# First push to GitHub (github.com/AndrewMak91)

Run in Ubuntu (WSL). Do this once.

This project uses a **fine-grained personal access token** owned by your personal account. It can
only act on repos owned by `AndrewMak91`, so any work organizations you belong to stay out of
reach, whatever their settings. Never paste the token into a chat or commit it.

## 1. Clear any earlier login

```bash
gh auth logout 2>/dev/null; gh auth status     # should say you are not logged in
```

## 2. Create the token (github.com)

Profile picture → **Settings** → **Developer settings** → **Personal access tokens** →
**Fine-grained tokens** → **Generate new token**

| Field | Value |
|---|---|
| Token name | `georesilience-wsl` |
| Expiration | 90 days (renew when it expires) |
| **Resource owner** | **`AndrewMak91`** (not any work organization) |
| Repository access | All repositories (owned by you; needed to create the repo; narrow to `georesilience` later) |
| Repository permissions (Read and write) | Administration, Contents, Issues, Pull requests, Workflows |

Generate, then copy the token (it's shown only once).

## 3. Log in with the token

```bash
gh auth login
# GitHub.com → HTTPS → Yes (authenticate Git) → Paste an authentication token
```

## 4. Verify only your account is reachable

```bash
gh auth status
gh repo list          # should list only AndrewMak91 repos
```

On github.com → Settings → Applications → **Authorized OAuth Apps**: if **GitHub CLI** appears from
an earlier attempt, click **Revoke**. Do not grant organization access anywhere.

## 5. Identify yourself to git (keep your email private)

Use your GitHub noreply address (Settings → Emails), e.g. `12345678+AndrewMak91@users.noreply.github.com`.

```bash
git config --global user.name  "Andrew Mak"
git config --global user.email "YOUR_NOREPLY_EMAIL"
```

## 6. First commit and push

```bash
cd /mnt/c/georesilience
git init -b main
git config core.autocrlf false
git config core.fileMode false
git add .
git commit -m "M0: project scaffold, roadmap, build, CI, Claude Code setup"

gh repo create AndrewMak91/georesilience --public --source=. --push \
  --description "C++20 geospatial heat-resilience screening engine (GDAL) + Python data science"
# Prefer private for now? Swap --public for --private; you can flip it later in repo Settings.
```

## 7. Milestones and weekly issues

```bash
python3 scripts/create_github_milestones.py --dry-run   # preview
python3 scripts/create_github_milestones.py
```

## 8. On github.com

1. **Actions** tab: CI should go green within a few minutes.
2. **Settings → Code security**: turn on secret scanning and push protection.
3. Optional: edit the token to **Only select repositories → georesilience** now that the repo exists.
4. Later, if you connect GitHub to Claude: install the Claude GitHub App on your personal account
   only, with **Only select repositories → georesilience**.

## Everyday loop

```bash
git switch -c week-03-gdal-info      # one branch per week
# ...work...
git add -A && git commit -m "Week 3: info command for vector and raster"
git push -u origin HEAD
gh pr create --fill                  # CI runs on the PR; merge when green
git switch main && git pull
```

Reference an issue in a commit or PR (`Closes #4`) to tick it off automatically.

## When the token expires

Generate a new one with the same settings, then `gh auth login` again (step 3).
