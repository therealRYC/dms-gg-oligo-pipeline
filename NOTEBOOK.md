<!-- Created: 2026-03-07 -->
<!-- Lab notebook retroactively constructed from git history, PR descriptions, planning docs, and bug tracking -->

# Lab Notebook — DMS GG Oligo Pipeline

**Project:** dms-gg-oligo-pipeline
**PI:** Doug Fowler, University of Washington
**Author:** Robert Chen (robchen@uw.edu)
**Repo:** github.com/therealRYC/dms-gg-oligo-pipeline
**Start date:** 2026-01-29

## Project Context

R pipeline for designing oligonucleotide pools for Deep Mutational Scanning (DMS) using a 3-enzyme Golden Gate assembly strategy (BsaI + BsmBI + PaqCI). Each oligo encodes a single specified amino acid substitution at one position in the gene, with a pre-assigned barcode for variant tracking. The pipeline outputs oligo pool sequences for Twist synthesis, WT gene block sequences, and a variant-barcode mapping file.

## Key Questions

1. How do we design a Golden Gate assembly scheme that keeps the tile and barcode on the same oligo through all pooled steps (preventing tile-barcode scrambling)?
2. What overhang scoring approach best predicts actual Golden Gate assembly fidelity under BsmBI cycling conditions?
3. How do we handle genes too long for single gene block synthesis (>1800 nt regions)?
4. What barcode generation algorithm guarantees minimum Hamming distance while scaling to >300K barcodes?

## Decision Log

| Date | Decision | Rationale | Ref |
|------|----------|-----------|-----|
| 2026-01-29 | 3-enzyme architecture (BsaI + BsmBI + PaqCI) | Orthogonal enzymes allow keeping tile + barcode on same oligo | Entry 1 |
| 2026-01-29 | Fully specified codons (no NNK/NNS) | Precise control over each mutation; human codon-optimized | Entry 1 |
| 2026-01-29 | Programmed barcodes with prefix optimization | Pre-assigned barcodes enable OPS compatibility | Entry 1 |
| 2026-02-16 | DP tile boundary optimizer over greedy search | DP globally optimizes overhang fidelity across all boundaries | Entry 5 |
| 2026-02-18 | Unified barcode mode (no OPS/standard split) | Single prefix-suffix hierarchy serves all readout modes | Entry 7 |
| 2026-02-18 | Global superblock DP (replaced by tile-boundary SBs on 02-26) | Gene block reuse across tiles; later replaced for correctness | Entry 7 |
| 2026-02-18 | Derive oh3 from PolIII promoter 3' end | Gene-independent, high-fidelity overhang (CACC, fid=0.969) | Entry 7 |
| 2026-02-21 | CoCoPUTs codon usage over Kazusa | 119K CDS, GRCh38.p13; Kazusa from 2007 is outdated | Entry 9 |
| 2026-02-22 | GF(4) linear codes for barcode prefixes | Algebraic guarantee of Hamming distance, no O(n^2) validation | Entry 10 |
| 2026-02-25 | Intergene elements support (WPRE, polyA, etc.) | Flexible downstream cassette for different readout assays | Entry 11 |
| 2026-02-26 | Tile-boundary superblocks over global DP | Fixes BUG-005; SBs split at tile boundaries only; per-tile overhang scope | Entry 12 |
| 2026-02-26 | Potapov Table 1 Set 3 (25 overhangs) as HF set | Simulated annealing-optimized for set fidelity, not greedy individual fidelity | Entry 12 |
| 2026-02-26 | OOGGA-style scoring: P_fid * P_eff * HF_bonus | Multiplicative formula balances fidelity, efficiency, and HF membership | Entry 12 |
| 2026-03-01 | Backwards-sweep SB partitioning | Sizes last SB first to accommodate cassette; avoids 1-tile SBs | Entry 17 |
| 2026-03-02 | BsmBI cycling matrix for all scoring | Standardize on one experimental condition; T4 data overestimates fidelity | Entry 18 |
| 2026-03-03 | WT controls (1 per position, always on) | Normalization controls for fitness scoring | Entry 19 |
| 2026-03-04 | SB-first two-pass DP architecture | Decide globals (SBs) first, locals (tiles) second — natural order | Entry 20 |

## Entries

---

### Entry 1 — 2026-01-29 | plan: Project planning & architecture design

**Commits:** `dc37e8c` Initial project setup with CLAUDE.md and .gitignore

Defined the complete architecture for a DMS oligo pool design pipeline using Golden Gate assembly. Key design decisions documented in CLAUDE.md:

