#!/usr/bin/env bash

set -euo pipefail

INPUT="data/processed/ghi_colorado_clipped.tif"

OUTPUT="data/outputs/ghi_colorado_cog.tif"

gdal_translate
-of COG
-co COMPRESS=DEFLATE
-co OVERVIEW_RESAMPLING=AVERAGE
"$INPUT"
"$OUTPUT"

echo "COG created"

gdalinfo "$OUTPUT"