# DMS GG Oligo Pipeline — Code Walkthrough

*Code review and implementation guide for the `dms-gg-oligo-pipeline`*
*Generated: 2026-03-07, updated 2026-03-17*

---

## Table of Contents

1. [Pipeline Overview](#1-pipeline-overview)
2. [Foundation: `constants.R` + `utils.R`](#2-foundation)
3. [Configuration: `00_config.R`](#3-configuration)
4. [Gene Input: `01_gene_input.R`](#4-gene-input)
5. [Enzyme Site Scan: `02_enzyme_site_scan.R`](#5-enzyme-site-scan)
6. [Codon Usage: `03_codon_table.R`](#6-codon-usage)
7. [Mutation Design: `04_mutation_design.R`](#7-mutation-design)
8. [Tiling: `05_tiling.R`](#8-tiling)
9. [Overhang Selection: `06_overhang_selection.R`](#9-overhang-selection)
10. [Barcode Design: `07_barcode_design.R` + `07b_linear_codes.R`](#10-barcode-design)
11. [Oligo Assembly: `08_oligo_assembly.R`](#11-oligo-assembly)
12. [WT Gene Block Design: `09_wt_geneblock_design.R`](#12-wt-gene-block-design)
13. [QC Checks: `10_qc_checks.R`](#13-qc-checks)
14. [Output: `11_output.R`](#14-output)
15. [Report: `12_report.R`](#15-report)
16. [GG Simulator: `13_gg_simulator.R`](#16-gg-simulator)
17. [Pipeline Orchestration: `run_pipeline.R`](#17-pipeline-orchestration)

---

## 1. Pipeline Overview

### What This Pipeline Does

The DMS GG Oligo Pipeline designs oligonucleotide pools for Deep Mutational Scanning (DMS) experiments using a **3-enzyme Golden Gate Assembly** strategy. Given a gene of interest, it outputs:

- An oligo pool CSV/FASTA for ordering from Twist Bioscience
- WT gene block sequences for synthesis
- A variant-barcode mapping file
- A wetlab-ready assembly report

### 3-Enzyme Architecture

The pipeline uses three Type IIS restriction enzymes in a hierarchical assembly:

| Enzyme | Recognition | Level | Purpose |
|--------|------------|-------|---------|
| **BsaI** | `GGTCTC` | Level 1 | Inserts oligo + 5'WT blocks into helper plasmid |
| **BsmBI** | `CGTCTC` | Level 1b | Inserts 3'WT+PolIII blocks between tile and barcode |
| **PaqCI** | `CACCTGC` | Level 2 | Moves complete insert to destination backbone |

### Universal Oligo Structure

Every oligo in the pool has the same layout, regardless of where the mutation falls in the gene:

```
5'—[fwd_handle]—BsaI_fwd(7)—oh1(4)—[mutable region]—BsmBI_rev_oh2(11)—BsmBI_fwd_oh3(11)—barcode—BsaI_rev_oh4(11)—[rev_handle]—3'
```

Where:
- `fwd_handle` = optional PCR handle for tile-specific amplification — **0 nt** if not used
- `BsaI_fwd` = `GGTCTCA` (recognition + 1nt spacer) — **7 nt**
- `oh1` = 4 nt WT gene sequence at tile's 5' boundary (BsaI overhang)
- `[mutable region]` = tile interior where the mutation is placed — **~230 nt**
- `BsmBI_rev_oh2` = RC of (CGTCTC + A + oh2) — **11 nt**
- `BsmBI_fwd_oh3` = CGTCTC + A + oh3 — **11 nt** (same for all tiles)
- `barcode` = programmed barcode — **20 nt** (default)
- `BsaI_rev_oh4` = RC of (GGTCTC + A + oh4) — **11 nt** (same for all tiles)
- `rev_handle` = optional PCR handle for tile-specific amplification — **0 nt** if not used

**Total fixed overhead** = 7 + 4 + 11 + 11 + 20 + 11 = **64 nt** (without handles), leaving **236 nt** (~78 codons) for the mutable region at the 300 nt Twist max. When PCR handles are used, they reduce the mutable region budget accordingly.

### Data Flow Summary

```
config.yaml
    │
    ▼
[1] load_config() ──────────► cfg (validated config list)
    │
    ▼
[2] read_gene() ────────────► gene (cds, protein, n_codons, gene_name)
    │
    ▼
[3] load_codon_usage() ─────► codon_usage (64-row table: codon, aa, frequency)
    │
    ▼
[4] scan_enzyme_sites() ───► scan_result (sites in gene/promoter/intergene)
    apply_domestication() ──► gene$cds (domesticated, no BsaI/BsmBI/PaqCI sites)
    │
    ▼
[5] design_mutations() ────► variants (position, wt/mut aa/codon, variant_type)
    check_and_fix_new_sites()  (post-check for inadvertent enzyme sites)
    │
    ▼
[5.5] auto_size_barcode_length()  (if barcode_length="auto", resolve before tiling)
    │
    ▼
[6] plan_assembly() ───────► assembly_plan (tiles, oh3, oh4, superblocks)
    assign_variants_to_tiles()  (each variant → best tile)
    │
    ▼
[7] design_barcodes() ─────► barcodes (one unique barcode per variant×replicate)
    │
    ▼
[8] assemble_oligos() ─────► oligos (oligo_name, sequence, length, variant_id)
    │
    ▼
[9] design_wt_geneblocks() ► geneblock_result (blocks, tile_manifests, helper)
    [9b] recompute_reaction_fidelity()  (from actual block overhangs)
    [9c] flag_borderline_overhangs()    (near-miss overhang pairs)
    │
    ▼
[10] run_qc_checks() ──────► qc_result (17 validation checks)
     simulate_pipeline_assembly()  (optional in-silico BsaI + BsmBI simulation)
    │
    ▼
[11] write_outputs() ──────► CSV/FASTA files in output_dir
    │
    ▼
[12] generate_report() ────► wetlab-ready Markdown assembly report
```

---

## 2. Foundation

### `constants.R` — Enzyme definitions, synthesis limits, amino acid alphabet

**File**: `R/constants.R` (157 lines)

This file defines all the biological and engineering constants used throughout the pipeline.

#### Enzyme Definitions

```r
ENZYMES <- list(
  BsaI = list(
    name = "BsaI",  recog = "GGTCTC",  recog_rc = "GAGACC",
    cut_fwd = 1L,  cut_rev = 5L,  oh_len = 4L,  spacer_len = 1L,  temp = 37L
  ),
  BsmBI = list(
    name = "BsmBI",  recog = "CGTCTC",  recog_rc = "GAGACG",
    cut_fwd = 1L,  cut_rev = 5L,  oh_len = 4L,  spacer_len = 1L,  temp = 42L
  ),
  PaqCI = list(
    name = "PaqCI",  recog = "CACCTGC",  recog_rc = "GCAGGTG",
    cut_fwd = 4L,  cut_rev = 8L,  oh_len = 4L,  spacer_len = 4L,  temp = 37L
  )
)
```

**Key details:**
- `cut_fwd` / `cut_rev`: Nucleotides downstream of the recognition site where the enzyme cuts on the forward and reverse strands, respectively. The difference (`cut_rev - cut_fwd`) equals `oh_len`.
- `spacer_len`: Gap between the end of the recognition site and the start of the overhang. BsaI and BsmBI have 1 nt spacer; PaqCI has 4 nt.
- BsaI (`GGTCTC`) and BsmBI (`CGTCTC`) differ by only 1 nt — this is critical for domestication (fixing one can create the other).

#### Synthesis Limits

```r
MAX_OLIGO_LENGTH    <- 300L   # Twist oligo pool max
MAX_GENEBLOCK_LENGTH <- 1800L  # Gene fragment synthesis max
MIN_GENEBLOCK_LENGTH <- 300L   # Twist gene fragment synthesis minimum
```

#### Other Constants

- `AA_ALL`: All 20 standard amino acids + stop (`*`)
- `CODON_TABLE`: Standard genetic code (64 codons → 21 amino acids/stop)
- `AA_TO_CODONS`: Reverse lookup (amino acid → all codons)
- `PALINDROMIC_4NT`: 16 palindromic 4-mers — hard-blacklisted for freely-chosen overhangs because they enable self-circularization
- `POLIII_TERM_SEQ`: `"TTTT"` — RNA PolIII terminates at ≥4 T's; barcodes must avoid this
- `DEFAULT_BARCODE_LENGTH`: 20 nt
- `DEFAULT_BARCODES_PER_VARIANT`: 10

### `utils.R` — Shared DNA helper functions

**File**: `R/utils.R` (228 lines)

#### Key Functions

| Function | Purpose |
|----------|---------|
| `reverse_complement(seq)` | RC via Biostrings (handles any DNA string) |
| `gc_content(seq)` | GC fraction (splits string, counts G/C) |
| `find_enzyme_sites(seq, site)` | Finds all occurrences of a recognition site on both strands |
| `has_enzyme_sites(seq, enzymes)` | Quick boolean check for any BsaI/BsmBI/PaqCI sites |
| `orient_enzyme_site(enzyme_name, overhang, orientation)` | Builds the full enzyme site string for oligo construction |
| `extract_codons(cds)` | Splits CDS into 3-nt codons |
| `replace_codon(cds, position, new_codon)` | Substitutes one codon by position |
| `translate_codon(codon)` / `translate_cds(cds)` | Standard genetic code translation |

#### `orient_enzyme_site()` — Critical for Oligo Construction

This function builds the oriented enzyme site string that appears on oligos and gene blocks:

```r
orient_enzyme_site <- function(enzyme_name, overhang, orientation = "forward",
                               spacer_seq = NULL) {
  enz <- ENZYMES[[enzyme_name]]
  if (is.null(spacer_seq)) {
    spacer_seq <- paste(rep("A", enz$spacer_len), collapse = "")
  }
  if (orientation == "forward") {
    paste0(enz$recog, spacer_seq, overhang)     # e.g., "CGTCTCAGGTA"
  } else {
    # Reverse: RC of the whole thing so the enzyme reads it on the opposite strand.
    # Result starts with overhang, ends with RC(recognition).
    reverse_complement(paste0(enz$recog, spacer_seq, reverse_complement(overhang)))
  }
}
```

**How it works for a forward BsmBI site with overhang `GGTA`:**
- `paste0("CGTCTC", "A", "GGTA")` → `"CGTCTCAGGTA"` (11 nt)
- After digestion, the enzyme reads the recognition site, cuts 1 nt past it (spacer), and exposes the 4-nt overhang `GGTA`.

**For a reverse site** (overhang `GGTA`):
- First builds `"CGTCTC" + "A" + RC("GGTA")` = `"CGTCTCATACC"` (the forward reading on the complementary strand)
- Then takes the RC of the whole thing: `"GGTATGAGACG"` (this is what appears on the oligo's top strand)
- After digestion, the enzyme on the bottom strand cuts to expose the `GGTA` overhang.

**Things to verify:**
- The `"A"` spacer default is used throughout — if any enzyme site uses a different spacer in reality, this would silently produce wrong sequences.
- The reverse orientation logic (`RC(overhang)` inside the forward construct, then RC of the whole thing) is algebraically correct: after RC, the exposed overhang equals the input overhang.

#### `find_enzyme_sites()` — Iterative Substring Search

Uses a `while` loop with `regexpr()` + `fixed = TRUE` to find all occurrences (including overlapping ones) on both strands. Returns a data frame with `start`, `end`, `strand`, `match`.

**Performance note:** This function creates data frames via `rbind()` in a loop — fine for small numbers of sites in a gene, but was identified as a bottleneck for batch barcode filtering. The pipeline uses fast `grepl()` alternatives for batch operations (see `filter_sequences_fast()` in barcode design).

---

## 3. Configuration

### `00_config.R` — YAML parsing, validation, defaults

**File**: `R/00_config.R` (683 lines)

#### `load_config(config_path)` → validated config list

The config loader performs three tasks:

1. **Deprecation warnings**: Alerts for removed parameters (`ops_mode`, `barcode_capacity_tolerance`)
2. **Default application**: Fills in 20+ parameters with sensible defaults
3. **Type coercion + validation**: Ensures all values are the right type and in valid ranges

**Key defaults:**
```r
defaults <- list(
  max_oligo_length        = 300L,
  max_geneblock_length    = 1800L,
  barcode_length          = 20L,     # or "auto"
  min_hamming_distance    = 3L,
  barcode_prefix_length   = 12L,
  barcodes_per_variant    = 10L,
  overlap_codons          = 6L,
  boundary_method         = "oogga_two_pass",  # only supported method
  upstream_cassette       = "",                # sequence between oh_L and ATG (e.g., Kozak tail)
  auto_domesticate        = TRUE,
  simulate_assembly       = TRUE,
  include_synonymous      = FALSE,
  ...
)
```

**`upstream_cassette`** (new): Optional DNA sequence inserted between oh_L and the ATG start codon on tile 1 oligos (e.g., a Kozak tail). Its length is subtracted from the mutable region budget for ALL tiles (conservative — avoids tile-specific DP refactoring). Default: empty string. Validated as ACGT-only when non-empty.

#### `build_downstream_cassette(cfg)` — Intergene Elements

Parses the optional `intergene_elements` list from the config YAML and concatenates them with the PolIII promoter to form the `downstream_cassette`:

```
downstream_cassette = concat(intergene_elements) + polIII_promoter
```

Each element must have `name` and `sequence` fields. Sequences are validated as ACGT-only, uppercased, and concatenated.

When `intergene_elements` is empty (the default), `downstream_cassette = polIII_promoter` — identical to the original pipeline behavior.

#### `validate_config(cfg)` — Comprehensive Validation

Validates:
- Gene input: exactly one of `gene_fasta` or `gene_cds` required
- `polIII_promoter` is required
- `paqci_star1` and `paqci_star2` default to `"auto"` (auto-selected via `auto_select_paqci_pair()`); can also be user-specified 4-nt sequences (not `NNNN`)
- `oh3` and `oh4` (if provided): 4 ACGT characters, distinct, not RC of each other, no enzyme sites
- Range checks on oligo length (100–500), barcode length (6–30 or "auto"), etc.
- Prefix length constraints: `prefix_length >= min_hamming` and `prefix_length < barcode_length` when `barcodes_per_variant > 1`

**Things to verify:**
- The `oh3`/`oh4` enzyme site check tests the 4-nt overhang itself for containing enzyme recognition sequences. A 4-nt string can't contain a 6+ nt recognition sequence, so this check will never trigger. However, it's a reasonable forward-looking guard.
- `gene_name` validation rejects filesystem-unsafe characters (`/\:*?"<>|`) — good practice for output file naming.

---

## 4. Gene Input

### `01_gene_input.R` — Read FASTA, validate CDS

**File**: `R/01_gene_input.R` (125 lines)

#### `read_gene(fasta_path)` → list with cds, protein, n_codons, gene_name

1. Reads FASTA via `Biostrings::readDNAStringSet()`
2. If multiple sequences, warns and uses the first
3. Extracts `gene_name` as first whitespace-delimited token from the FASTA header
4. Uppercases the CDS
5. Validates via `validate_cds()`
6. Translates via `translate_cds()`
7. Removes terminal stop from protein string

#### `read_gene_from_string(cds_string, gene_name)` → same structure

Alternative entry point for inline CDS (via `gene_cds` config parameter). Same validation/translation, but no FASTA parsing.

#### `validate_cds()` — CDS Validation

Checks:
- Valid DNA characters (ACGT only)
- Length divisible by 3
- Starts with ATG
- No internal stop codons (all codons except the last are checked)

**Things to verify:**
- The pipeline does NOT require the CDS to end with a stop codon — this is intentional. The last codon is treated as the "stop position" in tiling regardless of whether it's actually TAA/TAG/TGA.
- The "no internal stops" check correctly excludes the last codon from the check.

---

## 5. Enzyme Site Scan

### `02_enzyme_site_scan.R` — Domestication engine

**File**: `R/02_enzyme_site_scan.R` (421 lines)

This is the module that makes the gene safe for Golden Gate assembly by removing endogenous enzyme recognition sites through silent codon changes.

#### `scan_enzyme_sites(cds, polIII, codon_usage, intergene_elements)` → scan result

Scans four sequences for BsaI, BsmBI, and PaqCI sites:
1. **Gene CDS** — sites can be domesticated via silent mutations
2. **PolIII promoter** — can't be silently mutated; user warned
3. **Intergene elements** — can't be silently mutated; user warned
4. **Junctions** — sites that span the boundary between adjacent sequences (invisible when scanning each piece alone)

#### `suggest_domestication()` — Silent Mutation Finder

For each enzyme site in the gene, this function:

1. Identifies overlapping codons (`first_codon` to `last_codon`)
2. For each codon, gets alternative synonymous codons ranked by human codon frequency
3. Tests each alternative: does it disrupt the target site?
4. **Critical cross-check**: also verifies the fix doesn't create a NEW site for any of the three enzymes

```r
# This is critical: BsaI (GGTCTC) and BsmBI (CGTCTC) differ by 1 nt
for (check_enz_name in c("BsaI", "BsmBI", "PaqCI")) {
  if (check_enz_name == enzyme) next
  new_sites <- find_enzyme_sites(region, check_enz$recog)
  orig_sites <- find_enzyme_sites(orig_region, check_enz$recog)
  if (nrow(new_sites) > nrow(orig_sites)) {
    creates_new <- TRUE
    break
  }
}
```

This cross-check is essential because BsaI and BsmBI recognition sequences differ by only one nucleotide (`GGTCTC` vs `CGTCTC`). Changing a `G→C` to fix a BsaI site could create a BsmBI site, and vice versa.

#### `apply_domestication()` — Iterative Application

Applies fixes in reverse position order (to avoid index shifting), then runs **iterative re-checking** up to 5 times:

```r
for (iter in seq_len(max_iterations)) {
  all_clear <- TRUE
  for (enz_name in c("BsaI", "BsmBI", "PaqCI")) {
    remaining <- find_enzyme_sites(cds, ENZYMES[[enz_name]]$recog)
    if (nrow(remaining) > 0) {
      all_clear <- FALSE
      new_dom <- suggest_domestication(cds, remaining, codon_usage)
      # ... apply fixes ...
    }
  }
  if (all_clear) break
}
```

The iterative approach handles cascading BsaI↔BsmBI interactions.

#### `scan_downstream_junctions()` — Junction Site Detection

A subtle but important function. An enzyme site can span the boundary between two adjacent sequences and be invisible when scanning each piece individually. For example, if the gene ends in `...CGTCT` and the intergene element starts with `CATG...`, the junction `CGTCTC` creates a BsmBI site.

The function extracts 6 nt of context from each side of every junction and scans the 12-nt region. Only sites that actually span the boundary (not fully within one side) are reported.

**Things to verify:**
- The context length of 6 nt is sufficient for the longest recognition site (PaqCI = 7 nt) minus 1.
- Junction sites cannot be auto-domesticated — they're reported as warnings. A user would need to modify the intergene element or promoter sequences manually.

---

## 6. Codon Usage

### `03_codon_table.R` — CoCoPUTs codon usage

**File**: `R/03_codon_table.R` (247 lines)

#### `load_codon_usage(custom_path)` → data frame (codon, aa, frequency)

Loading priority:
1. Custom table (CSV or RDS) — validated via `validate_codon_table()`
2. Bundled RDS at `data/human_codon_usage.rds`
3. Built-in table from `builtin_human_codon_usage()`

The built-in table uses **CoCoPUTs** (Alexaki et al. 2019) — a modern replacement for the Kazusa database (last updated 2007). Key stats:
- 119,196 CDS entries, 77.5M total codons
- Assembly: GRCh38.p13 (GCF_000001405.39)
- Frequencies are per thousand codons

#### `validate_codon_table()` — Rigorous Validation

Checks:
- Required columns: `codon`, `aa`, `frequency`
- Exactly 64 rows
- Valid 3-nt ACGT codons
- No duplicate codons
- Non-negative numeric frequencies

#### Key Lookup Functions

```r
get_preferred_codons(codon_usage)   # → named vector: aa → highest-frequency codon
get_preferred_codon(aa, preferred)  # → single codon for one amino acid
get_ranked_codons(aa, codon_usage)  # → all codons for aa, sorted by frequency desc
```

**CoCoPUTs vs Kazusa differences**: 19 of 21 preferred codons are identical. The two changes:
- **Asn (N)**: AAT replaces AAC (CoCoPUTs: AAT=18.51, AAC=18.28)
- **Pro (P)**: CCT replaces CCC (CoCoPUTs: CCT=19.11, CCC=18.88)

Both are near-ties, so the practical impact is minimal.

---

## 7. Mutation Design

### `04_mutation_design.R` — Variant generation

**File**: `R/04_mutation_design.R` (200 lines)

#### `design_mutations(cds, codon_usage, include_synonymous)` → variants data frame

For each mutable position (codons 2 through n-1), generates:
- **19 missense** mutations (all amino acids except WT) using preferred human codons
- **1 nonsense** (stop) mutation using the preferred stop codon
- **1 WT control** (identical codon to wild-type, unique barcode for normalization)
- Optionally, **1 synonymous** variant (different codon, same AA — Met and Trp skipped)

**Why codons 1 and n are excluded:**
- Codon 1 (Met/ATG) always falls in the first tile's oh1 overhang — its mutation would be silently overridden during assembly.
- The last codon (stop) is excluded because read-through mutations are not of experimental interest in DMS. (Note: since the oh_R cassette extension feature, the stop codon is geometrically *inside* the last tile's mutable region — it's excluded by choice, not by constraint.)

```r
mutable_positions <- 2L:(n_codons - 1L)
```

Each variant gets a `variant_type` column: `"missense"`, `"nonsense"`, `"wt_control"`, or `"synonymous"`.

**Variant naming convention:**
- Missense: `"A42G"` (WT_aa + position + mut_aa)
- Nonsense: `"A42*"`
- WT control: `"A42="`
- Synonymous: `"A42syn"`

#### `check_and_fix_new_sites()` — Post-Check for Inadvertent Sites

After all variants are designed, this function checks whether substituting the mutant codon into the domesticated CDS creates a new enzyme site in the local region:

```r
mut_cds <- replace_codon(cds, pos, mut_codon)
win_start <- max(1L, nt_start - 14L)
win_end <- min(nchar(mut_cds), nt_start + 2L + 14L)
window <- substring(mut_cds, win_start, win_end)

if (has_enzyme_sites(window)) {
  # Try alternative codons for the same amino acid
  ranked <- get_ranked_codons(mut_aa, codon_usage)
  ...
}
```

Uses a ±14 nt window around the mutation site (sufficient for any 7-nt recognition site to be detected).

WT controls are skipped because their codon is identical to the domesticated CDS.

**Performance note:** This function calls `has_enzyme_sites()` → `find_enzyme_sites()` per variant, which was identified as a bottleneck for large genes (step 5 takes ~100-244s depending on gene size). The window-based approach is already an optimization over full-CDS checking.

**Things to verify:**
- The ±14 nt window is sufficient. PaqCI has a 7-nt recognition sequence, so a mutation at position `p` could create a site that starts at `p-6` or ends at `p+8`. The window of ±14 provides ample coverage.
- The preferred stop codon for `"*"` is `TAA` (frequency 0.44 per thousand) — this is the most common stop codon in CoCoPUTs.

---

## 8. Tiling

### `05_tiling.R` — Gene partitioning

**File**: `R/05_tiling.R` (242 lines)

#### `compute_max_tile_size(max_oligo_length, barcode_length, handle_overhead, upstream_cassette_len)` → integer nt

Computes the maximum mutable region that fits in an oligo after subtracting all fixed elements:

```
overhead = BsaI_5'(7) + oh1(4) + upstream_cassette + BsmBI_oh2(11) + BsmBI_oh3(11) + barcode + BsaI_oh4(11) + handles
         = 44 + upstream_cassette_len + barcode_length + handle_overhead

mutable_size = max_oligo_length - overhead
             = 300 - 44 - 0 - 20 - 0 = 236 nt = 78 codons (at barcode_length=20, no cassette/handles)
```

The `upstream_cassette_len` is subtracted from ALL tiles' mutable space (conservative -- avoids tile-specific DP refactoring; cost: 0-2 codons for typical <=6 nt cassettes). Result is rounded down to a codon boundary (multiple of 3).

#### `partition_tiles()` — Geometric Partitioning

Simple equal-sized tiling with overlap. Each tile is `mutable_codons` wide, with `overlap_codons` (default 6) shared between adjacent tiles.

```r
effective_step <- mutable_codons - overlap_codons
tile_starts <- seq(1L, n_codons, by = effective_step)
```

**Note:** This function is the fallback/basic tiler. In production, `plan_assembly()` in `06_overhang_selection.R` uses `search_tile_boundaries_dp()` which dynamically places boundaries at positions where gene-derived overhangs have high fidelity.

Each tile records:
- `oh1_seq`: first 4 nt of the tile (WT gene at 5' boundary — becomes the BsaI overhang)
- `oh2_seq`: last 4 nt of the tile (WT gene at 3' boundary — becomes the BsmBI overhang)

#### `assign_variants_to_tiles()` — Variant-to-Tile Assignment

With overlapping tiles, a codon can fall in multiple tiles. This function assigns each variant to the best tile:

- **Quality 2** (preferred): codon is fully in the mutable interior (past oh1, before oh2)
- **Quality 1** (fallback): codon partially overlaps an overhang region

Variants at gene edges that can only achieve quality 1 are flagged with `overhang_note = "partial_oh_overlap"`. These are later filtered out in `run_pipeline.R` because the mutation would be overridden by the fixed overhang during assembly.

**Things to verify:**
- The quality check uses `local_start >= 5L` (past 4-nt oh1) and `local_end <= tile_len - 4L` (before 4-nt oh2). This correctly excludes codons that partially overlap the overhang regions.
- The vectorized lookup `pos_tile[variants$position]` is much faster than per-variant iteration.

---

## 9. Overhang Selection

### `06_overhang_selection.R` + `06b_oogga_dp.R` — Assembly planning with OOGGA collision-aware DP

**Files**: `R/06_overhang_selection.R` (~1936 lines) + `R/06b_oogga_dp.R` (~1420 lines)

These modules integrate tiling, overhang selection, and superblock partitioning into a single planning system. The architecture uses **OOGGA-style collision-aware dynamic programming** (inspired by Mukundan & Madhusudhan 2025) in a two-pass design: SB boundaries first, then tile boundaries per SB segment.

#### Overhang Scoring Formula

```
Score = P_fid(oh) × P_eff(oh)
```

Both metrics from the **BsmBI cycling 256×256 matrix** (Pryor et al. 2020):
- **P_fid** = M[X,X] / sum(M[X,*]) — individual fidelity (accuracy)
- **P_eff** = M[X,X] / max(diag(M)) — relative ligation efficiency (yield)

Returns `NA` for unknown overhangs (excluded from optimization). The HF set bonus was dropped because under cycling conditions, pairwise misligation between non-complementary overhangs is negligible.

```r
overhang_score <- function(oh, fid_lookup, eff_lookup) {
  fid <- if (oh %in% names(fid_lookup)) unname(fid_lookup[oh]) else NA_real_
  eff <- if (oh %in% names(eff_lookup)) unname(eff_lookup[oh]) else NA_real_
  fid * eff
}
```

#### Data Loading

- `load_overhang_fidelity("BsmBI")`: Loads from RDS file, or derives from pairwise matrix
- `load_pairwise_matrix("BsmBI")`: Loads the 256×256 BsmBI cycling matrix (Pryor 2020) from `data/neb_overhang_fidelity/bsmbi_pairwise.rds`
- `compute_overhang_efficiency(matrix)`: Computes P_eff for all 256 overhangs from the pairwise matrix
- `POTAPOV_TABLE1_SET3_25`: Hard-coded 25-overhang HF set from Potapov 2018 Table 1 (informational only)

**Matrix convention:** `M[X,Y]` = ligation frequency of overhang X with RC(Y). The diagonal `M[X,X]` = correct Watson-Crick ligation.

#### OOGGA Collision-Aware DP (`06b_oogga_dp.R`)

The core innovation: the DP transition checks each candidate overhang against **all prior overhangs on the path**, rejecting candidates with >max_identity/4 positional matches (including RC checks). This eliminates the iterative blacklisting loop from the legacy approach.

##### Collision Primitives

```r
build_oh_compatibility(max_identity = 2L)
```

Pre-computes a 256×256 boolean matrix: `compat[A, B] = TRUE` iff `A` passes the identity check against both `B` and `RC(B)`. The default `max_identity = 2` means ≤2 of 4 positions can match — faithful to OOGGA's `__find_identities()` logic.

##### Two-OH SB Boundary Model

Each gene-region SB boundary contributes **two overhangs** to the collision set:
- **oh1**: first 4 nt past the boundary (start of next segment)
- **oh2**: 4 nt at the overlap extension point (end of prev segment's last tile)

Both oh1 and oh2 must be pairwise compatible with all prior boundary overhangs on the path, plus alien overhangs (oh3, oh4, oh_L + RCs).

Score is multiplicative: `overhang_score(oh1) * overhang_score(oh2)`.

Cassette-region boundaries use a single-OH model (no tile overlap in the cassette).

##### Beam Search DP

The SB DP uses beam search (default width 10) because Bellman optimality doesn't hold — the collision constraint is path-dependent. Each beam entry stores the full tuple (score, positions, oh1s, oh2s) for path reconstruction.

```r
search_sb_boundaries_oogga(full_seq, gene_len, max_block_length, ...)
```

##### Per-Segment Tile DP

After SB boundaries are placed, each SB segment gets its own tile DP. Key features:
- **Enzyme-aware alien sets**: oh1 (BsaI pot) checks against oh_L, oh4 + RCs; oh2 (BsmBI pot) checks against oh3 + RC. This avoids over-constraining — oh1 and oh2 are in different enzyme pots.
- **Tile-independent reactions**: Each tile's assembly reaction runs in its own pot, so tile-to-tile collision checking is unnecessary. This enables standard Bellman DP (no beam search needed).
- **Multi-K search**: Tries K_ideal ± dp_k_range tile counts, selecting by geometric mean score per boundary.

##### Tile Overlap

Tiles are extended rightward by `overlap_codons` (default 6) so adjacent tiles share codons at their boundary. This means:
- Core boundary positions from the DP determine where tiles logically separate
- Each tile physically extends `overlap_codons` past its core end
- Codons near the boundary are mutable in both tiles — `assign_variants_to_tiles()` picks the tile where they're fully interior

#### `plan_assembly()` — Master Orchestrator

Main entry point called from `run_pipeline.R`. Follows a **constrained-first ordering**: fixed overhangs are committed before any boundary search runs.

**Phase 1** — Select fixed overhangs (oh_L, oh3, oh4, PaqCI):
- `oh_L` (BsaI, 5' gene junction): default `"auto"` — auto-selected via `auto_select_bsai_pair()` which jointly optimizes oh_L and oh4 for BsaI set fidelity. When auto-selected, oh_L is external to the CDS (upstream of ATG), not the first 4 nt of the gene. Can also be user-specified.
- `oh3` (BsmBI, same for all tiles): prefer promoter-derived oh3 from the PolIII promoter's terminal 5 nt. If the promoter-derived 4-mer is a homopolymer or palindrome, fall back to highest-scoring overhang by P_fid x P_eff
- `oh4` (BsaI, same for all tiles): jointly optimized with oh_L via `auto_select_bsai_pair()` for best BsaI set fidelity, blacklisting oh3+RC
- `paqci_star2` / `paqci_star1` (PaqCI, Level 2): default `"auto"` — auto-selected via `auto_select_paqci_pair()` which scores candidates by base composition diversity and avoids collision with oh_L, oh4, oh3
- oh3 and oh4 do NOT check against oh1/oh2 (which don't exist yet) — downstream phases will blacklist them

**Phase 2** — SB boundary search (OOGGA DP on full gene+cassette):
- SBs at any codon position — no tile constraint
- SB junction OHs must avoid fixed overhangs (oh3, oh4, oh_L)
- Two-OH model with beam search for collision-free paths

**Phase 3** — Per-segment tile search (OOGGA DP per SB segment):
- Each SB segment gets its own tile DP
- SB junction OHs are alien to the tile DP (prevents tile–SB collisions in the BsmBI pot)
- Enzyme-aware alien sets (BsaI vs BsmBI pot separation)

**Phase 3.5** — oh_R cassette search (last tile only):
- After the tile DP, the last tile's oh2 is clamped at the gene end (stop codon in oh2 zone)
- `search_oh_R()` scans the downstream cassette at **1-nt resolution** to find a better oh2
- Scoring: P_fid × P_eff with OOGGA identity check vs alien OHs
- If found, extends the last tile into the cassette — invariant cassette nt on every oligo
- Pushes the stop codon into the tile interior (geometrically mutable, excluded by experimental choice)
- Graceful degradation: returns NULL if no valid candidate → behavior unchanged

**Phase 4** — Per-reaction pairwise validation:
- Compute set fidelity for each BsaI and BsmBI reaction
- Warn if any reaction falls below 0.80 set fidelity (hardcoded threshold in QC checks)

Returns `assembly_plan` with tiles, oh3, oh4, oh_R_result, full_seq, superblocks, reaction fidelity.

#### `search_oh_R()` — Last Tile Cassette Overhang Search

```r
search_oh_R(cassette_seq, last_tile_gene_nt, max_mutable_nt,
            oh_fidelity, eff_lookup, alien_ohs, max_identity, min_clearance_nt)
```

Slides a 4-nt window through the cassette at 1-nt steps. Unlike gene boundaries (codon-locked), cassette positions are at any offset — giving 10-100× more candidates.

Constraints:
- **Min clearance** (default 5 nt): ensures stop codon has ≥1 nt gap from oh2 zone
- **Max prefix** = `max_mutable_nt + 8 - last_tile_gene_nt`: oligo length budget
- **Hard filters**: palindromes, homopolymers, OOGGA identity vs aliens

**Things to verify:**
- `compute_set_fidelity()` computes the Potapov 2018 metric: `set_fidelity = product of per-overhang fidelities`, where each `f(X) = M[X,X] / sum(M[X,Y] for Y in set)`.
- The constrained-first ordering means oh3 never needs to check against oh2, and oh4 never needs to check against oh1 — downstream phases avoid them.
- oh_R reconstruction: cassette nt on oligo + remaining cassette in gene block = full core cassette (verified by GG simulator).

---

## 10. Barcode Design

### `07_barcode_design.R` — Unified hierarchical prefix-suffix barcodes

**File**: `R/07_barcode_design.R` (~1255 lines)

### `07b_linear_codes.R` — GF(4) Hamming code construction

**File**: `R/07b_linear_codes.R` (542 lines)

#### `auto_size_barcode_length()` — Automatic Length Sizing

When `barcode_length = "auto"` in config, this function (called at Step 5.5 in the pipeline, after variant count is known) iterates suffix lengths from 0 to 18, checking that `4^suffix_length * filter_pass_rate >= barcodes_per_variant * 2` (2x safety margin). Returns the smallest barcode_length (prefix + suffix) that satisfies capacity. Max 30 nt, min 6 nt.

#### Architecture

```
barcode = prefix (p nt) + suffix (L-p nt)
```

- One unique **prefix** per variant — carries the Hamming distance guarantee
- Each variant's `barcodes_per_variant` barcodes share the same prefix, different random suffixes
- Cross-variant pairs: d(full barcode) ≥ d(prefix) ≥ min_hamming (guaranteed)
- Within-variant pairs: d(full) = d(suffix) = random (OK — same variant, doesn't matter)

#### `design_barcodes()` — Main Entry Point

Flow:
1. Auto-size barcode_length if `"auto"`
2. Check prefix feasibility + auto-adjust min_hamming if needed
3. Generate `n_variants` unique prefixes via algebraic code or lexicode
4. Generate barcodes: vectorized batch suffix generation
5. Skip prefix distance validation for algebraically-guaranteed codes
6. Compute per-barcode nearest-neighbor Hamming distance

#### Prefix Generation Strategy

Ordered by priority:

##### Path 1: GF(4) Shortened Hamming Code (d ≤ 3)

Implemented in `07b_linear_codes.R`. This is the primary path for the default `min_hamming = 3`.

**Key insight**: A linear code over GF(4) = {A, C, G, T} with minimum distance d = 3 guarantees that ANY two codewords differ in at least 3 positions. This is an algebraic guarantee — no pairwise distance checking needed.

The construction:
1. Build a parity-check matrix H for Ham_4(m) — the quaternary Hamming code
2. Derive the generator matrix G from H using Gaussian elimination over GF(4)
3. If `prefix_length` < native code length, shorten the code
4. Enumerate all 4^k codewords (for k ≤ 12) or sample (for k > 12)

**GF(4) arithmetic**: The Galois field GF(4) = GF(2²) has elements {0, 1, α, α²} where α² + α + 1 = 0. Addition is XOR of 2-bit representations; multiplication uses lookup tables.

DNA mapping: 0 → A, 1 → C, α → G, α² → T

**Code capacity**: For prefix_length = 12, the shortened code [12, 9, ≥3]₄ gives 4⁹ = 262,144 codewords. After biological filtering (~50% pass rate), ~131K prefixes — more than enough for any DMS gene.

##### Path 2: DNABarcodes Lexicode (d ≥ 4)

Falls back to `DNABarcodes::create.dnabarcodes()` for larger minimum distances. Uses Conway heuristic first, then Ashlock as fallback.

#### Suffix Generation — Vectorized Batch Approach

```r
generate_barcodes_per_prefix <- function(prefixes, suffix_length, barcodes_per_variant, ...)
```

Two-pass approach:
1. **Pass 1 (batch)**: Generate all suffix candidates at once in a matrix, paste with prefixes, apply filters (enzyme sites, homopolymers, GC, PolIII terminator, junction context)
2. **Pass 2 (retry)**: For any variants that didn't get enough barcodes in Pass 1, generate more suffixes per-variant

The batch approach generates `n_variants × oversample_factor` suffixes in one shot:

```r
suf_mat <- matrix(sample(bases, suffix_length * n_total_candidates, replace = TRUE),
                  nrow = n_total_candidates, ncol = suffix_length)
all_suffixes <- do.call(paste0, as.data.frame(suf_mat))
```

#### Fast Filtering — `filter_sequences_fast()`

This was a critical performance optimization. The original `has_enzyme_sites()` function (via `find_enzyme_sites()`) took 156s for 65K sequences. The fast version uses vectorized `grepl()` with `fixed = TRUE`:

```r
filter_sequences_fast <- function(seqs, max_homopolymer, ...) {
  # Enzyme site check — vectorized grepl, not per-sequence find_enzyme_sites()
  for (enz_name in c("BsaI", "BsmBI", "PaqCI")) {
    enz <- ENZYMES[[enz_name]]
    keep <- keep & !grepl(enz$recog, seqs, fixed = TRUE)
    keep <- keep & !grepl(enz$recog_rc, seqs, fixed = TRUE)
  }
  # Homopolymer check
  pattern <- paste0("([ACGT])\\1{", max_homopolymer, ",}")
  keep <- keep & !grepl(pattern, seqs)
  # PolIII terminator
  keep <- keep & !grepl(POLIII_TERM_SEQ, seqs, fixed = TRUE)
  seqs[keep]
}
```

This reduces filtering from ~156s to <0.1s.

#### Enhanced Barcode Filters (opt-in)

Five additional filters beyond the standard set, all defaulting to off:

| Config flag | Filter | Rationale |
|-------------|--------|-----------|
| `filter_ggc` | GGC motif | Illumina sequencing error hotspot — systematic miscalls at GGC contexts |
| `filter_hairpin` | Hairpin stems > N bp | Self-complementary stems cause oligo folding, reducing capture efficiency |
| `filter_dinuc_repeats` | Dinucleotide repeats > N units | Polymerase slippage during PCR or sequencing (e.g., ATATAT) |
| `filter_polyg` | Poly-G runs > N | Two-color Illumina chemistry (NovaSeq, NextSeq) reads poly-G as no-signal |
| `filter_tm_uniformity` | Tm deviation > N°C from median | Uniform Tm ensures even hybridization kinetics across barcodes |

Each has a vectorized helper (e.g., `has_ggc_motif_vec()`, `has_hairpin_vec()`, `nn_tm_vec()`) and is wired into `filter_sequences_fast()`. The Tm calculation uses nearest-neighbor thermodynamics (SantaLucia 1998).

#### Capacity Estimation

```r
estimate_prefix_capacity <- function(prefix_length, min_hamming, filter_pass_rate = 0.50)
```

Uses the sphere-packing (Hamming) bound: `max_prefixes = 4^k / V(k, t)` where `V(k, t) = Σ choose(k,i)·3^i` is the Hamming ball volume.

`check_prefix_feasibility()` auto-reduces `min_hamming` down to a floor of 2 if capacity is tight, warning the user at each reduction.

**Things to verify:**
- The `filter_pass_rate = 0.50` estimate is conservative. Actual pass rates depend on barcode length, GC constraints, and enzyme site density.
- The GF(4) code construction in `07b_linear_codes.R` correctly implements Gaussian elimination over a non-prime field. The key operations (multiplication via lookup table, addition via XOR) are correct for GF(2²).

---

## 11. Oligo Assembly

### `08_oligo_assembly.R` — Universal oligo construction

**File**: `R/08_oligo_assembly.R` (~185 lines)

This module is remarkably concise — the simplicity is a direct benefit of the universal oligo architecture (no tile-type-specific logic).

#### `assemble_oligos(variants, cds, barcodes, tiles, oh3, oh4, max_oligo_length, full_seq, pcr_handles)` — Vectorized by Tile

- `full_seq` (gene + core cassette): needed when the last tile extends past the gene end via oh_R cassette extension. When NULL (backward compatible), uses `cds` only.
- `pcr_handles`: optional list of per-tile `list(fwd, rev)` pairs. Handles are prepended/appended outside the BsaI sites. When NULL, empty strings are used (zero-cost backward compat).

The function pre-computes invariant elements once, then loops over tiles with vectorized operations:

```r
# Pre-compute invariant enzyme site strings (constant for ALL oligos)
bsai_5prime <- paste0(ENZYMES$BsaI$recog,
                      paste(rep("A", ENZYMES$BsaI$spacer_len), collapse = ""))  # "GGTCTCA"
bsmbi_oh3_str <- orient_enzyme_site("BsmBI", oh3, "forward")                   # "CGTCTCA" + oh3
bsai_oh4_str <- orient_enzyme_site("BsaI", oh4, "reverse")                     # RC of "GGTCTCA" + RC(oh4)
```

For each tile:
```r
# Use full_seq when tile extends past gene end (oh_R cassette extension)
source <- if (tiles$end_nt[t] > gene_len && !is.null(full_seq)) full_seq else cds
wt_tile_seqs[t] <- substring(source, tiles$start_nt[t], tiles$end_nt[t])

# Local mutation within the ~230nt tile (NOT full CDS rebuild)
cs <- (variants$position[idx] - 1L) * 3L + 1L - t_start + 1L

mutant_tiles <- paste0(
  substring(wt_tile, 1L, cs - 1L),         # before mutation
  variants$mut_codon[idx],                   # mutant codon
  substring(wt_tile, cs + 3L)               # after mutation
)

# Extract mutable region (strip oh1=4nt front, oh2=4nt back)
mutable_regions <- substring(mutant_tiles, 5L, t_len - 4L)
```

For the last tile with oh_R extension, the tile includes invariant cassette nucleotides between the stop codon and the oh2 zone. These appear on every oligo — mutations only happen at gene codon positions.

The vectorized assembly includes PCR handles when provided:
```r
sequences[idx] <- paste0(
  fwd_handles[tid],      # "" when pcr_handles is NULL
  bsai_5prime, tile_oh1[tid], mutable_regions,
  tile_oh2_rev[tid], bsmbi_oh3_str,
  barcodes[idx], bsai_oh4_str,
  rev_handles[tid]       # "" when pcr_handles is NULL
)
```

**PCR handle mechanics**: Handles flank the oligo outside BsaI sites. During BsaI digestion, handles become waste fragments (cut away from the productive insert). This enables tile-specific PCR amplification from a pooled oligo order — each tile gets a unique primer pair. The handle length eats into the 300 nt Twist budget, reducing the mutable region. Handle pairs are specified via a CSV file (`fwd,rev` columns) referenced in config.

**Performance**: Vectorized approach completes in 0.8-2.5s even for large genes (60K+ oligos).

**Key insight**: `substring()` in R recycles scalar arguments when applied to a vector. So `substring(wt_tile, 1L, cs - 1L)` where `wt_tile` is a scalar and `cs` is a vector produces a vector of results — this is what enables the vectorization.

---

## 12. WT Gene Block Design

### `09_wt_geneblock_design.R` — BsaI/BsmBI gene blocks

**File**: `R/09_wt_geneblock_design.R` (~1423 lines)

This module designs the WT gene blocks that pair with oligos in Golden Gate reactions. All blocks include configurable flanking pads outside enzyme sites for efficient Type IIs cleavage at linear termini.

#### `flag_borderline_overhangs()` — Near-Miss Detection

Called at Step 9c in the pipeline (after gene block design and reaction fidelity recomputation). Checks all overhang pairs within each reaction for pairs at exactly `max_identity` threshold (e.g., 2/4 positional matches). These are technically allowed by OOGGA but represent the weakest permissible pairs. Both direct and RC identity are checked. Returns a data frame of flagged pairs for inclusion in the assembly report.

#### Block Types

For each tile, two reactions use different enzyme systems:

1. **BsaI reaction (Level 1)**: Inserts the oligo + 5'WT gene block into the helper plasmid
   - `bsai_block`: 5'WT segment flanked by BsaI sites (PaqCI** → gene 5'WT → oh1)

2. **BsmBI reaction (Level 1b)**: Inserts 3'WT + downstream cassette between the tile and barcode
   - `bsmbi_block`: 3'WT + downstream cassette flanked by BsmBI sites (oh2 → gene 3'WT + cassette → oh3)

#### `design_wt_geneblocks()` — Main Entry Point

For each tile:
1. Compute 5'WT block: gene sequence from PaqCI site to tile start (with BsaI flanking sites)
2. Compute 3'WT block: gene sequence from tile end through downstream cassette (with BsmBI flanking sites)
3. For the last tile with oh_R extension: trim the cassette prefix that's already on the oligo. The gene block contains only the *remaining* cassette after the oh_R position.
4. Check if blocks exceed synthesis limits; if so, trigger superblock splitting
5. Design the helper plasmid (holds the BsaI and PaqCI sites)
6. Build per-tile manifests (which blocks go in which reactions)

**oh_R cassette trimming**: When the last tile extends `cassette_on_oligo` nt into the cassette, the gene block's content is `substring(polIII_for_block, cassette_on_oligo + 1)`. Pre-computed cassette split positions are also adjusted by `-cassette_on_oligo`. After BsmBI ligation, the oligo's cassette prefix + gene block's remaining cassette = full core cassette (seamless reconstruction).

#### Flanking Pads

Gene blocks include flanking DNA outside the enzyme recognition sites:

```
pad + BsaI_fwd + [gene content] + BsaI_rev + pad    (BsaI blocks)
pad + BsmBI_fwd + [gene content] + BsmBI_rev + pad   (BsmBI blocks)
```

Default pad: `"TGCATG"` (6 nt). Configurable via `geneblock_flanking_pad` in config. NEB recommends >=6 bp flanking for efficient Type IIs cleavage at linear fragment termini — the enzyme needs extra DNA to "grip onto" near the ends of linear dsDNA. The pad overhead (2 x pad length) is counted in block length calculations to stay within synthesis limits.

#### Superblock Splitting

When a gene block exceeds `MAX_GENEBLOCK_LENGTH` (1800 bp), it's split into sub-blocks connected by BsmBI junction overhangs:

```
Original: oh_5 ——— [long sequence] ——— oh_3

Split:    oh_5 — [sub1] — SB_oh1 | SB_oh1 — [sub2] — SB_oh2 | SB_oh2 — [sub3] — oh_3
```

Split points are chosen at positions where the gene sequence provides high-fidelity BsmBI overhangs (using the same scoring formula as tile boundary search).

#### Cassette Splitting

For very long downstream cassettes (intergene elements + PolIII > ~1700 nt), the cassette itself is split across multiple BsmBI-connected sub-blocks. The function `find_cassette_split_points()` selects split positions within the cassette where junction overhangs have high fidelity and don't collide with existing overhangs.

#### Helper Plasmid Design

The helper plasmid is a shared backbone for all Level 1 (BsaI) reactions:

```
PaqCI_fwd — [stuffer] — BsaI_oh4_fwd — [cloning region] — BsaI_oh_L_rev — [stuffer] — PaqCI_rev
```

It contains:
- PaqCI sites at the outer edges (for Level 2 transfer to the destination backbone)
- BsaI sites (oh4 and oh_L) defining the cloning region where the oligo + 5'WT block inserts

**Things to verify:**
- Gene blocks include the correct enzyme site orientations: BsaI_fwd and BsaI_rev for bsai_blocks; BsmBI_fwd and BsmBI_rev for bsmbi_blocks.
- Superblock junction overhangs are checked for collision with tile boundary overhangs AND with each other (no two SB junctions in the same reaction should share an overhang or its RC).
- The helper plasmid uses "N" padding in the stuffer regions — the report output filters these for enzyme site checking.

---

## 13. QC Checks

### `10_qc_checks.R` — 17 validation checks

**File**: `R/10_qc_checks.R` (501 lines)

#### `run_qc_checks()` → list with qc_pass (logical) and qc_report (data frame)

| # | Check | What it validates |
|---|-------|-------------------|
| 1 | `oligo_lengths` | All oligos ≤ max_oligo_length (300 nt) |
| 2 | `block_lengths` | All gene blocks ≤ max_geneblock_length (1800 nt) |
| 3 | `barcode_junction_sites` | No enzyme sites at barcode-context junctions |
| 4 | `barcode_uniqueness` | All barcodes are unique |
| 5 | `tile_coverage` | Tiles cover entire gene without gaps (clamped to gene_len for oh_R extension) |
| 6 | `variant_count` | Expected number of variants generated |
| 7 | `single_codon_change` | Each non-control variant differs by exactly one codon from WT |
| 8 | `oligo_gc_content` | Oligo GC content within 25-75% |
| 9 | `domestication_complete` | Gene domesticated for all 3 enzymes |
| 10 | `overhang_fidelity` | Tile boundary overhangs have adequate fidelity (≥0.80) |
| 11 | `tile_manifests` | Per-tile assembly manifests complete |
| 12 | `helper_plasmid` | Helper plasmid free of unintended BsmBI sites |
| 13 | `reaction_fidelity` | Per-reaction set-level overhang fidelity (≥0.80) |
| 14 | `barcode_poliii_term` | No barcodes contain PolIII terminator signal (TTTT) |
| 14b | `barcode_ggc_motif` | No barcodes contain GGC motif (opt-in) |
| 14c | `barcode_hairpins` | No barcodes have hairpin stems > threshold (opt-in) |
| 14d | `barcode_dinuc_repeats` | No barcodes have dinucleotide repeats > threshold (opt-in) |
| 14e | `barcode_polyg` | No barcodes have poly-G runs > threshold (opt-in) |
| 14f | `barcode_tm_uniformity` | All barcodes within Tm tolerance of median (opt-in) / Tm distribution (informational) |
| 15 | `block_min_length` | All gene blocks above synthesis minimum (300 nt) |
| 16 | `cassette_fragment_lengths` | Cassette fragments within synthesis limits |
| 17 | `sb_overhang_collisions` | Superblock boundary overhangs are unique |
| 18 | `pcr_handle_enzyme_sites` | PCR handles free of enzyme recognition sites (when handles provided) |

**Check 3 (barcode junction sites)** is particularly important — it catches the case where enzyme recognition sequences span the junction between the flanking enzyme site and the barcode itself. The check constructs the full junction context (6 nt left + barcode + 6 nt right) and scans for sites.

**Check 6 (variant count)** dynamically computes the expected count based on variant types present:
```r
expected_total <- n_positions_present * 20L + n_wt_ctrl + n_syn
```
This accounts for WT controls (1 per position) and optional synonymous variants.

**Check 7 (single codon change)** excludes WT controls (their codon IS the WT codon by design) and verifies that the recorded `wt_codon` matches the actual gene codon at that position.

**Things to verify:**
- Check 10 uses an internal fidelity threshold of 0.80 (hardcoded inline in `10_qc_checks.R`). This flags truly problematic overhangs rather than just non-ideal ones. The former `SET_FIDELITY_WARNING_THRESHOLD` constant was removed from `constants.R`.
- Check 13 (reaction fidelity) uses a minimum threshold of 0.80 for the entire SET fidelity (product of per-overhang fidelities), hardcoded inline in `10_qc_checks.R`. This is reasonable -- even with 6 overhangs in a reaction, each would need ~0.97 individual fidelity for the set to be >=0.80.

---

## 14. Output

### `11_output.R` — CSV/FASTA file writer

**File**: `R/11_output.R` (203 lines)

#### `write_outputs()` → list of file paths

Writes up to 11 output files:

| # | File | Contents |
|---|------|----------|
| 1 | `{gene}_oligo_pool.csv` | oligo_name, sequence, length, variant_id, tile_id |
| 2 | `{gene}_geneblock_order.csv` | block_name, sequence, length, block_type, ... |
| 3 | `{gene}_variant_barcode_map.csv` | variant_id, position, wt/mut aa/codon, variant_type, barcode, tile_id |
| 4 | `{gene}_tile_manifests.csv` | Per-tile BsaI and BsmBI reaction contents |
| 5 | `{gene}_helper_plasmid.csv` | Helper plasmid sequence |
| 6 | `{gene}_qc_report.csv` | QC check results |
| 7 | `{gene}_oligo_pool.fasta` | Oligo sequences in FASTA format |
| 8 | `{gene}_geneblock_order.fasta` | Gene block sequences in FASTA format |
| 9 | `{gene}_sequences.fasta` | Original CDS, domesticated CDS, protein |
| 10 | `{gene}_skipped_variants.csv` | Gene-edge variants skipped due to oh overlap |
| 11 | `{gene}_pcr_primer_table.csv` | Per-tile PCR primer pairs (fwd/rev handles) — only written when PCR handles are configured |

The sequences FASTA (#9) includes a domestication mutation count in the header — useful for traceability.

All CSV files use `readr::write_csv()` for consistent formatting.

---

## 15. Report

### `12_report.R` — Wetlab-compatible Markdown assembly report

**File**: `R/12_report.R` (~1045 lines)

#### `generate_report()` → path to report file

Generates a bench-ready Markdown report with 11 sections:

1. **Gene Summary** — dimensions, domestication stats
2. **Assembly Architecture** — 3-enzyme strategy diagram
3. **Oligo Pool Summary** — counts, length stats
4. **Barcode Design** — method, distances, capacity
5. **QC Summary** — pass/fail table
6. **Reaction Fidelity** — per-reaction set fidelity scores
7. **Fixed Overhangs & Helper Plasmid** — oh3, oh4, PaqCI overhangs
8. **Per-Tile Assembly Guide** — for each tile: which blocks, which reactions, overhang map
9. **PaqCI Level 2 Reaction** — final cloning step
10. **Gene Block Order Sheet** — ready for synthesis ordering
11. **Domestication Log** — all silent mutations applied

The per-tile guide (#8) is the most operationally useful section — it tells a lab technician exactly which components go into each reaction.

---

## 16. GG Simulator

### `13_gg_simulator.R` — In-silico assembly verification

**File**: `R/13_gg_simulator.R` (~795 lines)

#### Purpose

Simulates the actual Golden Gate assembly process in silico to verify that designed oligos and gene blocks assemble correctly. This is the ultimate end-to-end validation.

#### Key Functions

| Function | What it does |
|----------|-------------|
| `digest_linear(seq, enzyme)` | Simulates Type IIS restriction digestion |
| `mark_terminal_waste()` | Marks first/last fragments as waste (no overhang) |
| `mark_stuffer_waste()` | Marks internal stuffer fragments |
| `ligate_fragments()` | Assembles fragments by matching complementary overhangs |
| `simulate_tile_assembly()` | Full BsaI + BsmBI simulation for one tile |
| `verify_assembly_product()` | Checks product matches expected gene + barcode |
| `simulate_pipeline_assembly()` | Orchestrates simulation over all tiles |

#### How Digestion Works

For a forward (+) site at position `s`:
```
top_cut = s + recog_len + cut_fwd - 1
overhang = substring(seq, top_cut + 1, top_cut + oh_len)
```

For a reverse (-) site at position `s` (RC match on top strand):
```
top_cut = s - 1 - cut_rev
overhang = substring(seq, top_cut + 1, top_cut + oh_len)
```

Fragments are ordered by cut position. Each fragment has a `oh_5` (5' overhang, from the cut that produced its left end) and `oh_3` (3' overhang, from the cut that produced its right end). Terminal fragments have `NA` for their outer overhang.

#### Ligation

Fragments are assembled by matching complementary overhangs:

```
Fragment A: ...body_A—oh_3="GGTA"
Fragment B: oh_5="GGTA"—body_B...
→ Joined: ...body_A—GGTA—body_B...
```

The algorithm starts with the fragment that has `oh_5 = NA` (the left-terminal fragment after waste removal), then iteratively finds the fragment whose `oh_5` matches the current last fragment's `oh_3`.

#### Targeted Junctional Sampling

Instead of random variant sampling, `simulate_pipeline_assembly()` can preferentially select variants near tile boundaries (where assembly errors are most likely). When `targeted_sampling = TRUE`, the sampler picks variants whose mutant codon is close to oh1 or oh2 zones.

#### Strict Nucleotide-Level Verification

When `strict_verification = TRUE`, the simulator performs nucleotide-exact product checking beyond the coarse grep-based checks:

| Check | What it verifies |
|-------|-----------------|
| `exact_match` | Full assembled product matches expected sequence nucleotide-by-nucleotide |
| `correct_length` | Product length equals expected |
| `no_internal_enzyme_sites` | No BsaI/BsmBI/PaqCI sites in the assembled insert |
| `paqci_flanks_present` | PaqCI overhangs at expected positions for Level 2 cloning |
| `no_duplications` | No duplicated segments from incorrect ligation |
| `first_mismatch_pos` | Position of first nucleotide difference (for debugging) |

This catches off-by-one errors in overhang geometry that coarse verification (has_mut_gene, has_polIII, has_barcode) would miss. When PCR handles are present, they're stripped before verification (they're waste after BsaI digestion).

---

## 17. Pipeline Orchestration

### `run_pipeline.R` — Master entry point

**File**: `run_pipeline.R` (607 lines)

Usage: `Rscript run_pipeline.R config.yaml`

The pipeline runs 12+ steps with timing instrumentation:

| Step | Function | Typical Time (GRIN2A, 1464 codons) |
|------|----------|-------------------------------------|
| 1 | `load_config()` | <0.1s |
| 2 | `read_gene()` | <0.1s |
| 3 | `load_codon_usage()` | <0.1s |
| 4 | `scan_enzyme_sites()` + `apply_domestication()` | <1s |
| 5 | `design_mutations()` + `check_and_fix_new_sites()` | ~100s |
| 5.5 | `auto_size_barcode_length()` (if "auto") | <0.1s |
| 6 | `plan_assembly()` + `assign_variants_to_tiles()` | ~5-20s |
| 7 | `design_barcodes()` | ~138s |
| 8 | `assemble_oligos()` | ~0.8s |
| 9 | `design_wt_geneblocks()` | <1s |
| 9b | Recompute reaction fidelity | <0.1s |
| 9c | `flag_borderline_overhangs()` | <0.1s |
| 10 | `run_qc_checks()` | <1s |
| 10b | `simulate_pipeline_assembly()` | <5s |
| 11 | `write_outputs()` | ~2s |
| 12 | `generate_report()` | <1s |

**Total for GRIN2A**: ~278s (~4.6 min)

#### Module Sourcing

All modules are sourced in dependency order:

```r
source(file.path(pipeline_dir, "R", "constants.R"))
source(file.path(pipeline_dir, "R", "utils.R"))
source(file.path(pipeline_dir, "R", "00_config.R"))
# ... through 13_gg_simulator.R
```

The `%||%` null-coalescing operator is defined early (both in `utils.R` and defensively in `run_pipeline.R`) because it's used throughout.

#### Variant Expansion for Multi-Barcode Support

After barcode generation (step 7), if `barcodes_per_variant > 1`, the variants data frame is expanded:

```r
variants_expanded <- variants[rep(seq_len(nrow(variants)), each = cfg$barcodes_per_variant), ]
variants_expanded$barcode_idx <- rep(seq_len(cfg$barcodes_per_variant), times = nrow(variants))
```

Each row in `variants_expanded` corresponds to one oligo (one variant × one barcode replicate).

#### Gene-Edge Variant Filtering

After tile assignment, variants with `overhang_note == "partial_oh_overlap"` are removed:

```r
skipped_mask <- !is.na(variants$overhang_note) & variants$overhang_note == "partial_oh_overlap"
skipped_variants <- variants[skipped_mask, , drop = FALSE]
if (nrow(skipped_variants) > 0L) {
  skipped_variants$skip_reason <- "partial_oh_overlap: ..."
}
variants <- variants[!skipped_mask, ]
```

These are saved to a separate output file (`_skipped_variants.csv`) for reference.

#### Junction Context for Barcode Filtering

Before barcode generation, the pipeline computes the actual DNA context flanking each barcode in the oligo:

```r
bsmbi_fwd_oh3_seq <- orient_enzyme_site("BsmBI", oh3, "forward")
bsai_rev_oh4_seq <- orient_enzyme_site("BsaI", oh4, "reverse")
junction_left_context <- substring(bsmbi_fwd_oh3_seq, nchar(bsmbi_fwd_oh3_seq) - 5L, ...)
junction_right_context <- substring(bsai_rev_oh4_seq, 1L, 6L)
```

These 6-nt contexts are passed to `design_barcodes()` so that barcodes creating enzyme sites at the junction boundaries are filtered out.

#### Step 9b: Reaction Fidelity Recomputation

After gene blocks are designed, the reaction fidelity is recomputed from actual block overhangs (not from the pre-computed SB boundaries which may include phantom overhangs from filtered split points).

#### Step 9c: Borderline Overhang Flagging

After fidelity recomputation, `flag_borderline_overhangs()` (from `09_wt_geneblock_design.R`) scans all per-reaction overhang pairs for near-misses at exactly the `max_identity` threshold. Flagged pairs are included in the assembly report as advisory warnings.

---

## Cross-Cutting Concerns

### Performance Bottlenecks

The two main bottlenecks are:

1. **Step 5 — Mutation site checking** (~100-244s): `check_and_fix_new_sites()` calls `has_enzyme_sites()` per variant. Each call does `find_enzyme_sites()` with string-scanning loops. Potential optimization: batch the window extractions and use vectorized `grepl()`.

2. **Step 7 — Barcode generation** (~138-343s): The GF(4) linear code prefix generation is fast, but suffix generation + batch filtering for large genes (>60K variants × 10 barcodes × 20× oversampling = 12M candidates) takes time.

### Error Handling Strategy

The pipeline uses a fail-fast approach:
- `stop()` for fatal errors (invalid config, insufficient barcode capacity)
- `cli::cli_warn()` for warnings that should be reviewed (enzyme sites in promoter, low-fidelity overhangs)
- `cli::cli_alert_*()` for informational progress messages

### Testing

Tests are in `tests/testthat/` with **346 test blocks** containing **~1,053 assertions** (0 failures):
- **Unit tests**: Per-function tests with known inputs/outputs
- **Integration tests**: Full pipeline on test genes (300 nt, 2100 nt)
- **OOGGA DP tests**: `test-oogga-dp.R` — collision-aware boundary selection, two-OH SB model, beam search
- **GG simulator tests**: `test-gg-simulator.R` — in-silico BsaI + BsmBI digestion/ligation verifying full assembly reconstruction
- **oh_R tests**: 7 tests in `test-overhang-selection.R` — cassette search, alien filtering, budget constraints, backward compat
- **AKAP11 benchmark**: Full pipeline on AKAP11 (5706 nt, 1902 codons) — always runs, serves as large-gene stress test

### Known Warnings (not failures)

- **`check_and_fix_new_sites()` warnings** (~20-50 per large gene): "Could not find enzyme-site-free codon for variant X". Fires when a mutant codon creates a BsmBI/PaqCI site and no alternative codon avoids it. Root causes: single-codon AAs (Met/Trp), flanking context completing a partial enzyme site. Inherent to gene sequence, not a pipeline bug.

### Known Open Issues

| Bug | Description | Status |
|-----|-------------|--------|
| BUG-003 | Boundary codon mutations blanket-skipped | Confirmed, fix deferred |
