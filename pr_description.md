## Summary

Wires the `min_geneblock_length` config parameter through the full pipeline call chain and fixes three root causes of gene block size violations discovered during AKAP11 pipeline runs:

- **Parameter mismatch:** `min_sub_length` was passed as total block length (300 nt) instead of gene-content length (300 - 22 = 278 nt), causing the DP to accept blocks that are actually undersized once enzyme site overhead is added
- **Global-to-tile mismatch:** `assign_global_boundaries_to_tiles()` filtered global DP splits to each tile's range with pure position filtering and zero size validation, creating tiny trailing blocks (22-31 nt = just enzyme overhead) and oversized blocks (1902 nt) when global splits fell outside a tile's WT region
- **Forward-pass overflow:** The forward pass that removes undersized superblock splits didn't check whether merging with the next sub-block would exceed the max synthesis limit, turning a "too small" problem into a "too large" problem

### Changes

**R/06_overhang_selection.R:**
- Fix `min_sub_length` to subtract `block_overhead` (22 nt) for gene-content semantics
- Add per-tile size validation in `assign_global_boundaries_to_tiles()` with `min_sub_length`, `max_sub_length`, `polIII_len` params
- Drop leading/trailing splits that create undersized sub-blocks, with merge-overflow safety checks
- Wire `min_sub_length` and `tile_boundary_nts` through `compute_global_superblock_boundaries()` to both DP calls

**R/09_wt_geneblock_design.R:**
- Add forward-pass overflow check for both BsaI and BsmBI paths: keep undersized splits when merging would create oversized blocks
- Add trailing gap check (BsaI) and leading+trailing gap checks (BsmBI) as safety net
- Add local split fallback using `optimize_split_points()` for blocks that still exceed synthesis limits after global DP
- Add `min_block_length` parameter

**R/10_qc_checks.R:**
- Add QC check #15 flagging blocks below minimum synthesis length
- Add `min_block_length` parameter

**run_pipeline.R:**
- Pass `cfg$min_geneblock_length` to `plan_assembly()`, `design_wt_geneblocks()`, and `run_qc_checks()`

**tests/testthat/test-geneblock-design.R:**
- Add `setup_geneblocks()` helper for reuse across tests
- 5 new TDD tests: block size bounds (2100 nt gene), block size bounds (9294 nt gene), no tiny trailing BsaI sub-blocks, no oversized BsmBI sub-blocks, min_sub_length gene-content semantics

### AKAP11 Pipeline Results

| Metric | Before | After |
|--------|--------|-------|
| Assembly simulation | 84/84 pass | 84/84 pass |
| Oversized blocks (>1800 nt) | 1 (1902 nt) | **0** |
| Tiny blocks (<100 nt) | 3 (22-31 nt) | **0** |
| Block size range | 22-1902 nt | **210-1720 nt** |
| Gene blocks (after dedup) | — | 62 |

## Test plan

- [x] 46/46 gene block design unit tests pass (including 5 new TDD tests)
- [x] 5010/5012 full test suite pass (2 pre-existing barcode test failures, unrelated to this PR)
- [x] AKAP11 pipeline end-to-end: 379,600 oligos, 62 gene blocks, 84/84 tiles pass in-silico assembly simulation
- [x] No oversized blocks; inherently small blocks (tile geometry, 210-267 nt) correctly flagged by QC
- [x] Local split fallback triggered for Tile 20 (1902 → split into valid sub-blocks)
