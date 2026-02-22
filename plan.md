# Plan: Optimize Barcode Generation Strategy

**Status: IMPLEMENTED** (2026-02-22)

## What Changed

Replaced the greedy O(n²) prefix generation with algebraically optimal methods:

1. **GF(4) shortened Hamming code** (primary, for d ≤ 3)
   - New module: `R/07b_linear_codes.R`
   - Implements GF(4) arithmetic, parity-check matrix construction, Gaussian elimination, code shortening, and codeword enumeration/sampling
   - For prefix_length=12: [12, 9, ≥3]₄ code with 4^9 = 262,144 codewords (deterministic, instant)
   - For prefix_length > 14: random sampling from the code (distance guarantee preserved by linearity)

2. **DNABarcodes lexicode** (fallback, for any d)
   - Conway heuristic first (fast, deterministic), Ashlock if Conway insufficient
   - Handles d ≥ 4 where Hamming codes don't apply
   - Already a project dependency

3. **Greedy methods removed entirely**
   - `generate_prefixes_greedy()`, `generate_prefixes_random_greedy()`, `generate_prefixes_greedy_excluding()` all deleted
   - No scenario where they outperform the algebraic methods

4. **Vectorized suffix generation**
   - Single-batch generation of all suffix candidates across all variants
   - Single-pass `filter_barcodes_batch()` applies enzyme site, homopolymer, GC, and junction context filters in one vectorized call
   - Per-variant retry only for the rare cases where initial batch was insufficient

5. **Validation skipped for algebraic codes**
   - When `code_type == "linear"` or `"lexicode"`, the O(n²) `validate_prefix_distances()` is bypassed
   - Distance guarantee is algebraic, not empirical

## Code Flow

```
generate_prefixes(k, min_hamming, n_needed):
│
├─ IF min_hamming <= 3:
│   ├─ PRIMARY: GF(4) Hamming Code (generate_prefixes_linear)
│   │   ├─ k ≤ 14: enumerate all 4^(k-3) codewords
│   │   └─ k > 14: sample & encode (d ≥ 3 still guaranteed)
│   │   → biological filter (enzyme sites, homopolymers, junctions)
│   │   → if enough after filtering: DONE (code_type = "linear")
│   │
│   └─ FALLBACK: DNABarcodes (Conway → Ashlock)
│       → biological filter
│       → if enough: DONE (code_type = "lexicode")
│
├─ IF min_hamming >= 4:
│   ├─ PRIMARY: DNABarcodes Conway
│   └─ FALLBACK: DNABarcodes Ashlock
│       → biological filter
│       → if enough: DONE (code_type = "lexicode")
│
└─ ERROR: impossible parameters
```

## Two-Stage Filtering Strategy

**Stage 1 — Filter PREFIXES** (cheap, eliminates fundamentally bad sequences):
- Enzyme sites in prefix alone (no suffix can rescue)
- Homopolymer runs in prefix (suffix can only make worse)
- Junction context (prefix ends/starts creating enzyme sites with flanking oligo)

**Stage 2 — Filter FULL BARCODES** (single vectorized batch via `filter_barcodes_batch()`):
- Enzyme sites in full barcode or spanning prefix-suffix boundary
- Full-length GC content in 25–75% range
- Homopolymer runs spanning prefix-suffix boundary
- Junction context with flanking oligo sequences

Safe because removing codewords from a code with minimum distance d preserves d ≥ d_code.

## Files Changed

| File | Change |
|------|--------|
| `R/07b_linear_codes.R` | **NEW** — GF(4) arithmetic, Hamming code construction, codeword generation |
| `R/07_barcode_design.R` | Rewrote prefix generation flow, vectorized suffix generation, added `filter_barcodes_batch()`, removed greedy functions, conditional validation |
| `tests/testthat/test-barcode-design.R` | Added GF(4) tests, updated for new `generate_prefixes()` API, removed greedy-specific tests |
| `run_pipeline.R` | Added `source("07b_linear_codes.R")` |
| `tests/testthat/setup.R` | Added `source("07b_linear_codes.R")` |

## Parameter Robustness

| Parameter | GF(4) Linear Code | DNABarcodes Lexicode |
|-----------|-------------------|---------------------|
| d = 3 (default) | **Primary** — Hamming code, optimal | Fallback |
| d ≥ 4 | Not supported (would need BCH) | **Primary** — handles any d |
| prefix_length ≤ 14 | Full enumeration | Works well |
| prefix_length > 14 | Sampling (d guarantee preserved) | Too slow / infeasible |
| prefix_length ≤ 8 | Limited capacity (≤1024) | Similar limitation |

## Research Summary

| Approach | Applicable? | Verdict |
|----------|------------|---------|
| GF(4) Hamming codes | Yes (d=3) | **Implemented as primary** — deterministic, maximum capacity |
| DNABarcodes lexicode | Yes (any d) | **Implemented as fallback** — general-purpose, well-tested |
| BK-trees | Marginal benefit | **Not implemented** — vectorized approach is competitive at current scale |
| De Bruijn graphs | No | **Not applicable** — solves substring orthogonality, not Hamming distance |
| BCH codes (d>3) | Possible but complex | **Not implemented** — DNABarcodes handles d>3 adequately |
