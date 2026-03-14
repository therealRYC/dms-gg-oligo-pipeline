# Deep Dive: OOGGA Algorithm (Optimal Overhang Golden Gate Assembly)

**Date:** 2026-03-13
**Paper:** https://doi.org/10.1101/2025.06.16.659877 (Mukundan S, 2025 preprint)
**Repo:** https://github.com/ (cloned locally at `~/Fowler Lab/.../OOGGA/`)
**Source analyzed:** `OOGGA.py` (438 lines), `eval_frags.py` (112 lines)

## Research Question

How does the OOGGA algorithm work, what are its design choices, and how does it compare to our R reimplementation in `R/06b_oogga_dp.R`?

## Key Findings

### Architecture Overview

OOGGA is a single-class Python program (`Dyna_frag`) that uses dynamic programming to find optimal DNA fragmentation points for Golden Gate assembly. The flow is:

```
load_csv_table_as_di()  →  Parse NEB ligation fidelity matrix
read_fasta()            →  Parse input DNA sequence
Dyna_frag.__init__()    →  Orchestrates: make_matrix() → traceback()
```

### 1. Scoring Table: `load_csv_table_as_di()`

Reads the Potapov et al. 2018 NEB data — a 256×256 ligation count matrix where rows and columns are all possible 4-nt overhangs. The diagonal element for overhang X is the count of X ligating to its correct Watson-Crick partner. Off-diagonal elements are misligation counts.

Two metrics per overhang:

- **Relative efficiency** = `diagonal_count / max_diagonal_count × 100`
  - How well this overhang ligates *relative to the best overhang*. If `AATT` is the best-ligating overhang and `GCTA` ligates at half the rate, `GCTA` gets efficiency ~50.

- **Fidelity** = `diagonal_count / row_total × 100`
  - What fraction of all ligation events involving this overhang are *correct* (ligating to the intended partner vs. misligating to something else).

**Implementation detail**: Two-pass read of the CSV. First pass finds `max_count` (highest diagonal value across all overhangs), second pass computes both metrics. The `diagonal_pos` counter walks along the diagonal (row 1 → column 1, row 2 → column 2, etc.).

Return value: dict `{'NNNN': (efficiency%, fidelity%)}` for all 256 overhangs.

### 2. DP State Space: `make_matrix()`

2D dynamic programming over:
- **i** = fragment index (0, 1, 2, ..., K where K = ceil(len(seq)/min_len))
- **j** = position in DNA sequence (0 to len-1)

`mat[i][j]` = best combined score achievable using exactly `i` cut points, with the most recent cut at position `j`.

**Two parallel matrices:**
- `mat[i][j]` — the combined optimization score
- `split_mat[i][j]` — tuple `(eff_tally, fid_tally)` keeping efficiency and fidelity products separate for reporting

**Initialization:**
```python
mat[0][start_site] = 1           # seed score
split_mat[0][start_site] = (1, 1)  # (eff_product, fid_product) start at 1
```

**Search space pruning** (`get_j_range`): For row `i`, valid cut positions must be at least `min_len` past the earliest scored position in row `i-1`, and at most `max_len` past the latest. Avoids checking impossible positions.

### 3. Scoring Model: Multiplicative Probability Chain

The scoring model is **multiplicative, not additive**. Each overhang's efficiency and fidelity are treated as probabilities (divided by 100), and the running tally is a product chain:

```python
eff_new = eff_tally_at_j_ * (eff_of_current_overhang / 100)
fid_new = fid_tally_at_j_ * (fid_of_current_overhang / 100)
score = (eff_new ** eff_w) * (fid_new ** fid_w)
```

This models the physical reality: *all* junctions must ligate correctly for the assembly to succeed — one bad junction tanks the whole thing.

The `eff_w` and `fid_w` exponents (default both = 1) let users weight efficiency vs. fidelity. With defaults, `score = eff_product × fid_product`.

