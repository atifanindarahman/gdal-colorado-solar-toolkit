#!/usr/bin/env bash
# Normalize raster values to 0-1 range using gdal_calc
set -euo pipefail

INPUT="data/processed/raster_clipped.tif"
OUTPUT="data/processed/raster_normalized.tif"
STATS_FILE="/tmp/gdal_stats.txt"

echo "Computing statistics..."
gdalinfo -stats "$INPUT" > "$STATS_FILE"

MIN=$(grep "STATISTICS_MINIMUM" "$STATS_FILE" \
      | head -1 | awk -F= '{print $2}' | tr -d ' ')
MAX=$(grep "STATISTICS_MAXIMUM" "$STATS_FILE" \
      | head -1 | awk -F= '{print $2}' | tr -d ' ')

echo "Min: $MIN"
echo "Max: $MAX"
echo "Normalizing to 0–1..."

gdal_calc.py \
  -A "$INPUT" \
  --outfile="$OUTPUT" \
  --calc="(A - $MIN) / ($MAX - $MIN)" \
  --NoDataValue=-9999 \
  --type=Float32 \
  --overwrite

echo ""
echo "Done. Normalized statistics:"
gdalinfo -stats "$OUTPUT" | grep "STATISTICS_"