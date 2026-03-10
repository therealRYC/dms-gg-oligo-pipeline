# MC Refinement Comparison: oogga_two_pass vs oogga_two_pass_mc

**Date:** 2026-03-10 06:15:40

## Setup

- **Methods:** `oogga_two_pass` (DP only) vs `oogga_two_pass_mc` (DP + Metropolis-Hastings refinement)
- **Genes:** GRIN2A (4392 nt), AKAP11 (5706 nt), TRIO (9294 nt), GRIN2A + extended cassette
- **MC params:** 1000 iterations, initial temperature = 1.0, cooling rate = 0.995
- **beam_width:** 10, **max_identity:** 2, **dp_k_range:** 3
- **Seed:** 42 (reproducible MC)

## Results

| Gene | Method | Tiles | SBs | Min Fid | Mean Fid | Mi2 Viol | Mi3 Viol | Time (s) | Status |
|------|--------|-------|-----|---------|----------|----------|----------|----------|--------|
| GRIN2A | DP only | 24 | 3 | 0.8043 | 0.9612 | 29 | 1 | 42.9 | OK |
| GRIN2A | DP + MC | 24 | 3 | 0.8043 | 0.9612 | 29 | 1 | 50.1 | OK |
| AKAP11 | DP only | 33 | 4 | 0.8272 | 0.9824 | 56 | 14 | 99.9 | OK |
| AKAP11 | DP + MC | 33 | 4 | 0.8272 | 0.9824 | 56 | 14 | 105.0 | OK |
| TRIO | DP only | 54 | 6 | 0.7998 | 0.9913 | 101 | 1 | 233.3 | OK |
| TRIO | DP + MC | 54 | 6 | 0.7998 | 0.9913 | 101 | 1 | 238.2 | OK |
| GRIN2A_ext | DP only | 27 | 3 | 0.8940 | 0.9979 | 18 | 0 | 121.9 | OK |
| GRIN2A_ext | DP + MC | 27 | 3 | 0.8940 | 0.9979 | 18 | 0 | 126.8 | OK |

## Per-Gene Analysis

### GRIN2A

- **Fidelity change (MC over DP):** +0.0000 (min), +0.0000 (mean)
- **MC overhead:** +7.2s (+17%)
- **Tiles:** DP=24, MC=24
- **Violations (DP):** mi2=29, mi3=1
- **Violations (MC):** mi2=29, mi3=1

### AKAP11

- **Fidelity change (MC over DP):** +0.0000 (min), +0.0000 (mean)
- **MC overhead:** +5.1s (+5%)
- **Tiles:** DP=33, MC=33
- **Violations (DP):** mi2=56, mi3=14
- **Violations (MC):** mi2=56, mi3=14

### TRIO

- **Fidelity change (MC over DP):** +0.0000 (min), +0.0000 (mean)
- **MC overhead:** +4.8s (+2%)
- **Tiles:** DP=54, MC=54
- **Violations (DP):** mi2=101, mi3=1
- **Violations (MC):** mi2=101, mi3=1

### GRIN2A_ext

- **Fidelity change (MC over DP):** +0.0000 (min), +0.0000 (mean)
- **MC overhead:** +4.9s (+4%)
- **Tiles:** DP=27, MC=27
- **Violations (DP):** mi2=18, mi3=0
- **Violations (MC):** mi2=18, mi3=0

