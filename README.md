# DMS Golden Gate Oligo Pipeline

R pipeline for designing oligonucleotide pools for Deep Mutational Scanning (DMS) via three-enzyme Golden Gate Assembly. Takes a gene of interest and outputs oligo pool sequences (for Twist Bioscience ordering), WT gene block sequences, and a variant-barcode mapping file.

**Author**: Robert Chen (robchen@uw.edu)
**Lab**: Fowler Lab, University of Washington

## Overview

The pipeline generates all 19 missense substitutions + 1 nonsense (stop) + 1 wild-type control at every position in a gene, each encoded as a single fully-specified oligo with a programmed barcode. Optional synonymous codon controls can also be included. Assembly uses a three-enzyme architecture:

- **BsaI** (Level 1): Inserts the oligo (mutant tile + barcode) and 5' WT gene block(s) into the helper plasmid
- **BsmBI** (Level 1b): Inserts the 3' WT gene block(s) and PolIII promoter between the tile and barcode
- **PaqCI** (Level 2): Clones the full-length insert from the helper plasmid into the destination backbone

The final construct in the plasmid:
```
[Backbone]--PaqCI**--oh_L--[upstream_cassette]--[Gene w/ mutation]--[Intergene elements]--[PolIII]--[Barcode]--PaqCI*--[Backbone]
```
Intergene elements (e.g., WPRE, bGH polyA) are optional and configured per experiment. The `upstream_cassette` (e.g., partial Kozak "CC") sits between the user-specified `oh_L` overhang and the ATG start codon.

Every oligo in the pool has the same universal structure regardless of tile position:
```
5'--[BsaI>>]--oh_L--[upstream_cassette]--[mutable region]--[<<BsmBI]--[BsmBI>>]--barcode--[<<BsaI]--3'
     7 nt     4 nt     0-6 nt               variable          11 nt      11 nt    20 nt    11 nt
```
For tile 1: `oh_L` is user-specified (upstream of ATG), mutable region starts at codon 1 (ATG).
For other tiles: `oh_L` position is filled by the gene-derived oh1; no upstream_cassette.

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
| `oh_L` | `"auto"` | 4-nt BsaI overhang at the 5' gene junction (upstream of ATG). Auto-selected by fidelity scoring if not specified. Set manually to match your helper plasmid. |
| `upstream_cassette` | `""` | DNA sequence between oh_L and ATG (e.g., `"CC"` for partial Kozak). Leave empty if oh_L directly abuts ATG. |
| `max_oligo_length` | 300 | Twist oligo pool maximum (nt) |
| `max_geneblock_length` | 1800 | Gene fragment synthesis maximum (nt) |
| `geneblock_flanking_pad` | `"TGCATG"` | Flanking bases beyond enzyme sites on gene blocks for efficient Type IIs cleavage. Set to `""` to disable. |
| `pcr_handles` | *(none)* | Path to CSV file with per-tile PCR handle pairs (`fwd,rev` columns, both written 5'→3'). The `rev` handle is appended directly to the oligo 3' end as-is (not reverse-complemented). To order the reverse primer, take the RC of the `rev` column. Omit for single-pool-per-tile ordering. |
| `barcode_length` | 20 | Total barcode length (nt); set to `"auto"` for auto-sizing |
| `barcode_prefix_length` | 12 | Prefix length for Hamming-constrained region (nt) |
| `min_hamming_distance` | 3 | Minimum Hamming distance between variant prefixes |
| `barcodes_per_variant` | 10 | Number of unique barcodes per variant |
| `barcode_gc_range` | [0.35, 0.65] | Acceptable GC content range for barcodes |
| `barcode_max_homopolymer` | 4 | Maximum homopolymer run length in barcodes |
| `barcode_filter_hairpin` | `true` | Reject barcodes with hairpin stems > 3 bp |
| `barcode_filter_dinuc_repeats` | `true` | Reject barcodes with dinucleotide repeats > 4 units |
| `barcode_filter_ggc` | `false` | Reject barcodes containing GGC (Illumina error hotspot) |
| `barcode_filter_polyg` | `false` | Reject barcodes with poly-G runs > 2 |
| `barcode_filter_tm_uniformity` | `false` | Reject barcodes with Tm > 2°C from median |
| `boundary_method` | `"oogga_two_pass"` | OOGGA collision-aware two-pass DP (only supported method) |
| `oogga_max_identity` | 2 | Max positional identity (out of 4) between overhang pairs before collision rejection |
| `oogga_beam_width` | 10 | Beam search width for SB boundary DP (higher = more exploration, slower) |
| `overlap_codons` | 6 | Number of codons of overlap between adjacent tiles at boundaries (must be even, >= 2) |
| `min_geneblock_length` | 300 | Minimum gene block length (nt) to avoid synthesis issues |
| `multi_k_search` | `true` | Try multiple tile counts to find best overhang quality |
| `dp_k_range` | 5 | Search K_ideal +/- this many tile counts |
| `paqci_star2` | `"auto"` | 4-nt PaqCI overhang at the 5' end of the insert (PaqCI\*\*). Auto-selected by fidelity scoring if not specified. Set manually to match your destination vector. |
| `paqci_star1` | `"auto"` | 4-nt PaqCI overhang at the 3' end of the insert (PaqCI\*). Auto-selected by fidelity scoring if not specified. Set manually to match your destination vector. |
| `auto_domesticate` | `true` | Automatically apply silent mutations to remove enzyme sites |
| `simulate_assembly` | `true` | Run in-silico GG assembly simulation after design. Uses targeted junctional sampling (boundary-vulnerable variants) + strict nucleotide-level verification. |
| `simulation_samples_per_tile` | 1 | Additional random variants per tile beyond the targeted junctional samples (overlap_codons/2 variants from each boundary) |
| `include_synonymous` | `false` | Boolean (`true`/`false`). When `true`, adds one synonymous variant per position using the highest-frequency alternative codon for the same amino acid. Met and Trp positions are skipped (only one codon each). |

