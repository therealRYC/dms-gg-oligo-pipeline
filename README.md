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
[Backbone]--PaqCI**--[Full gene with one mutation]--[PolIII promoter]--[Barcode]--PaqCI*--[Backbone]
```

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

# Copy and edit config
cp config_template.yaml my_config.yaml
# Edit my_config.yaml with your gene FASTA path and parameters

# Run
Rscript run_pipeline.R my_config.yaml
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
| `barcode_length` | 20 | Total barcode length (nt) |
| `min_hamming_distance` | 3 | Minimum Hamming distance between variant prefixes |
| `barcode_prefix_length` | 12 | Prefix length for Hamming-constrained region (nt) |
| `barcodes_per_variant` | 10 | Number of unique barcodes per variant |
| `boundary_method` | `"dp"` | `"dp"` (global optimum) or `"greedy"` (local search) |
| `overhang_fidelity_threshold` | 0.95 | Minimum fidelity for auto-selected overhangs |

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
6. **Assembly planning** (`05_tiling.R` + `06_overhang_selection.R`) -- DP optimizer for tile boundary placement maximizing overhang quality; oh3/oh4 auto-selection from NEB high-fidelity sets; superblock split-point optimization
7. **Barcode design** (`07_barcode_design.R`) -- Unified hierarchical prefix-suffix barcodes with Hamming distance guarantee on prefixes
8. **Oligo assembly** (`08_oligo_assembly.R`) -- Build complete oligo sequences (universal structure for all tiles)
9. **Gene block design** (`09_wt_geneblock_design.R`) -- WT gene blocks with correct flanking enzyme sites; superblock splitting for fragments >1800 bp
10. **QC** (`10_qc_checks.R`) -- Validates oligo lengths, enzyme site absence, barcode uniqueness, tile coverage, gene block sizes
10b. **In-silico GG simulation** (`13_gg_simulator.R`, optional) -- Simulates BsaI + BsmBI digestion and ligation for sampled oligos; verifies assembled products match expected sequences
11. **Output** (`11_output.R`) -- Write CSV and FASTA files (including skipped gene-edge variants)
12. **Report** (`12_report.R`) -- Generate wetlab-compatible Markdown assembly report with per-tile guides

## Key Design Decisions

**Mutation strategy**: Fully specified codons (no degenerate NNK/NNS). Each oligo encodes exactly one mutation using the most-preferred human codon.

**Tile boundary optimization**: A dynamic programming optimizer searches all valid codon-boundary positions to find tile placements where gene-derived overhangs have high ligation fidelity (Potapov et al. 2018 NEB data). Supports multi-K search across different tile counts.

**Barcode design**: Unified hierarchical prefix-suffix mode -- each variant gets a unique high-Hamming-distance prefix (12 nt), extended with filtered random suffixes to the full barcode length (20 nt). Cross-variant Hamming distance is guaranteed by the prefix; within-variant replicates differ only in their suffix. Configurable `barcodes_per_variant` (default 10) for experimental replication. Prefixes that create enzyme sites at junction boundaries are automatically filtered.

**Superblocks**: WT gene blocks exceeding the 1800 bp synthesis limit are automatically split at positions with high-fidelity overhangs (BsaI for 5' WT blocks, BsmBI for 3' WT blocks).

## Repository Structure

```
dms-gg-oligo-pipeline/
├── run_pipeline.R              # Master entry point
├── config_template.yaml        # Annotated config template
├── dmsggoligo.Rproj            # RStudio project file
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
│   ├── 08_oligo_assembly.R     # Full oligo sequence construction (universal structure)
│   ├── 09_wt_geneblock_design.R# WT gene block + superblock design
│   ├── 10_qc_checks.R         # Comprehensive QC validation
│   ├── 11_output.R            # CSV/FASTA output writing
│   ├── 12_report.R            # Wetlab-compatible Markdown assembly report
│   └── 13_gg_simulator.R      # In-silico Golden Gate assembly simulator
├── data/
│   ├── human_codon_usage.rds   # CoCoPUTs human codon usage table (Alexaki et al. 2019)
│   ├── neb_overhang_fidelity/  # Potapov 2018 ligation fidelity matrices (BsaI, BsmBI)
│   ├── GRIN2A_NM_000833_CDS.fasta
│   ├── SLC6A1_NM_003042_CDS.fasta
│   └── AKAP11_NM_016248_CDS.fasta
├── examples/                   # Example pipeline configs
│   └── *.yaml                  # GRIN2A overhang verification configs
├── scripts/                    # Helper scripts
│   ├── generate_grin2a_cds.R   # Generate GRIN2A test FASTA
│   ├── generate_slc6a1_cds.R   # Generate SLC6A1 test FASTA
│   ├── generate_akap11_cds.R   # Generate AKAP11 test FASTA
│   └── validate_gga.py         # Python cross-validator for GG assembly correctness
├── tests/testthat/             # Unit + integration tests
├── DESCRIPTION                 # R package metadata
└── CLAUDE.md                   # Detailed project context and design rationale
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

## References

- Potapov et al. (2018). Comprehensive Profiling of Four Base Overhang Ligation Fidelity by T4 DNA Ligase. *ACS Synth Bio* 7(11):2665-2674
- Pryor et al. (2020). Enabling one-pot Golden Gate assemblies of unprecedented complexity. *PLOS ONE*
- Mukundan & Madhusudhan (2025). OOGGA: Overhang Optimizer for Golden Gate Assembly. *bioRxiv* 10.1101/2025.06.16.659877
