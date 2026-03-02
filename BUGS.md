# Created: 2026-02-20
# Last updated: 2026-03-02 — BUG-008 fix plan: standardize on BsmBI cycling P_fid, drop P_eff + HF bonus

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

### F13: Large downstream cassette splitting (was BUG-004)
- **File:** `R/09_wt_geneblock_design.R` (`find_cassette_split_points`, `build_cassette_blocks`), `R/06_overhang_selection.R`
- **Fixed in:** cassette splitting implementation (2026-03-01)
- **What:** When the downstream cassette (intergene elements + PolIII) exceeds ~1778 nt, it is now automatically split across multiple BsmBI-connected gene block fragments. Split points are chosen at positions with high-fidelity BsmBI overhangs, using the same OOGGA scoring as gene superblock junctions. After ligation, the cassette is reconstructed seamlessly.
- **Verified:** GRIN2A long cassette test case (P2A-EGFP + WPRE + spacer + hGH polyA = 2133 nt) successfully split into 2 fragments at position 1045 (overhang ACCA), all 64 gene blocks within synthesis limit.

### F14: BsaI superblock junction overhang collision with tile oh1 (was BUG-007)
- **File:** `R/06_overhang_selection.R` (`partition_tile_superblocks` Phase 4, iterative DP loop)
- **Fixed in:** iterative DP with SB-aware blacklisting (OPT-005 implementation, 2026-03-01)
- **What:** When a superblock boundary's `oh2_seq` matched the `oh1_seq` of a tile in a later superblock, the BsaI ligation failed (ambiguous ligation). Discovered on AKAP11 where SB boundary tile 17 had `oh2_seq = ACCA`, colliding with tiles 21 and 24.
- **Fix:** Two-level resolution: (1) Phase 4 of `partition_tile_superblocks()` now checks SB boundary overhangs against all tile `oh1_seq` values in later superblocks (identity + RC collision). (2) When collisions are detected, the iterative DP loop blacklists the colliding oh2 values and re-runs the tile boundary DP, preventing those positions from being selected. The old ±1 tile shift heuristic was removed.
- **Verified:** AKAP11 pipeline run completes with 0 collisions after iterative blacklisting.

### F15: Tile 20 AKAP11 3'WT block oversized (was BUG-005)
- **File:** `R/06_overhang_selection.R`
- **Status:** ELIMINATED — no longer possible under tile-boundary SB architecture
- **What:** Under the old global-split architecture, tile 20's 3'WT region was 1885 nt (exceeds limit). The global DP placed a split that was incorrectly dropped due to minimum sub-block length constraints.
- **Resolution:** The tile-boundary superblock architecture (2026-02-26) replaced global splits with per-tile-boundary partitioning. SB boundaries now fall at tile boundaries only, using gene-derived overhangs (oh2) as junction sequences. This ensures each tile's reaction uses only locally-relevant overhangs and eliminates the global-to-local assignment problem entirely.

### F16: HF overhang set was greedy-generated, not from Potapov Table 1 (was BUG-006)
- **File:** `R/06_overhang_selection.R` (`load_high_fidelity_set`), `data/neb_overhang_fidelity/high_fidelity_sets.rds`
- **Fixed in:** branch `260226-hf-set-fix`
- **What:** The old "potapov_set2_20" HF set was misleadingly named. It was generated by a greedy algorithm selecting top-20 mutually-orthogonal overhangs by individual fidelity, NOT from Potapov 2018 Table 1. The paper's Table 1 sets were optimized via simulated annealing for **set** fidelity (the metric that actually predicts assembly success).
- **Fix:** Replaced with Potapov 2018 Table 1 Set 3 (25 overhangs, 95.8% predicted set fidelity). Exact sequences: `CCTC, CTAA, GACA, GCAC, AATC, GTAA, TGAA, ATTA, CCAG, AGGA, ACAA, TAGA, CGGA, CATA, CAGC, AACG, AAGT, CTCC, AGAT, ACCA, AGTG, GGTA, GCGA, AAAA, ATGA`. Source: Potapov et al. 2018, ACS Synth Bio, Table 1 (extracted directly from paper PDF).
- **OOGGA scoring (implemented 2026-02-26):** Score = `P_fid(oh) * P_eff(oh) * (1 + w_hf * in_HF)` where w_hf=0.5 default. Uses BsmBI-specific data for P_fid, T4 data for P_eff, with HF set bonus for overhangs in Potapov Table 1 Set 3. See `Plans/260226_overhang-architecture-redesign.md` for full design.

## Open Bugs

