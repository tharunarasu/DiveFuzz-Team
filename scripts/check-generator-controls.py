"""Integration checks for reproducible, validation-preserving ablation controls."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import time

root = Path(__file__).resolve().parents[1]
out = root / 'evidence/final/preflight' / time.strftime('%Y%m%d-%H%M%S')
out.mkdir(parents=True)
results = []
for name, allow_duplicates in [('enabled-a', False), ('enabled-b', False), ('disabled', True)]:
    dest = out / name
    cmd = [sys.executable, '-m', 'generator.main', '--generate', '--eliminate',
           '--architecture', 'nutshell', '--allowed-ext-name', 'nutshell',
           '--template-type', 'nutshell', '--random-seed', '501', '--max-workers', '1',
           '--seeds', '2', '--instr-number', '20', '--no-jump', '--debug',
           '--debug-mode', 'SUMMARY', '--out-dir', str(dest)]
    if allow_duplicates:
        cmd.append('--allow-duplicates')
    p = subprocess.run(cmd, cwd=root / 'fuzzer', text=True, stdout=subprocess.PIPE,
                       stderr=subprocess.STDOUT, timeout=120)
    (out / (name + '.log')).write_text(p.stdout)
    hashes = {f.name: hashlib.sha256(f.read_bytes()).hexdigest() for f in dest.glob('*.S')}
    counts = {f.name: f.read_text().count('[ACCEPTED]') for f in dest.glob('spike_debug_seed_*.log')}
    result = dict(name=name, command=cmd, returncode=p.returncode, hashes=hashes, accepted=counts)
    results.append(result)
    print(json.dumps(result), flush=True)
    assert p.returncode == 0 and len(hashes) == 2 and sorted(counts.values()) == [20, 20], p.stdout
assert results[0]['hashes'] == results[1]['hashes'], 'RNG reproducibility check failed'
(out / 'checks.json').write_text(json.dumps(dict(passed=True, results=results), indent=2))
print('PASS: repeatable seeded generation and runtime validation in both ablation conditions')
