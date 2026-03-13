# Brainstorm: Unified DP for Joint SB-Tile Optimization

**Date:** 2026-03-13
**Research question:** Can we design a single-pass DP that jointly optimizes superblock (SB) and tile boundary placement to maximize minimum set fidelity across all tile reactions?

---

## 1. The Problem

### Current two-step approach
1. **SB DP** places superblock boundaries to maximize individual overhang scores (P_fid × P_eff)
2. **Tile DP** places tile boundaries within each SB segment, using SB overhangs as fixed aliens

### Why this is suboptimal
The SB DP doesn't know which tile overhangs will be chosen later. It picks the highest-scoring individual overhangs without considering cross-reactivity with future tile overhangs. Meanwhile, the Tile DP inherits fixed SB aliens it can't change, even if those aliens cross-react with the best tile boundary positions.

### The coupling
Every tile's Level 1 reaction contains **all** SB overhangs as aliens:
```
Tile_i reaction = {oh1_i, oh2_i, oh3, oh4} ∪ ALL_SB_overhangs
```

This is because each tile's WT gene blocks (leading: gene_start→tile_start, trailing: tile_end→gene_end+cassette) span the entire gene except the mutable tile region. All SB junction overhangs fall within these blocks.

---

## 2. Empirical Evidence

### 2.1 BsmBI cycling matrix statistics (Pryor et al. 2020)

| Metric | Value |
|--------|-------|
| Overhang pairs with **zero** cross-reactivity | 30,236 / 32,640 (92.6%) |
| Overhang pairs with <1% cross-reactivity | 31,261 / 32,640 (95.8%) |
| Individual P_fid range | 0.35 – 0.95 |
| Individual P_fid median | 0.64 |
| OOGGA-compatible pairs (identity ≤ 2) | 29,640 |
| OOGGA-compat pairs WITH nonzero cross-reactivity | 832 (2.8%) |

**Key insight:** Individual P_fid is misleading. It measures fidelity against all 256 possible partners, but reactions only have 4-8 overhangs. Set fidelity depends on which specific overhangs share a reaction. Randomly chosen 5-OH sets from the zero-cross-reactivity graph achieve set_fid = 1.000 with 100% success rate.

**Key gap:** OOGGA compatibility (Hamming distance > 2) is **not the same** as zero cross-reactivity. 832 pairs pass the OOGGA identity check but still have nonzero M[A,B] values in the cycling matrix. These mismatches cause set fidelity drops.

### 2.2 AKAP11 worked example (5706 nt, 1902 codons)

**Two-step picks:** SB overhangs = {AGAA, AGAA, AGAA} (all three SBs use the same highest-scoring overhang at score = 0.878)

**Result:** 3 of 23 tiles have set_fid < 0.95:

| Tile | OH1 | OH2 | Set Fidelity | Root Cause |
|------|-----|-----|-------------|------------|
| 18 | AGTG | TGTG | 0.754 | Intra-tile cross-reactivity: M[AGTG,TGTG]=46, M[TGTG,AGTG]=65 |
| 20 | TTTT | GGAA | 0.933 | SB-tile coupling: M[GGAA,AGAA]=39 × 3 SB copies |
| 21 | GGAA | GAGG | 0.933 | SB-tile coupling: same GGAA-AGAA cross-reactivity |

**Attempted fix:** Replace AGAA SBs with GGAA-safe alternatives (TTCT, AAAA):
- Tiles 20, 21 improved: 0.933 → 0.979, 0.991 ✓
- BUT new problems emerged: tile 5 dropped 0.981 → 0.946 ✗
- Tile 18 barely changed (0.754 → 0.758) because it's an intra-tile issue

**This demonstrates:** You can't fix the coupling by just avoiding one cross-reactivity — changing SBs shifts problems to different tiles. True joint optimization is needed.

---

## 3. Constraint Structure

