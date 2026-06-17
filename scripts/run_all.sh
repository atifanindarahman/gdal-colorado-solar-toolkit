#!/usr/bin/env bash

set -euo pipefail

INPUT="${1:?Usage: $0 <ghi.tif> [boundary.shp]}"

BOUNDARY="${2:-data/raw/colorado_boundary.shp}"

bash scripts/01_inspect.sh "$INPUT"

bash scripts/02_reproject.sh "$INPUT"

bash scripts/03_clip.sh "$BOUNDARY"

bash scripts/04_normalize.sh

bash scripts/05_cog.sh

echo ""
echo "Workflow complete"