<!-- Created: 2026-03-02 -->
<!-- Last updated: 2026-03-02 — Corrected recommendation: use BsmBI cycling data -->

# Overhang Fidelity Comparison: T4 Static vs Enzyme Cycling

## Purpose

Compare overhang ligation fidelity profiles and HF sets across three
experimental conditions to inform which data source the pipeline should
use for overhang scoring (BUG-008).

## Data Provenance

| Dataset | Source | Condition | Enzyme | Total counts (row 1) |
|---------|--------|-----------|--------|---------------------|
| `t4_25c_18h` | Potapov et al. 2018 | T4 ligase, 25°C, 18h static | N/A (T4) | 4,065 |
| `bsai_cycling` | Pryor et al. 2020, Table S1 | 37°C, 1h cycling | BsaI | 752 |
| `bsmbi_cycling` | Pryor et al. 2020, Table S2 | 37°C, 1h cycling | BsmBI | 908 |

Cross-validation: tatapov Python library matches Pryor 2020 Excel supplements
exactly (0 mismatches across 131,072 cells for BsaI + BsmBI).

## Key Findings

### 1. Cycling data is too sparse for set-level optimization

The BsaI and BsmBI cycling datasets have ~5x fewer total counts than the
T4 18h dataset (median row sum: ~850 vs ~5600). Under cycling, many
off-diagonal (misligation) entries are zero — and **these zeros likely
reflect real biology, not insufficient sequencing depth.** In a cycling
protocol the restriction enzyme re-cuts misligated products, genuinely
eliminating many misligations that occur under T4-only static conditions.
NEB's GetSet tool uses cycling data directly and reports that up to ~20
four-base overhangs achieve perfect fidelity under cycling (Pryor 2020),
consistent with our SA finding 25 overhangs at 1.0000 set fidelity.

Note: the T4 18h matrix is also very sparse (86% zeros vs 94% for
cycling), so both datasets share this characteristic. The cycling data
still has 56 non-zero off-diagonal entries in a typical top-25 submatrix.

### 2. BsaI and BsmBI cycling are nearly identical (rho = 0.977)

Spearman rank correlations of individual P_fid:

| Pair | Spearman rho | p-value |
|------|-------------|---------|
| T4 vs BsaI | 0.805 | 1.9e-59 |
| T4 vs BsmBI | 0.772 | 5.5e-52 |
| BsaI vs BsmBI | **0.977** | 8.0e-172 |

This confirms Pryor et al.'s claim that enzyme choice barely matters for
fidelity rankings. The two cycling datasets are nearly interchangeable.

### 3. T4 static overestimates palindrome fidelity

| Palindrome | P_fid (T4) | P_fid (BsaI) | P_fid (BsmBI) |
|-----------|-----------|-------------|--------------|
| ATAT | 0.954 | 0.814 | 0.793 |
| TATA | 0.953 | 0.886 | 0.881 |
| AATT | 0.935 | 0.820 | 0.801 |
| TTAA | 0.927 | 0.968 | 0.945 |

Under T4 static, 2 palindromes pass the 0.95 threshold; under cycling,
only 1 (BsaI) or 0 (BsmBI) pass. This is consistent with the known issue
that static ligation allows palindromes more time to self-ligate correctly,
inflating their apparent fidelity.

### 4. Far fewer overhangs pass 0.95 threshold under cycling

| Dataset | P_fid >= 0.95 (all) | Non-palindrome |
|---------|-------------------|---------------|
| T4 25°C/18h | 33 | 31 |
| BsaI cycling | 2 | 1 |
| BsmBI cycling | 1 | 1 |

The 0.95 individual fidelity threshold is nearly impossible to meet under
cycling conditions. Only TTAA (for BsaI) and CTAA (for BsmBI) barely clear
it. This means individual-fidelity-based filtering is not useful for the
cycling data.

### 5. SA-optimized HF sets

| Dataset | Best set fidelity | Potapov Set 3 overlap | Notes |
|---------|------------------|----------------------|-------|
| T4 25°C/18h | 0.9978 | 2/25 | Meaningful optimization |
| BsaI cycling | 1.0000 | 1/25 | Trivially perfect (sparse data) |
| BsmBI cycling | 1.0000 | 3/25 | Trivially perfect (sparse data) |

Potapov Set 3 evaluated under T4 data: **0.9805** set fidelity (vs 95.8%
reported in paper — difference likely due to AAAA homopolymer in Set 3
which our SA excludes, and potentially different normalization).