- **3-enzyme architecture**: BsaI (Level 1a, flanks 5'WT blocks), BsmBI (Level 1b, flanks 3'WT blocks + PolIII + barcode), PaqCI (Level 2, backbone cloning). Orthogonal enzymes keep tile + barcode on the same oligo through all pooled steps.
- **Fully specified codons**: Each oligo encodes exactly one specific amino acid substitution using the most-preferred human codon. No degenerate codons (NNK/NNS).
- **Three tile types**: Leading (5' end), internal (middle), trailing (3' end), each with different oligo structures depending on position relative to gene boundaries.
- **Programmed barcodes**: Pre-assigned barcodes with prefix-optimized Hamming distance for OPS compatibility.
- **Superblock splitting**: WT gene blocks exceeding ~1800 bp synthesis limit are split into sub-blocks connected by additional BsmBI overhangs.
- **Implementation plan**: 14 R modules in dependency order, from `constants.R` through `run_pipeline.R`.

Repository structure, module responsibilities, enzyme constants, and verification plan all documented. No code written yet.

---

### Entry 2 — 2026-02-11 | session: Full pipeline implementation

**PRs:** #2, #3 | **Commits:** `bbaf952`..`2c01ede`

Implemented the complete pipeline in a single session — 14 R source modules, annotated config template, and master `run_pipeline.R` entry point.

**Architecture implemented:**
- Universal oligo structure: `BsaI_fwd + oh1 + [mutant tile] + BsmBI_rev_oh2 + BsmBI_fwd_oh3 + [barcode] + BsaI_rev_oh4` (56 nt overhead, 243 nt max mutable region at 300 nt oligo limit)
- Full 256-overhang NEB fidelity data (Potapov 2018), 117 overhangs >= 0.95 threshold
- Vectorized prefix-first barcode algorithm (~14,800 capacity at k=8/d=3 in ~1.4s)
- Automatic superblock splitting for WT gene blocks exceeding synthesis limit
- Silent codon domestication for endogenous BsaI, BsmBI, and PaqCI sites

**Test results:** 725 tests passing across 11 test files (77s), including integration tests on 300-nt, 2100-nt, and 9294-nt (TRIO) genes.

**Performance issue identified:** `has_enzyme_sites()` via `find_enzyme_sites()` extremely slow for batch barcode operations (156s for 65K sequences). Replaced with vectorized `grepl()` with `fixed=TRUE` (<0.1s). Similarly, `gc_content()` with `strsplit` slow — used `nchar(gsub("[AT]","",seqs))` for batch GC.

---

### Entry 3 — 2026-02-13 | research: Literature comparison — Jann et al. 2025

**PRs:** #4 | **Commits:** `095755f`

Detailed comparison of our 3-enzyme Golden Gate pipeline with the Gibson + Golden Gate oPool method from Jann et al. (PLOS Biology 2026). Key findings:

- **Barcode programmability**: Our pipeline uses pre-assigned barcodes (enabling OPS); Jann uses random barcode barcoding requiring PacBio long-read sequencing for variant-barcode mapping.
- **Assembly strategy**: We use 3-enzyme GG (BsaI + BsmBI + PaqCI) with oligo pools; Jann uses Gibson assembly of oPool fragments into a backbone, then GG for barcode ligation.
- **Mutation precision**: Both use fully specified codons; similar mutation coverage.
- **OPS compatibility**: Our prefix-optimized barcodes designed for in-situ sequencing; Jann's random barcodes are not OPS-compatible.
- **Cost/scalability trade-offs**: Our approach requires gene block synthesis (one-time cost); Jann's oPool approach may be cheaper per gene but requires long-read sequencing.

Analysis archived in `archive/260212/260212-comparison-vs-Jann2025.md`.

---

### Entry 4 — 2026-02-14 | plan: Refactoring plan (Round 01)

**PRs:** #5 | **Commits:** `517058b`..`b69d928`

Created a 9-task refactoring roadmap (`260213_DMS_Oligo_Pool_Refinement_Plan_Round_01.md`) based on lessons from initial implementation:

- **T1**: Switch codon usage from Kazusa (2007) to CoCoPUTs (2019) — done Feb 21
- **T2**: Add optional PCR handle support on oligos — deferred
- **T3**: Fix overhang selection to use pairwise ligation matrix, not individual fidelity — done Feb 26
- **T4**: Scale barcode generation to 10x coverage (200K+ barcodes) — done Feb 18
- **T5**: Add PolIII-aware barcode filters (poly-T) — done Feb 22
- **T6**: Tile-specific PCR handles — deferred
- **T7**: Integration tests for superblock reuse — done Feb 26
- **T8**: Enhance barcode QC reporting (Hamming distance stats) — done Feb 17
- **T9**: Review set-level overhang fidelity thresholds — done Feb 26

