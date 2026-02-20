# Created: 2026-02-20
# Last updated: 2026-02-20 — Initial bug inventory from GGA validator analysis

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

## Open Bugs

### BUG-1: Overhang Conflict — Mutations at Tile Boundaries Silently Lost
- **Severity:** HIGH
- **Scope:** ~7% of all variants (4 codons per tile boundary x 20 variants/codon)
- **What:** oh1 (first 4 nt) and oh2 (last 4 nt) of each tile are always WT. Mutations at codons overlapping these regions are silently overridden — the assembled product carries WT, not the intended mutation.
- **Root cause:** `R/08_oligo_assembly.R:91` strips oh1/oh2 from mutant tiles. Non-overlapping tiles mean boundary codons aren't mutable in ANY tile.
- **Validator evidence:** 145/2000 overhang conflicts in test gene.
- **Fix:** 4-codon tile overlap so boundary codons fall in the adjacent tile's mutable interior.

### BUG-2: Barcode Junction Enzyme Sites
- **Severity:** HIGH
- **Scope:** ~0.1% of variants (gene-dependent)
- **What:** `filter_sequences_fast()` checks barcodes for enzyme sites in isolation, not in junction context with the flanking enzyme sites (BsmBI oh3 on left, BsaI oh4 on right). A barcode starting `GTCTC` plus oh3 ending in `C` creates `CGTCTC` = BsmBI site.
- **Validator evidence:** 2/2000 variants (A49V, A57G) failed BsmBI assembly.
- **Fix:** Junction-context filtering: check `left_context + barcode + right_context` for enzyme sites.

### BUG-3: QC Doesn't Validate Barcode Junctions
- **Severity:** MEDIUM
- **Scope:** Detection gap
- **What:** `R/10_qc_checks.R:50-57` — Check #3 ("oligo_enzyme_sites") always returns `pass = TRUE`. No actual scan of barcode junctions for unintended enzyme sites.
- **Fix:** Replace no-op with real junction scan as a safety net (should be 0 after BUG-2 fix).

### BUG-4: Mutations Generated for Start Codon (M1*)
- **Severity:** MEDIUM
- **Scope:** 20 variants per gene
- **What:** `design_mutations()` includes codon 1 (Met/ATG). These M1* variants always have full overhang conflict (ATG is in oh1 of first tile). The variants are synthesized but can never produce the intended mutation.
- **Fix:** Skip position 1 in `design_mutations()`.

### BUG-5: Mutations Generated for Stop Codon
- **Severity:** MEDIUM
- **Scope:** 19 variants per gene
- **What:** The last codon is a stop codon. `design_mutations()` generates nonsense reversion variants. These are always in the last tile's oh2 (stop codon is in last 4 nt of gene). No downstream tile covers them.
- **Fix:** Skip the last codon (stop) in `design_mutations()`.

## Verified NOT Bugs

| Claim | Status |
|-------|--------|
| First overhang ATG"N" not handled correctly | **OK.** `oh_L = substring(cds, 1, 4)` correctly uses gene-derived overhang. |
| `create_bsmbi_block()` has same duplication as BsaI blocks | **Not a bug.** BsmBI gene_seq starts at `tile$end_nt + 1`, no overlap. |
| `check_and_fix_new_sites()` window too small | **Not a bug.** Uses 14-nt window — more than enough for any 7-nt recognition site. |
