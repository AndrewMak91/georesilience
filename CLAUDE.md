# CLAUDE.md — GeoResilience

C++20 geospatial screening engine (GDAL/OGR) + Python analysis, PostGIS, ML, and dashboard. Hobby/portfolio project, 3–4 h/week.
Current phase and tasks: @docs/ROADMAP.md. Architecture: @docs/architecture.md.

## Commands (run in WSL Ubuntu)

- Configure + build: `cmake --preset dev && cmake --build --preset dev`
- Test: `ctest --preset dev --output-on-failure`
- Run: `./build/dev/georesilience --version`
- Format: `clang-format -i src/**/*.cpp include/**/*.hpp tests/**/*.cpp`
- Env check: `./scripts/check_env.sh`

## Progress and deferred setup

- The current step is the first week in docs/ROADMAP.md with unchecked items. Calendar dates don't
  matter; at the start of a session, tell me which week and milestone I'm on.
- Python work lives in `analysis/` and SQL in `sql/`; both read engine exports and never write
  scores back. In ML work, always use spatial block cross-validation (geographic folds, not Census blocks).
- QGIS was not installed during setup. When I reach Week 7 (or any task needing a reference GIS
  check), remind me to install it first: `winget install --id OSGeo.QGIS_LTR -e`.

## Study area and unit (ADR 0002, ADR 0003)

- Los Angeles County; unit of analysis is **H3 res 8** hexes (`h3_id`). Demographics come from
  2020 Census blocks (`GEOID20`) plus ACS block groups (12-digit `GEOID`, poverty/vehicles only;
  tracts as fallback); both are allocated to hexes by block internal point. Heat is
  population-weighted (ADR 0003).
- Keep the engine unit-agnostic: the unit polygon layer and ID field come from config, never hard-coded.
- Do **not** build a tract/hex toggle in v1. It's in the v1.1 backlog in ROADMAP.md. If a request
  would add new scope, point me to the backlog instead.

## How to work with me (the developer is learning — this matters)

- I am building this to learn and to show my own skills. **Explain the approach before writing
  non-trivial code**, and prefer small diffs I can read in one sitting.
- For scoring, normalization, zonal statistics, and validation logic: **write or update the test
  first**, show me the expected values, and let me confirm them before implementing.
- Never change values in `tests/data/reference_*.csv` to make a test pass. If a reference value
  looks wrong, stop and tell me.
- Stay inside the current milestone in ROADMAP.md. If something belongs to a later milestone, note
  it in the issue instead of building it.
- After finishing a task, update the matching checklist item in `docs/ROADMAP.md` and any doc whose
  behaviour changed.

## Learning mode (check the week's _Mode_ line in ROADMAP.md)

- **You write:** I write the code. Explain concepts, point me to the right functions or docs, ask
  guiding questions, and review what I wrote (correctness, tests, style). Do **not** write the
  solution or edit those files unless I say "show me" for a specific part. Small fixes: describe
  them and let me make them.
- **Pair:** explain the approach first, then let me type it, or write a small first piece and let
  me finish. Pause after each step so I can ask questions.
- **Claude writes:** plumbing/boilerplate. Write it in small diffs and walk me through each one.
- Setup steps (installs, editor, debugger): give one step at a time, explain what it does, and let
  me type the commands myself.
- If a week has no _Mode_ line, ask me which mode to use.

## Code rules

- C++20, no compiler extensions. Namespace `georesilience`. Headers in `include/georesilience/<module>/`.
- Module boundaries in docs/architecture.md are strict: `analytics` does no file I/O; `cli` has no math.
- Use GDAL's C++ API (`GDALDataset`, `OGRLayer`, `OGRSpatialReference`); release handles with RAII
  (`GDALDatasetUniquePtr`).
- Missing values are explicit (`std::optional` or a flag), never silently 0.
- Errors: return a result or throw a project exception with a message that names the file/field;
  CLI maps errors to non-zero exit codes.
- Area/distance math only in a projected CRS. Say which CRS in comments and docs.
- New third-party dependency → ask first and record it in docs/decisions/0001-toolchain.md.

## Data and secrets

- Never read, print, or commit `.env` or any file containing keys.
- Raw data lives in `data/raw/` (git-ignored). Only small clipped samples go in `data/sample/`.
- Every dataset must have a row in docs/data_sources.md before code uses it.

## Language for results

GeoResilience is a *screening index*. Never describe outputs as predicting illness or
recommending funding. Use "may warrant further investigation".
