#!/usr/bin/env bash

set -euo pipefail

INPUT="${1:?Usage: $0 <input_raster.tif>}"

OUTPUT="data/processed/ghi_utm13n.tif"

echo "Reprojecting Colorado GHI Raster"

gdalwarp
-t_srs EPSG:32613
-r bilinear
-dstnodata -9999
-co COMPRESS=LZW
-co TILED=YES
"$INPUT"
"$OUTPUT"

echo ""
echo "Finished:"
gdalinfo "$OUTPUT" | grep -E "Coordinate System|Pixel Size" -A 3