```
Constraint domains for overhang compatibility:

GLOBAL (all must be mutually compatible):
  • All SB overhangs — appear in every reaction
  • oh3, oh4 — fixed, appear in every reaction

PER-TILE (must be compatible with each other AND with all globals):
  • oh1_i, oh2_i — appear only in tile i's reaction

INDEPENDENT:
  • Tile i overhangs ↔ Tile j overhangs — different tubes, no constraint
```

The **scoring function** is set fidelity per reaction:
```
f(X) = M[X,X] / sum(M[X,Y] for Y in reaction_set)
Set fidelity = product of f(X) for all X in reaction_set
```

The **objective** is:
```
maximize  min_{tile i} SetFidelity(tile_i_reaction)
```

---

## 4. Three DP Formulations

### 4.1 Formulation A: Penalty Accumulator DP

**Core idea:** Use a decomposable scoring function (product of pairwise terms) instead of exact set fidelity, enabling incremental tracking of retroactive SB-tile interactions.

**Scoring decomposition:**
```
For tile i with reaction R_i = {oh1_i, oh2_i, oh3, oh4} ∪ SB_set:

tile_score_i ≈ base_score(oh1_i, oh2_i, oh3, oh4)
              × Π_{s ∈ SB_set} pairwise_compat(oh1_i, s) × pairwise_compat(oh2_i, s)

where pairwise_compat(a, b) = 1 - M[a,b]/(M[a,a] + M[a,b])  (fraction of correct ligation)
```

**The penalty accumulator:**
```
accumulator[c] = Π_{all completed tiles i} pairwise_compat(oh1_i, c) × pairwise_compat(oh2_i, c)
```

This is a 256-element vector. When tile i completes, update: `accumulator[c] *= pw(oh1_i, c) × pw(oh2_i, c)` for all c. When an SB boundary is placed at position with overhang c, multiply the path score by `accumulator[c]`.

**Pseudocode:**
```
PENALTY_ACCUMULATOR_DP(gene, max_tile_len, max_block_len, oh3, oh4, K_sb):
  N = len(gene) / 3  # codons

  # Precompute
  oh[c] = gene_overhang_at(codon c)  for all c
  pw[a][b] = pairwise_compatibility(a, b, M)  # 256×256 lookup
  base_score[c1][c2] = pw[oh[c1]][oh[c2]] × pw[oh[c1]][oh3] × ...  # all fixed pairs

  # State: (position, tile_codon_count, sb_block_count, k_sb_placed, SB_set)
  # Value: (path_score, accumulator[256])

  Initialize: dp[0, 0, 0, 0, ∅] = (1.0, ones(256))

  For each state (pos, tc, sbc, k, S) with value (score, acc):
    oh_here = oh[pos]

    # Option 1: SKIP (no boundary here)
    if tc + 1 ≤ max_tile_codons AND sbc + 3 ≤ max_block_nt:
      Update dp[pos+1, tc+1, sbc+3, k, S] if better

    # Option 2: TILE BOUNDARY ONLY
    if tc ≥ min_tile_codons:
      tile_oh2 = oh_here
      tile_oh1 = oh[pos - tc]  # start of this tile

      # Score this tile against CURRENT SB set (incomplete — future SBs handled by accumulator)
      tile_score = base_score[tile_oh1][tile_oh2]
      for s in S:
        tile_score *= pw[tile_oh1][s] × pw[tile_oh2][s]

      new_score = score × tile_score

      # Update accumulator for the new tile's overhangs
      new_acc = copy(acc)
      for c in 0..255:
        new_acc[c] *= pw[tile_oh1][c] × pw[tile_oh2][c]

      Update dp[pos+1, 1, sbc+3, k, S] with (new_score, new_acc) if better

    # Option 3: SB BOUNDARY ONLY
    if k < K_sb AND sbc ≥ min_block_nt AND oh_here compatible with all in S:
      sb_penalty = acc[oh_here]  # retroactive penalty on all past tiles!
      new_score = score × overhang_quality(oh_here) × sb_penalty
      new_S = S ∪ {oh_here}

      Update dp[pos+1, tc+1, 3, k+1, new_S] with (new_score, acc) if better

    # Option 4: BOTH (tile + SB boundary at same position)
    # Combine Options 2 and 3

  Return best terminal state (pos=N, k=K_sb) → path gives all boundaries
```

