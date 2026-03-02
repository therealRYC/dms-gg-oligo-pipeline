# BsaI vs BsmBI Overhang Fidelity Comparison

**Date:** 2026-02-28
**Purpose:** Determine which enzyme-specific pairwise ligation matrix to use for boundary scoring. The pipeline currently uses a built-in T4 ligase (18h) matrix, but we have BsaI- and BsmBI-specific matrices available. Since gene blocks are assembled using both enzymes (BsaI for 5'WT blocks, BsmBI for 3'WT blocks), we need to decide: use one, both, or a conservative composite.

---

## Data Sources

All three matrices are from Potapov et al. 2018 (ACS Synth Bio), processed from the NEB Ligase Fidelity Viewer data. Each is a 256x256 matrix of pairwise ligation counts between all possible 4-nt overhangs, normalized with diagonal = 1000.

| Matrix | File | Condition | Temperature |
|--------|------|-----------|-------------|
| **Built-in (T4)** | `potapov_18h_overhangs.rds` | T4 ligase, 18h incubation | 25°C |
| **BsaI** | `bsai_overhangs.rds` | BsaI + T4, golden gate conditions | 37°C |
| **BsmBI** | `bsmbi_overhangs.rds` | BsmBI + T4, golden gate conditions | 42°C |

## Key Finding: Built-in T4 Data is Dangerously Optimistic

The built-in T4 ligase data dramatically overestimates overhang fidelity compared to actual golden gate conditions:

| Metric | BsaI | BsmBI | Built-in (T4) |
|--------|------|-------|---------------|
| Mean fidelity | 0.656 | 0.649 | 0.924 |
| Median fidelity | 0.656 | 0.638 | 0.943 |
| Overhangs >= 0.95 | 2 | 1 | 117 |
| Overhangs >= 0.90 | 9 | 8 | 186 |
| Overhangs >= 0.80 | 50 | 50 | 256 (all) |

**206 of 256 overhangs** appear "good" (>= 0.80) under built-in T4 conditions but are actually below 0.80 under at least one enzyme-specific condition. The current pipeline's `-5.0` fidelity penalty triggers at built-in fidelity < 0.80 — this threshold catches zero overhangs in practice.

### Worst Overestimates (built-in fidelity - min(BsaI, BsmBI))

| Overhang | BsaI | BsmBI | Built-in | Overestimate |
|----------|------|-------|----------|-------------|
| CGCC | 0.341 | 0.355 | 0.915 | **0.574** |
| CCGC | 0.411 | 0.377 | 0.938 | **0.561** |
| CACC | 0.452 | 0.417 | 0.969 | **0.551** |
| ACGC | 0.437 | 0.448 | 0.969 | **0.532** |
| AGCC | 0.456 | 0.464 | 0.959 | **0.503** |
| CGCA | 0.486 | 0.467 | 0.968 | **0.500** |
| CAGC | 0.504 | 0.482 | 0.974 | **0.493** |
| GCAC | 0.477 | 0.506 | 0.930 | **0.453** |

Note: CGCC, CCGC, CACC, ACGC are all CG-rich non-palindromic overhangs. Under GG conditions, CG-rich overhangs have dramatically worse fidelity than T4-only predictions suggest.

## BsaI vs BsmBI: Very High Agreement

| Correlation | Value |
|-------------|-------|
| Pearson r (individual fidelity) | 0.976 |
| Spearman rho (rank order) | 0.977 |
| Pearson r (off-diagonal pairwise) | 0.991 |

### Set Fidelity Differences Are Negligible

| Overhang Set | BsaI Set Fid | BsmBI Set Fid | Difference |
|-------------|-------------|--------------|-----------|
| CCTC, CTAA, GACA, GCAC, AATC | 0.9840 | 0.9841 | 0.0001 |
| ACAA, TTAA, TAGA, CATA | 0.9955 | 0.9949 | 0.0006 |
| ACAA, CGCG, GATC, TTAA | 0.9986 | 0.9983 | 0.0003 |
| TGTG, ACAA, CACC | 0.9305 | 0.9259 | 0.0045 |
| TAGA, CATA, CTAA, TGAA, ACAA | 0.9930 | 0.9934 | 0.0004 |

