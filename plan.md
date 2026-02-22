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

---

# Plan: PolIII Terminator Filter for Barcodes

**Status: IMPLEMENTED** (2026-02-22)

## Problem

RNA Polymerase III terminates transcription at runs of ≥4 consecutive thymidines on the non-template strand (`TTTT` in the sense/coding direction). Since the barcode is transcribed by a PolIII promoter (U6), any `TTTT` in the barcode will cause premature transcription termination, yielding a truncated barcode RNA.

The current homopolymer filter uses `max_homopolymer = 4`, which generates the regex `([ACGT])\1{4,}` — this catches runs of **5+** identical bases. `TTTT` (4 Ts) passes through undetected.

This is distinct from the general homopolymer aesthetic concern — it's a functional requirement for PolIII-transcribed barcodes.

Note: `06_overhang_selection.R` already defines `HOMOPOLYMER_4NT <- c("AAAA", "CCCC", "GGGG", "TTTT")` for overhang selection, showing awareness of this issue, but the barcode filter doesn't use it.

## Implementation

### Step 1: Add PolIII terminator constant to `constants.R`
- Add `POLIII_TERM_SEQ <- "TTTT"` with comment explaining the biological rationale (PolIII termination signal)

### Step 2: Update `filter_barcodes_batch()` in `07_barcode_design.R`
- Add parameter `filter_poliii_term = TRUE`
- When TRUE: `bad <- bad | grepl(POLIII_TERM_SEQ, barcodes, fixed = TRUE)`
- Place after the homopolymer check (logically related)

### Step 3: Update `filter_sequences_fast()` in `07_barcode_design.R`
- Add same PolIII terminator check so prefixes are also filtered
- Ensures no prefix contains `TTTT`

### Step 4: Thread parameter through calling functions
- `generate_barcodes_per_prefix()`: add `filter_poliii_term` param, pass to `filter_barcodes_batch()`
- `design_barcodes()`: add `filter_poliii_term` param, pass through
- Default TRUE since the pipeline always uses PolIII for barcode transcription

### Step 5: Update `10_qc_checks.R`
- Add QC check: no barcode contains `TTTT`

### Step 6: Update tests
- Test that barcodes containing `TTTT` are rejected
- Test that `TTTA`, `ATTT` etc. pass (only runs of 4+ Ts are blocked)

### Impact analysis
For an 8-nt suffix, ~3.1% of random candidates will contain `TTTT`. With 500 candidates per variant (oversample_factor=20), this is negligible — plenty will still pass. For 12-nt prefixes, the GF(4) code has 262,144 codewords; filtering out ~6-8% with `TTTT` still leaves >240K, far exceeding the ~30K needed for GRIN2A.
