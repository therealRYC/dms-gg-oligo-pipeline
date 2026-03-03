# DMS Golden Gate Oligo Pipeline

R pipeline for designing oligonucleotide pools for Deep Mutational Scanning (DMS) via three-enzyme Golden Gate Assembly. Takes a gene of interest and outputs oligo pool sequences (for Twist Bioscience ordering), WT gene block sequences, and a variant-barcode mapping file.

**Author**: Robert Chen (robchen@uw.edu)
**Lab**: Fowler Lab, University of Washington

## Overview

The pipeline generates all 19 amino acid substitutions + 1 stop codon at every position in a gene, each encoded as a single fully-specified oligo with a programmed barcode. Assembly uses a three-enzyme architecture:

- **BsaI** (Level 1): Inserts the oligo (mutant tile + barcode) and 5' WT gene block(s) into the helper plasmid
- **BsmBI** (Level 1b): Inserts the 3' WT gene block(s) and PolIII promoter between the tile and barcode
- **PaqCI** (Level 2): Clones the full-length insert from the helper plasmid into the destination backbone

The final construct in the plasmid:
```
[Backbone]--PaqCI**--[Gene w/ mutation]--[Intergene elements]--[PolIII]--[Barcode]--PaqCI*--[Backbone]
```
Intergene elements (e.g., WPRE, bGH polyA) are optional and configured per experiment.

Every oligo in the pool has the same universal structure regardless of tile position:
```
5'--[BsaI>>]--oh1--[mutable region]--[<<BsmBI]--[BsmBI>>]--barcode--[<<BsaI]--3'
     7 nt     4 nt    variable          11 nt      11 nt    20 nt    11 nt
                                                          (= 64 nt overhead)
```

## Quick Start (Command Line)

```bash
# Install BiocManager (needed for Bioconductor packages)
Rscript -e 'install.packages("BiocManager")'

# Install R dependencies
Rscript -e 'install.packages(c("yaml", "readr", "data.table", "cli", "testthat", "rmarkdown"))'
Rscript -e 'BiocManager::install(c("Biostrings", "DNABarcodes"))'

# Copy and edit config (or use a pre-built one from configs/)
cp config_template.yaml my_config.yaml
# Edit my_config.yaml with your gene FASTA path and parameters

# Run
Rscript run_pipeline.R my_config.yaml
# Or use a pre-built config:
Rscript run_pipeline.R configs/grin2a.yaml
```

## Quick Start (RStudio / IDE)

1. **Open the project**: Double-click `dmsggoligo.Rproj` to open in RStudio, or set the working directory manually:
   ```r
   setwd("/path/to/dms-gg-oligo-pipeline")
   ```

2. **Install dependencies** (once): Run the install commands from Quick Start above in the R console.

3. **Run the pipeline** interactively:
   ```r
   # Option A: Source from the console
   config_path <- "my_config.yaml"
   source("run_pipeline.R")

   # Option B: Use the terminal pane
   # In RStudio's Terminal tab: Rscript run_pipeline.R my_config.yaml
   ```

## Configuration

See `config_template.yaml` for all parameters with annotations. Key settings:

| Parameter | Default | Description |
|-----------|---------|-------------|
| `max_oligo_length` | 300 | Twist oligo pool maximum (nt) |
| `max_geneblock_length` | 1800 | Gene fragment synthesis maximum (nt) |
| `barcode_length` | 20 | Total barcode length (nt); set to `"auto"` for auto-sizing |
| `barcode_prefix_length` | 12 | Prefix length for Hamming-constrained region (nt) |
| `min_hamming_distance` | 3 | Minimum Hamming distance between variant prefixes |
| `barcodes_per_variant` | 10 | Number of unique barcodes per variant |
| `barcode_gc_range` | [0.25, 0.75] | Acceptable GC content range for barcodes |
| `barcode_max_homopolymer` | 4 | Maximum homopolymer run length in barcodes |
| `boundary_method` | `"dp"` | `"dp"` (global optimum) or `"greedy"` (local search) |
| `multi_k_search` | `true` | Try multiple tile counts to find best overhang quality |
| `dp_k_range` | 5 | Search K_ideal +/- this many tile counts; stops early when gain < 0.5% |
| `overhang_fidelity_threshold` | 0.95 | Minimum fidelity for auto-selected overhangs |
| `auto_domesticate` | `true` | Automatically apply silent mutations to remove enzyme sites |
| `simulate_assembly` | `false` | Run in-silico GG assembly simulation after design |
| `simulation_samples_per_tile` | 1 | Variants per tile to simulate (when `simulate_assembly` is true) |

## Outputs

The pipeline writes up to 11 files to the output directory (all prefixed with the gene name):