### 4. Overhang Compatibility: `__overlap_pass()`

The **constraint filter** that prevents cross-reactive overhangs. For every candidate cut, OOGGA traces back through all previously chosen overhangs and checks that the new overhang doesn't share more than `max_overhang_identity` (default 2) positional matches with any of them.

The check considers:
1. All overhangs from the traceback path to this cell
2. The terminal overhang (`seq[-4:]`)
3. Any `alien_overhangs` (user-specified, e.g., from the backbone vector)
4. **Reverse complements** of all the above — because in a GG reaction, both strands are present

Identity metric: simple positional matching — count how many of the 4 positions are identical between two overhangs. If any pair exceeds `max_overhang_identity`, the candidate is rejected.

**Performance note**: This is the bottleneck. At every DP cell, it must trace the full path back to the start. For long sequences with many fragments, this dominates runtime.

### 5. Traceback

After the matrix is filled, traceback finds terminal cells — positions `j` where `j + max_len > len(seq)` (meaning the last fragment can reach the end of the sequence). If `n_frag` is specified, it only looks at row `i = n_frag - 1`.

Solutions sorted by total score (descending), top `n_trace` reported.

The `__trace()` method follows `trace_di` pointers backward from `(i, j)` to `(0, start_site)`, collecting all cut positions. Returns list in **reverse order** (last cut first, start position last).

### 6. Fragment Extraction

`get_fragments()` converts cut positions into actual DNA fragments. Each fragment includes its 4-nt overhang on both ends (overlapping with adjacent fragments). `write_outfile()` produces a human-readable report with sequence numbering, break points, and per-fragment statistics.

## Algorithm Summary

```
Input:  DNA sequence + NEB fidelity data + length constraints
        ↓
Step 1: Parse NEB matrix → {overhang: (efficiency%, fidelity%)}
        ↓
Step 2: DP over (fragment_count × position) matrix
        At each cell: score = product(efficiencies) × product(fidelities)
        Constraint: no two overhangs share >2/4 positional matches
        ↓
Step 3: Find terminal cells, trace back top N paths
        ↓
Output: Ranked fragmentation plans with per-junction scores
```

## Constructor Parameters

| Parameter | Default | Meaning |
|-----------|---------|---------|
| `seq` | — | DNA sequence to fragment |
| `min_len`, `max_len` | — | Fragment length bounds |
| `n_frag` | `False` | Optional: force exactly N fragments |
| `n_trace` | 5 | Number of top solutions to report |
| `start_site` | 0 | Where in sequence to begin |
| `eff_w`, `fid_w` | 1, 1 | Exponent weights for efficiency vs. fidelity |
| `exclusion_list` | `[]` | Positions where cuts are forbidden |
| `inti_score` | 1 | Initial score seed |
| `max_overhang_identity` | 2 | Max allowed positional matches between any two overhangs |
| `alien_overhangs` | `[]` | External overhangs to check for cross-reactivity |

## Design Choices & Observations

1. **Multiplicative scoring** — physically grounded (assembly is a probability chain), but means scores shrink rapidly with more fragments. This makes comparing solutions with different fragment counts non-trivial.

2. **Identity-based overlap check** — simpler than using the full NEB misligation matrix. Checks positional matches (0-4 of 4 bases), not thermodynamic cross-reactivity. The default threshold of 2 means any two overhangs can share at most 2/4 matching positions.

3. **No reverse-complement overhang scoring** — the code looks up `seq[j:j+4]` in the scoring table but doesn't also score its reverse complement. The NEB matrix is symmetric, and in GG assembly the actual ligation involves the Watson-Crick complement. The overlap check does consider RC, but the scoring doesn't explicitly.

4. **Full traceback at every cell** — the overlap check in `__overlap_pass` calls `__trace()` which follows pointers all the way back. This is O(fragments) per cell, making total complexity roughly O(K × N² × K) where N = sequence length and K = max fragments.

