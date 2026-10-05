#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/env-f.sh"
cd "$DIVEFUZZ_ROOT"
mkdir -p evidence
python scripts/verify-f.py 2>&1 | tee evidence/verification.log