| File | Description |
|------|-------------|
| `<gene>_oligo_pool.csv` | Oligo name, sequence, length, variant ID, tile ID |
| `<gene>_geneblock_order.csv` | Gene block name, sequence, length, enzyme type, gene region |
| `<gene>_variant_barcode_map.csv` | Variant ID, position, WT/mutant AA, barcode, tile ID |
| `<gene>_tile_manifests.csv` | Per-tile BsaI and BsmBI reaction component lists |
| `<gene>_helper_plasmid.csv` | Helper plasmid insert sequence for BsaI Level 1 |
| `<gene>_qc_report.csv` | QC check results (pass/fail, details) |
| `<gene>_oligo_pool.fasta` | Oligo pool in FASTA format (for Twist ordering) |
| `<gene>_geneblock_order.fasta` | Gene blocks in FASTA format |
| `<gene>_sequences.fasta` | Original CDS, domesticated CDS, and protein sequence |
| `<gene>_skipped_variants.csv` | Gene-edge variants excluded due to partial overhang overlap (if any) |
| `<gene>_assembly_report.md` | Wetlab-compatible Markdown report with per-tile assembly guides |

## Pipeline Steps

1. **Config** (`00_config.R`) -- Parse YAML, validate parameters, apply defaults
2. **Gene input** (`01_gene_input.R`) -- Read FASTA, validate CDS (divisible by 3, starts ATG, no internal stops)
3. **Enzyme site scan** (`02_enzyme_site_scan.R`) -- Find endogenous BsaI/BsmBI/PaqCI sites, suggest silent mutations for domestication
4. **Codon table** (`03_codon_table.R`) -- Human codon usage table, preferred codon lookup
5. **Mutation design** (`04_mutation_design.R`) -- Generate all single-AA substitutions + stops using preferred human codons
6. **Assembly planning** (`05_tiling.R` + `06_overhang_selection.R`) -- DP optimizer for tile boundary placement maximizing overhang quality (P_fid * P_eff from BsmBI cycling data); oh3/oh4 auto-selection by score ranking; superblock split-point optimization
7. **Barcode design** (`07_barcode_design.R`) -- Unified hierarchical prefix-suffix barcodes with Hamming distance guarantee on prefixes
8. **Oligo assembly** (`08_oligo_assembly.R`) -- Build complete oligo sequences (universal structure for all tiles)
9. **Gene block design** (`09_wt_geneblock_design.R`) -- WT gene blocks with correct flanking enzyme sites; superblock splitting for fragments >1800 bp
10. **QC** (`10_qc_checks.R`) -- Validates oligo lengths, enzyme site absence, barcode uniqueness, tile coverage, gene block sizes
10b. **In-silico GG simulation** (`13_gg_simulator.R`, optional) -- Simulates BsaI + BsmBI digestion and ligation for sampled oligos; verifies assembled products match expected sequences
11. **Output** (`11_output.R`) -- Write CSV and FASTA files (including skipped gene-edge variants)
12. **Report** (`12_report.R`) -- Generate wetlab-compatible Markdown assembly report with per-tile guides

## Key Design Decisions

**Mutation strategy**: Fully specified codons (no degenerate NNK/NNS). Each oligo encodes exactly one mutation using the most-preferred human codon.

**Tile boundary optimization**: A dynamic programming optimizer searches all valid codon-boundary positions to find tile placements where gene-derived overhangs have high ligation fidelity and efficiency. Scoring uses BsmBI cycling data (Pryor et al. 2020): `Score = P_fid * P_eff`, where P_fid measures accuracy and P_eff measures relative ligation yield. Supports multi-K search across different tile counts.

**Barcode design**: Unified hierarchical prefix-suffix mode -- each variant gets a unique high-Hamming-distance prefix (12 nt), extended with filtered random suffixes to the full barcode length (20 nt). Cross-variant Hamming distance is guaranteed by the prefix; within-variant replicates differ only in their suffix. Configurable `barcodes_per_variant` (default 10) for experimental replication. Prefixes that create enzyme sites at junction boundaries are automatically filtered.

**Superblocks**: WT gene blocks exceeding the 1800 bp synthesis limit are automatically split into superblocks at tile boundaries, using gene-derived overhangs (oh2) as junction sequences. This tile-boundary partitioning ensures each tile's reaction uses only locally-relevant overhangs, avoiding global exclusion conflicts. Overhang collisions at SB boundaries are detected and resolved by shifting boundaries ±1 tile. For very long downstream cassettes (>~1700 nt, e.g., multiple intergene elements), the cassette itself is split across multiple BsmBI-connected fragments — no user action required.

## Repository Structure