**oh_L overhang**: The `oh_L` parameter defaults to `"auto"`, which auto-selects a high-fidelity BsaI overhang. Set it manually if your helper plasmid requires a specific overhang at the 5' gene junction. Placing oh_L upstream of the start codon (ATG) frees codon 2 for full mutagenesis. Note: `CACC` (a natural Kozak choice) collides with oh3 derived from the U6 promoter ending `...CACCG` — choose oh_L based on your specific plasmid.

**oh3 auto-derivation**: The BsmBI overhang at the PolIII-barcode junction (oh3) is automatically derived from the last 4 nucleotides of the PolIII promoter (before the terminal base). For the default U6 promoter ending `...CACCG`, oh3 = `CACC`. If you provide a different PolIII promoter, oh3 adapts accordingly. If the derived oh3 is a homopolymer (e.g., `AAAA`) or palindromic, the pipeline falls back to score-based selection from the BsmBI fidelity data. You can also override oh3 manually via `manual_oh3` in the config.

**PaqCI overhangs**: The `paqci_star2` and `paqci_star1` parameters default to `"auto"`, which auto-selects high-fidelity PaqCI overhangs. Set them manually if your destination backbone requires specific PaqCI overhangs at the cloning site.

## Outputs

The pipeline writes up to 12 files to the output directory (all prefixed with the gene name):

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
| `<gene>_pcr_primer_table.csv` | Per-tile PCR handle pairs with reverse primer to order (only when `pcr_handles` configured) |
| `<gene>_assembly_report.md` | Wetlab-compatible Markdown report with per-tile assembly guides |

## Pipeline Steps

