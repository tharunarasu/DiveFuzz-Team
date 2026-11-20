#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/env-f.sh"
python "$DIVEFUZZ_ROOT/scripts/check-generator-controls.py"
