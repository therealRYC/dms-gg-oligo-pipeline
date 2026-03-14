# Plan: Switch OOGGA Cross-K Scoring to Raw Product

**Date:** 2026-03-14
**Status:** Completed

## Context

2x2 factorial benchmark (narrow/wide K range x geo_mean/raw scoring) on AKAP11 showed:
- Scoring method is the only variable that matters (raw product: 31 tiles vs geo_mean: 35 tiles)
- Wide K range is 6x slower with zero benefit
- Raw product embeds soft parsimony: extra boundaries must earn their keep

## Steps

1. Remove `k_scoring` and `k_range_mode` from `search_sb_boundaries_oogga()` - hardcode raw + narrow
2. Remove from `search_tile_boundaries_oogga()` - same
3. Remove from `tile_segments_oogga()` - remove pass-through
4. Remove from `plan_assembly()` - remove config unpacking + pass-through
5. Add historical note to benchmark script
6. Write brainstorm file with decision rationale
7. Regression test (pipeline + unit tests)
8. Notebook entry

## Key Files

- `R/06b_oogga_dp.R` — 3 functions modified
- `R/06_overhang_selection.R` — config unpacking + 2 call sites
- `scripts/bench_k_handling.R` — header note
- `Brainstorm/2026-03-14_k-scoring-method.md` — decision rationale
- `NOTEBOOK.md` — Entry 42
