# Data source register

Fill one row per dataset **before** using it. Verify licenses on the source page; do not assume.

| ID | Indicator | Dataset | Publisher | Vintage | Format | Unit / CRS | License / attribution | Redistributable sample? | Notes |
|---|---|---|---|---|---|---|---|---|---|
| DS-01 | Boundaries | TIGER/Line census tracts | U.S. Census Bureau | | Shapefile | EPSG:4269 (NAD83) | | | Join key `GEOID` (11 digits) |
| DS-02 | V (vulnerability) | ACS 5-year detailed/subject tables | U.S. Census Bureau | | CSV / API | counts, % | | | Keep margins of error; match tract vintage to DS-01 |
| DS-03 | H (heat) | Landsat Collection 2 Level-2 surface temperature (summer, low cloud) | USGS (via a STAC catalog) | | Cloud-Optimized GeoTIFF | Kelvin (scaled) | | | LST ≠ air temperature; record scene IDs, dates, STAC endpoint, and scaling factors |
| DS-04 | G (green space) | NLCD tree canopy cover | USFS / MRLC | | GeoTIFF | % canopy, 30 m | | | Alternative: NDVI from the same Landsat scenes |
| DS-05 | (optional) | CDC/ATSDR Social Vulnerability Index | CDC/ATSDR | | CSV/SHP | percentile | | | Could replace a custom V; check tract vintage |
| DS-06 | ML feature | NLCD impervious surface | USGS / MRLC | | GeoTIFF | % impervious, 30 m | | | Used in M5 ML model |
| DS-08 | Unit of analysis | H3 hexagonal grid, resolution 8 (generated with `h3-py`) | Uber H3 (open source) | | GeoPackage (generated) | EPSG:4326 cells | Apache-2.0 library | Yes (generated) | Clipped to LA County; ID field `h3_id` |
| DS-07 | Validation outcome | Heat-related ER visits / EMS heat calls, or urban heat campaign air temperature | State/county health dept, or city/NOAA campaign | | CSV/SHP | count/rate or °C | | | Must be independent of LST; record geographic level and suppression rules |

## Candidate vulnerability fields (pick 2–4 for the MVP)

- Share of population age 65+
- Share below poverty line
- Share of households without a vehicle
- Share of people living alone age 65+

## Rules

- Raw downloads go in `data/raw/` (git-ignored). Clipped samples go in `data/sample/`.
- Record download date and exact URL/query in the Notes column.
- Boundary vintage and ACS vintage must use the same tract definitions (2020-based tracts for
  ACS 2020+).
