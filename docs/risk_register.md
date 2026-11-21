# Risk register

Reviewed at weeks 1, 4, 8, 13, 17, 23, 28, 32. Status: Open / Watching / Closed.

| # | Risk | L | I | Mitigation | Status |
|---|---|---|---|---|---|
| R1 | GDAL installation or linking problems | M | H | WSL2 + apt `libgdal-dev`; CI on Ubuntu; `check_env` script | Open |
| R2 | Public datasets hard to combine | H | H | One county, census tracts, `GEOID` join, matching vintages | Open |
| R3 | Data processing takes too long | M | H | Clip to study area; synthetic fixtures for tests | Open |
| R4 | Spatial results incorrect | M | H | Projected CRS for area/distance; QGIS reference checks | Open |
| R5 | Scope creep | H | H | Flex rules in ROADMAP; Priority-3 features last | Open |
| R6 | Statistical interpretation overstated | M | H | Screening-index language everywhere; limitations doc | Open |
| R7 | Dashboard integration slow | M | M | Results contract (Week 24); engine independent | Open |
| R8 | AI answers inaccurate | M | H | Template explanations ship; AI optional, local, grounded | Open |
| R9 | Benchmark not meaningful | L | M | Documented dataset + machine | Open |
| R10 | Licensing/attribution incomplete | L–M | H | Data source register filled at ingestion | Open |
| R11 | Docs rushed at the end | M | H | Each week closes with a docs update | Open |
| R12 | **Raster handling missing from original scope** | H | H | Raster read in Week 3, zonal stats Week 10 | Open |
| R13 | **Unexpected costs** (API, hosting, Claude Code billing an API key) | M | M | `docs/hosting.md`; env check warns on `ANTHROPIC_API_KEY` | Open |
| R14 | **Secrets leaked to public repo** | L | H | `.env` ignored; push protection; Week 26 scan | Open |
| R15 | **Anaconda GDAL/PROJ conflicts with system GDAL** | M | M | Build in WSL with conda deactivated | Open |
| R16 | **ACS small-area estimate unreliability** (worse at block group, ADR 0003) | H | M | Carry MOE; flag CV > 30 %; tract fallback if block-group flags dominate | Open |
| R17 | **Over-reliance on AI-generated code** | M | H | Tests written/reviewed by hand for scoring math; read every diff | Open |
| R18 | **Outcome data unavailable at tract level** (health data often by ZIP/county, suppressed small counts) | H | M | Accept coarser level with areal aggregation; fallback: air-temperature campaign data | Open |
| R19 | **Circular validation** (validating against the same LST used as an input) | M | H | Validate only against independent outcomes; documented in Week 19 | Open |
| R20 | **Spatial leakage in ML evaluation** (random CV overstates accuracy) | M | M | Spatial block cross-validation | Open |
| R21 | **Block → hex allocation error** (each block assigned whole to one hex by internal point; 2020 differential-privacy noise; ACS block-group fields split by population share) | L | M | ADR 0003; conservation test (Week 7); use block counts summed to hexes only; flag low-population hexes; document block-group detail (IR-07); finer within-block allocation in v1.1 | Open |
| R22 | **Scope creep from the tract/hex toggle** | M | M | Deferred to v1.1 backlog; engine kept unit-agnostic | Watching |
