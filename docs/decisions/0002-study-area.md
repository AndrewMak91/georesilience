# ADR 0002 — Study area and unit of analysis

**Status:** Accepted (2026-11-16)

## Decision

| Concern | Choice |
|---|---|
| Study area | **Los Angeles County, California** (full county extent) |
| Unit of analysis (v1) | **Uber H3 hexagons, resolution 8** (~0.74 km² each; ~14,000 cells over the county before masking) |
| Demographic source | ACS 5-year estimates at **census tract** level, transferred to hexes by area-weighted interpolation |
| Validation geography | Whatever level the outcome data uses (often ZIP/ZCTA); hex scores are aggregated up to it in Week 20 |
| Development subset | A few contiguous cities/tracts for `data/sample/`; full county for real runs |

## Why

- One county keeps downloads, joins, and vintages simple, with strong coast-to-inland heat contrast.
- H3 res 8 gives equal-area, consistent cells that suit raster aggregation (≈800 Landsat 30 m pixels
  per hex) and ML, and avoids tract size differences driving the map.
- Res 7 (~5 km²) blurs neighborhood heat; res 9 (~0.1 km²) has only ~10 native 100 m thermal pixels
  per hex and ~100k cells, too heavy for the dashboard.

## Consequences

- **Engine stays unit-agnostic:** it reads any polygon layer + ID field from config. Hexes are generated
  once by a Python script (`h3-py`) and saved as a GeoPackage; no H3 dependency in C++.
- **New step (Week 7):** area-weighted interpolation of tract counts to hexes, then rates computed per
  hex. Margins of error are approximated and hexes with very few residents are flagged.
- **Limitation to document:** interpolation assumes people are spread evenly within a tract. Better
  (dasymetric) weighting by developed land is in the v1.1 backlog.
- Hexes over forest, desert, water, or with ~0 population are flagged and excluded from ranking.

## Deferred (v1.1, minor update, not a new version)

- Config + dashboard toggle to run and view results by **census tract or H3**.
- Dasymetric interpolation using developed land / impervious surface.

## Later extension (post-v1)

- Bangkok, using global datasets (land cover, gridded population), to show the method transfers
  internationally.
