# ADR 0001 — Toolchain

**Status:** Proposed (accept in Week 2)

## Decision

| Concern | Choice | Why |
|---|---|---|
| OS for development | WSL2 Ubuntu 24.04 | One-command GDAL SDK; matches CI |
| Compiler | GCC 13+ (C++20) | Ubuntu default |
| Build | CMake ≥ 3.22 + Ninja, `CMakePresets.json` | Same commands locally and in CI |
| Geospatial | GDAL/OGR (system package), GEOS via OGR | Plan requirement |
| Tests | GoogleTest (system package, FetchContent fallback) | Plan requirement |
| Config | JSON via nlohmann/json | Header-only, available via apt and vcpkg |
| CLI parsing | Hand-written until it hurts; then CLI11 | Minimize dependencies early |
| Formatting | clang-format (`.clang-format`) | Consistent diffs |
| Python | venv + pip (dashboard and analysis only) | Avoid conda/GDAL conflicts |

## Consequences

- Windows-native builds are not supported in v1; documented as a future option.
- New dependencies require a note here.
