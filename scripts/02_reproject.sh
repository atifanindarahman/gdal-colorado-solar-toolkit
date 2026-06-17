#!/usr/bin/env bash
set -euo pipefail
INPUT="${1:?Usage: $0 <input_raster.tif>}"
OUTPUT="data/processed/raster_utm13n.tif"

echo "Reprojecting: $INPUT"
echo "Source CRS:   EPSG:26913 (NAD83 UTM Zone 13N)"
echo "Target CRS:   EPSG:32613 (WGS84 UTM Zone 13N)"
echo "Output:       $OUTPUT"
echo ""

gdalwarp \
  -s_srs EPSG:26913 \
  -t_srs EPSG:32613 \
  -r bilinear \
  -dstnodata -9999 \
  -co "COMPRESS=LZW" \
  -co "TILED=YES" \
  "$INPUT" \
  "$OUTPUT"

echo ""
echo "Done. Verifying output CRS:"
gdalinfo "$OUTPUT" | grep -A 3 "Coordinate System"