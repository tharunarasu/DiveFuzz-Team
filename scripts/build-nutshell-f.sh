#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/env-final-f.sh"
mkdir -p "$DIVEFUZZ_ROOT/evidence/final/build"
exec > >(tee "$DIVEFUZZ_ROOT/evidence/final/build/nutshell.log") 2>&1
git -C "$DIVEFUZZ_ROOT" submodule update --init dut/NutShell
git -C "$NOOP_HOME" submodule update --init difftest
python "$DIVEFUZZ_ROOT/scripts/prepare-nutshell.py"
cd "$NOOP_HOME"
java -version
mill -i --version
verilator --version
make -j2 emu EMU_COVERAGE=1
