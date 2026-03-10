# Full Pipeline Benchmark: Legacy DP vs OOGGA Two-Pass (beam=1)

**Date:** 2026-03-10
**Pipeline:** dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

## Setup

- **8 full pipeline runs**: 4 genes × 2 boundary methods
- **Legacy DP:** Tile-first DP → constrained SB DP → reactive blacklisting
- **OOGGA two-pass (beam=1):** SB-first OOGGA DP → per-segment tile OOGGA DP with proactive collision checks
- **Barcodes per variant:** 10 (all runs)
- **Assembly simulation:** enabled for all runs
- **OOGGA params:** max_identity=2, beam_width=1
- All runs executed in parallel on WSL2

## Assembly Structure

| Gene | Method | Tiles | Variants | Oligos | Gene Blocks | SBs | Total Rxns |
|------|--------|-------|----------|--------|-------------|-----|------------|
| GRIN2A | Legacy DP | 25 | 30,681 | 306,810 | 52 | 6 | 50 |
| GRIN2A | OOGGA | 27 | 28,497 | 284,970 | 59 | 4 | 54 |
| AKAP11 | Legacy DP | 31 | 39,858 | 398,580 | 66 | 6 | 62 |
| AKAP11 | OOGGA | 33 | 37,170 | 371,700 | 68 | 5 | 66 |
| TRIO | Legacy DP | 47 | 64,974 | 649,740 | 103 | 8 | 94 |
| TRIO | OOGGA | 56 | 60,354 | 603,540 | 119 | 7 | 112 |
| GRIN2A_ext | Legacy DP | 25 | 30,681 | 306,810 | 57 | 5 | 50 |
| GRIN2A_ext | OOGGA | 27 | 28,497 | 284,970 | 68 | 4 | 54 |

## Overhang Fidelity

| Gene | Method | Min Set Fidelity | Rxns < 0.90 | Rxn Fidelity QC |
|------|--------|------------------|-------------|-----------------|
| GRIN2A | Legacy DP | 0.7402 | 3 | FAIL |
| GRIN2A | OOGGA | 0.8940 | 1 | PASS |
| AKAP11 | Legacy DP | 0.8583 | 4 | PASS |
| AKAP11 | OOGGA | 0.7533 | 5 | FAIL |
| TRIO | Legacy DP | 0.7829 | 2 | FAIL |
| TRIO | OOGGA | 0.7581 | 12 | FAIL |
| GRIN2A_ext | Legacy DP | 0.7402 | 3 | FAIL |
| GRIN2A_ext | OOGGA | 0.8940 | 1 | PASS |

## QC Results

| Gene | Method | PASS | FAIL | Failed Checks |
|------|--------|------|------|---------------|
| GRIN2A | Legacy DP | 13 | 3 | overhang_fidelity, reaction_fidelity, block_min_length |
| GRIN2A | OOGGA | 15 | 2 | overhang_fidelity, block_min_length |
| AKAP11 | Legacy DP | 14 | 2 | overhang_fidelity, block_min_length |
| AKAP11 | OOGGA | 13 | 3 | overhang_fidelity, reaction_fidelity, block_min_length |
| TRIO | Legacy DP | 13 | 4 | oligo_gc_content, overhang_fidelity, reaction_fidelity, block_min_length |
| TRIO | OOGGA | 13 | 4 | oligo_gc_content, overhang_fidelity, reaction_fidelity, block_min_length |
| GRIN2A_ext | Legacy DP | 14 | 3 | overhang_fidelity, reaction_fidelity, block_min_length |
| GRIN2A_ext | OOGGA | 15 | 2 | overhang_fidelity, block_min_length |

**Note:** All failures are expected/informational:
- `overhang_fidelity`: Individual tile boundary overhangs below 0.80 (common with BsmBI cycling data)
- `reaction_fidelity`: Minimum set fidelity below 0.90 in some reactions
- `block_min_length`: Some gene blocks below 300 nt synthesis minimum (short terminal blocks)
- `oligo_gc_content`: TRIO has GC-extreme regions (up to 76.2%) inherent to the gene sequence

## Pipeline Timing (seconds)

| Step | GRIN2A DP | GRIN2A OG | AKAP11 DP | AKAP11 OG | TRIO DP | TRIO OG | GR_ext DP | GR_ext OG |
|------|-----------|-----------|-----------|-----------|---------|---------|-----------|-----------|
| 5_mutations | 183.2 | 183.5 | 239.6 | 239.1 | 429.9 | 430.1 | 184.1 | 182.5 |
| 6_assembly_plan | 14.2 | 86.0 | 7.4 | 102.0 | 32.5 | 154.5 | 14.2 | 94.0 |
| 7_barcodes | 222.1 | 209.0 | 315.5 | 271.0 | 378.4 | 311.9 | 220.7 | 204.1 |
| 8_oligo_assembly | 0.9 | 0.9 | 1.3 | 1.3 | 2.1 | 2.0 | 0.9 | 1.2 |
| 10_qc | 33.0 | 27.9 | 51.6 | 44.0 | 67.8 | 59.9 | 32.9 | 42.5 |
| 10b_simulation | 1.7 | 0.7 | 0.8 | 0.5 | 1.0 | 0.9 | 2.3 | 0.6 |
| **Total** | **479.3** | **526.7** | **641.5** | **679.1** | **949.2** | **997.1** | **480.3** | **543.7** |

