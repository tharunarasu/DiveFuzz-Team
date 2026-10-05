#!/usr/bin/env bash
# Source from any directory. All task-created data lives on F: in WSL.
export DIVEFUZZ_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export TMPDIR="$DIVEFUZZ_ROOT/.local/tmp"
export TEMP="$TMPDIR"
export TMP="$TMPDIR"
export XDG_CACHE_HOME="$DIVEFUZZ_ROOT/.local/cache"
export PIP_CACHE_DIR="$XDG_CACHE_HOME/pip"
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/pycache"
export PYTHONDONTWRITEBYTECODE=1
mkdir -p "$TMPDIR" "$PIP_CACHE_DIR"
export PATH="$DIVEFUZZ_ROOT/.venv/bin:$DIVEFUZZ_ROOT/ref/riscv-isa-sim-adapter/build:$PATH"
export spike="$DIVEFUZZ_ROOT/ref/riscv-isa-sim-adapter/build/spike"
