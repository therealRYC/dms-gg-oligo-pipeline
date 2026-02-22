# Plan: Optimize Barcode Generation Strategy

## Analysis of Current Implementation

### Current Architecture (07_barcode_design.R)
The pipeline uses a **unified hierarchical prefix-suffix design**:
- **Prefix** (default 12 nt): One unique prefix per variant, hard Hamming distance ≥ 3 guarantee
- **Suffix** (default 8 nt): Random filtered suffixes per prefix, no pairwise constraint
- Cross-variant d(full) ≥ d(prefix) ≥ min_hamming (guaranteed by prefix)
- Scale: 5K–50K variants × 10 barcodes/variant = 50K–500K total barcodes

### Current Bottlenecks
1. **Greedy prefix selection is O(n_candidates × n_selected)**: For prefix_length=12, random sampling 500K candidates, each checked against all previously selected prefixes via vectorized `colSums`. This is effectively O(500K × n_prefixes_needed).
2. **Suffix generation loops over each variant independently**: `generate_barcodes_per_prefix()` iterates over all variants one-by-one with random sampling + filtering per variant — not vectorized across variants.
3. **Validation is O(n²)**: `validate_prefix_distances()` checks all prefix pairs exhaustively.
4. **Non-deterministic**: Random shuffling/sampling means different runs produce different barcode sets.
5. **Suboptimal capacity**: Greedy typically achieves 60–90% of theoretical maximum; the random start makes this unpredictable.

### Theoretical Capacity Bounds (n=12, d=3, q=4)
| Bound | Max Codewords |
|-------|--------------|
| Singleton bound | 4^10 = 1,048,576 |
| Hamming (sphere-packing) bound | 4^12 / V(12,1) ≈ **453,438** |
| Current greedy (estimated) | ~50K–100K (varies by run) |

The current approach leaves significant capacity on the table, though for most DMS genes (≤50K variants) it is sufficient.

---

## Alternative Approaches Evaluated

### 1. BK-Trees (Burkhard-Keller Trees)
**What they do**: Metric space tree exploiting triangle inequality to prune Hamming distance queries from O(n) to O(log n) per lookup.

**Applicability**: Would replace the linear scan in greedy selection (`all(dists >= min_hamming)`) with a "does any selected prefix have distance < d?" query.

**Expected benefit**: 2–5× speedup over brute-force for n_selected in 5K–50K range with d=3. However, benchmarks from `cppbktree` show that **for distance thresholds > 2 and datasets under ~100K, simple linear scans with good cache behavior are competitive**. Your current vectorized `colSums` approach already has good cache behavior.

**Verdict**: **Marginal benefit at current scale.** Would require Rcpp implementation for any real speedup in R. Worth considering only if prefix generation becomes a bottleneck at >100K prefixes.

### 2. De Bruijn Sequences/Graphs
**What they do**: Cyclic sequences where every possible k-mer appears exactly once. Used by Seqwalk (Gowri et al. 2024, Nature Computational Science) for hybridization-orthogonal probe design.

**Applicability**: De Bruijn-based methods optimize **substring orthogonality** (no shared k-mers between barcodes), which minimizes cross-hybridization. This is the **wrong optimization criterion** for DMS barcodes, where we need **Hamming distance ≥ 3 for sequencing error correction**.

**Verdict**: **Not applicable.** De Bruijn graphs solve a fundamentally different problem (FISH probes, DNA-PAINT) than yours (Illumina sequencing error correction).

### 3. Linear Codes over GF(4) — The Most Promising Approach
**What they do**: Algebraic code constructions where the minimum distance d is **guaranteed by the mathematical structure** of the generator matrix. Each codeword is produced by matrix multiplication in O(n) time — **no pairwise distance checking needed**.

**Key insight**: DNA naturally maps to GF(4) = {0, 1, α, α+1} via A=0, C=1, G=α, T=α+1. A linear code [n, k, d]₄ produces exactly 4^k codewords of length n with guaranteed minimum Hamming distance d.

**Specific construction for our parameters**: A **shortened quaternary Hamming code**:
- Start with Ham₄(3) = [21, 18, 3]₄ (a perfect code)
- Shorten to **[12, 9, 3]₄** by fixing 9 coordinate positions
- Produces **4^9 = 262,144 codewords** with guaranteed d ≥ 3
- After ~50% biological filtering → **~131K usable prefixes**
- This is 2–3× more than the greedy approach and far exceeds the 50K variant ceiling

**Critical property**: Removing codewords from a linear code (for biological filtering) **preserves the minimum distance guarantee**. The pairwise distance between any two remaining codewords is still ≥ d. This means post-hoc GC/homopolymer/enzyme filtering is safe.

**Verdict**: **Best theoretical approach.** Deterministic, optimal capacity, O(n) per codeword, no pairwise checking. Requires implementing GF(4) arithmetic.

### 4. Lexicodes (Conway-Sloane) via DNABarcodes Package
**What they do**: Iterate through all vectors in lexicographic order, greedily accepting those with d ≥ d_min from all accepted vectors. Conway & Sloane (1986) showed these often produce optimal or near-optimal codes.

**DNABarcodes package**: Already an `Imports` dependency in the project. Implements Conway lexicode (`heuristic="conway"`) and Ashlock evolutionary (`heuristic="ashlock"`) algorithms. `create.dnabarcodes(n=12, dist=3, metric="hamming")` would directly produce a high-quality prefix set.

**Expected yield**: ~80K–140K barcodes for n=12, d=3 (Conway: ~80K, Ashlock: ~140K).

**Verdict**: **Easiest quick win.** The package is already a dependency. Using it for prefix generation would likely produce a larger, more deterministic prefix set than the current random greedy — with minimal code changes.