1. **Config** (`00_config.R`) -- Parse YAML, validate parameters, apply defaults
2. **Gene input** (`01_gene_input.R`) -- Read FASTA, validate CDS (divisible by 3, starts ATG, no internal stops)
3. **Enzyme site scan** (`02_enzyme_site_scan.R`) -- Find endogenous BsaI/BsmBI/PaqCI sites, suggest silent mutations for domestication
4. **Codon table** (`03_codon_table.R`) -- Human codon usage table, preferred codon lookup
5. **Mutation design** (`04_mutation_design.R`) -- Generate 19 missense + 1 nonsense + 1 WT control per position (+ optional synonymous) using preferred human codons
5.5. **Auto-size barcode** (`07_barcode_design.R`, conditional) -- When `barcode_length = "auto"`, compute the minimum barcode length needed for the variant count and barcodes_per_variant before tiling (barcode length affects oligo budget)
6. **Assembly planning** (`05_tiling.R` + `06_overhang_selection.R` + `06b_oogga_dp.R`) -- Reaction-aware boundary optimization: SB boundaries placed first via collision-aware beam search DP (maximizing min set fidelity across all reactions), then tile boundaries within SB segments via per-segment Bellman DP with enzyme-aware alien sets (BsaI and BsmBI pots separated); oh3/oh4 auto-selection by score ranking; user-specified or auto-selected oh_L + upstream_cassette; oh_R cassette search extends last tile into downstream cassette for stop codon mutability
7. **Barcode design** (`07_barcode_design.R`) -- Unified hierarchical prefix-suffix barcodes with Hamming distance guarantee on prefixes; optional enhanced filters (GGC motif, hairpin, dinucleotide repeats, poly-G, Tm uniformity)
8. **Oligo assembly** (`08_oligo_assembly.R`) -- Build complete oligo sequences (universal structure for all tiles; last tile includes invariant cassette prefix from oh_R extension; optional per-tile PCR handles for pooled amplification)
9. **Gene block design** (`09_wt_geneblock_design.R`) -- WT gene blocks with flanking pads for efficient Type IIs cleavage; superblock splitting for fragments >1800 bp
9b. **Recompute reaction fidelity** (`09_wt_geneblock_design.R`) -- Recalculate set fidelity from actual block overhangs (removes phantom overhangs from filtered split points)
9c. **Borderline overhang flagging** (`09_wt_geneblock_design.R`) -- Flag overhang pairs at exactly max_identity threshold for researcher visibility
10. **QC** (`10_qc_checks.R`) -- Validates oligo lengths, enzyme site absence, barcode uniqueness, tile coverage, gene block sizes, PCR handle integrity, enhanced barcode filter compliance
10b. **In-silico GG simulation** (`13_gg_simulator.R`, optional) -- Simulates BsaI + BsmBI digestion and ligation with targeted junctional sampling; strict nucleotide-level verification of assembled products
11. **Output** (`11_output.R`) -- Write CSV and FASTA files (including skipped gene-edge variants)
12. **Report** (`12_report.R`) -- Generate wetlab-compatible Markdown assembly report with per-tile guides

## Key Design Decisions

**Mutation strategy**: Fully specified codons (no degenerate NNK/NNS). Each oligo encodes exactly one mutation using the most-preferred human codon.

**5' gene junction**: The `oh_L` overhang sits upstream of ATG in the helper plasmid, with an optional `upstream_cassette` (e.g., partial Kozak "CC") between oh_L and the start codon. This architecture frees codon 2 for full mutagenesis — previously, oh1 = CDS[1:4] locked codon 2's first nucleotide inside the overhang.

**Boundary optimization**: OOGGA-style collision-aware two-pass DP. Pass 1 places superblock boundaries on the full gene+cassette sequence with beam search to maintain collision-free overhang paths. Pass 2 runs per-segment tile DP with enzyme-aware alien sets (BsaI and BsmBI pots separated). Scoring: P_fid × P_eff from BsmBI cycling data (Pryor et al. 2020). Multi-K search explores different tile counts. Phase 3.5 extends the last tile into the cassette (oh_R search) for stop codon mutability.

**Barcode design**: Unified hierarchical prefix-suffix mode -- each variant gets a unique high-Hamming-distance prefix (12 nt), extended with filtered random suffixes to the full barcode length (20 nt). Cross-variant Hamming distance is guaranteed by the prefix; within-variant replicates differ only in their suffix. Configurable `barcodes_per_variant` (default 10) for experimental replication. Prefixes that create enzyme sites at junction boundaries are automatically filtered. For `min_hamming <= 3`, prefixes are generated using GF(4) linear codes (algebraically guaranteed distance, deterministic). For `min_hamming >= 4`, prefixes are generated using DNABarcodes lexicodes (Conway/Ashlock heuristics).

**PCR handles**: Optional per-tile PCR handles flank each oligo outside the BsaI sites for tile-specific amplification from pooled oligo orders. Specified via a CSV file (`fwd,rev` columns, one row per tile) referenced in config as `pcr_handles: "path/to/handles.csv"`. Handles reduce the mutable region budget (eating into the 300 nt Twist max), potentially increasing tile count. The pipeline validates handle count ≥ tile count after assembly planning.

**Enhanced barcode filters**: Five opt-in filters beyond the standard enzyme site, homopolymer, and GC checks: GGC motif (Illumina error hotspot), hairpin stems, dinucleotide repeats, poly-G runs (two-color chemistry), and Tm uniformity. All default to off. Enable via config flags (`barcode_filter_ggc: true`, etc.).

**Gene block flanking pads**: Gene blocks include flanking DNA (default `"TGCATG"`, 6 nt) outside the Type IIs recognition sites at both termini. NEB recommends ≥6 bp for efficient cleavage of linear fragments. Configurable via `geneblock_flanking_pad` in config; set to `""` to disable.

