# DiveFuzz Presentation Guide

This guide is for preparing the team presentation from the completed artifact-reproduction work.

## Recommended slide structure

### 1. Title and project goal

**DiveFuzz: Reproduction and RTL Evaluation**  
Include the team members, course, and ACM CCS 2025 paper citation.

State the goal in one sentence: evaluate whether diverse RISC-V instruction construction improves CPU-fuzzing exploration and whether the artifact runs correctly on a supported RTL CPU.

### 2. Motivation and paper claims

Explain that CPU fuzzers must explore many instruction combinations, operand values, and architectural states. DiveFuzz tries to reduce repeated write-back values and improve behavioral diversity.

Clearly label these as claims reported by the original paper:

- 26 new CPU bugs
- 15 CVE assignments
- 204x coverage speedup over a prior baseline

Do not present these paper values as results from our machine.

### 3. Our reproduction scope

Explain that our evaluation used one supported CPU configuration: the NutShell in-order RISC-V RTL model with its Verilator emulator and NEMU differential reference.

Mention that this is a scoped reproduction, not a full recreation of all four CPUs, all baselines, and the paper's historical bug revisions.

### 4. Overall architecture

Show this pipeline as a flow chart:

```text
DiveFuzz generator
        |
Adapted Spike validation
        |
Duplicate-signature filter
        |
RISC-V assembler and linker
        |
NutShell Verilator RTL
        |                 \
        |                  NEMU differential reference
        |
Coverage, timing, and discrepancy logs
```

The duplicate filter is the main comparison variable: enabled versus disabled.

### 5. Implementation environment

Include the actual setup:

- Intel Core i7-12700H, 14 physical cores, 20 logical processors
- Approximately 23.6 GiB host memory
- Ubuntu 24.04.4 under WSL2
- Python 3.12.3
- RISC-V GCC 13.2.0 and GNU assembler 2.42
- Verilator 5.052
- NutShell pinned to commit `63a2687`
- Project sources, caches, builds, and evidence stored on `F:`

### 6. Main campaign results

Present the results in a table or bar chart:

| Measurement | Result |
| --- | --- |
| Main generated programs | 120 |
| Differentially passing programs | 120/120 |
| Main runs | 6 |
| Line coverage | 606/702 = 86.32% in every run |
| Toggle coverage | Approximately 71% |

Emphasize that all selected workloads reached a good trap under NutShell/NEMU.

### 7. Instruction diversity and Figure 6-style result

Show the existing chart:

`evidence/final/paper-figure6/figure6-scoped-comparison.png`

Use these values:

- Duplicate filter enabled: 44.62% mean logged write-back repetition
- Duplicate filter disabled: 55.23% mean logged write-back repetition
- Paper DiveFuzz reference: approximately 55% repetition

Explain that our experiment used only 500 accepted instructions per run, so this is a scoped trend comparison rather than an exact reproduction of the paper's two-million-instruction experiment.

### 8. Time-to-coverage

Use the common 99% NutCore branch-coverage threshold: 6,065 of 6,126 points.

| Setting | Seeds to target | RTL time | End-to-end time |
| --- | ---: | ---: | ---: |
| Filtering enabled | 7.3 average | 27.26 s | 441.79 s |
| Filtering disabled | 7.0 average | 25.47 s | 60.85 s |

Explain that filtering increased generation time in this small experiment. The RTL-only times were similar; end-to-end time includes generation and compilation.

### 9. Bug detection and discrepancy triage

Present the local findings conservatively:

- 120 generated tests: 0 differential failures
- 0 confirmed new CPU bugs
- 4 directed tests: 2 passed completely
- `ebreak`: Spike and standalone NutShell agreed, but NEMU disagreed on the exception cause
- `odd-pmpcfg`: reproducible NutShell discrepancy candidate requiring specification and RTL review

The paper's 26 bugs were not re-detected because the original historical buggy CPU revisions and bug corpus were unavailable in this checkout.

### 10. Limitations and conclusion

Discuss the following limitations:

- One CPU revision instead of four CPUs
- Small workload and seed budget
- No full DifuzzRTL or Cascade baseline run
- Coverage includes boot and initialization activity
- No exact access to the paper's historical buggy revisions
- The two discrepancies are candidates, not confirmed bugs

Conclude that the artifact was successfully built, demonstrated, and evaluated; the scoped results were reproduced; and the remaining differences from the paper are documented rather than overstated.

## Presentation advice

- Use one main message per slide.
- Keep the paper's claims visually separate from our measured results.
- Prefer the existing chart and small tables over raw logs.
- Put detailed commands and file paths in speaker notes or the appendix.
- Do not show the 204x, 26-bug, or 15-CVE values without labeling them as paper-reported claims.
- Aim for 8–12 minutes and leave time for questions about limitations.

## Useful repository evidence

- [Final report](../FINAL_REPORT.md)
- [Phase-one report](../REPORT.md)
- [Time-to-coverage summary](../evidence/final/time-to-coverage/branch/summary.json)
- [Bug-detection summary](../evidence/final/bug-detection/summary.json)
- [Figure 6-style chart](../evidence/final/paper-figure6/figure6-scoped-comparison.png)
- [Original paper](../3719027.3765167.pdf)
