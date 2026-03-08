# Plan: Low Set Fidelity Optimization (260308)

## Context

**Problem**: GRIN2A (4395 nt, 25 tiles, 5 SB boundaries) shows min set fidelity = 0.7402 and 3 reactions below 0.90. The worst offenders are early-tile BsmBI reactions (tiles 1-4) which have 5 overhangs — the 3'WT is long (~4000+ nt) and needs 3-4 SB splits, accumulating junction overhangs.

**Root cause**: The current SB boundary DP scores positions by `sum(P_fid × P_eff)` per individual overhang. It doesn't account for **pairwise cross-reactivity** between overhangs that co-occur in the same reaction. Two overhangs that each score well individually can have elevated M[X,Y] in the pairwise ligation matrix, dragging down set fidelity.

**Goal**: Maximize worst-case set fidelity across all reactions. Warn if any reaction falls below 0.90.

## Key Insight: Reaction-Aware Optimization

Each tile has its own independent BsaI and BsmBI reactions. Overhang reuse BETWEEN tiles is fine — only overhangs WITHIN the same reaction must be compatible. The optimization target is: **for each tile's reaction, the overhangs in that specific reaction have high set fidelity**.

### How overhangs accumulate per reaction

| Reaction | Fixed OHs | Tile-specific OH | SB junction OHs in this reaction |
|----------|-----------|------------------|----------------------------------|
| BsaI     | oh_L, oh4 | oh1              | SB boundaries BEFORE this tile   |
| BsmBI    | oh3       | oh2              | SB boundaries AFTER this tile    |

**Extreme tiles are the bottleneck**:
- First tile's BsmBI: ALL SB junction OHs (they're all after it) + oh3 + oh2
- Last tile's BsaI: ALL SB junction OHs (they're all before it) + oh_L + oh4 + oh1
- Middle tiles: split SB OHs between BsaI and BsmBI, fewer per reaction

SB junction OHs must be mutually unique (they all appear together in extreme tile reactions), but tile boundary OHs (oh1, oh2) can be reused across tiles since each tile is independent.

## Design Decisions

1. **SB positions**: Free at any codon boundary (not restricted to tile-end positions). Minimum spacing enforced to prevent tiny blocks (~300 nt min via `min_block_length`).
2. **Tile method**: Both DP and MC implemented, MC uses DP as starting point.
3. **Fidelity floor**: Best achievable. Warn if any reaction falls below 0.90.

## Algorithm

### Phase 1: Fixed overhangs (unchanged)
Select oh_L (gene start), oh3 (PolIII-derived), oh4 (score-selected).

### Phase 2: SB-first Monte Carlo (`search_sb_boundaries_mc`)

Simulated annealing MC for SB boundaries at any codon boundary. Scores by min set fidelity across extreme tile reactions (first tile BsmBI + last tile BsaI). Multiple restarts for robustness.

### Phase 3A: Enhanced DP (`search_tile_boundaries_dp_v2`)

Max-min DP for tile boundaries within SB segments. Partitions gene at SB boundaries, runs sub-DP within each segment, scoring by min(BsaI_set_fid, BsmBI_set_fid).

### Phase 3B: Tile MC (`search_tile_boundaries_mc`)

MC tile optimizer using dp_v2 as initial solution, then SA to move non-SB boundaries.

### Phase 4: Joint refinement (`refine_boundaries_mc`)

Randomly perturbs one tile boundary at a time by ±3 codons, accepting improvements.

## Implementation Status

### Functions added to `R/06_overhang_selection.R`:

| Function | Status | Description |
|----------|--------|-------------|
| `evaluate_sb_config()` | DONE | Score SB config by min set fidelity |
| `search_sb_boundaries_mc()` | DONE | SA-based SB boundary search |
| `search_tile_boundaries_dp_v2()` | DONE | Max-min DP with set fidelity scoring |
| `search_tile_boundaries_mc()` | DONE | MC tile optimizer (DP as initial) |
| `refine_boundaries_mc()` | DONE | Joint tile boundary refinement |

### Tests: `tests/testthat/test-set-fidelity-optimization.R`

46 tests covering all 5 functions + integration. All passing.

### Bugs found and fixed:

1. **eval_tile_config first-tile collision**: First tile oh1 == oh_L is expected, not a collision.
2. **Gene-end palindrome hard rejection**: Last tile oh2 is gene-derived and unavoidable; skip hard filters for gene-edge OHs.
3. **MC init_boundaries extraction**: Used `end_codon - overlap` instead of `start_codon - 1`.

### Remaining work:

- [ ] Integrate into `plan_assembly()` with config option for MC-optimized flow
- [ ] Benchmark on GRIN2A/AKAP11/TRIO (before/after fidelity comparison)
- [ ] Compare Phase 3A (DP) vs 3B (MC) on same SB boundaries
