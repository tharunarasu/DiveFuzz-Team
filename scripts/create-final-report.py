"""Create the phase-two report from completed experiment evidence."""
import json
from pathlib import Path
from statistics import mean

root = Path(__file__).resolve().parents[1]
campaign = root / (root / 'evidence/final/latest-campaign.txt').read_text().strip()
data = json.loads((campaign / 'results.json').read_text())
assert len(data['runs']) == 6 and all(len(r['seeds']) == 20 for r in data['runs'])
rows = []
for run in sorted(data['runs'], key=lambda r: (r['repeat'], r['mode'])):
    metrics = run['reference_metrics']
    coverage = run['coverage']
    rows.append([str(run['repeat']), run['mode'], f"{run['passed_seeds']}/20",
                 str(metrics['unique_writeback_pairs']),
                 f"{coverage['core/v_line']['percent']:.2f}%",
                 f"{coverage['core/v_toggle']['percent']:.2f}%",
                 f"{run['generation']['seconds']:.1f}"])
enabled = [r for r in data['runs'] if r['mode'] == 'enabled']
disabled = [r for r in data['runs'] if r['mode'] == 'disabled']
av_on = mean(r['reference_metrics']['unique_writeback_pairs'] for r in enabled)
av_off = mean(r['reference_metrics']['unique_writeback_pairs'] for r in disabled)
time_on = mean(r['generation']['seconds'] for r in enabled)
time_off = mean(r['generation']['seconds'] for r in disabled)
toggle_on = mean(r['coverage']['core/v_toggle']['percent'] for r in enabled)
toggle_off = mean(r['coverage']['core/v_toggle']['percent'] for r in disabled)
passes = sum(r['passed_seeds'] for r in data['runs'])
body = [
('Final phase results', f'The NutShell in-order RTL design was built with Verilator line and toggle coverage. Across six runs, {passes} of 120 generated seeds reached a good trap while checked against the bundled NEMU reference. Each seed requested 100 workload instructions. Each condition was repeated three times with 20 seeds and one worker.'),
('Motivation and background', 'DiveFuzz investigates repetitive write-back outcomes and uneven opcode selection in CPU fuzzing. It uses runtime instruction construction and reference execution to explore architectural states. RISC-V architectural state includes registers, program counter, memory, and control/status registers. Differential testing compares a processor implementation against a reference and requires investigation of mismatches.'),
('Methodology', 'We used the pinned NutShell in-order implementation and its differential test harness. The adapted Spike engine validated generation. The generated binary images then executed in the Verilator RTL emulator with NEMU as the differential reference. Two conditions kept runtime validation and known-bug filtering enabled. The enabled condition rejected duplicate signatures. The disabled condition allowed duplicate signatures. Paired repetitions used RNG seeds 1001, 2001, and 3001, a fresh cache per run, one worker, and the same workload size.'),
('Workload and metrics', 'The comparison used the NutShell RV64IMC profile with CSR generation, ecall, ebreak, and generated jumps excluded. The initialization template still uses privileged setup instructions. Unique write-back pairs count distinct observed opcode and destination-value pairs from accepted Spike debug events. Coverage is the union of Verilator coverage points hit by the 20 seeds in a run within the NutCore hierarchy, excluding differential wrappers. Generation time is process wall time including startup and debug output. RTL execution time is recorded separately in the results file.'),
('Measured comparison', f'The average number of distinct observed write-back pairs was {av_on:.1f} with duplicate filtering enabled and {av_off:.1f} with it disabled. The ratio of those averages was {av_on/av_off:.2f} times. Mean generation time was {time_on:.1f} seconds enabled and {time_off:.1f} seconds disabled. Each run covered 606 of 702 line points. Mean toggle coverage was {toggle_on:.2f}% enabled and {toggle_off:.2f}% disabled, out of 213,316 toggle points. Each repetition uses 2,000 accepted workload instructions, so this comparison has a common requested instruction count. The three repetitions are a small local experiment and are not the paper’s coverage-speedup benchmark.'),
('Exception triage', 'A separate ebreak test completed successfully under Spike and under NutShell without differential testing, while the bundled NEMU comparison reported a different exception cause. A read-only counter-write test passed all three checks. A directed odd pmpcfg CSR test passed on Spike and failed on NutShell alone and in the NEMU differential run. These are reproducible configuration-specific discrepancies requiring upstream and specification review before classifying any as new hardware defects.'),
('Limitations', 'The comparison covers one CPU revision, one host, a short fixed-size corpus, and a restricted integer/memory workload. Compressed control-flow generation, CSR fuzzing, and full paper baselines were excluded from the main comparison. Matching RNG seeds do not produce identical instruction streams across conditions once filtering causes different retries. Coverage includes reset and initialization activity. There is no measured time-to-coverage comparison, baseline-fuzzer reproduction, or confirmed new bug. The original paper reports its own multi-CPU results and speedups under its experimental conditions.'),
('Reproduction and evidence', f'The full command lines, per-seed logs, coverage files, and machine-readable results are stored under {campaign.relative_to(root)}. Run scripts/run-final-campaign-f.sh from WSL to repeat the experiment. Raw coverage files are retained locally and omitted from Git. The previous PDF is the phase-one report. The phase-two findings are based on the local run and the directed triage logs under evidence/final/triage.'),
('References', '[Guo et al., DiveFuzz: Enhancing CPU Fuzzing via Diverse Instruction Construction, ACM CCS 2025](https://doi.org/10.1145/3719027.3765167). [RISC-V ISA Manual](https://github.com/riscv/riscv-isa-manual). [Spike simulator](https://github.com/riscv-software-src/riscv-isa-sim). [Team artifact](https://github.com/tharunarasu/DiveFuzz-Team).'),
]
headers = ['Run', 'Filter', 'Pass', 'Unique pairs', 'Line', 'Toggle', 'Gen. sec']
md = ['# DiveFuzz phase-two final report', '', '**Team FuzzForge**  ',
      'Tharun Arasu Sivakumar, Deepthi Tirumala, Felicia Jeyaseelan', '']
for title, paragraph in body:
    md += ['## ' + title, '', paragraph, '']
    if title == 'Measured comparison':
        md += ['| ' + ' | '.join(headers) + ' |', '| ' + ' | '.join(['---']*len(headers)) + ' |']
        md += ['| ' + ' | '.join(row) + ' |' for row in rows]
        md += ['']
(root / 'FINAL_REPORT.md').write_text('\n'.join(md), encoding='utf-8')
print('Created FINAL_REPORT.md')