Also began the overhang strategy refactoring plan that evolved into the DP tile boundary optimizer.

---

### Entry 5 — 2026-02-16 | session: DP tile boundary optimizer + OPS barcodes

**PRs:** #6, #7, #8 | **Commits:** `b69d928`..`1fc84fe`

Major session implementing two features: dynamic programming tile boundary optimization and OPS barcode mode.

**DP tile boundary optimizer (PR #6):**
- Replaced fixed tile boundaries with a DP optimizer that jointly selects tile boundaries and overhang fidelity
- Implemented sliding window approach (`search_window_K` config parameter) to find boundaries with high-fidelity overhangs
- Unified `plan_assembly()` function merges tiling + overhang selection into single optimization
- Validated on GRIN2A (4395 nt) and SLC6A1 (1800 nt) — all 13 QC checks pass

**OPS barcode mode (PR #8):**
- Two barcode generation modes: OPS (prefix-first, hard prefix Hamming guarantee, soft full-barcode tolerance) and Standard (global hard Hamming distance)
- Auto-sizing `barcode_length` to minimum needed for variant count
- New functions: `estimate_barcode_capacity`, `estimate_ops_capacity`, `auto_size_barcode_length`
- Pipeline resolves barcode_length before tiling (Step 5.5) for correct oligo budget

**Assembly report (PR #6):**
- Added wetlab assembly report generation as Step 12 (`R/12_report.R`, 852 lines)
- Comprehensive Markdown report with design parameters, oligo specs, barcode mapping, tile manifests, QC results

---

### Entry 6 — 2026-02-17 | session: Assembly reports + Hamming distance output

**PRs:** #9, #10 | **Commits:** `f058799`..`e37f775`

Polish session adding barcode QC and report improvements:

- **Per-barcode Hamming distance** (PR #10): Added `compute_min_hamming_per_barcode()` — nearest-neighbor Hamming distance for every barcode. Included in `variant_barcode_map.csv` output. Logs min/median/max summary during generation.
- **Report improvements** (PR #9): Added barcode design section (Section 4) to assembly report. Fixed "?" gene block lengths by remapping manifest names after deduplication. Fixed report display bugs (alignment, domestication columns, oh_L HF flag).
- **Gene block dedup fix**: Fixed gene block lengths showing "?" in report by remapping manifest names after deduplication step.

---

### Entry 7 — 2026-02-18/19 | session: 3-enzyme redesign (unified barcodes, global SB DP, vectorized assembly)

**PRs:** #11, #12 | **Commits:** `1f94dc3`..`49f992a`

Major architectural session with four interconnected changes (PR #11):

- **Unified hierarchical barcode mode**: Replaced dual OPS/standard barcode paths with a single prefix-suffix architecture. One unique prefix per variant with hard Hamming guarantee, random filtered suffixes for replicates. Eliminates mode-switching complexity.
- **Global superblock DP**: Redesigned superblock splitting from per-tile independent optimization to global DP that maximizes gene block reuse across tiles. (Later replaced by tile-boundary SBs on Feb 26.)
- **PerturbView oh3 derivation**: Derived oh3 (CACC, fidelity=0.969) from PolIII promoter 3' end instead of selecting from HF set. Updated promoter to PerturbView hU6+T7 sequence. Gene-independent, high-fidelity overhang.
- **Vectorized oligo assembly**: Rewrote Step 8 with local tile mutation, pre-computed enzyme sites, and vectorized `paste0` per tile. Speedup: **2001s → 0.7s** at 10 bpv (289K oligos) — 2,858x improvement.

PR #12 updated README, added .Rproj file, fixed DESCRIPTION wording. Test suite: FAIL 0 | WARN 2 | SKIP 1 | PASS 1917.

---

### Entry 8 — 2026-02-20 | retro: Bug fix marathon (F1-F10) + GG assembly simulator

**PRs:** #13, #14, #15, #16 | **Commits:** `0231ada`..`7d880dc` | **Bugs fixed:** F1-F10

Intensive debugging session — 10 bugs found and fixed across 4 PRs, driven by building an in-silico GGA validator.

**In-silico GG simulator (PR #14, `R/13_gg_simulator.R`):**
- Simulates BsaI + BsmBI digestion, ligation, and product verification
- Uncovered F1 (orient_enzyme_site wrong RC formula) — all reverse enzyme sites producing non-complementary overhangs. Benchling rejected all GRIN2A assemblies.
- Config: `simulate_assembly` and `simulation_samples_per_tile` options

**Critical bugs found (PRs #14-16):**
- **F1** (CRITICAL): `orient_enzyme_site()` reverse case used `RC(recog + spacer + overhang)` instead of `RC(recog + spacer + RC(overhang))`. All reverse sites wrong.
- **F2**: `create_bsai_block()` duplicated oh_5prime (4 nt extra in 5'WT blocks)
- **F3**: Oligo names not unique when `barcodes_per_variant > 1`
- **F4**: No tile overlap at boundaries — ~7% of variants silently lost. Fixed with 4-codon overlap + smart variant assignment.
- **F5**: Barcode junction enzyme sites not checked (oh3-barcode boundary)
- **F6**: QC check #3 was a no-op
- **F7**: Codon 1 (Met) and last codon (stop) mutations generated but unassemblable
- **F8**: Python validator extracted wrong overhang for reverse sites (0/1960 pass → 1958/1960)
- **F9**: Gene-edge codons (pos 2, pos n-1) overlap oh1/oh2 overhangs — ~40 variants blanket-skipped
- **F10**: Integration tests skipped barcode junction context — ~2 variants per run got BsmBI-creating barcodes

**Lesson**: Building an assembly simulator was the most effective debugging tool. Uncovered bugs that unit tests couldn't catch because they required multi-component integration.

Also added `gene_cds` config option, `gene_name` config, `_sequences.fasta` output, and moved run configs to `examples/` (PR #13).

---

### Entry 9 — 2026-02-21 | session: CoCoPUTs codon usage + superblock junction fixes

**PRs:** #17, #18, #19 | **Commits:** `a4ce1d5`..`041ce71` | **Bugs fixed:** F11, F12

Two independent improvements:

**CoCoPUTs codon usage (PR #17):**
- Replaced Kazusa codon usage table (last updated 2007, GenBank release 160) with CoCoPUTs (Alexaki et al. 2019, J Mol Biol) — 119,196 CDS, 77.5M codons, GRCh38.p13
- 19/21 preferred codons identical to Kazusa; N→AAT (was AAC) and P→CCT (was CCC) — near-tied alternatives
- Added `codon_table_path` config param for user-supplied custom tables (.csv/.rds)
- Technical note: CoCoPUT TSV has trailing-tab column-shift issue — must use cols 14:77 with `row.names=NULL`

**Superblock junction bugs (PR #18, BUG-001 = F11):**
- Three related bugs in `R/09_wt_geneblock_design.R` causing assembly failures on all tiles with superblocked gene blocks:
  1. BsaI sub-blocks after the first used wrong oh_5 (gene position instead of junction overhang) → ligation failure
  2. BsaI non-final sub-blocks included trailing junction OH, duplicated by next sub-block → 4-nt insertion
  3. BsmBI non-final sub-blocks had same trailing OH duplication → 4-nt insertion
- Fix: Use junction overhang for oh_5 on non-first sub-blocks; trim `sub_end - 4L` for non-final sub-blocks
- Verified: 66/66 tiles pass assembly simulation + product verification (GRIN2A, 22 tiles, 47 blocks)

**Barcode edge case (PR #18, F12):** Increased minimum suffix candidates from 10 to 500; added prefix junction filtering (48 prefixes removed for GRIN2A).

Also updated GRIN2A CDS to native NCBI sequence (NM_000833.5), cleaned up repo (PR #19).

---

### Entry 10 — 2026-02-22 | session: GF(4) linear codes for barcode prefixes

**PRs:** #20 | **Commits:** `28bd565`..`bb7068a`

Replaced the O(n^2) greedy prefix generation algorithm with algebraically optimal methods.

**New module `R/07b_linear_codes.R`:**
- Implements GF(4) arithmetic (addition, multiplication, dot product) over the field GF(2^2)
- Constructs quaternary Hamming codes with parameters [n, n-3, >=3]_4
- Gaussian elimination for systematic form and code shortening
- Codeword enumeration (k <= 12) and sampling (larger codes)
- All codewords guaranteed minimum Hamming distance >= 3 by linearity (algebraic, not empirical)

**Unified prefix generation entry point (`generate_prefixes()`):**
- Tries GF(4) Hamming code first (d <= 3), falls back to DNABarcodes Conway heuristic, then Ashlock
- Deleted all greedy methods (`generate_prefixes_greedy`, `generate_prefixes_random_greedy`, `generate_prefixes_greedy_excluding`)
- Skips O(n^2) distance validation for algebraic codes — distance guarantee is by construction

**Also implemented:**
- PolIII terminator signal filter (TTTT) in barcodes — prevents premature Pol III transcription termination
- `POLIII_TERM_SEQ` constant in `R/constants.R`
- Vectorized `filter_barcodes_batch()` for single-pass filtering (enzyme sites, homopolymers, GC, junction context)
- Documented BUG-003 (boundary codon rescue plan) in BUGS.md

---

### Entry 11 — 2026-02-25 | session: Intergene elements + AKAP11 debugging

**PRs:** #21, #23 | **Commits:** `d05de24`..`5938353` | **Bugs documented:** BUG-004, BUG-005, BUG-006

Two major efforts: flexible downstream cassette support and first real-gene debugging with AKAP11.

**Intergene elements (PR #21):**
- Added optional `intergene_elements` config list allowing users to place additional sequence elements (reporters, selection cassettes, IRES, etc.) between the gene 3' end and PolIII promoter
- `build_downstream_cassette()` in `00_config.R` validates elements and builds `downstream_cassette = concat(intergene) + polIII_promoter`
- Per-element enzyme site scanning with warnings (intergene elements can't be silently domesticated)
- Report module generates dynamic construct diagrams showing intergene elements
- When omitted (default), pipeline behaves identically to before

**AKAP11 pipeline debugging (PR #23):**
- First run on AKAP11 (NM_016248.4, 5583 nt, 1902 codons, 31 tiles) exposed multiple gene block sizing bugs
- `min_sub_length` was passed as total block length (300 nt) instead of gene-content length (300 - 22 = 278 nt)
- `assign_global_boundaries_to_tiles()` created tiny trailing blocks (22-31 nt) and oversized blocks (1902 nt)
- Forward-pass merge didn't check max synthesis limit — turned "too small" into "too large"
- Added `MIN_GENEBLOCK_LENGTH` constant, wired `min_geneblock_length` through full call chain + QC check #15
- Result: AKAP11 block range improved from 22-1902 nt to 210-1720 nt, 84/84 tiles pass assembly simulation

**Bugs documented for later:**
- BUG-004: Large downstream cassette exceeds synthesis limit (fixed Mar 1-5)
- BUG-005: Tile 20 AKAP11 oversized 3'WT block (eliminated by tile-boundary SB architecture)
- BUG-006: HF set was greedy-generated, not from Potapov Table 1 (fixed Feb 26)

---

### Entry 12 — 2026-02-26 | session: Architecture day — OOGGA scoring + tile-boundary SBs + HF set fix

**PRs:** #24, #25, #26, #27, #28, #29 | **Commits:** `75e6bc1`..`1891deb` | **Bugs fixed:** F16

Most productive day of the project — 6 PRs merged implementing three major architectural changes, using parallel worktree development.

**1. HF set fix (PR #25, BUG-006 = F16):**
- Discovered the "Potapov" HF set was actually greedy-generated (top-20 by individual fidelity), NOT from the paper
- Replaced with actual Potapov 2018 Table 1 Set 3: 25 overhangs, 95.8% predicted set fidelity, optimized via simulated annealing
- Exact sequences verified from paper PDF (kappagate library had WRONG sequences)
- Hard-coded `POTAPOV_TABLE1_SET3_25` constant to eliminate RDS file dependency

**2. OOGGA-style scoring (PR #27):**
- Replaced ad-hoc `10 * in_HF + fidelity` scoring with multiplicative formula: `P_fid * P_eff * (1 + 0.5 * in_HF)`
- Added `compute_overhang_efficiency()` extracting P_eff from Potapov 256x256 pairwise matrix diagonal
- Applied at all 3 scoring locations: tile boundary DP, greedy SB splitter, SB DP

**3. Tile-boundary superblock architecture (PRs #26, #28, #29):**
- Replaced global superblock DP with tile-boundary partitioning: SBs split only at tile boundaries
- Per-tile overhang exclusion replaces global exclusion — eliminates BUG-005
- New functions: `partition_tile_superblocks()`, `get_tile_reaction_overhangs()`, `scan_downstream_junctions()`
- `convert_partition_to_splits()` shim for backward compatibility
- 30 TDD tests written first, then implementation to pass them
- Fixed latent PolIII-unaware split filtering bug exposed by new geometry (TRIO tile 36)

**Parallel development:** Three worktrees (`260226-hf-set-fix`, `260226-oogga-scoring`, `260226-tile-boundary-superblocks`) developed concurrently with handoff document coordinating context.

Full test suite: FAIL 0 | PASS 6109.

---

### Entry 13 — 2026-02-27 | session: Pipeline walkthrough + legacy cleanup

**PRs:** #30, #31 | **Commits:** `5035f1d`..`d32ae0e`

Post-redesign documentation and cleanup:

**Pipeline walkthrough (PR #30):**
- Three-level walkthrough (conceptual, pseudocode, code) of all 12 pipeline steps using GRIN2A
- Concrete numbers: 234 nt max mutable region, ~20 tiles, 29,260 variants, 292,600 oligos
- Documents the 3-enzyme architecture, DP tile boundary optimizer, PolIII-derived oh3, GF(4) barcodes, tile-boundary superblocks
- Includes summary table of changes vs. original CLAUDE.md

**Legacy cleanup (PR #31, -547 lines):**
- Removed `extract_tile_overhangs()` no-op wrapper
- Removed `select_fixed_overhangs()` legacy wrapper
- Deleted deprecated `compute_global_superblock_boundaries()`, `assign_global_boundaries_to_tiles()`, `compute_superblock_boundaries()` and their regression tests
- Removed dead legacy code path in `design_wt_geneblocks()` for old `superblock_boundaries` parameter
- Kept `convert_partition_to_splits()` shim — performs legitimate view transformation

Also added cassette splitting for oversized downstream cassettes (Option A), filled in actual WPRE and bGH polyA sequences in config template, enabled intergene elements by default.

---

### Entry 14 — 2026-02-28 | session: BsaI collision deep dive + overhang analysis

**Commits:** `34ee6c0`..`62207ea` | **Bugs documented:** BUG-007, OPT-001 through OPT-005

Deep analysis session on AKAP11 and GRIN2A overhang behavior:

**BUG-007 discovered and fixed:**
- BsaI superblock junction collision: SB boundary tile 17's `oh2_seq = ACCA` collided with tiles 21 and 24 (`oh1_seq = ACCA`), causing ambiguous BsaI ligation
- Added BsaI-level collision detection in Phase 4 of `partition_tile_superblocks()`
- When collisions detected, boundary shifted to avoid

**Comprehensive overhang deep dive:**
- Created detailed analysis documents for GRIN2A and AKAP11 with precise DP scores, boundary positions, gene block tables
- Analyzed all 256 4-nt overhangs for BsaI vs BsmBI fidelity differences

**Future optimizations documented (OPT-001 through OPT-005):**
- OPT-001: Gene-end overhang — shift BsmBI junction into 3' cassette for better overhang choice
- OPT-002: Gene-start overhang — place BsaI junction in Kozak sequence for gene-independent oh_L
- OPT-003: Palindrome blacklist — all 16 palindromic 4-mers have poor BsmBI fidelity
- OPT-004: Configurable DP K-range with diminishing-returns stopping — implemented
- OPT-005: Joint tile-boundary + superblock optimization with iterative DP blacklisting — implemented

---

### Entry 15 — 2026-03-01 | session: BUG-007 fix + backwards-sweep SB + TRIO support

**PRs:** #32 | **Commits:** `e08e6a7`..`fe8739d` | **Bugs fixed:** F14

Major PR overhauling overhang selection and superblock partitioning:

**Backwards-sweep SB partitioning:**
- Old forward-greedy approach produced unbalanced partitions (AKAP11: SB4 had only 1 tile)
- New algorithm: Walk backwards from last tile to size last SB for cassette fit, then forward-greedy for remaining tiles
- AKAP11 result: SB1(8), SB2(9), SB3(9), SB4(2), SB5(3) — no single-tile superblocks

**BsmBI-specific fidelity scoring:**
- Switched from built-in T4 ligase (18h, 25C) fidelity matrix to `bsmbi_overhangs.rds` (BsmBI + T4 at 42C)
- T4 data dangerously optimistic: CGCC shows 0.915 in T4 vs 0.355 under BsmBI conditions
- BsaI and BsmBI fidelity nearly identical (Pearson r = 0.976), so single matrix suffices

**Iterative DP collision resolution (OPT-005, fixes BUG-007 = F14):**
- Two-level resolution: (1) Phase 4 checks SB boundary oh2 against all tile oh1 values in later SBs, (2) iterative DP loop blacklists colliding oh2 values and re-runs tile boundary DP
- Replaces old ±1 tile shift heuristic
- AKAP11 pipeline completes with 0 collisions after iterative blacklisting

**Palindrome blacklist (OPT-003):**
- 16 palindromic 4-mers penalized (-10.0) for gene-derived overhangs, hard-excluded for freely-chosen overhangs

**Repo cleanup:** Archived dated configs, analysis docs, and planning files. Added TRIO CDS (NM_007118.4, 9294 nt). Created gene-specific config files for GRIN2A, AKAP11, and TRIO. Added TIMELINE.md with auto-update script.

Full test suite: FAIL 0 | WARN 43 | SKIP 6 | PASS 6090.

---

### Entry 16 — 2026-03-02 | retro: Overhang scoring overhaul (BUG-008)

**Commits:** `855091e`..`e467682` | **Bugs fixed:** F17

Discovered and fixed a fundamental scoring inconsistency (BUG-008):

**Problem:** OOGGA scoring formula drew P_fid from BsmBI cycling, P_eff from T4 static, and HF bonus from T4 25C/18h — three different experimental conditions. The composite score didn't correspond to any single experimentally-measured system.

**Analysis:** Created `260302_overhang_fidelity_comparison/` with:
- Python scripts for tatapov-to-CSV conversion with Pryor 2020 cross-validation
- R analysis scripts comparing T4 static vs BsaI/BsmBI cycling across all 256 overhangs
- Results summary documenting systematic T4 overestimation of CG-rich overhang fidelity

**Fix:** Standardized on BsmBI cycling matrix (Pryor et al. 2020) for both P_fid and P_eff:
- New formula: `Score = P_fid_bsmbi * P_eff_bsmbi`
- Removed `DEFAULT_HF_BONUS_WEIGHT`, `hf_set` param from all scoring/split functions
- Created `bsmbi_cycling_pairwise.rds` from real experimental data
- HF set membership retained as informational column only

**Matrix convention note:** Raw Potapov/Pryor matrix has M[X,Y] = X ligates Y. Pipeline needs M[X,X] = correct ligation of X (diagonal). Remapping: `M_new[X,Y] = M_raw[X, RC(Y)]`. Fidelity formula: `fidelity(X) = M[X][RC(X)] / sum(M[X][*])`.

Also documented WPRE/PolIII insulation design, added long cassette test config (GRIN2A + P2A-EGFP, 2133 nt cassette).

---

### Entry 17 — 2026-03-03 | session: WT controls + synonymous variants + cassette design

**PRs:** #33 | **Commits:** `b53a358`..`14f9526`

**WT controls (PR #33):**
- Added WT controls: 1 per mutable position, identical codon to wild-type with unique barcode(s), for DMS normalization
- New `variant_type` column: `"missense"`, `"nonsense"`, `"wt_control"`, `"synonymous"`
- 21 variants per position (default): 19 missense + 1 stop + 1 WT control
- Optional synonymous controls (`include_synonymous: false` default): highest-frequency alternative codon, same AA. Met/Trp skipped (single codon). 22 variants/position when enabled.
- Fixed pre-existing QC bug where variant count check didn't account for gene-edge skipped positions

**Cassette design work:**
- Replaced hGH polyA with bGH polyA (225 bp) in downstream cassette — bGH is standard in PerturbView constructs
- Documented pTK4 provenance for all cassette element sequences
- Updated plan files: marked cassette design items complete

**Example gene outputs:** Added canonical pipeline outputs for GRIN2A, TRIO, and AKAP11 to `Example Genes/`.

Full test suite: FAIL 0 | WARN 43 | SKIP 5 | PASS 6127.

---

### Entry 18 — 2026-03-04 | plan: SB-first DP refactor begins

**Commits:** `07ed352`..`16ccfaa`

Started a major architectural refactor: reversing the order of assembly planning from "tile boundaries first, then SBs" to "SBs first, then tiles within each SB."

**Motivation:** Current approach decides tile boundaries (local) first, then groups into superblocks (global), then iterates up to 5 times if collisions found (OPT-005). The SB-first approach decides globals first and locals second — the natural order.

**Architecture:**
```
Pass 1: SB DP on gene+cassette → SB boundaries (few splits, trivially fast)
Pass 2: Per-SB tile DP → tile boundaries (small, independent, parallelizable)
         Blacklist: SB boundary OHs + static OHs (oh_L, oh3, oh4)
```

**Implementation (Tasks T0-T2):**
- T0: `search_superblock_boundaries_dp()` — SB-level DP over codon boundaries, scoring by `overhang_score()`, respecting `max_sub_length` and `min_sub_length`
- T1: SB anchor overhangs and `sb_blacklist` in tile DP — tile boundary DP receives SB boundary overhangs as blacklisted to prevent collisions
- T2: `plan_assembly_v2()` — two-pass orchestration function

Also replaced synthetic pairwise matrices with real Pryor 2020 data, removed HF set annotations from assembly report.

Plan doc: `Notes/260304_sb-first-dp-refactor.md`.

---

### Entry 19 — 2026-03-05 | session: SB-first validation + convergence problem discovered

**Commits:** `f7160b8`..`3dd7b24` | **Bugs fixed:** F13 (guard condition)

Intensive implementation and validation day for the SB-first architecture:

**Implementation completed:**
- Hard codon constraint for SB boundaries in gene portion — SB splits must fall on codon boundaries
- SB-boundary tile overlap via post-extension — tiles at SB boundaries get extended to include 4-codon overlap
- Cassette boundary pass-through from SB DP to gene block design
- Switched `run_pipeline.R` to use `plan_assembly_v2()` (SB-first two-pass DP)
- Removed anchor_oh1/anchor_oh2 from tile DP (unnecessary with blacklist approach)

**Validation reports generated:** GRIN2A, AKAP11, TRIO with 10 barcodes per variant.

**BUG-004 guard condition fix (F13):**
- Original guard required `cassette_alone > 1778` to trigger splitting
- Missed "danger zone" where medium cassette (400-1778 nt) + large gene residual > 1800 nt total (TRIO: 1374 + 1090 = 2464 nt)
- Removed guard from both Path 1 and Path 2; when SB DP cassette_splits available, gene sub-block includes cassette content up to split point

**Convergence issue identified:** Local refinement added to SB DP for overhang collision avoidance, but the interplay between SB boundary selection and tile OH collision created a convergence problem that required further investigation.

Tile DP mechanics and overlap explanation doc added: `Notes/260305_tile-dp-mechanics-and-overlap.md`.

---

### Entry 20 — 2026-03-06 | retro: Pivot to hybrid planner + collision fixes

**Commits:** `7e76680`..`cd674d9`

Pivoted from pure SB-first architecture to a hybrid approach after discovering limitations:

**Hybrid assembly planner:**
- The pure SB-first approach struggled when SB boundary overhangs created downstream collisions with tile overhangs that hadn't been chosen yet
- New hybrid: tile-first DP (as before) + constrained SB DP that respects tile boundary decisions
- `plan_assembly_v2()` updated to use hybrid strategy

**Collision fixes:**
- Fixed cassette junction OH collision with tile DP homopolymer blacklist
- Pre-blacklist tile OHs for cassette SB boundaries
- **Scoped collision loop blacklisting**: Previously, cassette-region collisions were added to global blacklist, over-constraining gene-region boundary selection. Fixed by classifying collisions as cassette vs gene region and scoping blacklists accordingly.

Plan doc: `Notes/260306_bug-c-collision-loop-scoping.md`.

Assembly reports generated from collision-loop-scoping runs for validation.

---

### Entry 21 — 2026-03-07 (AM) | session: Report OH display improvements

**Commits:** `2849752`..`73ab689`

Report quality improvements:

- Added `oh_5`/`oh_3` columns to all block data frames — explicit overhang metadata on every gene block
- Fixed report OH display: use block metadata instead of junction indices (was showing wrong overhangs for deduplicated/reused blocks)
- Recompute reaction fidelity from actual block overhangs (not estimated from tile partition)
- Added reaction fidelity summary table to assembly report — shows per-reaction predicted fidelity as product of all pairwise overhang fidelities

Assembly reports regenerated from report-OH-fix runs.

---

### Entry 22 — 2026-03-07 (PM) | session: Hard blacklists + Notes/ rename

**Commits:** `dccef24`..`4a3010d`

**Hard blacklists in tile boundary scoring:**
- Replaced soft penalties with hard blacklists for problematic overhangs in tile boundary DP scoring
- Previously, low-fidelity and palindromic overhangs received heavy negative scores but could still be selected if no better option existed
- Now uses explicit exclusion: these overhangs are removed from the candidate set entirely
- Cleaner separation between "preferences" (scoring) and "requirements" (blacklists)

**Repo organization:** Renamed `Plans/` directory to `Notes/` to better reflect content (planning docs, design notes, handoff documents — not active task plans).

Assembly reports regenerated from hard-blacklist scoring runs for validation.

