# Architecture

```mermaid
flowchart LR
    subgraph Inputs["Public inputs (data/raw, git-ignored)"]
        B[Tract boundaries<br/>TIGER/Line]
        D[Demographics<br/>ACS tables]
        T[Heat raster<br/>Landsat LST]
        C[Canopy raster<br/>NLCD]
    end

    subgraph Engine["C++20 engine (GDAL/OGR) — source of truth"]
        IO[io<br/>open, read, CRS report]
        VAL[validation<br/>IDs, nulls, geometry]
        SP[spatial<br/>reproject, join, zonal stats]
        AN[analytics<br/>normalize, weight, rank, scenarios]
        CLI[cli<br/>info / prepare / score]
    end

    subgraph Outputs["results/ (committed, small)"]
        G[(GeoPackage)]
        J[GeoJSON + CSV<br/>+ run metadata]
    end

    subgraph Present["Presentation (reads exports only)"]
        DASH[Streamlit dashboard]
        EXP[Template explanations]
        AI[Optional local LLM<br/>off by default]
    end

    B & D & T & C --> IO --> VAL --> SP --> AN --> G & J
    CLI -.drives.-> IO
    J --> DASH --> EXP
    DASH -.optional.-> AI
```

## Boundaries

- **Engine ↔ presentation:** the contract is the exported file schema (`docs/results_contract.md`,
  Week 18). The dashboard never recomputes indicators or normalization.
- **AI:** receives only structured result records and methodology text; it never produces numbers
  that are displayed as data. The app works identically with AI disabled.

## Module responsibilities

| Module | Owns | Must not |
|---|---|---|
| `io` | Opening datasets, metadata, writing outputs | Contain analysis logic |
| `validation` | Quality checks and reports | Modify data silently |
| `spatial` | CRS transforms, joins, zonal statistics | Know about weights |
| `analytics` | Normalization, scoring, scenarios | Do file I/O |
| `cli` | Argument parsing, logging, exit codes | Contain calculations |
