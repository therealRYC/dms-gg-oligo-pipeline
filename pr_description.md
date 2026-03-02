# PR: Overhang scoring, superblock partitioning, and assembly improvements

**Branch:** `claude/run-akap11-analysis-a6Uof` → `main`

---

## Summary

This PR overhauls the overhang selection and superblock partitioning systems based on deep analysis of AKAP11 (NM_016248.4, 5583 nt, 31 tiles) and GRIN2A (NM_000833.5, 4395 nt, 25 tiles) pipeline runs. The changes fix real assembly failures, switch to enzyme-specific fidelity scoring, and produce more balanced superblock partitions.

**Key results:**
- Both AKAP11 and GRIN2A pipelines complete successfully with all critical QC checks passing
- AKAP11: 31 tiles, 5 superblocks, 64 gene blocks, 379,600 oligos
- GRIN2A: 25 tiles, 4 superblocks, 51 gene blocks, 292,200 oligos
- Full test suite: FAIL 0 | WARN 43 | SKIP 6 | PASS 6090

---

## Changes in Detail

### 1. Backwards-Sweep Superblock Partitioning (`R/06_overhang_selection.R`)

**Problem:** The old `partition_tile_superblocks()` used forward-greedy partitioning followed by a Phase 2 fixup to accommodate the downstream cassette (intergene elements + PolIII promoter) in the last superblock. When the cassette was large enough, Phase 2 had to split the last greedy superblock, often creating a 1-tile superblock. For AKAP11 this produced: SB1(9), SB2(9), SB3(9), SB4(**1 tile**), SB5(3).

**Fix:** New backwards-sweep algorithm:
1. **Step 1 (backwards):** Walk from the last tile backwards, sizing the last SB to be the largest group where gene content + cassette fits within `max_sub_length`. This guarantees the cassette fits without a fixup pass.
2. **Step 2 (forward greedy):** Partition the remaining prefix tiles using standard forward greedy (gene content only).

**Result for AKAP11:** SB1(8), SB2(9), SB3(9), SB4(**2**), SB5(3) — no single-tile superblocks, more balanced partition.

### 2. BsmBI-Specific Fidelity Scoring (replaces T4 ligase data)

**Problem:** The pipeline was using a built-in T4 ligase (18h, 25°C) fidelity matrix for scoring boundary overhangs. This data is **dangerously optimistic** — it overestimates fidelity by up to 0.57 for CG-rich overhangs (e.g., CGCC: 0.915 in T4 vs 0.355 under BsmBI GG conditions). The low-fidelity penalty (`< 0.80`) caught zero overhangs under T4 data but should catch ~206 under actual GG conditions.

**Fix:** `precompute_boundary_scores()` and `search_tile_boundaries_dp()` now load `bsmbi_overhangs.rds` (BsmBI + T4 ligase at 42°C) by default instead of the built-in T4 matrix. Low-fidelity penalty threshold updated from 0.80 to 0.50 (catches truly problematic overhangs: CGCC: 0.35, CCGC: 0.38, CACC: 0.42).

**Justification:** BsaI and BsmBI fidelity data are nearly identical (Pearson r = 0.976, set fidelity differences < 0.5%), so a single matrix suffices. BsmBI is slightly more conservative (mean 0.649 vs 0.656) and is the bottleneck enzyme (more overhangs in its reaction). Full analysis in `260228_bsai_vs_bsmbi_fidelity_comparison.md`.

### 3. Palindrome Blacklist (`R/constants.R`, `R/06_overhang_selection.R`)

**OPT-003 implementation.** All 16 palindromic 4-nt overhangs (sequence = RC(sequence)) are now penalized:
- **Gene-derived overhangs (oh1, oh2):** Heavy penalty (-10.0) in DP scoring — the DP avoids them but doesn't make them impossible when no alternative exists (e.g., gene ending in TAA → oh2 = TTAA)
- **Freely-chosen overhangs (oh3, oh4, SB junctions):** Already implicitly excluded because none appear in the Potapov HF Set 3

Under BsmBI conditions, 7 of 16 palindromes have fidelity < 0.60 (worst: CGCG = 0.404). The previous T4-based scoring masked this entirely.

### 4. BsaI-Level SB Boundary Collision Detection (`R/06_overhang_selection.R`)

**BUG-007 fix.** When the superblock partition places a boundary at a tile whose `oh2_seq` matches the `oh1_seq` of a tile in a later superblock, the BsaI ligation fails (ambiguous ligation: two fragments expose the same `oh_5` overhang).

**AKAP11 example:** SB boundary at tile 17 (`oh2_seq = ACCA`) collided with tiles 21 and 24 (`oh1_seq = ACCA`), causing assembly failures for 22,200 oligos (5.8% of pool).

**Fix:** Added BsaI-level collision detection in Phase 4 of `partition_tile_superblocks()`. When an SB boundary's `oh2_seq` matches any tile's `oh1_seq` in a later superblock, the boundary is shifted.

### 5. Sub-Block Junction Collision Fix (`R/09_wt_geneblock_design.R`)

When computing local sub-block split points (for oversized 5'WT or 3'WT blocks), the exclusion set now includes ALL tiles' oh1/oh2 values, not just the current tile's. Since gene blocks are deduplicated and shared across tiles, a junction overhang that collides with any tile's oh1/oh2 causes ambiguous ligation in that tile's reaction.