---

## Implementation Plan

### Step 1: Use DNABarcodes for Prefix Generation (Quick Win)
Replace the custom greedy prefix generation with `DNABarcodes::create.dnabarcodes()` for the core prefix set, then layer biological filtering on top.

**Changes to `R/07_barcode_design.R`:**

- Add new function `generate_prefixes_lexicode(k, min_hamming, n_needed)` that:
  1. Calls `DNABarcodes::create.dnabarcodes(n=k, dist=min_hamming, metric="hamming", heuristic="conway")` (or "ashlock" for maximum capacity)
  2. Converts the DNAStringSet result to character vector
  3. Applies `filter_sequences_fast()` for enzyme sites and homopolymers
  4. Applies `filter_barcode_junctions()` for junction context
  5. Returns filtered prefix set

- Modify `generate_prefixes()` to use lexicode as primary path, falling back to greedy if DNABarcodes is unavailable or insufficient

- Modify `generate_prefixes_random_greedy()` to use lexicode for prefix_length > 10 as well (DNABarcodes handles arbitrary lengths)

**Benefits:**
- Deterministic (same prefix set every run with Conway heuristic)
- Larger prefix pool (~80K–140K vs ~50K–100K)
- Simpler code (delegates distance-constrained generation to well-tested package)
- No change to downstream suffix generation or validation

### Step 2: Vectorize Suffix Generation (Performance)
The current `generate_barcodes_per_prefix()` loops over each variant independently. Batch the suffix generation across all variants.

**Changes to `R/07_barcode_design.R`:**

- Generate ALL suffix candidates in one batch: `matrix(sample(bases, suffix_length * n_total_candidates), ...)` where `n_total_candidates = n_variants * n_suffix_candidates`
- Paste ALL suffixes with their respective prefixes in one vectorized `paste0()` call using `rep(prefixes, each=n_suffix_candidates)`
- Apply `filter_sequences_fast()` once on the entire batch (vectorized `grepl`)
- Apply GC filter once on the entire batch
- Split by variant, sample `barcodes_per_variant` per group
- Retry only for variants that didn't get enough valid suffixes

**Expected speedup**: 5–20× for suffix generation phase (eliminates R-level per-variant loop overhead, single vectorized `grepl` call instead of n_variants calls)

### Step 3: Implement GF(4) Linear Code Construction (Optimal Capacity)
For maximum capacity and mathematical elegance, implement a shortened quaternary Hamming code generator.

**New file `R/07b_linear_codes.R`:**

- `gf4_add(a, b)`: Addition in GF(4) (XOR of 2-bit representations)
- `gf4_mul(a, b)`: Multiplication in GF(4) using lookup table
- `gf4_hamming_generator(m)`: Construct the parity-check matrix H for Ham₄(m), derive generator matrix G
- `gf4_shorten_code(G, target_n)`: Shorten the code to target length
- `gf4_encode_all(G)`: Enumerate all 4^k message vectors, multiply by G, map to DNA
- `generate_prefixes_linear(k, min_hamming, n_needed)`: Main entry point that constructs the code, enumerates codewords, applies biological filtering

**GF(4) arithmetic is simple** — it's GF(2²) with elements {0, 1, α, α²} where α² + α + 1 = 0. All operations reduce to small lookup tables (4×4 for add, 4×4 for multiply).

**Mapping**: 0→A, 1→C, α→G, α²→T (or any consistent mapping)

**Benefits:**
- Generates 262K codewords for [12, 9, 3]₄ — maximum practical capacity
- O(n) per codeword, no pairwise checking
- Fully deterministic
- Mathematically proven minimum distance

### Step 4: Skip Exhaustive Validation When Using Linear Codes
When prefixes come from a linear code, `validate_prefix_distances()` is redundant — the algebraic structure guarantees d ≥ 3. Add a `skip_validation` flag to avoid the O(n²) validation step.

**Changes:**
- Add `code_type` attribute to prefix sets ("greedy", "lexicode", "linear")
- In `design_barcodes()`, skip `validate_prefix_distances()` when `code_type == "linear"` or `code_type == "lexicode"`
- Keep validation available as an opt-in paranoia check

### Step 5: BK-Tree for Greedy Fallback (Optional, Future)
If the greedy path is retained as a fallback, add a BK-tree to accelerate distance checking. This is lower priority since Steps 1 and 3 eliminate the need for greedy selection in most cases.

**Implementation**: Pure R BK-tree (acceptable for <50K elements) or Rcpp for >50K.

---

## Summary of Expected Improvements

| Metric | Current | After Step 1 | After Step 2 | After Step 3 |
|--------|---------|-------------|-------------|-------------|
| Prefix capacity (n=12, d=3) | ~50K–100K (varies) | ~80K–140K (stable) | Same | ~131K (deterministic) |
| Prefix generation time | Seconds–minutes | Seconds | Same | Milliseconds |
| Suffix generation time | O(n_variants) loop | Same | ~5–20× faster | Same |
| Validation time | O(n²) | O(n²) | Same | Skipped (proven) |
| Deterministic? | No | Yes (Conway) | Same | Yes |
| Code complexity | Medium | Lower | Similar | Higher (new module) |

## Recommended Implementation Order
1. **Step 1** (DNABarcodes lexicode) — immediate, low-risk, biggest bang for buck
2. **Step 2** (vectorize suffixes) — moderate effort, good performance win
3. **Step 3** (GF(4) linear codes) — higher effort, maximum theoretical capacity
4. **Step 4** (skip validation) — trivial once Step 1 or 3 is done
5. **Step 5** (BK-tree) — optional, only if greedy fallback matters