5. **Only the best predecessor is kept** — at each cell, only one trace pointer is stored (the best-scoring predecessor). Alternative near-optimal paths are lost. The `n_trace` parameter finds multiple solutions by looking at different *terminal* cells, not by exploring alternative paths through the matrix.

6. **Tie-breaking is implicit (leftward bias)** — `__get_score_list` iterates `j_` from 0 upward, and `sorted(..., key=lambda x:x[0])` is stable, so among candidates with identical scores, the leftmost predecessor wins. There is no secondary tiebreaker on fidelity, efficiency, or fragment length. This creates a subtle bias toward shorter first fragments and longer later fragments when exact ties exist (likely rare with float arithmetic).

7. **`n_trace` solutions can be highly redundant** — Multiple terminal cells can trace back to the *exact same predecessor* in the prior row, sharing their entire path except the final cut. For example, terminal cells at `(3, 800)` and `(3, 850)` may both have `trace_di` pointing to `(2, 500)`, producing two "different" solutions that are really the same fragmentation with a 50 nt shift at the end. The algorithm has no mechanism to enforce diversity among the top-N solutions (no path exclusion, no next-best-path logic like Yen's algorithm). True diversity only occurs when terminal cells happen to trace through genuinely different intermediate paths.

## Detailed Walkthrough: Collision-Checking Call Chain

The collision check involves 4 methods calling each other:

```
make_matrix()  →  __get_score_list()  →  __overlap_pass()  →  __trace()
                                                            →  __find_identities()
```

### How it works step by step

1. **`__get_score_list(i, j, eff, fid)`** — For a candidate cut at `(i, j)`, loops over *every* position `j_` as a potential predecessor from row `i-1`. For each valid `j_` (correct fragment length, has a score), calls `__overlap_pass(i, j, j_)`.

2. **`__overlap_pass(i, j, j_)`** — The heart of the check:
   - Calls `__trace(i-1, j_)` to get the full path back to position 0
   - Extracts the 4-nt overhang at every cut position on that path
   - Adds the terminal overhang (`seq[-4:]`) and any alien overhangs
   - Builds comparison set: all existing overhangs (forward) + reverse complements of everything (including RC of the candidate overhang itself — because both strands are present in the GG ligation pot)
   - Calls `__find_identities()` to check each comparison against the candidate

3. **`__trace(i, j)`** — Follows `trace_di` pointers from `(i, j)` back to `(0, start_site)`, collecting all cut positions. Returns list in reverse order (newest cut first).

4. **`__find_identities(overhangs, current_overhang)`** — For each overhang in the comparison set, counts positional matches (0-4) against the candidate. Any match > `max_overhang_identity` (default 2) → rejection.

### Concrete example

Sequence = 1000 nt. DP at cell `(i=3, j=600)`, evaluating predecessor `j_=400`.

**Traceback**: `__trace(2, 400)` → follows pointers: `(2,400) → (1,200) → (0,0)` → returns `[400, 200, 0]`

**Overhang collection**:
- Path overhangs: `seq[400:404]`, `seq[200:204]`, `seq[0:4]` (say `GCTA`, `TTAG`, `ATGC`)
- Terminal: `seq[996:1000]` (say `CCGG`)
- Alien: e.g., `AGTC`

**Candidate**: `seq[600:604]` = `GCTG`

**Comparison set**: `[GCTA, TTAG, ATGC, CCGG, AGTC, RC(GCTA), RC(TTAG), RC(ATGC), RC(CCGG), RC(AGTC), RC(GCTG)]`

**Identity check** — `GCTG` vs `GCTA`: G=G, C=C, T=T, G≠A → **3 matches → FAIL** (exceeds threshold of 2). Position 600 rejected when coming from this path.

### Performance implications

The full traceback at every DP cell is the primary bottleneck. For a 3000 nt sequence with 200-500 nt fragments: ~6-15 rows × 3000 positions × ~300 valid predecessors × traceback length ~6-15 per check. The collision check is O(K) per candidate (where K = path length), nested inside O(N) candidates per cell, inside O(K × N) cells total.

### Suboptimality from single-path storage

Because `trace_di` stores only *one* pointer per cell (the best-scoring predecessor), the overlap check follows the single best path to each candidate. If that path contains a conflicting overhang, the candidate is rejected — even if an alternative, slightly-worse path to the same cell would have had compatible overhangs. The DP has no mechanism to explore these alternatives.

## R Implementation Comparison (`R/06b_oogga_dp.R` vs. `OOGGA.py`)

### 1. Path Storage: Single-predecessor vs. Beam Search

OOGGA stores **one** predecessor pointer per DP cell (`trace_di[make_key(i,j)] = make_key(i-1, j_)`). Our R stores up to `beam_width` (default 10) complete path entries per position (`dp_paths[[p]] = list of path entries`).

This directly addresses OOGGA's single-path limitation: when one path's overhang set conflicts with a candidate, another path at the same position might pass. The tradeoff is heavier memory (each path carries growing `ohs`, `positions`, `oh1s`, `oh2s` vectors) and more work per DP transition.

### 2. Collision Check: Full Traceback vs. Pre-computed Matrix

OOGGA traces the entire path at every DP cell and does character-by-character identity comparison (`__trace()` → `__find_identities()`). Our R pre-computes a 256×256 boolean compatibility matrix (`build_oh_compatibility()`) once before the DP, then does O(1) matrix lookups per (candidate, prior_oh) pair.

Additionally, our R doesn't need traceback at all because each beam path entry carries its full `ohs` vector forward. OOGGA must reconstruct the path because it only stores single-predecessor pointers.

### 3. Static Pre-filtering

OOGGA has no pre-filtering — self-palindrome and alien checks happen inside the DP inner loop, repeated for every predecessor evaluation. Our R precomputes a `static_ok[]` vector before the DP (lines 310-345 in `oogga_sb_dp_solve_k_v2()`, lines 713-746 in `oogga_tile_dp_solve_k()`), checking self-palindrome for oh1/oh2, alien compatibility, and oh1-oh2 mutual compatibility once per position. Positions that fail are skipped immediately in the inner loop (`if (!static_ok[b]) next`).

For a position visited from 100 different predecessors, our R does 1 static check; OOGGA does 100.

### 4. Scoring Model — Mathematically Equivalent (with caveats)

Both compute the same two metrics from the NEB pairwise matrix:

| Metric | OOGGA Python | Our R |
|--------|-------------|-------|
| Efficiency | `(diagonal / max_diagonal) × 100` | `diagonal / max_diagonal` |
| Fidelity | `(diagonal / row_total) × 100` | `diagonal / row_total` |
| Scale | Percentages (0–100) | Fractions (0–1) |

OOGGA divides by 100 at each DP step to convert back to fractions; our R is already in fractions.

**Key structural difference**: OOGGA tracks efficiency and fidelity as **separate running products** (`split_mat` stores `(eff_tally, fid_tally)` tuples), then combines at the end with configurable exponents: `score = (eff_product ^ eff_w) * (fid_product ^ fid_w)`. Our R combines them **upfront** into `overhang_score(oh) = fid * eff` before the DP starts.

With defaults (`eff_w = fid_w = 1`), the math is equivalent: OOGGA's `product(eff_i) × product(fid_i)` = our `product(fid_i × eff_i)` by commutativity. But if non-default weighting were ever desired (e.g., `fid_w=2` to prioritize fidelity), our R would need to separate the scores in the DP.

**Unknown-overhang handling**: OOGGA skips unknown overhangs entirely (catches `KeyError`, position stays `False` in matrix). Our R previously used a 0.5 fallback for unknown overhangs — this was identified during this analysis as incorrect (should skip/mark NA instead, matching OOGGA's behavior). Fix in progress in a parallel session.

### 5. Two-Overhang Model (domain-specific extension)

OOGGA uses one overhang per cut (`seq[j:j+4]`). Our R uses two overhangs per tile boundary: oh1 (first 4 nt of the next tile) and oh2 (4 nt at the overlap extension point, `overlap_codons` past the boundary). Both participate in the same BsmBI ligation reaction and must be collision-free.

This means our collision set grows at 2× the rate per boundary, making the constraint stricter. Both oh1 and oh2 are checked against all prior overhangs on the path:
```r
if (!all(compat_matrix[oh1, prior])) next
if (!all(compat_matrix[oh2, prior])) next
```

### 6. Two-Pass Architecture

OOGGA is single-pass: one DP over the entire sequence.

Our R is two-pass:
1. **Pass 1** (`search_sb_boundaries_oogga()`): DP for superblock boundaries across the full gene + cassette. Gene-region boundaries use two-OH scoring; cassette-region boundaries use single-OH.
2. **Pass 2** (`tile_segments_oogga()` → `search_tile_boundaries_oogga()`): Independent tile DP within each superblock segment. SB junction overhangs from Pass 1 become `alien_ohs`, preventing tile boundaries from colliding with superblock boundaries.

### 7. K Selection and Cross-K Comparison

OOGGA either uses a user-specified `n_frag` or searches all possible K values and compares raw scores — which is problematic because multiplicative scores shrink with more fragments (a 3-fragment solution with score 0.5 might be better per-junction than a 2-fragment solution with score 0.6).

Our R searches a focused range around `K_ideal ± dp_k_range` and compares by **geometric mean** (`score^(1/K)`), which normalizes for fragment count and fairly compares per-boundary quality across different K values.

### 8. Infeasibility Handling

OOGGA asserts and crashes (`assert self.sorted_score_li`). Our R gracefully relaxes the constraint from `max_identity=2` to `max_identity=3`, rebuilding the compatibility matrix and re-running the DP. This handles genes with constrained overhang landscapes that can't satisfy the stricter threshold.

### Summary Table

| Aspect | OOGGA Python | Our R (`06b_oogga_dp.R`) |
|--------|-------------|--------------------------|
| Paths per cell | 1 (single best) | Up to `beam_width` (default 10) |
| Collision check | Full traceback + char comparison | Pre-computed 256×256 matrix |
| Path state | Reconstructed via trace pointers | Carried forward in each path entry |
| Static pre-filter | None | Self-palindrome, alien, oh1/oh2 mutual |
| Overhangs per boundary | 1 (oh at cut) | 2 (oh1 + oh2) |
| Architecture | Single-pass | Two-pass (SB → tile) |
| K comparison | Raw score | Geometric mean normalization |
| Infeasibility handling | Assert/crash | Relax max_identity 2→3 |
| Scoring data | T4 37°C 18h (default) | BsmBI cycling |
| Tie-breaking | Implicit leftward | Beam retains multiple options |
| Unknown overhangs | Skip entirely (KeyError) | ~~0.5 fallback~~ → fixing to skip/NA |

## Open Questions (remaining)

1. **What does the paper add?** — The preprint may discuss the algorithm's theoretical properties, benchmarks, or design rationale not evident from code alone.
2. **Scoring with BsmBI cycling vs. T4 37°C** — OOGGA defaults to `FileS04_T4_18h_37C.csv`. Our pipeline uses BsmBI cycling conditions. How do these differ in practice? The underlying Potapov data is T4-only; we use Pryor et al. 2020 for BsmBI.
3. **How does `eval_frags.py` relate?** — Standalone overhang evaluator using the same `load_csv_table_as_di()`. Useful for scoring externally-chosen overhangs (e.g., NEB SplitSet results) without running the DP.
4. **Beam width sensitivity** — How does beam_width=10 compare to beam_width=1 (OOGGA-equivalent) on our benchmark genes? Are we actually using the beam diversity, or do paths converge?
