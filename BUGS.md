# Created: 2026-02-20
# Last updated: 2026-02-26 — Add Potapov Table 1 sequences, OOGGA research findings to BUG-006

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

### BUG-003: Boundary codon mutations blanket-skipped (partial fix possible)
- **File:** `run_pipeline.R:177-188`, `R/04_mutation_design.R`, `R/05_tiling.R:176-180`
- **Status:** DEFERRED — workaround in place (F9 blanket skip), partial fix planned
- **What:** Codons at gene edges (position 2 and position n-1) partially overlap the fixed WT-derived overhangs (oh1 and oh2). Currently all ~40 mutations at these positions are blanket-skipped, even though many are assemblable.
- **Root cause:** BsaI generates 4-nt overhangs, codons are 3 nt. The 4/3 misalignment means:
  - Codon 2 (nt 4-6): first nucleotide (nt 4) sits inside oh1 (nt 1-4)
  - Codon n-1: third nucleotide (wobble position) sits inside oh2 (last 4 nt of tile)
  - The overlap is always exactly **1 nucleotide**
- **Why many are recoverable:** If the mutant codon preserves the single overlapping nucleotide, assembly works correctly. The oligo assembly code (line 91: `mutable_regions <- substring(mutant_tiles, 5L, t_len - 4L)`) strips oh1/oh2 as fixed overhangs. When the mutant codon's overlapping nt matches WT, the assembled product is the correct mutant.
- **Planned fix — `rescue_boundary_variants()`:**
  1. For each `partial_oh_overlap` variant, identify the constrained codon position (pos 1 for oh1, pos 3 for oh2) and the required WT nucleotide
  2. Check if the preferred mutant codon already satisfies the constraint — if so, rescue it directly
  3. If not, search all codons for the target AA ranked by human usage frequency, filtering to those that preserve the constrained nt AND don't create enzyme sites
  4. If a compatible codon exists: use it (mark as `oh_rescued` with `codon_note`)
  5. If no compatible codon exists (e.g., Trp=TGG when first nt must be G): mark as `oh_incompatible` and skip
- **Expected recovery:**
  - Codon 2 (first-position constraint): ~5-7 of 20 mutations (~30%). Limited because only AAs in the same genetic code "column" share a first nucleotide (e.g., first nt = G → only Val, Ala, Asp, Glu, Gly reachable)
  - Codon n-1 (wobble-position constraint): ~13-15 of 20 mutations (~70%). High recovery because wobble position is highly degenerate (most AAs have codons ending in any given nt)
  - **Total: ~19 of 40 variants recovered (~48%)** with zero architectural changes
- **Files to modify:** `R/04_mutation_design.R` (new function), `run_pipeline.R` (call site), `R/11_output.R` (output columns), `tests/testthat/test-mutation-design.R` (tests)
- **Current workaround (F9):** All 40 variants blanket-skipped and written to `_skipped_variants.csv`. Safe but loses coverage at 2 positions per gene.

### BUG-004: Large downstream cassette exceeds synthesis limit (unsplittable)
- **File:** `R/06_overhang_selection.R` (`dp_solve_superblock_splits`), `R/09_wt_geneblock_design.R`
- **Status:** OPEN — design decision needed
- **What:** The superblock DP can only place splits within the gene region (codon boundaries). The downstream cassette (intergene + PolIII) is treated as an unsplittable blob appended to the last sub-block via `extra_content_length`. If the cassette alone exceeds ~1778 nt (1800 - 22 overhead), or if cassette + remaining gene content in the last sub-block exceeds that limit, the DP fails to find a feasible solution. It returns empty splits with a warning and the pipeline proceeds to build an unorderable gene block.
- **Trigger:** `intergene_elements` totaling >~1400 nt (leaving room for PolIII ~300 nt + some gene content). A 3000 nt intergene region makes it impossible regardless of gene length.
- **Two candidate fixes:**
  - **Option 1 — Separate cassette fragments:** Treat intergene elements as independent BsmBI gene block(s) with their own junction overhangs. Conceptually adds a new fragment category. PolIII stays as the most 3' element before oh3/barcode. Downside: more overhangs in the BsmBI reaction = lower set fidelity.
  - **Option 3 — Extend DP into cassette (preferred):** Concatenate gene + cassette into a single splittable sequence. The DP places splits anywhere in the combined sequence — codon boundaries within the gene, any position within the cassette. No new fragment categories; cassette sub-blocks are just more superblock sub-blocks. Requires: (a) coordinate system refactor (positions > gene_len index into cassette), (b) mixed candidate generation (codon-boundary in gene, free in cassette), (c) protect last ~10 nt of cassette from splitting (oh3 derivation region). Affected files: `dp_solve_superblock_splits()`, `compute_global_superblock_boundaries()`, `design_wt_geneblocks()`.
  - Both options produce the same physical result (more BsmBI fragments in the same reaction). Option 3 is cleaner architecturally.
- **Current workaround:** None. Pipeline will produce oversized gene blocks if cassette is too large.

