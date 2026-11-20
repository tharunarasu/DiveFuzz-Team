"""Small controlled RTL campaign; all claims backed by per-command logs and JSON."""
import argparse
from collections import Counter
import csv
import hashlib
import json
import os
from pathlib import Path
import re
import signal
import subprocess
import sys
import time

ROOT = Path(__file__).resolve().parents[1]
ANSI = re.compile(r'\x1b\[[0-9;]*[A-Za-z]')

def command(cmd, log, cwd=ROOT, timeout=180, env=None):
    start = time.perf_counter()
    with log.open('w') as stream:
        p = subprocess.Popen(cmd, cwd=cwd, env=env, stdout=stream,
                             stderr=subprocess.STDOUT, start_new_session=True)
        try:
            rc = p.wait(timeout=timeout)
        except subprocess.TimeoutExpired:
            os.killpg(p.pid, signal.SIGKILL)
            p.wait()
            rc = 124
    return dict(command=[str(x) for x in cmd], returncode=rc,
                seconds=round(time.perf_counter()-start, 4), log=str(log.relative_to(ROOT)))

def write_json(path, data):
    path.write_text(json.dumps(data, indent=2))

def reference_metrics(directory):
    opcodes, pairs = Counter(), Counter()
    accepted = 0
    per_seed = {}
    for path in sorted(directory.glob('spike_debug_seed_*.log')):
        events = list(re.finditer(r'(?ms)^\[#\d+\] \[ACCEPTED\] ([^\n]+)\n(.*?)(?=^\[#\d+\]|\Z)', path.read_text()))
        per_seed[path.name] = len(events)
        for event in events:
            accepted += 1
            opcode = event[1].split()[0]
            opcodes[opcode] += 1
            dest = re.search(r'Dest:\s*\[([^\]]*)\]', event[2])
            if dest:
                for reg, value in re.findall(r'r(\d+)=(0x[0-9a-fA-F]+)', dest[1]):
                    if int(reg) != 0:
                        pairs[(opcode, int(value, 16))] += 1
    return dict(accepted=accepted, per_seed=per_seed, opcodes=dict(opcodes),
                unique_opcodes=len(opcodes), unique_writeback_pairs=len(pairs),
                writeback_events=sum(pairs.values()),
                repeated_writeback_events=sum(pairs.values())-len(pairs))

