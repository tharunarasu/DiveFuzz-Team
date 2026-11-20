"""Summarize a scoped Figure 6-style opcode-weighted repetition experiment."""
from collections import Counter
import csv
import json
from pathlib import Path
import re
from statistics import mean
import sys

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

root = Path(__file__).resolve().parents[1]
campaign = (root / sys.argv[1]).resolve()
if not campaign.is_relative_to(root / 'evidence/final'):
    raise ValueError('Campaign must be inside evidence/final')
data = json.loads((campaign / 'results.json').read_text())
assert len(data['runs']) == 6
out = root / 'evidence/final/paper-figure6'
out.mkdir(parents=True, exist_ok=True)
events_re = re.compile(r'(?ms)^\[#\d+\] \[ACCEPTED\] ([^\n]+)\n(.*?)(?=^\[#\d+\]|\Z)')
results = []
for run in data['runs']:
    corpus = campaign / f"run-{run['repeat']}-{run['mode']}" / 'corpus'
    files = sorted(corpus.glob('spike_debug_seed_*.log'),
                   key=lambda p: int(re.search(r'(\d+)\.log$', p.name).group(1)))
    seen = set()
    events = writes = 0
    op_counts = Counter()
    missing_addiw = 0
    timeline = []
    for file in files:
        for event in events_re.finditer(file.read_text()):
            events += 1
            opcode = event[1].split()[0]
            op_counts[opcode] += 1
            dest = re.search(r'Dest:\s*\[([^\]]*)\]', event[2])
            if opcode == 'addiw' and event[1].split()[1].rstrip(',') not in ('zero', 'x0') and dest is None:
                missing_addiw += 1
            if dest:
                for reg, value in re.findall(r'r(\d+)=(0x[0-9a-fA-F]+)', dest[1]):
                    if int(reg) != 0:
                        writes += 1
                        seen.add((opcode, int(value, 16)))
            if events % 100 == 0:
                timeline.append({'accepted_instructions': events, 'logged_writebacks': writes,
                                 'unique_opcode_value_pairs': len(seen),
                                 'repetition_percent': 100 * (1-len(seen)/writes) if writes else None})
    assert events == 500 and missing_addiw == 0, (run['mode'], events, missing_addiw)
    results.append({'repeat': run['repeat'], 'mode': run['mode'], 'rng_seed': run['rng_seed'],
                    'generated': run['generated_sources'], 'passed': run['passed_seeds'],
                    'accepted_instructions': events, 'logged_writebacks': writes,
                    'unique_opcode_value_pairs': len(seen),
                    'repetition_percent': 100 * (1-len(seen)/writes),
                    'addiw_events': op_counts['addiw'], 'timeline': timeline})
averages = {mode: mean(r['repetition_percent'] for r in results if r['mode'] == mode)
            for mode in ['enabled', 'disabled']}
summary = {'paper': {'figure': 6, 'page': 8, 'reported_divefuzz_repetition_percent_approx': 55,
                     'paper_instruction_scale': 'up to 2,000,000',
                     'baseline': 'DifuzzRTL and Cascade'},
           'our_campaign': str(campaign.relative_to(root)), 'runs': results,
           'mean_repetition_percent': averages,
           'formula': '100 * (1 - distinct (opcode, value) pairs / logged non-x0 integer-register writebacks)',
           'comparison': 'Scoped Figure 6-inspired analysis. CPU, workload, baselines, scale, and writeback-event coverage differ; not an exact reproduction.'}
(out / 'summary.json').write_text(json.dumps(summary, indent=2))
with (out / 'results.csv').open('w', newline='') as stream:
    columns = ['repeat', 'mode', 'rng_seed', 'generated', 'passed', 'accepted_instructions',
               'logged_writebacks', 'unique_opcode_value_pairs', 'repetition_percent', 'addiw_events']
    writer = csv.DictWriter(stream, fieldnames=columns, extrasaction='ignore')
    writer.writeheader()
    writer.writerows(results)
fig, ax = plt.subplots(figsize=(8, 4.8))
for mode, color, label in [('enabled', '#126b65', 'Duplicate filter enabled'),
                           ('disabled', '#c75b28', 'Duplicate filter disabled')]:
    runs = [r for r in results if r['mode'] == mode]
    x = [p['accepted_instructions'] for p in runs[0]['timeline']]
    y = [mean(r['timeline'][i]['repetition_percent'] for r in runs) for i in range(len(x))]
    ax.plot(x, y, marker='o', color=color, label=label)
    ax.fill_between(x, [min(r['timeline'][i]['repetition_percent'] for r in runs) for i in range(len(x))],
                    [max(r['timeline'][i]['repetition_percent'] for r in runs) for i in range(len(x))],
                    color=color, alpha=.12)
ax.set(xlabel='Accepted generated instructions per run', ylabel='Logged write-back repetition (%)',
       title='Scoped replication of the Figure 6 repetition metric', ylim=(0, 100))
ax.grid(axis='y', alpha=.25)
ax.legend(loc='lower right')
fig.text(.5, .005, 'Three runs per condition; shading shows run range. Integer register write-backs only.',
         ha='center', fontsize=8)
fig.tight_layout(rect=(0,.04,1,1))
fig.savefig(out / 'figure6-scoped-comparison.png', dpi=180)
plt.close(fig)
print(json.dumps(summary, indent=2))
