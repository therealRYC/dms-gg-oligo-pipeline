# TASKS.md - DMS GG Oligo Pipeline Refactoring Tasks

> **Purpose**: Task list for Claude Code agents to implement. Each task is self-contained
> with context, acceptance criteria, and relevant files. Work on these in order unless
> otherwise noted; some tasks have dependencies.
>
> **Convention**: Tasks are numbered T1, T2, ... Subtasks are T1.1, T1.2, etc.
> Mark `[x]` when complete.

---

## T1: Modernize Codon Usage Data Source

**Status**: [ ] Not started
**Priority**: Medium
**Depends on**: None
**Files**: `R/03_codon_table.R`, `data/generate_data.R`, `R/constants.R`

### Context

The pipeline currently uses the **Kazusa codon usage database**, which was last updated in **2007** (GenBank release 160). While the top-ranked codon per amino acid is unlikely to change for humans, using an outdated source is not defensible in publications.

**Modern alternatives:**
- **CoCoPUTs / HIVE-CUTs** (FDA/GWU, 2019): Updated every 2 months from GenBank + RefSeq. Includes tissue-specific (TissueCoCoPUTs) and cancer-specific (CancerCoCoPUTs) tables. Available at https://dnahive.fda.gov/dna.cgi?cmd=cuts_main
- **CSDbase** (2022, Mol Biol Evol): RefSeq-based, 15k+ species, per-gene metrics.

**How other DMS tools handle this:**
- DIMPLE: Hardcoded codon dictionaries (likely Kazusa-derived), supports `-usage human` or `-usage ecoli`
- VaLiAnT: Ships with a `default_codon_table.csv`, allows user-supplied custom tables
- jbloomlab `gga_codon_muts_oligo_design`: Ships with `human_codon_freq.csv`, allows `--codon_freqs_csv`

**Practical impact**: For DMS libraries (where we only pick the single most-preferred codon per AA), the actual codon selections are identical between Kazusa and CoCoPUTs for humans. The value is scientific rigor, reproducibility, and future-proofing (e.g., tissue-specific optimization).

### Subtasks

- [ ] **T1.1**: Update `builtin_human_codon_usage()` in `03_codon_table.R` to use CoCoPUTs frequencies instead of Kazusa. Document the source (CoCoPUTs version/date, GenBank release) in a comment. Verify that the top-ranked codon per AA is identical (it should be).
- [ ] **T1.2**: Update `data/generate_data.R` to generate an RDS from CoCoPUTs data and add a comment noting the source.
- [ ] **T1.3**: Add a `codon_table_path` config option in `00_config.R` and `config_template.yaml` so users can provide a custom codon usage CSV (like VaLiAnT and jbloomlab do). Format: columns `codon`, `aa`, `frequency`. If not provided, use the built-in CoCoPUTs table.
- [ ] **T1.4**: Update tests in `test-codon-table.R` to verify the new data source loads correctly and that preferred codons match expected values.

### Acceptance Criteria
- Built-in table uses CoCoPUTs data with source documented
- Users can supply custom codon table via config
- All existing tests pass
- Top-ranked codon per AA is unchanged from current pipeline behavior for human

---

## T2: Add PCR Handle Support to Oligo Design

**Status**: [ ] Not started
**Priority**: High
**Depends on**: None (but T6 builds on this)
**Files**: `R/05_tiling.R`, `R/08_oligo_assembly.R`, `R/00_config.R`, `config_template.yaml`, `R/constants.R`

### Context

Users may need to add **PCR primer handles** to oligos to selectively amplify subsets of the pool ("fish out" specific tiles). This is cheaper than ordering multiple separate pools. Currently the oligo budget is hardcoded at 300 nt with a fixed overhead calculation. PCR handles reduce the available space for the mutable region, so tile sizes must shrink accordingly.

Since each tile undergoes a **different Golden Gate reaction** (different gene blocks), it makes sense to have tile-specific PCR handles so you can selectively amplify oligos for a given tile from the pooled order.

### Subtasks

