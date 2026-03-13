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

## Open Questions (for future exploration)

1. **How does our R implementation differ?** — Does `R/06b_oogga_dp.R` use the same multiplicative scoring? Same overlap check? Different optimizations?
2. **What does the paper add?** — The preprint may discuss the algorithm's theoretical properties, benchmarks, or design rationale not evident from code alone.
3. **Scoring with BsmBI cycling vs. T4 37°C** — OOGGA defaults to `FileS04_T4_18h_37C.csv`. Our pipeline uses BsmBI cycling conditions. How do these differ in practice?
4. **How does `eval_frags.py` relate?** — It's a standalone tool that scores a given set of overhangs using the same `load_csv_table_as_di()` function, but without the DP. Useful for evaluating externally-chosen overhangs (e.g., NEB SplitSet results).
