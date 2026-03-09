# SB Boundary Optimization: SplitSet vs OOGGA vs Our SA

**Date**: 2026-03-09
**Research question**: How does our simulated annealing for superblock boundary placement compare to published algorithms (NEB SplitSet, OOGGA), and can we do better?

## Problem Classification

Three distinct problem types in Golden Gate overhang optimization:

| Problem | Variables | Example |
|---------|-----------|---------|
| **Free-variable** (GetSet) | Choose K overhangs from 256 4-mers | Designing synthetic constructs |
| **Position-constrained** (SplitSet/OOGGA/our SA) | Choose K cut positions along a gene | Splitting a gene into assembly fragments |
| **Tile boundary** (dp_v2) | Choose K boundaries within SB segments | Our per-segment tile optimization |

Our SB boundary problem is position-constrained: cut positions determine overhangs via the gene sequence.

## Algorithm Comparison

| Aspect | NEB SplitSet | OOGGA | Our SA |
|--------|-------------|-------|--------|
| **Algorithm** | MCMC (Metropolis) | DP | SA (Metropolis) |
| **Deterministic** | No | Yes | No |
| **Globally optimal** | No | Yes (for its objective) | No |
| **Objective** | Set fidelity (product) | Individual fidelity (decomposable proxy) | min(BsaI set fid, BsmBI set fid) |
| **Iterations** | 10,000 | O(n × W) — instant | 5 × 10,000 = 50,000 |
| **Speed** | ~seconds | ~milliseconds | ~400s for GRIN2A |
| **Reference** | Pryor et al. 2020 PLOS ONE | Mukundan & Madhusudhan 2025 bioRxiv | Custom |

## Key Insight: Set Fidelity vs Individual Fidelity

**True set fidelity** (what we ultimately care about):
```
p(O_i) = M[O_i, O_i] / sum_{j in SET}(M[O_i, O_j])
F_set = product_i(p(O_i))
```
The denominator depends on the ENTIRE set — adding/removing an OH changes fidelity of ALL others. **Non-decomposable** → DP can't optimize this directly.

**Individual fidelity** (OOGGA's proxy):
```
f(O_i) = M[O_i, O_i] / sum_{j in ALL_256}(M[O_i, O_j])
```
The denominator is fixed (all 256 overhangs) — each OH scored independently. **Decomposable** → DP works.

**Why the proxy works**: Under BsmBI cycling conditions, off-diagonal misligation rates are tiny. The dominant term in the denominator is always the correct ligation. So set fidelity ≈ product of individual fidelities, with small corrections for the few overhangs that have non-negligible cross-reactivity.

## Our SA Scoring Function Problem

`evaluate_sb_config()` (line 3822-3872) only checks 2 "extreme" reactions:
- First tile's BsmBI: {oh3, all SB OHs}
- Last tile's BsaI: {oh_L, oh4, all SB OHs}

**What it misses**: tile boundary overhangs (oh1_t, oh2_t) — unknown at SB search time. The actual per-tile set fidelity after dp_v2 can be very different from this proxy.

**Evidence**: Different random seeds produce wildly different final fidelity (GRIN2A: 0.85 vs 1.00 with different seeds). The proxy doesn't predict actual quality.

## Our SB Problem's Extra Complexity

Unlike OOGGA's single-pot problem, our SB overhangs appear in **two** pot types:
- **BsmBI pot** (3' WT block): First tile sees ALL K SB OHs
- **BsaI pot** (5' WT block): Last tile sees ALL K SB OHs

For tiles in intermediate segments, each pot sees a subset of SB OHs (decreasing/increasing by segment position). The score is min over all tile reactions — this depends on tile boundaries (unknown at SB search time).

## Proposed Improvements

### Option A: OOGGA-style DP for SB boundaries
- Use individual fidelity as scoring → DP gives optimal solution instantly
- Validate with true set fidelity post-hoc
- **Pro**: Deterministic, fast, no SA tuning
- **Con**: Individual fidelity ignores pot composition; doesn't consider downstream dp_v2

### Option B: "100 random configs → dp_v2 scoring" (Robert's idea)
- Generate many valid SB configurations (random or DP-seeded)
- For each, run dp_v2 to get ACTUAL tile-level min set fidelity
- Pick the SB config that produces the best downstream result
- **Pro**: Uses the TRUE objective function, not a proxy
- **Con**: 100 × dp_v2_time ≈ 100 × 3-7s ≈ 5-12 min per gene

### Option C: DP initial + short SA refinement
- Use OOGGA-style DP for initial SB positions (instant)
- Refine with short SA using true set fidelity (1000 iterations, ~10s)
- **Pro**: Fast, combines global structure from DP with local optimization from SA
- **Con**: Still uses 2-reaction proxy during SA (unless we run dp_v2 in the scoring loop)

### Option D: Hybrid DP → dp_v2 → multi-start
- DP gives top-N SB configs by individual fidelity (fast, exhaustive)
- Run dp_v2 on top-N → pick best by actual min set fidelity
- N = 10-50 (manageable)
- **Pro**: Best of all worlds — DP for structure, dp_v2 for true scoring
- **Con**: Need to enumerate top-N DP solutions (not standard DP, but k-best paths)

## Key References

1. Potapov V et al. (2018). ACS Synth Biol 7(11):2665-2674. DOI: 10.1021/acssynbio.8b00333. [256×256 fidelity matrix, set fidelity formula, MCMC optimization]
2. Pryor JM et al. (2020). PLOS ONE 15(9):e0238592. PMC7467295. [GetSet/SplitSet MCMC details, temperature calibration]
3. Mukundan S, Madhusudhan MS. (2025). bioRxiv 10.1101/2025.06.16.659877. [OOGGA DP approach, outperforms SplitSet] **PREPRINT**
4. Hoch D et al. (2024). Protein Science 33(10):e5169. PMC11403590. [GGAssembler graph-theoretical approach]
5. Kang S et al. (2024). Nucleic Acids Research 52(19):e95. PMC11514489. [Enhanced GG, genetic algorithm]

## Open Questions

- How much does individual fidelity diverge from set fidelity for our typical SB OH counts (K=2-5)?
- What is dp_v2's runtime per segment in isolation (without SB MC overhead)? Could we afford 100 dp_v2 calls?
- Does the tile-first DP approach (boundary_method="dp" on main) actually perform better than SB-first MC? (Benchmark running)
- Can we access the OOGGA preprint full text for the exact DP recurrence?