- [ ] **T2.1**: Add config options for PCR handles:
  ```yaml
  # PCR handle options
  pcr_handles_enabled: false
  pcr_handle_5prime: ""        # 5' PCR handle sequence (same for all tiles if not tile-specific)
  pcr_handle_3prime: ""        # 3' PCR handle sequence
  ```
  Validate that handles are valid DNA, don't contain BsaI/BsmBI/PaqCI sites, and that the remaining oligo budget can still accommodate at least ~100 nt of mutable region.
- [ ] **T2.2**: Modify `compute_max_tile_size()` in `05_tiling.R` to subtract PCR handle lengths from the oligo budget before computing the mutable region size. The function signature should accept handle lengths as parameters.
- [ ] **T2.3**: Modify `build_oligo()` in `08_oligo_assembly.R` to prepend/append PCR handles to the assembled oligo sequence.
- [ ] **T2.4**: Update `run_pipeline.R` to pass PCR handle info through the pipeline.
- [ ] **T2.5**: Add tests for oligo assembly with and without PCR handles; verify total length is within budget.

### Acceptance Criteria
- PCR handles are configurable (on/off, sequences)
- Tile size automatically adjusts to account for handle lengths
- Oligos with handles still fit within `max_oligo_length`
- All existing tests still pass; new tests cover handle scenarios

### Notes for Future Work (T6)
Tile-specific PCR handles (different handles per tile) require more planning and are covered in T6.

---

## T3: Fix Overhang Selection to Use Pre-Validated High-Fidelity Sets

**Status**: [ ] Not started
**Priority**: High
**Depends on**: None
**Files**: `R/06_overhang_selection.R`, `data/generate_data.R`, `R/constants.R`

### Context

The current overhang selection has several issues to address:

**Clarification on oh3/oh4 being "the same for all tiles":**
oh3 and oh4 are **fixed synthetic overhangs** (not gene-derived). They work the same for all tiles because they sit at junctions that are **not** at gene boundaries:
- oh3 = BsmBI overhang at the PolIII-to-barcode junction (this junction is the same in every tile's BsmBI reaction)
- oh4 = BsaI overhang at the barcode-to-helper-plasmid junction (same in every tile's BsaI reaction)

The gene-derived overhangs (oh1, oh2) ARE different per tile — they're extracted from the WT gene at tile boundaries. oh3/oh4 just need to be orthogonal to all of those.

**The real issue**: The current approach selects overhangs based on **individual fidelity scores** (diagonal of the ligation matrix). The Potapov et al. 2018 paper (ACS Synthetic Biology, DOI: 10.1021/acssynbio.8b00333) provides something much better: **pre-validated overhang sets** where the entire set has been optimized for minimal cross-reactivity.

**Key data from the paper:**
- **Table 1**: Pre-validated high-fidelity sets for different assembly complexities (10, 20, 25, 30 fragments)
- **Set 2** (non-MoClo-constrained, 20 overhangs): ~98.1% predicted fidelity
- For <=10 fragments: subsets achieve >99% fidelity
- The Pryor et al. 2020 follow-up (PLOS ONE) has enzyme-specific data for BsaI and BsmBI
- **tatapov** Python package (Edinburgh Genome Foundry) provides the raw 256x256 ligation frequency matrices

**What should change:**
- Use the full 256x256 **pairwise ligation frequency matrix** (not just diagonal fidelity) for set-level orthogonality checking
- For the 3-4 overhangs in each tile reaction, validate that the set has high predicted fidelity (not just each individual overhang)
- For gene-derived overhangs (oh1, oh2), check their pairwise compatibility with oh3/oh4 using the matrix
- Consider bundling a small pre-validated overhang set from Table 1 as default oh3/oh4 candidates

### Subtasks

- [ ] **T3.1**: Research and document the exact data files needed. The 256x256 ligation frequency matrices are available from:
  - Supplementary data of Potapov 2018 (ACS Synth Bio)
  - `tatapov` Python package (repackaged matrices)
  - Pryor 2020 supplementary data (enzyme-specific: BsaI 1h, BsmBI 1h)
  Decide which condition(s) to bundle (recommendation: Potapov 37C/18h for general use, plus Pryor BsaI-specific and BsmBI-specific for enzyme-matched selection).
- [ ] **T3.2**: Update `data/generate_data.R` to bundle the full 256x256 pairwise matrix (not just the diagonal fidelity vector). Store as a named 256x256 numeric matrix in RDS format.
- [ ] **T3.3**: Add a `compute_set_fidelity(overhangs, pairwise_matrix)` function to `06_overhang_selection.R` that computes the predicted set-level fidelity for a group of overhangs in the same reaction, using the full pairwise matrix.
- [ ] **T3.4**: Update `select_fixed_overhangs()` to:
  - Use set-level fidelity (not just individual fidelity) when selecting oh3/oh4
  - Verify oh3/oh4 are compatible with all gene-derived tile boundary overhangs (oh1, oh2) that appear in the same reaction
  - Default threshold should be **>0.95 set-level fidelity** (the Potapov paper shows sets of up to 10 overhangs can achieve >99%)
- [ ] **T3.5**: Update `validate_reaction_overhangs()` to use pairwise cross-reactivity data instead of just checking for sequence identity/reverse-complement collisions.
- [ ] **T3.6**: For superblock splitting, update `select_superblock_overhangs()` to check that the junction overhang is compatible with all other overhangs in that reaction using pairwise data.
- [ ] **T3.7**: Update tests in `test-overhang-selection.R`.

### Acceptance Criteria
- Overhang selection uses pairwise ligation matrix (not just diagonal fidelity)
- Set-level fidelity is computed and reported for each tile's reaction
- oh3/oh4 validated for compatibility with gene-derived overhangs per-reaction
- Default fidelity threshold is 0.95 at the set level
- Superblock junction overhangs are validated against the pairwise matrix
- All tests pass

---

## T4: Scale Barcode Generation for High Coverage (10x Default)

**Status**: [ ] Not started
**Priority**: High
**Depends on**: None
**Files**: `R/07_barcode_design.R`, `R/00_config.R`, `config_template.yaml`, `R/constants.R`

### Context

The current `barcodes_per_variant` defaults to 1. In practice, DMS experiments need **multiple barcodes per variant** for statistical coverage. For a 1000-AA gene:
- 20 variants/position x 1000 positions = 20,000 variants
- At 10x coverage: 200,000 barcodes needed
- At 1x: 20,000 barcodes

The current barcode generator tops out around ~14,800 barcodes (prefix=8, suffix=4, Hamming>=3). To reach 200,000, the algorithm needs to scale.

### Subtasks

- [ ] **T4.1**: Change the default `barcodes_per_variant` to **10** in `constants.R` and `config_template.yaml`. Update the config template comments to explain the rationale (statistical power, fitness estimate confidence).
- [ ] **T4.2**: Analyze and document the theoretical capacity at different parameter settings:
  - barcode_length=12, prefix=8, suffix=4, d=3 → ~14,800 (current max)
  - barcode_length=15, prefix=10, suffix=5, d=3 → estimate capacity
  - barcode_length=18, prefix=12, suffix=6, d=3 → estimate capacity
  - barcode_length=20, prefix=14, suffix=6, d=3 → estimate capacity
  Determine the minimum `barcode_length` needed for 200k barcodes at d=3.
- [ ] **T4.3**: Update `check_barcode_capacity()` to use accurate capacity estimates and provide actionable error messages that suggest specific parameter changes (e.g., "increase barcode_length to 18 for 200k barcodes at d=3").
- [ ] **T4.4**: Optimize `generate_prefixes_greedy()` and `generate_filtered_barcodes()` for the larger scale. At 200k barcodes, the current vectorized approach may need further optimization (e.g., generating prefixes in batches, streaming suffix combination). Profile and optimize as needed. Target: generate 200k barcodes in <30 seconds.
- [ ] **T4.5**: Update `validate_barcode_distances()` to handle 200k barcodes efficiently. The current prefix-group validation should scale, but verify memory usage and runtime.
- [ ] **T4.6**: Add integration-level test that generates 200k barcodes (can be skip-gated behind `RUN_SLOW_TESTS=true`).
- [ ] **T4.7**: Update the pipeline entry point (`run_pipeline.R`) and config validation to handle the expanded barcode needs gracefully, including clear error messages if parameters are insufficient.

### Acceptance Criteria
- Default coverage is 10x (200k barcodes for a 1000-AA gene)
- Pipeline auto-suggests appropriate `barcode_length` if capacity is insufficient
- 200k barcodes generated in <30 seconds
- All barcode quality filters still enforced
- Hamming distance guarantee maintained at scale

---

## T5: Add PolIII-Aware Barcode Filters

**Status**: [ ] Not started
**Priority**: High
**Depends on**: T4 (barcode scaling should be done first since filters reduce yield)
**Files**: `R/07_barcode_design.R`, `R/00_config.R`, `config_template.yaml`, `R/constants.R`

### Context

Barcodes in this pipeline are **transcribed by a PolIII promoter** (U6). PolIII terminates when it encounters a run of thymidines on the non-template strand. This means certain barcode sequences will cause **premature transcription termination**, making the barcode unreadable in OPS and other RNA-based readouts.

**Key facts from the literature (Gao et al. 2018, Mol Ther Nucleic Acids):**
- **T4 (TTTT)**: Causes ~75% premature termination from U6 promoter
- **T5**: ~90-95% termination (near-complete)
- **T6+**: 100% termination
- Context matters: T4 flanked by G/C is a stronger terminator than T4 flanked by A
- The termination signal is on the **non-template strand** (= the sense strand = the barcode sequence as written)

**Additional PolIII-relevant filters to consider:**
- Poly-T runs (most critical — causes premature termination)
- Poly-A runs on sense strand (if barcode is read from reverse complement context)
- Self-complementary sequences (hairpins impair transcription and sequencing)
- Repetitive dinucleotide repeats (e.g., ATATAT — cause polymerase slippage)

**Current state**: The pipeline filters homopolymers of any base at length 4+ (`max_homopolymer: 4`). This already catches TTTT, but the filter is not PolIII-aware — it doesn't distinguish between poly-T (fatal for transcription) and poly-C (merely a sequencing concern).

### Subtasks

- [ ] **T5.1**: Add a dedicated **poly-T filter** to `filter_sequences_fast()` that is more stringent than the general homopolymer filter. Default: reject barcodes with **3 or more consecutive T's** (conservative — T4 already causes 75% termination, so excluding T3+ provides safety margin). Make this configurable:
  ```yaml
  barcode_max_polyT: 3    # Max consecutive T's in barcode (PolIII termination safety)
  ```
- [ ] **T5.2**: Add a **dinucleotide repeat filter**. Reject barcodes with dinucleotide repeats of length >= 4 (e.g., `ATATATAT`, `GCGCGCGC`). These cause polymerase slippage and are problematic for both sequencing and in-situ hybridization.
- [ ] **T5.3**: Update `check_barcode_capacity()` to account for the reduced yield from stricter filtering when estimating capacity.
- [ ] **T5.4**: Add a config flag to disable PolIII-specific filters for users who don't need RNA barcode transcription:
  ```yaml
  polIII_barcode_filters: true   # Enable PolIII-aware barcode filtering (default true)
  ```
- [ ] **T5.5**: Update tests. Add test cases that verify:
  - Barcodes containing `TTTT` are rejected when PolIII filters are on
  - Barcodes containing `TTT` are rejected at the stricter threshold
  - Dinucleotide repeats are rejected
  - Filters can be disabled via config

### Acceptance Criteria
- No barcode contains 3+ consecutive T's (when PolIII filters enabled)
- Dinucleotide repeats filtered
- Filter is configurable and can be disabled
- Capacity estimation accounts for stricter filters
- Tests cover all filter scenarios

### References
- Gao Z, Herrera-Carrillo E, Berkhout B (2018). Mol Ther Nucleic Acids 10:36-44. PMC5725217
- Arimbasseri AG, Maraia RJ (2015). Mol Cell 58(6):1124-1132. PMC3760304
- Li J et al. (2021). Nat Commun 12:6135 (structural basis of PolIII termination)

---

## T6: Tile-Specific PCR Handles (Requires Careful Planning)

**Status**: [ ] Not started — needs design discussion
**Priority**: Medium
**Depends on**: T2 (basic PCR handle support)
**Files**: `R/05_tiling.R`, `R/08_oligo_assembly.R`, `R/00_config.R`, `config_template.yaml`

### Context

Since each tile undergoes a **separate GGA reaction** (with different gene blocks), it may be useful to have **tile-specific PCR handles** so users can selectively amplify oligos for a given tile from a single pooled order.

This is more complex than T2 (uniform handles) because:
- Each tile needs a unique pair of PCR handles
- The handles must not cross-amplify other tiles (sufficient sequence divergence)
- Handle assignment needs to be deterministic and reproducible
- The number of unique handle pairs scales with the number of tiles (~13 for a 1000-AA gene)

### Design Questions (to resolve before implementation)

1. **User-specified vs auto-generated handles?** If user-specified, the config needs a list of handle pairs mapped to tile IDs. If auto-generated, the pipeline needs a primer design step.
2. **Handle length constraints?** Typical PCR primers are 18-25 nt. Each pair (5' + 3') eats 36-50 nt of oligo budget, significantly reducing tile size.
3. **Tm matching?** Handles should have similar melting temperatures for multiplexed PCR.
4. **Cross-reactivity checking?** Handles must not prime off each other or off gene sequence.

### Subtasks

- [ ] **T6.1**: Design the config schema for tile-specific handles. Proposed:
  ```yaml
  pcr_handles_per_tile:
    - tile_id: 1
      handle_5prime: "ACGTACGTACGTACGTAC"
      handle_3prime: "TGCATGCATGCATGCATG"
    - tile_id: 2
      handle_5prime: "..."
      handle_3prime: "..."
  ```
  Alternatively, allow a CSV file path pointing to a handle table.
- [ ] **T6.2**: Modify `build_oligo()` to accept tile-specific handles instead of global handles.
- [ ] **T6.3**: Modify `compute_max_tile_size()` to use the **longest** handle pair when computing the mutable region budget (conservative) or compute per-tile budgets.
- [ ] **T6.4**: Add validation: handles don't contain enzyme sites, handles for different tiles have sufficient sequence divergence, total oligo length within budget.
- [ ] **T6.5**: Add tests.

### Acceptance Criteria
- Tile-specific handles can be specified via config
- Oligo budget adjusts per tile
- Cross-reactivity validation between handles
- All tests pass

---

## T7: Improve WT Gene Block Design for Superblock Reuse

**Status**: [ ] Not started
**Priority**: Medium
**Depends on**: T3 (overhang selection improvements)
**Files**: `R/09_wt_geneblock_design.R`

### Context

The question: **Does the WT gene block design handle the fact that superblocks may be reused across tiles, but within a superblock, each tile needs different upstream/downstream sub-blocks that flank the tile?**

Current behavior: For each tile, the pipeline generates:
- A **5'WT BsaI block** (gene start to tile boundary)
- A **3'WT+PolIII BsmBI block** (tile boundary to gene end + PolIII)

For a long gene with superblock splitting, the 5'WT region may be split into multiple sub-blocks at superblock boundaries. The `deduplicate_blocks()` function merges blocks with identical sequences.

**Potential issue**: Two tiles that are adjacent but in different superblocks might share some sub-blocks. The current approach generates the full upstream/downstream blocks per tile and then deduplicates by sequence identity. This should work correctly but may not be optimal — it might generate more unique blocks than necessary.

### Subtasks

- [ ] **T7.1**: Add a detailed integration test with a long gene (>3600 nt, forcing superblock splitting) that verifies:
  - Sub-blocks within a superblock are correctly sized
  - Sub-blocks flanking a tile within a superblock have the correct overhang junctions
  - Shared sub-blocks between tiles are correctly deduplicated
  - The total number of unique blocks is minimal
- [ ] **T7.2**: Trace through the gene block design logic for a 3-tile gene with 1 superblock boundary and document the expected blocks in a comment or test fixture.
- [ ] **T7.3**: If issues are found, refactor the block generation to be superblock-aware (generate blocks per superblock region, then assign to tiles, rather than per-tile generation + dedup).

### Acceptance Criteria
- Long-gene integration test passes
- Superblock sub-blocks are correctly assigned to tiles
- No redundant block synthesis (deduplication is correct)
- Block sequences are verified against expected assembly products

---

## T8: Enhance Barcode QC Reporting

**Status**: [ ] Not started
**Priority**: Medium
**Depends on**: T4 (barcode scaling)
**Files**: `R/10_qc_checks.R`, `R/07_barcode_design.R`

### Context

The current barcode uniqueness QC check (#4) only verifies that all barcodes are unique. It does **not** report:
- Whether all barcode pairs meet the minimum Hamming distance
- Which specific pairs violate the threshold (if any)
- The distribution of pairwise Hamming distances
- Summary statistics (min, median, mean pairwise distance)

The `validate_barcode_distances()` function in `07_barcode_design.R` does check Hamming distances during generation and errors on violations, but this information is not surfaced in the QC report.

### Subtasks

- [ ] **T8.1**: Update the barcode uniqueness QC check in `10_qc_checks.R` to also report:
  - Minimum pairwise Hamming distance across all barcodes
  - Whether the minimum meets the configured threshold
  - Number of pairs below threshold (if any), with examples
- [ ] **T8.2**: Add a new QC check: **barcode Hamming distance distribution**. Report min, 5th percentile, median, mean. For large barcode sets (>10k), use sampling (e.g., 100k random pairs) rather than exhaustive pairwise comparison.
- [ ] **T8.3**: If violations are found, report the specific violating pairs (up to 10) with their sequences and distances in the QC detail field.
- [ ] **T8.4**: Update tests to verify the new QC check reports correct Hamming distance statistics.

### Acceptance Criteria
- QC report includes Hamming distance statistics
- Violations (if any) are specifically identified with sequences and distances
- Scales to 200k barcodes without excessive runtime (sampling for large sets)
- Tests verify correct reporting

---

## T9: Review and Tighten Default Overhang Fidelity Threshold

**Status**: [ ] Not started
**Priority**: Low (can be addressed as part of T3)
**Depends on**: T3 (overhang selection using pairwise data)
**Files**: `R/06_overhang_selection.R`, `R/constants.R`, `config_template.yaml`

### Context

The current default fidelity threshold is 0.95 for individual overhang fidelity. However, the Potapov paper demonstrates that pre-validated sets can achieve **>99% fidelity for 10-piece assemblies**. Since each tile's reaction only uses ~3-4 overhangs (oh1, oh2, oh3 in BsmBI reaction; oh_L, oh1, oh4 in BsaI reaction), we are well within the range where >99% set-level fidelity is achievable.

Once T3 (pairwise matrix-based selection) is implemented, the threshold should be evaluated at the **set level** rather than the individual level. A set-level threshold of >0.95 is conservative and appropriate; >0.99 may be achievable for these small sets.

### Subtasks

- [ ] **T9.1**: After T3 is complete, evaluate what set-level fidelity is achievable for the typical 3-4 overhang reactions in this pipeline.
- [ ] **T9.2**: Update the default threshold and config comments to reflect set-level (not individual) fidelity.
- [ ] **T9.3**: Add a QC check that reports the predicted set-level fidelity for each tile's BsaI and BsmBI reactions.

### Acceptance Criteria
- Default threshold is set-level (not individual)
- QC report shows per-tile-reaction predicted fidelity
- All reported fidelities are >0.95

---

## Task Dependency Graph

```
T1 (Codon DB)          ─── independent
T2 (PCR Handles)       ─── independent
T3 (Overhang Sets)     ─── independent
T4 (Barcode Scale)     ─── independent
T5 (PolIII Filters)    ─── depends on T4
T6 (Tile PCR Handles)  ─── depends on T2
T7 (Superblock Reuse)  ─── depends on T3
T8 (Barcode QC)        ─── depends on T4
T9 (Fidelity Threshold)─── depends on T3
```

**Recommended execution order:**
1. T1, T2, T3, T4 (all independent — can be parallelized)
2. T5, T6, T7, T8 (depend on wave 1)
3. T9 (depends on T3)
