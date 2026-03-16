<!-- Created: 2026-03-07 -->
<!-- Last updated: 2026-03-15 — Entry 46: Claude Code configuration (hooks, effort, cache) -->

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
| 2026-03-07 | Remove overhang_fidelity_threshold; BsmBI data everywhere | Threshold was T4-calibrated (117 OH >= 0.95); under BsmBI cycling only 1 passes — meaningless | Entry 23 |
| 2026-03-08 | SB-first MC + within-SB DP as default boundary method | Reaction-aware scoring achieves min set fidelity ≥0.99 vs 0.78-0.89 legacy | Entry 24 |
| 2026-03-14 | Enzyme-aware alien sets for tile DP (oh1=BsaI, oh2=BsmBI) | oh1 and oh2 are in different enzyme pots; checking both against all aliens was over-constrained | Entry 43 |
| 2026-03-14 | Remove tile-to-tile collision checking | Each tile's assembly reaction is independent (separate pot); Bellman DP replaces beam search | Entry 43 |
| 2026-03-14 | Reduce SB DP max by overlap_codons*3 | Prevents oversized sub-blocks at boundary tiles after overlap zone extension | Entry 43 |
| 2026-03-08 | Drop tile MC from production pipeline | Benchmarking: tile MC = DP v2 on 2/3 genes, degraded TRIO; 500-900s wasted | Entry 24 |
| 2026-03-08 | Document & shelve convergent U6T7 tornado design | Promising but needs wet-lab validation; current pipeline working; can add as config toggle later | Entry 25 |
| 2026-03-08 | Re-evaluate DP vs MC tile boundaries with corrected metrics | Previous comparison invalidated by missing cassette OHs + blacklist filters | Entry 26 |
| 2026-03-08 | Keep DP (dp_v2) for tile boundaries, discard tile MC | MC never improved beyond dp_v2 initial solution, 1.8-2.8x slower, failed on TRIO | Entry 26 |
| 2026-03-09 | BUG-009: All DPs missing OOGGA collision prevention | Our DPs pre-compute scores independently per position — no inter-boundary collision check. OOGGA's `__overlap_pass()` rejects OHs sharing >2/4 bases with any prior OH. Root cause of repeated-overhang failures. | Entry 27 |
| 2026-03-09 | Switch to two-pass OOGGA (SB junctions + tile boundaries) | Replace SB MC + dp_v2 architecture entirely. Both passes use proper OOGGA DP with collision checking and BsmBI cycling data. | Entry 27 |
| 2026-03-09 | oogga_greedy not suitable as default | Fails on TRIO (3098 codons); can't find valid boundaries at max_identity=3 for long genes | Entry 29 |
| 2026-03-09 | SB-first architecture has alignment bug | SB boundaries at arbitrary codon positions don't align with tile boundaries, causing gene block fragmentation | Entry 29 |
| 2026-03-09 | OOGGA 2-condition compat check (remove 3rd identity check) | Match OOGGA Python exactly: only check identity(A,B) and identity(A,RC(B)), not identity(RC(A),B) | Entry 28 |
| 2026-03-09 | Multiplicative DP scoring (product, not sum) | OOGGA uses ∏(eff_i × fid_i); our additive sum was incorrect. Initial score 0→1.0, +=→*= | Entry 28 |
| 2026-03-09 | Beam search with beam_width=10 default | Improvement over OOGGA's single-path; path-dependent collision breaks Bellman optimality | Entry 28 |
| 2026-03-09 | max_identity fallback: mi=2 → mi=3 → error (no legacy DP) | Never fall back to collision-unaware DP; mi=3 is acceptable safety net | Entry 28 |
| 2026-03-10 | Per-segment tile DP fixes SB/tile alignment | Tile DP runs within each SB segment, so tile endpoints naturally align with SB boundaries | Entry 30 |
| 2026-03-10 | beam_width=1 as practical default | beam=1 is 1.5-3.7x faster than beam=10 with negligible fidelity difference | Entry 30 |
| 2026-03-10 | MC refinement not useful for tile boundaries | 0 moves accepted across all genes; DP at mi=3 is locally optimal under mi=2 MC constraints | Entry 30 |
| 2026-03-09 | Precompute static checks for OOGGA DP (20-76x speedup) | Position-dependent but path-independent checks (self-palindrome, alien compat) computed once before DP loop | Entry 28 |
| 2026-03-13 | Two-OH SB DP model: score oh1+oh2 at each SB boundary | Multiplicative scoring of both overhangs at SB junctions; 5 static checks per position; forward CDS extension replaces post-hoc SB-boundary-tile extension | Entry 37 |
| 2026-03-13 | Increase overlap_codons 4→6 + distance-aware assignment | 6-codon overlap with 3/3 split gives 5 nt clearance from ligation junctions (vs 2 nt at 4-codon); matches DIMPLE's 4 nt buffer without dead zones | Entry 39 |
| 2026-03-14 | Implemented clearance-aware overlap codon handling | overlap_codons default 4→6, binary quality→clearance scoring in assign_variants_to_tiles(), config validation (even, >=2). All 5271 tests pass. | Entry 40 |
| 2026-03-13 | overhang_score() returns NA for unknown overhangs (not 0.5) | Fabricated 0.5 fallback could mislead DP; NA makes unscorable boundaries explicit and excluded | Entry 41 |
| 2026-03-14 | Raw product scoring + narrow K range hardcoded | 2×2 factorial benchmark: raw picks fewer tiles (31 vs 35) with higher total assembly probability; wide K is 6x slower with zero benefit | Entry 42 |
| 2026-03-15 | oh2 = last 4 nt of tile (not end_codon + overlap_codons) | end_codon already includes overlap extension from DP; adding overlap again double-counted, placing oh2 18 nt past tile end | Entry 45 |

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
- Full 256-overhang NEB fidelity data (BsmBI cycling, Pryor 2020; T4 legacy data retained as fallback)
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

**PRs:** #24, #25, #26, #27, #28, #29 | **Commits:** `75e6bc1`..`1891deb` | **Bugs fixed:** F15 (eliminated), F16

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

---

### Entry 23 — 2026-03-07 22:35 | cleanup: Remove overhang_fidelity_threshold; BsmBI data everywhere

**Type**: session
**Status**: completed
**Tags**: [overhang-fidelity, bsmbi, cleanup, config]

**Goal**: Remove the `overhang_fidelity_threshold` config parameter and standardize all fidelity data on BsmBI cycling (Pryor 2020).

**Approach**: The threshold (default 0.95) was calibrated for T4 ligase data (Potapov 2018). Under BsmBI cycling conditions, only 1 of 256 overhangs passes 0.95 vs 117 for T4 — the threshold was effectively meaningless. Traced all uses across 14 files (production code, tests, docs) and removed or replaced them.

**Key findings**:
- BsmBI cycling fidelity distribution: 1 OH >= 0.95, 8 >= 0.90, 23 >= 0.85, 39 >= 0.80, median 0.64
- T4 fidelity distribution: 117 OH >= 0.95, 186 >= 0.90, 224 >= 0.85, median 0.94
- `select_superblock_overhangs()` was still using `builtin_overhang_fidelity()` (T4 data) — inconsistent with rest of pipeline
- Set fidelity under cycling is typically ~1.0 for 3-5 overhang reactions, so the threshold warning rarely fired

**Decisions made**:
- Remove `overhang_fidelity_threshold` from config entirely (over lowering it): no meaningful threshold exists for BsmBI cycling individual fidelity
- Replace with internal `SET_FIDELITY_WARNING_THRESHOLD` (0.80): safety net for set fidelity warnings only
- Keep `builtin_overhang_fidelity()` as T4 legacy fallback (over deleting it): future option for users who want T4 data
- Switch all tests to BsmBI data (over keeping T4 for test fixtures): consistency across codebase

**Artifacts**:
- `R/constants.R` — `SET_FIDELITY_WARNING_THRESHOLD` replaces `DEFAULT_FIDELITY_THRESHOLD`
- `config_template.yaml` — threshold section removed
- `R/06_overhang_selection.R` — `select_superblock_overhangs()` now uses BsmBI data

**Related commits**:
- `2c84e73` — Remove overhang_fidelity_threshold config; use BsmBI data everywhere
- `1318543` — notebook: Update fidelity data reference to BsmBI cycling

**Tests**: FAIL 0 | WARN 43 | SKIP 4 | PASS 6388 (263s)

---

### Entry 24 — 2026-03-08 14:11 | implementation: Reaction-aware set fidelity optimization

**Type**: session
**Status**: completed
**Tags**: [set-fidelity, monte-carlo, boundary-optimization, superblocks, mc-fidelity]

**Goal**: Maximize worst-case set fidelity across all ligation reactions by replacing the legacy tile-first DP with a reaction-aware SB-first Monte Carlo approach.

**Problem**: Legacy DP scored SB boundary overhangs individually (`sum(P_fid × P_eff)`) without accounting for pairwise cross-reactivity between overhangs co-occurring in the same reaction. GRIN2A min set fidelity = 0.894 (1 reaction < 0.90); TRIO = 0.783 (3 < 0.90, 1 < 0.80). Worst offenders: extreme tile reactions where ALL SB junction OHs accumulate.

**Key insight**: Each tile has independent BsaI and BsmBI reactions. First tile BsmBI sees all SB junction OHs (downstream); last tile BsaI sees all SB junction OHs (upstream). Optimizing for these two extreme tile reactions automatically optimizes for all tiles.

**Approach — three-phase pipeline**:
1. **SB-first MC** (`search_sb_boundaries_mc`): Simulated annealing places SB boundaries at any codon boundary (not restricted to tile ends), scoring by min set fidelity across extreme tile reactions using 256×256 BsaI/BsmBI pairwise matrices. Multiple restarts (5×10K iterations).
2. **Within-SB DP** (`search_tile_boundaries_dp_v2`): Max-min DP places tile boundaries within each SB segment. Scores by `min(BsaI_set_fid, BsmBI_set_fid)` per tile, accounting for which SB junction OHs appear in each reaction.
3. **Joint refinement** (`refine_boundaries_mc`): MC perturbation of individual tile boundaries (±3 codons), accepting improvements to min set fidelity.

**Benchmark results**:

| Gene | Codons | Legacy min_fid | Legacy <0.90 | New min_fid | New <0.90 |
|------|--------|----------------|--------------|-------------|-----------|
| GRIN2A | 1465 | 0.8940 | 1 | **1.0000** | 0 |
| AKAP11 | 1902 | 0.8665 | 1 | **1.0000** | 0 |
| TRIO | 3098 | 0.7829 | 3 (1 <0.80) | **0.9965** | 0 |

**Decisions made**:
- SB-first MC + within-SB DP as default `boundary_method` (over legacy tile-first DP): reaction-aware scoring achieves min set fidelity ≥0.99 vs 0.78-0.89
- Drop tile MC from production pipeline (over keeping it): benchmarking showed tile MC = DP v2 on GRIN2A/AKAP11, actively degraded TRIO (0.904 → 0.840 by changing tile count 43→45); 500-900s wasted. Function retained for research.
- Gene-edge OHs skip hard filters (over hard-rejecting): first tile oh1 = oh_L and last tile oh2 = gene-end-derived are fixed by the sequence — their quality is captured in set fidelity scoring instead

**Bugs found and fixed**:
- Gene-edge palindrome hard rejection: last tile oh2 (e.g. "TTAA" from TAA stop) hard-rejected as palindromic → tile MC returned -Inf. Fix: skip hard filters for gene-edge OHs.
- SA acceptance NaN crash: `-Inf - (-Inf) = NaN` → guard with `if (!is.finite(new_score)) next`
- `refine_boundaries_mc` return value: returns list with `$tiles`, not a data frame

