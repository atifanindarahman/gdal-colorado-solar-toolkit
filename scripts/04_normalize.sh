#!/usr/bin/env bash

set -euo pipefail

INPUT="data/processed/ghi_colorado_clipped.tif"

OUTPUT="data/processed/ghi_normalized.tif"

STATS_FILE="data/processed/gdal_stats.txt"

gdalinfo -stats "$INPUT" > "$STATS_FILE"

MIN=$(grep "STATISTICS_MINIMUM" "$STATS_FILE"
| head -1 | awk -F= '{print $2}')

MAX=$(grep "STATISTICS_MAXIMUM" "$STATS_FILE"
| head -1 | awk -F= '{print $2}')

echo "Minimum: $MIN"
echo "Maximum: $MAX"

gdal_calc.py
-A "$INPUT"
--outfile="$OUTPUT"
--calc="(A-$MIN)/($MAX-$MIN)"
--NoDataValue=-9999
--type=Float32
--overwrite

echo "Normalization complete"