---
description: Run a milestone gate review (e.g. /milestone-review M1)
---

Run the milestone review for $ARGUMENTS using docs/ROADMAP.md.

1. Build and run all tests (`cmake --preset dev && cmake --build --preset dev && ctest --preset dev --output-on-failure`).
2. For each checklist item in that milestone, state Done / Not done / Partially, with evidence
   (file path, test name, or command output).
3. Check the milestone's gate in the table at the top of ROADMAP.md. Say plainly whether it passes.
4. List open risks from docs/risk_register.md that this milestone affects.
5. Draft docs/reviews/$ARGUMENTS.md (deliverables, gate result, defects, risks, next-phase changes)
   and show it to me before saving.

Do not tag a release or mark the milestone complete; I'll do that.
