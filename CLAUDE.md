# CLAUDE.md — DMS GG Oligo Pipeline Project Context

## Project Summary

This project builds an R pipeline (`dms-gg-oligo-pipeline`) for designing oligonucleotide pools for Deep Mutational Scanning (DMS). The pipeline takes a gene of interest and outputs oligo pool sequences for ordering from Twist Bioscience, WT gene block sequences, and a variant-barcode mapping file.

**GitHub repo**: `therealRYC/dms-gg-oligo-pipeline` (to be created)
**Language**: R (Bioconductor + CRAN packages)
**PI / Lab**: Fowler Lab, UW
**Author**: Robert Chen (robchen@uw.edu, GitHub: therealRYC)

---

## Key Design Decisions (agreed upon in planning)

### Mutation Strategy
- **Fully specified codons** — each oligo in the pool encodes exactly one specific mutation. No degenerate/random codons (NNK, NNS, etc.).
- All 19 amino acid substitutions + 1 stop codon at every position in the gene.
- Use **human codon usage table** (most-preferred codon per amino acid).

### Two-Level Golden Gate Assembly
- **Level 1 (BsmBI)**: Stitch the mutant tile from the oligo pool into WT gene blocks to reconstruct the full-length gene with one mutation, keeping the barcode linked.
- **Level 2 (PaqCI)**: Clone the assembled full-length insert (gene + PolIII promoter + barcode) into the destination backbone.
- BsmBI and PaqCI are orthogonal (don't interfere with each other).

### Final Construct in Plasmid
```
[Backbone]—PaqCI**—[Full gene with one mutation]—[intergene elements (optional)]—[PolIII promoter]—[Barcode]—PaqCI*—[Backbone]
```
- The PolIII promoter (U6 with internal T7) sits between the gene and barcode.
- This enables flexibility for LABEL-Seq, VIS-Seq, and PerturbView readouts.
- The PolIII promoter transcribes the barcode.
- **Intergene elements** (optional): Additional sequence elements (reporters, selection cassettes, IRES, etc.) can be placed between the gene 3' end and the PolIII promoter via the `intergene_elements` config. These are included in the BsmBI gene blocks and automatically handled by superblock splitting.

### Three Tile Types

The gene is divided into tiles. Each tile position has a different oligo + gene block design depending on whether the tile is at the 5' end, middle, or 3' end of the gene.

**Internal tile (tile is in the middle of the gene):**
- Oligo: `BsmBI***—[mutant tile]—BsmBI*—BsmBI**—[Barcode]—PaqCI*`
- Leading WT block: `PaqCI**—[5' WT gene]—BsmBI***`
- Trailing WT block: `BsmBI*—[3' WT gene]—[PolIII promoter]—BsmBI**`
- BsmBI assembly produces: `PaqCI**—[5' WT]—[mutant tile]—[3' WT]—[PolIII]—[Barcode]—PaqCI*`

**Leading tile (mutation at 5' end of gene):**
- Oligo: `PaqCI**—[mutant tile]—BsmBI*—BsmBI**—[Barcode]—PaqCI*`
- Trailing WT block: `BsmBI*—[3' WT gene]—[PolIII promoter]—BsmBI**`
- No leading WT block needed; oligo carries the PaqCI** site directly.

**Trailing tile (mutation at 3' end of gene):**
- Oligo: `BsmBI***—[mutant tile]—BsmBI*—BsmBI**—[Barcode]—PaqCI*`
- Leading WT block: `PaqCI**—[5' WT gene]—BsmBI***`
- PolIII fragment: `BsmBI*—[PolIII promoter]—BsmBI**` (separate small fragment since PolIII can't fit on the oligo)

### Superblocks
For long genes, WT gene blocks may exceed the ~1800 bp synthesis limit for gene fragments. In that case, blocks are split into "superblocks" — sub-blocks connected by additional unique BsmBI overhangs within the same one-pot Level 1 reaction.

### Cassette Splitting
For very long downstream cassettes (>~1700 nt total, i.e., intergene elements + PolIII exceed the synthesis limit), the cassette itself is split across multiple BsmBI-connected sub-blocks in the same Level 1b reaction. Split points within the cassette are chosen at positions with high-fidelity BsmBI overhangs, using the same OOGGA scoring as gene superblock junctions. After ligation, the cassette is reconstructed seamlessly — the BsmBI junction overhangs are consumed during ligation, leaving an uninterrupted cassette sequence. This is handled automatically: users add elements to `intergene_elements` and the pipeline adapts.

### Oligo Length Budget (Twist max = 300 nt)
The tile size is determined by subtracting fixed overhead (enzyme sites, barcode, spacers) from 300 nt. Approximate tile size: ~200-250 nt (~67-83 codons), depending on tile type.

### Barcode Design
- **Programmed barcodes** — each variant gets a unique, pre-assigned barcode (no randomers).
- Default: 12 nt barcodes, minimum Hamming distance >= 3 (configurable).
- **Prefix optimization for optical pooled screens**: Maximize Hamming distance in the first k nucleotides (configurable, for in-situ sequencing where fewer cycles = less signal degradation).
- Filter out: homopolymer runs, extreme GC content, sequences containing BsmBI/PaqCI sites.
- **Algorithm**: Prefix-first approach — generate high-Hamming-distance k-nt prefixes using `DNABarcodes::create.dnabarcodes()`, then extend with filtered suffixes.

### Overhang Selection
- Auto-selected from NEB Ligase Fidelity Viewer validated data for BsmBI.
- Same ~3-4 overhangs (BsmBI***, BsmBI*, BsmBI**) reused across all tiles since each tile's Level 1 reaction is independent.
- User can override with manual overhang specification.
- Superblock split points are chosen to maximize overhang fidelity at the gene sequence's natural 4-nt junctions.

### WT Gene Blocks
- Ordered as synthesized gene fragments (e.g., Twist gene fragments, IDT gBlocks).
- Synthesized once per gene, reused across experiments.
- The scripts output gene block sequences for ordering.

---

## Repository Structure

```
dms-gg-oligo-pipeline/
├── run_pipeline.R              # Master entry point (Rscript run_pipeline.R config.yaml)
├── config_template.yaml        # Annotated config template
├── R/
│   ├── 00_config.R             # YAML parsing, validation, defaults
│   ├── 01_gene_input.R         # Read FASTA, validate CDS
│   ├── 02_enzyme_site_scan.R   # Find endogenous BsmBI/PaqCI sites, suggest silent mutations
│   ├── 03_codon_table.R        # Human codon usage table, preferred codon lookup
│   ├── 04_mutation_design.R    # Generate all single-AA substitutions + stops
│   ├── 05_tiling.R             # Partition gene into tiles, classify leading/internal/trailing
│   ├── 06_overhang_selection.R # Auto-select high-fidelity overhangs from NEB data
│   ├── 07_barcode_design.R     # Programmed barcodes with prefix-optimized Hamming distance
│   ├── 08_oligo_assembly.R     # Assemble full oligo sequences per tile type
│   ├── 09_wt_geneblock_design.R # Design WT gene blocks + superblock splitting
│   ├── 10_qc_checks.R          # Comprehensive QC validation
│   ├── 11_output.R             # Write CSV/FASTA outputs
│   ├── utils.R                 # Shared helpers (RC, GC, site matching, enzyme formatting)
│   └── constants.R             # Enzyme defs, synthesis limits, AA alphabet
├── data/
│   ├── neb_overhang_fidelity/  # Pre-bundled NEB Ligase Fidelity matrices (RDS)
│   └── human_codon_usage.rds   # CoCoPUTs human codon usage table (Alexaki et al. 2019)
├── tests/testthat/             # Unit + integration tests
├── DESCRIPTION                 # R package metadata
└── .gitignore
```

## R Package Dependencies

**CRAN:** `yaml`, `readr`, `data.table`, `cli`, `testthat`, `rmarkdown`
**Bioconductor:** `Biostrings`, `DNABarcodes`

---

## Module Details

### 1. Config (`00_config.R`)
- Parse YAML config with `yaml::read_yaml()`
- Apply defaults, validate types and ranges
- Key params: gene FASTA path, PolIII promoter sequence, max oligo length (300), barcode length (12), min Hamming distance (3), OPS prefix length, overhang fidelity threshold
- **Intergene elements**: optional `intergene_elements` list in config. `build_downstream_cassette()` concatenates them + PolIII into `downstream_cassette`. Default: empty (pipeline runs identically to before).

### 2. Gene Input (`01_gene_input.R`)
- Read FASTA via `Biostrings::readDNAStringSet()`
- Validate: divisible by 3, starts ATG, no internal stops
- Output: `DNAString` CDS + `AAString` protein

### 3. Enzyme Site Scan (`02_enzyme_site_scan.R`)
- Search gene + PolIII promoter for BsmBI (`CGTCTC`) and PaqCI (`CACCTGC`) on both strands
- For gene sites: suggest silent codon changes ranked by human codon frequency
- For PolIII sites: warn user (can't silently mutate regulatory sequences)
- Optionally auto-apply domestication

### 4. Codon Table (`03_codon_table.R`)
- Load bundled human codon usage (default) or custom table
- `get_preferred_codon(aa)` returns highest-frequency human codon per AA
- Used by mutation design and enzyme site domestication

### 5. Mutation Design (`04_mutation_design.R`)
- For each AA position: generate 19 substitutions + 1 stop using preferred human codons
- Output table: `position, wt_aa, wt_codon, mut_aa, mut_codon, variant_id`
- Post-check: scan each mutant codon in tile context for inadvertent enzyme site creation; swap to next-best codon if found

### 6. Tiling (`05_tiling.R`)
- Compute max tile size from oligo length budget (accounting for enzyme sites, barcode, primer sites)
- Partition gene into tiles on codon boundaries
- Classify each tile: leading / internal / trailing
- Compute WT block boundaries for each tile position

### 7. Overhang Selection (`06_overhang_selection.R`)
- Load NEB Ligase Fidelity matrix for BsmBI
- For the ~3-4 overhangs needed (BsmBI***, BsmBI*, BsmBI**): select from high-fidelity set
- Same overhangs reused across all tiles (each tile's Level 1 reaction is independent)
- For superblocks: select additional overhangs for internal junctions, checking against gene sequence at split points
- User can override with manual overhang specification

### 8. Barcode Design (`07_barcode_design.R`)
- **Prefix-first algorithm:**
  1. Generate high-Hamming-distance k-nt prefixes (e.g., k=8) using `DNABarcodes::create.dnabarcodes()`
  2. Extend each prefix with 4-nt suffix candidates
  3. Filter for GC content, homopolymers, enzyme sites
  4. Assign one barcode per variant
  5. Validate full-length Hamming distance (guaranteed if k > barcode_length/2)
- Configurable: barcode length, min Hamming distance, prefix length, GC range, max homopolymer

### 9. Oligo Assembly (`08_oligo_assembly.R`)
- Core molecular biology logic: orient BsmBI/PaqCI sites correctly for each tile type
- Helper: `orient_enzyme_site(enzyme, overhang, orientation)` builds the recognition + spacer + overhang string
- Builds complete oligo for each variant: tile type determines structure
- Validates all oligos are within length limit

### 10. WT Gene Block Design (`09_wt_geneblock_design.R`)
- For each tile position, generate the required WT blocks with correct flanking enzyme sites
- Leading block: `PaqCI**—[5' WT]—BsmBI***`
- Trailing block: `BsmBI*—[3' WT]—[PolIII]—BsmBI**`
- PolIII-only fragment for trailing tile positions
- Superblock splitting: if any block > 1800 bp, split at positions with high-fidelity BsmBI overhangs

### 11. QC (`10_qc_checks.R`)
- Oligo lengths within limit
- No unintended enzyme sites in oligos
- All barcodes unique with correct Hamming distances
- Tiles cover entire gene without gaps
- Gene blocks within synthesis limits
- GC content and homopolymer warnings
- Each variant differs by exactly one codon from WT

### 12. Output (`11_output.R`)
- `oligo_pool.csv`: oligo_name, sequence, length, variant_id, tile_id, tile_type
- `wt_geneblocks.csv`: block_name, sequence, length, block_type, associated_tile_ids
- `variant_barcode_map.csv`: variant_id, position, wt_aa, mut_aa, barcode, tile_id
- Optional: `qc_report.html` via rmarkdown

---

## Enzyme Constants

- **BsmBI**: Recognition = `CGTCTC`, cuts 1/5 downstream, 4-nt overhang, optimal temp 42C
- **PaqCI**: Recognition = `CACCTGC`, cuts 4/8 downstream, 4-nt overhang, optimal temp 37C
- Gene sequences must be **domesticated** (endogenous BsmBI/PaqCI sites removed via silent mutations) before use.

---

## Implementation Order

1. `constants.R` + `utils.R` — foundation
2. `00_config.R` + `config_template.yaml` — config infrastructure
3. `01_gene_input.R` — gene loading
4. `03_codon_table.R` + `data/human_codon_usage.rds` — codon tables
5. `02_enzyme_site_scan.R` — domestication
6. `04_mutation_design.R` — variant generation
7. `05_tiling.R` — gene partitioning
8. `06_overhang_selection.R` + `data/neb_overhang_fidelity/` — overhang selection
9. `07_barcode_design.R` — barcode generation
10. `08_oligo_assembly.R` — oligo construction (most complex module)
11. `09_wt_geneblock_design.R` — gene block design
12. `10_qc_checks.R` — validation
13. `11_output.R` — file output
14. `run_pipeline.R` — master orchestration
15. Tests + integration test
16. Git repo creation at `therealRYC/dms-gg-oligo-pipeline`

---

## Key Reference Tools & Literature

- **DIMPLE** (github.com/coywil26/DIMPLE): DMS library design using OLS + Golden Gate
- **gga_codon_muts_oligo_design** (jbloomlab): Golden Gate codon mutagenesis oligo design
- **GGAssembler** (Fleishman Lab): Graph-theoretical Golden Gate fragment design
- **VaLiAnT**: Oligo library design for SGE/DMS
- **dms_variants** (jbloomlab): Barcode variant analysis package
- **DNABarcodes** (Bioconductor): Barcode set generation with error-correction properties
- **CoCoPUTs** (Alexaki et al. 2019, J Mol Biol): Updated codon usage tables from FDA/GWU (replaces Kazusa)
- **NEB Ligase Fidelity Viewer**: Source for overhang fidelity data (Potapov et al. 2018)
- **Enrich2** (FowlerLab): Statistical framework for DMS data analysis

---

## Open Items / Still To Discuss

- Exact PolIII promoter sequence to use (U6 + internal T7 — user to provide)
- PaqCI overhang sequences for the backbone (determined by destination vector)
- Whether to add primer binding sites to oligos for PCR amplification before assembly
- Detailed barcode prefix length (k) for OPS optimization — default 8, user configurable

---

## Verification Plan

1. **Unit tests**: `devtools::test()` — each module has test file with known inputs/outputs
2. **Integration test**: Run full pipeline on a short synthetic test gene (~300 bp) with one embedded BsmBI site; verify all outputs generated and QC passes
3. **Manual spot-check**: For a known gene, manually verify 2-3 oligo sequences have correct structure (enzyme sites in right orientation, correct mutation, valid barcode)
4. **In-silico assembly**: Computationally simulate BsmBI digestion of oligos + gene blocks for one tile; verify the assembled product matches expected sequence

---

## Status

**Current state**: Planning complete. No code written yet. Directory is empty. Git repo not yet created.
**Next step**: Begin implementation starting with `constants.R` and `utils.R`.
