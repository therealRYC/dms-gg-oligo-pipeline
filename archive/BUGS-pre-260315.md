# Created: 2026-02-20
# Last updated: 2026-03-14 — BUG-010, BUG-011: Critical assembly failures exposed by full pipeline benchmark

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
- **File:** `R/09_wt_geneblock_design.R` (`find_cassette_split_points`, `build_cassette_subblocks`), `R/06_overhang_selection.R`
- **Fixed in:** cassette splitting implementation (2026-03-01), guard condition fix (2026-03-05)
- **What:** When the downstream cassette (intergene elements + PolIII) exceeds ~1778 nt, it is now automatically split across multiple BsmBI-connected gene block fragments. Split points are chosen at positions with high-fidelity BsmBI overhangs, using the same OOGGA scoring as gene superblock junctions. After ligation, the cassette is reconstructed seamlessly.
- **Guard condition fix (2026-03-05):** The original guard required `cassette_alone > 1778` to trigger splitting. This missed the "danger zone" where a medium cassette (400–1778 nt) combined with a large gene residual exceeds 1800 nt total (e.g., TRIO: 1374 nt gene residual + 1090 nt cassette = 2464 nt). Removed the `nchar(polIII_for_block) > max_sub_content` guard from both Path 1 (no gene splits) and Path 2 (with gene splits). When SB DP cassette_splits are available, the gene sub-block now includes cassette content up to the split point (trim-4 convention), and the remaining cassette is built as separate sub-blocks.
- **Defense-in-depth:** `plan_assembly_v2()` now warns if gene_residual + cassette exceeds limit but no SB DP cassette boundary was placed.
- **Verified:** GRIN2A long cassette test case (P2A-EGFP + WPRE + spacer + hGH polyA = 2133 nt) successfully split into 2 fragments at position 1045 (overhang ACCA), all 64 gene blocks within synthesis limit. Medium cassette regression test (1100 nt cassette + 2100 nt gene) passes with 0 oversized blocks.

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
- **Scoring formula (updated 2026-03-02, BUG-008):** Score = `P_fid_bsmbi(oh) * P_eff_bsmbi(oh)`. Both metrics from BsmBI cycling matrix (Pryor 2020). HF set bonus dropped — under cycling, pairwise misligation is negligible. HF set membership retained as informational column only.

### F17: Overhang scoring mixed data sources from different experimental conditions (was BUG-008)
- **File:** `R/06_overhang_selection.R`, `R/09_wt_geneblock_design.R`, `R/constants.R`, `data/neb_overhang_fidelity/`
- **Fixed in:** 2026-03-02 (commits `6f68c6d`..`79198b6`)
- **What:** The OOGGA scoring formula drew P_fid from BsmBI cycling, P_eff from T4 static, and HF bonus from T4 25°C/18h — three different experimental conditions. The composite score didn't correspond to any single experimentally-measured system.
- **Fix:** Standardized on BsmBI cycling matrix (Pryor et al. 2020) for both P_fid and P_eff. Scoring formula: `Score = P_fid_bsmbi * P_eff_bsmbi`. Removed `DEFAULT_HF_BONUS_WEIGHT`, `hf_set` param from all scoring/split functions. Created `bsmbi_cycling_pairwise.rds` from real experimental data. HF set membership retained as informational column only (Potapov Table 1 Set 3 constant).
- **Analysis:** Full comparison of T4 static vs BsaI/BsmBI cycling in `260302_overhang_fidelity_comparison/`.

### F18: DP boundary searches missing OOGGA collision prevention (was BUG-009)
- **File:** `R/06b_oogga_dp.R` (new), `R/06_overhang_selection.R` (dispatch rewrite)
- **Fixed in:** branch `260309-oogga-comparison` (commits `2d69d04`, `efedadc`, `dffdf8c`)
- **What:** All DP-based boundary searches pre-computed scores per position independently with no awareness of which overhangs were chosen at previous boundaries. Two boundaries could produce the same 4-mer overhang, causing misligation.
- **Root cause:** Missing OOGGA's `__overlap_pass()` — the collision check inside the DP transition that traces back through ALL prior boundary overhangs and rejects candidates sharing >2/4 positional bases with any prior OH or its RC.
- **Fix (4 parts):**
  1. **Fixed 4 OOGGA Python↔R discrepancies**: Removed extra `identity(RC(A),B)` check (redundant, not in OOGGA). Added self-palindrome check. Switched scoring from additive to multiplicative (OOGGA uses `∏(eff_i × fid_i)`). Kept beam search as improvement over OOGGA's single-path.
  2. **SB-first architecture rewrite**: Pass 1 finds SB boundaries on full gene+cassette. Pass 2 finds tile boundaries within each SB segment with SB junction OHs as alien constraints. (Previously was tiles-first, which is backwards.)
  3. **Performance optimization (20-76x speedup)**: Precompute position-dependent but path-independent checks (self-palindrome, alien compat, oh1/oh2 mutual) once before DP loop. Only path-dependent checks remain in inner loop.
  4. **max_identity fallback**: If DP infeasible at mi=2, retry at mi=3, then error. Never falls back to collision-unaware DP.
