# GDAL Colorado Solar Toolkit

## Overview
End-to-end GDAL/OGR command-line workflow for processing Solargis GHI raster data over Colorado.

## Workflow
1. Raster inspection (gdalinfo)
2. CRS validation and reprojection (gdalwarp)
3. Boundary clipping
4. Normalization (gdal_calc)
5. Cloud Optimized GeoTIFF creation (COG)

## Tech Stack
- GDAL / OGR CLI
- Bash scripting
- Rasterio (validation)
- GeoPandas (visualization)
- Python (analysis)

## Project Structure
scripts/ → bash automation pipeline  
data/ → raw and processed geospatial data  
notebooks/ → visualization and validation  

## Output
- Reprojected raster (EPSG:32613)
- Clipped Colorado dataset
- Normalized GHI raster (0–1)
- Cloud Optimized GeoTIFF (COG)

## Author
Atif Aninda Rahman
University of Denver — MS GIS