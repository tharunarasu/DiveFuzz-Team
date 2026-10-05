#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/env-f.sh"
cd "$DIVEFUZZ_ROOT"
mkdir -p evidence
exec > >(tee evidence/setup.log) 2>&1
case "$DIVEFUZZ_ROOT" in /mnt/f/*) ;; *) echo 'Run this checkout on F: (/mnt/f).'; exit 1;; esac
for tool in python3 gcc g++ make dtc riscv64-unknown-elf-gcc; do command -v "$tool"; done
git submodule update --init fuzzer/generator/reg_analyzer/riscv-opcodes ref/riscv-isa-sim-adapter
python3 -m venv .venv
python -m pip install --no-compile --upgrade pip
# PyYAML 5.4.1 has no Python 3.12 wheel; use its maintained API-compatible release.
python -m pip install --no-compile -r scripts/requirements-wsl.txt
python -m pip check
cd "$DIVEFUZZ_ROOT/fuzzer/generator/reg_analyzer/riscv-opcodes"
make
cd "$DIVEFUZZ_ROOT"
python scripts/prepare-spike.py
cd "$DIVEFUZZ_ROOT/ref/riscv-isa-sim-adapter"
mkdir -p build
cd build
../configure --prefix="$DIVEFUZZ_ROOT/.local/spike" CXXFLAGS='-O2 -fPIC' CFLAGS='-O2 -fPIC'
make -j4
cd ../spike_engine
make -j2 PYTHON="$DIVEFUZZ_ROOT/.venv/bin/python"
python -c 'import spike_engine; print("PASS: native Spike engine import")'
echo 'Setup complete. Source scripts/env-f.sh before using DiveFuzz.'