### BUG-008: Overhang scoring mixes data sources from different experimental conditions
- **File:** `R/06_overhang_selection.R` (`oogga_score`, `precompute_boundary_scores`), `R/constants.R` (`DEFAULT_HF_BONUS_WEIGHT`), `data/neb_overhang_fidelity/`
- **Status:** FIX PLANNED — standardize on BsmBI cycling for both P_fid and P_eff, drop HF bonus
- **What:** The OOGGA-based overhang scoring formula draws P_fid, P_eff, and HF set bonus from three different experimental conditions, meaning the composite score doesn't correspond to any single experimentally-measured system.
- **Current scoring formula:** `Score = P_fid(oh) * P_eff(oh) * (1 + w_hf * in_HF)`
  - `P_fid` = `M[X][RC(X)] / sum(M[X][*])` — drawn from **BsmBI-specific cycling data** (Pryor 2020, BsmBI-v2, 42°C/16°C, 30 cycles)
  - `P_eff` = `M[X][RC(X)] / max_Y(M[Y][RC(Y)])` — drawn from **T4 DNA Ligase static data** (Potapov 2018, 37°C, 18h)
  - `in_HF` = membership in Potapov Table 1 Set 3 — optimized under **T4 DNA Ligase static conditions** (25°C, 18h)

#### Analysis (completed 2026-03-02)

Side-by-side comparison of T4 25°C/18h, BsaI cycling, and BsmBI cycling fidelity profiles. Full analysis in `260302_overhang_fidelity_comparison/`.

**Key findings:**
1. **BsaI ≈ BsmBI cycling** (Spearman rho = 0.977). Enzyme choice barely matters; condition (static vs cycling) is what matters.
2. **T4 static overestimates fidelity** vs cycling for most overhangs, especially palindromes (2 palindromes pass 0.95 under T4, 0 under BsmBI).
3. **Cycling zeros reflect real biology**, not sequencing depth artifacts. The restriction enzyme re-cuts misligated products during cycling, genuinely eliminating misligations that occur under T4-only static. NEB's GetSet tool uses cycling data directly and reports ~20 overhangs achieve perfect fidelity under BsmBI cycling (Pryor 2020). Both matrices are sparse (T4: 86% zeros, BsmBI: 94% zeros).
4. **HF set bonus adds no value under cycling conditions.** SA optimization shows any reasonable 25-overhang set achieves ~1.0 set fidelity under BsmBI cycling — pairwise cross-ligation is negligible. The HF set bonus was designed to encode pairwise compatibility information, but cycling conditions already handle this biologically.
5. **BsmBI P_eff has good dynamic range** (SD = 0.153, range 0.28–1.00), comparable to T4 P_eff (SD = 0.143, range 0.05–1.00). The earlier claim that BsmBI P_eff had "compressed dynamic range" was wrong. P_eff captures real yield information that P_fid misses — e.g., TTAA has P_fid = 0.945 (high accuracy) but P_eff = 0.298 (terrible yield), making it a high-fidelity bottleneck. Under BsmBI, Spearman(P_fid, P_eff) = 0.728 — correlated but with substantial independent signal.
6. **P_eff from T4 was unprincipled.** Now that BsmBI P_eff is confirmed to have adequate dynamic range, there is no reason to source P_eff from a different experimental condition.

#### Fix plan: Standardize on BsmBI cycling for both P_fid and P_eff, drop HF bonus

**New scoring formula:** `Score = P_fid_bsmbi(oh) * P_eff_bsmbi(oh)`

Both metrics computed from the same BsmBI cycling 256×256 matrix. P_fid captures accuracy (fraction of correct ligations). P_eff captures yield (correct ligation count relative to best overhang). The product rewards overhangs that are both accurate AND efficient. Penalties for palindromes, homopolymers, and low-fidelity overhangs remain unchanged.

**Rationale:**
- Matches our actual experimental conditions (BsmBI cycling protocol)
- More conservative than T4 (overhangs that pass BsmBI thresholds will perform at least as well in practice)
- NEB recommends matching dataset to protocol (Sikkema et al. 2023)
- Eliminates data-source mixing entirely — one matrix, two derived metrics
- Under cycling, pairwise misligation is negligible for well-chosen overhangs, so HF set bonus adds no discriminating power
- P_eff adds real signal: identifies overhangs like TTAA that are high-fidelity but low-yield

**What changes:**

