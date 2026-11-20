"""Directed three-way checks: Spike, NutShell alone, and NutShell versus NEMU."""
import json
import os
from pathlib import Path
import sys
import time
import importlib.util

spec = importlib.util.spec_from_file_location('campaign', Path(__file__).with_name('run-final-campaign.py'))
campaign = importlib.util.module_from_spec(spec)
spec.loader.exec_module(campaign)
command = campaign.command

root = Path(__file__).resolve().parents[1]
dest = root / 'evidence/final/triage' / time.strftime('%Y%m%d-%H%M%S')
dest.mkdir(parents=True)
cases = [('arithmetic', 'li t0, 40\naddi t0, t0, 2\nli t1, 42\nbne t0, t1, fail\nj success', None),
         ('ebreak', 'ebreak\nj fail', 3),
         ('readonly-counter', 'csrrw a1, hpmcounter31, a1\nj fail', 2),
         ('odd-pmpcfg', 'csrrsi a5, pmpcfg1, 0\nj fail', 2)]
results = []
for name, instruction, expected_cause in cases:
    work = dest / name
    (work / 'build').mkdir(parents=True)
    source = work / 'test.S'
    source.write_text(f'''.option norvc
.section .text
.globl _start
_start:
  la t0, handler
  csrw mtvec, t0
  {instruction}
.balign 4
handler:
  csrr t0, mcause
  li t1, {expected_cause or 0}
  bne t0, t1, fail
success:
  li t1, 1
  la t0, tohost
  sd t1, 0(t0)
  .word 0x0000006b
fail:
  li t1, 3
  la t0, tohost
  sd t1, 0(t0)
  li x1, 1
  .word 0x0000806b
.section .tohost,"aw",@progbits
.balign 64
.globl tohost
tohost: .dword 0
.balign 64
.globl fromhost
fromhost: .dword 0
''')
    obj, elf, img = [source.with_suffix(x) for x in ['.o', '.elf', '.img']]
    build = [
        ['riscv64-unknown-elf-as', '-march=rv64imc_zicsr_zifencei', str(source), '-o', str(obj)],
        ['riscv64-unknown-elf-ld', '-T', str(root / 'scripts/reference-sanity.ld'), str(obj), '-o', str(elf)],
        ['riscv64-unknown-elf-objcopy', '-O', 'binary', str(elf), str(img)]]
    for number, cmd in enumerate(build):
        result = command(cmd, work / f'compile-{number}.log')
        assert result['returncode'] == 0, result
    item = dict(name=name, expected_cause=expected_cause)
    item['spike'] = command([os.environ['spike'], '--isa=rv64imc_zicsr_zifencei', str(elf)], work / 'spike.log', timeout=20)
    emu = root / 'dut/NutShell/build/emu'
    base = [str(emu), '-i', str(img), '-C', '10000', '-b', '0', '-e', '0']
    env = dict(os.environ, NOOP_HOME=str(work))
    item['rtl_alone'] = command(base+['--no-diff'], work / 'rtl-alone.log', env=env, timeout=20)
    item['rtl_nemu'] = command(base+['--diff', str(root / 'dut/NutShell/ready-to-run/riscv64-nemu-interpreter-so')],
                               work / 'rtl-nemu.log', env=env, timeout=20)
    item['rtl_good_trap'] = 'HIT GOOD TRAP' in (work / 'rtl-alone.log').read_text()
    item['reference_disagreement'] = (item['spike']['returncode'] == 0 and item['rtl_alone']['returncode'] == 0
                                      and item['rtl_good_trap'] and item['rtl_nemu']['returncode'] != 0)
    results.append(item)
    (dest / 'results.json').write_text(json.dumps(results, indent=2))
    print(json.dumps(item), flush=True)
(root / 'evidence/final/latest-triage.txt').write_text(str(dest.relative_to(root)))