**State comparison challenge:**
Two paths to the same (pos, tc, sbc, k, S) may have different accumulators. Path A might have higher score but worse accumulator (making future SBs more expensive). This creates a **multi-objective** comparison.

**Practical resolution:** Use a weighted heuristic:
```
effective_value = score × min_{c ∈ feasible_future_SBs(S)} acc[c]^(K_sb - k)
```
This estimates the worst-case future SB penalty and collapses to a single scalar.

**Complexity:** O(N × max_tc × max_sbc × K_sb × |reachable_SB_sets|)
- N ≈ 3000 codons
- max_tc ≈ 80 codons
- max_sbc ≈ 600 codons (1800 nt / 3)
- K_sb ≤ 5
- |reachable_SB_sets| — the bottleneck, potentially large

**Pros:** True single-pass; captures the retroactive coupling
**Cons:** Multi-objective state comparison; approximate scoring (pairwise ≠ set fidelity)

---

### 4.2 Formulation B: Hierarchical Beam DP (SB-first with re-evaluation)

**Core idea:** Run the SB DP with wide beam to get B candidate SB configurations. For each, run the tile DP and compute exact set fidelities. Return the joint-best.

**Pseudocode:**
```
HIERARCHICAL_BEAM_DP(gene, max_tile_len, max_block_len, oh3, oh4, K_sb, B):

  # Phase 1: SB DP with beam width B
  # Standard OOGGA DP, but keep top-B paths instead of just the best
  sb_configs = SB_DP_BEAM(gene, K_sb, max_block_len, beam_width=B)
  # Returns B candidate SB configurations: [{positions, overhangs, score}, ...]

  best_min_fid = -∞
  best_config = null

  # Phase 2: For each SB config, run tile DP and evaluate
  for config in sb_configs:

    # Run standard tile DP with config.overhangs as aliens
    tile_result = TILE_DP(gene, max_tile_len, aliens=config.overhangs ∪ {oh3, oh4})

    # Compute EXACT set fidelity for every tile reaction
    min_fid = +∞
    for tile in tile_result.tiles:
      reaction = {tile.oh1, tile.oh2, oh3, oh4} ∪ config.overhangs
      sf = compute_set_fidelity(reaction, M)
      min_fid = min(min_fid, sf.set_fidelity)

    # Track joint-best
    if min_fid > best_min_fid:
      best_min_fid = min_fid
      best_config = (config, tile_result)

  return best_config
```

**Complexity:** O(B × (SB_DP_cost + Tile_DP_cost + N_tiles × set_fid_cost))
- B = 10-100
- SB_DP with beam: O(N × K_sb × B) — fast
- Tile_DP: O(N × max_tc) — fast
- Total: very practical, seconds to minutes

**Pros:** Uses exact set fidelity scoring; simple implementation; practical
**Cons:** Not truly single-pass; beam width B is a tuneable (too small → misses optimal, too large → slow); doesn't explore SB-tile interactions within a single DP

---

### 4.3 Formulation C: Zero-Cross-Reactivity Feasibility DP

**Core idea:** Instead of optimizing a continuous score, treat the problem as a binary feasibility problem. Define "compatible" as M[A,B] = 0 AND M[B,A] = 0 (zero cross-reactivity in the cycling matrix). Find boundary placements where every reaction achieves set fidelity = 1.0.

**Data support:** 92.6% of all overhang pairs have zero cross-reactivity, and every randomly sampled 5-clique from the zero-cross-react graph achieves set_fid = 1.000. The solution space is rich.

**Precomputation:**
```
# Build zero-cross-reactivity graph on gene-derived overhangs
zero_graph[c1][c2] = (M[oh(c1), oh(c2)] == 0) AND (M[oh(c2), oh(c1)] == 0)

# For each position, compute zero-cross-react partners with oh3, oh4
valid_pos[c] = zero_graph[c][oh3_idx] AND zero_graph[c][oh4_idx]
```