| Component | Current | New | File(s) |
|-----------|---------|-----|---------|
| `oogga_score()` | `P_fid_bsmbi * P_eff_t4 * (1 + w_hf * in_HF)` | `P_fid_bsmbi * P_eff_bsmbi` | `R/06_overhang_selection.R` |
| `eff_lookup` | Computed from T4 Potapov pairwise matrix | **Compute from BsmBI cycling matrix** | `R/06_overhang_selection.R` |
| `hf_set` / `load_high_fidelity_set()` | Potapov Table 1 Set 3 | **Remove from scoring** (keep data file for reference) | `R/06_overhang_selection.R` |
| `DEFAULT_HF_BONUS_WEIGHT` | 0.5 | **Remove** | `R/constants.R` |
| `compute_overhang_efficiency()` | Uses T4 pairwise matrix | **Rewrite to use BsmBI cycling matrix** | `R/06_overhang_selection.R` |
| `load_pairwise_matrix()` calls | T4 + BsaI + BsmBI Hamming-model matrices | **Load only BsmBI cycling matrix** (for P_eff) | `R/06_overhang_selection.R` |
| `potapov_18h_pairwise.rds` | Used for P_eff | **No longer loaded during scoring** | `data/neb_overhang_fidelity/` |
| Config `hf_bonus_weight` | User-configurable | **Remove param** | `config_template.yaml`, `R/00_config.R` |

**Data source for P_eff:** The BsmBI cycling matrix is already available as `data/neb_overhang_fidelity/bsmbi_pairwise.rds`. However, this file currently contains a **synthetic Hamming-distance model**, NOT the real experimental data. The real BsmBI cycling 256×256 matrix has been extracted from tatapov/Pryor 2020 and validated (see `260302_overhang_fidelity_comparison/data/bsmbi_cycling_matrix.csv`). **Action: import the real BsmBI matrix** as an RDS and use it for both P_fid and P_eff computation.

**Functions to modify in `R/06_overhang_selection.R`:**
1. **`oogga_score()`** → Simplify to `fid_lookup[oh] * eff_lookup[oh]`. Remove `hf_set`, `w_hf` params. Rename to `overhang_score()`.
2. **`compute_overhang_efficiency()`** → Rewrite to take the BsmBI cycling matrix. Same formula: `P_eff(X) = M[X][RC(X)] / max_Y(M[Y][RC(Y)])`.
3. **`precompute_boundary_scores()`** → Remove `hf_set` and `bsai_matrix` params. Keep `eff_lookup` (now sourced from BsmBI). Keep palindrome/homopolymer/low-fidelity penalties.
4. **`search_tile_boundaries_dp()`** → Keep `eff_lookup` passthrough (now BsmBI-sourced).
5. **`find_best_superblock_splits()`** → Remove `hf_set` from scoring; keep `eff_lookup`.
6. **`find_cassette_split_points()`** → Remove `hf_set` from scoring; keep `eff_lookup`.
7. **`plan_assembly()`** → Replace `potapov_matrix` loading with BsmBI matrix loading for P_eff. Remove `hf_set` from scoring path. Keep `oh_fidelity` (BsmBI) for P_fid.
8. **`select_oh3_oh4()`** → Remove HF set preference logic; rank by `P_fid * P_eff` (both BsmBI).

**Data file changes:**
- **Import real BsmBI matrix:** Convert `260302_overhang_fidelity_comparison/data/bsmbi_cycling_matrix.csv` to `data/neb_overhang_fidelity/bsmbi_cycling_pairwise.rds` (real 256×256 experimental matrix from Pryor 2020)
- **Keep existing files** for reference but stop loading synthetic Hamming-model pairwise matrices during scoring

**Functions/data to keep (read-only reference):**
- `load_high_fidelity_set()` — keep for documentation/comparison, don't use in scoring
- `data/neb_overhang_fidelity/*.rds` — keep all existing files; they're small and useful for analysis

**Tests to update:** Any test that passes `hf_set` or `w_hf` to scoring functions. Tests that check HF bonus behavior should be removed or replaced with tests verifying `P_fid * P_eff` scoring. Tests using `eff_lookup` should verify the BsmBI source.

**Existing penalties (UNCHANGED):**
- Palindrome penalty: -10.0 for gene-derived overhangs (oh1, oh2) that are palindromic
- Homopolymer blacklist: hard exclusion for AAAA/CCCC/GGGG/TTTT
- Low-fidelity penalty: -5.0 when BsmBI P_fid < 0.50
- These all use BsmBI P_fid already, so they benefit from the standardization

