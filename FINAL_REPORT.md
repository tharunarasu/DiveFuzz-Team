# DiveFuzz phase-two final report

**Team FuzzForge**  
Tharun Arasu Sivakumar, Deepthi Tirumala, Felicia Jeyaseelan

## Final phase results

The NutShell in-order RTL design was built with Verilator line and toggle coverage. Across six runs, 120 of 120 generated seeds reached a good trap while checked against the bundled NEMU reference. Each seed requested 100 workload instructions. Each condition was repeated three times with 20 seeds and one worker.

## Motivation and background

DiveFuzz investigates repetitive write-back outcomes and uneven opcode selection in CPU fuzzing. It uses runtime instruction construction and reference execution to explore architectural states. RISC-V architectural state includes registers, program counter, memory, and control/status registers. Differential testing compares a processor implementation against a reference and requires investigation of mismatches.

## Methodology

We used the pinned NutShell in-order implementation and its differential test harness. The adapted Spike engine validated generation. The generated binary images then executed in the Verilator RTL emulator with NEMU as the differential reference. Two conditions kept runtime validation and known-bug filtering enabled. The enabled condition rejected duplicate signatures. The disabled condition allowed duplicate signatures. Paired repetitions used RNG seeds 1001, 2001, and 3001, a fresh cache per run, one worker, and the same workload size.

## Workload and metrics

The comparison used the NutShell RV64IMC profile with CSR generation, ecall, ebreak, and generated jumps excluded. The initialization template still uses privileged setup instructions. Unique write-back pairs count distinct observed opcode and destination-value pairs from accepted Spike debug events. Coverage is the union of Verilator coverage points hit by the 20 seeds in a run within the NutCore hierarchy, excluding differential wrappers. Generation time is process wall time including startup and debug output. RTL execution time is recorded separately in the results file.

## Measured comparison

The average number of distinct observed write-back pairs was 947.3 with duplicate filtering enabled and 449.0 with it disabled. The ratio of those averages was 2.11 times. Mean generation time was 413.3 seconds enabled and 34.2 seconds disabled. Each run covered 606 of 702 line points. Mean toggle coverage was 71.34% enabled and 71.03% disabled, out of 213,316 toggle points. Each repetition uses 2,000 accepted workload instructions, so this comparison has a common requested instruction count. The three repetitions are a small local experiment and are not the paper’s coverage-speedup benchmark.

| Run | Filter | Pass | Unique pairs | Line | Toggle | Gen. sec |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | disabled | 20/20 | 443 | 86.32% | 71.10% | 34.1 |
| 1 | enabled | 20/20 | 977 | 86.32% | 70.90% | 434.8 |
| 2 | disabled | 20/20 | 486 | 86.32% | 70.94% | 27.5 |
| 2 | enabled | 20/20 | 941 | 86.32% | 71.01% | 299.4 |
| 3 | disabled | 20/20 | 418 | 86.32% | 71.05% | 41.1 |
| 3 | enabled | 20/20 | 924 | 86.32% | 72.10% | 505.6 |

## Exception triage

A separate ebreak test completed successfully under Spike and under NutShell without differential testing, while the bundled NEMU comparison reported a different exception cause. A read-only counter-write test passed all three checks. A directed odd pmpcfg CSR test passed on Spike and failed on NutShell alone and in the NEMU differential run. These are reproducible configuration-specific discrepancies requiring upstream and specification review before classifying any as new hardware defects.

## Limitations

The comparison covers one CPU revision, one host, a short fixed-size corpus, and a restricted integer/memory workload. Compressed control-flow generation, CSR fuzzing, and full paper baselines were excluded from the main comparison. Matching RNG seeds do not produce identical instruction streams across conditions once filtering causes different retries. Coverage includes reset and initialization activity. There is no measured time-to-coverage comparison, baseline-fuzzer reproduction, or confirmed new bug. The original paper reports its own multi-CPU results and speedups under its experimental conditions.

## Reproduction and evidence

The full command lines, per-seed logs, coverage files, and machine-readable results are stored under evidence/final/campaign-20261119-184525. Run scripts/run-final-campaign-f.sh from WSL to repeat the experiment. Raw coverage files are retained locally and omitted from Git. The previous PDF is the phase-one report. The phase-two findings are based on the local run and the directed triage logs under evidence/final/triage.

## References

[Guo et al., DiveFuzz: Enhancing CPU Fuzzing via Diverse Instruction Construction, ACM CCS 2025](https://doi.org/10.1145/3719027.3765167). [RISC-V ISA Manual](https://github.com/riscv/riscv-isa-manual). [Spike simulator](https://github.com/riscv-software-src/riscv-isa-sim). [Team artifact](https://github.com/tharunarasu/DiveFuzz-Team).