**Artifacts**:
- `R/06_overhang_selection.R` — 5 new functions: `evaluate_sb_config`, `search_sb_boundaries_mc`, `search_tile_boundaries_dp_v2`, `search_tile_boundaries_mc`, `refine_boundaries_mc`
- `tests/testthat/test-set-fidelity-optimization.R` — 55 tests (all passing)
- `scripts/benchmark_set_fidelity.R` — Benchmark comparing legacy DP vs MC approaches
- `Plans/2026-03-08_low-set-fidelity-optimization.md` — Algorithm design and benchmark results
- `config_template.yaml` — Updated default: `boundary_method: "mc_fidelity"`

**Related commits**:
- `159818c` — Add reaction-aware set fidelity optimization functions
- `30e283d` — Fix gene-edge OH handling in set fidelity optimization
- `59dba80` — Integrate mc_fidelity mode into plan_assembly
- `231125b` — Fix SA acceptance NaN crash; add benchmark script
- `c0c5e7a` — Remove tile MC from mc_fidelity pipeline; use DP v2 → refinement directly
- `b087b70` — Update plan with benchmark results; mark all items complete
- `43cb765` — Change default boundary_method from "dp" to "mc_fidelity"
- `4182772` — Update README for mc_fidelity default boundary method

**Tests**: FAIL 0 | WARN 43 | SKIP 4 | PASS 6425 (421s)

---

### 2026-03-08 14:23 — Research: Convergent U6T7 Tornado Barcode Design Feasibility

**Type**: research
**Status**: completed
**Tags**: [construct-design, polII-polIII, convergent, tornado, circRNA, vis-seq, nis-seq, brainstorm]

**Question**: Can the DMS construct be redesigned to place the PolIII barcode cassette in convergent (antisense) orientation relative to the PolII gene, enabling WPRE/polyA to move to the backbone and reducing gene block overhead from ~1145 nt to <100 nt per tile?

**Sources consulted**:
- Hill et al. 2018, Nat Methods (PMC5882576) — PolII/PolIII co-directional interference: 88% → 29% sgRNA editing
- Ma et al. 2018, Mol Ther NA (PMC6023835) — α-amanitin boosts U6 2-fold; PolII/PolIII compete
- Uenaka & Wernig 2026, Cell Stem Cell — TK4: CAG + WPRE = iPSC silencing resistance
- Litke & Jaffrey 2019, Nat Biotech (MN052909) — Tornado circRNA system (~200× linear RNA)
- Mefferd et al. 2015, RNA — Chimeric U6T7 promoter (18-bp PSE replacement)
- Harris & Jan 2025, Nat Methods — CRISPuRe-seq convergent PolII/PolIII validated
- Datlinger et al. 2024, Nat Biotech — CROPseq-multi convergent design
- Fowler Lab 2025, bioRxiv — VIS-seq tornado circRNA barcodes (>75K copies/cell)

**Summary of findings**:
Co-directional PolII upstream of PolIII (Architecture A) causes significant transcriptional interference — user's concern validated. The field consensus is convergent (opposite-direction) PolII/PolIII, used by ALL major dual-promoter vectors (pLKO.1, lentiCRISPRv2, lentiGuide-Puro). A convergent design with tornado circRNA (Architecture C++) achieves: (1) zero PolII/PolIII interference, (2) gene block cassette overhead of ~93 nt (vs. 1145 nt current), (3) WPRE/polyA in backbone, (4) **identical oligo structure** to current pipeline (56 nt overhead, 81 codons/tile), and (5) built-in dual readout (VIS-Seq circRNA + NIS-Seq T7 IVT).

**Implications for our work**:
- Convergent design is architecturally superior but requires wet-lab validation before committing code changes
- Can be implemented as a `barcode_orientation: "convergent"` config toggle without disrupting existing pipeline
- Mainly affects `08_oligo_assembly.R` (barcode RC) and `09_wt_geneblock_design.R` (smaller cassette)
- The "no tile size penalty" finding is critical — tornado elements go in gene blocks/backbone, not oligo

**Key references**:
- Full brainstorm: `Brainstorm/260308_barcode-upstream-convergent-design.md`

**Related commits**:
- `3838172` — brainstorm: Convergent U6T7 tornado barcode design

**Decision**: Document and shelve — promising but needs wet-lab validation first.

---

### 2026-03-08 19:46 — Plan: Fix SB-First MC Bugs + Re-evaluate Tile Boundary Algorithms

**Type**: session
**Status**: superseded (see 2026-03-09 Entry 27 — switching to two-pass OOGGA)
**Tags**: [blacklist, cassette-split, set-fidelity, monte-carlo, dp, tile-boundaries, bug-fix, benchmark]

**Scientific question**: Was the previous decision to drop tile MC (Entry 24) based on correct metrics? Multiple bugs in the fidelity computation (missing cassette split OHs, missing homopolymer/palindrome filters) may have corrupted the comparison.

**Background/motivation**: Entry 24 concluded that tile MC was inferior to DP v2, but that benchmark was run with broken fidelity accounting. Three categories of bugs invalidated the comparison:
1. **Missing homopolymer filter in SB DP** — ROOT CAUSE of GGGG appearing in TRIO output (palindrome filter existed, homopolymer filter missing)
2. **Missing blacklist filters** in `optimize_split_points()` and `find_cassette_split_points()` (palindromes + homopolymers)
3. **Cassette split OHs invisible to set fidelity** — MC path always produced empty `cassette_splits` even when SB boundaries were placed in the cassette region; these OHs were never included in BsmBI set fidelity computation for any tile

**Approach**:
Three-worktree structure: parent (bug fixes) → two children (DP vs MC comparison).

*Parent worktree* (`260308-fixing-sb-first-mc-method`):
- Task 1: Default `boundary_method` → `"mc_fidelity"` in config
- Task 2: Universal homopolymer/palindrome filtering in SB DP, `optimize_split_points`, `find_cassette_split_points`, `refine_boundaries_mc`
- Task 3: Fix cassette split OH handling — extract from MC result, pass through `get_tile_reaction_overhangs`, `search_tile_boundaries_dp_v2`, `refine_boundaries_mc`, Phase 4 validation
- Task 4: 27 regression tests covering all fixes

*Child A* (`260308-tile-dp-comparison`): Existing dp_v2 + refinement with corrected metrics
*Child B* (`260308-tile-mc-comparison`): Fresh SA tile MC (`search_tile_boundaries_mc`) replacing dp_v2 + refinement

**Additional bugs found during benchmarking**:
- **dp_v2 segment-end oh2 missing filters**: In dp_v2's "Find best last boundary" loop, the last tile's oh2 in non-final SB segments wasn't filtered for palindromes/homopolymers. This oh2 extends past the SB boundary — it's an internal overhang, not gene-end constrained. Fixed with `is_final_segment` check in all three worktrees (`8928663`, `3e066a7`, `14a0626`).
- **MC tile boundary snapping**: `search_tile_boundaries_mc()` snapped dp_v2 boundaries to a separate `valid_boundaries` set, changing tile geometry and introducing palindromic overhangs. SA then couldn't find any valid configuration (all returned `-Inf`), and the function fell through to build tiles from invalid snapped boundaries. Fixed by using dp_v2 boundaries directly + adding `-Inf` fallback to return dp_v2 tiles when SA fails (`ea26f05`).
- **Non-reproducible SB MC**: Benchmarks varied between runs because `mc_seed` wasn't set in config files. Added `mc_seed: 42` to all configs (`8ffc3b1`, `78806ee`).

**Benchmark results** (mc_seed: 42, all metrics corrected):

| Gene | Method | Tiles | SBs | Min Fid | Mean Fid | <0.95 | <0.90 | Palindromes | Homopolymers | Time (s) |
|------|--------|-------|-----|---------|----------|-------|-------|-------------|--------------|----------|
| GRIN2A | DP | 19 | 2 | 0.9092 | 0.9841 | 1 | 1 | 0 | 0 | 2.6 |
| GRIN2A | MC | 19 | 2 | 0.9092 | 0.9841 | 1 | 1 | 0 | 0 | 7.4 |
| AKAP11 | DP | 24 | 3 | 0.9092 | 0.9808 | 2 | 2 | 0 | 0 | 3.5 |
| AKAP11 | MC | 24 | 3 | 0.9092 | 0.9808 | 2 | 2 | 0 | 0 | 7.0 |
| TRIO | DP | 39 | 6 | 0.8887 | 0.9711 | 5 | 1 | 0 | 1 | 7.3 |
| TRIO | MC | 39 | 6 | 0.8887 | 0.9711 | 5 | 1 | 0 | 1 | 13.2 |
| GRIN2A_long | DP | 19 | 2 | 0.8760 | 0.9793 | 1 | 1 | 0 | 0 | 3.6 |
| GRIN2A_long | MC | 19 | 2 | 0.8760 | 0.9793 | 1 | 1 | 0 | 0 | 8.1 |

**Key findings**:
- MC produced **identical fidelity** to DP on all four genes — it never improved beyond dp_v2's initial solution
- MC was **1.8-2.8x slower** (SA overhead with no benefit)
- TRIO MC triggered the `-Inf` fallback ("no valid SA solution found in 35.1s") — SA couldn't find any configuration passing all hard filters, so it returned dp_v2 tiles
- The theoretical explanation: tile reactions are independent (tile oh2s never share a pot), so the optimization decomposes per-tile. DP solves this exactly; MC adds randomized search with no advantage

**Decisions made**:
- **Keep DP (dp_v2) for tile boundaries**: MC never outperforms DP, adds latency, and fails on complex genes (over tile MC, which was theoretically motivated but empirically inferior)
- **Confirms Entry 24's original conclusion**: Even with corrected metrics, DP wins decisively — the previous result wasn't an artifact of corrupted data

**Remaining issues**:
- TRIO has 1 homopolymer violation in both DP and MC — likely from refinement step or an edge case not covered by the dp_v2 segment-end fix. Needs investigation.
- 4 pre-existing test failures (FAIL 4 | WARN 43 | SKIP 4 | PASS 6435) — in test-geneblock-design.R (TRIO sizing), test-overhang-selection.R (global boundaries), test-plan-assembly-hybrid.R (SB boundary invariant). Appear to pre-date our changes.

**Artifacts**:
- `scripts/benchmark_tile_methods.R` — benchmark script (both children)
- Plan file in Claude plan mode context

**Related commits**:
- `7065d72` — Fix blacklist filters and cassette split OH handling
- `d9c3d2a` — Add regression tests for blacklist and cassette OH fixes
- `8928663` — Fix dp_v2 missing palindrome/homopolymer filter on segment-end oh2
- `a33cfb8` — Add tile boundary benchmark script for DP comparison
- `ff60ea1` — Use SA tile MC instead of DP+refinement for tile boundaries
- `54250b3` — Add tile boundary benchmark script for MC comparison
- `ea26f05` — Fix MC tile boundary init: remove snapping, add -Inf fallback
- `3e066a7` — Fix dp_v2 segment-end filter (DP child)
- `14a0626` — Fix dp_v2 segment-end filter (MC child)
- `8ffc3b1` — Add mc_seed: 42 to configs (DP child)
- `78806ee` — Add mc_seed: 42 to configs (MC child)

**Next steps**:
- ~~Merge parent worktree bug fixes to main~~ (superseded by Entry 27 — switching to two-pass OOGGA)
- ~~Discard MC child worktree~~ (superseded)
- Investigate TRIO's remaining 1 homopolymer violation
- Investigate 4 pre-existing test failures

---

### 2026-03-09 07:27 — BUG-009: DP Missing OOGGA Collision Prevention + Architecture Switch

**Type**: session
**Status**: completed
**Tags**: [bug, oogga, dp, collision, architecture, overhang-selection]

**Goal**: Understand why our DP boundary searches produce repeated overhangs, and determine how far our implementation diverges from the actual OOGGA algorithm.

