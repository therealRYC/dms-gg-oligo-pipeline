# Legacy DP vs OOGGA Two-Pass (beam=1) — Head-to-Head

**Date:** 2026-03-10 10:01:23

## Setup

- **Legacy DP:** Tile-first DP on full CDS → constrained SB DP → reactive blacklisting loop (up to 5 iterations)
- **OOGGA two-pass (beam=1):** SB-first OOGGA DP → per-segment tile OOGGA DP with proactive collision checks
- **Genes:** GRIN2A (4395 nt), AKAP11 (5706 nt), TRIO (9294 nt), GRIN2A + extended cassette (P2A-EGFP + WPRE + bGH polyA)
- **OOGGA params:** max_identity=2, beam_width=1, dp_k_range=3
- **Legacy DP params:** dp_k_range=5

## Metrics

- **Tiles / SBs / Splits**: Assembly structure
- **Min/Mean Set Fidelity**: Per-reaction set fidelity (Potapov 2018). Higher = better ligation specificity.
- **Mi2 violations**: Overhang pairs with >2/4 positional identity within a reaction (strict OOGGA threshold)
- **Mi3 violations**: Overhang pairs with >3/4 positional identity (only exact/RC matches — most problematic)
- **Exact violations**: Identical or exact-RC overhang pairs in a reaction (worst case)
- **Unresolved**: SB collisions the reactive blacklisting loop couldn't fix (legacy DP only)

## Results

| Gene | Method | Tiles | SBs | Splits | Min Fid | Mean Fid | Mi2 | Mi3 | Exact | Unresolved | Time (s) |
|------|--------|-------|-----|--------|---------|----------|-----|-----|-------|------------|----------|
| GRIN2A | Legacy DP | 25 | 4 | 69 | 0.8582 | 0.9894 | 30 | 0 | 0 | 0 | 6.3 |
| GRIN2A | OOGGA two-pass (beam=1) | 26 | 3 | 50 | 0.8043 | 0.9647 | 37 | 2 | 2 | 0 | 27.1 |
| AKAP11 | Legacy DP | 31 | 5 | 116 | 0.9130 | 0.9840 | 131 | 0 | 0 | 0 | 7.0 |
| AKAP11 | OOGGA two-pass (beam=1) | 32 | 4 | 93 | 0.8259 | 0.9843 | 53 | 13 | 13 | 0 | 33.9 |
| TRIO | Legacy DP | 47 | 8 | 315 | 0.7829 | 0.9868 | 109 | 0 | 0 | 0 | 20.5 |
| TRIO | OOGGA two-pass (beam=1) | 55 | 6 | 270 | 0.8130 | 0.9931 | 84 | 3 | 3 | 0 | 65.1 |
| GRIN2A_ext | Legacy DP | 25 | 4 | 69 | 0.7402 | 0.9845 | 38 | 0 | 0 | 0 | 6.8 |
| GRIN2A_ext | OOGGA two-pass (beam=1) | 27 | 3 | 52 | 0.8940 | 0.9969 | 25 | 0 | 0 | 0 | 35.1 |

## Per-Gene Analysis

### GRIN2A

- **Tiles:** DP=25, OOGGA=26
- **Superblocks:** DP=4, OOGGA=3
- **Min fidelity:** DP=0.8582, OOGGA=0.8043 (-0.0539)
- **Mean fidelity:** DP=0.9894, OOGGA=0.9647 (-0.0247)
- **Mi2 violations:** DP=30, OOGGA=37
- **Mi3 violations:** DP=0, OOGGA=2
- **Exact violations:** DP=0, OOGGA=2
- **Unresolved collisions:** DP=0, OOGGA=0
- **Runtime:** DP=6.3s, OOGGA=27.1s (4.3x)

### AKAP11

- **Tiles:** DP=31, OOGGA=32
- **Superblocks:** DP=5, OOGGA=4
- **Min fidelity:** DP=0.9130, OOGGA=0.8259 (-0.0871)
- **Mean fidelity:** DP=0.9840, OOGGA=0.9843 (+0.0003)
- **Mi2 violations:** DP=131, OOGGA=53
- **Mi3 violations:** DP=0, OOGGA=13
- **Exact violations:** DP=0, OOGGA=13
- **Unresolved collisions:** DP=0, OOGGA=0
- **Runtime:** DP=7.0s, OOGGA=33.9s (4.9x)

### TRIO

- **Tiles:** DP=47, OOGGA=55
- **Superblocks:** DP=8, OOGGA=6
- **Min fidelity:** DP=0.7829, OOGGA=0.8130 (+0.0301)
- **Mean fidelity:** DP=0.9868, OOGGA=0.9931 (+0.0063)
- **Mi2 violations:** DP=109, OOGGA=84
- **Mi3 violations:** DP=0, OOGGA=3
- **Exact violations:** DP=0, OOGGA=3
- **Unresolved collisions:** DP=0, OOGGA=0
- **Runtime:** DP=20.5s, OOGGA=65.1s (3.2x)

### GRIN2A_ext

- **Tiles:** DP=25, OOGGA=27
- **Superblocks:** DP=4, OOGGA=3
- **Min fidelity:** DP=0.7402, OOGGA=0.8940 (+0.1538)
- **Mean fidelity:** DP=0.9845, OOGGA=0.9969 (+0.0124)
- **Mi2 violations:** DP=38, OOGGA=25
- **Mi3 violations:** DP=0, OOGGA=0
- **Exact violations:** DP=0, OOGGA=0
- **Unresolved collisions:** DP=0, OOGGA=0
- **Runtime:** DP=6.8s, OOGGA=35.1s (5.2x)

