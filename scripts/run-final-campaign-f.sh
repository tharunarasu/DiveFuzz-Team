#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/env-final-f.sh"
python "$DIVEFUZZ_ROOT/scripts/run-final-campaign.py" "$@"