- **Verified:**
  - 117 OOGGA-specific tests + 1149 cross-language equivalence tests (vs OOGGA Python golden reference)
  - Benchmark: all OOGGA methods achieve 0 mi3 violations (baseline DP had 3 mi2 violations)
  - `oogga_greedy` best overall: fastest (~4s), highest fidelity (0.995), 0 mi3 violations
- **References:** Mukundan & Madhusudhan (2025). OOGGA. bioRxiv 10.1101/2025.06.16.659877. GitHub: bigbigdumdum/OOGGA.
- **Cross-language equivalence**: `identity(A, RC(B)) ≡ identity(RC(A), B)` proven mathematically (substitution j=3-i). The "extra" 3rd condition was redundant, not wrong — 2-condition and 3-condition compat matrices are identical.

## Open Bugs

### BUG-010: Hundreds of variants skipped per gene — zero should be skipped
- **File:** `R/05_tiling.R` (`assign_variants_to_tiles()`), `R/08_oligo_assembly.R`
- **Status:** OPEN — critical, blocks production use
- **Severity:** Critical — pipeline silently drops mutational coverage at gene edges
- **Discovered:** 2026-03-14 (full pipeline benchmark on 4 genes)
- **What:** Every gene run skips hundreds of variants with "partial oh1/oh2 overlap":

  | Gene | Variants skipped | % of total |
  |------|-----------------|------------|
  | GRIN2A | 210 | 0.7% |
  | AKAP11 | 273 | 0.7% |
  | TRIO | 546 | 0.8% |
  | GRIN2A_ext | 147 | 0.5% |

  These are variants near the gene start (ATG) and gene end (stop codon) where the
  tile's oh1/oh2 overhang overlaps with the mutable region. The pipeline flags them
  as `partial_oh_overlap` and excludes them from the oligo pool.
- **Expected behavior:** Zero skipped variants. Every position in the gene (except
  Met1 and the stop codon itself) should be mutable. The DIMPLE paper recommends a
  4 nt buffer past ATG and stop to avoid library biasing at gene edges.
- **Related:** BUG-003 (boundary codon mutations) describes the same root cause but
  proposed a partial rescue approach. The real fix may require architectural changes
  to how gene-edge overhangs are handled (see OPT-001 and OPT-002 for ideas).
- **Benchmark data:** `benchmarks/260314_full_pipeline_run/*/pipeline_log.txt`

### BUG-011: In-silico assembly simulator fails on nearly all tiles
- **File:** `R/10b_gg_simulator.R` (`simulate_pipeline_assembly()`, `digest_sequence()`, `ligate_fragments()`)
- **Status:** OPEN — critical, indicates assemblies are broken OR simulator is broken
- **Severity:** Critical — if the simulator is correct, the designed assemblies do not work
- **Discovered:** 2026-03-14 (full pipeline benchmark on 4 genes)
- **What:** The assembly simulation fails on the vast majority of tiles:

  | Gene | Pass | Fail | Rate |
  |------|------|------|------|
  | GRIN2A | 1/25 | 24 | 4% |
  | AKAP11 | 1/31 | 30 | 3% |
  | TRIO | 1/53 | 52 | 2% |
  | GRIN2A_ext | 1/24 | 23 | 4% |

  Failure modes:
  - Most tiles return `NA` for assembled product (fragments don't ligate)
  - A few tiles report "ambiguous ligation" (2 fragments match same oh_5)
  - Only 1 tile passes per gene (always tile with specific geometry)
- **Expected behavior:** All tiles should pass. The simulator digests oligo + WT gene
  blocks with BsmBI/BsaI, identifies matching overhangs, and ligates in order. If
  this fails, either (a) the designed overhangs/enzyme sites are incorrect, or
  (b) the simulator has a bug. Either way, this must be resolved before production.
- **Investigation needed:** Trace a single failing tile end-to-end: extract the oligo +
  gene blocks, manually simulate digestion, check if overhangs match. This will
  determine whether the design or the simulator is at fault.
- **Benchmark data:** `benchmarks/260314_full_pipeline_run/*/pipeline_log.txt`
- **Pre-existing test failure:** `tests/testthat/test-gg-simulator.R:309`

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
