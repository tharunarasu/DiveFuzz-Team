#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/env-f.sh"
mkdir -p "$DIVEFUZZ_ROOT/evidence/final/checks"
python "$DIVEFUZZ_ROOT/scripts/functional-checks.py" 2>&1 | tee "$DIVEFUZZ_ROOT/evidence/final/checks/functional.log"
