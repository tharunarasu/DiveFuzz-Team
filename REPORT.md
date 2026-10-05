# DiveFuzz: paper study and preliminary reproduction

**Course project checkpoint — four sections, 25 points each**  
**Paper:** Zihui Guo, Miaomiao Yuan, Yanqi Yang, Liwei Chen, Gang Shi, and Dan Meng, *DiveFuzz: Enhancing CPU Fuzzing via Diverse Instruction Construction*, ACM CCS 2025, pp. 1964–1978. [DOI](https://doi.org/10.1145/3719027.3765167).  
**Local artifact:** commit `13b028f8aaf16e4a0bb3476c2af9c866ab42353d`.  
**Scope:** paper study, source inspection, and an environment checkpoint. The current repository is actively developed; this checkout is not established as the exact artifact used for the paper.

## 1. Motivation of the original paper — 25 points

The authors identify repetitive instruction write-back values and uneven opcode selection in existing CPU fuzzers. DiveFuzz aims to diversify execution outcomes and instruction semantics so that testing reaches a broader range of CPU states. Its approach combines runtime operand construction, contextual semantics, and mutation that adjusts opcode distribution. [Paper abstract](https://doi.org/10.1145/3719027.3765167).

The practical importance can be understood through a simple example. An instruction sequence can contain many different `add` instructions, yet repeatedly calculate zero because its operands cancel. Counting distinct assembly strings would make the test corpus appear diverse, although the arithmetic outcomes are repetitive. Conversely, varying operands to produce carry, overflow, sign changes, or boundary values can exercise different internal decisions even when the opcode remains unchanged. This example explains the motivation; it is not a measured result from this reproduction.

CPU validation must also account for instruction interactions. A value produced by one instruction may become the address, operand, or control input of a later instruction. A generator that observes execution state can therefore construct useful dependencies rather than treating each instruction as an isolated random choice. The reproduction question is: **Can the artifact construct executable tests while preserving runtime diversity checks, and what remains before we can evaluate an RTL CPU?**

## 2. Background — 25 points

### RISC-V and architectural state

An instruction set architecture (ISA) defines the behavior software expects from a processor. RISC-V specifications describe unprivileged instructions and privileged behavior such as control/status registers and exception handling. The configured ISA must match the reference model, assembler, and target CPU. [Official specification repository](https://github.com/riscv/riscv-isa-manual).

Architectural state includes general-purpose registers, the program counter, memory, and relevant control/status registers. Write-back data refers to a result committed to a destination, commonly a register. Architectural correctness concerns these observable effects. Microarchitectural features such as pipeline scheduling and speculation affect how a CPU implements them.

### CPU fuzzing and differential testing

Fuzzing generates or mutates many test programs to expose behaviors that directed tests may miss. Differential testing executes a compatible program against a CPU under test and a reference model, then checks observable results. A discrepancy is a candidate defect requiring investigation: unsupported instructions, configuration mismatches, nondeterministic inputs, or a faulty reference can also produce discrepancies.

Spike is a functional RISC-V simulator. It is useful as an ISA-level reference, but matching its behavior does not establish matching cycle timing or identical microarchitecture. [Spike documentation](https://github.com/riscv-software-src/riscv-isa-sim).

### Components in this checkout

| Component | Role in the local artifact |
|---|---|
| `fuzzer/generator/main.py` | Standalone generation/mutation entry point |
| `generator/reg_analyzer/spike_session.py` | Reference execution, register queries, checkpoint rollback |
| `generator/reg_analyzer/stateful_xor_cache.py` | Context-aware duplicate signatures |
| `generator/reg_analyzer/riscv-opcodes` | Instruction encoding metadata submodule |
| `ref/riscv-isa-sim-adapter/spike_engine` | Native C++ implementation exposed to Python |
| `executor/divefuzz_adapter.py` | Connects seed generation to the DUT runner |
| `utils/elf_to_img.py` | Assembly-to-ELF and binary image conversion |
| `dut/` | Optional CPU implementation submodules |

These roles were inspected in the local source. Running the standalone generator is a useful initial checkpoint because it separates generation and compilation failures from the substantially larger RTL build.

## 3. Methodology, metrics, and threat model — 25 points

### Local execution workflow

The following describes this checkout, rather than asserting that every implementation detail appeared in the original paper:

1. Select a template, ISA extension profile, instruction count, seed count, and worker count.
2. Construct a template executable and initialize the adapted Spike session.
3. Generate a candidate instruction or sequence using the current context.
4. Execute candidates in the reference session, query operand/result state, and apply duplicate and validity checks.
5. Keep accepted state; roll back rejected candidates with checkpoints and retry.
6. Write assembly seeds. Assemble and link them into RISC-V ELF executables and convert them into binary images.
7. For a full CPU campaign, submit compatible images to a built DUT and investigate reproducible differential failures.

In the current source, `XORCache` stores signatures associated with opcodes using a shared Bloom filter. `StatefulXORCache` incorporates relevant context, including floating-point rounding, vector configuration, and atomic reservation state. Such signatures are a compact heuristic; they do not prove exhaustive state exploration. Bloom-filter false positives can reject genuinely new candidates. This is distinct from a false-positive *bug report*.

### Threat/verification model

For this checkpoint, the target is a functional correctness defect in a pre-silicon RISC-V implementation. The tester controls generated instruction streams and configured initial state. The reference model and toolchain are assumed to implement the selected ISA consistently. A full DUT experiment additionally requires an execution harness that compares compatible architectural effects.

This is an interpretation of the verification setup based on the artifact, not a claim that the paper specifies this exact adversary model. We have not demonstrated exploitation, privilege escalation, speculative leakage, multicore memory-order violations, or post-silicon behavior. A mismatch must first be reduced and replayed under matched configurations.

### Metrics

The abstract reports evaluation across five coverage metrics but does not name them. The full PDF could not be fetched in this session (ACM returned HTTP 403); exact metric definitions, aggregation details, campaign hardware, and table-level results require checking the full paper. The following are **proposed local evaluation metrics**, not a substitute for those five published metrics.

| Metric | Definition and interpretation |
|---|---|
| Setup success | Required tools found, dependency check passes, native engine imports |
| Valid seed rate | Successfully assembled/linked seeds divided by requested seeds |
| Generation throughput | Accepted generated instructions or valid seeds per wall-clock second; report which denominator is used |
| Execution completion | Seeds completing the selected reference/DUT test without a timeout or harness failure |
| Write-back diversity | Count distinct observed `(opcode, destination value)` pairs; also report repeats and context where relevant |
| Opcode distribution | Frequency of executed opcodes; optionally normalized entropy `H = -sum(p_i log(p_i))/log(K)` for `K > 1` supported opcodes |
| RTL coverage | Covered points divided by instrumented points, using the same coverage model and DUT build for every run |
| Time to coverage | Wall-clock time to reach a fixed common coverage threshold; report runs that never reach it as censored |
| Confirmed bug yield | Distinct reproducible, triaged root causes rather than raw mismatching seeds |

Generated opcode frequencies and executed opcode frequencies can differ because branches and exceptions change the path. Unique write-back pairs are a proxy for behavioral diversity, not equivalent to RTL coverage. A tiny smoke test cannot support statistically meaningful speedup or bug-yield claims.

### Follow-up experiment design

Once a DUT builds, compare diversity elimination enabled and disabled with the same ISA, template, CPU revision, worker count, and time budget. Use at least three independent runs, retain every corpus and configuration, and report variability. If introducing other fuzzers, use the same instrumented DUT and count both generation and simulation costs consistently. Replay failures, reduce inputs, and classify configuration errors separately from confirmed defects.

## 4. Preliminary results and environment evidence — 25 points

### Published results versus local measurements

The paper's abstract reports 26 new bugs across XiangShan, CVA6, Rocket, and NutShell, with 15 CVE identifiers. It also reports coverage speedups of 204× over DifuzzRTL and 114× over Cascade. These are author-reported results, **not reproduced measurements from this machine**. The exact comparison conditions require the full paper. [Paper abstract](https://doi.org/10.1145/3719027.3765167).

### Storage and environment

The Windows checkout is `F:\DiveFuzz\DiveFuzz`; Ubuntu WSL sees it as `/mnt/f/DiveFuzz/DiveFuzz`. Ubuntu 24.04.4 and Python 3.12.3 were detected. The initial WSL inspection showed approximately 11 GiB RAM and 3 GiB swap. Subsequent Python installs, downloaded metadata, caches, logs, and build products are directed to F:. Upstream generation also uses Linux `/dev/shm` for temporary execution templates and shared memory; this is RAM-backed storage, not an installation directory.

Before the storage restriction was specified, an apt command installed the RISC-V GCC/binutils packages and device-tree compiler prerequisites in the existing Ubuntu WSL environment. No further apt installation is part of the F: setup scripts. Existing Linux system tools are reused; this is not a claim that the existing WSL virtual disk resides on F:.

### Evidence and acceptance criteria

`evidence/setup.log` records the initial setup and build failure; `evidence/spike-build.log` records the successful repaired build. `scripts/verify-f.py` records command output and writes `evidence/verification.json`. The final verification returned success, with every recorded command returning zero. The preceding failed reference-layout check is retained in `evidence/verification-initial.json` and `evidence/reference-execute-initial.log`.

| Check or measurement | Observed result |
|---|---|
| Python dependencies | `pip check`: no broken requirements |
| RISC-V compiler / assembler | GCC 13.2.0 / GNU assembler 2.42 |
| Adapted Spike / Python wrapper | Built on F:; native Python 3.12 engine imported successfully |
| Reference arithmetic program | Assembled, linked, and executed in Spike; success exit code 0 |
| Generation configuration | CVA6 template/profile, elimination enabled, 1 worker, jumps disabled, 2 seeds × 20 requested instructions |
| Accepted instruction evidence | Debug logs contain exactly 20 `[ACCEPTED]` records per seed, 40 total |
| Generated / compiled seeds | 2/2 assembly sources; 2/2 ELF executables; 2/2 nonempty images |
| Valid seed rate in this pilot | 100% (2/2), a very small sample |
| ELF architecture | ELF64, little-endian, RISC-V, entry point `0x80000000` |
| Artifact sizes | Each ELF: 26,672 bytes; each image: 1,056,768 bytes |
| Generator process wall time | 10.095 seconds, including interpreter/import startup and debug output |
| Generator's internal time | 1.60 seconds reported by the generator; excludes earlier process startup |
| Timeouts / retry counter | 0 timeouts; 1 reported failed conflict avoidance, followed by successful completion |
| RTL DUT execution / coverage / bugs | Not measured; no DUT emulator built or executed |

The final corpus is archived in `evidence/seeds-20261004-104433/`; hashes are recorded in `evidence/verification.json`. Accepted-instruction logs contain reference PCs and register values, demonstrating active runtime validation rather than file generation alone. The tool's conflict counters are reported as labeled; they are not treated as confirmed defects or as an independently validated count of duplicate values.

These results establish a working **generation, reference-execution, and compilation environment for the selected profile**. They do not establish correctness of a target CPU, reproduce the paper's speedups, or demonstrate compatibility with every extension. The grade's alternative environment-evidence requirement is addressed with archived commands, outputs, and artifacts.

### Problems and solutions

| Problem | Observation or implication | Resolution or next step |
|---|---|---|
| Windows-native tooling | POSIX shell, shared-library, and shared-memory assumptions complicate native Windows execution | Use existing Ubuntu WSL while keeping project-created disk data on F: |
| Python dependency pin | Upstream pins PyYAML 5.4.1; this lacks a Python 3.12 wheel | Use a separate local requirements file with PyYAML 6.0.x, then verify imports and dependency consistency |
| Missing opcode metadata | Opcode submodule was uninitialized | Initialize the pinned submodule and generate `instr_dict.json` |
| Windows line endings | `configure` could not execute with its CRLF shebang; CRLF in `config.h.in` also left `DTC` undefined during compilation | Normalize the configure script, configuration-header template, and helper scripts to LF; regenerate configuration |
| Flattened symbolic link | `spike_dasm_option_parser.cc` contained only `../fesvr/option_parser.cc`; compilation failed at line 1 | Restore the Git-recorded symbolic link using `scripts/prepare-spike.py`, then resume the incremental build |
| Initial reference-test ELF layout | A test linked using only `-Ttext` placed an ELF load segment at `0x7ffff000`, outside Spike's default RAM | Add explicit load segments with `scripts/reference-sanity.ld`; the corrected test passes |
| Wrapper compiler warnings | Wrapper defaults to C++17 while Spike headers use some C++20 features | GCC accepted them as extensions; build/import passed. For stricter compilers, build the wrapper with C++20 flags |
| Incorrect README Spike path | README path from repository root omits `ref/` | Source `scripts/env-f.sh`, which uses the absolute checkout path |
| Extension compatibility | Ubuntu's GCC version differs from the README recommendation | Start with a scoped CVA6 profile; test assembly explicitly and record unsupported extensions if found |
| Unbuilt DUTs | DUT submodules initially uninitialized | Complete generator checkpoint first; select a CPU, initialize its pinned dependencies, and follow its build instructions for RTL testing |
| F: filesystem overhead | WSL access to Windows files can be slower for many small files | Retain F: storage; allow more build time or later use a Linux filesystem disk explicitly stored on F: |
| Full paper unavailable | ACM PDF fetch returned HTTP 403 | Use the accessible abstract and inspected code for this checkpoint; obtain the paper through institutional access for exact evaluation details |

### Reproduction commands

From PowerShell:

```powershell
wsl -d Ubuntu -- bash /mnt/f/DiveFuzz/DiveFuzz/scripts/setup-f.sh
wsl -d Ubuntu -- bash /mnt/f/DiveFuzz/DiveFuzz/scripts/verify-f.sh
```

For an interactive WSL terminal:

```bash
cd /mnt/f/DiveFuzz/DiveFuzz
source scripts/env-f.sh
cd fuzzer
python -m generator.main --help
```

The smoke test selects the CVA6 template/profile for manageable instruction support. It does not imply that a CVA6 RTL core has been built or verified. The archived evidence, dependency versions, revision IDs, and artifact hashes make the checkpoint reviewable.
