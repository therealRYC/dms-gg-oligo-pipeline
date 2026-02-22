<!-- Created: 2026-02-18 -->
<!-- Last updated: 2026-02-18 — Initial changelog for superblock-boundary-redesign branch -->

# 260218 Updated Changes to DMS Pipeline

Summary of all changes on the `260217-superblock-boundary-redesign` branch.

**Test status:** FAIL 0 | WARN 2 | SKIP 1 | PASS 1917

---

## 1. Unified Hierarchical Barcode Mode

**Files:** `R/constants.R`, `R/00_config.R`, `R/07_barcode_design.R`, `config_template.yaml`

Replaced the dual-mode barcode system (OPS mode vs. standard mode) with a single unified hierarchical prefix-suffix architecture.

- **Old:** Two code paths — `design_barcodes_ops()` (soft tolerance, prefix-first) and `design_barcodes_standard()` (global hard Hamming, random+greedy). User toggled with `ops_mode: true/false`.
- **New:** One unique prefix per *variant* with hard Hamming distance guarantee; random filtered suffixes for replicate barcodes within each variant. No pairwise suffix constraint needed.

Key changes:
- Defaults updated: `barcode_length` 12 → 20, `prefix_length` 8 → 12, `barcodes_per_variant` 1 → 10
- `ops_mode` and `barcode_capacity_tolerance` are deprecated (warning if present in config)
- `check_prefix_feasibility()` auto-adjusts `min_hamming` down to floor of 2 if prefix capacity is tight
- For `prefix_length <= 10`: exhaustive enumeration of all 4^k candidates; for `> 10`: random-greedy sampling
- `design_barcodes()` is now a single linear flow: auto-size → feasibility check → generate prefixes → generate per-prefix barcodes → validate

## 2. Global Superblock Boundary Optimization

**Files:** `R/06_overhang_selection.R`, `R/09_wt_geneblock_design.R`

Superblock splitting redesigned from per-tile independent optimization to a global boundary system.

- **Old:** Each tile independently computed its own superblock split points. Different tiles could have different split positions for overlapping WT regions, preventing block deduplication.
- **New:** `compute_global_superblock_boundaries()` computes shared split positions once for the entire 3'WT and 5'WT regions using DP optimization. `assign_global_boundaries_to_tiles()` assigns the relevant subset to each tile.
- Maximizes gene block reuse across tiles (fewer unique blocks to order)
- Homopolymer overhangs (AAAA, CCCC, GGGG, TTTT) excluded from oh3/oh4 selection

## 3. PerturbView Promoter + oh3 Derivation from Promoter

**Files:** `R/06_overhang_selection.R`, `R/09_wt_geneblock_design.R`, `config_template.yaml`, all config YAML files, `tests/testthat/setup.R`

oh3 (BsmBI overhang at the PolIII–barcode junction) is now derived from the PolIII promoter's 3' end instead of being selected from the HF overhang set. This matches the PerturbView/pCROP-Seq-v2 architecture.

- Promoter's last 5 nt = oh3 (4 nt overhang) + spacer (1 nt for BsmBI)
- PerturbView hU6+T7 promoter ends `...GAAACACCG` → oh3=CACC (fidelity=0.969), spacer=G
- `core_polIII` (promoter minus last 5 nt) used in gene blocks to avoid duplicating the oh3+spacer sequence
- After ligation: `...core_polIII + oh3 + barcode` → seamless junction, no duplicated sequence
- Falls back to HF set selection if promoter-derived oh3 collides with oh2 values

PolIII promoter sequence updated to PerturbView hU6+T7 version (incorporates T7 core `TAATACGACTCACTATA`).

## 4. Step 8 Oligo Assembly Performance Optimization

**File:** `R/08_oligo_assembly.R`

Rewrote `assemble_oligos()` with three optimizations to eliminate the per-oligo bottleneck:

