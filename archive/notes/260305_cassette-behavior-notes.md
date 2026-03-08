<!-- Created: 2026-03-05 -->
<!-- Last updated: 2026-03-05 — Initial notes on cassette handling behavior -->

# Cassette Handling Behavior — Notes

## Overview

The "downstream cassette" = `intergene_elements` (if any) + `polIII_promoter`, built by `build_downstream_cassette()` in `00_config.R`. It flows through the pipeline as:

1. **Config**: `cfg$downstream_cassette` (full cassette string)
2. **Assembly planning**: passed to `plan_assembly()` / `plan_assembly_v2()` as `downstream_cassette`
3. **Gene block design**: passed to `design_wt_geneblocks()` as `polIII` (confusing naming — it's the full cassette, not just PolIII)

Key constants:
- `max_block_length` = 1800 nt (synthesis limit)
- `block_overhead` = 22 nt (2 x 11-nt BsmBI enzyme sites per block)
- `max_sub_content` = 1778 nt (gene content budget per block)

---

## Case 1: Cassette fits on the last superblock

**Condition:** `gene_3wt_content + cassette_length <= 1778`

**Example:** Gene = 2100 nt, PolIII = 250 nt. Last tile's 3'WT = 500 nt. Total = 750 <= 1778.

**Code path:**
- `partition_tile_superblocks()` backwards sweep sizes last SB to fit gene+cassette
- `design_wt_geneblocks()` line 544-557: single block with `paste0(gene_seq, polIII_for_block)`

**Result:** One `bsmbi_3wt_tileN` block. No splitting.

---

## Case 2: Cassette too large for last superblock, but < synthesis limit

**Condition:** `gene_3wt + cassette > 1778` but `cassette <= 1778`

**Example:** Gene = 2100 nt, cassette = 1500 nt. Last tile's 3'WT = 400 nt. Total = 1900 > 1778.

**Code path:**
- `cassette_needs_splitting = FALSE`
- Backwards sweep tries to minimize gene content in last SB
- `design_wt_geneblocks()` tries local gene-region split (`optimize_split_points()`) at lines 449-476
- Splits 3'WT gene content into sub-blocks; cassette appended to last sub-block

**Result:** Multiple `bsmbi_3wt_tileN_subK` blocks. Cassette on the last sub-block. No cassette splitting.

---

## Case 3: Cassette > synthesis limit, needs splitting

**Condition:** `cassette_length > 1778`

**Example:** Intergene = 2000 nt, PolIII = 250 nt. Cassette = 2250 nt.

**Code path:**
- `cassette_needs_splitting = TRUE`
- Backwards sweep SKIPPED — gene partitioned with forward greedy only, no cassette budget
- `design_wt_geneblocks()`:
  - **Non-last tiles** (lines 652-768): last gene sub-block gets gene content only; `find_cassette_split_points()` + `build_cassette_subblocks()` create separate BsmBI-flanked cassette fragments
  - **Last tile** (lines 771-831): cassette is standalone; same split + build logic

**Result:** Separate `bsmbi_cassette_tileN_subK` blocks connected by BsmBI overhangs.

---

## Edge Cases

### Case 4: No intergene elements (default)
Cassette = polIII only (~250 nt). Trivially fits. No special handling.

### Case 5: Cassette exactly at boundary (~1778 nt)
`cassette_needs_splitting` uses `>` (not `>=`), so exactly 1778 is NOT split.
But any gene content pushes the block over. Triggers Case 2 local gene split.
If gene content too small to split effectively → oversized block flagged by QC.
**This is BUG-004 territory.**

### Case 6: Gene SB splits + cassette interaction
When gene has pre-computed SB splits AND cassette, last gene sub-block carries the cassette.
Trailing gap checks (lines 634-647) account for `polIII_for_block` length.

### Case 7: Enzyme sites at intergene element junctions
`run_pipeline.R:126-131` scans for enzyme sites spanning junctions between intergene elements.
Can't be auto-domesticated. Pipeline warns but continues.

### Case 8: Cassette split overhang exhaustion
`find_cassette_split_points()` searches +-50 nt window, retries up to 3x with `n_splits + 1`.
If all fail, returns best-effort (may include low-scoring "NNNN" overhangs). QC flags downstream.

### Case 9: Cassette between 1778 and 1800 nt
A 1790 nt cassette needs 1790 + 22 = 1812 total → exceeds 1800 synthesis limit.
Code correctly triggers splitting since `1790 > 1778` (max_sub_content).

---

## Summary Table

| Case | Cassette size | Gene 3'WT? | Behavior |
|------|--------------|------------|----------|
| 1 | Small (gene+cass <= 1778) | Yes/No | Single block with cassette appended |
| 2 | Medium (gene+cass > 1778, cass <= 1778) | Yes | Split gene; cassette on last sub-block |
| 3 | Large (cass > 1778) | Yes/No | Cassette split into separate BsmBI fragments |
| 5 | Boundary (~1778) | With gene | May produce oversized block (QC flagged, BUG-004) |

---

## Key File References

- `R/00_config.R:114-158` — `build_downstream_cassette()`
- `R/06_overhang_selection.R:2059-2300` — `partition_tile_superblocks()`
- `R/06_overhang_selection.R:2517-2991` — `plan_assembly()` (v1)
- `R/06_overhang_selection.R:3023-3546` — `plan_assembly_v2()` (v2)
- `R/09_wt_geneblock_design.R:34-129` — `find_cassette_split_points()`
- `R/09_wt_geneblock_design.R:146-184` — `build_cassette_subblocks()`
- `R/09_wt_geneblock_design.R:204-906` — `design_wt_geneblocks()`
- `tests/testthat/test-cassette-splitting.R` — cassette splitting tests

---

## Open Questions / TODO

- BUG-004: Narrow zone where cassette <= 1778 but gene+cass > 1778 and gene too small to split
- Should `polIII` parameter in `design_wt_geneblocks()` be renamed to `cassette` for clarity?
- Are there real-world constructs where the cassette would be > 1778 nt? (e.g., GFP reporter + IRES + PolIII ≈ 2200 nt?)
