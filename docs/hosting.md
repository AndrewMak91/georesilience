# Hosting plan: free, public, no surprise bills

## Principle

Nothing that runs publicly needs a paid service or a secret. The C++ engine runs on your machine
(or in GitHub Actions); only its **exported results** are published.

```
your laptop / CI ──(C++ engine)──► results/*.geojson, *.csv  ──commit──► GitHub ──► free host
```

## Options (decide in Week 24)

| Option | Cost | Fits when | Watch out for |
|---|---|---|---|
| **Streamlit Community Cloud** | Free | You want the planned Python/Streamlit dashboard | Free unlimited apps must come from a **public** repo (one private app allowed); ~1 GB RAM; apps sleep after ~12 h idle and wake on visit |
| **GitHub Pages** (static HTML + MapLibre/Leaflet + GeoJSON) | Free for public repos | You want an always-on demo with no server | Weighted-sum sliders must be written in JavaScript; needs its own parity test |
| **Hugging Face Spaces** (CPU basic) | Free tier | Alternative Streamlit host | Also sleeps when idle |
| Private repo, no hosting | Free | Fallback if you don't want it public | Reviewers must run it locally; demo via screenshots/GIF |

**Recommendation:** public repo + Streamlit Community Cloud (matches the plan's stack). Keep the
exported GeoJSON small (simplify tract geometry, round coordinates to ~5 decimals) so it loads fast
within the memory limit.

## Costs that can sneak in — and how this project avoids them

| Risk | Avoidance |
|---|---|
| Hosted AI API called from a public app | Public app ships **template explanations only**. Any LLM feature is local-only and off by default. |
| API key committed to git | `.env` is git-ignored; GitHub secret scanning/push protection on; `CLAUDE.md` forbids reading `.env` |
| Claude Code silently billing an API key | If `ANTHROPIC_API_KEY` is set on your machine, Claude Code uses it instead of your subscription. `scripts/check_env.*` warns if it is set. |
| Plan overflow | Leave "extra usage"/usage credits disabled in Claude settings unless you deliberately want them |
| GitHub Actions minutes | Free for public repos; private repos have a monthly free allowance — keep CI small |
| Large data in git / Git LFS quotas | Raw data stays out of git; only clipped samples are committed |
| Census API | Free; a key is optional for light use. Store it in `.env`, never in code |
