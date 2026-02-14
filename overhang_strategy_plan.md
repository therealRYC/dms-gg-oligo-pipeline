# Overhang Strategy Refactoring Plan

> **Branch**: `claude/refine-overhang-strategy-Hd3Q9`
> **Scope**: Refactor overhang selection to use pre-validated high-fidelity sets,
> full 256x256 pairwise ligation matrices, reaction-scoped planning, and
> integrated superblock split-point optimization.
> **Relates to**: T3 (Fix Overhang Selection), T7 (Superblock Reuse), T9 (Fidelity Threshold)

---

## 1. Problem Statement

The current overhang selection has three fundamental issues:

### 1.1 Individual fidelity instead of set-level validation
The current code selects overhangs based on **individual** fidelity scores (the diagonal
of the ligation matrix: `fidelity = M[X][RC(X)] / sum(M[X][*])`). This tells you how
faithfully an overhang ligates with its correct complement, but says nothing about
**cross-reactivity** between overhangs in the same reaction. Two overhangs can each have
0.98 individual fidelity but still cross-ligate at 5% because they happen to be similar.

What's needed: the full 256x256 pairwise ligation frequency matrix, where `M[X][Y]`
gives the ligation frequency of overhang X with the reverse complement of overhang Y.
Set-level fidelity is then computed as the product of correct-pairing probabilities
across all overhangs in one reaction.

### 1.2 Module separation creates blind spots
The current pipeline separates overhang planning across three modules:
- `05_tiling.R`: computes superblock boundaries → gene-derived junction overhangs
- `06_overhang_selection.R`: selects oh3, oh4 → freely chosen overhangs
- `09_wt_geneblock_design.R`: `apply_superblock_splitting()` → selects MORE junction
  overhangs independently

This means oh3/oh4 are selected without knowing how many superblock junction overhangs
will end up in the same reaction, and the superblock splitting in module 09 selects
overhangs without considering the choices already made in module 06.

### 1.3 Superblock junction overhangs are incorrectly free-selected
In `apply_superblock_splitting()` (`09_wt_geneblock_design.R:336-421`), junction
overhangs are selected from the high-fidelity pool as if they're freely choosable.
But in Golden Gate assembly, the junction overhang at a split point **must be the 4 nt
of gene sequence at that position**. Both sub-blocks include this 4-nt sequence at their
boundary; after enzyme digestion and ligation, the junction is seamless. Freely-selected
overhangs would insert 4 non-gene nucleotides at each junction, corrupting the reading
frame.

---

## 2. Design Principles

### 2.1 Overhangs are reaction-scoped
Overhangs only need to be mutually orthogonal **within a single enzyme reaction**.
Different reactions can reuse overhangs safely because each enzyme only cuts its own
recognition sites.

Per-tile reactions and their overhangs:

**BsaI reaction (Level 1)** for tile i:
| Overhang | Source | Selectable? |
|----------|--------|-------------|
| oh_L     | First 4 nt of gene (or superblock boundary) | Gene-derived |
| 5'WT superblock junction(s) | 4 nt at split point(s) in 5'WT | Gene-derived (split point choosable) |
| oh1_i    | 4 nt at tile i's 5' boundary | Gene-derived |
| oh4      | Barcode-helper junction | Freely selectable |

**BsmBI reaction (Level 1b)** for tile i:
| Overhang | Source | Selectable? |
|----------|--------|-------------|
| oh2_i    | 4 nt at tile i's 3' boundary | Gene-derived |
| 3'WT superblock junction(s) | 4 nt at split point(s) in 3'WT | Gene-derived (split point choosable) |
| oh3      | PolIII-barcode junction | Freely selectable |

