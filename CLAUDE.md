# CLAUDE.md — DMS GG Oligo Pipeline Project Context

## Project Summary

This project is a mature R pipeline (`dms-gg-oligo-pipeline`) for designing oligonucleotide pools for Deep Mutational Scanning (DMS). The pipeline takes a gene of interest and outputs oligo pool sequences for ordering from Twist Bioscience, WT gene block sequences, a variant-barcode mapping file, tile manifests, a helper plasmid specification, and a bench-ready assembly report.

**GitHub repo**: `therealRYC/dms-gg-oligo-pipeline` (https://github.com/therealRYC/dms-gg-oligo-pipeline)
**Language**: R (Bioconductor + CRAN packages)
**PI / Lab**: Fowler Lab, UW
**Author**: Robert Chen (robchen@uw.edu, GitHub: therealRYC)

---

## Key Design Decisions

### Mutation Strategy
- **Fully specified codons** — each oligo in the pool encodes exactly one specific mutation. No degenerate/random codons (NNK, NNS, etc.).
- All 19 amino acid substitutions + 1 stop codon + 1 WT control at every mutable position.
- Optionally, 1 synonymous control per position (configurable via `include_synonymous`).
- Positions 1 (start Met) and n_codons (stop) are excluded — Met always falls in tile 1's oh1 overhang; stop read-through is not of experimental interest.
- Use **human codon usage table** (most-preferred codon per amino acid, from CoCoPUTs).

### Three-Enzyme Golden Gate Assembly
- **BsaI (Level 1, 37C)**: Inserts the oligo + 5'WT gene block(s) into the helper plasmid, reconstructing the upstream portion of the gene with the mutant tile.
- **BsmBI (Level 1b, 42C)**: Inserts 3'WT+downstream cassette gene block(s) between the tile and barcode, completing the gene and adding the PolIII promoter.
- **PaqCI (Level 2, 37C)**: Moves the complete assembled insert (full gene + PolIII + barcode) from the helper plasmid into the destination backbone.
- All three enzymes are orthogonal (do not interfere with each other).

### Final Construct in Plasmid
```
[Backbone]—PaqCI**—[Full gene with one mutation]—[intergene elements (optional)]—[PolIII promoter]—[Barcode]—PaqCI*—[Backbone]
```
- The PolIII promoter (U6 with internal T7) sits between the gene and barcode.
- This enables flexibility for LABEL-Seq, VIS-Seq, and PerturbView readouts.
- The PolIII promoter transcribes the barcode.
- **Intergene elements** (optional): Additional sequence elements (reporters, selection cassettes, IRES, etc.) can be placed between the gene 3' end and the PolIII promoter via the `intergene_elements` config. These are included in the BsmBI gene blocks and automatically handled by cassette splitting.

### Universal Oligo Structure (ALL tile types)

Every tile uses the same oligo layout — no tile-type-specific branching:

```
5'—[fwd_handle]—BsaI_fwd(7)—oh1(4)—[mutable region]—BsmBI_rev_oh2(11)—BsmBI_fwd_oh3(11)—barcode—BsaI_rev_oh4(11)—[rev_handle]—3'
```

Where:
- `fwd_handle` / `rev_handle` = optional PCR handles for tile-specific amplification (0 nt if unused)
- `BsaI_fwd` = GGTCTC + A (recognition + 1nt spacer) = 7 nt
- `oh1` = 4 nt BsaI overhang: `oh_L` (external, upstream of ATG) for tile 1, gene-derived for other tiles
- `mutable region` = tile interior where the mutation occurs
- `BsmBI_rev_oh2` = RC(CGTCTC + A + oh2) = 11 nt
- `BsmBI_fwd_oh3` = CGTCTC + A + oh3 = 11 nt (same for all tiles)
- `barcode` = programmed barcode (default 20 nt)
- `BsaI_rev_oh4` = RC(GGTCTC + A + oh4) = 11 nt (same for all tiles)

The only tile-specific behavior: tile 1 uses oh_L (external, auto-selected or user-specified) as oh1 instead of a gene-derived boundary overhang. Tile 1 also includes the optional `upstream_cassette` between oh_L and ATG.

### Superblocks
For long genes, WT gene blocks may exceed the ~1800 bp synthesis limit for gene fragments. In that case, blocks are split into "superblocks" — sub-blocks connected by additional unique enzyme overhangs within the same one-pot reaction. Superblock junction positions are chosen via OOGGA collision-aware DP to maximize overhang fidelity.

### Cassette Splitting
For very long downstream cassettes (>~1700 nt total, i.e., intergene elements + PolIII exceed the synthesis limit), the cassette itself is split across multiple BsmBI-connected sub-blocks in the same Level 1b reaction. Split points within the cassette are chosen at positions with high-fidelity BsmBI overhangs, using the same OOGGA scoring as gene superblock junctions. After ligation, the cassette is reconstructed seamlessly. This is handled automatically: users add elements to `intergene_elements` and the pipeline adapts.

### Oligo Length Budget (Twist max = 300 nt)
The tile size is determined by subtracting fixed overhead (enzyme sites, barcode, PCR handles, upstream cassette) from 300 nt. Total fixed overhead = 44 + upstream_cassette + barcode + handles. Approximate mutable region: ~200-230 nt (~67-77 codons).

### Barcode Design
- **Programmed barcodes** — each variant gets unique, pre-assigned barcodes (no randomers).
- Default: **20 nt** barcodes, minimum Hamming distance >= 3, **prefix length 12**, **10 barcodes per variant**.
- **Unified hierarchical architecture**: barcode = prefix(p nt) + suffix(L-p nt). One unique prefix per variant; each variant's N barcodes share the same prefix with different random suffixes. Cross-variant Hamming distance is guaranteed by the prefix.
- **Prefix generation** (ordered by priority):
  1. GF(4) shortened Hamming code (d <= 3): deterministic, maximum capacity, O(n) per codeword (07b_linear_codes.R)
  2. DNABarcodes lexicode (any d): Conway heuristic first, Ashlock fallback for larger sets
- **Enhanced filters**: GC content (0.35-0.65), homopolymer runs (max 4), PolIII terminator (TTTT), self-complementarity/hairpins, dinucleotide repeats, optional GGC motif filter, optional poly-G filter, optional Tm uniformity filter.
- Filter out sequences containing BsaI/BsmBI/PaqCI recognition sites.
- Barcode length supports `"auto"` mode for automatic sizing based on capacity needs.

### Overhang Selection
- Auto-selected from NEB/Pryor 2020 enzyme-specific cycling pairwise fidelity matrices (256x256) for both BsaI and BsmBI.
- Scoring formula: `Score = P_fid(oh) * P_eff(oh)` — individual fidelity times relative ligation efficiency.
- oh1 (BsaI) and oh2 (BsmBI) are gene-derived at tile boundaries — optimized by dynamic boundary search.
- oh3 is a fixed BsmBI overhang (same for all tiles) — derived from promoter sequence or score-selected.
- oh4 is a fixed BsaI overhang (same for all tiles) — auto-selected from high-fidelity set.
- oh_L is a fixed BsaI overhang for tile 1 — auto-selected or user-specified.
- PaqCI overhangs (paqci_star1, paqci_star2) — auto-selected or user-specified.
- Palindromic overhangs are hard-blacklisted for freely-chosen overhangs; heavy penalty for gene-derived boundary overhangs.
- Homopolymer 4-nt overhangs (AAAA, CCCC, GGGG, TTTT) are excluded from oh3/oh4 selection.
- User can override any overhang with manual specification in the config.
- Superblock split points use OOGGA collision-aware selection (06b_oogga_dp.R).

### WT Gene Blocks
- Ordered as synthesized gene fragments (e.g., Twist gene fragments, IDT gBlocks).
- Synthesized once per gene, reused across experiments.
- Two categories: BsaI blocks (5'WT segments) and BsmBI blocks (3'WT + downstream cassette segments).
- Flanked by configurable padding sequence (default `TGCATG`, 6 bp per NEB recommendation).
- Min gene block length: 300 bp (Twist minimum). Max: 1800 bp.

---

## Repository Structure

```
dms-gg-oligo-pipeline/
├── run_pipeline.R              # Master entry point (Rscript run_pipeline.R config.yaml)
├── config_template.yaml        # Annotated config template with all parameters
├── R/
│   ├── 00_config.R             # YAML parsing, validation, defaults
│   ├── 01_gene_input.R         # Read FASTA or CDS string, validate CDS
│   ├── 02_enzyme_site_scan.R   # Find endogenous BsaI/BsmBI/PaqCI sites, suggest silent mutations
│   ├── 03_codon_table.R        # Human codon usage table, preferred codon lookup
│   ├── 04_mutation_design.R    # Generate all single-AA substitutions + stops + controls
│   ├── 05_tiling.R             # Partition gene into tiles, compute mutable region budgets
│   ├── 06_overhang_selection.R # Integrated assembly planning: dynamic boundary search + overhang selection
│   ├── 06b_oogga_dp.R          # OOGGA collision-aware boundary selection (DP + greedy + single-pass)
│   ├── 07_barcode_design.R     # Programmed barcodes with unified hierarchical prefix-suffix design
│   ├── 07b_linear_codes.R      # GF(4) linear code construction for barcode prefixes
│   ├── 08_oligo_assembly.R     # Assemble universal oligo sequences (3-enzyme architecture)
│   ├── 09_wt_geneblock_design.R # Design WT gene blocks (BsaI + BsmBI) + superblock splitting
│   ├── 10_qc_checks.R          # Comprehensive QC validation (3-enzyme architecture)
│   ├── 11_output.R             # Write CSV/FASTA outputs (11 output files)
│   ├── 12_report.R             # Wetlab-compatible Markdown assembly report
│   ├── 13_gg_simulator.R       # In-silico Golden Gate assembly verification
│   ├── utils.R                 # Shared helpers (RC, GC, site matching, enzyme site orientation)
│   └── constants.R             # Enzyme defs, synthesis limits, AA alphabet, barcode defaults
├── configs/                    # Gene-specific config files
│   ├── akap11.yaml
│   ├── grin2a.yaml
│   ├── grin2a_long_cassette.yaml
│   └── trio.yaml
├── data/
│   ├── neb_overhang_fidelity/  # BsaI + BsmBI pairwise matrices and 1D fidelity (RDS)
│   ├── pryor2020_overhang_fidelity/ # Source data: Pryor et al. 2020 supplemental files
│   ├── cassette_elements/      # Reusable cassette element sequences
│   ├── human_codon_usage.rds   # CoCoPUTs human codon usage table (Alexaki et al. 2019)
│   └── *.fasta                 # Gene FASTA files (AKAP11, GRIN2A, SLC6A1, TRIO)
├── data-raw/
│   └── generate_data.R         # Script to regenerate bundled data from source files
├── Example Genes/              # Validated pipeline outputs for 4 example genes
│   ├── AKAP11/
│   ├── GRIN2A/
│   ├── GRIN2A_long_cassette/
│   └── TRIO/
├── tests/
│   ├── testthat.R
│   └── testthat/               # 346 test blocks across 21 test files
│       ├── fixtures/           # Test fixture data
│       └── test-*.R            # Unit + integration + edge case tests
├── scripts/                    # Utility scripts (benchmarks, reference implementations)
├── Plans/                      # Feature planning documents
├── Brainstorm/                 # Research session notes
├── archive/                    # Historical benchmarks, notes, validation snapshots
├── .qa/                        # QA baseline and report files
├── DESCRIPTION                 # R package metadata (dmsggoligo v0.1.0)
├── NOTEBOOK.md                 # Lab notebook
├── BUGS.md                     # Bug tracker
├── README.md                   # Project documentation
├── dmsggoligo.Rproj            # RStudio project file
└── .gitignore
```

## R Package Dependencies

**CRAN:** `yaml`, `readr`, `data.table`, `cli`
**Bioconductor:** `Biostrings`, `DNABarcodes`
**Suggests:** `testthat` (>= 3.0.0), `rmarkdown`

---

## Module Details

### 1. Config (`00_config.R`)
- Parse YAML config with `yaml::read_yaml()`
- Apply defaults, validate types and ranges
- Key params: gene FASTA path (or inline CDS string), PolIII promoter sequence, max oligo length (300), barcode length (20 or "auto"), min Hamming distance (3), barcode prefix length (12), barcodes per variant (10), overhang fidelity threshold, boundary search method, OOGGA parameters
- Overhangs `oh_L`, `oh4`, `paqci_star1`, `paqci_star2` default to `"auto"` (auto-selected by the pipeline)
- **Intergene elements**: optional `intergene_elements` list in config. `build_downstream_cassette()` concatenates them + PolIII into `downstream_cassette`. Default: empty.
- **PCR handles**: optional per-tile PCR handle configuration for tile-specific amplification from pooled oligos.
- **Upstream cassette**: optional sequence between oh_L and ATG on tile 1 oligos.
- **Boundary method**: `boundary_method` controls tile boundary optimization algorithm — `"oogga_two_pass"` (default), `"oogga_greedy"`, or `"oogga_single"`.
- **Enhanced barcode filters**: toggle GGC motif, hairpin, dinucleotide repeat, poly-G, and Tm uniformity filters.

### 2. Gene Input (`01_gene_input.R`)
- Read FASTA via `Biostrings::readDNAStringSet()` or accept inline CDS string
- Validate: divisible by 3, starts ATG, no internal stops
- Output: `DNAString` CDS + `AAString` protein + gene name + codon count

### 3. Enzyme Site Scan (`02_enzyme_site_scan.R`)
- Search gene + PolIII promoter + intergene elements for **BsaI** (`GGTCTC`), **BsmBI** (`CGTCTC`), and **PaqCI** (`CACCTGC`) on both strands
- BsaI and BsmBI differ by only 1 nt — iterative domestication handles cases where fixing one creates the other
- For gene sites: suggest silent codon changes ranked by human codon frequency
- For PolIII/intergene sites: warn user (can't silently mutate regulatory sequences)
- Optionally auto-apply domestication (`auto_domesticate` config flag)

### 4. Codon Table (`03_codon_table.R`)
- Load bundled human codon usage (CoCoPUTs, default) or custom table
- `get_preferred_codon(aa)` returns highest-frequency human codon per AA
- Used by mutation design and enzyme site domestication

### 5. Mutation Design (`04_mutation_design.R`)
- For each mutable AA position: generate 19 missense + 1 nonsense + 1 WT control using preferred human codons
- Optionally: 1 synonymous control per position (different codon, same AA)
- Output table: `variant_id, position, wt_aa, wt_codon, mut_aa, mut_codon, variant_type`
- Variant types: `"missense"`, `"nonsense"`, `"wt_control"`, `"synonymous"`
- Post-check: scan each mutant codon in tile context for inadvertent enzyme site creation; swap to next-best codon if found

### 6. Tiling (`05_tiling.R`)
- Compute max mutable region size from oligo length budget (accounting for BsaI/BsmBI sites, barcode, PCR handles, upstream cassette)
- Universal budget formula: `max_oligo - 44 - upstream_cassette - barcode - handles`, rounded down to codon boundary
- Partition gene into tiles on codon boundaries with configurable overlap (default 6 codons)
- Tiles include oh1_seq and oh2_seq (gene-derived 4-nt overhangs at boundaries)

### 7. Overhang Selection (`06_overhang_selection.R`)
- Load enzyme-specific pairwise fidelity matrices (BsaI 256x256 and BsmBI 256x256) from Pryor et al. 2020
- Integrated assembly planning: dynamically searches candidate tile boundary positions where gene-derived overhangs (oh1/oh2) score highest under enzyme-specific cycling conditions
- Auto-select BsaI pair: oh_L (tile 1 upstream) + oh4 (barcode-helper junction) from high-fidelity set
- Auto-select PaqCI pair: paqci_star1 + paqci_star2 for Level 2 cloning
- oh_R cassette search: find overhangs at the cassette boundary for the last tile
- Compute per-reaction set fidelity and overall pipeline fidelity
- For superblocks: select additional junction overhangs, checking OOGGA compatibility
- User can override any overhang with manual specification

### 7b. OOGGA Collision-Aware Boundary Selection (`06b_oogga_dp.R`)
- Implements collision-aware boundary optimization inspired by OOGGA (Mukundan & Madhusudhan 2025)
- Three methods:
  - `oogga_two_pass`: Superblock-first OOGGA DP, then per-superblock tile OOGGA DP (default)
  - `oogga_greedy`: Superblock-first OOGGA DP, then greedy sequential tile selection
  - `oogga_single`: Single-pass OOGGA DP on entire gene+cassette
- Pre-computes 256x256 overhang compatibility matrix for O(1) per-pair collision checks
- DP transition checks each candidate overhang against ALL prior overhangs on the path, rejecting candidates with >max_identity/4 positional matches (including RC checks)
- Eliminates iterative blacklisting — collision avoidance is built into the DP

### 8. Barcode Design (`07_barcode_design.R`)
- **Unified hierarchical prefix-suffix architecture:**
  - barcode = prefix(p nt) + suffix(L-p nt)
  - One unique prefix per variant; barcodes_per_variant barcodes share the same prefix
  - All prefix pairs have d >= min_hamming (hard guarantee)
  - Suffixes are random, filtered only for enzyme sites, homopolymers, GC
- **Prefix generation** (ordered by priority):
  1. GF(4) shortened Hamming code (d <= 3): deterministic, maximum capacity (07b_linear_codes.R)
  2. DNABarcodes lexicode (any d): Conway heuristic first, Ashlock fallback
- **Enhanced filters**: GGC motif (Illumina error hotspot), self-complementarity/hairpins, dinucleotide repeats, poly-G, Tm uniformity (post-hoc)
- Configurable: barcode length (default 20), min Hamming distance (3), prefix length (12), GC range (0.35-0.65), max homopolymer (4), barcodes per variant (10)

### 8b. GF(4) Linear Codes (`07b_linear_codes.R`)
- Implements shortened quaternary Hamming codes over GF(4) = GF(2^2)
- Produces prefix sets with algebraically guaranteed minimum Hamming distance d >= 3
- Eliminates pairwise distance checking — guaranteed by linearity
- Capacity for [n, n-3, 3]_4 shortened Hamming code: 4^(n-3)
- DNA mapping: 0 -> A, 1 -> C, alpha -> G, alpha^2 -> T

### 9. Oligo Assembly (`08_oligo_assembly.R`)
- Core molecular biology logic: universal 3-enzyme oligo structure for ALL tile types
- No tile-type-specific branching — every oligo has the same layout
- Tile 1 uses oh_L as oh1 (external) and prepends optional upstream_cassette before ATG
- Other tiles use gene-derived oh1 at tile boundary
- Performance: vectorized by tile — pre-extracts WT tile regions, pre-computes enzyme site strings, uses vectorized paste0() per tile
- Helper: `orient_enzyme_site(enzyme, overhang, orientation)` builds the recognition + spacer + overhang string
- Supports optional PCR handles (prepended/appended outside BsaI sites)
- Validates all oligos are within length limit

### 10. WT Gene Block Design (`09_wt_geneblock_design.R`)
- For each tile, generates the required WT blocks:
  - **BsaI blocks** (5'WT segments): flanked by BsaI sites for Level 1 insertion into helper plasmid
  - **BsmBI blocks** (3'WT + downstream cassette): flanked by BsmBI sites for Level 1b insertion
- Interior superblocks at tile boundaries need both BsaI and BsmBI versions
- Cassette splitting: when downstream cassette exceeds synthesis limit, split across multiple BsmBI-connected sub-blocks
- `flag_borderline_overhangs()`: detects near-miss overhangs at gene block boundaries
- `recompute_reaction_fidelity()`: recalculates per-reaction fidelity after superblock decisions
- Gene blocks flanked by configurable padding (default `TGCATG`)
- Generates tile manifests (per-tile BsaI and BsmBI reaction contents) and helper plasmid specification

### 11. QC (`10_qc_checks.R`)
- Oligo lengths within limit (min and max)
- No unintended BsaI/BsmBI/PaqCI sites in oligos or PCR handles
- All barcodes unique with correct Hamming distances
- Tiles cover entire gene without gaps
- Gene blocks within synthesis limits (min 300 bp, max 1800 bp)
- GC content and homopolymer warnings
- Each variant differs by exactly one codon from WT
- Per-reaction overhang fidelity checks (when assembly_plan provided)
- Enhanced barcode filter validation (GGC, hairpin, dinuc, polyG, Tm stats)
- PCR handle enzyme site QC

### 12. Output (`11_output.R`)
Writes up to 11 output files, all prefixed with `{gene_name}_`:

| File | Description | Key Columns |
|------|-------------|-------------|
| `{gene}_oligo_pool.csv` | Complete oligo pool for ordering | oligo_name, sequence, length, variant_id, tile_id |
| `{gene}_geneblock_order.csv` | Deduplicated gene blocks for synthesis ordering | block_name, sequence, length |
| `{gene}_variant_barcode_map.csv` | Variant-barcode associations | variant_id, position, wt_aa, mut_aa, wt_codon, mut_codon, variant_type, barcode, min_hamming_dist, barcode_idx, tile_id |
| `{gene}_tile_manifests.csv` | Per-tile BsaI and BsmBI reaction contents | tile_id, reaction components |
| `{gene}_helper_plasmid.csv` | Helper plasmid specification | plasmid components |
| `{gene}_qc_report.csv` | QC check results | check name, status, details |
| `{gene}_oligo_pool.fasta` | Oligo sequences in FASTA format | |
| `{gene}_geneblock_order.fasta` | Gene block sequences in FASTA format | |
| `{gene}_sequences.fasta` | Original CDS, domesticated CDS, protein | |
| `{gene}_skipped_variants.csv` | Variants skipped due to gene-edge overlap | variant_id, position, skip_reason |
| `{gene}_pcr_primer_table.csv` | PCR primer pairs per tile (when handles used) | tile_id, fwd_handle, rev_handle, rev_primer_to_order |

### 13. Assembly Report (`12_report.R`)
- Generates a bench-ready Markdown assembly report after each pipeline run
- Structured for wetlab use: per-tile component tables, overhang maps, fidelity scores, gene block order sheet
- Includes borderline overhang pair reporting
- Output: `{gene}_assembly_report.md`

### 14. GG Simulator (`13_gg_simulator.R`)
- In-silico Golden Gate assembly verification
- Simulates Type IIS restriction enzyme digestion and ligation
- Key functions:
  - `digest_linear()` — Cut a linear DNA with a Type IIS enzyme
  - `ligate_fragments()` — Assemble fragments by matching overhangs
  - `simulate_tile_assembly()` — Full BsaI + BsmBI simulation for one tile
  - `select_junctional_variants()` — Pick boundary-vulnerable variants per tile for targeted testing
  - `build_expected_product()` — Construct expected product from first principles
  - `verify_assembly_product_strict()` — Exhaustive nucleotide-level product verification
- `simulate_pipeline_assembly()` — Orchestrate verification over all tiles with configurable sampling

---

## Enzyme Constants

- **BsaI**: Recognition = `GGTCTC`, cuts 1/5 downstream, 4-nt overhang, 1-nt spacer, optimal temp 37C
- **BsmBI**: Recognition = `CGTCTC`, cuts 1/5 downstream, 4-nt overhang, 1-nt spacer, optimal temp 42C
- **PaqCI**: Recognition = `CACCTGC`, cuts 4/8 downstream, 4-nt overhang, 4-nt spacer, optimal temp 37C
- Gene sequences must be **domesticated** (endogenous BsaI/BsmBI/PaqCI sites removed via silent mutations) before use.
- BsaI and BsmBI recognition sequences differ by only 1 nucleotide — domestication handles cascading fixes.

---

## Key Reference Tools & Literature

- **DIMPLE** (github.com/coywil26/DIMPLE): DMS library design using OLS + Golden Gate
- **gga_codon_muts_oligo_design** (jbloomlab): Golden Gate codon mutagenesis oligo design
- **GGAssembler** (Fleishman Lab): Graph-theoretical Golden Gate fragment design
- **OOGGA** (Mukundan & Madhusudhan 2025): Collision-aware overhang optimization — inspiration for 06b_oogga_dp.R
- **VaLiAnT**: Oligo library design for SGE/DMS
- **dms_variants** (jbloomlab): Barcode variant analysis package
- **DNABarcodes** (Bioconductor): Barcode set generation with error-correction properties
- **CoCoPUTs** (Alexaki et al. 2019, J Mol Biol): Updated codon usage tables from FDA/GWU (replaces Kazusa)
- **Potapov et al. 2018, ACS Synth Bio**: 256x256 ligation fidelity matrices for Golden Gate
- **Pryor et al. 2020, PLOS ONE**: Enzyme-specific (BsaI, BsmBI) cycling pairwise fidelity matrices
- **Enrich2** (FowlerLab): Statistical framework for DMS data analysis

---

## Verification

1. **Unit + integration tests**: `devtools::test()` — 346 test blocks across 21 test files covering all modules, edge cases (tile-1 mutable start, upstream cassette, oh_L validation, PCR handles, cassette splitting, OOGGA DP), and integration
2. **Example genes**: 4 validated example genes (AKAP11, GRIN2A, GRIN2A_long_cassette, TRIO) with full pipeline output in `Example Genes/`
3. **In-silico assembly**: `13_gg_simulator.R` simulates BsaI + BsmBI digestion and ligation per tile, with exhaustive nucleotide-level product verification against expected sequences
4. **QA process**: Tracked in `.qa/` with baseline scoring and reports

---

## Status

**Current state**: Mature codebase. All 18 R modules implemented and tested. 4 validated example genes. Active GitHub repo with 48+ merged PRs. 3-enzyme architecture (BsaI + BsmBI + PaqCI) fully operational.
**Pipeline usage**: `Rscript run_pipeline.R <config.yaml>` — runs all 12 pipeline steps end-to-end.
