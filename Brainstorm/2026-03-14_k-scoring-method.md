# K-Scoring Method Decision: Raw Product vs Geometric Mean

**Date:** 2026-03-14
**Context:** OOGGA DP cross-K scoring for superblock and tile boundary selection

## Research Question

When comparing DP solutions across different K values (number of internal boundaries), should we use geometric mean (`score^(1/K)`) or raw product scoring to pick the best K?

## Key Findings

### 2x2 Factorial Benchmark (AKAP11, 5706 nt)

| Condition | Scoring | K Range | SB K | Tiles | Min Fid | Time |
|-----------|---------|---------|------|-------|---------|------|
| A (baseline) | geo_mean | narrow | 4 | 35 | 0.902 | 59s |
| B | geo_mean | wide | 4 | 35 | 0.902 | 367s |
| C | raw | narrow | 3 | 31 | 0.866 | 59s |
| D | raw | wide | 3 | 31 | 0.866 | 373s |

### Scoring method is the only variable that matters
- **A = B** (narrow vs wide with geo_mean: identical results)
- **C = D** (narrow vs wide with raw: identical results)
- **A != C** (geo_mean vs raw with same K range: different results)

### Raw product wins on the metrics that matter
- **Fewer fragments**: 31 tiles vs 35 (fewer assembly junctions = fewer failure points)
- **Higher total assembly probability**: 0.038 vs 0.022 (raw product of all junction scores)
- **Modest min-fidelity cost**: 0.866 vs 0.902 (both well above NEB's ~0.80 threshold)

### Wide K range is pure waste
- 6x slower (367s vs 59s) with zero benefit
- For both scoring methods, narrow range finds the same optimum

## Why Raw Product is the Right Choice

Geometric mean normalizes by K, making K=3 and K=5 "fairly comparable." But this removes the natural penalty for adding boundaries. In molecular biology terms:

1. **Each junction is a failure point** — more cuts = more chances for ligation failure
2. **Raw product = total assembly probability** — the product of all junction fidelities is literally the probability that all junctions ligate correctly
3. **Soft parsimony** — extra boundaries only get chosen if they *improve* the total product, meaning each new cut must earn its keep by enabling higher-quality junctions elsewhere

Geometric mean artificially inflates the attractiveness of adding more boundaries, which is why it picks K=4 (35 tiles) instead of K=3 (31 tiles).

## Decision

- **Hardcode raw product scoring** — remove `k_scoring` parameter
- **Hardcode narrow K range** — remove `k_range_mode` parameter
- Both were experimental infrastructure for the benchmark, not production options
- Implementation: commit `730b132` removes params from `search_sb_boundaries_oogga()`, `search_tile_boundaries_oogga()`, `tile_segments_oogga()`, and `plan_assembly()`

## Open Questions

None — this decision is clear-cut. If a future gene shows different behavior, the benchmark script and this document provide the full context for revisiting.
