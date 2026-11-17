# Exit strategy: free up space, archive, or remove everything

Everything this project installs can be removed. Pick the level you need. Run
`scripts\space_report.ps1` first to see where the space is.

| Level | When | Frees | Reversible? |
|---|---|---|---|
| **1. Clean up** | Disk is getting full mid-project | Build output, raw data, caches | Yes: rebuild / re-download |
| **2. Archive** | Project finished, keep a copy | Nothing yet; makes Level 3 safe | — |
| **3. Full removal** | Done, want the space back | Everything (~12–20 GB) | Only via GitHub + reinstall |

---

## Level 1 — Clean up (keeps everything working)

Inside Ubuntu (WSL):

```bash
cd /mnt/c/georesilience
rm -rf build/                      # rebuilt by: cmake --preset dev && cmake --build --preset dev
rm -rf data/raw/ data/interim/     # re-download using the URLs in docs/data_sources.md
rm -rf .venv/                      # recreate with the pip line in docs/dev_setup.md
# PostGIS (from M5), if you want it gone but keep Ubuntu:
# sudo apt remove --purge -y postgresql* postgis* && sudo apt autoremove -y
pip cache purge 2>/dev/null || true
sudo apt-get clean && sudo apt-get autoremove -y
```

Deleting files inside Ubuntu does **not** shrink its virtual disk on Windows. To get that space
back, compact the disk from **PowerShell as Administrator**:

```powershell
wsl --shutdown
# Find the path with scripts\space_report.ps1 (look for ext4.vhdx), then:
diskpart
#   select vdisk file="C:\Users\<you>\AppData\Local\...\ext4.vhdx"
#   attach vdisk readonly
#   compact vdisk
#   detach vdisk
#   exit
```

Option on recent WSL versions: `wsl --manage Ubuntu-24.04 --set-sparse true` makes the disk give
space back automatically from then on.

---

## Level 2 — Archive (do this before Level 3)

Pre-removal checklist. Every box must be checked before deleting anything:

- [ ] `git status` shows nothing to commit
- [ ] `git fetch && git status` says "up to date with 'origin/main'" (nothing unpushed)
- [ ] All branches you care about are pushed: `git branch -vv` shows no "ahead"
- [ ] Release `v1.0.0` exists on GitHub with sample outputs and screenshots attached
- [ ] Every dataset has its source URL in `docs/data_sources.md` (so it can be re-downloaded)
- [ ] Anything only on your machine (notes, notebooks, `.env` values) is saved somewhere else
- [ ] Test the archive: `git clone https://github.com/AndrewMak91/georesilience /tmp/check` works

Optional full snapshot of the Ubuntu environment (large: several GB), to an external or other drive:

```powershell
wsl --export Ubuntu-24.04 D:\backups\georesilience-ubuntu.tar
# restore later with: wsl --import Ubuntu-24.04 D:\wsl\Ubuntu D:\backups\georesilience-ubuntu.tar
```

---

## Level 3 — Full removal

> **Irreversible.** `wsl --unregister` deletes everything inside Ubuntu immediately with no recycle
> bin. Complete the Level 2 checklist first.

**A. Online accounts and hosted pieces**
1. Streamlit Community Cloud (or other host): delete the app.
2. GitHub: decide to keep the repo public (recommended for your portfolio), make it private,
   or archive it (Settings → Archive this repository). Deleting it is optional.
3. GitHub → Settings → Applications: uninstall the Claude GitHub App if you installed it.
4. Delete any API keys you created (Census, Anthropic Console) on those sites.

**B. Ubuntu (WSL)** — PowerShell as Administrator:

```powershell
wsl --list --verbose               # confirm the exact distro name
wsl --unregister Ubuntu-24.04      # deletes the distro and its virtual disk
# Only if you don't use WSL for anything else:
wsl --uninstall
```

**C. Windows apps** (skip any you use for other things — VS Code and Git probably stay):

```powershell
winget uninstall --id OSGeo.QGIS_LTR -e
winget uninstall --id GitHub.cli -e
code --uninstall-extension ms-vscode-remote.remote-wsl
code --uninstall-extension ms-vscode.cmake-tools
code --uninstall-extension ms-vscode.cpptools
code --uninstall-extension anthropic.claude-code
```

**D. The project folder**

```powershell
Remove-Item -Recurse -Force C:\georesilience
```

**E. Check**
- `scripts\space_report.ps1` is gone with the folder, so check free space with:
  `Get-PSDrive C | Select-Object @{n='FreeGB';e={[math]::Round($_.Free/1GB,1)}}`
- Your Windows Anaconda install is untouched: this project never modified it.

What stays after Level 3: the GitHub repo (unless you deleted it), and your Claude account.
