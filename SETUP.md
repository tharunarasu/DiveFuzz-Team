# Run this checkout from F:

This setup reuses existing Ubuntu WSL system tools. It installs Python packages into `F:\DiveFuzz\DiveFuzz\.venv`, keeps downloads/caches under `.local`, and builds Spike under `ref\riscv-isa-sim-adapter`. It does not run apt or install into Windows C:.

From PowerShell, rebuild or verify with:

```powershell
wsl -d Ubuntu -- bash /mnt/f/DiveFuzz/DiveFuzz/scripts/setup-f.sh
wsl -d Ubuntu -- bash /mnt/f/DiveFuzz/DiveFuzz/scripts/verify-f.sh
```

To resume just the native build without repeating Python setup:

```powershell
wsl -d Ubuntu -- bash /mnt/f/DiveFuzz/DiveFuzz/scripts/build-spike-f.sh
```

For an interactive terminal, run `wsl -d Ubuntu` and then:

```bash
cd /mnt/f/DiveFuzz/DiveFuzz
source scripts/env-f.sh
cd fuzzer
python -m generator.main --help
```

Use `source scripts/env-f.sh` again in each new WSL terminal. The `.venv` is a Linux environment and should be used from WSL.

The verification script saves its results in `evidence/verification.json` and detailed logs in `evidence/`. It tests native engine import, a reference arithmetic program, standalone generation with elimination enabled, and checked assembly/link/image conversion. Its small CVA6 profile does not build or execute a CVA6 RTL core.

The upstream requirements remain available unchanged. `scripts/requirements-wsl.txt` uses PyYAML 6.0.x for Python 3.12. `scripts/requirements-lock.txt` records the exact package versions verified in this session. `scripts/prepare-spike.py` repairs CRLF in build configuration inputs and restores one Git-recorded symlink that was flattened by the Windows checkout.

For a full DUT campaign, initialize one CPU submodule, build its emulator and differential reference according to that CPU revision, then provide its actual paths in a configuration copied from `fuzzer/demo.yaml.example`. Invoke `python run_dut.py --config your_test.yaml` from `fuzzer`. Do not use the example's placeholder paths as measured results.

The report in `REPORT.md` covers the four course rubric sections and explicitly separates published claims, local verification, and future RTL experiments.

## Phase-two NutShell RTL experiments

The phase-two report is `FINAL_REPORT.md`. The recorded experiment uses the pinned NutShell in-order CPU and NEMU differential reference, with Verilator line and toggle coverage enabled. The experimental workload excludes generated CSR instructions, `ecall`, `ebreak`, and jumps; the exception cases are documented separately in the report.

From PowerShell on this machine, after completing the initial setup above:

```powershell
wsl -d Ubuntu -- bash /mnt/f/DiveFuzz/DiveFuzz/scripts/setup-final-tools-f.sh
wsl -d Ubuntu -- bash /mnt/f/DiveFuzz/DiveFuzz/scripts/build-nutshell-f.sh
wsl -d Ubuntu -- bash /mnt/f/DiveFuzz/DiveFuzz/scripts/functional-checks-f.sh
wsl -d Ubuntu -- bash /mnt/f/DiveFuzz/DiveFuzz/scripts/run-final-campaign-f.sh --seeds 20 --instructions 100 --repeats 3
```

These commands place the JDK, Mill, dependency caches, RTL build, test inputs, logs, and raw coverage files on F:. The campaign can take considerable time and disk space. It stores command-level evidence under `evidence/final/` and records the latest campaign path in `evidence/final/latest-campaign.txt`. Generate the Markdown report from a completed campaign with:

```powershell
wsl -d Ubuntu -- bash -c 'source /mnt/f/DiveFuzz/DiveFuzz/scripts/env-f.sh && python /mnt/f/DiveFuzz/DiveFuzz/scripts/create-final-report.py'
```

Raw coverage files are kept locally and omitted from Git. Coverage summaries and test logs are shareable through the team repository.
