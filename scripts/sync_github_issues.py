#!/usr/bin/env python3
"""Sync weekly checklists from docs/ROADMAP.md into the matching GitHub issue bodies.

docs/ROADMAP.md is the master copy. For every issue whose title matches a roadmap week (or an
M-section with its own checklist), this rewrites the issue body with the current checklist,
including [x] state. Issues missing on GitHub are reported, not created (use
create_github_milestones.py for that).

Usage:  python3 scripts/sync_github_issues.py [--dry-run]
"""
import json
import re
import subprocess
import sys
from pathlib import Path

ROADMAP = Path(__file__).resolve().parent.parent / "docs" / "ROADMAP.md"
DRY = "--dry-run" in sys.argv


def parse(text: str) -> dict:
    sections, cur, in_ms = {}, None, False
    for line in text.splitlines():
        m = re.match(r"^## (M\d) — (.+?)(?: \(.+\))?$", line)
        if m:
            in_ms = True
            cur = f"{m.group(1)} — {m.group(2)}"
            sections[cur] = []
            continue
        if line.startswith("## "):
            in_ms, cur = False, None
            continue
        w = re.match(r"^\*\*(Week \d+ — .+?)\*\*", line)
        if w and in_ms:
            cur = w.group(1)
            sections[cur] = []
            continue
        item = re.match(r"^- \[([ x])\] (.+)$", line)
        if item and cur is not None:
            sections[cur].append(f"- [{item.group(1)}] {item.group(2)}")
    return {k: v for k, v in sections.items() if v}


def main() -> None:
    wanted = parse(ROADMAP.read_text(encoding="utf-8"))
    out = subprocess.run(["gh", "issue", "list", "--state", "all", "--limit", "500",
                          "--json", "number,title,body"], check=True, capture_output=True, text=True).stdout
    issues = {i["title"]: i for i in json.loads(out)}
    for title, items in wanted.items():
        body = "\n".join(items) + "\n\nSource: docs/ROADMAP.md"
        issue = issues.get(title)
        if issue is None:
            print("missing on GitHub (run create_github_milestones.py):", title)
        elif issue["body"].strip() == body.strip():
            print("up to date:", title)
        elif DRY:
            print(f"would update #{issue['number']}: {title}")
        else:
            subprocess.run(["gh", "issue", "edit", str(issue["number"]), "--body", body], check=True)
            print(f"updated #{issue['number']}: {title}")


if __name__ == "__main__":
    main()
