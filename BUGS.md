# Created: 2026-02-20
# Last updated: 2026-02-21 — Add F11 (superblock junction bugs) and F12 (barcode suffix sampling)

# Bug Inventory — DMS GG Oligo Pipeline

## Fixed Bugs

### F1: `orient_enzyme_site()` reverse case used wrong RC formula
- **File:** `R/utils.R:118-128`
- **Fixed in:** PR #14 (commit `96eb1d7`)
- **Fix:** Changed `RC(recog + spacer + overhang)` to `RC(recog + spacer + RC(overhang))` so the exposed sticky end matches the forward site.

### F2: `create_bsai_block()` duplicated oh_5prime (4 nt)
- **File:** `R/09_wt_geneblock_design.R:322-342`
- **Fixed in:** PR #14 (commit `96eb1d7`)
- **Fix:** Trim `gene_seq` leading 4 nt since `bsai_fwd` already embeds oh_5prime.

### F3: Oligo names not unique when `barcodes_per_variant > 1`
- **File:** `R/08_oligo_assembly.R:100-110`
- **Fixed in:** PR #14 (commit `96eb1d7`)
- **Fix:** Append `_b{barcode_idx}` suffix to oligo names.

### F4: Tile overlap for internal boundary codons (was BUG-1)
- **File:** `R/05_tiling.R`
- **Fixed in:** PR #15 (commit `0057cc4`)
- **Fix:** 4-codon tile overlap so internal-boundary codons fall in the adjacent tile's mutable interior. Smart `assign_variants_to_tiles()` prefers tiles where the mutation is fully interior.
- **Note:** Gene-edge codons (codon 2 and penultimate codon) were addressed separately — see F9.

### F5: Barcode junction enzyme site filtering (was BUG-2)
- **File:** `R/07_barcode_design.R`
- **Fixed in:** PR #15 (commit `0057cc4`)
- **Fix:** `filter_barcode_junctions()` checks `left_context + barcode + right_context` for enzyme sites. `run_pipeline.R` computes and passes the junction contexts.
- **Note:** Integration tests now pass junction contexts — see F10.

### F6: QC junction scan (was BUG-3)
- **File:** `R/10_qc_checks.R`
- **Fixed in:** PR #15 (commit `0057cc4`)
- **Fix:** Replaced no-op QC check #3 with real junction enzyme site scan.

### F7: Skip Met@1 and stop codon mutations (was BUG-4, BUG-5)
- **File:** `R/04_mutation_design.R`
- **Fixed in:** PR #15 (commit `0057cc4`)
- **Fix:** `design_mutations()` skips codon 1 (Met) and the last codon (stop).

### F8: Python validator reverse-site overhang extraction
- **File:** `scripts/validate_gga.py:309`
- **Fixed in:** this session (worktree `260220-test-run-after-gga-checker-and-debugging`)
- **What:** `find_enzyme_sites()` incorrectly took RC of top-strand overhang for reverse enzyme sites. Forward site at junction gives `TGAC`, reverse site gave `GTCA` (its RC) instead of `TGAC`. Every BsmBI assembly failed (100% false-negative rate).
- **Fix:** Return the top-strand sequence directly (`oh = seq[oh_start:oh_end]`) instead of `reverse_complement()`. Cross-validation: 0/1960 PASS → 1958/1960 PASS.

### F9: Gene-edge variants skipped from oligo pool (was BUG-6)
- **File:** `run_pipeline.R`, `R/11_output.R`
- **Fixed in:** this session (worktree `260220-test-run-after-gga-checker-and-debugging`)
- **What:** Gene-edge codons (codon 2 and penultimate non-stop codon) partially overlap fixed oh1/oh2 overhangs. Assembled products would get chimeric codons — neither WT nor intended mutation.
- **Fix:** Filter variants with `overhang_note == "partial_oh_overlap"` after `assign_variants_to_tiles()`. Removed variants are written to `_skipped_variants.csv` with reason. ~40 variants per gene (~1-2%) are skipped.

### F10: Integration tests now pass junction context to design_barcodes (was BUG-7)
- **File:** `tests/testthat/test-integration.R`
- **Fixed in:** this session (worktree `260220-test-run-after-gga-checker-and-debugging`)
- **What:** All 3 integration tests called `design_barcodes()` without `junction_left_context`/`junction_right_context`, so barcode junction enzyme-site filtering was skipped. ~2 variants per run got barcodes creating BsmBI sites at the oh3-barcode junction.
- **Fix:** Compute junction contexts (matching `run_pipeline.R` logic) and pass them to `design_barcodes()` in all integration tests.

### F11: Superblock junction bugs — BsaI oh_5 mismatch + 4-nt duplication (BUG-001)
- **File:** `R/09_wt_geneblock_design.R`
- **Fixed in:** PR #18 (commit `76a0329`)
- **What:** Three related bugs in superblock splitting caused assembly failures on all tiles with superblocked gene blocks:
  1. BsaI sub-blocks after the first used wrong oh_5 (gene position instead of junction overhang) → ligation failure
  2. BsaI non-final sub-blocks included trailing junction OH, duplicated by next sub-block → 4-nt insertion
  3. BsmBI non-final sub-blocks had same trailing OH duplication → 4-nt insertion
- **Fix:** Use junction overhang for oh_5 on non-first BsaI sub-blocks; trim trailing 4 nt (`sub_end - 4L`) from non-final sub-blocks in both BsaI and BsmBI loops.
- **Verified:** 66/66 tiles pass assembly simulation + product verification (GRIN2A, 22 tiles, 47 blocks).

### F12: Barcode suffix sampling too small when barcodes_per_variant=1
- **File:** `R/07_barcode_design.R`
- **Fixed in:** PR #18 (commit `76a0329`)
- **What:** When `barcodes_per_variant=1`, suffix candidate count was `1 * 10 = 10`, far too few to find valid suffixes in the 65K search space (suffix_length=8). Also, prefixes creating enzyme sites at junction boundaries were not filtered.
- **Fix:** Minimum 500 initial candidates (5000 on retry); added `filter_barcode_junctions()` call on prefixes to remove those creating enzyme sites at oh3-barcode or barcode-oh4 junctions (48 removed for GRIN2A).

## Open Bugs

(None currently open.)

## Verified NOT Bugs

| Claim | Status |
|-------|--------|
| First overhang ATG"N" not handled correctly | **OK.** `oh_L = substring(cds, 1, 4)` correctly uses gene-derived overhang. |
| `create_bsmbi_block()` has same duplication as BsaI blocks | **Not a bug.** BsmBI gene_seq starts at `tile$end_nt + 1`, no overlap. |
| `check_and_fix_new_sites()` window too small | **Not a bug.** Uses 14-nt window — more than enough for any 7-nt recognition site. |