- **References:**
  - Potapov et al. 2018. ACS Synth Bio 7(11):2665-2674. PMID: 30335370
  - Pryor et al. 2020. PLOS ONE 15(9):e0238592. PMID: 32877448. PMC7467295
  - Sikkema et al. 2023. Current Protocols 3(9):e882. PMID: 37755329
  - Mukundan & Madhusudhan 2025. bioRxiv 10.1101/2025.06.16.659877 (preprint)
  - `tatapov` Python library (Edinburgh Genome Foundry) — repackages both Potapov/Pryor datasets
  - Full comparison analysis: `260302_overhang_fidelity_comparison/`

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

## Future Optimizations

### OPT-001: Gene-end overhang — place BsmBI junction in 3' cassette instead of last codon
- **Status:** IDEA — to explore later
- **What:** Currently, the last tile's oh2 is forced to be the last 4 nt of the CDS (gene-derived). If that 4-mer happens to be a palindrome or low-fidelity overhang (e.g., TTAA), there's no way to avoid it. The idea is to shift the BsmBI junction a few nucleotides downstream into the 3' cassette (WPRE, polyA, or PolIII), giving more overhang choices.
- **How it would work:**
  - Oligo carries `[last codons of gene] + [first few nt of cassette]`
  - Trailing WT block starts from that cassette position onward
  - The oh2 becomes a cassette-derived 4-mer instead of gene-derived
- **Trade-offs:**
  - (+) Gene-independent overhang choice at the 3' end
  - (+) Can avoid palindromic/low-fidelity overhangs at the gene terminus
  - (-) Slightly increases oligo length for trailing tile (a few extra nt of cassette sequence)
  - (-) Tiling module (`05_tiling.R`) would need to know about the cassette sequence
  - (-) Only helps the very last tile
- **Implementation:** Extend `precompute_boundary_scores()` to score a virtual boundary at `gene_len + offset` for small offsets into the cassette. Requires passing cassette sequence to the tiling module. The DP would then naturally pick the best position (gene-end or cassette-start) based on overhang quality.

### OPT-002: Gene-start overhang — place BsaI junction in Kozak sequence instead of ATG
- **Status:** IDEA — to explore later
- **What:** Currently, the first tile's oh1 (= oh_L) is forced to be the first 4 nt of the CDS, which is always ATG + first nt of codon 2 (gene-dependent). Moving the BsaI junction upstream into the Kozak consensus sequence (part of the destination vector backbone) could provide a gene-independent, high-quality overhang.
- **Kozak consensus:** Standard mammalian Kozak is `GCCACCATGG` (positions -6 to +4 relative to A of ATG).
- **Candidate overhangs from Kozak:**

  | Position | Overhang | GC% | Palindromic? | Notes |
  |----------|----------|-----|-------------|-------|
  | -3 to +1 | **ACCA** | 50% | No | **Best candidate.** Balanced GC, good fidelity, splits cleanly between Kozak and ATG. Oligo carries `ACCA` + `TG` + [tile]. |
  | -2 to +2 | CCAT | 50% | No | Good. Splits ATG across junction (reconstructed by ligation). |
  | -6 to -3 | GCCA | 75% | No | Appears in published HF sets. High GC. |
  | -5 to -2 | CCAC | 75% | No | Risk of cross-talk with CACC. |
  | -4 to -1 | CACC | 75% | No | **Avoid.** Experimentally shown to have very low ligation efficiency (~234/100k in Strzelecki et al. 2024 NAR). |
  | -1 to +3 | CATG | 50% | **YES** | **Avoid.** Palindromic — self-ligation. |

- **Advantages:**
  - oh_L becomes gene-independent and universal (same overhang for all genes)
  - Can pick a high-fidelity, non-palindromic overhang (ACCA recommended)
  - Eliminates the ATG"N" variability that currently affects BsaI reaction set fidelity
- **Disadvantages:**
  - Oligo carries 2-6 extra nt of fixed Kozak sequence, reducing tile budget
  - Assumes standard GCCACC Kozak in the destination vector — non-standard Kozaks would cause mismatches
  - PaqCI site positioning must be upstream of the Kozak junction
  - Kozak is typically part of the backbone, not the gene insert — architectural implications for Level 2
- **References:** Kozak 1987; Strzelecki et al. 2024 NAR (ligation efficiency data); Potapov et al. 2018 (fidelity data).
- **Implementation:** Add a config option `junction_mode: "gene_start" | "kozak"`. When "kozak", define oh_L from the configured Kozak sequence rather than `substring(cds, 1, 4)`. Requires Kozak sequence as a config parameter.

