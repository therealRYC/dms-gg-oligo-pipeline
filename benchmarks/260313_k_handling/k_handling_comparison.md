# K-Handling Method Comparison: 2×2 Factorial

**Date:** 2026-03-14 00:08:30

## Setup

- **Method:** `oogga_two_pass` (SB-first → per-segment tile DP)
- **Gene:** AKAP11 (5706 nt / 1902 codons)
- **Downstream cassette:** WPRE + spacer + bGH polyA + PolIII (1095 nt)
- **Tile size budget:** 234 nt
- **Beam width:** 10
- **max_identity:** 2

## Factorial Design

| Condition | K Range | Scoring | What it tests |
|-----------|---------|---------|---------------|
| A (current baseline) | Narrow | Geometric mean | Current behavior |
| B | Wide (all feasible) | Geometric mean | Wider K range with geo mean |
| C | Narrow | Raw product | Scoring method alone |
| D (OOGGA-style) | Wide (all feasible) | Raw product | Full OOGGA approach |

## Results

| Condition | K Range | K Score | SB K | Tiles | SBs | Min Fid | Mean Fid | SB Raw Score | Time (s) |
|-----------|---------|---------|------|-------|-----|---------|----------|--------------|----------|
| A_narrow_geo | narrow | geo_mean | 4 | 35 | 5 | 0.9020 | 0.9965 | 0.0215431 | 58.6 |
| B_wide_geo | wide | geo_mean | 4 | 35 | 5 | 0.9020 | 0.9965 | 0.0215431 | 366.8 |
| C_narrow_raw | narrow | raw | 3 | 31 | 4 | 0.8662 | 0.9962 | 0.0382331 | 59.4 |
| D_wide_raw | wide | raw | 3 | 31 | 4 | 0.8662 | 0.9962 | 0.0382331 | 372.9 |

## Per-Segment Tile Boundaries

| Condition | Seg 1 | Seg 2 | Seg 3 | Seg 4 | Seg 5 |
|-----------|------|------|------|------|------|
| A_narrow_geo | 9 | 5 | 7 | 9 | 0 |
| B_wide_geo | 9 | 5 | 7 | 9 | 0 |
| C_narrow_raw | 9 | 8 | 8 | 2 | ? |
| D_wide_raw | 9 | 8 | 8 | 2 | ? |

## Key Comparisons

### A_narrow_geo vs D_wide_raw (Practical question: current vs OOGGA-style)

- **SB K:** 4 vs 3 (**DIFFERS**)
- **Tiles:** 35 vs 31 (**DIFFERS**)
- **Min fidelity:** 0.9020 vs 0.8662 (-0.0358)
- **Mean fidelity:** 0.9965 vs 0.9962 (-0.0003)
- **Runtime:** 58.6s vs 372.9s (6.4x)

### A_narrow_geo vs B_wide_geo (Does wider K inflate fragment count with geo mean?)

- **SB K:** 4 vs 4 (same)
- **Tiles:** 35 vs 35 (same)
- **Min fidelity:** 0.9020 vs 0.9020 (+0.0000)
- **Mean fidelity:** 0.9965 vs 0.9965 (+0.0000)
- **Runtime:** 58.6s vs 366.8s (6.3x)

### A_narrow_geo vs C_narrow_raw (Does scoring alone change outcome?)

- **SB K:** 4 vs 3 (**DIFFERS**)
- **Tiles:** 35 vs 31 (**DIFFERS**)
- **Min fidelity:** 0.9020 vs 0.8662 (-0.0358)
- **Mean fidelity:** 0.9965 vs 0.9962 (-0.0003)
- **Runtime:** 58.6s vs 59.4s (1.0x)

### C_narrow_raw vs D_wide_raw (Does K range matter with raw scoring?)

- **SB K:** 3 vs 3 (same)
- **Tiles:** 31 vs 31 (same)
- **Min fidelity:** 0.8662 vs 0.8662 (+0.0000)
- **Mean fidelity:** 0.9962 vs 0.9962 (+0.0000)
- **Runtime:** 59.4s vs 372.9s (6.3x)

## Condition A Detailed Reaction Fidelity (Baseline)

