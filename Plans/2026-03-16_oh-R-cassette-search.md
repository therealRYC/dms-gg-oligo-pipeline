# Plan: Last Tile oh_R — Optimized Cassette Overhang Search

**Date**: 2026-03-16
**Status**: IMPLEMENTED

## Problem

The last tile's oh2 was clamped at the gene end (stop codon), making the stop codon non-mutable. Mirror image of the first-tile/oh_L problem.

## Solution

After the tile DP runs, a new Phase 3.5 scans the downstream cassette at 1-nt resolution to find an optimal oh2 (called oh_R) for the last tile. This:
- Searches every nucleotide position (not just codon boundaries)
- Scores candidates by P_fid × P_eff (BsmBI cycling)
- Filters palindromes, homopolymers, OOGGA identity vs aliens
- Extends the last tile into invariant cassette sequence
- Pushes stop codon into tile interior (mutable)

## Architecture

```
Phase 1:   Select oh_L, oh3, oh4 (fixed overhangs)
Phase 2:   SB DP on gene+cassette
Phase 3:   Tile DP per SB segment (gene only)
Phase 3.5: oh_R search — scan cassette for best last-tile oh2  ← NEW
Phase 4:   Pairwise validation
```

## Files Modified

| File | Change |
|------|--------|
| `R/06_overhang_selection.R` | New `search_oh_R()` + Phase 3.5 in `plan_assembly()` |
| `R/06b_oogga_dp.R` | Remove `n_codons_gene` clamp on oh2 in SB precompute |
| `R/08_oligo_assembly.R` | `full_seq` parameter for last tile cassette extraction |
| `R/09_wt_geneblock_design.R` | Trim cassette prefix for oh_R extended last tile |
| `R/10_qc_checks.R` | Clamp tile coverage to gene_len |
| `R/04_mutation_design.R` | Update stop codon exclusion rationale |
| `run_pipeline.R` | Pass `full_seq` to `assemble_oligos()` |
| `tests/testthat/test-overhang-selection.R` | 7 new search_oh_R tests |
| `tests/testthat/test-gg-simulator.R` | Pass `full_seq` in assembly tests |
| `tests/testthat/test-integration.R` | Pass `full_seq` + guard 0-row skip |

## Key Invariants

1. **Oligo length**: `overhead + (last_tile_gene_nt + cassette_prefix - 8) ≤ 300`
2. **Stop codon clearance**: `cassette_prefix - 4 ≥ 1` (oh_R at least 5 nt into cassette)
3. **Cassette reconstruction**: cassette nt on oligo + remaining cassette in gene block = full core cassette
4. **No collision**: oh_R compatible with oh3 and SB junction OHs per OOGGA identity check

## Graceful Degradation

If cassette is empty or too short for any valid oh_R, the search returns NULL and behavior is unchanged (oh2 stays at gene end).
