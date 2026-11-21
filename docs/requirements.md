# MVP requirements

> **DRAFT for review (Week 1).** Remove this note once approved.

Sources: `docs/plan/project_plan_v1.0.md` (§1.3 success criteria, §2.1 scope, §8.3 interpretation,
priority order), `docs/ROADMAP.md` milestone gates, ADR 0002 (study area and unit), and ADR 0003
(2026-11-19): population allocation by Census 2020 block, population-weighted heat, exposure
columns, hybrid Census 2020 + ACS block-group demographics.

Priority: **P1** essential · **P2** high value · **P3** optional (must never put P1 at risk).

## 1. Problem statement

Neighborhoods in Los Angeles County differ in how hot their surfaces get, how much tree canopy they
have, and how many residents are more sensitive to heat. Where these overlap, an area may warrant
further investigation for heat mitigation, tree planting, or cooling resources.

GeoResilience is a **screening index**. It compares H3 resolution 8 hexes on three documented
indicators: surface heat where people live (H), population vulnerability (V), and lack of green
space (G). It combines them with configurable weights into a transparent, reproducible score and
rank, and reports how many residents each hex holds. It supports preliminary comparison only: it
does **not** predict heat-related illness for any person, and it does **not** decide or recommend
funding.

## 2. Functional requirements

| ID | Requirement | Priority | Milestone | Depends on |
|---|---|---|---|---|
| FR-01 | Report metadata for a vector file (layers, features, geometry type, CRS) | P1 | M1 | — |
| FR-02 | Report metadata for a raster file (size, bands, type, nodata, CRS, geotransform) | P1 | M1 | — |
| FR-03 | Join Census 2020 block counts to blocks (15-digit `GEOID20`) and ACS estimates to block groups (12-digit `GEOID`; tracts as fallback); report duplicates, unmatched records, and missing values | P1 | M2 | FR-01 |
| FR-04 | Carry ACS margins of error; flag unreliable estimates | P1 | M2 | FR-03 |
| FR-05 | Detect missing or unexpected CRS; reproject to one projected CRS | P1 | M2 | FR-01, FR-02 |
| FR-06 | Check geometry validity with a documented repair-or-reject policy | P1 | M2 | FR-01 |
| FR-07 | Allocate people to hexes by where they live: Census 2020 block counts go to the hex containing the block's internal point; ACS block-group counts are split to blocks by population share, then summed per hex; rates computed after allocation | P1 | M2 | FR-03, FR-05, FR-06 |
| FR-08 | One `prepare` command: raw → validated hex GeoPackage + quality report | P1 | M2 | FR-03 – FR-07 |
| FR-09 | Zonal statistics per hex: **population-weighted heat** (mean LST per block, averaged per hex weighted by block population), plain area-mean heat for comparison, canopy share; flag hexes with no valid pixels | P1 | M3 | FR-02, FR-05, FR-07, FR-08 |
| FR-10 | Min-max and percentile normalization (handle min == max) | P1 | M3 | FR-07, FR-09 |
| FR-11 | Validate weights (non-negative, sum to 1); composite score and deterministic rank | P1 | M3 | FR-10, FR-12 |
| FR-12 | Weights and settings from `config/*.json` | P1 | M3 | — |
| FR-13 | Export GeoPackage, GeoJSON, and CSV with run metadata, plus **exposure columns** (e.g. residents and residents 65+ per hex) reported next to the score but not part of it | P1 | M3 | FR-07, FR-11 |
| FR-14 | Compare ≥3 weighting scenarios (baseline, equal, vulnerability-heavy) with Spearman rank correlation and top-k overlap. _Stretch: Monte Carlo (Dirichlet) weight perturbation_ | P1 | M4 | FR-12, FR-13 |
| FR-15 | Validate scores against one independent outcome (not LST) at whatever geographic level it comes in: rank correlation + bootstrap CI. _Stretch: quintile rates, mismatch map_ | P1 | M5 | FR-13 |
| FR-16 | One interpretable model predicting LST, compared with a linear baseline, using spatial (block) CV; report RMSE/MAE/R² + permutation importance. _Stretch: SHAP, residual Moran's I_ | P1 | M5 | FR-08, FR-09 |
| FR-17 | Load engine exports into PostGIS with `ogr2ogr`; saved queries in `sql/`, schema in `data_dictionary.md`. Gate: 5 queries; flex minimum: 3 (at least one spatial join, one distance query) | P1 | M5 | FR-13 |
| FR-18 | Public dashboard: map, ranks, scenarios, validation findings; readable by non-specialists (legend, plain-language notes) | P1 | M6 | FR-13, FR-14, FR-15 |
| FR-19 | Template explanations of a hex's score and its components | P2 | M6 | FR-13 |
| FR-20 | Optional local AI explanations, off by default, based only on result records | P3 | M6 | FR-19 |