**Pseudocode:**
```
ZERO_CROSS_FEASIBILITY_DP(gene, max_tile_len, max_block_len, oh3, oh4, K_sb):
  N = len(gene) / 3

  # Precompute zero-cross-reactivity for all position pairs
  zcr[c1][c2] = (M[oh(c1), oh(c2)] == 0 AND M[oh(c2), oh(c1)] == 0)

  # State: (position, tile_codon_count, sb_block_count, k_sb_placed, SB_positions_tuple)
  # Value: boolean (reachable or not) + backpointer

  # Additional constraint for SB positions:
  # Since SB overhangs appear in ALL tile reactions, every SB overhang must
  # have zero cross-reactivity with EVERY tile overhang (past and future).
  # This is the hard part — we don't know future tile overhangs.

  # SOLUTION: Two-phase approach within the feasibility DP

  # Phase 1: Enumerate valid SB overhang sets
  # A valid SB set S = {s1, ..., s_k} requires:
  #   (a) All pairs in S are zero-cross-reactive
  #   (b) All s in S are zero-cross-reactive with oh3 and oh4
  #   (c) There exist gene positions with these overhangs at correct spacing
  #   (d) For each s in S, enough tile boundary positions have overhangs
  #       that are zero-cross-reactive with s (feasibility check)

  valid_sb_sets = enumerate_valid_sb_sets(gene, K_sb, max_block_len)

  # Phase 2: For each valid SB set, find tile boundaries
  for S in valid_sb_sets:
    aliens = S ∪ {oh3, oh4}

    # Tile DP: find boundaries where oh1, oh2 at each tile are:
    #   - zero-cross-reactive with each other
    #   - zero-cross-reactive with ALL aliens
    tile_result = FEASIBILITY_TILE_DP(gene, max_tile_len, aliens)

    if tile_result.feasible:
      # Verify: compute actual set fidelity (should be 1.0 by construction)
      return (S, tile_result)

  # If no zero-cross set works, fall back to threshold-based optimization
  return FORMULATION_B(gene, ..., threshold=0.95)
```

**FEASIBILITY_TILE_DP inner DP:**
```
FEASIBILITY_TILE_DP(gene, max_tile_len, aliens):
  # Standard boundary DP, but transitions are binary:
  # A tile boundary at position c is valid iff:
  #   oh(c) is zero-cross-reactive with ALL aliens
  #   AND oh(c) is zero-cross-reactive with oh(tile_start)  [the tile's oh1]

  # State: (position, tile_start_codon)
  # Transition: if position c is a valid boundary given tile_start_codon:
  #   new state = (c+1, c)  [start new tile]

  # This is O(N × max_tc) — very fast
```

**Complexity:**
- Enumerate valid SB sets: O(|candidate_positions|^K_sb) with aggressive pruning
- Per SB set, tile DP: O(N × max_tc)
- Pruning: most positions are valid (92.6% zero-cross-react), so feasibility is likely

**Pros:** Achieves set_fid = 1.0 by construction; binary constraints simplify DP; fast
**Cons:** May be infeasible for some genes/tile configurations; falls back to Formulation B

---

## 5. Comparison Summary

| Property | A: Penalty Accumulator | B: Hierarchical Beam | C: Zero-Cross Feasibility |
|----------|----------------------|---------------------|--------------------------|
| **True single-pass?** | Yes | No (nested) | No (enumeration + DP) |
| **Scoring** | Approximate (pairwise) | Exact (set fidelity) | Exact (binary) |
| **Handles retroactive coupling?** | Yes (via accumulator) | Yes (via re-evaluation) | Yes (by construction) |
| **Set fidelity guarantee** | No hard guarantee | Best-of-B guarantee | = 1.0 if feasible |
| **State space** | Large (accumulator in state) | Small per DP | Small per DP |
| **Implementation complexity** | High | Low | Medium |
| **Practical runtime** | Minutes? | Seconds | Seconds |
| **When it shines** | Theoretical elegance | Most genes | Genes with rich zero-CR landscape |

