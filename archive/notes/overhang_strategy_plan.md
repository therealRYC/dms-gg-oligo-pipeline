# Overhang Strategy Refactoring Plan (v2)

> **Branch**: `claude/refine-overhang-strategy-Hd3Q9`
> **Scope**: Refactor tiling + overhang selection into an integrated system that
> dynamically searches tile boundaries for high-fidelity overhangs, uses
> Potapov Set 2 pre-validated overhangs, and validates with 256x256 pairwise
> ligation matrices.
> **Relates to**: T3 (Fix Overhang Selection), T7 (Superblock Reuse), T9 (Fidelity Threshold)

---

## 1. Problem Statement

### 1.1 Tiling is overhang-blind
The current pipeline fixes tile boundaries by pure geometry (even spacing at
`max_mutable_codons`), then extracts whatever 4-nt overhangs happen to fall at
those positions. This is backwards. The gene sequence at each candidate boundary
position yields a specific 4-nt overhang, and shifting the boundary by even one
codon produces a completely different overhang. We should **search** candidate
boundary positions for ones where the gene-derived overhang is already in a
pre-validated high-fidelity set.

### 1.2 Individual fidelity instead of set-level validation
The current code uses individual fidelity scores (diagonal of the ligation matrix).
This doesn't capture cross-reactivity between overhangs in the same reaction.
We need the full 256x256 pairwise ligation matrix for set-level validation.

### 1.3 Module separation creates blind spots
Overhang planning is split across `05_tiling.R`, `06_overhang_selection.R`, and
`09_wt_geneblock_design.R`. These modules make decisions without seeing each
other's constraints.

### 1.4 Superblock junction overhangs are incorrectly free-selected
In `apply_superblock_splitting()` (`09_wt_geneblock_design.R:336-421`), junction
overhangs are freely selected from the high-fidelity pool. But Golden Gate junction
overhangs at a split point **must be the 4 nt of gene sequence at that position**.
Both sub-blocks include this 4-nt sequence at their boundary; after enzyme digestion
and ligation, the junction is seamless. Freely-selected overhangs would insert
4 non-gene nucleotides at each junction, corrupting the reading frame.

---

## 2. Key Design Decisions

### 2.1 Use Potapov 2018 Set 2 (non-MoClo-constrained)

**Decision**: Use Potapov et al. 2018 Table 1, Set 2 (non-MoClo) as the default
pre-validated high-fidelity overhang set. NOT MoClo overhangs.

**Rationale**:
- MoClo overhangs are standardized for modular plant/yeast assembly — they include
  biologically-conventional positions (e.g., AATG at start codons) that have mediocre
  fidelity. We don't need MoClo compatibility.
- Potapov Set 2 is computationally optimized purely for mutual fidelity:
  - 20 overhangs at ~98.1% set-level fidelity
  - 10-member subset at >99% fidelity
- For pairwise validation matrices, use **enzyme-specific** data from Pryor et al. 2020:
  BsaI-specific matrix for BsaI reactions, BsmBI-specific for BsmBI reactions.

### 2.2 Overhangs are reaction-scoped

Overhangs only need to be mutually orthogonal **within a single enzyme reaction**.

Per-tile reactions and their overhangs:

| Reaction | Overhangs | Notes |
|----------|-----------|-------|
| **BsaI** (tile i) | oh_L, [5'WT superblock junctions], oh1_i, oh4 | oh_L = first 4 nt of gene (fixed). oh4 = freely selectable. |
| **BsmBI** (tile i) | oh2_i, [3'WT superblock junctions], oh3 | oh3 = freely selectable. |

**Implication**: oh3 (BsmBI) and oh4 (BsaI) are in different reactions, so they
CAN be the same sequence. oh1 values across tiles are in different reactions, so
they CAN repeat. The only cross-tile constraint is that oh4 must be orthogonal to
ALL oh1 values (since oh4 appears in every tile's BsaI reaction), and oh3 must be
orthogonal to ALL oh2 values.

### 2.3 Dynamic tile boundary search — not "tile then score"

The fundamental shift: **tile boundaries are flexible within a search window**.
Instead of fixing boundaries geometrically and hoping the overhangs are good,
we search candidate boundary positions for ones where the gene-derived overhangs
(oh1 and oh2) are members of the pre-validated high-fidelity set.

**Why this works**: At each candidate boundary codon B, the overhangs are:
- oh2 (upstream tile's 3' end) = `gene[(B*3)-3 .. B*3]`
- oh1 (downstream tile's 5' start) = `gene[(B*3)+1 .. (B*3)+4]`

Shifting B by 1 codon shifts both overhangs by 3 nt, producing completely different
4-nt sequences. In a search window of ±15 codons (30 candidates), with a 20-member
set, the probability that at least one candidate produces an overhang in the set is:
`1 - (1 - 20/256)^30 ≈ 1 - 0.922^30 ≈ 91%` per overhang.

For both oh1 AND oh2 to be in the set at the same position: lower probability, but
the algorithm prioritizes "at least one in set" over "neither in set."

### 2.4 Two-tier approach with mandatory pairwise validation

**Tier 1 (Default)**: Search boundaries for HF set membership → select oh3/oh4 from set
**Tier 2 (Fallback)**: If HF set can't satisfy constraints, score all candidates
using the 256x256 pairwise matrix and pick the best available
**Always**: Validate every reaction's complete overhang set using the pairwise matrix

---

## 3. The Algorithm

### 3.1 Overview

```
Phase 1: Compute search space (ideal layout + windows)
Phase 2: Score every candidate boundary position
Phase 3: Greedy forward assignment of boundaries
Phase 4: Select oh3, oh4 from HF set (excluding committed oh1/oh2 values)
Phase 5: Superblock split-point optimization (same search strategy)
Phase 6: Per-reaction pairwise validation
```

### 3.2 Phase 1: Compute search space

```
INPUT:
  cds              — domesticated gene sequence
  max_mutable_nt   — from compute_max_tile_size() (e.g., 243 nt = 81 codons)
  min_mutable_nt   — minimum tile size (e.g., max/3 = 81 nt = 27 codons)
  search_window_K  — ±K codons around ideal boundary (default 15)

COMPUTE:
  n_codons = nchar(cds) / 3
  max_codons = max_mutable_nt / 3
  min_codons = min_mutable_nt / 3
  n_tiles = ceiling(n_codons / max_codons)
  ideal_size = ceiling(n_codons / n_tiles)   # even distribution
  ideal_boundaries = [ideal_size, 2*ideal_size, ..., (n_tiles-1)*ideal_size]
```

### 3.3 Phase 2: Score candidate boundary positions

For each boundary i (i = 1..n_tiles-1):

```
  center = ideal_boundaries[i]

  # Window limits: ensure adjacent tiles stay within [min, max] size
  prev_end = boundaries[i-1].pos  (or 0 for first boundary)
  lo = max(prev_end + min_codons, center - K)
  hi = min(n_codons - min_codons, center + K)    # leave room for last tile

  For B in lo..hi:
    oh2_B = substring(cds, B*3 - 3, B*3)          # last 4 nt if upstream tile ends at codon B
    oh1_next_B = substring(cds, B*3 + 1, B*3 + 4) # first 4 nt if downstream tile starts at codon B+1

    oh2_in_hf = oh2_B %in% hf_set
    oh1_in_hf = oh1_next_B %in% hf_set
    oh2_fid = individual_fidelity(oh2_B)     # from 256-overhang fidelity table
    oh1_fid = individual_fidelity(oh1_next_B)

    # Composite score:
    #   Priority 1: both in HF set (20 points)
    #   Priority 2: one in HF set (10 points)
    #   Priority 3: sum of individual fidelities (0-2 points, tiebreaker)
    score = 10 * (oh2_in_hf + oh1_in_hf) + oh2_fid + oh1_fid

    candidates[i].append({pos=B, oh2=oh2_B, oh1_next=oh1_next_B,
                          oh2_in_hf, oh1_in_hf, score})

  Sort candidates[i] by score descending
```

### 3.4 Phase 3: Greedy forward assignment

```
  oh_L = substring(cds, 1, 4)    # fixed: first 4 nt of gene
  assigned_boundaries = []

  For i in 1..(n_tiles-1):
    For cand in candidates[i]:   # iterate in score order (best first)
      # HARD CONSTRAINT: oh1_next must not collide with oh_L
      # (oh_L is in every BsaI reaction; oh1_next will also be in its tile's BsaI reaction)
      oh1_ok = (cand.oh1_next != oh_L) &&
               (cand.oh1_next != RC(oh_L))

      # HARD CONSTRAINT: tile sizes must stay within [min, max]
      prev_boundary = if (i == 1) 0 else assigned_boundaries[i-1].pos
      tile_before_size = (cand.pos - prev_boundary) * 3
      size_ok = (tile_before_size >= min_mutable_nt) &&
                (tile_before_size <= max_mutable_nt)

      # Also check last tile won't be too small
      if (i == n_tiles - 1):
        last_tile_size = (n_codons - cand.pos) * 3
        size_ok = size_ok && (last_tile_size >= min_mutable_nt)

      If (oh1_ok && size_ok):
        assigned_boundaries[i] = cand
        break

    If boundary i not assigned:
      # Relax: take best-scoring candidate that satisfies size constraints
      assigned_boundaries[i] = first candidate satisfying size_ok only
```

### 3.5 Phase 4: Select oh3 and oh4 from HF set

```
  # Collect all committed gene-derived overhangs
  all_oh1 = {oh_L} ∪ {boundary.oh1_next for each boundary}
  # Also include oh1 of first tile = oh_L (already in set)
  # Also include oh2 of last tile = last 4 nt of gene (fixed)
  oh2_last = substring(cds, nchar(cds)-3, nchar(cds))
  all_oh2 = {boundary.oh2 for each boundary} ∪ {oh2_last}
  # oh2 of first tile boundary:
  oh2_first = oh2 extracted from first tile's end position (assigned_boundaries[1].oh2
              or the full gene end if single tile)

  # Select oh4: must be orthogonal to ALL oh1 values in BsaI reactions
  oh4_exclude = all_oh1 ∪ RC(all_oh1)
  oh4_candidates = hf_set \ oh4_exclude
  oh4 = highest-fidelity member of oh4_candidates

  # Select oh3: must be orthogonal to ALL oh2 values in BsmBI reactions
  oh3_exclude = all_oh2 ∪ RC(all_oh2)
  oh3_candidates = hf_set \ oh3_exclude
  oh3 = highest-fidelity member of oh3_candidates

  # oh3 and oh4 CAN be the same sequence (different reactions)

  # VERIFY: for each tile, oh1 ≠ oh4 and oh2 ≠ oh3 (and their RCs)
  # If violation found: try next-best oh3/oh4 candidate
```

### 3.6 Phase 5: Superblock split-point optimization

Same search strategy as tile boundaries. For any WT gene block that exceeds the
synthesis limit (1800 nt), search candidate split positions within the block for
positions where the gene-derived junction overhang is in the HF set.

```
  For each oversized block:
    n_splits = ceiling(block_length / max_block_length) - 1
    target_sub_size = block_length / (n_splits + 1)

    For each needed split s:
      center = block_start + s * target_sub_size
      # Search window: ±50 codons (wider than tile boundaries since block is long)
      For each candidate position C in window:
        junction_oh = gene[C*3-3 .. C*3]     # gene-derived 4-nt at split

        # Check: junction_oh must be orthogonal to other overhangs in same reaction
        # (BsaI for 5'WT blocks, BsmBI for 3'WT blocks)
        in_hf = junction_oh %in% hf_set
        fidelity = individual_fidelity(junction_oh)
        score = 10 * in_hf + fidelity

      Pick best candidate; add its junction_oh to the reaction's overhang set
```

### 3.7 Phase 6: Per-reaction pairwise validation

```
  For each tile i:
    bsai_ohs = [oh_L, 5'WT_junction_ohs..., oh1_i, oh4]
    bsmbi_ohs = [oh2_i, 3'WT_junction_ohs..., oh3]

    bsai_fidelity = compute_set_fidelity(bsai_ohs, bsai_pairwise_matrix)
    bsmbi_fidelity = compute_set_fidelity(bsmbi_ohs, bsmbi_pairwise_matrix)

    If fidelity < threshold:
      WARN: "Tile {i} {reaction} has low predicted fidelity ({fidelity})"
```

### 3.8 Fallback: Tier 2 (pairwise matrix selection)

If Phase 4 fails (can't find oh3/oh4 in HF set orthogonal to all gene-derived
overhangs), fall back to:

1. Start with all 256 overhangs
2. Exclude those matching any gene-derived overhang (identity or RC)
3. Filter to individual fidelity >= 0.90
4. For oh4: score each candidate by worst pairwise cross-reactivity with all
   oh1 values, using the BsaI pairwise matrix
5. For oh3: same, using BsmBI pairwise matrix with all oh2 values
6. Pick the candidate with the best (lowest) worst-case cross-reactivity

---

## 4. Architecture Changes

### 4.1 Module responsibilities (before → after)

```
BEFORE:
  05_tiling.R             → compute_max_tile_size() + partition_tiles() +
                             compute_superblock_boundaries() + assign_variants_to_tiles()
  06_overhang_selection.R → extract_tile_overhangs() + select_fixed_overhangs() +
                             select_superblock_overhangs()
  09_wt_geneblock_design.R → design_wt_geneblocks() + apply_superblock_splitting()

AFTER:
  05_tiling.R             → compute_max_tile_size() + assign_variants_to_tiles()
                             (pure math only — no boundary decisions)

  06_overhang_selection.R → INTEGRATED assembly planning:
                             search_tile_boundaries()  — dynamic boundary search (Phase 2-3)
                             plan_assembly()            — master function (all phases)
                             compute_set_fidelity()     — pairwise matrix math
                             optimize_split_points()    — superblock split search (Phase 5)
                             validate_reaction_overhangs() — pairwise validation (Phase 6)
                             load_pairwise_matrix()     — data loading
                             load_high_fidelity_set()   — Potapov Set 2 loading

  09_wt_geneblock_design.R → design_wt_geneblocks() ONLY
                             (receives assembly_plan, no independent splitting/selection)
```

### 4.2 Data flow

```
compute_max_tile_size()  [05_tiling.R — pure oligo budget math]
         │
         ▼ max_mutable_nt
plan_assembly(cds, polIII, max_mutable_nt, max_block_length, config)
  [06_overhang_selection.R — master function]
         │
         ├─ search_tile_boundaries(cds, max_mutable_nt, hf_set)
         │     → tiles data.frame with optimized oh1/oh2
         │
         ├─ select oh3, oh4 from hf_set (excluding committed oh1/oh2)
         │
         ├─ optimize_split_points() for oversized blocks
         │     → superblock_splits with gene-derived junction overhangs
         │
         ├─ validate_reaction_overhangs() per tile via pairwise matrix
         │     → per-reaction fidelity scores
         │
         └─ assembly_plan (tiles, oh3, oh4, splits, fidelity report)
                │
                ▼
assign_variants_to_tiles(variants, tiles)  [05_tiling.R]
                │
                ▼
design_wt_geneblocks(cds, polIII, tiles, assembly_plan, ...)
  [09_wt_geneblock_design.R — sequence generation only]
```

### 4.3 Pipeline step changes in run_pipeline.R

```
BEFORE (steps 6-9):
  Step 6: compute_max_tile_size() + partition_tiles() + assign_variants_to_tiles()
  Step 7: extract_tile_overhangs()
  Step 8: select_fixed_overhangs(oh3, oh4)
  Step 9: compute_superblock_boundaries()

AFTER (steps 6-7):
  Step 6: compute_max_tile_size()                              [05_tiling.R]
  Step 7: plan_assembly() → returns tiles + oh3/oh4 + splits   [06_overhang_selection.R]
          Then: assign_variants_to_tiles()                      [05_tiling.R]
```

---

## 5. Function Specifications

### 5.1 `search_tile_boundaries(cds, max_mutable_nt, min_mutable_nt, hf_set, oh_fidelity, search_window_K)`

The core boundary search algorithm (Phases 1-3 from Section 3).

**Parameters:**
- `cds`: domesticated gene sequence
- `max_mutable_nt`: maximum tile mutable region (from `compute_max_tile_size()`)
- `min_mutable_nt`: minimum tile size (default: `max_mutable_nt %/% 3`, floor 81 nt)
- `hf_set`: character vector of pre-validated high-fidelity overhangs (Potapov Set 2)
- `oh_fidelity`: data.frame with overhang + fidelity columns (256 rows)
- `search_window_K`: ±K codons around ideal boundary (default 15)

**Returns:** data.frame with columns:
- `tile_id`, `start_codon`, `end_codon`, `start_nt`, `end_nt`
- `oh1_seq`, `oh2_seq` (4-nt overhangs at boundaries)
- `oh1_in_hf`, `oh2_in_hf` (logical: is this overhang in the HF set?)
- `oh1_fidelity`, `oh2_fidelity` (individual fidelity scores)
- `tile_seq` (WT gene sequence for this tile region)
- `boundary_shift` (how far from ideal position, in codons)

### 5.2 `plan_assembly(cds, polIII, max_mutable_nt, max_block_length, config)`

Master function that orchestrates all phases.

**Parameters:**
- `cds`: domesticated gene sequence
- `polIII`: PolIII promoter sequence
- `max_mutable_nt`: from `compute_max_tile_size()`
- `max_block_length`: synthesis limit (default 1800)
- `config`: list with `fidelity_threshold`, `manual_oh3`, `manual_oh4`,
  `search_window_K`, `min_mutable_codons`

**Returns:** `assembly_plan` list:
```r
list(
  tiles = data.frame(
    tile_id, start_codon, end_codon, start_nt, end_nt,
    oh1_seq, oh2_seq, oh1_in_hf, oh2_in_hf,
    oh1_fidelity, oh2_fidelity, tile_seq, boundary_shift
  ),
  oh3 = "XXXX",                     # selected fixed BsmBI overhang
  oh4 = "YYYY",                     # selected fixed BsaI overhang
  oh_L = "ZZZZ",                    # first 4 nt of gene (fixed)
  oh3_in_hf = TRUE/FALSE,           # is oh3 from the HF set?
  oh4_in_hf = TRUE/FALSE,
  superblock_splits = data.frame(
    block_type, tile_id, split_nt, junction_oh,
    junction_in_hf, junction_fidelity
  ),
  reaction_fidelity = data.frame(
    tile_id, reaction_type,         # "BsaI" or "BsmBI"
    overhangs,                      # semicolon-separated list
    n_overhangs, n_in_hf,           # count and HF membership count
    set_fidelity,                   # predicted set-level fidelity
    min_pairwise_score              # worst pairwise score in reaction
  ),
  strategy_used = "hf_set" | "pairwise_matrix",
  hf_set_used = character(),        # which HF set was used
  summary = list(
    n_tiles = integer,
    n_boundaries = integer,
    n_boundaries_both_in_hf = integer,
    n_boundaries_one_in_hf = integer,
    n_boundaries_neither_in_hf = integer,
    n_superblock_splits = integer,
    overall_min_fidelity = numeric
  )
)
```

### 5.3 `compute_set_fidelity(overhangs, pairwise_matrix)`

Compute predicted set-level fidelity for overhangs in one reaction.

**Algorithm** (Potapov 2018 method):
```r
# For each overhang X in the set:
#   f(X) = M[X, X] / sum(M[X, Y] for all Y in set)
# where M[X, Y] = ligation frequency of X with RC(Y)
#
# Set-level fidelity = product of f(X) for all X
#   (= probability that ALL junctions ligate correctly)

compute_set_fidelity <- function(overhangs, pairwise_matrix) {
  n <- length(overhangs)
  per_oh_fidelity <- numeric(n)

  for (i in seq_len(n)) {
    oh_i <- overhangs[i]
    # Sum of ligation with all overhangs in the set (including correct partner)
    total <- sum(pairwise_matrix[oh_i, overhangs])
    correct <- pairwise_matrix[oh_i, oh_i]  # correct Watson-Crick pairing
    per_oh_fidelity[i] <- correct / total
  }

  list(
    set_fidelity = prod(per_oh_fidelity),
    per_overhang = data.frame(
      overhang = overhangs,
      correct_fraction = per_oh_fidelity
    )
  )
}
```

### 5.4 `optimize_split_points(cds, block_start_nt, block_end_nt, max_sub_length, existing_ohs, hf_set, oh_fidelity, search_window)`

Search for superblock split positions where gene-derived junction overhang is in
the HF set. Same philosophy as tile boundary search.

### 5.5 `validate_reaction_overhangs(reaction_overhangs, pairwise_matrix, threshold)`

Refactored from current identity/RC check to use pairwise matrix.

**Checks:**
1. No identity or RC collisions (hard fail — assembly won't work)
2. Pairwise cross-reactivity below threshold for all pairs
3. Set-level fidelity above threshold

### 5.6 `load_pairwise_matrix(enzyme_name)`

Load 256x256 pairwise ligation matrix. Try enzyme-specific (Pryor 2020) first,
fall back to generic (Potapov 18h).

### 5.7 `load_high_fidelity_set(set_name)`

Load pre-validated overhang set. Default: Potapov 2018 Table 1, Set 2 (non-MoClo).

---

## 6. Data Requirements

### 6.1 Pre-validated high-fidelity set (NEW)

**`data/neb_overhang_fidelity/high_fidelity_sets.rds`**
- Named list of character vectors
- `$greedy_fidelity_20`: 20-overhang set generated by greedy individual-fidelity selection (legacy, NOT from Potapov Table 1)
- `$greedy_fidelity_10`: 10-overhang greedy subset
- **Note:** Default HF set is now `POTAPOV_TABLE1_SET3_25` (hard-coded, 25 overhangs, 95.8% set fidelity). The RDS sets above are legacy fallbacks only.

### 6.2 Full 256x256 pairwise ligation matrices (NEW)

**`data/neb_overhang_fidelity/potapov_18h_pairwise.rds`**
- 256x256 named numeric matrix (row/col names = 4-nt overhang sequences)
- `M[i,j]` = ligation frequency of overhang i with RC(overhang j)
- Source: Potapov 2018 supplementary data / tatapov Python package

**`data/neb_overhang_fidelity/bsai_pairwise.rds`**
- Same format, BsaI-specific (Pryor et al. 2020, PLOS ONE)

**`data/neb_overhang_fidelity/bsmbi_pairwise.rds`**
- Same format, BsmBI-specific (Pryor 2020)

Individual fidelity can be derived from the matrix:
`fidelity(X) = M[X,X] / sum(M[X,*])`. Keep existing 256x1 files for backward compat.

### 6.3 Data generation

Update `data/generate_data.R` to hardcode the pairwise matrices and HF sets.
Matrices are 65,536 values each (~500 KB compressed RDS). Static published data,
so embedding is appropriate.

---

## 7. Changes to Existing Modules

### 7.1 `05_tiling.R`

**Keep:**
- `compute_max_tile_size()` — pure oligo budget math, unchanged
- `assign_variants_to_tiles()` — pure lookup, unchanged

**Remove:**
- `partition_tiles()` — replaced by `search_tile_boundaries()` in 06
- `compute_superblock_boundaries()` — replaced by `optimize_split_points()` in 06

### 7.2 `06_overhang_selection.R`

**Complete rewrite.** Old functions (`extract_tile_overhangs`, `select_fixed_overhangs`,
`select_orthogonal_set`, `select_superblock_overhangs`) are replaced by the new
integrated planning system described in Section 5.

**Keep as internal helpers:**
- `builtin_overhang_fidelity()` — 256-overhang individual fidelity data
- `validate_fixed_overhangs()` — manual oh3/oh4 validation

### 7.3 `09_wt_geneblock_design.R`

**Refactor `design_wt_geneblocks()`** to accept `assembly_plan` parameter
instead of `tile_overhangs` + `superblock_boundaries`.

**Remove:**
- `apply_superblock_splitting()` — replaced by assembly_plan's pre-computed splits
- All calls to `select_superblock_overhangs()`

The function becomes a pure sequence generator: given the assembly plan (which
specifies exactly where to split and which overhangs to use), it builds the block
sequences.

### 7.4 `run_pipeline.R`

Replace steps 6-9 with:
```r
# Step 6: Compute oligo budget
tile_size <- compute_max_tile_size(cfg$max_oligo_length, cfg$barcode_length)

# Step 7: Plan assembly (dynamic tile boundaries + overhang selection)
assembly_plan <- plan_assembly(
  cds = gene$cds,
  polIII = cfg$polIII_promoter,
  max_mutable_nt = tile_size,
  max_block_length = cfg$max_geneblock_length,
  config = list(
    fidelity_threshold = cfg$overhang_fidelity_threshold,
    manual_oh3 = cfg$oh3,
    manual_oh4 = cfg$oh4,
    search_window_K = cfg$search_window_K  # new config option, default 15
  )
)
tiles <- assembly_plan$tiles
oh3 <- assembly_plan$oh3
oh4 <- assembly_plan$oh4

# Step 8: Assign variants to tiles
variants <- assign_variants_to_tiles(variants, tiles)
```

And update step 12:
```r
geneblock_result <- design_wt_geneblocks(
  cds = gene$cds,
  polIII = cfg$polIII_promoter,
  tiles = tiles,
  assembly_plan = assembly_plan,
  paqci_star2 = cfg$paqci_star2,
  paqci_star1 = cfg$paqci_star1,
  max_block_length = cfg$max_geneblock_length
)
```

### 7.5 `10_qc_checks.R`

Add new QC check: **per-reaction predicted fidelity**
- Report set-level fidelity for each tile's BsaI and BsmBI reactions
- WARN if any reaction < 0.90
- FAIL if any reaction < 0.80
- Report how many tile boundaries have overhangs in the HF set

### 7.6 `00_config.R` + `config_template.yaml`

New config options:
```yaml
# Tile boundary search
search_window_K: 15           # ±K codons around ideal boundary (default 15)
min_tile_codons: 27            # minimum tile mutable region in codons

# Overhang selection
overhang_set_fidelity_threshold: 0.95  # minimum set-level fidelity per reaction
```

---

## 8. Test Plan

### 8.1 Unit tests for boundary search

```
test: search_tile_boundaries finds boundaries in HF set
  - Synthetic gene where a known boundary has an HF set member
  - Verify the algorithm finds it

test: search_tile_boundaries respects min/max tile size
  - Verify no tile is smaller than min or larger than max

test: search_tile_boundaries handles single-tile gene
  - Short gene: no boundaries to search, single tile returned

test: search_tile_boundaries shifts from ideal when HF overhang available nearby
  - Gene where ideal boundary gives low-fidelity overhang but ±3 codons gives HF set member
  - Verify boundary_shift is nonzero and overhang is in HF set
```

### 8.2 Unit tests for set fidelity

```
test: compute_set_fidelity returns >0.99 for Potapov Set 2 (10-member)
test: compute_set_fidelity returns 0 for set with duplicate overhangs
test: compute_set_fidelity matches manually computed value for 3-overhang set
```

### 8.3 Unit tests for assembly planning

```
test: plan_assembly on short gene returns no superblocks, oh3/oh4 from HF set
test: plan_assembly on long gene returns superblock splits with gene-derived junctions
test: plan_assembly reports per-reaction fidelity
test: plan_assembly accepts manual oh3/oh4 override
test: plan_assembly falls back to pairwise matrix when HF set exhausted
```

### 8.4 Integration test updates

Update `test-integration.R`:
- Short gene: verify tiles have optimized boundaries, assembly_plan has fidelity report
- Long gene: verify superblock splits use gene-derived overhangs (not freely selected)
- TRIO gene: verify all reactions pass pairwise validation

### 8.5 Regression

- All existing pipeline outputs remain valid
- QC still passes for all test genes

---

## 9. Implementation Order

1. **Data preparation** — Generate pairwise matrices + Potapov Set 2 in
   `data/generate_data.R` and RDS files

2. **Core math** — Implement `compute_set_fidelity()`, `load_pairwise_matrix()`,
   `load_high_fidelity_set()` (pure functions, no side effects)

3. **Boundary search** — Implement `search_tile_boundaries()` (the core new algorithm)

4. **Assembly planner** — Implement `plan_assembly()` (master function tying
   everything together: boundary search + oh3/oh4 selection + superblock splits +
   validation)

5. **Refactor 09** — Update `design_wt_geneblocks()` to accept assembly_plan

6. **Refactor 05** — Remove `partition_tiles()` and `compute_superblock_boundaries()`
   (now in 06)

7. **Update run_pipeline.R** — New step ordering

8. **Update config** — Add new config options

9. **Update tests** — Refactor existing, add boundary search and fidelity tests

10. **Update QC** — Add per-reaction fidelity reporting

---

## 10. Risk Assessment

### Low risk
- Adding pairwise matrix data: purely additive
- `compute_set_fidelity()`: new function, no side effects
- Boundary search: new function, doesn't touch existing code until wired in

### Medium risk
- Replacing `partition_tiles()`: changes the core tiling output format (adds
  HF membership columns). All downstream code that reads tiles must be checked.
- Removing `apply_superblock_splitting()`: must verify gene block design still works
  with pre-computed splits from assembly_plan
- Pipeline step reordering: integration test is the safety net

### Mitigation
- Build new functions first (additive phase)
- Wire them into the pipeline only after unit tests pass
- Run full integration test on all 3 test genes (300 nt, 2100 nt, 9294 nt TRIO)
  after each integration step
- Keep old functions available during development (remove only at the end)