**Critical path:** FR-01/02 → FR-08 → FR-09 → FR-11 → FR-13. Everything in M4–M6 reads the FR-13
exports, so a slip on this path delays all later milestones.

## 3. Non-functional requirements

| ID | Requirement | Priority |
|---|---|---|
| NFR-01 | Clean build and test from the README alone | P1 |
| NFR-02 | Reproducible: same inputs + config → identical outputs | P1 |
| NFR-03 | Area and distance math only in a projected CRS, named in code comments and docs | P1 |
| NFR-04 | Missing values explicit (`std::optional` or a flag), never silently 0 | P1 |
| NFR-05 | Errors name the file or field; the CLI exits non-zero | P1 |
| NFR-06 | Engine unit-agnostic: unit layer and ID field come from config | P1 |
| NFR-07 | Module boundaries kept (`analytics` has no I/O; `cli` has no math) | P1 |
| NFR-08 | Automated tests for validation, normalization, and scoring; CI green | P1 |
| NFR-09 | No secrets in the repo or needed for the dashboard; free hosting | P1 |
| NFR-10 | Every dataset registered in `data_sources.md` with its license before use | P1 |
| NFR-11 | Stage timings benchmarked on a documented machine | P2 |

## 4. Interpretation requirements

From plan §8.3. Wherever results are shown (dashboard, report, README), the reader can find:

| ID | The reader can see… |
|---|---|
| IR-01 | What each indicator (H, V, G) measures, its unit, and its direction (higher = more concern) |
| IR-02 | Which datasets and vintages feed each indicator (links to `data_sources.md`) |
| IR-03 | How normalization and population weighting work, in plain language |
| IR-04 | Which weights produced the score shown |
| IR-05 | How much each indicator contributes to a selected hex's score |
| IR-06 | Whether that hex's rank changes under the other scenarios |
| IR-07 | What the score cannot establish: no individual prediction; LST ≠ air temperature; poverty and vehicle data are block-group-level even when shown per hex; data vintages |
| IR-08 | Data-quality flags: few residents, unreliable ACS estimate, no valid pixels |

Wording rule: high-scoring areas "may warrant further investigation". Never "at risk of illness",
"needs funding", or "most dangerous".

## 5. Out of scope for v1

| Item | Why / where it goes |
|---|---|
| Tract/hex unit toggle | v1.1 backlog. The engine stays unit-agnostic (NFR-06), so it's a small change later |
| Finer population allocation within blocks (building footprints, impervious surface) | v1.1 backlog. v1 allocates by Census 2020 block |
| Esri GeoEnrichment demographics | v1.1 backlog: optional, local only, off by default; check cost and license first (paid credits; usually not redistributable; needs an API key) |
| Other study areas (e.g. Bangkok) | v1.1 backlog / post-v1 |
| Hosted AI API on the public demo | Not planned. Costs money and exposes an endpoint; template explanations ship instead |
| Individual-level health prediction or funding recommendations | Never. Contradicts the screening-index purpose |
| Real-time or automatically refreshed data | Not planned. v1 runs on fixed, documented data vintages |

New ideas that come up mid-project go to the ROADMAP backlog first, not into this list.

## 6. Acceptance

- A requirement is **met** when its milestone's gate (ROADMAP.md) passes **and** at least one test
  or review document demonstrates it.
- Every **P1** requirement must be met by v1.0.0. **P2** items may be trimmed under the ROADMAP flex
  rules; **P3** items may be dropped. Items marked _Stretch_ are not needed to meet a requirement.
- Tests and review docs cite requirement IDs (e.g. a test comment `// FR-10`), so the table below
  fills in as work is done.

| ID | Verified by (test / doc) | Status |
|---|---|---|
| FR-01 | _Week 3 unit test_ | Open |
| … | | |