### BUG-005: Tile 20 AKAP11 3'WT block oversized — global split dropped incorrectly
- **File:** `R/06_overhang_selection.R` (`assign_global_boundaries_to_tiles`)
- **Status:** OPEN — confirmed via trace, not yet investigated
- **What:** For AKAP11, tile 20's 3'WT region is 1635 nt gene + 250 nt PolIII = 1885 nt (exceeds 1778 nt max_sub_length). The global 3'WT DP correctly placed a split at nt 4278, which falls within tile 20's 3'WT range (starts at 4072). But `assign_global_boundaries_to_tiles()` drops this split — likely because the leading sub-block [4072, 4278] = 207 nt falls below `min_sub_length`, without checking that dropping it produces an oversized merged block (1885 > 1778).
- **Root cause:** The assign function's "drop undersized sub-blocks" logic doesn't have a safety check: "is the merged result oversized?" It should keep the undersized split as the lesser evil when merging would exceed max_sub_length.
- **Related to:** BUG-004 (both stem from 3'WT region size management). The broader issue is that global splits are computed for the *largest* WT region (earliest tile), then assigned to individual tiles. Tiles near the crossover point (where the split just barely falls in range) can get sub-blocks that are too small for the global split but too large without it.
- **Likely fix:** In `assign_global_boundaries_to_tiles()`, when a split would be dropped for min_sub_length violation, check if merging exceeds max_sub_length. If so, keep the split (or trigger a local re-split).

### BUG-006: HF overhang set is greedy-generated, not from Potapov Table 1
- **File:** `R/06_overhang_selection.R` (`load_high_fidelity_set`, `generate_hf_set`), `data/neb_overhang_fidelity/high_fidelity_sets.rds`
- **Status:** OPEN — needs replacement with published set
- **What:** The "potapov_set2_20" HF set was misleadingly named. It is NOT from Potapov 2018 Table 1. It was generated by `generate_hf_set()`, a greedy algorithm that selects the top 20 mutually-orthogonal overhangs by individual fidelity. The Potapov paper's Table 1 sets were optimized via simulated annealing for **set** fidelity (product of pairwise correct fractions), which is the metric that actually predicts assembly success. Greedy individual-fidelity selection can produce sets with poor pairwise interactions.
- **Fix:** Replace with the 25-overhang set from Potapov 2018 Table 1 (predicted 95.8% set fidelity — the highest for any 25-overhang set in the paper). This gives more headroom for gene-derived overhangs to land in the set. Update `high_fidelity_sets.rds` and `load_high_fidelity_set()` default. Remove `generate_hf_set()` as the primary path (keep only as last-resort fallback).
- **Potapov Table 1 — 25-overhang set (Set 3, to be embedded in code):**
  - Source: Potapov et al. 2018, ACS Synth Bio, Table 1. Optimized via simulated annealing for **set fidelity**. Predicted 95.8% set fidelity.
  - Extracted directly from Potapov 2018 paper PDF Table 1. Note: includes AAAA (homopolymer) — confirmed in paper's SA-optimized set.
  - Exact sequences: `CCTC, CTAA, GACA, GCAC, AATC, GTAA, TGAA, ATTA, CCAG, AGGA, ACAA, TAGA, CGGA, CATA, CAGC, AACG, AAGT, CTCC, AGAT, ACCA, AGTG, GGTA, GCGA, AAAA, ATGA`
  - Table 1 also has: Set 1 (15 OHs, >99%, includes MoClo), Set 2 (20, ~98%), Set 4 (30, ~90%).
- **OOGGA scoring research (completed 2026-02-26):**
  - OOGGA (Mukundan & Madhusudhan 2025, bioRxiv 10.1101/2025.06.16.659877) uses a DP that scores by individual overhang fidelity and efficiency.
  - **Key finding:** OOGGA uses ONLY the diagonal of the Potapov 256×256 matrix (context-independent fidelity). It does NOT compute pairwise cross-reactivity between overhangs in the set. Our existing formula `fidelity(X) = M[X][RC(X)] / sum(M[X][*])` is identical to OOGGA's `P_fid`.
  - **OOGGA does NOT use or reference Potapov Table 1 HF sets** — it uses all 256 overhangs and lets the DP find optimal ones via sequence identity filter.
  - **P_eff (new metric):** OOGGA also uses `P_eff(X) = M[X][RC(X)] / max_Y(M[Y][RC(Y)])`, a relative efficiency metric our pipeline doesn't currently use.
  - **Potapov GetSet (NEB):** Uses MCMC simulated annealing with **context-dependent** set fidelity: `p(O_i) = M[O_i][RC(O_i)] / sum_{j in S}(M[O_i][j])` where S = only overhangs in the set. This is more accurate than OOGGA's context-independent version.
  - **Two candidate scoring approaches:**
    - **Option A — Pure OOGGA DP:** Score overhangs purely by `P_fid × P_eff` products. No HF set bonus. Simpler.
    - **Option B — OOGGA DP + HF set upscoring:** Same per-overhang scoring, plus bonus for overhangs in the Potapov Table 1 HF set. Captures pairwise interactions not in individual fidelity.
  - **Recommendation:** Option B adds genuine value because: (1) HF sets encode pairwise interactions not captured by individual fidelity, (2) HF sets were experimentally validated, (3) bonus is most valuable for freely-chosen overhangs (oh3, oh4, SB junctions).
  - **Decision:** Deferred pending tile-boundary architecture completion. See `Plans/260226_overhang-architecture-redesign.md` for full analysis.
  - References: Potapov et al. 2018 (PMID 30335370), Pryor et al. 2020 (PMC7467295), kappagate/tatapov (Edinburgh Genome Foundry).

## Verified NOT Bugs

| Claim | Status |
|-------|--------|
| First overhang ATG"N" not handled correctly | **OK.** `oh_L = substring(cds, 1, 4)` correctly uses gene-derived overhang. |
| `create_bsmbi_block()` has same duplication as BsaI blocks | **Not a bug.** BsmBI gene_seq starts at `tile$end_nt + 1`, no overlap. |
| `check_and_fix_new_sites()` window too small | **Not a bug.** Uses 14-nt window — more than enough for any 7-nt recognition site. |
