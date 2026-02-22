# Tabled Refactor: Align DP Boundary Scorer with OOGGA

**Date**: 2026-02-16
**Status**: Tabled (not implementing now)
**File**: `R/06_overhang_selection.R`
**Functions affected**: `precompute_boundary_scores()`, `dp_solve_k()`, `plan_assembly()`

---

## Background

OOGGA (Overhang Optimizer for Golden Gate Assembly; Mukundan & Madhusudhan, bioRxiv 2025.06.16.659877) uses a DP identical in structure to our `dp_solve_k()` but optimizes **actual set fidelity** from the Potapov 2018 pairwise matrix, rather than HF-set membership as a proxy.

## Current Scoring (lines 558-582)

```r
score = 10*(oh1 in HF set) + 10*(oh2 in HF set)   # 0-20 pts, dominates
      + 2.0 * oh1_set_fidelity_with_oh_L            # 0-2 pts
      + 1.0 * oh2_individual_fidelity                # 0-1 pts
      - 5.0 * (penalty if either < 0.80)             # -5 or 0
```

HF membership bonus (up to 20 pts) completely dominates fidelity terms (up to 3 pts). The optimizer finds the globally optimal boundary placement **for maximizing HF-set membership**, not for maximizing set fidelity.

## What OOGGA Does Differently

OOGGA scores each junction by its **fidelity contribution from the pairwise matrix**:

```
f(o_k) = M[o_k, o_k] / sum(M[o_k, o_j] for all o_j in set)
Set Fidelity = product(f(o_k))
```

Since `log(product) = sum(log)`, this decomposes into an additive DP recurrence. OOGGA also supports a tunable **ligation efficiency** weight (absolute ligation rate, not just specificity).

## Comparison Summary

| Aspect | Our DP | OOGGA |
|--------|--------|-------|
| DP structure | `S(k,b)` with parent traceback | Same |
| Multi-K search | Yes | Yes |
| Deterministic / globally optimal | Yes (for its objective) | Yes (for its objective) |
| Scores fidelity directly in DP? | No — HF-set proxy | Yes — pairwise matrix |
| Accounts for reaction context? | Partially (oh1 vs oh_L only) | Fully |
| Validates set fidelity? | Post-hoc only (Phase 6) | During optimization |
| Ligation efficiency? | Not considered | Tunable weight |
| HF set dependency | Heavy (10-pt bonus) | None |

## Proposed Refactor (If Implemented)

### 1. Replace HF-bonus scoring with log-fidelity scoring

In `precompute_boundary_scores()`, replace:

```r
scores[b] <- hf_bonus + 2.0 * oh1_pw + 1.0 * oh2_fid + fid_penalty
```

With something like:

```r
# oh1 scored via set fidelity with oh_L (BsaI reaction, both partners known)
oh1_sf <- compute_set_fidelity(c(oh_L, oh1), bsai_matrix)$set_fidelity
# oh2 scored via individual fidelity (BsmBI partner oh3 not yet known)
oh2_sf <- individual_fidelity(oh2, bsmbi_matrix)
scores[b] <- log(oh1_sf) + log(oh2_sf)
```

### 2. The oh3 Chicken-and-Egg Problem

Our architecture differs from OOGGA's use case: oh2's true set fidelity depends on oh3, which is selected in Phase 4 *after* boundaries are fixed. OOGGA doesn't face this because all its overhangs are gene-derived.

Options:
- **(a) Two-pass approach**: Run DP with individual fidelity for oh2, pick oh3 in Phase 4, then re-score boundaries with true set fidelity and optionally re-run DP. Complexity: 2x runtime, marginal improvement.
- **(b) Use individual fidelity as oh2 proxy**: Since the BsmBI reaction has only 2-3 overhangs (oh2, oh3, possibly superblock junctions), individual fidelity is a reasonable proxy. The set fidelity won't diverge much from individual fidelity in a 2-member set. This is the simpler path.
- **(c) Joint optimization**: Fold oh3 selection into the DP by adding a dimension. Combinatorial explosion — not worth it for a fixed overhang.

Recommendation: **(b)** — use individual fidelity for oh2, set fidelity for oh1.

### 3. Optional: Add Ligation Efficiency Term

From the Potapov 2018 matrix, efficiency for overhang X = `M[X,X] / max(M[Y,Y] for all Y)`. Add as a tunable weight:

```r
scores[b] <- w_fid * (log(oh1_sf) + log(oh2_sf)) + w_eff * (eff(oh1) + eff(oh2))
```

Default `w_eff = 0` to match current behavior; expose in config for users who want it.

### 4. Drop HF-Set Bonus Entirely?

With direct fidelity scoring, the HF-set bonus becomes redundant — overhangs in the HF set will naturally score high because they have high fidelity. Could retain a small bonus (1-2 pts) as a tiebreaker to prefer experimentally validated overhangs when fidelity scores are similar, but it should not dominate.

## Estimated Effort

- Refactor `precompute_boundary_scores()`: ~1 hour
- Add efficiency extraction helper: ~30 min
- Add config params (`w_fid`, `w_eff`, `scoring_method`): ~30 min
- Update tests: ~1 hour
- Validation against current outputs: ~1 hour

Total: ~4 hours

## Risk Assessment

- **Low risk**: The DP structure doesn't change, only the per-boundary score function.
- **Backward compat**: Add `scoring_method = "fidelity"` config param; default to new behavior, allow `"hf_proxy"` for old behavior.
- **Regression check**: Run on test genes and compare set fidelity of chosen boundaries (Phase 6 output) between old and new scoring. New scoring should produce equal or better set fidelity.

## References

- Mukundan & Madhusudhan (2025). OOGGA. bioRxiv 10.1101/2025.06.16.659877
- Potapov et al. (2018). Comprehensive Profiling of Four Base Overhang Ligation Fidelity. ACS Synth Bio 7(11):2665-2674
- Pryor et al. (2020). Enabling one-pot Golden Gate assemblies. PLOS ONE
- NEB SplitSet: github.com/potapovneb/golden-gate (Perl, MCMC-based)