### OPT-003: Blacklist palindromic overhangs from boundary selection
- **Status:** READY TO IMPLEMENT
- **What:** Palindromic 4-nt overhangs (sequence = reverse complement) are problematic for Golden Gate assembly because they enable self-circularization and inverted-insertion products. None of the 16 palindromes appear in the Potapov HF Set 3, and under BsmBI-specific conditions, 7 of 16 have fidelity < 0.60 (worst: CGCG = 0.404). The current T4 ligase-based scoring dramatically overestimates their performance (e.g., GATC shows 0.950 in T4 but 0.582 under BsmBI), so most palindromes escape the existing -5.0 low-fidelity penalty.
- **The 16 palindromes:** AATT, ATAT, ACGT, AGCT, TATA, TTAA, TGCA, TCGA, CATG, CTAG, CCGG, CGCG, GATC, GTAC, GCGC, GGCC
- **BsmBI fidelity of worst palindromes:** CGCG (0.404), GCGC (0.432), GGCC (0.454), AGCT (0.512), CCGG (0.564), GATC (0.582), GTAC (0.584)
- **Two-tier handling (penalty vs blacklist):**
  - **Gene-derived overhangs (oh1, oh2 at tile boundaries):** HEAVY PENALTY (-10.0) but NOT impossible. A gene could end in TAA (stop codon) making the last tile's oh2 = TTAA (palindrome). Since gene-derived overhangs can't be changed, we penalize but still allow them as a last resort.
  - **Freely-chosen overhangs (oh3, oh4, SB junction selections):** HARD BLACKLIST. Same treatment as homopolymers. These overhangs are chosen by the pipeline, so palindromes can always be avoided.
- **Planned implementation:**
  1. Add `PALINDROMIC_4NT` constant in `constants.R` (all 16 palindromes)
  2. Hard blacklist for freely-chosen overhangs (oh3, oh4, SB junctions) — same treatment as `HOMOPOLYMER_4NT`
  3. Heavy penalty (-10.0) in `precompute_boundary_scores()` for boundaries where oh1 or oh2 is palindromic — penalty makes DP avoid them, but doesn't make them impossible when no alternative exists
  4. Add palindrome check in superblock junction scoring (`09_wt_geneblock_design.R`)
- **Impact on boundary selection:** Only 7-14% of codon boundaries have a palindromic oh. Every 31-codon window tested has 24+ palindrome-free positions. No boundary selection failures expected.
- **Also consider:** Blacklisting/penalizing CG-rich non-palindromic overhangs with BsmBI fidelity < 0.50 (27 additional overhangs, e.g., CGCC: 0.355, CCGC: 0.378, CACC: 0.417). These are almost as bad as palindromes under BsmBI conditions.
- **Related:** Consider switching scoring from built-in T4 ligase data to BsmBI-specific pairwise data (`data/neb_overhang_fidelity/bsmbi_overhangs.rds`) for more accurate boundary scoring.

### OPT-004: Configurable DP K-range with diminishing-returns stopping
- **Status:** IMPLEMENTED
- **What:** Config parameter `dp_k_range` (default 5) controls the search range for multi-K tile boundary optimization. `search_tile_boundaries_dp()` searches K_ideal +/- `dp_k_range` tile counts. Diminishing-returns stopping halts the search when average score improvement drops below 0.5%. When two K values produce similar scores, the K with fewer gene blocks is preferred (lower synthesis cost).
- **Config:** `dp_k_range: 5` (integer, default 5), `multi_k_search: true` (boolean, default true)

### OPT-005: Joint tile-boundary + superblock optimization (iterative DP with blacklisting)
- **Status:** IMPLEMENTED — fixes BUG-007 collisions
- **What:** Iterative DP with SB-aware blacklisting replaces the old unreliable ±1 tile shift heuristic. The algorithm: (1) run standard tile boundary DP, (2) simulate SB partitioning, (3) check for oh2-vs-oh1 collisions, (4) if collision found, blacklist the colliding oh2 values and re-run DP. Iterates up to 5 times until collision-free. Across all K values, prefers the collision-free solution with best average score.
- **Implementation:** `R/06_overhang_selection.R` — `precompute_boundary_scores()` accepts `blacklisted_oh2` parameter; `plan_assembly()` contains the iterative loop with trial SB partitioning and collision detection.

## Verified NOT Bugs

| Claim | Status |
|-------|--------|
| First overhang ATG"N" not handled correctly | **OK.** `oh_L = substring(cds, 1, 4)` correctly uses gene-derived overhang. |
| `create_bsmbi_block()` has same duplication as BsaI blocks | **Not a bug.** BsmBI gene_seq starts at `tile$end_nt + 1`, no overlap. |
| `check_and_fix_new_sites()` window too small | **Not a bug.** Uses 14-nt window — more than enough for any 7-nt recognition site. |