```
dms-gg-oligo-pipeline/
├── run_pipeline.R              # Master entry point
├── config_template.yaml        # Annotated config template with all parameters
├── configs/                    # Pre-built gene-specific configs
│   ├── grin2a.yaml             # GRIN2A (1464 codons)
│   ├── akap11.yaml             # AKAP11 (1902 codons)
│   ├── trio.yaml               # TRIO (3098 codons)
│   └── grin2a_long_cassette.yaml  # GRIN2A + P2A-EGFP (1881 nt cassette, split test)
├── R/
│   ├── constants.R             # Enzyme definitions, synthesis limits, AA alphabet
│   ├── utils.R                 # Shared helpers (reverse complement, GC content, etc.)
│   ├── 00_config.R             # YAML parsing, validation, defaults
│   ├── 01_gene_input.R         # FASTA reading, CDS validation
│   ├── 02_enzyme_site_scan.R   # BsaI/BsmBI/PaqCI site detection + domestication
│   ├── 03_codon_table.R        # Human codon usage table
│   ├── 04_mutation_design.R    # Single-AA substitution + stop codon generation
│   ├── 05_tiling.R             # Gene partitioning into tiles
│   ├── 06_overhang_selection.R # DP boundary optimizer + overhang selection
│   ├── 07_barcode_design.R     # Programmed barcode generation (unified hierarchical)
│   ├── 07b_linear_codes.R      # GF(4) Hamming code prefix generation (d <= 3)
│   ├── 08_oligo_assembly.R     # Full oligo sequence construction (universal structure)
│   ├── 09_wt_geneblock_design.R# WT gene block + superblock design
│   ├── 10_qc_checks.R         # Comprehensive QC validation
│   ├── 11_output.R            # CSV/FASTA output writing
│   ├── 12_report.R            # Wetlab-compatible Markdown assembly report
│   └── 13_gg_simulator.R      # In-silico Golden Gate assembly simulator
├── data/
│   ├── human_codon_usage.rds   # CoCoPUTs human codon usage table (Alexaki et al. 2019)
│   ├── neb_overhang_fidelity/  # Overhang fidelity data (see Data Sources below)
│   ├── GRIN2A_NM_000833_CDS.fasta
│   ├── AKAP11_NM_016248_CDS.fasta
│   ├── TRIO_NM_007118_CDS.fasta
│   └── SLC6A1_NM_003042_CDS.fasta
├── tools/
│   └── update_timeline.sh      # Auto-generates TIMELINE.md from git history
├── tests/testthat/             # Unit + integration tests (~6100 tests)
├── Plans/                      # Current design docs and planning references
├── archive/                    # Superseded plans, old configs, helper scripts
├── TIMELINE.md                 # Auto-generated project timeline with milestones
├── BUGS.md                     # Known bugs and status tracking
├── DESCRIPTION                 # R package metadata
├── CLAUDE.md                   # Detailed project context and design rationale
└── dmsggoligo.Rproj            # RStudio project file
```

## Dependencies

**CRAN**: `yaml`, `readr`, `data.table`, `cli`
**Bioconductor**: `Biostrings`, `DNABarcodes`
**Testing**: `testthat` (>= 3.0.0), `rmarkdown`

## Tests

```bash
Rscript -e 'testthat::test_dir("tests/testthat")'
```

For the full test suite including slow integration tests (TRIO gene, ~9 kb):
```bash
RUN_SLOW_TESTS=true Rscript -e 'testthat::test_dir("tests/testthat")'
```

## Validated Genes

The pipeline has been validated on three genes of increasing size plus a cassette-splitting test case. All runs used `barcodes_per_variant=1` (single barcode per variant) for fast validation:

| Gene | Accession | Codons | Variants | Oligos | Gene Blocks | Tiles | Runtime |
|------|-----------|--------|----------|--------|-------------|-------|---------|
| GRIN2A | NM_000833 | 1,465 | 29,220 | 29,220 | 51 | 25 | ~4 min |
| AKAP11 | NM_016248 | 1,902 | 37,960 | 37,960 | 64 | 31 | ~7 min |
| TRIO | NM_007118 | 3,098 | 61,880 | 61,880 | 98 | 47 | ~8 min |
| GRIN2A + P2A-EGFP | NM_000833 | 1,465 | 29,220 | 29,220 | 64 | 25 | ~4 min |

Pre-built configs for each gene are in `configs/`. Runtimes measured on WSL2 with `barcodes_per_variant=1`. At `barcodes_per_variant=10`, expect approximately 10x longer runtimes due to barcode generation and oligo assembly scaling (e.g., GRIN2A: ~45 min, AKAP11: ~77 min).