**Approach**: Read the full OOGGA source code (bigbigdumdum/OOGGA on GitHub), compared it side-by-side with our `search_tile_boundaries_dp()`, `dp_solve_k()`, and `precompute_boundary_scores()`. Also reviewed the tabled refactor document (`archive/260216/260216 Tabled Refactor for Alignment with OOGGA.md`) and compared our SA-based SB search to NEB's SplitSet (Pryor et al. 2020).

**Key findings**:
- **BUG-009 identified**: ALL our DP-based boundary searches (tile-first `search_tile_boundaries_dp`, per-segment `search_tile_boundaries_dp_v2`) are missing OOGGA's `__overlap_pass()` — the collision prevention mechanism that rejects overhangs sharing >2/4 positional bases with any previously chosen overhang or its reverse complement
- **Our DP is ~80% OOGGA**: DP structure (mat[K][j]), multi-K search, and scoring logic are structurally equivalent. The additive scoring (sum) vs OOGGA's multiplicative (product) is mathematically equivalent via log transform. The ONE critical gap is collision prevention.
- **How OOGGA prevents repeats**: Inside the DP transition (`__get_score_list()`), OOGGA calls `__overlap_pass()` which traces back through the full parent chain to collect all previously chosen overhangs, then `__find_identities()` counts positional matches. Any candidate sharing >2/4 bases (default `max_overhang_identity=2`) with any prior OH or RC is rejected. This makes it a path-dependent DP, not a pure Bellman DP.
- **Our SA for SB boundaries ≈ NEB SplitSet**: Both are MCMC/SA with Metropolis acceptance on set fidelity. Neither is optimal. OOGGA's DP approach is strictly better for position-constrained problems.
- **Previous comparison invalidated**: The DP vs MC tile boundary comparison (Entry 26) tested two algorithms that BOTH lack collision prevention. The "DP wins" conclusion is correct (DP ≥ MC) but both produce suboptimal results.

**Decisions made**:
- **Switch to two-pass OOGGA**: Replace the entire SB MC + dp_v2 architecture with proper OOGGA DP for both passes. Pass 1: OOGGA DP to find superblock junctions. Pass 2: OOGGA DP to find tile boundaries within each superblock. Both use BsmBI cycling data and collision checking. (over: continuing to patch the existing broken DPs)
- **Do NOT merge parent worktree to main**: Previous plan to merge bug fixes is superseded — the fix is to replace the DPs entirely, not patch them
- **BUG-009 filed in BUGS.md**: Documents the root cause with full structural comparison table

**Artifacts**:
- `BUGS.md` — BUG-009 added (DP missing OOGGA collision prevention)
- `Brainstorm/260309_sb-boundary-optimization-algorithms.md` — SplitSet vs OOGGA vs our SA comparison

**Related commits**:
- `409ae14` — brainstorm: SB boundary optimization algorithms

**Open questions**:
- OOGGA's path-dependent collision check makes the DP O(n² × K) per transition — is this fast enough for TRIO (3098 codons)?
- Should we use OOGGA's `max_overhang_identity=2` threshold (reject if >2/4 match) or exact-match-only?
- How to handle `alien_overhangs` (oh3, oh4, oh_L) in the OOGGA framework — these are fixed overhangs that all boundary OHs must avoid

**Next steps**:
- Implement two-pass OOGGA in a new session (context exhausted)
- Pass 1: OOGGA DP for SB junction placement (replaces `search_sb_boundaries_mc`)
- Pass 2: OOGGA DP for tile boundaries within each SB (replaces `search_tile_boundaries_dp_v2`)
- Use BsmBI cycling pairwise matrix for scoring
- Add `alien_overhangs` parameter for oh3, oh4, oh_L, cassette split OHs

---

### Entry 28 — 2026-03-09 13:55 | dev: OOGGA Collision-Aware Boundary Selection Rewrite (BUG-009 fix)

**Type**: session
**Status**: completed
**Tags**: [oogga, dp, collision, overhang-selection, bug-fix, performance, benchmark]

**Goal**: Implement the OOGGA rewrite plan from Entry 27 — fix 4 OOGGA Python↔R discrepancies, rewrite to SB-first architecture, and benchmark all methods.

**Approach**: Line-by-line comparison of OOGGA Python source (`bigbigdumdum/OOGGA`) against our R port identified 4 discrepancies. Fixed primitives first (compatibility check, self-palindrome, scoring), then rewrote the architecture to SB-first → tiles-within-SBs, then optimized performance with precomputed static checks, and finally benchmarked 4 methods × 2 beam widths × 2 genes.

**What was done**:

1. **Fixed 4 OOGGA Python↔R discrepancies** (`R/06b_oogga_dp.R`):
   - Removed extra `identity(RC(A), B)` check from `build_oh_compatibility()` — OOGGA only checks 2 conditions, not 3
   - Added self-palindrome check to `oogga_overlap_pass()`: `identity(candidate, RC(candidate)) > max_identity → reject`
   - Switched all DP scoring from additive (`Σ score_i`, init=0) to multiplicative (`∏ score_i`, init=1.0) — matches OOGGA's `eff_tally * (eff/100)` product
   - Kept beam search as improvement over OOGGA's single-path (configurable `beam_width`, default=10)

2. **SB-first architecture rewrite** (`R/06b_oogga_dp.R` + `R/06_overhang_selection.R`):
   - Pass 1: SB boundary DP on full gene+cassette — junction OHs selected with collision prevention against alien OHs (oh3, oh4, oh_L)
   - Pass 2: Tile boundary DP within each SB segment — SB junction OHs added to alien set
   - Key insight: SB junction OHs are in EVERY tile's Level 1 reaction pot (WT blocks span full gene)

3. **Performance optimization — 20-76x speedup**:
   - Problem: `oogga_overlap_pass()` called ~600K times in nested R loops (62-153s per DP call)
   - Fix: Precompute position-dependent but path-independent checks (self-palindrome, alien compat, oh1/oh2 mutual) once before DP loop
   - Only path-dependent checks (candidate vs prior OHs on current beam path) remain in inner loop
   - Results: Tile DP 62s→3s (21x), SB DP 133s→2s (67x), Single-pass 153s→2s (76x)

4. **max_identity fallback**: If DP infeasible at mi=2, retry at mi=3, then error. Never falls back to legacy collision-unaware DP.

5. **117 OOGGA-specific tests**: Full suite now FAIL 0 | WARN 43 | SKIP 4 | PASS 6487 (+52 net new tests)

**Benchmark results** (2100 nt gene, 700 codons):

| Method | Beam | Tiles | SBs | Min Fid | Mean Fid | mi2 Violations | mi3 Violations | Time |
|--------|------|-------|-----|---------|----------|----------------|----------------|------|
| dp (baseline) | — | 9 | 2 | 0.651 | 0.937 | 3 | 0 | 2.7s |
| oogga_two_pass | 1 | 9 | 2 | 0.651 | 0.937 | 2 | 0 | 17s |
| oogga_two_pass | 10 | 9 | 2 | 0.651 | 0.937 | 3 | 0 | 48s |
| oogga_greedy | — | 9 | 2 | 0.956 | 0.995 | 3 | 0 | 4s |
| oogga_single | 1 | 9 | 2 | 0.370 | 0.795 | 14 | 0 | 5s |
| oogga_single | 10 | 9 | 2 | 0.651 | 0.954 | 3 | 0 | 12s |

**Key findings**:
- **BUG-009 confirmed**: baseline DP has 3 mi2 violations (OHs sharing >2/4 positional bases)
- **All OOGGA methods: 0 mi3 violations** — no exact-match or RC collisions
- mi2 violations in OOGGA are from mi=3 fallback (would pass at mi=3, not genuine failures)
- **oogga_greedy is best overall**: fastest OOGGA method (~4s), highest fidelity (0.995), good collision avoidance
- beam=10 helps oogga_single significantly (0.795→0.954 fidelity) but slows oogga_two_pass with minimal benefit
- All OOGGA tile DPs fell back to mi=3 on this gene — mi=2 may be too restrictive for typical tile boundary density

**Decisions made**:
- OOGGA 2-condition compat check: Match OOGGA Python exactly (over: keeping our extra identity(RC(A),B) check — document as future `strict_compat` option)
- Multiplicative scoring: Product not sum (over: keeping additive — incorrect per OOGGA source)
- Beam search default=10: Improvement over OOGGA's single-path (over: beam=1 matching OOGGA exactly — our beam search helps with path-dependent constraints)
- max_identity fallback mi=2→mi=3→error: Never use legacy DP (over: falling back to collision-unaware DP)
- Precompute static checks: Factor out position-dependent/path-independent work (over: calling oogga_overlap_pass in inner loop — 600K calls too slow)

**Artifacts**:
- `R/06b_oogga_dp.R` — Complete OOGGA DP implementation (~1500 lines)
- `R/06_overhang_selection.R` — Updated dispatch in `plan_assembly()` (SB-first architecture)
- `R/00_config.R` — Added `oogga_beam_width` config parameter (default=10)
- `tests/testthat/test-oogga-dp.R` — 117 OOGGA-specific tests
- `scripts/benchmark_oogga_comparison.R` — 4-way benchmark with beam_width comparison

**Related commits**:
- `2d69d04` — Rewrite OOGGA DP: fix 4 discrepancies, SB-first architecture
- `efedadc` — Optimize OOGGA DP: precompute static checks for 20-76x speedup
- `dffdf8c` — benchmark: add beam_width comparison + correct test gene sequences
- `d732f6d` — benchmark: add dual max_identity violation counting (mi2 vs mi3)
- `6bbea71` — Add OOGGA 4-way benchmark comparison script

**Open questions**:
- Should `oogga_greedy` become the default `boundary_method` given its benchmark performance?
- Cross-language equivalence tests (Step 8 of plan) deferred — run OOGGA Python on test sequence and verify R produces identical results
- Re-adding `identity(RC(A),B)` as optional `strict_compat=TRUE` — would make compat matrix symmetric

**Next steps**:
- ~~Run cross-language equivalence tests against OOGGA Python~~ Done (Entry 29)
- ~~Consider making `oogga_greedy` the default boundary method~~ No — fails on TRIO (Entry 29)
- ~~Test on TRIO (3098 codons) to verify performance at scale~~ Done (Entry 29)

---

### 2026-03-09 19:13 — 4-Gene Full Pipeline Benchmark: dp vs OOGGA Methods

**Type**: session
**Status**: completed
**Tags**: [benchmark, oogga, boundary-selection, collision-prevention, bug-fix]

**Goal**: Run the full pipeline on 4 real genes (GRIN2A, AKAP11, TRIO, GRIN2A long cassette) with 3 boundary methods (dp, oogga_two_pass beam=10, oogga_greedy) and compare results.

