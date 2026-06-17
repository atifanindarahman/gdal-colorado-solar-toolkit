#!/usr/bin/env bash

set -euo pipefail

RASTER="data/processed/ghi_utm13n.tif"

BOUNDARY="${1:-data/raw/colorado_boundary.shp}"

BOUNDARY_UTM="data/processed/colorado_boundary_utm13n.shp"

OUTPUT="data/processed/ghi_colorado_clipped.tif"

echo "Reprojecting Colorado boundary"

ogr2ogr
-t_srs EPSG:32613
"$BOUNDARY_UTM"
"$BOUNDARY"

echo "Clipping raster"

gdalwarp
-cutline "$BOUNDARY_UTM"
-crop_to_cutline
-dstnodata -9999
"$RASTER"
"$OUTPUT"

echo "Finished clipping"