---

## 6. Recommended Approach

**Start with C, fall back to B.**

**Rationale:**
1. The data shows 92.6% of overhang pairs have zero cross-reactivity. For most genes, a zero-cross-reactive configuration exists.
2. Formulation C gives the strongest guarantee (set_fid = 1.0) with the simplest DP.
3. When C fails (rare gene sequences with constrained overhang landscape), Formulation B with beam_width=50-100 provides a practical fallback.
4. Formulation A is theoretically interesting but the multi-objective state comparison makes implementation complex without clear advantage over B.

**Key insight that simplifies everything:** The current DP uses OOGGA's identity-based compatibility check (max_identity ≤ 2) as a proxy for cross-reactivity. But the actual cycling matrix is the ground truth. Replacing the OOGGA identity check with a **matrix-derived zero-cross-reactivity check** in the existing DP infrastructure would capture 97.2% of what OOGGA catches, while eliminating the 2.8% of OOGGA-compatible pairs that actually cross-react.

---

## 7. Implementation Path

### Step 1: Build the zero-cross-reactivity compatibility matrix
Replace `build_oh_compatibility(max_identity)` with `build_oh_zcr_compatibility(M, threshold)`:
```r
build_oh_zcr_compatibility <- function(pairwise_matrix, max_cross = 0) {
  all_ohs <- rownames(pairwise_matrix)
  n <- length(all_ohs)
  compat <- matrix(TRUE, n, n, dimnames = list(all_ohs, all_ohs))
  for (i in 1:n) {
    for (j in 1:n) {
      if (i == j) next
      if (pairwise_matrix[i,j] > max_cross || pairwise_matrix[j,i] > max_cross) {
        compat[i,j] <- FALSE
      }
    }
  }
  compat
}
```

### Step 2: Modify existing tile DP to use ZCR compatibility
Swap the compatibility matrix in `search_tile_boundaries_oogga()` from identity-based to ZCR-based. The DP mechanics stay identical — only the compatibility check changes.

### Step 3: Implement SB beam search
Modify `search_sb_boundaries_oogga()` to return top-B paths instead of just the best. This is a small change to the existing beam search (already supports beam_width parameter).

### Step 4: Wire up the hierarchical evaluation
For each of B SB configurations, run the (now ZCR-based) tile DP, compute exact set fidelity, return the joint best.

### Step 5: Validate
- Run on AKAP11, TRIO, GRIN2A, SLC6A1
- Compare worst-case set fidelity: current two-step vs. joint approach
- Verify that ZCR-based DP finds valid configurations where identity-based DP produces sub-0.95 tiles

---

## 8. Literature Review Summary

### No existing tool solves this problem
A comprehensive literature search confirms that **no published tool performs joint optimization of fragment boundaries and overhang selection across multiple assembly levels**. The field has converged on single-level approaches:

| Tool | Approach | Multi-level? | Joint boundary+OH? |
|------|----------|-------------|-------------------|
| **OOGGA** (Mukundan 2025, preprint) | DP with multiplicative scoring | No | Yes (single-level) |
| **NEBridge SplitSet** (NEB) | Stochastic Monte Carlo | No | No (sequential) |
| **GGAssembler** (Fleishman Lab 2024) | Graph shortest-path with rainbow coloring | No | No (pre-filter then path) |
| **j5** (Hillson 2012) | Heuristic search | Partial (heuristic) | Unknown |
| **DIMPLE** (Cowan 2023) | Rule-based tiling | No | No |

### Key theoretical insight: Bellman's optimality breaks
OOGGA's DP has a subtle issue: the optimal subpath to position j depends on **which overhangs were used** (not just the accumulated score), because collision constraints are path-dependent. This breaks Bellman's principle of optimality. Our beam search extension addresses this. The OOGGA paper doesn't discuss this because single-level paths are short enough that it rarely matters.

### OOGGA's scoring function
OOGGA uses a weighted sum: `Total = (w_eff × Π_efficiencies) + (w_fid × Π_fidelities)` with tunable w_eff, w_fid. Our implementation uses the product `P_fid × P_eff` per overhang, which is equivalent to w_eff=1, w_fid=1 with multiplicative combining.