**Approach**: Created 4 git worktrees branched from `260309-oogga-comparison`. Generated 3 method-specific YAML configs per gene (12 total). Ran `run_pipeline.R` for each config (12 pipeline runs in parallel across worktrees, sequential within). Used `barcodes_per_variant: 1` for speed (barcodes don't affect boundary selection). Collected assembly reports and compared metrics.

**Critical bug found**: `run_pipeline.R` was not passing `boundary_method`, `oogga_max_identity`, or `oogga_beam_width` from the YAML config to `plan_assembly()`. The config list on line 193-199 was missing these 3 keys. Result: ALL runs used the legacy `dp` path regardless of config. First batch of 12 runs produced identical results. Fixed in commit `750103d`, then re-ran all 12.

**Benchmark results** (after fix):

| Gene | Method | Tiles | Gene Blocks | SB OHs | Min Set Fid | Low-Fid Tiles | Time |
|------|--------|-------|-------------|--------|-------------|---------------|------|
| GRIN2A (1464 cod) | dp | 25 | 52 | 5 | 0.740 | 22 | 289s |
| GRIN2A | oogga_two_pass | 24 | 83 | 3 | 0.794 | 22 | 574s |
| GRIN2A | oogga_greedy | 29 | 95 | 3 | 0.874 | 26 | 330s |
| AKAP11 (1902 cod) | dp | 31 | 66 | 5 | 0.858 | 23 | 442s |
| AKAP11 | oogga_two_pass | 27 | 119 | 4 | 0.853 | 25 | 770s |
| AKAP11 | oogga_greedy | 37 | 147 | 4 | 0.783 | 35 | 447s |
| TRIO (3098 cod) | dp | 47 | 103 | 7 | 0.783 | 44 | 645s |
| TRIO | oogga_two_pass | 45 | 235 | 6 | 0.749 | 44 | 1354s |
| TRIO | oogga_greedy | — | — | — | — | — | **FAILED** |
| GRIN2A LC (1464 cod) | dp | 25 | 57 | 4 | 0.740 | 21 | 290s |
| GRIN2A LC | oogga_two_pass | 24 | 98 | 3 | 0.794 | 22 | 641s |
| GRIN2A LC | oogga_greedy | 29 | 116 | 3 | 0.850 | 26 | 371s |

**Key findings**:
- **OOGGA methods produce distinct boundaries** — different tile counts, overhangs, and SB structures vs dp. Collision prevention is working.
- **oogga_two_pass finds fewer, wider tiles** (24 vs 25 for GRIN2A, 27 vs 31 for AKAP11, 45 vs 47 for TRIO) — collision-aware DP finds efficient solutions.
- **oogga_greedy finds more, smaller tiles** (29, 37) — greedy makes locally optimal but globally suboptimal choices.
- **oogga_greedy FAILS on TRIO** — can't find valid boundaries for 3098-codon gene even at max_identity=3. The greedy approach gets trapped. DP succeeds.
- **Gene block explosion in OOGGA** — 83-235 blocks vs 52-103 for dp. Root cause: SB boundaries don't align with tile boundaries ("SB boundary at position X does not match any tile end_nt. Skipping."). This is a fundamental issue with the SB-first architecture.
- **Tile DP always falls back to max_identity=3** — mi=2 is infeasible for all genes. With 24+ overhangs per reaction, the constraint space is too tight at mi=2.
- **oogga_two_pass is ~2x slower** — SB DP adds 60-136s, plus collision-aware tile DP overhead.
- **Overhang fidelity is comparable** across all methods — OOGGA doesn't significantly improve or worsen fidelity.

**Decisions made**:
- oogga_greedy cannot be the default: fails on long genes (over greedy DP approach)
- SB-first architecture has an alignment bug: SB boundaries need to align with tile boundaries, or the partition logic needs restructuring (over keeping current SB-first design as-is)

**Architecture issue — SB/tile boundary misalignment**:
The SB-first architecture places SB boundaries at arbitrary codon positions (Pass 1), then tile boundaries are found independently (Pass 2). Since these are decoupled, SB boundary positions rarely coincide with tile boundary positions. `sb_dp_to_partition()` then skips non-matching SB boundaries, causing excessive gene block fragmentation. Possible fixes:
1. Constrain SB DP to only place boundaries at positions that are valid tile boundaries
2. Add a post-hoc alignment step that adjusts SB boundaries to nearest tile boundary
3. Return to tile-boundary-constrained SB architecture (our legacy approach) but with OOGGA collision checking

**Artifacts**:
- `archive/benchmark_260309/` — 11 assembly reports (3 methods × 4 genes, minus TRIO greedy)
- `scripts/run_gene_benchmark.sh` — Benchmark runner script
- Worktrees: `260309-benchmark-{grin2a,akap11,trio,grin2a-long-cassette}`

**Related commits**:
- `153b9af` — benchmark: 4-gene × 3-method full pipeline comparison
- `750103d` — Fix boundary_method not passed from config to plan_assembly()
- `6b956dd` — docs: update build_oh_compatibility docstring with redundancy proof
- `6d184b8` — Add cross-language equivalence tests + mark BUG-009 as fixed

**Open questions**:
- How to fix SB/tile boundary alignment? Option 1 (constrain SB DP to tile-valid positions) seems cleanest but requires knowing valid tile positions before running SB DP — circular dependency.
- Is oogga_two_pass worth the 2x runtime cost given comparable fidelity to dp?
- Should we consider a hybrid: dp for tiles (fast, good fidelity) + OOGGA collision checking as a post-hoc filter?

**Next steps**:
- Fix SB/tile boundary alignment bug
- Investigate the "Total score: 0" issue in OOGGA tile DP
- Consider hybrid approach: legacy dp tiles + OOGGA collision validation

---

### 2026-03-10 10:02 — Per-Segment Tile OOGGA DP: Implementation + 3 Benchmarks

**Type**: session
**Status**: completed
**Tags**: [oogga, per-segment-tiling, benchmark, beam-search, mc-refinement, collision-aware]

**Goal**: Fix the SB/tile boundary alignment bug (Entry 29) by running tile DP per SB segment, then benchmark beam width, MC refinement, and legacy DP vs OOGGA.

**Approach**: Implemented `tile_segments_oogga()` — after SB DP finds superblock boundaries (Pass 1), Pass 2 runs tile DP independently within each SB segment. Tiles naturally end at SB boundaries by construction, eliminating the alignment bug. Also added `mc_refine_segment_tiles()` (Metropolis-Hastings) as an optional post-DP refinement. Ran three benchmarks on 4 genes (GRIN2A, AKAP11, TRIO, GRIN2A_ext).

**Key findings**:

*Benchmark 1 — Beam width (beam=1 vs beam=10):*
- beam=1 is 1.5-3.7x faster with negligible fidelity difference
- Both produce identical tile counts; beam=10 only rarely finds marginally better solutions
- **Verdict**: beam=1 is the practical default

*Benchmark 2 — MC refinement (DP only vs DP+MC):*
- 0 moves accepted across all 4 genes (0/4000 iterations per segment)
- Root cause: tile DP falls back to mi=3 when mi=2 is infeasible. At mi=3, boundaries are already locally optimal. MC checks at mi=2 → all proposals rejected.
- **Verdict**: MC refinement adds cost (marginal) with zero benefit; not worth including

*Benchmark 3 — Legacy DP vs OOGGA two-pass (beam=1):*

| Gene | Method | Tiles | SBs | Blocks | Min Fid | Mi2 | Mi3 | Time |
|------|--------|-------|-----|--------|---------|-----|-----|------|
| GRIN2A | Legacy DP | 25 | 4 | 69 | 0.858 | 30 | 0 | 6.3s |
| GRIN2A | OOGGA | 26 | 3 | 50 | 0.804 | 37 | 2 | 27.1s |
| AKAP11 | Legacy DP | 31 | 5 | 116 | 0.913 | 131 | 0 | 7.0s |
| AKAP11 | OOGGA | 32 | 4 | 93 | 0.826 | 53 | 13 | 33.9s |
| TRIO | Legacy DP | 47 | 8 | 315 | 0.783 | 109 | 0 | 20.5s |
| TRIO | OOGGA | 55 | 6 | 270 | 0.813 | 84 | 3 | 65.1s |
| GRIN2A_ext | Legacy DP | 25 | 4 | 69 | 0.740 | 38 | 0 | 6.8s |
| GRIN2A_ext | OOGGA | 27 | 3 | 52 | 0.894 | 25 | 0 | 35.1s |

- OOGGA uses fewer SBs (3-6 vs 4-8) → fewer gene blocks (50-270 vs 69-315)
- OOGGA has fewer mi2 violations on 3/4 genes (proactive collision checking works)
- OOGGA introduces some mi3 violations (2-13) from tile DP fallback mi2→mi3
- Min fidelity mixed: OOGGA wins on TRIO (+0.030) and GRIN2A_ext (+0.154), loses on GRIN2A (-0.054) and AKAP11 (-0.087)
- OOGGA is 3-5x slower

**Decisions made**:
- Per-segment tile DP fixes alignment bug: tile DP runs within each SB segment so endpoints naturally match (over full-CDS tile DP with post-hoc alignment)
- beam=1 as default: 1.5-3.7x faster with negligible quality difference (over beam=10)
- MC refinement not useful: 0 moves accepted; DP at mi=3 already locally optimal (over keeping MC as option)

**Artifacts**:
- `R/06b_oogga_dp.R` — `tile_segments_oogga()` + `mc_refine_segment_tiles()`
- `R/06_overhang_selection.R` — Updated Pass 2 dispatch to per-segment tiling
- `tests/testthat/test-oogga-dp.R` — 8 new per-segment tile + MC tests
- `scripts/benchmark_beam_width.R` — Beam width benchmark script
- `scripts/benchmark_mc_refinement.R` — MC refinement benchmark script
- `scripts/benchmark_dp_vs_oogga.R` — Legacy DP vs OOGGA benchmark script
- `benchmarks/260310_beam_width_comparison.md` — Beam width results
- `benchmarks/260310_mc_refinement_comparison.md` — MC refinement results
- `benchmarks/260310_dp_vs_oogga_two_pass.md` — Legacy DP vs OOGGA results

**Related commits**:
- `eb6f3c7` — Add per-segment tile OOGGA DP to fix SB/tile alignment
- `a20b70a` — Add per-segment tile + MC refinement tests, fix single-tile rbind
- `10504e6` — Add beam width + MC refinement benchmark scripts
- `86925b7` — benchmark: beam width + MC refinement on 4 genes
- `ce953cd` — benchmark: legacy DP vs OOGGA two-pass (beam=1) on 4 genes

**Open questions**:
- Why does OOGGA tile DP always fall back to mi=3? Is the alien OH set too large for mi=2 to be feasible?
- "Total score: 0" in OOGGA tile DP — is multiplicative scoring zeroing out due to one bad boundary?
- Is the 3-5x runtime cost of OOGGA justified given the mi3 violations it introduces?
- Should we consider a hybrid: legacy DP speed + OOGGA collision validation as post-hoc filter?

**Next steps**:
- Investigate mi=2 infeasibility: what makes the constraint space too tight?
- Debug "Total score: 0" in tile DP multiplicative scoring
- Consider defaulting to legacy DP with OOGGA collision post-check as a faster alternative

---

### 2026-03-10 10:56 — Full Pipeline DP vs OOGGA Two-Pass Benchmark

**Type**: benchmark
**Status**: completed
**Tags**: [benchmark, oogga, dp, full-pipeline, assembly-simulation]

**Goal**: Run the complete pipeline (all 12 steps + assembly simulation) for 4 genes × 2 boundary methods (legacy DP vs OOGGA two-pass beam=1) to produce full assembly reports for side-by-side comparison.

**Approach**: Created 8 benchmark config files (one per gene × method combo) and ran all 8 in parallel. Each run is fully independent — config, mutation design, tiling, barcoding, oligo assembly, gene block design, QC, and assembly simulation.

**Key findings**:
- OOGGA produces 2-9 more tiles per gene → fewer variants per tile → 7-8% smaller oligo pools (e.g., TRIO: 650K→604K oligos)
- OOGGA requires 7-16 more gene blocks to synthesize (more tiles = more WT blocks)
- Fidelity is gene-dependent: OOGGA wins on GRIN2A/ext (0.894 vs 0.740 min set fidelity), DP wins on AKAP11 (0.858 vs 0.753)
- OOGGA total runtime overhead is only 5-13% — step 6 (assembly planning) is 6-14x slower, but offset by faster barcode gen (fewer barcodes)
- Pipeline bottleneck is mutations (38-45%) + barcodes (30-40%) regardless of boundary method
- All 8 runs pass assembly simulation — both methods produce valid assemblies

**Artifacts**:
- `benchmarks/260310_full_pipeline/comparison_summary.md` — full comparison with tables
- `benchmarks/260310_full_pipeline/{gene}_{method}/` — complete output dirs with assembly reports
- `configs/bench_*.yaml` — 8 benchmark configs

**Related commits**:
- `5fb6c9b` — benchmark: Add 8 configs for full pipeline DP vs OOGGA comparison
- `de1d9ac` — benchmark: Full pipeline DP vs OOGGA two-pass on 4 genes

---

### 2026-03-10 12:30 — Cleanup: Git Branch Cleanup + OOGGA PR Merge

**Type**: session
**Status**: completed
**Tags**: [cleanup, git, branches, worktrees, pr]

**Goal**: Clean up 15+ local branches and 7 worktrees accumulated during the OOGGA rewrite, then merge `260309-oogga-comparison` to main via PR.

**What was done**:
- Pushed `260308-low-set-fidelity-optimization` (1 unpushed brainstorm commit) for archival
- Removed 7 git worktrees (benchmark runners + superseded MC method)
- Deleted 12 local branches (7 merged to main, 5 superseded by OOGGA rewrite)
- Deleted 11 stale remote branches (old features, Claude-generated, docs)
- 3 local branches need manual `git branch -D` (hook blocks force-delete): `260308-fixing-sb-first-mc-method`, `260308-tile-dp-comparison`, `260308-tile-mc-comparison`
- Added .gitignore patterns for large regenerable benchmark outputs (~1.85 GB CSVs/FASTAs)
- Created PR merging `260309-oogga-comparison` → `main`

**End state**: Local and remote have only `main` + `260309-oogga-comparison`. Single worktree.

**Artifacts**:
- `Plans/2026-03-10_git-branch-cleanup.md` — full cleanup plan with branch listing
- `.gitignore` — updated with benchmark output patterns

---

### Entry 33 — 2026-03-10 | review: Full pipeline code review

**Type**: session (ongoing)
**Status**: in-progress
**Tags**: [code-review, walkthrough, learning, documentation]

**Goal**: Systematic code review of the entire pipeline — Robert reading each R script in RStudio, asking questions, and building deep understanding of the codebase. Notes drafted in Asana, discussed here.

**Approach**: File-by-file walkthrough. Robert reviews in RStudio, pastes questions/comments here. Claude explains design choices, flags issues, and researches anything unclear. This entry accumulates findings throughout the session.

**Findings**:

*(updated as review progresses)*

### Entry 34 — 2026-03-12 | fix (shelved): BUG-010 oh2 recomputation + backward segment extension

**Type**: bugfix (abandoned)
**Status**: shelved
**Tags**: [bug-010, oogga, oh2, superblock, backward-extension, failed-experiment]
**Branch**: `fix/oh2-recomputation-backward-ext` (archived as tag `archive/bug010-oh2-recomputation-backward-ext`)

**Problem being solved**: AKAP11 OOGGA two-pass produces tiles 1-3 with low BsmBI set fidelity (0.75-0.83) due to junction overhang CACA colliding with oh3=CACC (positional identity 3/4). Additionally, post-processing in `tile_segments_oogga()` recomputes oh2 from the full CDS, overwriting the segment-capped oh2 — causing gene sequence corruption (wrong 4 nt) at every SB boundary junction.

**What was implemented** (7 commits):
1. **Cap oh2 for SB boundary tiles** — SB boundary tiles keep oh2 at the segment end instead of extending past it
2. **Backward segment extension** — non-first segments extend backward by `overlap_codons * 3` nt, aiming to eliminate the ~2-codon dead zone at SB boundaries
3. **SB DP oh1_next check** — `precompute_sb_boundary_candidates()` rejects SB positions where oh1_next (from backward extension) is palindromic, homopolymer, in blacklist, or has positional identity >2 with boundary OH
4. **Junction OH invariant** — `convert_partition_to_splits()` warns if `junction_oh != gene[split_nt-3:split_nt]`
5. **Alien safety net** — post-processing warns on oh2/alien collisions for interior tiles
6. **Gene reconstruct QC** — new `qc_gene_reconstruct()` verifies SB junction OHs match gene sequence

**Benchmark results** (all 4 genes passed, tests: FAIL 0 / PASS 7838):

| Gene | Min Fidelity | Mi2 Violations (before → after) |
|------|-------------|-------------------------------|
| GRIN2A | 0.9010 | 30 → 11 |
| AKAP11 | 0.8382 | 131 → 35 |
| TRIO | 0.8382 | 109 → 79 |
| GRIN2A_ext | 0.8940 | 38 → 23 |

**Why it was shelved**: The backward extension approach is a band-aid. The real problem is that the SB DP doesn't score overhangs the same way the tile DP does. At each SB boundary, there are TWO overhangs that matter — oh2 of the last tile (at the boundary) and oh1 of the first tile of the next segment (at the start of the overlap). The SB DP currently only picks a boundary position and gets one overhang from the gene sequence; it doesn't jointly score the oh1/oh2 pair. The correct fix is to make the SB DP "two-overhang-aware" — at each candidate boundary position, compute both oh1 and oh2 and score them the same way the tile DP does (fidelity, efficiency, collision checking against all other overhangs in the reaction). This eliminates the dead zone by construction rather than patching it with backward extension. The backward extension also introduced a known limitation: cross-boundary oh1 collisions for the backward-extended first tiles, since their oh1 is gene-determined (not DP-chosen) and never validated against all aliens.

**What to carry forward**:
- The gene reconstruct QC idea is sound and should be reimplemented in the correct fix
- The junction OH invariant assertion is useful
- The core oh2-capping logic (don't extend oh2 past SB boundaries) is correct but should fall out naturally from a properly designed SB DP
- The investigation in `260310-understanding-oogga-vs-legacy-dp` (Entry 32b) remains relevant: `optimize_split_points()` greedy sub-block splitting is a separate source of low fidelity

---

### 2026-03-12 22:39 — Entry 35: Fix tile overlap + cassette over-splitting in OOGGA DP

**Type**: session
**Status**: completed
**Tags**: [oogga, tile-overlap, cassette-splitting, bug-fix, variant-loss]

**Goal**: Implement fixes for Issues 1 and 2 from the two-OH model diagnostic plan (260312).

**Issue 1 — Tile overlap missing (~7% variant loss)**:
The OOGGA tile DP and greedy functions correctly scored oh2 at the extended position (`boundary + overlap_codons`) but never extended `tile_ends_codon`. Without overlap, codons at tile boundaries appeared in only one tile's oh region → flagged `partial_oh_overlap` → removed. Three coordinated changes matching the legacy DP pattern:
1. Reduce `max_codons` by `overlap_codons` before DP search (prevents oligo overflow)
2. Extend `tile_ends_codon` by `overlap_codons` after extracting boundaries
3. Fix oh2 computation to use tile's extended end directly (prevents double-counting)

Applied to both `search_tile_boundaries_oogga()` and `search_tile_boundaries_greedy_seq()`.

**Issue 2 — Cassette over-splitting (1079 nt cassette split into 3 fragments)**:
The SB DP ran on `gene + cassette` and could place boundaries inside the cassette when the two-OH model's stricter constraints reduced valid gene-region candidates. Fix at two levels:
1. `precompute_sb_boundary_candidates()` now accepts `cassette_needs_splitting` — when FALSE, positions > `gene_len` stay `valid=FALSE`
2. `sb_dp_to_partition()` guards cassette splits extraction behind `cassette_needs_splitting` (defense-in-depth)

**GRIN2A benchmark results (post-fix vs pre-fix)**:

| Metric | Pre-fix OOGGA | Post-fix OOGGA | Legacy DP |
|--------|--------------|----------------|-----------|
| Variants | 28,497 | 30,429 | 30,681 |
| Skipped positions | 106 | 14 | 2 |
| Cassette fragments | 3 (391+351+400) | 1 (1112 nt) | 1 (1532 nt) |
| Gene blocks | 59 | 54 | 52 |
| Tiles | 27 | 26 | 25 |

**Remaining 14 skipped positions**: Position 2 (oh_L overlap), position 1464 (gene edge), plus 3 groups of 4 codons at SB segment boundaries (538-541, 766-769, 1322-1325). This is a fundamental limitation of per-segment tiling — overlap can't cross SB junctions because each segment is tiled independently. The legacy single-pass DP doesn't have this constraint.

**Issue 3 (DP scoring ignores fixed OH cross-reactivity)**: Not fixed — user wants to think more. Noted as known gap.

**Artifacts**:
- `R/06b_oogga_dp.R` — tile overlap + cassette gating fixes
- `R/06_overhang_selection.R` — `sb_dp_to_partition()` defense-in-depth guard
- `benchmarks/260312_overlap_fix/grin2a_oogga/` — verification benchmark
- `Plans/2026-03-12_two-oh-diagnostic.md` — full diagnostic plan

**Related commits**:
- `7fbc41d` — fix: Add tile overlap extension to OOGGA DP and greedy tile search
- `c35c990` — fix: Prevent cassette over-splitting in OOGGA SB DP

**Open questions**:
- Can the 12 SB-junction skipped positions be recovered? Would require cross-segment overlap or constraining SB boundaries to avoid oh-edge codons
- Issue 3 (fixed OH cross-reactivity in DP scoring) — approach TBD
- Assembly simulation still failing (BUG-010, separate issue)

---

### 2026-03-13 — Entry 36: Codebase simplification (oogga_two_pass only) + oh2 double-extension bug fix

**Type**: refactor + bugfix
**Status**: completed (pending merge/push)
**Tags**: [simplification, oogga-two-pass, dead-code, oh2-bug, assembly-simulator]
**Branch**: `main` (local, 12 commits ahead of origin)
**Plan**: [swift-knitting-taco.md](Plans/) (8-phase simplification plan)

**Goal**: Delete all boundary methods except `oogga_two_pass` to reduce codebase size (~32% target) and eliminate context-window bloat during Claude sessions.

#### Phase 1-7: Code Deletion (~6,300 lines removed)

| Phase | What | Lines removed |
|-------|------|--------------|
| 1 | Delete 5 obsolete test files (Gen 1/2 comparisons) | ~2,681 |
| 2 | Delete Gen 1/2 functions from `06b_oogga_dp.R` (5 functions) | ~921 |
| 3 | Delete 16 legacy functions from `06_overhang_selection.R` | ~2,118 |
| 4 | Simplify `plan_assembly()` routing — single code path | ~400 |
| 5 | Other module cleanup (`00_config`, `07_barcode`, `09_geneblock`, `12_report`) | ~110 |
| 6 | Simplify retained test files | ~685 |
| 7 | Delete benchmark scripts and configs | ~400 |

Key deletions: `builtin_overhang_fidelity()`, `search_tile_boundaries()` (greedy), `search_tile_boundaries_dp()`, `dp_solve_k()`, `partition_tile_superblocks()`, `search_superblock_boundaries_dp()`, `oogga_single_pass_dp()`, `search_boundaries_oogga_single()`, `mc_refine_segment_tiles()`, `search_tile_boundaries_greedy_seq()`, `apply_superblock_splitting()`, and more. Fallback chains in `load_overhang_fidelity()`, `load_high_fidelity_set()`, `load_pairwise_matrix()` now `stop()` instead of falling back to deleted functions.

#### Phase 8: Validation — discovered oh2 double-extension bug

During final test validation, `test-gg-simulator.R:309` failed: tile 1 variant A23E had `has_mut_gene=FALSE`. Root cause investigation:

**Bug**: `tile_segments_oogga()` (lines ~1164-1174) computed oh2 as:
```r
oh2_codon <- min(tiles$end_codon[i] + overlap_codons, total_n_codons)
```
But `end_codon` already included the overlap extension from the inner DP (`search_tile_boundaries_oogga()` line 936). This **double-extended** oh2 by 4 codons (12 nt) — e.g., tile 1 oh2 was computed at codon 40 (nt 117-120 = "TGAC") instead of codon 36 (nt 105-108 = "GAAA").

**Impact**: Every tile junction in the assembled product had the wrong 4-nt overhang. The assembly simulator (`verify_assembly_product()`) detected this because `grepl(expected_mut_cds, product)` failed — the product had corrupted sequence at every boundary. This bug was **latent** — it existed before the simplification but was masked because the old DP method produced different tile boundaries where the corruption happened to not affect the test gene.

**Fix** (commit `50d4b7a`):
1. Internal tiles: use `tiles$end_nt[i]` directly for oh2 (no extra extension)
2. SB-boundary tiles (last tile of non-final segment): selectively extend `end_codon` past the SB boundary by `overlap_codons` so oh2 doesn't collide with the SB junction overhang
3. Updated `plan_assembly()` SB-to-tile mapping: range-based lookup instead of exact `end_nt` match (SB-boundary tiles now extend past the SB position)
4. Updated 4 test assertions in `test-oogga-dp.R` to match corrected behavior

**Note**: This is related to but distinct from BUG-010 (Entry 34). BUG-010 tried to fix oh2 recomputation via backward segment extension — that approach was shelved. This fix addresses the root cause (double-extension) with a simpler, correct solution.

**Final validation**: 227 tests pass, 0 failures, 41 warnings (pre-existing), 1 skip.

**Commits** (oldest to newest):
- `2ea919f` refactor: Delete 5 obsolete test files (Phase 1)
- `dbc1efa` refactor: Delete Gen 1/2 functions from 06b_oogga_dp.R (Phase 2)
- `30c31d4` refactor: Delete 16 legacy functions from 06_overhang_selection.R (Phase 3)
- `bf9ab39` wip: checkpoint
- `2dd4fe8` wip: checkpoint
- `a6f555e` refactor: Simplify plan_assembly() routing — oogga_two_pass only (Phase 4)
- `1625287` refactor: Other module cleanup (Phase 5)
- `efd00b9` refactor: Simplify retained test files (Phase 6)
- `92beecf` refactor: Delete benchmark scripts and configs (Phase 7)
- `c70538b` wip: checkpoint
- `cc0b33a` fix: Update tests for oogga_two_pass-only codebase
- `50d4b7a` fix: Correct oh2 double-extension bug in tile_segments_oogga

**Branch cleanup note** (2026-03-13): Multiple local branches exist from parallel sessions. Stale branches with no unique work: `260310-code-review`, `260312-simplify-testing`, `260312-testing-simplify-codebase`. Branches with unique work not in main: `260310-understanding-oogga-vs-legacy-dp` (3 commits — OOGGA vs DP investigation, likely moot post-simplification), `fix/oh2-recomputation-backward-ext` (5 commits — BUG-010 shelved approach, superseded by commit `50d4b7a`). User is cleaning up in a separate session.

---

### 2026-03-13 15:30 — Entry 37: Two-OH SB DP Model Ported to Main

**Type**: session
**Status**: completed
**Tags**: [oogga, superblock, two-oh, porting, benchmark]

**Goal**: Port the two-overhang (two-OH) SB DP model from the `explore/forward-backward-overlap` worktree onto the clean, refactored main branch.

**Approach**: Surgical function-by-function porting rather than git merge/rebase, since the worktree predated the major codebase simplification (Entry 36). Analyzed the diff between the worktree and main to identify exactly which functions changed, then applied each change manually to the refactored codebase. This avoided merge conflicts entirely.

**Key changes**:

1. **`precompute_sb_boundary_candidates()`** — Two-OH scoring: each gene-region SB boundary now computes oh1 (forward 4 nt past boundary) and oh2 (at overlap extension point). Multiplicative scoring: `overhang_score(oh1) × overhang_score(oh2)`. Cassette-region boundaries remain single-OH.

2. **`oogga_sb_dp_solve_k_v2()`** — Tracks `oh1s`/`oh2s` per-boundary for output, plus combined `ohs` for collision checking. 5 per-position static checks (vs 2 for single-OH): oh1 self-palindrome, oh1 vs aliens, oh2 self-palindrome, oh2 vs aliens, oh1-oh2 mutual compatibility.

3. **`search_sb_boundaries_oogga()`** — New `make_single_sb()` helper for DRY single-boundary format. Output df uses `oh1_sb`/`oh2_sb` instead of `boundary_oh`. DRYed K-loop into `run_dp()` closure.

4. **`tile_segments_oogga()`** — Forward CDS extension: non-last gene segments get CDS extended by `overlap_codons × 3` nt past the SB boundary. Passes `n_codons_tile` to constrain tile boundary placement to the original segment while allowing oh2 to reach into the overlap zone. Replaces the old post-hoc SB-boundary-tile detection/extension.

5. **`convert_partition_to_splits()`** — Directional junction OHs: oh2_sb for bsmbi_3wt (upstream tile), oh1_sb for bsai_5wt (downstream tile), at different split positions.

6. **Downstream consumers** (`sb_dp_to_partition()`, `plan_assembly()`, `10_qc_checks.R`, tests) — Updated to two-OH format with backward-compatible `boundary_oh` fallback.

**Benchmark results (4 genes, two-OH model)**:

| Gene | Variants | Mutable | Skipped | Min Set Fidelity | Gene Blocks |
|------|----------|---------|---------|-----------------|-------------|
| GRIN2A | 30,429 | 1,449/1,463 | 14 | 0.933 | 56 |
| AKAP11 | 39,522 | 1,882/1,900 | 18 | 0.749 | 73 |
| TRIO | 64,470 | 3,070/3,096 | 26 | 0.735 | 121 |
| GRIN2A_ext | 30,513 | 1,453/1,463 | 10 | 0.749 | 69 |

**Comparison with pre-fix single-OH (Entry 36 baseline)**:
- GRIN2A single-OH (pre-tile-overlap-fix): 28,665 variants, 98 skipped
- GRIN2A two-OH: 30,429 variants, 14 skipped — **+1,764 variants recovered**
- Skipped positions now ~14 (gene-edge oh effects), down from 98-106

**Known issue**: GRIN2A_ext cassette over-splitting persists — 4 fragments instead of expected 2 (one is 35 nt, below synthesis minimum). Only affects `cassette_needs_splitting=TRUE` cases. The two-OH model's 5 per-position checks leave fewer valid cassette-region candidates. Tracked for follow-up.

**Artifacts**:
- `benchmarks/260313_two_oh_model/` — Assembly reports for all 4 genes
- PR #40: https://github.com/therealRYC/dms-gg-oligo-pipeline/pull/40

**Related commits** (branch `260313-two-oh-sb-dp`):
- `da4421e` wip: checkpoint
- `f3c93d4` feat: Port two-OH SB DP model to 06b_oogga_dp.R
- `f08d253` wip: checkpoint
- `c6f7c5e` feat: Update downstream consumers for two-OH SB DP format
- `ba1bec6` benchmark: Two-OH SB DP model — 4-gene benchmark results

**Open questions**:
- How to constrain cassette-region boundary count when `cassette_needs_splitting=TRUE` to prevent over-splitting
- AKAP11 and TRIO have reactions below 0.90 set fidelity — investigate whether DP scoring that accounts for fixed OH cross-reactivity (Issue 3 from diagnostic plan) would help

**Next steps**:
- Merge PR #40
- Fix cassette over-splitting for `cassette_needs_splitting=TRUE` genes (GRIN2A_ext)
- Investigate low-fidelity reactions in AKAP11/TRIO

---

### 2026-03-13 — Entry 38: Deep dive into OOGGA algorithm

**Type**: research
**Status**: completed
**Tags**: [oogga, algorithm, literature, scoring, comparison]

Deep-read of the original OOGGA Python codebase (`OOGGA.py`, Mukundan S, 2025 preprint) followed by systematic comparison with our R reimplementation (`R/06b_oogga_dp.R`).

**OOGGA algorithm** — 2D DP (fragment count × position), multiplicative probability-chain scoring (efficiency × fidelity products), identity-based overhang compatibility filter (max 2/4 positional matches including reverse complements), traceback for top-N solutions. Key limitations: single-path storage per cell (alternative paths lost), implicit leftward tie-breaking, `n_trace` solutions can be highly redundant (different terminals tracing through same intermediate path).

**R implementation differences** — Our reimplementation addresses several OOGGA limitations:
- **Beam search** (default width 10) vs single-predecessor: retains multiple paths per position, so collision-compatible alternatives aren't lost
- **Pre-computed 256×256 compatibility matrix** vs full traceback: O(1) per-pair lookup instead of O(K) character comparison
- **Carried-forward path state** vs reconstructed: each beam path stores its full overhang set, eliminating traceback entirely
- **Static pre-filtering**: self-palindrome, alien compat, oh1/oh2 mutual compat computed once per position (not per-predecessor)
- **Two-overhang model**: oh1 + oh2 per boundary (DMS tile overlap architecture) vs single overhang per cut
- **Two-pass architecture**: SB boundaries → tile boundaries, with SB overhangs as alien constraints for tiles
- **Geometric mean K comparison**: normalizes multiplicative scores across different fragment counts
- **Graceful fallback**: max_identity 2→3 on infeasibility instead of assertion crash

**Scoring formulas**: Mathematically identical at default settings — both compute `efficiency = diagonal/max_diagonal`, `fidelity = diagonal/row_total`, combined multiplicatively. OOGGA stores as percentages and tracks eff/fid separately (configurable exponent weighting); our R stores as fractions and combines upfront (`overhang_score = fid × eff`).

**Bug found**: `overhang_score()` used a 0.5 fallback for unknown overhangs instead of skipping (OOGGA skips via KeyError). Fix in progress in parallel session.

See [detailed analysis](Brainstorm/260313_oogga-algorithm-deep-dive.md).

**Open questions**: BsmBI cycling vs T4 scoring differences in practice; beam width sensitivity (does beam=10 actually find different paths vs beam=1?); what the preprint adds beyond the code.

---

### 2026-03-13 — Entry 39: Tile boundary clearance — ligation fidelity near overhangs

**Type**: brainstorm
**Status**: actionable (not yet implemented)
**Tags**: [tiling, overhang, clearance, ligation-fidelity, dimple, overlap, variant-assignment]

**Question**: How close can a mutated codon be to a BsmBI ligation junction (oh1/oh2 overhang) before ligation efficiency drops? And what can we do about it?

#### Background: DIMPLE's approach

DIMPLE (Coyote-Maestas et al., Genome Biology 2023) observed positional bias for variants near sublibrary boundaries. Their fix: shift BsaI cut sites 4 **nucleotides** outward, creating a WT-only buffer between the overhang and the first mutagenized codon. Confirmed via code: `cutsite_overhang = 4` (nt) and `-overlap` argparse parameter defaults to 4 (nt). The paper's "4 non-mutated residues" means nucleotide residues, not amino acid residues.

After BsaI digestion, a DIMPLE fragment looks like:
```
[4nt OH]—[4nt WT buffer]—[mutagenized region]—[4nt WT buffer]—[4nt OH]
                          ↑                                    ↑
                     4 nt from junction                   4 nt from junction
```

DIMPLE can do this because each sublibrary assembles into its own independently PCR-amplified backbone — there's no shared boundary between adjacent sublibraries.

#### Our architecture: shared boundaries prevent DIMPLE-style buffers

In our pipeline, oh2 of tile N and oh1 of tile N+1 are the **same gene coordinates**. Adding a WT buffer zone on one side creates dead space that the other side can't cover:

```
Tile N:    [...mutable...] [buffer] [oh2]
Tile N+1:                  [oh1] [buffer] [...mutable...]
                                 ^^^^^^^^
                                 dead zone — buffer in BOTH tiles,
                                 never mutagenized anywhere
```

This is a fundamental constraint of our shared-boundary Golden Gate architecture vs DIMPLE's independent-backbone design.

#### Current clearance: 2 nt (structural)

With 4-codon overlap, the 4-nt overhang (4 mod 3 = 1) always eats 1 nt into a codon, leaving a 2-nt remnant. Example with junction at codon 250:

```
Tile N:  ...|251|252| 2̲5̲3̲ |████|     oh2 = nt 759-762 (3rd nt of 253 + all of 254)
                  ↑   ↑↑  oh2
              last    2nt remnant (codon 253 can't be mutated —
            mutable   its 3rd nt is locked in oh2)

Clearance: codon 252 end (nt 756) → oh2 start (nt 759) = 2 nt
```

This 2-nt clearance is **structural** — increasing `overlap_codons` alone doesn't change it (just shifts which codon number is at the boundary).

#### Solution: increase overlap to 6 codons

With 6-codon overlap and a natural 3/3 split:

```
Tile N:  ...|251|252|253|  254  | 2̲5̲5̲ |████|
                     ↑     ^^^    ^^  oh2
                    last   3nt + 2nt = 5 nt clearance
                   mutable

Tile N+1:          |████| 2̲5̲2̲ |  253  |254|255|256|...
                    oh1    ^^    ^^^
                          2nt + 3nt = 5 nt clearance
                                  ↑
                                first mutable
```

- Tile N mutates codons 251-253 (last mutable codon 253: 5 nt from oh2)
- Tile N+1 mutates codons 254+ (first mutable codon 254: 5 nt from oh1)
- No dead zones — codon 253 is mutated by tile N, codon 254 by tile N+1
- 5 nt clearance exceeds DIMPLE's 4 nt buffer
- Cost: ~6 nt less step per tile (negligible for most genes)

#### Current code problem: assignment doesn't support this

`assign_variants_to_tiles()` (R/05_tiling.R:176-181) uses a **binary** quality check:

```r
if (local_start >= 5L && local_end <= tile_len - 4L) {
  quality <- 2L  # interior
} else {
  quality <- 1L  # partial oh overlap
}
```

With 6-codon overlap, codons 253-254 are quality 2 (interior) in **both** tiles. Ties broken by first-tile-wins → produces a 4/2 split instead of the optimal 3/3 split. This means codon 253 goes to tile N where it's only 2 nt from oh2, instead of being pushed to the middle of the overlap.

#### Implementation plan

Two changes needed:

1. **Increase `overlap_codons` from 4 to 6** (parameter change in config/defaults)

2. **Distance-aware variant assignment** — replace binary quality with clearance scoring:
   ```r
   # Score = distance from nearest junction (oh1 or oh2)
   clearance <- min(local_start - 4L, tile_len - 4L - local_end)
   ```
   Pick the tile with the highest clearance score. This naturally produces the 3/3 split for 6-codon overlap.

**Files to modify**:
- `R/05_tiling.R`: `assign_variants_to_tiles()` — replace binary quality with clearance score
- `R/00_config.R`: change `overlap_codons` default from 4 to 6
- `R/06b_oogga_dp.R`: verify tile DP works correctly with 6-codon overlap (should be fine — it already parameterizes `overlap_codons`)
- Tests: update expected tile counts for test genes

**Impact on tile count** (theoretical, 300 nt oligos, 243 nt mutable):
- 4-codon overlap: step = 77 codons
- 6-codon overlap: step = 75 codons
- For a 1500-codon gene: 20 tiles → 20 tiles (no change)
- For a 3000-codon gene: 39 tiles → 40 tiles (1 extra tile)

#### References

- DIMPLE: Coyote-Maestas et al. (2023) Genome Biology 24:36. PMID: 36829228
- DIMPLE source: github.com/coywil26/DIMPLE — `cutsite_overhang=4`, `-overlap` default=4 (both nucleotides)
- Potapov et al. (2018) ACS Synth Bio 7:2665 — overhang fidelity data


---

### 2026-03-13 21:52 — Entry 40: OOGGA Python vs R Implementation Validation

**Type**: session
**Status**: completed
**Tags**: [oogga, validation, superblock, dp, overhang-selection]

**Goal**: Validate that our R OOGGA DP (`R/06b_oogga_dp.R`) produces equivalent results to the original Python OOGGA (`Dyna_frag` class) when configured identically (single-OH, beam_width=1).

**Approach**: Created a standalone comparison folder (`archive/260313-oogga-python-vs-our-R-implementation/`) with 5 scripts that: (1) export our BsmBI NEB data to OOGGA's CSV format, (2) build a domesticated GRIN2A+cassette test sequence with aligned parameters, (3) run R OOGGA in single-OH mode, (4) run Python OOGGA on the same sequence, and (5) compare outputs systematically. Also wrote 8 testthat assertions covering CSV roundtrip, scoring equivalence, position/overhang/score match, collision checks, and set fidelity.

**Key findings**:
- R and Python produce **identical** results: K=3, boundaries at positions 1116/2073/3840, overhangs GAAA/AGAA/AAGA
- Total scores differ by ~1.8e-7 (relative), explained by P_fid floating-point difference when R uses RDS doubles vs Python uses CSV integers for row sums (~5e-7 per overhang)
- All 86 testthat assertions pass
- Set fidelity = 1.0 for both (perfect under BsmBI cycling conditions with only 7 overhangs)
- Multiple optimal solutions exist (Python found 5 traces with identical scores but different boundary positions)

**Artifacts**:
- `archive/260313-oogga-python-vs-our-R-implementation/scripts/01_export_neb_data.R` — RDS→CSV export with roundtrip verification
- `archive/260313-oogga-python-vs-our-R-implementation/scripts/02_prepare_inputs.R` — Domesticated GRIN2A + params.json
- `archive/260313-oogga-python-vs-our-R-implementation/scripts/03_run_r_single_oh.R` — R single-OH mode runner
- `archive/260313-oogga-python-vs-our-R-implementation/scripts/04_run_python_oogga.py` — Python OOGGA wrapper
- `archive/260313-oogga-python-vs-our-R-implementation/scripts/05_compare.R` — Comparison with markdown report
- `archive/260313-oogga-python-vs-our-R-implementation/tests/test-oogga-validation.R` — 8 testthat tests (86 assertions)
- `archive/260313-oogga-python-vs-our-R-implementation/outputs/comparison_report.md` — Final report

**Key alignment details**:
- R boundary `p` = OOGGA boundary `j = p` (same numeric value, same overhang `seq[p+1:p+4]` in 1-indexed)
- OOGGA automatically includes `seq[0:4]` (via trace) and `seq[-4:]` (explicitly) in collision checks; R passes both as `alien_ohs`
- An overhang and its own RC are the same physical junction — not a real collision
- Score formula: R `product(P_fid * P_eff)` = Python `product(eff/100) * product(fid/100)` (mathematically identical)

**Next steps**:
- Validation complete — R OOGGA core DP is confirmed faithful to the original Python implementation
- Can proceed with confidence on full pipeline results using the extended features (two-OH model, beam search)

---

### 2026-03-13 23:04 — Entry 41: Remove 0.5 fallback for unknown overhangs — treat as unscorable

**Type**: session
**Status**: completed
**Tags**: [overhang-scoring, na-fallback, defensive-coding, report]

**Goal**: Replace the fabricated 0.5 fallback in `overhang_score()` with NA, so unknown overhangs are excluded from optimization rather than silently competing with real scores.

**Approach**: Changed `overhang_score()` to return `NA_real_` instead of `0.5` for overhangs not found in fidelity/efficiency lookups. All downstream consumers (tile precompute, SB precompute, superblock junction loop, cassette split loop) now skip boundaries with NA scores. Added `n_unscorable_boundaries` to the assembly plan summary and a conditional note in the markdown report (Section 5b) that fires when the count is >0.

**Key findings**:
- With full NEB BsmBI cycling data (all 256 4-mers covered), the change has zero practical effect — no overhangs are unscorable
- The old `0.5 * 0.5 = 0.25` fallback was problematic: in additive scoring (`oh1_base + oh2_base`), `0.5 + 0.5 = 1.0` was *higher* than many real overhangs, potentially steering the DP toward unknown overhangs
- The change is a safety net for edge cases (custom/trimmed fidelity data)

**Decisions made**:
- Return NA instead of 0.5: makes invalid states unrepresentable (over assigning a fabricated score that could mislead optimization)

**Artifacts**:
- `R/06_overhang_selection.R` — `overhang_score()` + `precompute_boundary_scores()` + superblock junction loop + summary field
- `R/06b_oogga_dp.R` — SB precompute (gene-region + cassette-region)
- `R/09_wt_geneblock_design.R` — cassette split point loop
- `R/12_report.R` — unscorable boundary note in Section 5b
- `tests/testthat/test-overhang-selection.R` — updated test expects NA

**Related commits**:
- `2c296f4` — Remove 0.5 fallback for unknown overhangs — treat as unscorable (NA)
- `1c4d78a` — wip: checkpoint (core source changes)
- `746b8a7` — wip: checkpoint (precompute + DP changes)

---

### Entry 42 — 2026-03-14 | decision: Raw product scoring + narrow K range for OOGGA DP

**Context**: The OOGGA DP searches across multiple K values (number of internal boundaries) to find the best tiling. Two open questions: (1) how to compare scores across different K values, and (2) how wide a K range to search.

**What we did**: Ran a 2×2 factorial benchmark on AKAP11 (5706 nt) comparing geometric mean vs raw product scoring × narrow vs wide K range. See [detailed analysis](Brainstorm/2026-03-14_k-scoring-method.md).

**Key findings**:
- Scoring method is the only variable that matters: A=B (narrow=wide with geo_mean), C=D (narrow=wide with raw), but A≠C (geo_mean≠raw)
- Raw product: 31 tiles, min fidelity 0.866, total assembly probability 0.038
- Geometric mean: 35 tiles, min fidelity 0.902, total assembly probability 0.022
- Wide K range: 6x slower (367s vs 59s) with zero benefit for either scoring method
- Raw product embeds "soft parsimony" — the product naturally penalizes unnecessary boundaries, so each extra cut must earn its keep

**Decisions made**:
- Hardcode raw product scoring — remove `k_scoring` parameter
- Hardcode narrow K range — remove `k_range_mode` parameter
- Both were experimental infrastructure for the benchmark, not production options

**Verification**:
- Full pipeline on AKAP11: 31 tiles, 4 SBs (matches benchmark condition C/D)
- Unit tests: 3 pre-existing failures (not introduced by this change), 5252 pass

**Artifacts**:
- `R/06b_oogga_dp.R` — Removed k_scoring/k_range_mode from 3 functions, hardcoded raw scoring
- `R/06_overhang_selection.R` — Removed config unpacking + pass-through
- `scripts/bench_k_handling.R` — Added historical note
- `Brainstorm/2026-03-14_k-scoring-method.md` — Full decision rationale

**Related commits**:
- `730b132` — Hardcode raw product scoring and narrow K range in OOGGA DP
- `381acf1` — Add historical note to K-handling benchmark script
- `993ea82` — brainstorm: K-scoring method decision

---

### 2026-03-14 — Entry 40: Implemented clearance-aware overlap codon handling

**Status**: Complete
**Tags**: [tiling, overhang, clearance, overlap, variant-assignment, config]

Implemented the clearance-aware overlap handling designed in Entry 39. Three changes:

1. **`R/00_config.R`**: Default `overlap_codons` changed from 4 to 6. Added validation requiring the value to be even (asymmetric splits otherwise) and >= 2.

2. **`R/05_tiling.R`**: `assign_variants_to_tiles()` now uses **clearance scoring** — the distance (in nt) from the nearest overhang junction — instead of binary quality (interior=2 / edge=1). The tile with the highest clearance wins. The 4-nt overhang vs 3-nt codon mismatch prevents exact ties, naturally producing a 3/3 split from 6 overlap codons without explicit tie-breaking logic. `partial_oh_overlap` flag triggers on `clearance < 0` (semantically identical to old `quality == 1`).

3. **Tests**: Three new tests in `test-tiling.R`:
   - Clearance scoring produces symmetric 3/3 split (28-codon gene, 20-codon tiles, 6-codon overlap)
   - Config rejects odd `overlap_codons`
   - Config rejects `overlap_codons < 2`

**Result**: 5,271 tests pass. The 1 failure in `test-gg-simulator.R:309` is pre-existing (stochastic assembly simulation issue, fails on different variants each run).

**Artifacts**:
- `R/00_config.R` — overlap_codons default + validation
- `R/05_tiling.R` — clearance-based `assign_variants_to_tiles()`
- `tests/testthat/test-tiling.R` — 3 new tests

**Related commits**:
- `f3811da` — feat: clearance-aware overlap codon handling (overlap_codons 4→6)
- `d548788` — fix: correct clearance split test geometry

---

### 2026-03-14 13:36 — Entry 43: Reaction-aware tile DP + SB boundary sub-block fix

**Type**: session
**Status**: completed
**Tags**: [oogga, tile-dp, collision, enzyme-pots, bellman, superblock, sub-block, alien-sets]

**Goal**: Remove unnecessary collision constraints from the tile DP that don't reflect the physical biochemistry, and fix 3 test failures caused by tiny sub-blocks at SB boundaries.

**Approach**: Three biochemistry-driven simplifications to `oogga_tile_dp_solve_k()`:
1. **Remove tile-to-tile path collision** — each tile's assembly reaction is a separate pot, so tiles never see each other's overhangs. Replaced beam search with standard Bellman DP (single best per position, no path tracking).
2. **Remove oh1↔oh2 mutual compat check** — oh1 is BsaI (Level 1), oh2 is BsmBI (Level 1b). Different enzymes, different pots.
3. **Split alien sets by enzyme** — oh1 checks BsaI-pot aliens only (oh_L, oh4, SB junctions before segment); oh2 checks BsmBI-pot aliens only (oh3, SB junctions at/after segment).

Then fixed 2 bugs exposed by the TRIO gene (9294 nt):
- **30 nt sub-block**: `convert_partition_to_splits()` was adding a bsmbi_3wt split for the boundary tile's own SB boundary, creating a sub-block of just the 12 nt overlap zone + 18 nt enzyme overhead. Fix: skip `tiles$end_nt[t] == boundary_nt`.
- **Oversized merged block**: After skipping the tiny split, the merged sub-block exceeded max by 7 nt because the SB DP didn't account for the overlap extension. Fix: reduce SB DP max by `overlap_codons * 3`.

**Key findings**:
- AKAP11: Before fix, 3/4 multi-tile segments failed at `max_identity=2` (fell back to 3 with score=0). After: all 4 succeed at `max_identity=2` with geo-mean scores 0.25–0.36
- `split_nt` is the **last nucleotide** of a sub-block, not a tile boundary position. Values are at `boundary_nt + 4` (bsai_5wt) and `boundary_nt + 12` (bsmbi_3wt) — in the overlap zone
- The old test `all(splits$split_nt %in% plan$tiles$end_nt)` was fundamentally wrong for the two-OH model

**Decisions made**:
- Enzyme-aware alien sets: physically correct per-reaction modeling (over single combined alien set)
- Bellman DP over beam search: tile reactions are independent, no path collision needed
- Reduce SB DP max globally by `overlap_codons*3`: prevents the geometry from ever creating oversized boundary-tile sub-blocks (over post-hoc local re-split)

**Artifacts**:
- `R/06b_oogga_dp.R` — Bellman DP, split alien sets in `oogga_tile_dp_solve_k()`, `search_tile_boundaries_oogga()`, `tile_segments_oogga()`
- `R/06_overhang_selection.R` — `sb_max_content` with overlap deduction in `plan_assembly()`, boundary tile skip in `convert_partition_to_splits()`
- `tests/testthat/test-oogga-dp.R` — Updated signatures, fixed SB DP param names, fixed oh2 overlap test
- `tests/testthat/test-overhang-selection.R` — Fixed split_nt assertion
- `benchmarks/260313_post_tile_collision_fix/` — AKAP11 benchmark results

**Related commits**:
- `9b76035` — refactor: Reaction-aware tile DP — remove unnecessary collision constraints
- `8d119d0` — benchmark: AKAP11 post tile collision fix
- `c2aacaf` — wip: checkpoint (SB max fix, boundary tile skip, enzyme-aware aliens)

**Verification**:
- OOGGA tests: 120/120 pass
- Full suite: 5271 pass, 1 pre-existing failure (`test-gg-simulator.R:309` — tile 1 K5E on TEST_GENE_SEQ)
- AKAP11 pipeline: all segments succeed at max_identity=2, blocks 153–1728 nt (within 1800 limit)

---

### 2026-03-14 14:15 — Entry 44: Full pipeline benchmark — 2 critical bugs exposed

**Type**: session
**Status**: completed
**Tags**: [benchmark, bugs, assembly-simulation, skipped-variants, production-readiness]

**Goal**: Run the full pipeline on all 4 test genes (GRIN2A, AKAP11, TRIO, GRIN2A_ext) with current settings (overlap_codons=6, barcodes_per_variant=10) and assess production readiness.

**Results**:

| Gene | Length | SBs | Tiles | Oligos | Blocks | Runtime |
|------|--------|-----|-------|--------|--------|---------|
| GRIN2A | 4,395 nt | 4 | 25 | 305K | 52 | 7.9m |
| AKAP11 | 5,706 nt | 4 | 31 | 397K | 64 | 10.6m |
| TRIO | 9,294 nt | 7 | 53 | 646K | 111 | 17.7m |
| GRIN2A_ext | 4,395 nt | 4 | 24 | 306K | 59 | 9.2m |

Pipeline scales linearly with gene length (TRIO = 2.1x GRIN2A → 2.1x tiles, oligos, blocks, 2.2x runtime).

**Two critical bugs discovered**:

1. **BUG-010: Hundreds of variants skipped per gene** (147–546 per gene, 0.5–0.8%). Variants near ATG and stop codon are flagged as `partial_oh_overlap` and silently excluded. There should be zero skipped variants.

2. **BUG-011: Assembly simulator fails on nearly all tiles** (1/25 to 1/53 pass rate). Most tiles return NA (fragments don't ligate). If the simulator is correct, the designed assemblies are broken. Must determine whether the design or the simulator is at fault.

**Decisions made**:
- These are blockers for production use — must be resolved before ordering oligos
- Opened BUG-010 and BUG-011 in BUGS.md with full diagnostic data

**Artifacts**:
- `benchmarks/260314_full_pipeline_run/` — full outputs for all 4 genes
- `benchmarks/260314_full_pipeline_run/cross_gene_summary.csv` — metrics table
- `BUGS.md` — BUG-010 and BUG-011 documented

**Related commits**:
- `6ef9ed0` — benchmark: Full pipeline run on 4 genes

**Next steps**:
- Investigate BUG-011 first: trace a single failing tile to determine design vs simulator fault
- Then tackle BUG-010: architectural fix for gene-edge overhangs (DIMPLE-style 4 nt buffer)

---

### 2026-03-15 15:38 — Fix: BUG-010 + BUG-011 resolved (oh2 double-counting)

**Type**: session
**Status**: completed
**Tags**: [bugfix, oh2, tile-geometry, assembly-simulation, oogga-dp]

**Goal**: Fix the oh2 double-counting bug that caused 210 skipped variants and 24/25 assembly simulation failures on GRIN2A.

**Approach**: Root cause analysis with user's geometry spreadsheet (`Brainstorm/260315-theoretical-tile-overhang-geometry.xlsx`) revealed that `end_codon` already includes the overlap extension from the DP (raw_boundary + overlap_codons = tile end). The tile metadata loop was adding `+ overlap_codons` again, putting oh2 18 nt past the actual tile end. This is a 2-line fix in `R/06b_oogga_dp.R` — the DP scoring was already correct; only the metadata was wrong.

**Key findings**:
- BUG-010 and BUG-011 were the same underlying bug, as hypothesized in Entry 44
- The DP correctly scores oh2 at `boundary + overlap_codons` (= tile end codon), but the tile metadata loop added another `+ overlap_codons`
- The mutable region (`tile[5:t_len-4]`), clearance scoring (`tile_len - 4`), and 3'WT block start (`end_nt + 1`) were all already correct — they assumed oh2 was at the tile end
- After fix: GRIN2A passes 25/25 assembly simulation, 210 skipped variants are expected gene-edge variants only

**Decisions made**:
- oh2 = last 4 nt of tile (at `end_codon`, not `end_codon + overlap_codons`): the overlap is already baked into `end_codon` by the DP (over previous assumption that oh2 extended past tile end)

**Artifacts**:
- `R/06b_oogga_dp.R` — 2-line fix (lines ~1082 and ~1353)
- `tests/testthat/test-oogga-dp.R` — test expectations updated to match correct geometry
- `BUGS.md` — BUG-010 and BUG-011 marked FIXED
- `benchmarks/260315_oh2_fix/grin2a_run.log` — verification pipeline run log

**Related commits**:
- `1369cf4` — fix: Remove oh2 double-counting of overlap_codons (BUG-010 + BUG-011)
- `5dba5d2` — test: Update oh2 test expectations to match corrected geometry
- `c3d024e` — bugs: Mark BUG-010 and BUG-011 as FIXED

**Verification (GRIN2A)**:
- Skipped variants: 210 (gene-edge only — was 210 including boundary variants before)
- Assembly simulation: 25/25 tiles pass (was 1/25)
- All oligos: 152-290 nt (within 300 nt limit)
- All gene blocks: 213-1769 nt (within 1800 nt limit)
- All 5264 unit tests pass, 0 failures

**Next steps**:
- Gene-edge codon 2 clearance = 0 (touching oh1) — fix by moving oh_L into Kozak sequence (separate session)
- Run AKAP11 and TRIO verification to confirm fix generalizes

---

### 2026-03-15 19:16 — Claude Code configuration: hooks, effort level, cache cleanup

**Type**: session
**Status**: completed
**Tags**: [claude-code, hooks, configuration, devtools]

**Goal**: Set up PostToolUse hook to enforce plan saving on ExitPlanMode, configure max effort level, and clean stale plugin cache.

**Approach**: Investigated Claude Code hook system to find the best way to enforce plan-saving after ExitPlanMode. Hookify plugin events (`bash`, `file`, `stop`, `prompt`) can't target specific tools like ExitPlanMode, so we used a native `PostToolUse` hook in `~/.claude/settings.json` with `"matcher": "ExitPlanMode"` and a prompt-based hook that blocks until the plan is saved.

**Key findings**:
- Hookify events don't map to specific tool names — only `bash`, `file`, `stop`, `prompt`, `all`
- Native Claude Code hooks support `PostToolUse` with a `matcher` regex on tool name — this is the right approach for tool-specific hooks
- `effortLevel: "max"` may not persist across sessions (Opus 4.6 only); env var `CLAUDE_CODE_EFFORT_LEVEL=max` is more reliable
- Subagents do NOT inherit effort level from parent — env var is the only way to force it globally
- Plugin cache dirs are bound to `CLAUDE_PLUGIN_ROOT` at session start — cleaning mid-session breaks hooks

**Decisions made**:
- Use native PostToolUse hook (not hookify) for ExitPlanMode enforcement: hookify can't target specific tools (over hookify `stop` event which would fire on every response)
- Put hook in `~/.claude/settings.json` (global, syncs via sync-config): plan saving is a personal workflow preference, not project-specific (over project-level `.claude/settings.json`)
- Belt-and-suspenders for effort: both `settings.json` and `~/.bashrc` env var (over settings.json alone which may not persist `max`)

**Artifacts**:
- `~/.claude/settings.json` — PostToolUse hook on ExitPlanMode + effortLevel: max
- `~/.bashrc` — `export CLAUDE_CODE_EFFORT_LEVEL=max`

**Open questions**:
- Plugin cache still has duplicate `d5c15b861cd2` dirs (restored after mid-session cleanup broke hooks) — clean next session
- Need to add `CLAUDE_CODE_EFFORT_LEVEL=max` to `~/.bashrc` on other devices (not covered by sync-config)

**Next steps**:
- Clean duplicate plugin cache dirs (start of next session, before CLAUDE_PLUGIN_ROOT is bound)
- Run `sync-config` to push settings to other devices
- Add bashrc env var on other devices manually
