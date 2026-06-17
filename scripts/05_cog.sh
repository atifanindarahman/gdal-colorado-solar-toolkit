#!/usr/bin/env bash
# Create a Cloud Optimized GeoTIFF (COG)
# COG is the modern standard for cloud-native geospatial data
set -euo pipefail

INPUT="data/processed/raster_clipped.tif"
OUTPUT="data/outputs/raster_colorado_cog.tif"

echo "Creating Cloud Optimized GeoTIFF..."
echo "Input:  $INPUT"
echo "Output: $OUTPUT"

gdal_translate \
  -of COG \
  -co "COMPRESS=DEFLATE" \
  -co "OVERVIEW_RESAMPLING=AVERAGE" \
  -co "BIGTIFF=IF_NEEDED" \
  "$INPUT" \
  "$OUTPUT"

echo ""
echo "Done. COG info:"
gdalinfo "$OUTPUT" | grep -E "Files|Driver|Size is"

echo ""
echo "Checking internal overview levels (COG requirement):"
gdalinfo "$OUTPUT" | grep "Overviews"