### GGAssembler's rainbow path approach
GGAssembler assigns "colors" to overhangs that cross-ligate and requires paths to use each color at most once. This is solved via randomized color-coding: O(2^k × n^O(1)) where k = number of colors. This is conceptually similar to our compatibility matrix but formalized as a graph coloring problem.

### The bilevel optimization framing
Our problem maps onto **bilevel combinatorial optimization**:
- **Upper level (leader):** Choose K superblock boundaries
- **Lower level (follower):** Given SB boundaries, choose tile boundaries to maximize worst-case tile fidelity
- **Coupling:** SB overhangs appear as aliens in all tile reactions

Known approaches: nested DP (our two-pass), single-pass DP on full state space (exponential), column generation / Benders decomposition (overkill for our problem size).

### Key references
- Potapov et al. 2018, ACS Synth Biol — foundational 256×256 fidelity matrix
- Pryor et al. 2020, PLoS ONE — BsmBI cycling data (our data source)
- Mukundan & Madhusudhan 2025, bioRxiv — OOGGA DP algorithm
- Hoch et al. 2024, Protein Sci — GGAssembler graph approach
- Strzelecki et al. 2024, NAR — thermodynamic overhang strength model
- Terzi & Tsaparas — sequence segmentation DP theory (k-segmentation)

---

## 9. Open Questions

1. **Threshold tuning for ZCR:** Should we use strict M[A,B]=0 or allow M[A,B] ≤ threshold? If we allow small nonzero values (e.g., M[A,B] ≤ 5), we get more candidate positions at the cost of slightly imperfect set fidelity.

2. **Tile 18 problem (AGTG-TGTG):** This is intra-tile cross-reactivity (oh1 vs oh2), not SB-tile coupling. Joint SB-tile optimization can't fix this — the tile boundary needs to MOVE. Should the tile DP also use ZCR compatibility for oh1-oh2 pairs?

3. **Scalability for very large genes (>10,000 nt):** With K_sb > 5, the SB beam search space grows. Is B=100 sufficient, or do we need smarter SB enumeration?

4. **Interaction with overlap extension:** Tile boundaries have oh1 and oh2 at offset positions (with overlap). Does ZCR compatibility between oh1 and oh2 at the same tile boundary constrain the overlap size?

5. **Formulation A viability:** Is there a principled way to collapse the 256-element accumulator to a scalar for state comparison? Could we use the minimum over all elements as a conservative bound?

---

## 9. Key Data Tables for Reference

### Set fidelity: impact of adding overhangs to a reaction
```
Base set {GCTA, AACG, TTAC, CAGT}: set_fid = 1.0000
+ GCTC (cross-reacts with GCTA):    set_fid = 0.8453  ← catastrophic drop
```

### OOGGA vs zero-cross-reactivity
```
Total OOGGA-compatible pairs:     29,640 (90.8% of all pairs)
  → with zero cross-reactivity:  28,808 (97.2% of OOGGA-compat)
  → with nonzero cross-react:       832 ( 2.8% — the gap!)

Total zero-cross-react pairs:     30,236 (92.6% of all pairs)
  → Some zero-CR pairs FAIL OOGGA  (identity > 2 but M=0)
```

### Per-tile SB impact (AKAP11 example)
```
SB config = {AGAA ×3} (two-step optimal):
  Tile 20: GGAA → per_oh_fid = 0.948  (cross: M[GGAA,AGAA]=39 × 3 copies)
  Tile 21: GGAA → per_oh_fid = 0.948

SB config = {TTCT, AAAA, TTCT} (GGAA-safe):
  Tile 20: GGAA → per_oh_fid = 0.979  ✓ fixed
  Tile 5:  TTGG → per_oh_fid = 0.946  ✗ new problem (TTGG-TTCT cross-react)
```
The whack-a-mole pattern: fixing one tile breaks another. Only joint optimization sees the full picture.