The GRIN2A + P2A-EGFP test case (`configs/grin2a_long_cassette.yaml`) validates cassette splitting: the downstream cassette (P2A-EGFP + WPRE + spacer + bGH polyA = 1881 nt) exceeds the 1778 nt cassette block synthesis limit and is automatically split into 2 BsmBI-connected fragments.

## Default Cassette Sequences

The default configs use the following downstream cassette elements between the gene 3' end and the PolIII promoter:

```
[Gene 3' end] -- [WPRE 589bp] -- [spacer 31bp] -- [bGH polyA 225bp] -- [hU6+T7 ~250bp] -- [barcode] -- ...
```

All three sequences were obtained from the **pTK4 vector** (Bhatt et al., Addgene):

| Element | Size | Source region in pTK4 | Notes |
|---------|------|-----------------------|-------|
| WPRE | 589 bp | Downstream of GFP cassette | Woodchuck hepatitis virus post-transcriptional regulatory element. Enhances mRNA processing and reduces PolII readthrough. |
| Spacer | 31 bp | Between WPRE and hGH polyA (downstream of GFP) | Contains ClaI and SalI sites. Retained for consistency with pTK4 and XPRESSO vector designs. |
| bGH polyA | 225 bp | Puromycin resistance polyA site (separate from the WPRE-spacer-hGH region) | Bovine growth hormone polyadenylation signal. The pTK4 GFP cassette uses hGH polyA (477 bp) downstream of WPRE, but the puromycin cassette elsewhere in pTK4 uses the shorter bGH polyA. We use bGH polyA for its smaller size and wider use across standard vectors (pcDNA3.1, pEGFP, pAAV). |

The bGH polyA sequence matches GenBank J00008.1 (bovine GH gene), EF550208.1 (pcDNA3.1+PA), and U55762.1 (pEGFP-N1). No BsmBI or PaqCI enzyme sites. See `data/cassette_elements/README.md` for full sequences and `docs/cassette_design_rationale.md` for design rationale.

## Overhang Fidelity Data

The `data/neb_overhang_fidelity/` directory contains pre-processed ligation fidelity data from two publications:

| File | Source | Conditions | Description |
|------|--------|------------|-------------|
| `potapov_18h_overhangs.rds` | Potapov et al. 2018 | T4 ligase, 37°C, 18h | Individual fidelity for all 256 4-nt overhangs |
| `potapov_18h_pairwise.rds` | Potapov et al. 2018 | T4 ligase, 37°C, 18h | 256x256 pairwise ligation matrix |
| `bsai_overhangs.rds` | Pryor et al. 2020 | BsaI, 37°C, 5min/60°C cycling | BsaI enzyme-specific individual fidelity |
| `bsai_pairwise.rds` | Pryor et al. 2020 | BsaI, 37°C, 5min/60°C cycling | BsaI enzyme-specific 256x256 pairwise matrix |
| `bsmbi_overhangs.rds` | Pryor et al. 2020 | BsmBI, 42°C/16°C cycling | BsmBI enzyme-specific individual fidelity |
| `bsmbi_pairwise.rds` | Pryor et al. 2020 | BsmBI, 42°C/16°C cycling | BsmBI enzyme-specific 256x256 pairwise matrix (Hamming model) |
| `bsmbi_cycling_pairwise.rds` | Pryor et al. 2020 | BsmBI, 42°C/16°C cycling | **Real experimental** 256x256 matrix (used for scoring) |
| `high_fidelity_sets.rds` | Potapov et al. 2018 | T4, 25°C, 18h (SA-optimized) | Potapov Table 1 Set 3 (25 overhangs, 95.8% set fidelity) |

**Overhang scoring formula**: `Score = P_fid(oh) * P_eff(oh)`, where both metrics come from the BsmBI cycling matrix (Pryor et al. 2020). P_fid measures ligation accuracy (fraction of correct pairings) and P_eff measures relative ligation yield (correct count vs. best overhang). This matches the actual assembly conditions (BsmBI cycling protocol) and is more conservative than T4 static data. See `260302_overhang_fidelity_comparison/` for the full analysis.

## References

- Potapov et al. (2018). Comprehensive Profiling of Four Base Overhang Ligation Fidelity by T4 DNA Ligase. *ACS Synth Bio* 7(11):2665-2674
- Pryor et al. (2020). Enabling one-pot Golden Gate assemblies of unprecedented complexity. *PLOS ONE*
- Alexaki et al. (2019). Codon and Codon-Pair Usage Tables (CoCoPUTs): Facilitating Genetic Variation Analyses and Recombinant Gene Design. *J Mol Biol* 431(13):2434-2441
- Mukundan & Madhusudhan (2025). OOGGA: Overhang Optimizer for Golden Gate Assembly. *bioRxiv* 10.1101/2025.06.16.659877