| Optimization | Problem | Solution |
|---|---|---|
| **(A) Local mutation** | Full CDS string (~5700 nt) rebuilt per oligo | Mutate within ~230 nt tile string directly |
| **(B) Pre-computed constants** | Enzyme site strings recomputed per oligo | Compute `bsai_5prime`, `bsmbi_oh3_str`, `bsai_oh4_str`, per-tile `oh2_rev` once |
| **(C) Vectorize by tile** | Per-oligo loop with data.frame row assignment | Vectorized `substring()` + `paste0()` per tile; build data.frame once at end |

`build_mutant_tile()` and `build_oligo()` retained for backward compatibility (used in tests).

Expected performance: Step 8 from ~33–54 min down to ~5–8 min (for large genes at 10 barcodes/variant).

## 5. Pipeline Timing Diagnostics

**File:** `run_pipeline.R`

- Added `proc.time()` timing around every pipeline step (steps 1–12)
- Each step's elapsed time displayed inline (e.g., `[1.3s]`)
- Full timing breakdown printed at pipeline completion
- Total pipeline wall-clock time displayed

## 6. Progress Logging

**Files:** `R/06_overhang_selection.R`, `R/07_barcode_design.R`

Added progress reports for long-running operations:
- Boundary score precomputation timing
- DP tile boundary search timing
- Superblock DP timing
- Prefix generation progress (every 10K prefixes)
- Barcode generation progress (every 5K variants)
- Prefix validation progress (every 5K rows)

## 7. Assembly Report Improvements

**File:** `R/12_report.R`

- Barcode section updated from dual OPS/standard display to unified hierarchical mode
- Tile guide reordered to physical assembly order (5' → 3'): 5'WT blocks → oligo pool → helper plasmid
- Added "5' OH" and "3' OH" columns to BsaI and BsmBI component tables
- Non-final 3'WT sub-blocks labeled "3'WT sub" vs final "3'WT+PolIII sub"

## 8. Test Updates

**Files:** `tests/testthat/test-barcode-design.R`, `test-geneblock-design.R`, `test-integration.R`, `test-overhang-selection.R`

- Removed all OPS-mode-specific tests; added unified hierarchical mode tests
- Added tests for: `estimate_prefix_capacity`, `check_prefix_feasibility` (including auto-adjust), `generate_prefixes_random_greedy`, `generate_barcodes_per_prefix`, `validate_prefix_distances`
- Added homopolymer exclusion tests for oh3/oh4
- Added `dp_solve_superblock_splits` tests
- Added global boundary sharing/deduplication test
- Integration tests updated: `prefix_length` 8 → 12, explicit `barcodes_per_variant: 1`

---

## Files Modified

| File | Changes |
|------|---------|
| `R/00_config.R` | Unified barcode config, deprecation warnings |
| `R/06_overhang_selection.R` | Global superblock DP, oh3 promoter derivation, homopolymer exclusion, progress logging |
| `R/07_barcode_design.R` | Unified hierarchical barcode rewrite, progress logging |
| `R/08_oligo_assembly.R` | Vectorized oligo assembly (local mutation + pre-computed constants) |
| `R/09_wt_geneblock_design.R` | core_polIII usage, oh3_spacer passthrough |
| `R/12_report.R` | Report updates for new barcode mode + tile guide improvements |
| `R/constants.R` | Updated defaults (barcode_length=20, prefix=12, bpv=10) |
| `config_template.yaml` | PerturbView promoter, unified barcode docs |
| `run_pipeline.R` | Per-step timing diagnostics |
| `tests/testthat/setup.R` | Updated TEST_POLIII to PerturbView promoter |
| `tests/testthat/test-barcode-design.R` | Unified barcode tests |
| `tests/testthat/test-geneblock-design.R` | Global boundary + PolIII labeling tests |
| `tests/testthat/test-integration.R` | Updated barcode params |
| `tests/testthat/test-overhang-selection.R` | Homopolymer + superblock DP tests |
