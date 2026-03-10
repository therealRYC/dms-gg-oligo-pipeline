# Beam Width Comparison: oogga_two_pass (beam=1 vs beam=10)

**Date:** 2026-03-10 05:59:49

## Setup

- **Method:** `oogga_two_pass` (SB-first → per-segment tile DP)
- **Genes:** GRIN2A (4392 nt), AKAP11 (5706 nt), TRIO (9294 nt), GRIN2A + extended cassette (P2A-EGFP + WPRE + bGH polyA)
- **Beam widths:** 1 (OOGGA native, no beam pruning) vs 10 (default)
- **max_identity:** 2, **dp_k_range:** 3

## Results

| Gene | Beam | Tiles | SBs | Min Fid | Mean Fid | Mi2 Viol | Mi3 Viol | Time (s) | Status |
|------|------|-------|-----|---------|----------|----------|----------|----------|--------|
| GRIN2A | 1 | 26 | 3 | 0.8043 | 0.9647 | 37 | 2 | 28.0 | OK |
| GRIN2A | 10 | 24 | 3 | 0.8043 | 0.9612 | 29 | 1 | 40.8 | OK |
| AKAP11 | 1 | 32 | 4 | 0.8259 | 0.9843 | 53 | 13 | 34.3 | OK |
| AKAP11 | 10 | 33 | 4 | 0.8272 | 0.9824 | 56 | 14 | 98.8 | OK |
| TRIO | 1 | 55 | 6 | 0.8130 | 0.9931 | 84 | 3 | 66.0 | OK |
| TRIO | 10 | 54 | 6 | 0.7998 | 0.9913 | 101 | 1 | 242.0 | OK |
| GRIN2A_ext | 1 | 27 | 3 | 0.8940 | 0.9969 | 25 | 0 | 37.4 | OK |
| GRIN2A_ext | 10 | 27 | 3 | 0.8940 | 0.9979 | 18 | 0 | 125.4 | OK |

## Per-Gene Analysis

### GRIN2A

- **Fidelity gain (beam=10 over beam=1):** +0.0000 (min), -0.0035 (mean)
- **Speed ratio:** beam=10 is 1.5x slower than beam=1
- **Violations (beam=1):** mi2=37, mi3=2
- **Violations (beam=10):** mi2=29, mi3=1

### AKAP11

- **Fidelity gain (beam=10 over beam=1):** +0.0013 (min), -0.0019 (mean)
- **Speed ratio:** beam=10 is 2.9x slower than beam=1
- **Violations (beam=1):** mi2=53, mi3=13
- **Violations (beam=10):** mi2=56, mi3=14

### TRIO

- **Fidelity gain (beam=10 over beam=1):** -0.0132 (min), -0.0018 (mean)
- **Speed ratio:** beam=10 is 3.7x slower than beam=1
- **Violations (beam=1):** mi2=84, mi3=3
- **Violations (beam=10):** mi2=101, mi3=1

### GRIN2A_ext

- **Fidelity gain (beam=10 over beam=1):** +0.0000 (min), +0.0010 (mean)
- **Speed ratio:** beam=10 is 3.4x slower than beam=1
- **Violations (beam=1):** mi2=25, mi3=0
- **Violations (beam=10):** mi2=18, mi3=0

