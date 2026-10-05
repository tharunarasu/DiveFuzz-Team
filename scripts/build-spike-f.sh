#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/env-f.sh"
cd "$DIVEFUZZ_ROOT"
mkdir -p evidence
exec > >(tee evidence/spike-build.log) 2>&1
python scripts/prepare-spike.py
cd ref/riscv-isa-sim-adapter/build
../configure --prefix="$DIVEFUZZ_ROOT/.local/spike" CXXFLAGS='-O2 -fPIC' CFLAGS='-O2 -fPIC'
make -j4
cd ../spike_engine
make -j2 PYTHON="$DIVEFUZZ_ROOT/.venv/bin/python"
python -c 'import spike_engine; print("PASS: native Spike engine import")'