### 6. DP K-Range and Diminishing Returns (`R/06_overhang_selection.R`, `R/00_config.R`)

**OPT-004 implementation.** New `dp_k_range` config parameter (default 5) replaces the hardcoded ±2. The DP now searches K_ideal ± 5 tile counts. Search stops early when average score improvement drops below 0.5% from K to K+1 (prefer fewer gene blocks when fidelity gain is marginal).

### 7. Overlap-Aware oh2 Computation (`R/06_overhang_selection.R`)

`precompute_boundary_scores()` now accepts `overlap_codons` parameter. oh2 is computed at the EXTENDED tile end (`boundary + overlap_codons`), matching how `build_tiles()` actually constructs tiles. Previously oh2 was computed at the core boundary, creating a mismatch that could lead to SB boundary collisions the DP didn't anticipate.

### 8. SB-Aware oh2 Blacklisting (`R/06_overhang_selection.R`)

**OPT-005 partial implementation.** `precompute_boundary_scores()` and `search_tile_boundaries_dp()` accept a `blacklisted_oh2` parameter. When the iterative collision resolution loop in `plan_assembly()` detects an SB boundary collision, it blacklists the colliding oh2 value and re-runs the DP. Boundaries where oh2 matches the blacklist are marked invalid, forcing the DP to find alternatives.

### 9. Non-Repeating Test Gene (`tests/testthat/setup.R`)

Replaced the repeating 40-codon `TEST_LONG_GENE_SEQ` (120-nt period, only 63 unique overhangs) with a non-repeating randomly generated gene (seed=2027, 225 unique overhangs). The repeating gene was pathological — its low overhang diversity made SB boundary collisions unavoidable regardless of partition algorithm. The new gene better represents real genes and enables robust testing of all partition strategies.

---

## New Files

| File | Purpose |
|------|---------|
| `260228_akap11_config.yaml` | AKAP11 pipeline run configuration |
| `260228_grin2a_config.yaml` | GRIN2A pipeline run configuration |
| `260228_overhang_deep_dive.md` | Comprehensive analysis: DP boundary selection, fixed overhang choices, superblock partitioning, per-reaction overhang sets, and gene block details for both genes |
| `260228_bsai_vs_bsmbi_fidelity_comparison.md` | Quantitative comparison of BsaI, BsmBI, and T4 fidelity matrices — justification for switching to BsmBI |
| `docs/insulation_design_notes.md` | PolII/PolIII boundary insulation design: bGH polyA, alpha-globin pause element, literature review |

---

## Future Optimizations Documented (BUGS.md)

These are catalogued with full design notes for future implementation:

| ID | Title | Status |
|----|-------|--------|
| **OPT-001** | Gene-end overhang — place BsmBI junction in 3' cassette instead of last codon | IDEA |
| **OPT-002** | Gene-start overhang — place BsaI junction in Kozak sequence instead of ATG. Detailed analysis of candidate Kozak overhangs (ACCA recommended, CATG/CACC avoided) | IDEA |
| **OPT-003** | Palindrome blacklist for boundary selection | **Implemented in this PR** |
| **OPT-004** | Configurable DP K-range with diminishing-returns stopping | **Implemented in this PR** |
| **OPT-005** | Joint tile-boundary + superblock optimization — iterative DP with SB-aware blacklisting to replace unreliable ±5 tile shift heuristic | Partially implemented (blacklisting infrastructure), full joint DP deferred |

### Open Bugs for Future Work

| ID | Title | Summary |
|----|-------|---------|
| **BUG-003** | Boundary codon mutations blanket-skipped | ~40 variants/gene at positions 2 and n-1 are skipped due to 4/3 nt codon-overhang misalignment. ~48% are recoverable with `rescue_boundary_variants()` — planned but deferred |
| **BUG-004** | Large downstream cassette exceeds synthesis limit | If intergene elements total >~1400 nt, the DP can't split them. Preferred fix: extend DP into cassette as a unified splittable sequence |
| **BUG-005** | Tile 20 AKAP11 3'WT block oversized | Global split dropped because leading sub-block falls below min_sub_length, but dropping it creates an oversized merged block. Needs safety check in `assign_global_boundaries_to_tiles()` |
| **BUG-007** | BsaI superblock junction collision with tile oh1 | Detection added in this PR; full resolution via joint optimization (OPT-005) deferred |

---

## Test Plan

- [x] Full test suite passes: `devtools::test()` → FAIL 0 | WARN 43 | SKIP 6 | PASS 6090
- [x] AKAP11 pipeline completes: 31 tiles, 64 gene blocks, 379,600 oligos, all QC critical checks pass
- [x] GRIN2A pipeline completes: 25 tiles, 51 gene blocks, 292,200 oligos, all QC critical checks pass
- [x] Backwards-sweep partition produces no 1-tile superblocks for AKAP11
- [x] Palindrome penalty applied correctly (GRIN2A tile 22 oh2 = TTAA gets -10.0)
- [x] BsmBI fidelity values used in DP scoring (verified CACC fidelity = 0.417, not 0.969)
- [x] Non-repeating test gene has 225 unique overhangs and no enzyme sites

https://claude.ai/code/session_01SDZL3kLkjvSmhkFVAJ6Kcs
