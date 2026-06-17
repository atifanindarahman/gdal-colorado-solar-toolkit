#!/usr/bin/env bash
# Master runner — executes the complete GDAL workflow end to end
set -euo pipefail

INPUT_RASTER="${1:?Usage: $0 <input_raster.tif> [boundary.shp]}"
BOUNDARY="${2:-data/raw/colorado_boundary.shp}"

echo "============================================="
echo " GDAL/OGR Geospatial Processing Toolkit"
echo "============================================="
echo ""

echo ">>> Step 1: Inspect"
bash scripts/01_inspect.sh "$INPUT_RASTER"

echo ""
echo ">>> Step 2: Reproject"
bash scripts/02_reproject.sh "$INPUT_RASTER"

echo ""
echo ">>> Step 3: Clip"
bash scripts/03_clip.sh "$BOUNDARY"

echo ""
echo ">>> Step 4: Normalize"
bash scripts/04_normalize.sh

echo ""
echo ">>> Step 5: COG"
bash scripts/05_cog.sh

echo ""
echo "============================================="
echo " All steps complete. Outputs in data/outputs/"
echo "============================================="