Maximum observed set fidelity difference: **0.0045** (< 0.5%). For practical purposes, BsaI and BsmBI matrices give essentially identical set fidelity results.

### Overhangs Where BsaI and BsmBI Disagree on Quality (>= 0.80 threshold)

Only 9 of 256 overhangs cross the 0.80 threshold differently between enzymes:

| Overhang | BsaI | BsmBI | Notes |
|----------|------|-------|-------|
| ACTA | 0.839 | 0.795 | BsaI good, BsmBI marginal |
| ATAT | 0.814 | 0.793 | Palindrome |
| ATTA | 0.814 | 0.782 | In HF Set 3 |
| TAGT | 0.805 | 0.744 | Biggest disagreement |
| TATC | 0.782 | 0.804 | BsmBI good, BsaI marginal |
| TATT | 0.783 | 0.813 | BsmBI good, BsaI marginal |
| TCTC | 0.796 | 0.811 | Both marginal |
| TCTT | 0.814 | 0.798 | Both marginal |
| TTCC | 0.817 | 0.796 | Both marginal |

All 9 are in the 0.74-0.84 range — none are decisively "good" or "bad" under either enzyme. The disagreement is at the boundary of mediocrity.

## Potapov HF Set 3 Under Enzyme-Specific Conditions

The HF Set 3 (25 overhangs) was optimized by Potapov for set fidelity under T4 conditions. Under enzyme-specific GG conditions:

| Metric | BsaI | BsmBI | Built-in (T4) |
|--------|------|-------|---------------|
| Mean individual fidelity | 0.710 | 0.698 | 0.968 |
| Range | 0.477-0.956 | 0.482-0.950 | 0.892-0.996 |
| OHs with fidelity >= 0.80 | 10/25 | 9/25 | 25/25 |
| OHs with fidelity >= 0.90 | 3/25 | 2/25 | 24/25 |

Under GG conditions, most HF Set 3 members have mediocre individual fidelity (0.50-0.75). Their value lies in pairwise orthogonality (low cross-reactivity), which is still good under both BsaI and BsmBI conditions.

## Recommendation

### Use BsmBI as the primary scoring matrix

**Rationale:**
1. **BsaI and BsmBI agree to r=0.976** — the choice barely matters for individual fidelity scoring
2. **Set fidelity differences are < 0.5%** — negligible for practical purposes
3. **BsmBI is slightly more conservative** (lower mean: 0.649 vs 0.656) — scoring by BsmBI gives a tiny safety margin for both reactions
4. **BsmBI is the enzyme used in the more complex reaction** — the Level 1b (3'WT + cassette) BsmBI reaction has more overhangs (tile oh2 + SB boundaries + oh3) than the BsaI reaction (oh_L + tile oh1 + SB boundaries + oh4), making it the fidelity bottleneck
5. **One matrix simplifies the code** — no need to maintain separate scoring for 5'WT vs 3'WT blocks

### Switch from built-in T4 to BsmBI for boundary scoring

The current built-in T4 data is unsuitable for boundary scoring:
- It misranks 206/256 overhangs relative to actual GG conditions
- The biggest overestimates (0.50-0.57) are for CG-rich overhangs that the pipeline currently considers excellent
- The low-fidelity penalty (`< 0.80`) catches zero overhangs under T4 data but should catch ~206 under GG data

**Implementation:** In `precompute_boundary_scores()` and `oogga_score()`, load `bsmbi_overhangs.rds` instead of `potapov_18h_overhangs.rds` for the individual fidelity lookup. Keep the T4 data available for legacy/comparison purposes. Continue using the BsaI pairwise matrix for `compute_set_fidelity()` on BsaI reactions and BsmBI pairwise matrix for BsmBI reactions (already supported).

### Update fidelity threshold

With BsmBI-specific data, the current 0.95 fidelity threshold is nearly impossible to meet (only 1 overhang qualifies). Suggested new thresholds:
- **Overhang quality scoring:** Use continuous OOGGA score (already weighted by fidelity), no hard threshold
- **Low-fidelity penalty:** Change from `builtin < 0.80` to `bsmbi < 0.50` (catches the truly awful overhangs: 27 CG-rich + some palindromes)
- **HF set bonus:** Keep Potapov Set 3 bonus — their pairwise orthogonality is still valuable even though individual fidelities are lower under GG conditions
