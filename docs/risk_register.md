# Risk register

Reviewed at weeks 1, 4, 8, 13, 17, 23, 28, 32. Status: Open / Watching / Closed.

| # | Risk | L | I | Mitigation | Status |
|---|---|---|---|---|---|
| R1 | GDAL installation or linking problems | M | H | WSL2 + apt `libgdal-dev`; CI on Ubuntu; `check_env` script | Watching |
| R2 | Public datasets hard to combine | H | H | One county; 2020-based geography with `GEOID20` (blocks) and 12-digit `GEOID` (block groups) joins; LA County tract and block-group codes verified identical in TIGER 2020/2024/2026 (ADR 0003, DS-01/02) | Open |
| R3 | Data processing takes too long | M | H | Clip to study area; synthetic fixtures for tests | Open |
| R4 | Spatial results incorrect | M | H | Projected CRS for area/distance; QGIS reference checks | Open |
| R5 | Scope creep | H | H | Flex rules in ROADMAP; Priority-3 features last | Open |
| R6 | Statistical interpretation overstated | M | H | Screening-index language everywhere; limitations doc | Open |
| R7 | Dashboard integration slow | M | M | Results contract (Week 24); engine independent | Open |
| R8 | AI answers inaccurate | M | H | Template explanations ship; AI optional, local, grounded | Open |
| R9 | Benchmark not meaningful | L | M | Documented dataset + machine | Open |
| R10 | Licensing/attribution incomplete | L–M | H | Data source register filled at ingestion; licenses and citations recorded for DS-01/02/03/09/10 (Week 1) | Open |
| R11 | Docs rushed at the end | M | H | Each week closes with a docs update | Open |
| R12 | **Raster handling missing from original scope** | H | H | Raster read in Week 3, zonal stats Week 10 | Open |
| R13 | **Unexpected costs** (API, hosting, Claude Code billing an API key) | M | M | `docs/hosting.md`; env check warns on `ANTHROPIC_API_KEY` | Watching |
| R14 | **Secrets leaked to public repo** | L | H | `.env` ignored; push protection; Week 32 secret scan | Open |
| R15 | **Anaconda GDAL/PROJ conflicts with system GDAL** | M | M | Build in WSL with conda deactivated | Watching |
| R16 | **ACS small-area estimate unreliability** (worse at block group, ADR 0003) | H | M | Carry MOE; flag CV > 30 %; tract fallback if block-group flags dominate | Open |
| R17 | **Over-reliance on AI-generated code** | M | H | Tests written/reviewed by hand for scoring math; read every diff | Open |
| R18 | **Outcome data unavailable at fine geography** (hex/tract; health data often by ZIP/county, suppressed small counts) | H | M | Accept coarser level with areal aggregation; fallback: air-temperature campaign data | Open |
| R19 | **Circular validation** (validating against the same LST used as an input) | M | H | Validate only against independent outcomes; documented in Week 19 | Open |
| R20 | **Spatial leakage in ML evaluation** (random CV overstates accuracy) | M | M | Spatial block cross-validation | Open |
| R21 | **Block → hex allocation error** (each block assigned whole to one hex by internal point; 2020 differential-privacy noise; ACS block-group fields split by population share) | L | M | ADR 0003; conservation test (Week 7); use block counts summed to hexes only; flag low-population hexes; document block-group detail (IR-07); finer within-block allocation in v1.1 | Open |
| R22 | **Scope creep from the tract/hex toggle** | M | M | Deferred to v1.1 backlog; engine kept unit-agnostic | Watching |
| R23 | **Mixed data vintages** (2020 Census population weights, ACS 2020–2024, summer 2026 LST): new development since 2020 is missing from the weights | M | M | Record every vintage (DS rows, IR-02); state the mismatch in IR-07 limitations; report ACS counts that can't be allocated (ADR 0003) | Open |
| R24 | **2026 block file differs from the 2020 block set** (fields or blocks not matching DHC; not yet verified) | L | M | Week 5 check of `GEOID20`, `INTPTLAT20`/`INTPTLON20` and the LA County block set against DHC; fall back to the 2020 file (DS-10) | Open |
| R25 | **Census Data API now requires a key** (brings key handling into the repo) | M | M | Use the bulk summary files (no key); download the raw files in Week 5 and keep them in `data/raw/` with their URLs recorded; if bulk files are retired, fall back to the API with the key in `.env` only, never committed (R14) | Watching |
| R26 | **Landsat Collection 3 released mid-project** (Collection 2 superseded under the newest-vintage rule) | L–M | M | Record scene IDs and collection in DS-03; decide in Week 5, with better information, how to handle a Collection 3 release | Open |
| R27 | **Too few LST pixels per small block** for population-weighted heat (30 m pixels resampled from 100 m thermal; many urban blocks are small) | H | M | Documented in `data_sources.md` ("Heat resolution vs block size"); define the per-block LST method in Week 9 methodology; flag blocks with no valid pixel (missing, not 0); test with the Week 10 synthetic raster | Open |

## Review log

### Week 1 — 2026-11-20

- **Watching** (mitigation in place and working): R1 and R15 (local build, 2/2 tests and the last
  three CI runs pass with GDAL 3.8.4); R13 (`check_env.sh` warns when `ANTHROPIC_API_KEY` is set);
  R25 (bulk files need no key; re-verified 2026-11-20).
- **Updated:** R2 mitigation now reflects block/block-group joins and verified 2020-based codes;
  R7 contract week corrected to 24; R10 notes licenses recorded for five datasets; R14 scan week
  corrected to 32 (matches ROADMAP); R16 and R21 rewritten for ADR 0003; R18 wording no longer
  tract-only.
- **New** from Week 1 decisions (ADR 0003, newest vintages): R23 mixed vintages, R24 2026 block
  file unverified, R25 Census API key, R26 Landsat Collection 3, R27 small blocks vs LST pixels.
- **Decided:** R25 — Census data via bulk files, not the API (note in `data_sources.md`); keep the
  Week 5 raw downloads in `data/raw/` with URLs recorded, and fall back to the API (key in `.env`
  only) if bulk files are retired. R26 —
  handling of a Collection 3 release decided in Week 5. R27 — limitation documented in
  `data_sources.md`; method set in Week 9.
- **Open questions:** R16 fallback trigger ("dominate") has no threshold yet.
- Next review: Week 4.