### 6. Top-25 individual fidelity overlap

| Pair | Overlap (of 25) |
|------|----------------|
| T4 ∩ BsaI | 14 |
| T4 ∩ BsmBI | 13 |
| BsaI ∩ BsmBI | 22 |
| Three-way | 13 |

The 13 overhangs in all three top-25 lists:
`AAGA, GAAA, ACAA, CAAA, ATAA, AATA, AGAA, CCAA, CTAA, TCAA, TTTA, TAGA, TTCA`

Notable: these are all A/T-rich, consistent with AT-rich overhangs having
higher fidelity due to weaker base-pairing reducing misligation.

## Practical Recommendation

**Use BsmBI cycling data (Pryor 2020) for overhang scoring in the pipeline.**
This matches the actual assembly conditions (BsmBI cycling protocol) and is
the more conservative choice — T4 static systematically overestimates
fidelity, especially for palindromes. NEB's own GetSet tool offers
enzyme-specific cycling datasets for exactly this reason.

Rationale:

1. **Matches experimental conditions.** The pipeline uses BsmBI Golden Gate
   cycling, not T4 static ligation. The cycling protocol's self-correction
   mechanism is part of the real system, and the BsmBI data captures it.
2. **More conservative.** T4 static overestimates fidelity for most overhangs
   (points above diagonal in scatter plots). Using BsmBI data means any
   overhang that passes our thresholds will perform at least as well in
   the actual reaction.
3. **NEB validates this approach.** The GetSet tool uses cycling data and
   finds ~20 overhangs at perfect fidelity under BsmBI — our SA confirms this.
4. **Palindrome accuracy.** T4 inflates palindrome fidelity (2 pass 0.95 vs
   0 under BsmBI cycling). BsmBI data correctly penalizes palindromes.

**For set optimization:** Since BsmBI cycling yields perfect (1.0) set
fidelity for 25-overhang sets, the SA is less discriminating at this set
size. For sets >20 overhangs (e.g., superblock junctions), T4 data may
provide additional discriminating power as a secondary tiebreaker. But
individual P_fid ranking and palindrome filtering should use BsmBI data.

**For the pipeline's overhang selection module:** Use the BsmBI cycling
matrix for individual P_fid scoring. For HF set pools, the Potapov Table 1
sets remain a good starting point (they perform well under all conditions)
but should be evaluated and filtered using BsmBI cycling fidelity.

## Output Files

| File | Description |
|------|-------------|
| `individual_fidelity_comparison.csv` | P_fid, P_eff for all 256 overhangs × 3 datasets |
| `spearman_correlations.csv` | Pairwise Spearman rho for P_fid |
| `top25_overhangs.csv` | Top-25 by individual P_fid per dataset |
| `palindrome_fidelity.csv` | Palindrome P_fid under all 3 conditions |
| `hf_set_t4_25c_18h.csv` | SA-optimal 25-OH set for T4 data |
| `hf_set_bsai_cycling.csv` | SA-optimal 25-OH set for BsaI cycling |
| `hf_set_bsmbi_cycling.csv` | SA-optimal 25-OH set for BsmBI cycling |
| `optimization_summary.csv` | Set fidelity + Potapov overlap for all |
| `cross_dataset_comparison.csv` | Pairwise overlap of optimal sets |
| `pfid_histograms.pdf` | P_fid distribution per dataset |
| `peff_histograms.pdf` | P_eff distribution per dataset |
| `scatter_t4_vs_bsmbi.pdf` | T4 vs BsmBI fidelity scatter |
| `scatter_bsai_vs_bsmbi.pdf` | BsaI vs BsmBI fidelity scatter |

## Figures

- **pfid_histograms.pdf**: Fidelity distributions. T4 is right-shifted (higher
  fidelity overall). Red dashed line at 0.95 — very few cycling overhangs pass.
- **scatter_t4_vs_bsmbi.pdf**: Points above the diagonal have higher fidelity
  under T4. Palindromes (red triangles) are notably above diagonal. HF Set 3
  members (blue) cluster in the high-fidelity region under both conditions.
- **scatter_bsai_vs_bsmbi.pdf**: Tight clustering along diagonal (rho = 0.977)
  confirms BsaI ≈ BsmBI for overhang fidelity.

## Reproducibility

All random seeds are fixed (base seed = 42). SA: 10 runs × 100K iterations
per dataset, T_start=1.0, alpha=0.9999.
