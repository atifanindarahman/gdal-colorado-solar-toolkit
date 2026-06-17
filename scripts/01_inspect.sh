#!/usr/bin/env bash

set -euo pipefail

INPUT="${1:?Usage: $0 <input_raster.tif>}"

echo "============================================="
echo " Solargis Colorado GHI Raster Inspection"
echo "============================================="

echo ""
echo "--- Driver and Size ---"
gdalinfo "$INPUT" | grep -E "Driver|Files|Size is|Pixel Size|Origin"

echo ""
echo "--- Coordinate System ---"
gdalinfo "$INPUT" | grep -A 8 "Coordinate System is"

echo ""
echo "--- Statistics ---"
gdalinfo -stats "$INPUT" | grep "STATISTICS_"

echo ""
echo "--- NoData and Data Type ---"
gdalinfo "$INPUT" | grep -E "NoData|Type="