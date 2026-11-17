---
description: Independently re-verify scoring math against hand-calculated references
---

Act as a skeptical reviewer who has not seen the implementation.

1. Read docs/methodology.md and tests/data/reference_scores.csv only.
2. Recompute 3 rows by hand (show the arithmetic), including normalization.
3. Then read the analytics code and tests, and report any mismatch between the methodology,
   the references, and the implementation: direction of indicators, min == max handling,
   weight validation, ties, and missing values.
4. Do not edit any files. Report findings only.

$ARGUMENTS