**Implication**: oh3 and oh4 are in different reactions, so they **could** be the same
sequence. The current code unnecessarily requires them to be different. (We may still
want them different for clarity/robustness, but it's not a hard constraint.)

### 2.2 Gene-derived overhangs constrain the design
oh1, oh2, and oh_L are determined by tile boundaries — fixed once tiling is done.
Superblock junction overhangs are gene-derived at the split point, but you CAN choose
WHERE to split (within the block region that needs splitting), giving some optimization
freedom.

Only oh3 and oh4 are truly freely selectable.

### 2.3 Two-tier selection with mandatory pairwise validation

**Tier 1 (Default): Pre-validated high-fidelity sets**
- Potapov et al. 2018 Table 1 provides experimentally validated overhang sets:
  - 10-fragment set: >99% predicted fidelity
  - 20-fragment set: ~98.1% predicted fidelity
  - 25-fragment set: ~97% predicted fidelity
- For the 2 freely-selectable overhangs (oh3, oh4): pick from the pre-validated set
- For typical genes, max overhangs per reaction = 3-6 (well within 10-member set)

**Tier 2 (Fallback): Full pairwise matrix selection**
- Used when: pre-validated set exhausted, or gene-derived overhangs have poor
  compatibility scores in the matrix
- Greedy selection maximizing set-level fidelity using the 256x256 matrix

**Always: Per-reaction pairwise validation**
- After ALL overhangs are determined (gene-derived + selected), validate every
  reaction's overhang set using the full pairwise matrix
- Report predicted set-level fidelity per reaction
- Warn if any pairwise cross-reactivity exceeds threshold

### 2.4 Superblock split-point optimization uses pairwise matrix
Instead of the current broken approach (split at arbitrary positions, select free
overhangs), the new approach:
1. Identify candidate split points on codon boundaries within the oversized block
2. At each candidate, extract the 4-nt gene-derived junction overhang
3. Score each candidate using the pairwise matrix (compatibility with all other
   overhangs in that reaction)
4. Choose split point(s) that maximize reaction-level fidelity

---

## 3. Data Requirements

### 3.1 Pre-validated overhang sets (NEW)
Bundle the specific overhang sets from Potapov et al. 2018 Table 1.

Source: Table 1 of Potapov et al. 2018 (ACS Synth Bio, DOI: 10.1021/acssynbio.8b00333)

These are stored as character vectors of 4-nt overhangs. Each set has been validated
for minimal mutual cross-reactivity.

**Sets to bundle:**
- Set 2 (non-MoClo, 20 overhangs): General-purpose, ~98.1% fidelity
- 10-overhang subset: >99% fidelity (for most pipeline use cases)
- Optionally: Set 1 (MoClo-constrained, 20 overhangs) for users with MoClo compatibility needs

### 3.2 Full 256x256 pairwise ligation matrices (NEW)
Replace the current 256x1 fidelity vectors with full 256x256 matrices.

Source: Supplementary data from Potapov 2018, repackaged via the `tatapov` Python
package (Edinburgh Genome Foundry). Also Pryor et al. 2020 for enzyme-specific data.

**Matrices to bundle:**
- `potapov_18h_pairwise.rds`: T4 DNA Ligase, 37C, 18h (256x256 named matrix)
- `bsai_pairwise.rds`: BsaI-specific, 37C, 1h (256x256)
- `bsmbi_pairwise.rds`: BsmBI-specific, 37C, 1h (256x256)

Matrix format: `M[i,j]` = ligation frequency of overhang i with RC(overhang j).
Diagonal `M[i,i]` should dominate (correct pairing). Off-diagonal = cross-reactivity.

**Deriving individual fidelity from the matrix:**
`fidelity(X) = M[X][X] / sum(M[X][*])` (probability of correct Watson-Crick pairing)

This means the existing individual fidelity data can be derived from the matrix,
so the matrix is a strict superset. We can keep the individual fidelity vectors for
backward compatibility / fast filtering.

### 3.3 Backward compatibility
Keep the existing 256x1 fidelity data files (`potapov_18h_overhangs.rds`, etc.) for
any code that still uses individual fidelity scores (e.g., initial candidate filtering).

---

## 4. Architecture Changes

### 4.1 Module responsibilities (before → after)

```
BEFORE:
  05_tiling.R           → tile partitioning + superblock boundary computation
  06_overhang_selection.R → oh3/oh4 selection + tile overhang extraction
  09_wt_geneblock_design.R → block sequence generation + independent superblock splitting

AFTER:
  05_tiling.R           → tile partitioning ONLY (pure geometry)
  06_overhang_selection.R → INTEGRATED assembly planning:
                             - tile overhang extraction
                             - WT block size computation
                             - superblock need determination
                             - split point optimization (gene-derived junction overhangs)
                             - oh3/oh4 selection (from pre-validated sets)
                             - per-reaction pairwise validation
                             - complete assembly plan output
  09_wt_geneblock_design.R → block sequence generation ONLY
                             (receives assembly plan from 06, no independent
                              overhang selection or splitting decisions)
```

### 4.2 Data flow

```
tiles (from 05)
    │
    ▼
plan_assembly_overhangs(tiles, cds, polIII, max_block_length, config)
    │
    ├── extract tile boundary overhangs (oh1, oh2, oh_L) ← gene-derived
    ├── compute WT block sizes per tile
    ├── determine which blocks need superblock splitting
    ├── for each oversized block:
    │     └── optimize_split_points() → gene-derived junction overhangs
    ├── count overhangs per reaction
    ├── choose_strategy(count) → Tier 1 or Tier 2
    ├── select oh3, oh4 (freely selectable)
    ├── validate all reactions via pairwise matrix
    │     └── compute_set_fidelity(reaction_overhangs, pairwise_matrix)
    └── output: assembly_plan
            │
            ▼
    design_wt_geneblocks(cds, polIII, tiles, assembly_plan)
            │
            └── generate block sequences using pre-computed split points
                and gene-derived junction overhangs from assembly_plan
```

### 4.3 Pipeline step changes in run_pipeline.R

```
BEFORE (steps 7-9):
  Step 7: Extract tile boundary overhangs        → 06_overhang_selection.R
  Step 8: Select fixed overhangs (oh3, oh4)      → 06_overhang_selection.R
  Step 9: Compute superblock boundaries           → 05_tiling.R

AFTER (single integrated step):
  Step 7: Plan assembly (overhangs + superblocks) → 06_overhang_selection.R
          Returns: assembly_plan with oh3, oh4, superblock_boundaries,
                   per-reaction overhang sets, per-reaction fidelity scores
```

---

## 5. Function Specifications

### 5.1 New/refactored functions in `06_overhang_selection.R`

#### `load_pairwise_matrix(enzyme_name)`
Load the full 256x256 pairwise ligation frequency matrix for a given enzyme.
Falls back to Potapov 18h generic data if enzyme-specific unavailable.
Returns: named 256x256 numeric matrix.

#### `load_high_fidelity_sets()`
Load pre-validated overhang sets from bundled data.
Returns: list of character vectors (e.g., `$set_10`, `$set_20`).

#### `compute_set_fidelity(overhangs, pairwise_matrix)`
Compute the predicted set-level fidelity for a group of overhangs that will be
in the same reaction.

**Algorithm** (from Potapov 2018):
For each overhang X in the set, the correct-pairing fraction is:
  `f(X) = M[X][X] / sum(M[X][Y] for all Y in set)`
Set-level fidelity = product of f(X) for all X in set (or geometric mean).

Alternatively, use the "fraction correct assemblies" metric from the paper:
For N overhangs, the probability that ALL junctions ligate correctly =
  `prod(f(X_i))` for i = 1..N

Returns: numeric fidelity score (0-1) and per-overhang breakdown.

#### `plan_assembly_overhangs(tiles, cds, polIII, max_block_length, config)`
Master function that integrates all overhang planning.

**Steps:**
1. Extract tile boundary overhangs (oh1, oh2) and oh_L (gene start)
2. For each tile, compute 5'WT and 3'WT block sizes
3. For blocks exceeding `max_block_length`:
   a. Call `optimize_split_points()` to choose split positions
   b. Extract gene-derived junction overhangs at split positions
4. Enumerate all overhangs per reaction (BsaI and BsmBI for each tile)
5. Count total freely-selectable overhangs needed (oh3, oh4)
6. Select oh3, oh4:
   - Try Tier 1: pick from pre-validated high-fidelity set
   - If that fails validation: fall back to Tier 2 (pairwise matrix search)
7. Validate ALL reactions using pairwise matrix
8. Report per-reaction predicted fidelity

**Returns:** `assembly_plan` list:
```r
list(
  tile_overhangs   = data.frame(tile_id, oh1_seq, oh2_seq, oh1_fidelity, oh2_fidelity),
  oh3              = "XXXX",
  oh4              = "YYYY",
  oh_L             = "ZZZZ",
  superblock_splits = data.frame(
    block_type,    # "bsai" or "bsmbi"
    tile_id,       # which tile's WT block this is
    split_nt,      # gene position of split
    junction_oh,   # 4-nt gene-derived overhang at split
    junction_fidelity
  ),
  reaction_overhangs = data.frame(
    tile_id,
    reaction_type,      # "BsaI" or "BsmBI"
    overhangs,          # semicolon-separated list
    n_overhangs,
    set_fidelity,       # predicted set-level fidelity
    min_pairwise_score  # worst pairwise score in the reaction
  ),
  strategy_used    = "pre_validated" or "pairwise_matrix",
  overall_min_fidelity = numeric
)
```

#### `optimize_split_points(cds, block_start, block_end, max_sub_length, existing_ohs, pairwise_matrix)`
Choose superblock split positions within a gene block region to maximize
junction overhang fidelity.

**Algorithm:**
1. Generate candidate split positions on codon boundaries within the block
2. For each candidate, extract the 4-nt gene-derived overhang
3. Filter: remove candidates whose overhang is identical to or RC of any
   existing overhang in the same reaction
4. Score each candidate using pairwise matrix (worst-case cross-reactivity
   with all other overhangs in the reaction)
5. If multiple splits needed: use greedy selection, adding the split with
   the best score at each step and updating the "existing" set

Returns: integer vector of split positions + character vector of junction overhangs.

#### `select_from_prevalidated_set(n_needed, exclude_overhangs, prevalidated_set, pairwise_matrix)`
Select n overhangs from a pre-validated set, excluding any that collide with
gene-derived overhangs in the same reaction.

**Algorithm:**
1. Filter pre-validated set: remove overhangs that match any in `exclude_overhangs`
   (identity or RC)
2. From remaining, pick `n_needed` overhangs by highest individual fidelity
3. Validate the complete set (selected + gene-derived) using pairwise matrix
4. If validation fails (set fidelity < threshold): return NULL to signal fallback

#### `select_from_pairwise_matrix(n_needed, exclude_overhangs, pairwise_matrix, fidelity_threshold)`
Fallback selection using the full pairwise matrix when pre-validated sets
don't work.

**Algorithm:**
1. Start with all 256 overhangs, exclude those matching `exclude_overhangs`
2. Filter to individual fidelity >= threshold
3. Greedy selection: iteratively add the overhang that maximizes the
   minimum pairwise fidelity in the growing set
4. After each addition, recompute set fidelity
5. Stop when n_needed selected or no candidates improve fidelity

#### `validate_reaction_overhangs(reaction_overhangs, pairwise_matrix, threshold)`
**Refactored** from current identity/RC-only check to use pairwise matrix.

Checks:
1. No identity or RC collisions (hard constraint — assembly fails)
2. No overhang contains enzyme recognition sites
3. Pairwise cross-reactivity below threshold for all pairs
4. Set-level fidelity above threshold

Returns: list with `pass` (logical), `set_fidelity`, `worst_pair`, `details`.

### 5.2 Changes to `05_tiling.R`

**Remove**: `compute_superblock_boundaries()` — logic moves to `06_overhang_selection.R`

**Keep**: `partition_tiles()`, `compute_max_tile_size()`, `assign_variants_to_tiles()`

### 5.3 Changes to `09_wt_geneblock_design.R`

**Remove**: `apply_superblock_splitting()`, `select_superblock_overhangs()` calls

**Refactor** `design_wt_geneblocks()` to accept `assembly_plan` instead of doing
its own superblock logic. The function receives pre-computed split points and
junction overhangs, and just generates the block sequences.

### 5.4 Changes to `run_pipeline.R`

Replace steps 7-9 with a single call:
```r
# Step 7: Plan assembly (overhangs + superblocks)
assembly_plan <- plan_assembly_overhangs(
  tiles = tiles,
  cds = gene$cds,
  polIII = cfg$polIII_promoter,
  max_block_length = cfg$max_geneblock_length,
  fidelity_threshold = cfg$overhang_fidelity_threshold,
  manual_oh3 = cfg$oh3,
  manual_oh4 = cfg$oh4
)
oh3 <- assembly_plan$oh3
oh4 <- assembly_plan$oh4
```

And update step 12 to pass the assembly plan:
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

---

## 6. Data File Changes

### 6.1 New data files needed

**`data/neb_overhang_fidelity/potapov_18h_pairwise.rds`**
- 256x256 named numeric matrix
- `M[i,j]` = ligation frequency of overhang i with RC(overhang j)
- Source: tatapov Python package or Potapov 2018 supplementary data
- Row/column names = 4-nt overhang sequences (alphabetical)

**`data/neb_overhang_fidelity/bsai_pairwise.rds`**
- Same format, BsaI-specific (Pryor 2020)

**`data/neb_overhang_fidelity/bsmbi_pairwise.rds`**
- Same format, BsmBI-specific (Pryor 2020)

**`data/neb_overhang_fidelity/high_fidelity_sets.rds`**
- List of pre-validated overhang sets
- `$set_10`: character vector of 10 overhangs (>99% set fidelity)
- `$set_20`: character vector of 20 overhangs (~98% set fidelity)
- Source: Potapov 2018 Table 1 (Set 2, non-MoClo-constrained)

### 6.2 Update `data/generate_data.R`
Add generation of pairwise matrices and high-fidelity sets.

For the pairwise matrices: since we can't run the tatapov Python package directly,
we have two options:
1. **Hardcode**: Embed the 256x256 matrices as R data (large but self-contained)
2. **Download**: Fetch from a cached source at generation time

Recommendation: Hardcode the matrices. At 256x256 = 65,536 values per matrix, this
is ~500 KB per matrix as compressed RDS. The matrices are static (published data),
so embedding is appropriate.

For the high-fidelity sets: hardcode from Potapov 2018 Table 1.

---

## 7. Config Changes

### 7.1 New config options

```yaml
# Overhang selection strategy
overhang_strategy: "auto"  # "auto", "prevalidated", "pairwise_matrix"
  # auto (default): try pre-validated sets first, fall back to pairwise matrix
  # prevalidated: only use pre-validated sets (fail if insufficient)
  # pairwise_matrix: always use full matrix (most thorough, slightly slower)

# Set-level fidelity threshold (replaces individual fidelity threshold)
overhang_set_fidelity_threshold: 0.95  # Minimum predicted set-level fidelity per reaction

# Minimum pairwise score (lowest acceptable pairwise compatibility)
overhang_min_pairwise: 0.90  # Warn if any overhang pair scores below this
```

### 7.2 Backward compatibility
The existing `overhang_fidelity_threshold: 0.95` remains supported for initial
candidate filtering (individual fidelity). The new `overhang_set_fidelity_threshold`
is the primary constraint.

---

## 8. Test Plan

### 8.1 Unit tests for new functions

**`test-overhang-selection.R`** (refactored):

1. `compute_set_fidelity()`:
   - Known 3-overhang set → verify against manually computed value
   - Set of 2 identical overhangs → fidelity = 0 (or error)
   - Pre-validated 10-member set → fidelity > 0.99

2. `optimize_split_points()`:
   - Short gene (no splits needed) → empty result
   - Long gene with known best split point → selects it
   - Multiple splits → all junction overhangs are orthogonal and gene-derived

3. `plan_assembly_overhangs()`:
   - Short gene (no superblocks): returns oh3, oh4, no splits, high fidelity
   - Long gene (with superblocks): returns oh3, oh4, split points, junction overhangs
   - Gene where oh1/oh2 happen to collide with pre-validated set → falls back gracefully
   - Manual oh3/oh4 override → validates and uses them

4. `validate_reaction_overhangs()`:
   - Known-good set → passes
   - Set with RC collision → fails
   - Set with high cross-reactivity → warns

5. `select_from_prevalidated_set()`:
   - Basic selection → picks highest-fidelity from set
   - Exclusion list removes candidates → still finds orthogonal overhangs
   - Too many exclusions → returns NULL (triggers fallback)

### 8.2 Integration test updates

Update `test-integration.R`:
- Short test gene: verify assembly plan has no superblocks, oh3/oh4 selected,
  per-reaction fidelity reported
- Add long test gene (>3600 nt): verify superblock splitting, junction overhangs
  are gene-derived, all reactions pass pairwise validation

### 8.3 Regression tests
- Verify that for the existing short test gene, the pipeline still produces valid
  output (oligos, gene blocks, barcodes)
- Verify QC still passes

---

## 9. Implementation Order

1. **Data preparation**: Generate/embed pairwise matrices and high-fidelity sets
   in `data/generate_data.R` and corresponding RDS files

2. **Core math**: Implement `compute_set_fidelity()` and `load_pairwise_matrix()`
   — these are pure functions with no dependencies on the rest of the refactor

3. **Split-point optimizer**: Implement `optimize_split_points()` — depends on
   pairwise matrix but not on the rest of the module

4. **Assembly planner**: Implement `plan_assembly_overhangs()` — the master
   function that ties everything together

5. **Refactor `09_wt_geneblock_design.R`**: Update to accept assembly_plan
   instead of doing independent superblock logic

6. **Refactor `05_tiling.R`**: Remove `compute_superblock_boundaries()`
   (moved to 06)

7. **Update `run_pipeline.R`**: Merge steps 7-9 into single assembly planning step

8. **Update tests**: Refactor existing tests, add new tests for pairwise validation

9. **Update QC (`10_qc_checks.R`)**: Add per-reaction fidelity reporting

---

## 10. Risk Assessment

### Low risk
- Adding pairwise matrix data: purely additive, no behavior change
- `compute_set_fidelity()`: new function, no side effects
- Pre-validated set selection: new selection path, existing path preserved as fallback

### Medium risk
- Moving superblock boundary computation from 05 to 06: changes module boundaries,
  must update all callers
- Changing `design_wt_geneblocks()` interface: requires coordinated updates to
  run_pipeline.R and tests
- Fixing the superblock junction overhang bug: changes assembly output for long genes
  (but current output is incorrect, so this is a bug fix)

### Mitigation
- Keep existing individual fidelity data and functions as internal helpers
  (backward compatibility)
- Run full integration test after each step
- The refactor is additive (new functions) before subtractive (removing old ones) —
  old and new can coexist during development
