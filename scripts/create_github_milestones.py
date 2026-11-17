#!/usr/bin/env python3
"""Create GitHub milestones (M0-M6) and one issue per week from docs/ROADMAP.md.

Safe to re-run: existing milestones and issues with the same title are skipped.
Requires the GitHub CLI, logged in (`gh auth login`), run from inside the repo.

Usage:  python3 scripts/create_github_milestones.py [--dry-run]
"""
import json
import re
import subprocess
import sys
from pathlib import Path

ROADMAP = Path(__file__).resolve().parent.parent / "docs" / "ROADMAP.md"
DRY = "--dry-run" in sys.argv


def gh(*args: str) -> str:
    if DRY and args[0] != "api" and args[:2] != ("issue", "list") and args[:2] != ("repo", "view"):
        print("DRY:", "gh", *args)
        return ""
    return subprocess.run(["gh", *args], check=True, capture_output=True, text=True).stdout


def parse(text: str):
    milestones, issues = [], []
    ms = None
    cur = None
    for line in text.splitlines():
        m = re.match(r"^## (M\d) — (.+?)(?: \((.+)\))?$", line)
        if m:
            ms = f"{m.group(1)} {m.group(2)}"
            milestones.append(ms)
            cur = {"title": f"{m.group(1)} — {m.group(2)}", "milestone": ms, "items": []}
            issues.append(cur)
            continue
        if line.startswith("## "):
            ms, cur = None, None
            continue
        w = re.match(r"^\*\*(Week \d+ — .+?)\*\*", line)
        if w and ms:
            cur = {"title": w.group(1), "milestone": ms, "items": []}
            issues.append(cur)
            continue
        item = re.match(r"^- \[ \] (.+)$", line)
        if item and cur is not None:
            cur["items"].append(item.group(1))
    return milestones, [i for i in issues if i["items"]]


def main() -> None:
    milestones, issues = parse(ROADMAP.read_text(encoding="utf-8"))
    repo = json.loads(gh("repo", "view", "--json", "nameWithOwner"))["nameWithOwner"]

    existing = {m["title"] for m in json.loads(gh("api", f"repos/{repo}/milestones?state=all&per_page=100") or "[]")}
    for title in milestones:
        if title in existing:
            print("skip milestone:", title)
        else:
            gh("api", f"repos/{repo}/milestones", "-f", f"title={title}")
            print("created milestone:", title)

    have = {i["title"] for i in json.loads(gh("issue", "list", "--state", "all", "--limit", "500", "--json", "title") or "[]")}
    for issue in issues:
        if issue["title"] in have:
            print("skip issue:", issue["title"])
            continue
        body = "\n".join(f"- [ ] {t}" for t in issue["items"]) + "\n\nSource: docs/ROADMAP.md"
        gh("issue", "create", "--title", issue["title"], "--body", body, "--milestone", issue["milestone"])
        print("created issue:", issue["title"])


if __name__ == "__main__":
    main()
