# ADR 0002 — Study area and unit of analysis

**Status:** Accepted (2026-11-16); amended 2026-11-19 (see [Amendment 1](#amendment-1-2026-11-19--population-weighting))

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

## Amendment 1 (2026-11-19) — population weighting

Replaces the **Demographic source** row and the Week 7 interpolation consequence above. The unit of
analysis (H3 res 8) and study area are unchanged.

| Concern | New choice |
|---|---|
| Demographic source | **Hybrid:** 2020 Census DHC at **block** level (population, age 65+, 65+ living alone) + ACS 5-year at **tract** level only for fields the 2020 Census lacks (poverty, no-vehicle households) |
| Allocation to hexes | Each block's counts go to the hex containing its TIGER/Line internal point. ACS tract counts are split to blocks by population share, then summed per hex. Rates are computed after allocation |
| Heat indicator (H) | **Population-weighted:** mean LST per block, averaged per hex weighted by block population. The plain area mean is kept for comparison |
| New output | Exposure columns (residents, residents 65+ per hex), reported next to the score, not part of it |

**Why:** area-weighted interpolation assumes people are spread evenly within a tract, so hexes over
rail yards, parks, or industrial land received residents they don't have. Blocks are far smaller, so
the score better reflects heat **where people live**.

**Consequences:**
- Most of the "dasymetric" backlog item is now in v1 at block level; only finer allocation within
  blocks (building footprints, impervious surface) stays in v1.1.
- Block counts carry 2020 Census differential-privacy noise; use them summed to hexes, not per block.
- Poverty and vehicle fields are still tract-level detail even when shown per hex (documented in
  `docs/requirements.md` IR-07). ACS margins of error are still carried.
- Adds ~1–1.5 h across Weeks 5 and 10 (ROADMAP change 11).
