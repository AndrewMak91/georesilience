# GeoResilience

A C++20 geospatial screening tool that combines public heat, vegetation, and demographic data to
rank geographic units (e.g. census tracts) for further investigation of urban heat mitigation,
tree planting, and cooling infrastructure.

> **Status:** Kickoff (M0). 32-week plan: C++ engine → Python/SQL/ML data science extension → dashboard → release. See [docs/ROADMAP.md](docs/ROADMAP.md).

> **What this is not:** GeoResilience is a transparent *screening index*. It does not predict
> heat-related illness and does not make funding or policy decisions.

## How it works

```
public data ──► C++ engine (GDAL/OGR) ──► validated, scored GeoPackage/GeoJSON ──► dashboard (Python)
                 ingest → validate → join → indicators → normalize → weight → export
```

The C++ engine is the single source of analytical truth. The dashboard only reads exported results.
Details: [docs/architecture.md](docs/architecture.md).

Composite score for unit *i* (weights are non-negative and sum to 1):

```
S_i = wH·H_i + wV·V_i + wG·G_i
H = normalized heat exposure, V = normalized population vulnerability, G = normalized lack of green space
```

## Build (Ubuntu / WSL2)

```bash
cd /mnt/c/georesilience        # or wherever you cloned it
sudo apt install build-essential cmake ninja-build git libgdal-dev gdal-bin
cmake --preset dev
cmake --build --preset dev
ctest --preset dev
./build/dev/georesilience --version
```

Full environment instructions, including Windows notes: [docs/dev_setup.md](docs/dev_setup.md).
Verify your machine with `scripts/check_env.sh` (WSL/Linux) or `scripts/check_env.ps1` (Windows).
Disk usage and how to remove everything afterwards: [docs/teardown.md](docs/teardown.md).

## Repository layout

| Path | Purpose |
|---|---|
| `include/georesilience/`, `src/` | C++ engine (`io/`, `spatial/`, `analytics/`, `cli/`) |
| `tests/` | GoogleTest unit and integration tests |
| `data/sample/` | Small, redistributable sample inputs (raw data is never committed) |
| `docs/` | Roadmap, architecture, data sources, methodology, risks, decisions |
| `scripts/` | Environment checks and GitHub setup helpers |
| `.github/workflows/` | CI: build + tests on every push |

Folders are added only when the current milestone needs them.

## Data sources and attribution

See [docs/data_sources.md](docs/data_sources.md). Every dataset's origin, date, and license are
recorded before it is used.

## License

Code: MIT (see [LICENSE](LICENSE)). Data keeps the license of its original source.