| Tile | Reaction | # OHs | # in HF | Set Fidelity |
|------|----------|-------|---------|--------------|
| 1 | BsaI | 2 | 0 | 1.0000 |
| 1 | BsmBI | 6 | 0 | 1.0000 |
| 2 | BsaI | 3 | 0 | 1.0000 |
| 2 | BsmBI | 6 | 0 | 1.0000 |
| 3 | BsaI | 3 | 0 | 1.0000 |
| 3 | BsmBI | 6 | 0 | 1.0000 |
| 4 | BsaI | 3 | 0 | 1.0000 |
| 4 | BsmBI | 6 | 0 | 0.9533 |
| 5 | BsaI | 3 | 0 | 1.0000 |
| 5 | BsmBI | 6 | 0 | 1.0000 |
| 6 | BsaI | 3 | 0 | 1.0000 |
| 6 | BsmBI | 5 | 0 | 1.0000 |
| 7 | BsaI | 3 | 0 | 1.0000 |
| 7 | BsmBI | 6 | 0 | 1.0000 |
| 8 | BsaI | 3 | 0 | 1.0000 |
| 8 | BsmBI | 5 | 0 | 1.0000 |
| 9 | BsaI | 3 | 1 | 1.0000 |
| 9 | BsmBI | 6 | 0 | 1.0000 |
| 10 | BsaI | 3 | 0 | 1.0000 |
| 10 | BsmBI | 5 | 0 | 1.0000 |
| 11 | BsaI | 3 | 0 | 1.0000 |
| 11 | BsmBI | 5 | 1 | 1.0000 |
| 12 | BsaI | 4 | 0 | 1.0000 |
| 12 | BsmBI | 5 | 0 | 1.0000 |
| 13 | BsaI | 4 | 0 | 1.0000 |
| 13 | BsmBI | 5 | 0 | 1.0000 |
| 14 | BsaI | 4 | 0 | 1.0000 |
| 14 | BsmBI | 5 | 0 | 0.9020 |
| 15 | BsaI | 4 | 0 | 1.0000 |
| 15 | BsmBI | 5 | 0 | 1.0000 |
| 16 | BsaI | 4 | 0 | 1.0000 |
| 16 | BsmBI | 4 | 0 | 1.0000 |
| 17 | BsaI | 4 | 0 | 1.0000 |
| 17 | BsmBI | 4 | 0 | 1.0000 |
| 18 | BsaI | 5 | 0 | 1.0000 |
| 18 | BsmBI | 4 | 0 | 1.0000 |
| 19 | BsaI | 5 | 0 | 1.0000 |
| 19 | BsmBI | 4 | 0 | 1.0000 |
| 20 | BsaI | 5 | 0 | 1.0000 |
| 20 | BsmBI | 4 | 0 | 1.0000 |
| 21 | BsaI | 5 | 0 | 1.0000 |
| 21 | BsmBI | 4 | 0 | 1.0000 |
| 22 | BsaI | 5 | 1 | 1.0000 |
| 22 | BsmBI | 4 | 0 | 0.9650 |
| 23 | BsaI | 5 | 0 | 1.0000 |
| 23 | BsmBI | 4 | 0 | 1.0000 |
| 24 | BsaI | 5 | 0 | 1.0000 |
| 24 | BsmBI | 3 | 0 | 1.0000 |
| 25 | BsaI | 5 | 0 | 1.0000 |
| 25 | BsmBI | 3 | 0 | 0.9971 |
| 26 | BsaI | 6 | 1 | 1.0000 |
| 26 | BsmBI | 3 | 0 | 0.9986 |
| 27 | BsaI | 6 | 0 | 1.0000 |
| 27 | BsmBI | 3 | 1 | 1.0000 |
| 28 | BsaI | 6 | 0 | 1.0000 |
| 28 | BsmBI | 3 | 0 | 1.0000 |
| 29 | BsaI | 6 | 0 | 1.0000 |
| 29 | BsmBI | 3 | 0 | 1.0000 |
| 30 | BsaI | 6 | 1 | 1.0000 |
| 30 | BsmBI | 3 | 0 | 1.0000 |
| 31 | BsaI | 6 | 0 | 1.0000 |
| 31 | BsmBI | 3 | 0 | 1.0000 |
| 32 | BsaI | 6 | 1 | 1.0000 |
| 32 | BsmBI | 3 | 0 | 1.0000 |
| 33 | BsaI | 6 | 0 | 1.0000 |
| 33 | BsmBI | 3 | 1 | 0.9358 |
| 34 | BsaI | 6 | 1 | 1.0000 |
| 34 | BsmBI | 2 | 0 | 1.0000 |
| 35 | BsaI | 6 | 1 | 1.0000 |
| 35 | BsmBI | 2 | 0 | 1.0000 |

