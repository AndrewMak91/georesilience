# GeoResilience Roadmap

32 weeks · ~116 hours · 3–4 h/week. **Progress is tracked by checkboxes, not dates**: the current step
is the first week with unchecked items, however long it takes to get there. Derived from the Project Plan v1.0, with the changes listed in
[Changes from plan v1.0](#changes-from-plan-v10). A milestone is complete when its **acceptance
gate** passes, not when its week ends.

Each week's checklist mirrors a GitHub issue (created by `scripts/create_github_milestones.py`).

| Milestone | Weeks | Hours | Gate (must be true to close) |
|---|---|---|---|
| **M0 Kickoff** | 0 | 2 | Repo on GitHub, CI green, tools verified, study area chosen |
| **M1 Foundation** | 1–4 | 14 | C++/GDAL exe reads a vector *and* a raster file and reports metadata; a clean build from README works |
| **M2 Data pipeline** | 5–8 | 17.5 | Raw → validated, joined GeoPackage via one CLI command, with a quality report |
| **M3 Analytics engine** | 9–13 | 17.5 | Indicators + normalized weighted scores match hand-calculated cases within tolerance |
| **M4 Evaluation** | 14–17 | 14 | ≥3 scenarios compared, rank stability quantified, limitations documented |
| **M5 Data science extension** | 18–23 | 21 | Scores validated against a real outcome with uncertainty; one interpretable spatial-CV ML model; 5 PostGIS queries |
| **M6 Interface** | 24–28 | 17.5 | Public dashboard (free host) shows map, ranks, scenarios, validation findings; values match engine output |
| **M7 Release** | 29–32 | 14 | v1.0.0 tag, tests pass in CI, benchmark, docs complete, demo + write-up published |

---

## M0 — Kickoff (Week 0, today)

> **RESUME HERE (paused 2026-11-16).** M0 decisions are made: **Los Angeles County, H3 res 8**
> (see docs/decisions/0002-study-area.md). Next session:
> 1. Commit the decision files: `git add -A && git commit -m "M0: study area + unit of analysis" && git push`
> 2. Sync the updated weekly checklists to GitHub issues: `python3 scripts/sync_github_issues.py --dry-run`, then without `--dry-run`
> 3. If not done: Settings → Code security → secret scanning + push protection
> 4. Start Week 1 (Claude Code: `/week-start`). Delete this note then.

- [x] Run `scripts/check_env.ps1` (Windows); fix anything marked MISSING
- [x] Run `scripts/check_env.sh` (WSL); fix anything marked MISSING
- [x] Create the GitHub repo `georesilience` and push this scaffold
- [x] Confirm the CI workflow passes on GitHub
- [x] Run `scripts/create_github_milestones.py` to create milestones and weekly issues
- [x] Pick the study area and unit of analysis: **Los Angeles County, H3 res 8** (`docs/decisions/0002-study-area.md`)
- [ ] Set a start date and replace "TBD" in this file
- QGIS install deliberately skipped at M0; it is the first item of Week 7

## M1 — Development foundation (Weeks 1–4)

**Week 1 — Requirements & data scouting** (3.5 h)
- [ ] Finalize MVP requirements checklist in `docs/requirements.md`
- [ ] Fill in the first three rows of `docs/data_sources.md` (boundaries, demographics, heat)
- [x] Decide unit of analysis: H3 res 8 hexes; tracts (11-digit `GEOID`) remain the demographic source (decided at M0)
- [ ] Review `docs/architecture.md` diagram; adjust if needed
- [ ] Open the initial risk review in `docs/risk_register.md`

**Week 2 — C++ / CMake build + CI** (3.5 h)
- [x] `cmake --preset dev && cmake --build --preset dev && ctest --preset dev` passes locally
- [x] `georesilience --version` prints app + GDAL versions
- [x] CI workflow green on GitHub (moved earlier than plan v1.0)
- [x] Record exact compiler / CMake / GDAL versions in `docs/dev_setup.md` (done during setup)

**Week 3 — GDAL vector *and* raster reading** (3.5 h)
- [ ] `georesilience info <path>` opens a vector file: layer count, feature count, geometry type, CRS
- [ ] Same command on a GeoTIFF: size, band count, data type, nodata, CRS, geotransform
- [ ] Missing file / unsupported file → clear error and non-zero exit code
- [ ] Unit tests using tiny fixtures in `tests/data/`

**Week 4 — Refactor & M1 review** (3.5 h)
- [ ] Split I/O (`src/io`) from CLI reporting (`src/cli`)
- [ ] Fresh clone → build → test following only the README
- [ ] Update risk register (build/dependency risks)
- [ ] Tag `v0.1.0` and write `docs/reviews/M1.md`

## M2 — Spatial data engineering pipeline (Weeks 5–8)

**Week 5 — Data acquisition** (3.5 h)
- [ ] Download tract boundaries (TIGER/Line) for the study area
- [ ] Pull ACS demographic table(s) for the same tracts and vintage
- [ ] Get heat layer (Landsat Collection 2 surface temperature) via a **STAC search** (`pystac-client`, e.g. Microsoft Planetary Computer or Earth Search) instead of manual downloads; read the Cloud-Optimized GeoTIFFs with windowed reads (GDAL `/vsicurl/`) clipped to the study area
- [ ] Get canopy (NLCD tree canopy) and impervious surface layers clipped to the study area (impervious is used in M5)
- [ ] Record source, date, units, license, and known limitations for each
- [ ] Commit only small clipped samples to `data/sample/`; keep raw files out of git
- [ ] Create `.venv` with `h3` and `geopandas`; write `scripts/make_h3_grid.py` to generate the H3 res 8 grid over LA County and save `data/interim/h3_r8.gpkg` (ID field `h3_id`)

**Week 6 — Attribute joins & validation** (3.5 h)
- [ ] Join demographics to boundaries on `GEOID`
- [ ] Report duplicates, unmatched records, missing/invalid numbers (never silently zero)
- [ ] Carry ACS margins of error and flag unreliable estimates
- [ ] Tests for duplicate and missing IDs

**Week 7 — CRS & geometry quality** (3.5 h)
- [ ] Install QGIS (skipped at M0): `winget install --id OSGeo.QGIS_LTR -e`, about 2–3 GB
- [ ] Detect missing/unexpected CRS; reproject to one projected CRS for area/distance (e.g. the local UTM zone)
- [ ] Geometry validity check with a documented repair-or-reject policy
- [ ] Test known areas/distances against a reference (QGIS)
- [ ] Area-weighted interpolation of tract counts to hexes (then compute rates per hex); approximate MOE; flag hexes with very few residents
- [ ] Test interpolation: hex totals sum back to tract/county totals within tolerance

**Week 8 — Pipeline integration & M2 review** (3.5 h)
- [ ] `georesilience prepare --config ... --out ...` runs raw → clean hex GeoPackage; unit layer + ID field come from config (unit-agnostic)
- [ ] Logging + quality report written alongside output
- [ ] Integration test on `data/sample/`
- [ ] Start the Python analysis layer: `analysis/requirements.txt` (geopandas, rasterio, xarray/rioxarray, jupyter) and a first notebook that loads the GeoPackage and maps it
- [ ] Tag `v0.2.0`, write `docs/reviews/M2.md`

## M3 — Spatial analytics engine (Weeks 9–13)

**Week 9 — Indicator specification** (3.5 h)
- [ ] `docs/methodology.md`: definition, unit, direction, source for H, V, G
- [ ] Define how canopy % becomes "lack of green space" (G = 1 − canopy share)
- [ ] Missing-data rule per indicator
- [ ] Hand-calculated reference table (5–10 hexes) in `tests/data/reference_scores.csv`

**Week 10 — Zonal statistics & indicators** (3.5 h)
- [ ] Raster zonal mean (heat) and zonal share (canopy) per hex
- [ ] Vulnerability indicator from ACS fields
- [ ] Flag hexes with no valid pixels; exclude unpopulated/forest/desert/water hexes from ranking
- [ ] Tests against a tiny synthetic raster with known answers

**Week 11 — Normalization & scoring** (3.5 h)
- [ ] Min-max and percentile normalization (handle min == max)
- [ ] Weight validation: non-negative, sum to 1 within tolerance
- [ ] Composite score + rank; ties handled deterministically
- [ ] Tests match `reference_scores.csv` within tolerance

**Week 12 — Config, export, reproducibility** (3.5 h)
- [ ] Weights/settings in `config/*.json`
- [ ] Export GeoPackage + GeoJSON + CSV with run metadata (config hash, input dates, engine version)
- [ ] Re-run test: same inputs + config → identical outputs

**Week 13 — Integration & M3 review** (3.5 h)
- [ ] Full run on LA County; inspect top/bottom ranked hexes
- [ ] Spot-check 3 hexes by hand
- [ ] Quick static map for sanity
- [ ] Tag `v0.3.0`, write `docs/reviews/M3.md`

## M4 — Statistical evaluation (Weeks 14–17)

Done in Python (`analysis/`, geopandas / rasterio / xarray, Jupyter). Notebooks read engine exports and
never feed scores back.

**Week 14 — Weighting scenarios** (3.5 h)
- [ ] ≥3 scenario configs (baseline 40/35/25, equal, vulnerability-heavy)
- [ ] Rank comparison table/chart; list tracts that move most

**Week 15 — Indicator relationships & data quality** (3.5 h)
- [ ] Descriptive stats, distributions, outliers
- [ ] Correlations (Spearman) and redundancy check
- [ ] Hotspot analysis of the composite score: Moran's I and LISA clusters (PySAL)
- [ ] Missing-data and MOE effects

**Week 16 — Sensitivity & validation** (3.5 h)
- [ ] Spearman/Kendall rank correlation between scenarios; top-k overlap
- [ ] Monte Carlo weight perturbation (Dirichlet) → rank-interval per tract
- [ ] Independent check of selected outputs in QGIS or GeoPandas

**Week 17 — Evaluation report & M4 review** (3.5 h)
- [ ] `docs/model_validation.md` with charts
- [ ] Limitations register updated (MAUP, ecological fallacy, LST ≠ air temperature, data vintages)
- [ ] Tag `v0.4.0`, write `docs/reviews/M4.md`

## M5 — Data science extension (Weeks 18–23)

Career-focused phase: Python, SQL, statistics, and ML on top of the engine's outputs. Lives in
`analysis/` (notebooks + small Python modules) and `sql/`. Reads engine exports; never writes
scores back.

**Week 18 — Spatial SQL with PostGIS** (3.5 h)
- [ ] Install PostgreSQL + PostGIS in WSL (`sudo apt install postgresql postgis`)
- [ ] Load tracts, indicators, and scores with `ogr2ogr`
- [ ] Write 5 saved queries in `sql/` (e.g. top-10 tracts per county subdivision, tracts within 500 m of a park layer, score summary by income band, spatial join to an outcome layer)
- [ ] Document the schema in `docs/data_dictionary.md`

**Week 19 — External outcome data** (3.5 h)
- [ ] Find a real outcome to validate against: heat-related ER visits or EMS/911 heat calls (state/county health data), or measured air temperature from an urban heat mapping campaign
- [ ] Record it in `docs/data_sources.md`, including its geographic level (tract, ZIP, county) and years
- [ ] Note the circularity trap: measured land surface temperature is already the H input, so it cannot validate the composite score

**Week 20 — Validation against outcomes** (3.5 h)
- [ ] Align geographies (areal interpolation or aggregation if outcomes are by ZIP/county)
- [ ] Compare scores to outcomes: rank correlation, outcome rates by score quintile, map of mismatches
- [ ] Bootstrap confidence intervals; report error and uncertainty plainly
- [ ] Write "How I know the score works (and where it doesn't)" section in `docs/model_validation.md`

**Week 21 — ML: predicting surface temperature** (3.5 h)
- [ ] Features per H3 res 8 hex: tree canopy, impervious surface, land cover shares, NDVI, optionally elevation
- [ ] Baseline linear model vs gradient boosting (scikit-learn / LightGBM)
- [ ] Spatial (block) cross-validation, not random splits; report RMSE/MAE and R²

**Week 22 — ML interpretation** (3.5 h)
- [ ] Feature importance with SHAP or permutation importance; partial dependence for canopy and impervious surface
- [ ] Residual map + Moran's I on residuals (spatial autocorrelation check, PySAL)
- [ ] Plain-language takeaway: e.g. "each 10-point canopy increase is associated with ~X °C cooler surfaces here"

**Week 23 — Notebook polish & M5 review** (3.5 h)
- [ ] Clean, re-runnable notebooks: `analysis/01_eda.ipynb`, `02_validation.ipynb`, `03_ml_lst.ipynb`
- [ ] Add exported validation/ML summaries to the results contract for the dashboard
- [ ] Tag `v0.5.0`, write `docs/reviews/M5.md`

## M6 — Interface and optional AI (Weeks 24–28)

**Week 24 — Results contract & layout** (3.5 h)
- [ ] `docs/results_contract.md`: exact exported fields the dashboard may read
- [ ] Wireframe: map, ranked table, scenario selector, tract detail, validation and ML findings panel
- [ ] Decide host (see `docs/hosting.md`): Streamlit Community Cloud or GitHub Pages

**Week 25 — Map, ranks, charts** (3.5 h)
- [ ] Choropleth with clear legend (colorblind-safe palette)
- [ ] Ranked table, summary chart, methodology/source notes
- [ ] Automated check: dashboard values == exported values

**Week 26 — Scenario controls & explanations** (3.5 h)
- [ ] Predefined scenarios from engine exports
- [ ] Optional custom weights: dashboard does only the weighted sum of engine-exported *normalized* indicators, with a parity test against the engine
- [ ] Per-tract contribution breakdown; two-tract comparison

**Week 27 — Explanations (template first, AI optional)** (3.5 h)
- [ ] Deterministic template explanations ("Tract A ranks above B mainly because…") — this ships publicly
- [ ] Optional: local LLM (e.g. Ollama) or API, *local only*, off by default, grounded in result records
- [ ] Reliability tests: unsupported questions get a limitation statement

**Week 28 — Integration, deploy & M6 review** (3.5 h)
- [ ] Deploy dashboard to the free host; confirm no secrets are required
- [ ] End-to-end demo run
- [ ] Tag `v0.6.0`, write `docs/reviews/M6.md`

## M7 — Testing, performance, release (Weeks 29–32)

**Week 29 — Test hardening** (3.5 h)
- [ ] Coverage of validation, normalization, scoring, invalid weights, missing inputs
- [ ] End-to-end test on sample data in CI

**Week 30 — Benchmark & clean build** (3.5 h)
- [ ] Time each pipeline stage on a documented dataset + machine
- [ ] One justified optimization (or a note why none was needed)
- [ ] Clean build from scratch in a fresh WSL distro or the CI runner

**Week 31 — Documentation & portfolio** (3.5 h)
- [ ] Final README structured as problem → data → method → results → limitations, with screenshots and live demo link
- [ ] Architecture, data dictionary, methodology, validation docs final
- [ ] Portfolio write-up (blog-style) plus a one-page brief for a non-technical reader (e.g. a city planner)

**Week 32 — Release** (3.5 h)
- [ ] Secret scan, license check for redistributed data
- [ ] Tag `v1.0.0` GitHub Release with sample outputs
- [ ] Record a short demo video/GIF
- [ ] Retrospective in `docs/reviews/M7.md`
- [ ] Complete the Level 2 archive checklist in `docs/teardown.md`, then decide: keep the environment or run Level 3 removal

---

## Backlog: v1.1 (minor update after v1.0.0, not a new version)

- Unit toggle: run and view results by census tract **or** H3 (config + dashboard)
- Dasymetric interpolation (weight by developed land / impervious surface)
- Bangkok extension with global datasets (later, post-v1)

Anything new that comes up mid-project goes here first, not into the current milestone.

## Flex rules

- If a week overruns, the next week's lowest-priority item moves to the end of the phase, not the
  next phase.
- If two consecutive weeks slip, cut in this order: AI explanations → custom weight sliders →
  benchmark optimization → Monte Carlo sensitivity. The M5 data science extension is the career
  priority: trim its scope (fewer queries, one model) before cutting it. Never cut tests,
  correctness, or docs.

## Disk space and exit strategy

Budget ~25 GB free (13–21 GB used at peak, mostly WSL, QGIS, raw data, and ~1 GB for PostGIS + ML libraries). Check usage any time
with `scripts\space_report.ps1`. If space runs low mid-project, use Level 1 in
[docs/teardown.md](teardown.md); it keeps everything rebuildable. At the end, archive (Level 2)
before any full removal (Level 3).

## Changes from plan v1.0

1. **Added M0 kickoff** so repo, CI, and tool checks happen before Week 1.
2. **CI moved to Week 2** (the plan listed `.github/workflows/` but never scheduled it).
3. **Raster support added to M1/M2.** Heat (land surface temperature) and tree canopy are usually
   rasters, so zonal statistics are core, not optional. Plan v1.0 scoped only vector/tabular input.
4. **Dashboard weight sliders clarified.** The engine exports normalized indicators; the dashboard
   may only compute the weighted sum, guarded by a parity test. This keeps the plan's rule that the
   interface never reimplements authoritative calculations.
5. **Public demo ships template explanations, not a hosted AI API.** Keeps hosting free and avoids
   a public endpoint spending your API credits. AI stays optional and local.
6. **Free hosting chosen in Week 24 and deployed in Week 28** (see `docs/hosting.md`).
7. **ACS margins of error** are carried through so unreliable estimates can be flagged.
8. **Exit strategy added** (`docs/teardown.md`, `scripts/space_report.ps1`), with an archive
   check in Week 32.
9. **Data science extension added (new M5, +6 weeks / ~21 h)** to build job-market skills on top of
   the C++ engine: Python analysis layer (from Week 8), STAC + Cloud-Optimized GeoTIFFs (Week 5),
   hotspot statistics (Week 15), PostGIS/spatial SQL, validation against real outcomes with
   uncertainty, and one interpretable ML model with spatial cross-validation. Interface and release
   become M6 and M7; the README and write-up are strengthened for hiring managers.
10. **Study area and unit decided at M0:** Los Angeles County, H3 res 8 (ADR 0002). Adds tract → hex
    interpolation to M2 (+~3.5 h). The tract/hex toggle is deferred to the v1.1 backlog to avoid
    scope creep; the engine stays unit-agnostic so the toggle is a small change later.
