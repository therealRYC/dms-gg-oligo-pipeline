# Benchmark: Post Tile Collision Fix (260313)

## Change
Reaction-aware tile DP: removed unnecessary collision constraints.
1. No tile-to-tile path collision (standard Bellman DP, no beam search)
2. No oh1↔oh2 mutual compat check (different enzyme pots)
3. Split alien sets by enzyme (BsaI pot for oh1, BsmBI pot for oh2)

## AKAP11 Results (5706 nt, 1902 codons)

| Segment | Codons | Tiles | max_identity | Geo-mean score | Status |
|---------|--------|-------|--------------|----------------|--------|
| 1 (nt 1-1776) | 592 | 10 | 2 | 0.3186 | SUCCESS |
| 2 (nt 1777-2667) | 297 | 6 | 2 | 0.2802 | SUCCESS |
| 3 (nt 2668-3837) | 390 | 8 | 2 | 0.3561 | SUCCESS |
| 4 (nt 3838-5475) | 546 | 10 | 2 | 0.3216 | SUCCESS |
| 5 (nt 5476-5706) | 77 | 1 | - | - | single-tile |

**Before**: 3/4 multi-tile segments failed at max_identity=2, fell back to max_identity=3 with score=0.
**After**: All 4 multi-tile segments succeed at max_identity=2 with positive scores (0.28-0.36).

## Test Results
- OOGGA tests: 124/124 pass (0 failures)
- Full suite: 5259 pass, 3 pre-existing failures (unrelated to this change)
