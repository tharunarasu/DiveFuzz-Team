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