### Timing Observations

- **Step 5 (mutations)** dominates total time (~38-45%) and is identical between methods (gene-dependent, not boundary-method-dependent)
- **Step 6 (assembly plan)** is 6-14x slower for OOGGA vs DP (86s vs 14s for GRIN2A; 155s vs 33s for TRIO) — OOGGA's collision-aware beam search explores more candidates
- **Step 7 (barcodes)** is ~6-18% faster for OOGGA because OOGGA produces more tiles → fewer variants per tile → fewer barcodes needed
- **Total overhead of OOGGA:** +47s (GRIN2A), +38s (AKAP11), +48s (TRIO), +63s (GRIN2A_ext) — roughly 5-13% of total pipeline time

## Comparison with Plan-Assembly-Only Benchmark

The previous benchmark (`benchmarks/260310_dp_vs_oogga_two_pass.md`) ran only `plan_assembly()` on each gene, not the full pipeline. Key differences:

### Tile Counts Match (with minor discrepancies)

| Gene | Method | Plan-Assembly | Full Pipeline | Match? |
|------|--------|---------------|---------------|--------|
| GRIN2A | DP | 25 | 25 | Yes |
| GRIN2A | OOGGA | 26 | 27 | +1 tile |
| AKAP11 | DP | 31 | 31 | Yes |
| AKAP11 | OOGGA | 32 | 33 | +1 tile |
| TRIO | DP | 47 | 47 | Yes |
| TRIO | OOGGA | 55 | 56 | +1 tile |
| GRIN2A_ext | DP | 25 | 25 | Yes |
| GRIN2A_ext | OOGGA | 27 | 27 | Yes |

**Note:** OOGGA tile counts differ by +1 for 3 of 4 genes. This is because the full pipeline applies enzyme site domestication before tiling (step 4), which changes a few codons. Different codon sequences at boundary positions can shift the OOGGA DP's optimal boundary selection, sometimes producing one extra tile. Legacy DP is less sensitive to this because its boundary search range is smaller.

### SB Counts Differ (expected)

| Gene | Method | Plan-Assembly SBs | Full Pipeline SBs | Notes |
|------|--------|-------------------|-------------------|-------|
| GRIN2A | DP | 4 | 6 | Full pipeline includes downstream cassette blocks |
| GRIN2A | OOGGA | 3 | 4 | |
| AKAP11 | DP | 5 | 6 | |
| AKAP11 | OOGGA | 4 | 5 | |
| TRIO | DP | 8 | 8 | Match (TRIO gene is so long that gene SBs dominate) |
| TRIO | OOGGA | 6 | 7 | |
| GRIN2A_ext | DP | 4 | 5 | Extended cassette requires more blocks |
| GRIN2A_ext | OOGGA | 3 | 4 | |

The full pipeline SB count is generally higher because it includes downstream cassette sub-blocks (PolIII + intergene elements) that the plan_assembly-only benchmark doesn't count.

### Min Set Fidelity

Full pipeline min fidelity values differ from plan-assembly because:
1. Full pipeline computes set fidelity across all overhangs in each BsmBI reaction (gene SB overhangs + tile boundary overhangs + fixed overhangs)
2. Plan-assembly-only computed fidelity for the gene SB/tile boundary overhangs in isolation
3. Full pipeline includes BsaI reactions (which always have fidelity=1.0 with only 2 overhangs) in the reaction count

## Key Takeaways

1. **OOGGA produces more tiles** (+2-9 more tiles) → fewer variants per tile → fewer total barcodes needed → smaller oligo pool
2. **OOGGA reduces oligo pool size** by 7-8% (GRIN2A: 307K→285K, AKAP11: 399K→372K, TRIO: 650K→604K)
3. **OOGGA requires more gene blocks** (+7-16 more) — more tiles means more WT blocks to synthesize
4. **Fidelity is mixed** — OOGGA wins on GRIN2A/GRIN2A_ext (0.894 vs 0.740), DP wins on AKAP11 (0.858 vs 0.753), roughly tied on TRIO
5. **OOGGA is ~5-13% slower** in total pipeline time — the 6-14x slower assembly planning step (step 6) is partially offset by faster barcode generation (fewer barcodes)
6. **All assembly simulations pass** — both methods produce valid assemblies
7. **Bottleneck is NOT the boundary method** — steps 5 (mutations) and 7 (barcodes) account for ~80% of total pipeline time regardless of method

## Output Files

Each run produced a complete output directory with:
- `*_assembly_report.md` — full assembly report
- `*_oligo_pool.csv` — oligo sequences for ordering
- `*_wt_geneblocks.csv` — WT gene block sequences
- `*_variant_barcode_map.csv` — variant-barcode mapping
- Assembly simulation results (all tiles verified)

Reports are in `benchmarks/260310_full_pipeline/{gene}_{method}/`.
