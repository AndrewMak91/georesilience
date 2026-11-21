# ADR 0003 — Population allocation to hexes

**Status:** Accepted (2026-11-19, Week 1). Supersedes the demographic-source row and the Week 7
interpolation consequence of [ADR 0002](0002-study-area.md), and its Amendment 1.

## Context

ADR 0002 moved ACS tract counts to H3 res 8 hexes by area-weighted interpolation. That assumes
people are spread evenly within each tract, so hexes over rail yards, parks, industrial land, and
empty hillsides received residents they don't have, and "heat" meant heat over land rather than heat
where people live.

## Decision

| Concern | Choice |
|---|---|
| Population source | 2020 Census DHC at **block** level (`GEOID20`, 15 digits): total population, age 65+, 65+ living alone |
| Other demographics | ACS 5-year at **block group** level (`GEOID`, 12 digits), only for fields the 2020 Census lacks: poverty (table C17002, ratio of income to poverty level) and no-vehicle households (table B25044, tenure by vehicles available). Fallback: the same tables at tract level if block-group availability fails the Week 5 check |
| Block → hex | All of a block's counts go to the hex containing its TIGER/Line internal point (`INTPTLAT20`, `INTPTLON20`). Blocks are not split |
| Block group → block | ACS block-group counts are split to its blocks by each block's share of the block group's 2020 population, then summed per hex. A block belongs to the block group whose `GEOID` is the first 12 digits of its `GEOID20` (key match, no spatial join) |
| Rates | Computed per hex **after** allocation (sum of numerators / sum of denominators), never by averaging rates |
| Heat (H) | Population-weighted: mean LST per block, averaged per hex weighted by block population. The plain area mean is exported for comparison |
| Exposure | Residents and residents 65+ per hex, exported next to the score, not part of it |

## Alternatives considered

- **Area-weighted tract interpolation** (ADR 0002 original): simplest, but places residents on
  unpopulated land. Rejected.
- **ACS at tract level:** smaller margins of error than block groups, but each tract value would be
  spread over many hexes. Kept only as the fallback.
- **Area-splitting blocks across hexes:** more exact for large blocks, but needs a block × hex overlay
  and still assumes even spread within the block. Most urban blocks are much smaller than a 0.74 km²
  hex, so the gain is small. Not adopted.
- **Dasymetric weighting by impervious surface or building footprints:** best accuracy, but more data
  and time. Deferred to the v1.1 backlog as finer allocation *within* blocks.
- **Esri GeoEnrichment:** cost, licensing, and API-key concerns. Deferred to the v1.1 backlog.

## Consequences

- Allocation is a point-in-polygon join, done in the projected CRS chosen in Week 7 (the same one
  used for area math).
- **Conservation test (Week 7):** hex totals must sum back to block, block-group, and county totals
  within tolerance. A block whose internal point falls in no hex (coast, islands) is reported, never
  silently dropped.
- **Missing values:** a hex with zero residents has no population-weighted H (`std::optional` empty,
  not 0); it is flagged and excluded from ranking. Its area mean is still reported. A block group
  with zero 2020 population cannot be split; its ACS counts are reported as unallocated.
- 2020 block counts carry differential-privacy noise: use them summed to hexes, never shown per block.
- Block-group ACS margins of error are larger than tract MOEs, so more estimates will be flagged
  unreliable (CV > 30 %, R16). MOEs are carried through and hexes with very few residents are flagged.
- Poverty and vehicle values are still block-group detail even when shown per hex (IR-07).
- The engine stays unit-agnostic: the block layer, ID field, and population field come from config.
- Effort: ~1–1.5 h across Weeks 5 and 10 (ROADMAP change 11); block groups instead of tracts add no
  scheduled time beyond the Week 5 availability check.

## Open items — resolved (2026-11-20)

- **ACS block groups:** C17002 and B25044 are published at block group in the 2020–2024 ACS 5-year
  table-based summary file. LA County block-group codes are identical in the 2020, 2024, and 2026
  TIGER/Line files (6,591). The tract fallback is not needed (DS-02).
- **DHC block fields:** all three are published at block level (2020 Census Data Product Crosswalk,
  May 2023): total population = P1; age 65+ = P12 cells 20–25 + 44–49; 65+ living alone = **P19
  cell 3** (one-person households with a person 65+). Chosen over the equivalent H14 cells because
  it is a single cell (DS-09).
