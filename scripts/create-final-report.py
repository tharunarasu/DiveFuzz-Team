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
                 f"{run['generation']['seconds']:.1f}", f"{run['rtl_seconds']:.1f}"])
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
('Motivation and Background', 'Processor verification must explore a vast space of instructions, operands, execution histories, and architectural states. The DiveFuzz paper identifies repeated write-back values and uneven opcode selection as limitations of existing CPU fuzzers [1]. It constructs instruction sequences using runtime state to increase behavioral diversity. RISC-V defines the architectural behavior expected from a CPU [2]. Differential testing compares the CPU implementation with a reference model, and a mismatch requires investigation before it can be classified as a defect.'),
('Methodology', 'We used the pinned NutShell in-order implementation and its differential test harness. The adapted Spike engine validated generation. The generated binary images then executed in the Verilator RTL emulator with NEMU as the differential reference. Two conditions kept runtime validation and known-bug filtering enabled. The enabled condition rejected duplicate signatures. The disabled condition allowed duplicate signatures. Paired repetitions used RNG seeds 1001, 2001, and 3001, a fresh cache per run, one worker, and the same workload size.'),
('Recommendation: Overall Architecture', 'The following architecture shows the implemented generation, compilation, and differential execution workflow. The duplicate filter setting is the independent variable. Both conditions use Spike validation and the same target configuration.'),
('Implementation Details', 'Hardware: 12th Gen Intel Core i7-12700H, 14 physical cores and 20 logical processors, approximately 23.6 GiB installed RAM. Ubuntu WSL reported approximately 11 GiB available memory and 3 GiB swap. Software: Ubuntu 24.04.4 LTS under WSL2, Python 3.12.3, RISC-V GCC 13.2.0, GNU assembler 2.42, Java 17.0.21.1, Mill 0.11.2, Chisel 3.6.0, and Verilator 5.052. The primary implementation languages are Python, Scala/Chisel, C++, and generated Verilog. Sources, tools, caches, build outputs, and results were stored on F:. NutShell was pinned to commit 63a2687089ec374e6bd19d85ec040caab297dbff.'),
('Workload and Metrics', 'The comparison used the NutShell RV64IMC profile with CSR generation, ecall, ebreak, and generated jumps excluded. The initialization template still uses privileged setup instructions. Unique write-back pairs count distinct observed opcode and destination-value pairs from accepted Spike debug events. Coverage is the union of Verilator coverage points hit by the 20 seeds in a run within the NutCore hierarchy, excluding differential wrappers. Generation and RTL times are process wall times; generation includes startup and debug output.'),
('Full Results', f'Across six runs, {passes} of 120 generated seeds reached a good trap while checked against NEMU. Each run generated and compiled 20 of 20 requested seeds, with 100 accepted workload instructions per seed and 2,000 per run. Mean generation time was {time_on:.1f} seconds with filtering enabled and {time_off:.1f} seconds disabled. Each run covered 606 of 702 line points. Mean toggle coverage was {toggle_on:.2f}% enabled and {toggle_off:.2f}% disabled, out of 213,316 toggle points. A later audit found that the parser omitted addiw destination values in these original logs. The unique-pair counts below are therefore counts from an incomplete logged subset and may be biased. The Figure 6 experiment below uses the corrected parser.'),
('Insights', f'The earlier run logged an average of {av_on:.1f} distinct observed write-back pairs with duplicate filtering enabled and {av_off:.1f} with it disabled, a ratio of {av_on/av_off:.2f} for the recorded subset. The addiw logging omission affects comparability, so this ratio must not be treated as a reliable estimate for all write-backs. All six runs reached the same line coverage, and the enabled condition took longer to generate the fixed-size corpus. These measurements cannot establish the paper’s reported coverage-speed advantages: our experiment uses one CPU, a restricted workload, an ablation baseline, and different metrics and budgets. Initialization activity, short runs, and different reference models may also affect coverage.'),
('Exception triage', 'A separate ebreak test completed successfully under Spike and under NutShell without differential testing, while the bundled NEMU comparison reported a different exception cause. A read-only counter-write test passed all three checks. A directed odd pmpcfg CSR test passed on Spike and failed on NutShell alone and in the NEMU differential run. These are reproducible configuration-specific discrepancies requiring upstream and specification review before classifying any as new hardware defects.'),
('Discussion', 'Original paper: its reported evaluation covers four open-source RISC-V CPUs and the authors’ selected baselines, coverage metrics, and experimental conditions. Generalization to other architectures and post-silicon behavior requires additional study. The authors measured control-register, mux, line, ready/valid and toggle coverage on Rocket, whereas our coverage results use NutShell. Student implementation: the comparison covers one CPU revision, one host, and a small restricted workload. Compressed control-flow generation, CSR fuzzing, and full paper baselines were excluded from the main comparison. Matching RNG seeds do not produce identical instruction streams once filtering causes different retries. Coverage includes reset and initialization activity. We did not measure time to a common coverage threshold or confirm any new bug.'),
('Conclusion', f'We reproduced a scoped part of DiveFuzz on the NutShell RTL model. All {passes} generated test programs passed differential execution under the selected workload. The original coverage runs reached the same measured line coverage and filtering incurred more generation time. Their write-back diversity counts have the logging limitation described above. Two directed discrepancies remain candidates for investigation rather than confirmed new CPU bugs.'),
('References', '[1] Guo et al., [DiveFuzz: Enhancing CPU Fuzzing via Diverse Instruction Construction](https://doi.org/10.1145/3719027.3765167), ACM CCS 2025, pp. 1964–1978.\n\n[2] [RISC-V ISA Manual](https://github.com/riscv/riscv-isa-manual).\n\n[3] [Spike RISC-V ISA simulator](https://github.com/riscv-software-src/riscv-isa-sim).\n\n[4] [DiveFuzz team reproduction repository](https://github.com/tharunarasu/DiveFuzz-Team).'),
('Appendix: Code, Data, and Reproduction', f'Full command lines, per-seed logs, and machine-readable results are in [{campaign.relative_to(root)}]({campaign.relative_to(root)}/results.json). The [per-run CSV]({campaign.relative_to(root)}/runs.csv) includes generation and RTL execution times, accepted instructions, opcode counts, write-back events, and repeated values. [Directed exception tests](evidence/final/triage/20261119-190729/results.json) contain the Spike, standalone RTL, and NEMU differential results. Run `scripts/run-final-campaign-f.sh` from WSL as described in [SETUP.md](SETUP.md). Raw coverage files remain on F: and are omitted from Git.'),
]
headers = ['Run', 'Filter', 'Pass', 'Unique pairs', 'Line', 'Toggle', 'Gen. sec', 'RTL sec']
md = ['# DiveFuzz phase-two final report', '', '**Team FuzzForge**  ',
      'Tharun Arasu Sivakumar, Deepthi Tirumala, Felicia Jeyaseelan', '']
for title, paragraph in body:
    md += ['## ' + title, '', paragraph, '']
    if title == 'Recommendation: Overall Architecture':
        md += ['```mermaid', 'flowchart LR', '  A[Seed and workload configuration] --> B[Generate candidate instruction]',
               '  B --> C[Adapted Spike runtime validation]', '  C --> D{Duplicate filter}',
               '  D -->|enabled or disabled| E[Assembly seeds]', '  E --> F[RISC-V assembler and linker]',
               '  F --> G[NutShell RTL emulator]', '  G <--> H[NEMU differential reference]',
               '  G --> I[Coverage, outcomes, and logs]', '```', '']
    if title == 'Full Results':
        md += ['| ' + ' | '.join(headers) + ' |', '| ' + ' | '.join(['---']*len(headers)) + ' |']
        md += ['| ' + ' | '.join(row) + ' |' for row in rows]
        md += ['']
(root / 'FINAL_REPORT.md').write_text('\n'.join(md), encoding='utf-8')
print('Created FINAL_REPORT.md')
