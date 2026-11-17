# Using Claude on this project

All of these run on your Claude subscription, and they share one usage allowance. None of them
call the paid API unless you set that up on purpose.

## Which tool for which job

| Job | Tool | How |
|---|---|---|
| Write and debug C++/Python, run builds and tests | **Claude Code in VS Code** (WSL window) or `claude` in the Ubuntu terminal | Open `C:\georesilience` through WSL; Claude reads `CLAUDE.md` automatically |
| Plan a week, check a milestone | Claude Code slash commands | `/week-start`, `/milestone-review M1`, `/check-scoring` (in `.claude/commands/`) |
| Bigger changes | Claude Code **plan mode** (Shift+Tab) | Claude proposes a plan; nothing changes until you approve |
| Work on the repo from your phone or browser | **Claude Code on the web** | Connect GitHub in Claude settings; it works in a cloud copy and opens a branch/PR |
| Research data sources, methodology, stats questions | **Claude app** (chat) | Start a Project named GeoResilience, add `docs/plan/project_plan_v1.0.docx` and `docs/ROADMAP.md` as project knowledge |
| Write docs, the evaluation report, the portfolio summary | Claude app | Ask for a doc; paste the finished text back into `docs/` |
| Diagrams | Claude app or Claude Code | Mermaid in markdown (GitHub renders it), like `docs/architecture.md` |
| Weekly reminder / check-in | Claude app scheduled task | Ask Claude to set up a weekly check-in |

## Guardrails (also in CLAUDE.md)

1. **You own the math.** For normalization, scoring, and zonal stats, have Claude write the test
   first, check the expected numbers yourself, then let it implement.
2. **Read every diff** before accepting. Portfolio reviewers will ask you to explain the code.
3. **One week at a time.** Start sessions with `/week-start` so work stays in scope.
4. **Independent check.** Run `/check-scoring` in a *fresh* session so the reviewer hasn't seen the
   implementation.
5. **Secrets.** `.claude/settings.json` blocks reading `.env` and raw data.

## Cost traps

- If `ANTHROPIC_API_KEY` is set in your environment, Claude Code uses that key and you are billed
  per token instead of using your subscription. The env check scripts warn about this.
- Leave usage credits / extra usage off in Claude settings unless you want to pay past your limits.
- The `@claude` GitHub Action (`/install-github-app`) needs an API key or a subscription token stored
  as a repo secret. It is optional; skip it until the project is going well.
- Building the in-app AI explanations on the Claude API is billed separately from the subscription.
  The public demo uses template explanations, so this costs nothing.

## Settings files

| File | Committed? | Purpose |
|---|---|---|
| `CLAUDE.md` | Yes | Project rules and commands Claude loads every session |
| `.claude/settings.json` | Yes | Allowed/blocked commands and files for this repo |
| `.claude/commands/*.md` | Yes | Project slash commands |
| `.claude/settings.local.json` | No (git-ignored) | Your personal overrides |
| `~/.claude/CLAUDE.md` (in WSL home) | No | Preferences for all your projects |