**Superblocks**: WT gene blocks exceeding the 1800 bp synthesis limit are automatically split into superblocks at tile boundaries with iterative collision blacklisting. SB junction overhangs are gene-derived 4-mers at the split positions. For very long downstream cassettes (>~1700 nt), the cassette itself is split across multiple BsmBI-connected fragments — no user action required.

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
│   ├── 06_overhang_selection.R # Assembly planner (OOGGA two-pass boundary optimizer)
│   ├── 06b_oogga_dp.R         # OOGGA collision-aware DP (SB + tile boundaries)
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
├── tests/testthat/             # Unit + integration tests (~4999 tests)
├── data-raw/                   # Scripts to generate bundled data files (e.g., generate_data.R)
├── Example Genes/              # Pre-generated pipeline outputs for validated genes (GRIN2A, AKAP11, TRIO, etc.)
├── scripts/                    # Utility and benchmarking scripts (bench_k_handling.R, oogga_golden_reference.py)
├── Brainstorm/                 # Research session write-ups
├── Plans/                      # Feature plans and design documents
├── archive/                    # Superseded plans, old configs, helper scripts
├── NOTEBOOK.md                 # Lab notebook (54 entries, Jan 29 - Mar 21)
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

The test suite includes TRIO (9294 nt) gene block tests that run as part of the standard suite.

## Validated Genes

The pipeline has been validated on three genes of increasing size plus a cassette-splitting test case. All pre-built configs use the default `barcodes_per_variant=10`:

| Gene | Accession | Codons | Config | Notes |
|------|-----------|--------|--------|-------|
| GRIN2A | NM_000833 | 1,465 | `configs/grin2a.yaml` | Standard validation gene |
| AKAP11 | NM_016248 | 1,902 | `configs/akap11.yaml` | Medium-size gene |
| TRIO | NM_007118 | 3,098 | `configs/trio.yaml` | Large gene, stress-tests superblock splitting |
| GRIN2A + P2A-EGFP | NM_000833 | 1,465 | `configs/grin2a_long_cassette.yaml` | Cassette splitting test (1881 nt cassette) |

Pre-built configs are in `configs/`. All three overhangs (`oh_L`, `paqci_star2`, `paqci_star1`) default to `"auto"` for auto-selection. Set them manually if your plasmids require specific overhangs.

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

The bGH polyA sequence matches GenBank J00008.1 (bovine GH gene), EF550208.1 (pcDNA3.1+PA), and U55762.1 (pEGFP-N1). No BsmBI or PaqCI enzyme sites. See `data/cassette_elements/README.md` for full sequences.

## Overhang Fidelity Data

The `data/neb_overhang_fidelity/` directory contains enzyme-specific ligation fidelity data from Pryor et al. 2020:

| File | Source | Conditions | Description |
|------|--------|------------|-------------|
| `bsai_overhangs.rds` | Pryor et al. 2020 | BsaI, 37°C/5min + 60°C cycling | Individual fidelity for all 256 4-nt overhangs |
| `bsai_pairwise.rds` | Pryor et al. 2020 | BsaI, 37°C/5min + 60°C cycling | 256x256 pairwise ligation matrix |
| `bsmbi_overhangs.rds` | Pryor et al. 2020 | BsmBI, 42°C/16°C cycling | Individual fidelity for all 256 4-nt overhangs |
| `bsmbi_pairwise.rds` | Pryor et al. 2020 | BsmBI, 42°C/16°C cycling | 256x256 pairwise ligation matrix |

The pipeline uses enzyme-specific cycling data (not T4 ligase static data) because it matches the actual Golden Gate assembly conditions.

**Overhang scoring formula**: `Score = P_fid(oh) * P_eff(oh)`, where both metrics come from the BsmBI cycling matrix (Pryor et al. 2020). P_fid measures ligation accuracy (fraction of correct pairings) and P_eff measures relative ligation yield (correct count vs. best overhang).

## References

- Potapov et al. (2018). Comprehensive Profiling of Four Base Overhang Ligation Fidelity by T4 DNA Ligase. *ACS Synth Bio* 7(11):2665-2674
- Pryor et al. (2020). Enabling one-pot Golden Gate assemblies of unprecedented complexity. *PLOS ONE*
- Alexaki et al. (2019). Codon and Codon-Pair Usage Tables (CoCoPUTs): Facilitating Genetic Variation Analyses and Recombinant Gene Design. *J Mol Biol* 431(13):2434-2441
- Mukundan & Madhusudhan (2025). OOGGA: Overhang Optimizer for Golden Gate Assembly. *bioRxiv* 10.1101/2025.06.16.659877
