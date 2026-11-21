# Architecture

```mermaid
flowchart LR
    subgraph Inputs["Inputs"]
        CFG[Config<br/>config/*.json<br/>unit layer, ID field, weights]
        U[Unit grid<br/>H3 res 8 GeoPackage<br/>data/interim, from make_h3_grid.py]
        BL[2020 blocks + internal points<br/>TIGER/Line]
        P[Block counts<br/>2020 Census DHC]
        D[Poverty, vehicles<br/>ACS block groups + MOE]
        T[Heat raster<br/>Landsat LST, remote COG via STAC]
        C[Canopy raster<br/>NLCD]
    end

    subgraph Engine["C++20 engine (GDAL/OGR) — source of truth"]
        IOR[io read<br/>open, read, CRS report]
        VAL[validation<br/>IDs, nulls, geometry]
        SP[spatial<br/>reproject, join, block → hex allocation,<br/>zonal stats]
        AN[analytics<br/>normalize, weight, rank, scenarios]
        IOW[io write<br/>write outputs]
        CLI[cli<br/>info / prepare / score]
    end

    subgraph Interim["data/interim (git-ignored)"]
        PG[(Prepared hex GeoPackage)]
        QR[Quality report]
    end

    subgraph Outputs["results/ (committed, small)"]
        G[(GeoPackage)]
        J[GeoJSON + CSV<br/>+ run metadata, exposure columns]
        S[Validation + ML summaries]
    end

    subgraph Analysis["Python analysis + SQL (reads exports, never writes scores)"]
        OUT[Outcome data<br/>DS-07]
        IMP[Impervious raster<br/>DS-06]
        NB[analysis/<br/>validation, hotspots, ML with spatial CV]
        DB[(PostGIS + sql/)]
    end

    subgraph Present["Presentation (reads exports only)"]
        DASH[Streamlit dashboard]
        EXP[Template explanations]
        AI[Optional local LLM<br/>off by default]
    end

    CFG & U & BL & P & D & T & C --> IOR
    IOR --> VAL --> SP --> AN --> IOW
    IOW -- prepare --> PG & QR
    PG -- score --> IOR
    IOW -- score --> G & J
    CLI -.drives.-> IOR & IOW
    G & J --> NB
    G --> DB
    OUT & IMP --> NB
    NB --> S
    J & S --> DASH --> EXP
    DASH -.optional.-> AI
```

## Boundaries

- **Engine ↔ presentation:** the contract is the exported file schema (`docs/results_contract.md`,
  Week 24). The dashboard never recomputes indicators or normalization.
- **AI:** receives only structured result records and methodology text; it never produces numbers
  that are displayed as data. The app works identically with AI disabled.

- **Unit of analysis:** any polygon layer + ID field named in config. v1 uses an H3 res 8 grid
  generated once in Python (`scripts/make_h3_grid.py`); the C++ engine has no H3 dependency.
- **Population allocation (ADR 0003):** `spatial` assigns each 2020 block to the unit containing its
  internal point and splits ACS block-group counts to blocks by population share. The block layer,
  ID, and population fields come from config, so allocation works for any unit layer.

## Module responsibilities

| Module | Owns | Must not |
|---|---|---|
| `io` | Opening datasets, metadata, writing outputs | Contain analysis logic |
| `validation` | Quality checks and reports | Modify data silently |
| `spatial` | CRS transforms, joins, zonal statistics | Know about weights |
| `analytics` | Normalization, scoring, scenarios | Do file I/O |
| `cli` | Argument parsing, logging, exit codes | Contain calculations |
