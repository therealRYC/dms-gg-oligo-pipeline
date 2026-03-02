<!-- Created: 2026-03-02 -->
<!-- Last updated: 2026-03-02 — Initial analysis of overhang fidelity across conditions -->

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
T4 18h dataset. Many off-diagonal (misligation) entries are exactly zero,
meaning **any reasonable 25-overhang set achieves perfect (1.0000) set
fidelity** under cycling data. This makes cycling data uninformative for
HF set optimization — it cannot distinguish good from bad overhang sets.

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

**Use T4 25°C/18h data (Potapov 2018) for both individual and set-level
overhang scoring.** Rationale:

1. It has ~5x more counts than cycling data, providing much more statistical
   power to detect rare misligations
2. It is the only dataset that can meaningfully differentiate HF sets
   (cycling data gives trivially perfect sets)
3. Individual fidelity rankings correlate well across conditions (rho > 0.77),
   so T4-optimized sets should also perform well under cycling
4. The T4 data may overestimate palindrome fidelity, but since we already
   exclude palindromes from HF sets, this is not a concern

**For the pipeline's overhang selection module:** Use the T4-based
SA-optimized set (or Potapov Table 1 sets) as the pool of pre-approved
overhangs. Do not mix data sources.

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
