#!/usr/bin/env bash
# Inspect a raster — always do this before any processing
# Usage: bash scripts/01_inspect.sh data/raw/your_file.tif
set -euo pipefail

INPUT="${1:?Usage: $0 <input_raster.tif>}"

echo "============================================="
echo " Raster Inspection: $(basename $INPUT)"
echo "============================================="

echo ""
echo "--- Driver and Size ---"
gdalinfo "$INPUT" | grep -E "Driver|Files|Size is|Pixel Size|Origin"

echo ""
echo "--- Coordinate System ---"
gdalinfo "$INPUT" | grep -A 8 "Coordinate System is"

echo ""
echo "--- Band Statistics ---"
gdalinfo -stats "$INPUT" | grep "STATISTICS_"

echo ""
echo "--- NoData and Data Type ---"
gdalinfo "$INPUT" | grep -E "NoData|Type="