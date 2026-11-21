# Data source register

Fill one row per dataset **before** using it. Verify licenses on the source page; do not assume.

| ID | Indicator | Dataset | Publisher | Vintage | Format | Unit / CRS | License / attribution | Redistributable sample? | Notes |
|---|---|---|---|---|---|---|---|---|---|
| DS-01 | Boundaries | TIGER/Line census tracts | U.S. Census Bureau | 2026 TIGER/Line (2020-based tracts) | Shapefile | EPSG:4269 (NAD83) | Not copyrighted; free to use, but acknowledge the U.S. Census Bureau as source; "TIGER/Line" is a registered trademark (2026 tract file metadata) | Yes, clipped sample; credit the U.S. Census Bureau (TIGER/Line terms) | Join key `GEOID` (11 digits). LA County tract GEOIDs identical in 2020, 2024 and 2026 files (2,498 tracts, checked 2026-11-20). URL: https://www2.census.gov/geo/tiger/TIGER2026/TRACT/tl_2026_06_tract.zip |
| DS-02 | V (vulnerability) | ACS 5-year detailed tables C17002 (ratio of income to poverty level) and B25044 (tenure by vehicles available), block group | U.S. Census Bureau | ACS 2020–2024 5-year (released 2026-01-29; newest 5-year as of 2026-11-20) | Bulk files (no API; see access note) | counts | No license statement found on Census pages; cite "U.S. Census Bureau", table name, product, vintage, URL, access date (https://www.census.gov/about/policies/citation.html) | Probably yes, with citation; no explicit license found (R10) | Only for fields not in the 2020 Census. Join key `GEOID` (12 digits) = first 12 digits of a block's `GEOID20`. Both tables confirmed at block group (summary level 150) in the 2020–2024 ACS 5-year table-based summary file; fallback is tract level (ADR 0003). Keep margins of error (larger at block group); use 2020-based geography. Census Data API now requires a key; the summary files do not. LA County block-group GEOIDs identical in 2020, 2024 and 2026 TIGER files (6,591). URL: https://www2.census.gov/programs-surveys/acs/summary_file/2024/table-based-SF/data/5YRData/ (`acsdt5y2024-c17002.dat`, `acsdt5y2024-b25044.dat`) |
| DS-09 | V + population weights | 2020 Census Demographic and Housing Characteristics (DHC), block level | U.S. Census Bureau | 2020 | Bulk files (no API; see access note) | counts | No license statement found on Census pages; cite as for DS-02 | Probably yes, with citation; no explicit license found (R10) | Confirmed block-level tables (2020 Census Data Product Crosswalk, May 2023): **P1** total population; **P12** sex by age, 65+ = cells 20–25 (male) + 44–49 (female); 65+ living alone = **P19** cell 3 (1-person households with a person 65+; chosen over the equivalent H14 cells 22, 31, 56, 65, ADR 0003). Block counts carry differential-privacy noise; use summed to hexes, not per block. Join key `GEOID20` (15 digits). URL: https://www2.census.gov/programs-surveys/decennial/2020/data/demographic-and-housing-characteristics-file/California/ |
| DS-10 | Population allocation | TIGER/Line 2020 census blocks | U.S. Census Bureau | 2026 TIGER/Line release of the 2020 tabulation blocks (`tabblock20`) | Shapefile | EPSG:4269 (NAD83) | Same TIGER/Line terms as DS-01 (verified on the 2020 and 2026 tract metadata; block file metadata not yet checked) | Yes, clipped sample; credit the U.S. Census Bureau (TIGER/Line terms) | Use the internal point (`INTPTLAT20`, `INTPTLON20`), which is guaranteed inside the block, rather than a computed centroid. On download, confirm the 2026 file still has `GEOID20`, `INTPTLAT20`, `INTPTLON20` and the same LA County block set as DHC; if not, use the 2020 file (TIGER2020/TABBLOCK20/tl_2020_06_tabblock20.zip, ~382 MB). URL: https://www2.census.gov/geo/tiger/TIGER2026/TABBLOCK20/tl_2026_06_tabblock20.zip |
| DS-03 | H (heat) | Landsat Collection 2 Level-2 surface temperature (summer, low cloud) | USGS (via a STAC catalog) | Collection 2 (current), Landsat 8–9, summer 2026 scenes; exact scenes chosen in Week 5 | Cloud-Optimized GeoTIFF | Kelvin (scaled) | "No restrictions on the use of Landsat products" (USGS). Cite: EROS Center (2020), Landsat 8-9 OLI/TIRS Level-2, Collection 2, https://doi.org/10.5066/P9OGBGM6. Optional credit: "Landsat Collection 2 Level-2 image courtesy of the U.S. Geological Survey" | Yes, clipped sample ("no restrictions on the use of Landsat products"); cite the DOI | LST ≠ air temperature; record scene IDs, dates, STAC endpoint. Scaling: K = DN × 0.00341802 + 149.0, fill value 0; ST missing where ASTER GED is missing. Product page: https://www.usgs.gov/landsat-missions/landsat-collection-2-surface-temperature |
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

## Census data access: bulk files, not the API (DS-02, DS-09; risk R25)

Decided 2026-11-20 (Week 1): download Census data as **bulk files** (ACS table-based summary files,
DHC data files, TIGER/Line zips), not through the Census Data API.

- The API now requires a key in every request URL, which would bring a secret into the workflow
  (R14). Bulk files need no key.
- Bulk files are fixed per release, so downloads are reproducible and can be re-fetched by URL.
- The dashboard never calls the API either way; it reads engine exports only (NFR-09).
- If the API is ever used, keep the key in `.env` only, and show the notice required by the
  [API Terms of Service](https://www.census.gov/data/developers/about/terms-of-service.html):
  "This product uses the Census Bureau Data API but is not endorsed or certified by the Census Bureau."

## Heat resolution vs block size (DS-03, DS-10; risk R27)

Population-weighted heat (ADR 0003) needs a mean LST for each 2020 block. Landsat thermal is
captured at **100 m** and delivered resampled to **30 m** pixels, so 30 m pixels are not independent
measurements.

- Illustration: a 100 m × 200 m urban block covers about 22 pixels at 30 m, but only about 2
  native 100 m thermal footprints. Smaller blocks may contain no pixel center at all.
- A block mean LST is therefore smoother than the pixel count suggests, and neighbouring small
  blocks will often share nearly the same value.
- A block with no valid pixel has a **missing** LST (never 0) and is flagged.
- The per-block method (e.g. pixel-center vs area-fraction weighting) is decided in the Week 9
  methodology and tested in Week 10. Until then, this is a known limitation, not a design choice.

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
