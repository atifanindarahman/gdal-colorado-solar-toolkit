#!/usr/bin/env bash
# Reproject vector boundary then clip raster to it
set -euo pipefail

RASTER="data/processed/raster_utm13n.tif"
BOUNDARY_IN="${1:-data/raw/colorado_boundary.shp}"
BOUNDARY_PROJ="data/processed/boundary_utm13n.shp"
OUTPUT="data/processed/raster_clipped.tif"

echo "=== Step 3a: Inspect boundary vector ==="
ogrinfo -al -so "$BOUNDARY_IN"

echo ""
echo "=== Step 3b: Reproject boundary to UTM Zone 13N ==="
ogr2ogr \
  -f "ESRI Shapefile" \
  -t_srs "EPSG:32613" \
  "$BOUNDARY_PROJ" \
  "$BOUNDARY_IN"

echo ""
echo "=== Step 3c: Clip raster to boundary ==="
gdalwarp \
  -cutline "$BOUNDARY_PROJ" \
  -crop_to_cutline \
  -dstnodata -9999 \
  -co "COMPRESS=LZW" \
  "$RASTER" \
  "$OUTPUT"

echo ""
echo "Done. Output extent:"
gdalinfo "$OUTPUT" | grep "Corner Coordinates" -A 5