def coverage_points(paths):
    points = {}
    for path in paths:
        for line in path.read_text(errors='replace').splitlines():
            if not line.startswith("C '"):
                continue
            key, count = line[3:].rsplit("' ", 1)
            points[key] = points.get(key, 0) + int(count)
    kinds = {}
    for key, hits in points.items():
        fields = dict(part.split('\x02', 1) for part in key.split('\x01') if '\x02' in part)
        kind = fields.get('page', fields.get('type', 'unknown'))
        for name in [kind, 'all/' + kind.split('/')[0]]:
            item = kinds.setdefault(name, dict(total=0, covered=0))
            item['total'] += 1
            item['covered'] += hits > 0
        if fields.get('h', '').startswith('TOP.SimTop.soc.nutcore') and not any(
                label in kind for label in ['DPICWrapper', 'DiffWrapper']):
            item = kinds.setdefault('core/' + kind.split('/')[0], dict(total=0, covered=0))
            item['total'] += 1
            item['covered'] += hits > 0
    for item in kinds.values():
        item['percent'] = round(100*item['covered']/item['total'], 4) if item['total'] else None
    return kinds

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--seeds', type=int, default=20)
    parser.add_argument('--instructions', type=int, default=100)
    parser.add_argument('--repeats', type=int, default=3)
    parser.add_argument('--pilot', action='store_true')
    parser.add_argument('--include-csr', action='store_true',
                        help='Explore CSR exception cases in addition to the integer/memory benchmark')
    args = parser.parse_args()
    emulator = ROOT / 'dut/NutShell/build/emu'
    reference = ROOT / 'dut/NutShell/ready-to-run/riscv64-nemu-interpreter-so'
    assert emulator.exists(), 'Build the RTL emulator first'
    dest = ROOT / 'evidence/final' / (('pilot-' if args.pilot else 'campaign-') + time.strftime('%Y%m%d-%H%M%S'))
    dest.mkdir(parents=True)
    results = dict(parameters=vars(args), rtl_reference='bundled NEMU',
                   generation_reference='adapted Spike', runs=[])
    for repeat in range(args.repeats):
        modes = ['enabled', 'disabled'] if repeat % 2 == 0 else ['disabled', 'enabled']
        for mode in modes:
            work = dest / f'run-{repeat+1}-{mode}'
            work.mkdir()
            corpus = work / 'corpus'
            cmd = [sys.executable, '-m', 'generator.main', '--generate', '--eliminate',
                   '--architecture', 'nutshell', '--allowed-ext-name', 'nutshell',
                   '--template-type', 'nutshell', '--random-seed', str(1001+1000*repeat),
                   '--max-workers', '1', '--seeds', str(args.seeds),
                   '--instr-number', str(args.instructions), '--no-jump', '--debug',
                   '--debug-mode', 'SUMMARY', '--out-dir', str(corpus)]
            if mode == 'disabled':
                cmd.append('--allow-duplicates')
            if not args.include_csr:
                cmd.extend(['--exclude-ext', 'RV_ZICSR'])
                cmd.extend(['--exclude-opcodes', 'ecall', 'ebreak'])
            generation = command(cmd, work / 'generation.log', ROOT / 'fuzzer', timeout=600)
            metrics = reference_metrics(corpus)
            run = dict(repeat=repeat+1, mode=mode, rng_seed=1001+1000*repeat,
                       generation=generation, reference_metrics=metrics, seeds=[])
            results['runs'].append(run)
            sources = sorted(corpus.glob('*.S'))
            run['generated_sources'] = len(sources)
            assert generation['returncode'] == 0 and len(sources) == args.seeds, str(work)
            assert sorted(metrics['per_seed'].values()) == [args.instructions]*args.seeds, str(work)
            isa = next(x[4:] for x in (corpus / '.isa_info').read_text().splitlines() if x.startswith('ISA='))
            coverage_files = []
            for idx, source in enumerate(sources):
                runtime = work / source.stem
                (runtime / 'build').mkdir(parents=True)
                obj, elf, img = [source.with_suffix(ext) for ext in ['.o', '.elf', '.img']]
                commands = [
                    ['riscv64-unknown-elf-as', '-march='+isa, str(source), '-o', str(obj)],
                    ['riscv64-unknown-elf-ld', '-T', str(ROOT / 'fuzzer/generator/reg_analyzer/linker/link.ld'), str(obj), '-o', str(elf)],
                    ['riscv64-unknown-elf-objcopy', '-O', 'binary', str(elf), str(img)]]
                seed = dict(name=source.name, source_sha256=hashlib.sha256(source.read_bytes()).hexdigest(), compilation=[])
                run['seeds'].append(seed)
                for number, compile_cmd in enumerate(commands):
                    check = command(compile_cmd, runtime / f'compile-{number}.log')
                    seed['compilation'].append(check)
                    if check['returncode']:
                        break
                seed['compiled'] = len(seed['compilation']) == 3 and all(x['returncode'] == 0 for x in seed['compilation'])
                if seed['compiled']:
                    env = dict(os.environ, NOOP_HOME=str(runtime))
                    seed['rtl'] = command([str(emulator), '-i', str(img), '--diff', str(reference),
                                           '-C', '200000', '-b', '0', '-e', '0', '--dump-coverage'], runtime / 'rtl.log', timeout=60, env=env)
                    output = ANSI.sub('', (runtime / 'rtl.log').read_text(errors='replace'))
                    seed['passed'] = seed['rtl']['returncode'] == 0 and 'HIT GOOD TRAP' in output
                    match = re.search(r'instrCnt = ([\d,]+), cycleCnt = ([\d,]+)', output)
                    if match:
                        seed['retired_instructions'], seed['cycles'] = [int(x.replace(',', '')) for x in match.groups()]
                    files = list((runtime / 'build').glob('*.coverage.dat'))
                    coverage_files.extend(files)
                    seed['coverage_files'] = [str(p.relative_to(ROOT)) for p in files]
                else:
                    seed['passed'] = False
                write_json(dest / 'results.json', results)
                print(f"run {repeat+1} {mode}: seed {idx+1}/{args.seeds}, compiled={seed['compiled']}, passed={seed['passed']}", flush=True)
            run['coverage'] = coverage_points(coverage_files)
            run['compiled_seeds'] = sum(s['compiled'] for s in run['seeds'])
            run['passed_seeds'] = sum(s['passed'] for s in run['seeds'])
            run['rtl_seconds'] = sum(s.get('rtl', {}).get('seconds', 0) for s in run['seeds'])
            write_json(dest / 'results.json', results)
    with (dest / 'runs.csv').open('w', newline='') as stream:
        columns = ['repeat', 'mode', 'rng_seed', 'generated_sources', 'compiled_seeds', 'passed_seeds',
                   'generation_seconds', 'rtl_seconds', 'accepted', 'unique_opcodes',
                   'unique_writeback_pairs', 'writeback_events', 'repeated_writeback_events']
        writer = csv.DictWriter(stream, fieldnames=columns)
        writer.writeheader()
        for run in results['runs']:
            row = {key: run[key] for key in columns if key in run}
            row.update(generation_seconds=run['generation']['seconds'])
            row.update({k: run['reference_metrics'][k] for k in columns if k in run['reference_metrics']})
            writer.writerow(row)
    if not args.pilot:
        (ROOT / 'evidence/final/latest-campaign.txt').write_text(str(dest.relative_to(ROOT)))
    results['all_passed'] = all(s['passed'] for run in results['runs'] for s in run['seeds'])
    write_json(dest / 'results.json', results)
    print('RESULTS:', dest, flush=True)
    return 0 if results['all_passed'] else 1

if __name__ == '__main__':
    sys.exit(main())
