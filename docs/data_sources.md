# Data source register

Fill one row per dataset **before** using it. Verify licenses on the source page; do not assume.

| ID | Indicator | Dataset | Publisher | Vintage | Format | Unit / CRS | License / attribution | Redistributable sample? | Notes |
|---|---|---|---|---|---|---|---|---|---|
| DS-01 | Boundaries | TIGER/Line census tracts | U.S. Census Bureau | | Shapefile | EPSG:4269 (NAD83) | | | Join key `GEOID` (11 digits) |
| DS-02 | V (vulnerability) | ACS 5-year detailed tables C17002 (ratio of income to poverty level) and B25044 (tenure by vehicles available), block group | U.S. Census Bureau | | CSV / API | counts | | | Only for fields not in the 2020 Census. Join key `GEOID` (12 digits) = first 12 digits of a block's `GEOID20`. Verify block-group availability in Week 5; fallback is tract level (ADR 0003). Keep margins of error (larger at block group); use 2020-based geography |
| DS-09 | V + population weights | 2020 Census Demographic and Housing Characteristics (DHC), block level | U.S. Census Bureau | 2020 | CSV / API | counts | | | Total population, age 65+, 65+ living alone (verify which tables are published at block level). Block counts carry differential-privacy noise; use summed to hexes, not per block. Join key `GEOID20` (15 digits) |
| DS-10 | Population allocation | TIGER/Line 2020 census blocks | U.S. Census Bureau | 2020 | Shapefile | EPSG:4269 (NAD83) | | | Use the internal point (`INTPTLAT20`, `INTPTLON20`), which is guaranteed inside the block, rather than a computed centroid |
| DS-03 | H (heat) | Landsat Collection 2 Level-2 surface temperature (summer, low cloud) | USGS (via a STAC catalog) | | Cloud-Optimized GeoTIFF | Kelvin (scaled) | | | LST ≠ air temperature; record scene IDs, dates, STAC endpoint, and scaling factors |
| DS-04 | G (green space) | NLCD tree canopy cover | USFS / MRLC | | GeoTIFF | % canopy, 30 m | | | Alternative: NDVI from the same Landsat scenes |
| DS-05 | (optional) | CDC/ATSDR Social Vulnerability Index | CDC/ATSDR | | CSV/SHP | percentile | | | Could replace a custom V; check tract vintage |
| DS-06 | ML feature | NLCD impervious surface | USGS / MRLC | | GeoTIFF | % impervious, 30 m | | | Used in M5 ML model |
| DS-08 | Unit of analysis | H3 hexagonal grid, resolution 8 (generated with `h3-py`) | Uber H3 (open source) | | GeoPackage (generated) | EPSG:4326 cells | Apache-2.0 library | Yes (generated) | Clipped to LA County; ID field `h3_id` |
| DS-07 | Validation outcome | Heat-related ER visits / EMS heat calls, or urban heat campaign air temperature | State/county health dept, or city/NOAA campaign | | CSV/SHP | count/rate or °C | | | Must be independent of LST; record geographic level and suppression rules |

## Candidate vulnerability fields (pick 2–4 for the MVP)

- Share of population age 65+ (2020 Census, DS-09)
- Share of people living alone age 65+ (2020 Census, DS-09)
- Share below poverty line (ACS, DS-02)
- Share of households without a vehicle (ACS, DS-02)

## Candidates to scout in Week 5 (not registered for use yet)

Landsat thermal is captured at 100 m and delivered resampled to 30 m. Look for finer data, then add a
row above before using any of these:

- Heat: ECOSTRESS land surface temperature (~70 m); airborne heat-mapping campaigns over LA, if any
- Canopy: 1 m tree canopy datasets covering LA County; NAIP imagery (~0.6 m) for NDVI

## Rules

- Raw downloads go in `data/raw/` (git-ignored). Clipped samples go in `data/sample/`.
- Record download date and exact URL/query in the Notes column.
- Boundary vintage and ACS vintage must use the same tract and block-group definitions (2020-based
  geography for ACS 2020+), so block-group codes match the 2020 block `GEOID20` prefixes.
