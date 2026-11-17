# Development environment

Your machine is Windows (x64) with Anaconda and VS Code already installed. The recommended setup is
**WSL2 + Ubuntu** for all C++/GDAL work, edited from Windows VS Code. Reasons:

- `apt install libgdal-dev` gives a working GDAL C++ SDK in one command; native Windows GDAL builds
  (vcpkg) take a long time and are the plan's #1 risk.
- The CI runner is Ubuntu, so local == CI.
- Claude Code, CMake, and GDAL tools all behave the same as in tutorials and docs.

## 1. Windows side (one time)

Run in **PowerShell as Administrator**:

```powershell
wsl --install -d Ubuntu-24.04      # reboot if asked, then create a Linux username/password
winget install --id Git.Git -e
winget install --id GitHub.cli -e
winget install --id Microsoft.VisualStudioCode -e   # skip if already installed
winget install --id OSGeo.QGIS_LTR -e               # independent reference checks (Weeks 7, 16)
```

> **VirtualBox note:** you have VirtualBox installed. WSL2 and recent VirtualBox versions coexist,
> but older VirtualBox (< 6.1) can break or run slowly when Hyper-V is on. Update VirtualBox if VMs
> misbehave after installing WSL.

VS Code extensions: **WSL**, **C/C++** (or clangd), **CMake Tools**, **Python**, **Jupyter**,
**Claude Code**.

## 2. Inside Ubuntu (WSL)

```bash
sudo apt update
sudo apt install -y build-essential cmake ninja-build git gdb \
  libgdal-dev gdal-bin libgtest-dev nlohmann-json3-dev clang-format python3-venv
# Claude Code (native installer)
curl -fsSL https://claude.ai/install.sh | bash
# GitHub CLI
sudo apt install -y gh && gh auth login
```

### Where the repo lives

The repo lives at **`C:\georesilience`** on Windows, which is **`/mnt/c/georesilience`** inside WSL.
Same files, two paths. This keeps it easy to find in File Explorer and GitHub Desktop.

```bash
cd /mnt/c/georesilience
code .          # VS Code opens the folder through the WSL extension
```

Trade-off to know about: building from `/mnt/c` is slower than from the Linux home folder. For a
project this size it is seconds, not minutes, so it is fine. If builds ever feel slow, move the
repo to `~/code/georesilience` in WSL; nothing else changes.

Use **one git** for this repo, the WSL one (`git` inside Ubuntu). Mixing Windows git and WSL git on
the same folder causes false "file mode changed" and line-ending diffs. Run once:

```bash
cd /mnt/c/georesilience
git config core.autocrlf false
git config core.fileMode false
```

`.gitattributes` already forces LF line endings so scripts run in Linux.

## 3. Python for M4/M5 (dashboard and analysis)

Use a project-local venv in WSL rather than your Windows Anaconda base:

```bash
python3 -m venv .venv && source .venv/bin/activate
pip install geopandas streamlit pandas matplotlib folium streamlit-folium
```

> **Anaconda caution:** conda ships its own GDAL/PROJ. If a conda environment is active (or conda
> is on PATH) while you build or run the C++ engine, you can get PROJ errors like
> "proj.db not found" or version mismatches. Run `conda deactivate` in the build shell, and run
> `conda config --set auto_activate_base false` inside WSL if you ever install conda there.

## 4. Verify

```bash
./scripts/check_env.sh
cmake --preset dev && cmake --build --preset dev && ctest --preset dev
./build/dev/georesilience --version
```

## Alternative: native Windows (not recommended for this project)

Visual Studio 2022 Build Tools (C++ workload) + vcpkg (`vcpkg install gdal gtest nlohmann-json`) and
configure with `-DCMAKE_TOOLCHAIN_FILE=<vcpkg>/scripts/buildsystems/vcpkg.cmake`. Expect a long
first GDAL build. If you go this way, record it in `docs/decisions/0001-toolchain.md`.

## Recorded versions (fill in Week 2)

| Tool | Version |
|---|---|
| Ubuntu | 24.04 (WSL2) |
| g++ | 13.3.0 |
| CMake | 3.28.3 |
| Ninja | 1.11.1 |
| GDAL | 3.8.4 |
| GoogleTest | Ubuntu system package |
| Python | 3.12.3 |
| Claude Code | 2.1.325 |
