# DMS Golden Gate Oligo Pipeline

R pipeline for designing oligonucleotide pools for Deep Mutational Scanning (DMS) via three-enzyme Golden Gate Assembly. Takes a gene of interest and outputs oligo pool sequences (for Twist Bioscience ordering), WT gene block sequences, and a variant-barcode mapping file.

**Author**: Robert Chen (robchen@uw.edu)
**Lab**: Fowler Lab, University of Washington

## Overview

The pipeline generates all 19 amino acid substitutions + 1 stop codon at every position in a gene, each encoded as a single fully-specified oligo with a programmed barcode. Assembly uses a three-enzyme architecture:

- **BsaI** (Level 1): Stitches the mutant tile into flanking WT gene blocks
- **BsmBI** (Level 1b): Joins the PolIII promoter and barcode cassette
- **PaqCI** (Level 2): Clones the full-length insert into the destination backbone

The final construct in the plasmid:
```
[Backbone]--PaqCI**--[Full gene with one mutation]--[PolIII promoter]--[Barcode]--PaqCI*--[Backbone]
```

## Quick Start

```bash
# Install R dependencies
Rscript -e 'install.packages(c("yaml", "readr", "data.table", "cli", "testthat", "rmarkdown"))'
Rscript -e 'BiocManager::install(c("Biostrings", "DNABarcodes"))'

# Copy and edit config
cp config_template.yaml my_config.yaml
# Edit my_config.yaml with your gene FASTA path and parameters

# Run
Rscript run_pipeline.R my_config.yaml
```

## Outputs

| File | Description |
|------|-------------|
| `oligo_pool.csv` | Oligo name, sequence, length, variant ID, tile ID, tile type |
| `wt_geneblocks.csv` | Gene block name, sequence, length, block type, associated tile IDs |
| `variant_barcode_map.csv` | Variant ID, position, WT/mutant AA, barcode, tile ID |

## Pipeline Steps

1. **Config** (`00_config.R`) -- Parse YAML, validate parameters, apply defaults
2. **Gene input** (`01_gene_input.R`) -- Read FASTA, validate CDS (divisible by 3, starts ATG, no internal stops)
3. **Enzyme site scan** (`02_enzyme_site_scan.R`) -- Find endogenous BsaI/BsmBI/PaqCI sites, suggest silent mutations for domestication
4. **Codon table** (`03_codon_table.R`) -- Human codon usage table, preferred codon lookup
5. **Mutation design** (`04_mutation_design.R`) -- Generate all single-AA substitutions + stops using preferred human codons
6. **Tiling** (`05_tiling.R`) -- Partition gene into tiles within the oligo length budget (~200-250 nt per tile)
7. **Overhang selection** (`06_overhang_selection.R`) -- DP optimizer for tile boundary placement maximizing overhang quality; oh3/oh4 auto-selection from NEB high-fidelity sets; superblock split-point optimization
8. **Barcode design** (`07_barcode_design.R`) -- Programmed barcodes with prefix-optimized Hamming distance for optical pooled screening
9. **Oligo assembly** (`08_oligo_assembly.R`) -- Build complete oligo sequences per tile type (leading/internal/trailing)
10. **Gene block design** (`09_wt_geneblock_design.R`) -- WT gene blocks with correct flanking enzyme sites; superblock splitting for fragments >1800 bp
11. **QC** (`10_qc_checks.R`) -- Validates oligo lengths, enzyme site absence, barcode uniqueness, tile coverage, gene block sizes
12. **Output** (`11_output.R`) -- Write CSV files

## Key Design Decisions

**Mutation strategy**: Fully specified codons (no degenerate NNK/NNS). Each oligo encodes exactly one mutation using the most-preferred human codon.

**Tile boundary optimization**: A dynamic programming optimizer searches all valid codon-boundary positions to find tile placements where gene-derived overhangs have high ligation fidelity (Potapov et al. 2018 NEB data). Supports multi-K search across different tile counts.

**Barcode design**: Prefix-first algorithm generates high-Hamming-distance prefixes (for OPS compatibility) then extends with filtered suffixes. Default: 12 nt, Hamming distance >= 3.

**Superblocks**: WT gene blocks exceeding the 1800 bp synthesis limit are automatically split at positions with high-fidelity BsmBI overhangs.

## Configuration

See `config_template.yaml` for all parameters with annotations. Key settings:

| Parameter | Default | Description |
|-----------|---------|-------------|
| `max_oligo_length` | 300 | Twist oligo pool maximum (nt) |
| `max_geneblock_length` | 1800 | Gene fragment synthesis maximum (nt) |
| `barcode_length` | 12 | Barcode length (nt) |
| `min_hamming_distance` | 3 | Minimum Hamming distance between barcodes |
| `barcode_prefix_length` | 8 | Prefix length for OPS optimization |
| `boundary_method` | `"dp"` | `"dp"` (global optimum) or `"greedy"` (local search) |
| `overhang_fidelity_threshold` | 0.95 | Minimum fidelity for auto-selected overhangs |

## Repository Structure

```
dms-gg-oligo-pipeline/
├── run_pipeline.R              # Master entry point
├── config_template.yaml        # Annotated config template
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
│   ├── 07_barcode_design.R     # Programmed barcode generation
│   ├── 08_oligo_assembly.R     # Full oligo sequence construction
│   ├── 09_wt_geneblock_design.R# WT gene block + superblock design
│   ├── 10_qc_checks.R         # Comprehensive QC validation
│   └── 11_output.R            # CSV/FASTA output writing
├── data/
│   ├── human_codon_usage.rds   # Kazusa human codon usage table
│   ├── neb_overhang_fidelity/  # Potapov 2018 ligation fidelity matrices (BsaI, BsmBI)
│   ├── GRIN2A_NM_000833_CDS.fasta
│   └── SLC6A1_NM_003042_CDS.fasta
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

## References

- Potapov et al. (2018). Comprehensive Profiling of Four Base Overhang Ligation Fidelity by T4 DNA Ligase. *ACS Synth Bio* 7(11):2665-2674
- Pryor et al. (2020). Enabling one-pot Golden Gate assemblies of unprecedented complexity. *PLOS ONE*
- Mukundan & Madhusudhan (2025). OOGGA: Overhang Optimizer for Golden Gate Assembly. *bioRxiv* 10.1101/2025.06.16.659877
