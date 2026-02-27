# DMS GG Oligo Pipeline — Step-by-Step Walkthrough (GRIN2A Example)

**Date:** 2026-02-27
**Gene:** GRIN2A (NM_000833.5, GluN2A subunit of the NMDA receptor)
**CDS:** 4395 nt, 1465 codons (1464 aa + stop)

This document walks through every stage of the pipeline at three levels:
1. **Conceptual** — what the step does and why
2. **Pseudocode** — the algorithm in plain language
3. **Code** — how it maps to the R source, with concrete GRIN2A numbers

---

## Architecture Overview: 3-Enzyme Golden Gate

The pipeline uses **three restriction enzymes** in a two-level assembly:

| Enzyme | Recognition | Overhang | Level | Role |
|--------|------------|----------|-------|------|
| **BsaI** | `GGTCTC` (6 nt + 1 nt spacer) | 4-nt | Level 1 | Inserts oligo + 5'WT into helper plasmid |
| **BsmBI** | `CGTCTC` (6 nt + 1 nt spacer) | 4-nt | Level 1b | Inserts 3'WT+PolIII between tile and barcode |
| **PaqCI** | `CACCTGC` (7 nt + 4 nt spacer) | 4-nt | Level 2 | Moves complete insert to destination backbone |

### Why 3 enzymes instead of the 2 in CLAUDE.md?

The original plan used BsmBI (Level 1) + PaqCI (Level 2) with tile-type-specific oligo structures (leading/internal/trailing). The current design adds BsaI to create a **universal oligo structure** — every oligo has the same layout regardless of where the tile sits in the gene. This eliminates tile-type branching logic entirely.

**Leading vs. trailing tiles in the 3-enzyme design:** The oligo structure is identical for all tiles. What differs is the **gene blocks**: tile 1 has a shorter (or empty) 5'WT BsaI block and a longer 3'WT BsmBI block; the last tile has a longer 5'WT block and a shorter 3'WT block. The helper plasmid + superblock splitting handle this transparently — the oligo doesn't need to "know" its position in the gene.

### Final assembled construct (per variant):

```
PaqCI**——[5'WT gene]——[mutant tile]——[3'WT gene]——[PolIII promoter]——[barcode]——PaqCI*
         ←——————BsaI Level 1———————→  ←————————BsmBI Level 1b—————→
         ←——————————————————————PaqCI Level 2—————————————————————————→
```

---

## Step 1: Configuration (`R/00_config.R`)

### Conceptual
Parse the YAML config file. Apply defaults. Validate parameter types and ranges. If intergene elements are specified, concatenate them into a `downstream_cassette` that sits between gene and barcode.

### Key GRIN2A parameters
```yaml
gene_fasta: "data/GRIN2A_NM_000833_CDS.fasta"
polIII_promoter: "GAGGGCC...ACACCG"   # 250 nt (U6 + internal T7)
max_oligo_length: 300                   # Twist oligo pool max
max_geneblock_length: 1800              # Gene fragment max
barcode_length: 20                      # 20 nt barcodes
barcode_prefix_length: 12               # 12 nt prefix (Hamming-constrained)
min_hamming_distance: 3                 # Error-correcting Hamming distance
barcodes_per_variant: 10                # 10 replicate barcodes per mutation
boundary_method: "dp"                   # Dynamic programming tile boundaries

# Intergene elements — placed between gene 3' end and PolIII promoter.
# Included by default (WPRE + bGH polyA). Comment out for minimal layout.
intergene_elements:
  - name: "WPRE"
    sequence: "YOUR_WPRE_SEQUENCE_HERE"            # ~590 nt
  - name: "bGH_polyA"
    sequence: "YOUR_BGH_POLYA_SEQUENCE_HERE"        # ~225 nt
```

### Code
`load_config()` parses `yaml::read_yaml(config_path)`, applies defaults via `%||%`, and calls `build_downstream_cassette()` which concatenates `intergene_elements` + PolIII into `downstream_cassette`. With WPRE (~590 nt) + bGH polyA (~225 nt) + PolIII (250 nt) = **~1065 nt** downstream cassette.

**Intergene elements** are validated (non-empty, ACGT-only), uppercased, and concatenated in order. The resulting `downstream_cassette = WPRE + bGH_polyA + polIII_promoter` is used throughout the pipeline (3'WT gene blocks, superblock splitting, etc.). The cassette adds ~815 nt beyond the PolIII-only layout, which means more 3'WT gene blocks will need superblock splitting — this is handled automatically (see Step 6d).

To run **without** intergene elements (PolIII immediately after gene), comment out or delete the `intergene_elements:` section.

---

## Step 2: Gene Input (`R/01_gene_input.R`)

### Conceptual
Read the FASTA, validate it's a proper CDS (divisible by 3, starts with ATG, no internal stops), translate to protein.

### GRIN2A numbers
```
CDS:     ATGGGCAGAGTG...TCTGATGTTTAA   (4395 nt)
Codons:  1465 (including stop)
Protein: MGRVG...SDV* → 1464 aa (stop removed from display)
oh_L:    ATGG  (first 4 nt of CDS — gene-dependent BsaI overhang, fixed for all tiles)

Note: oh_L is always ATG + the 4th nucleotide of the gene. Different genes yield
different oh_L values (ATGA, ATGC, ATGG, ATGT). All have good fidelity:
  ATGA = 0.990 (in HF Set 3!)   ATGC = 0.959   ATGG = 0.946   ATGT = 0.977
```

### Code
```r
gene <- read_gene("data/GRIN2A_NM_000833_CDS.fasta")
# gene$cds      = "ATGGGCAGAGTG...TCTGATGTTTAA"  (4395 nt)
# gene$n_codons = 1465
# gene$protein  = "MGRVG...SDV"  (1464 aa)
```

---

## Step 3: Codon Usage (`R/03_codon_table.R`)

### Conceptual
Load the CoCoPUTs human codon usage table (Alexaki et al. 2019, 119K CDS from GRCh38.p13). This tells us the most-preferred human codon for each amino acid — used for both mutation design and enzyme site domestication.

### Example preferred codons (from CoCoPUTs)
```
Ala → GCC (28.5/1000)    Arg → CGG (11.4/1000)    Leu → CTG (39.6/1000)
Ser → AGC (19.4/1000)    Val → GTG (28.2/1000)    Stop → TGA (most common)
```

### Code
```r
codon_usage <- load_codon_usage(NULL)   # NULL = built-in CoCoPUTs
preferred   <- get_preferred_codons(codon_usage)
# preferred["A"] = "GCC", preferred["R"] = "CGG", preferred["*"] = "TGA", ...
```

---

## Step 4: Enzyme Site Scanning & Domestication (`R/02_enzyme_site_scan.R`)

### Conceptual
Before assembly, the gene must be "domesticated" — any endogenous BsaI (`GGTCTC`), BsmBI (`CGTCTC`), or PaqCI (`CACCTGC`) recognition sites in the gene must be removed via **silent mutations** (synonymous codon changes that preserve the amino acid).

**Critical nuance:** BsaI and BsmBI differ by only 1 nucleotide (`GGTCTC` vs `CGTCTC`). Fixing a BsmBI site can accidentally create a BsaI site and vice versa. The pipeline handles this with **iterative domestication** — after applying fixes, it re-scans for all three enzymes and re-fixes up to 5 iterations.

### Pseudocode
```
FOR each enzyme site found in gene:
    FOR each codon overlapping this site:
        FOR each alternative codon (ranked by frequency):
            IF changing this codon:
                - disrupts the target site, AND
                - doesn't create a new BsaI/BsmBI/PaqCI site:
                    ACCEPT this change
                    BREAK

REPEAT re-scan + re-fix until clean (max 5 iterations)
```

### GRIN2A specifics
GRIN2A (4395 nt) likely has several endogenous BsaI/BsmBI sites (both `GGTCTC` and `CGTCTC` are 6-mers, expected ~1 per 4^6/2 = 2048 nt on both strands). Each is resolved by finding a synonymous codon substitution ranked by CoCoPUTs frequency.

### Code path
```r
scan_result <- scan_enzyme_sites(gene$cds, cfg$polIII_promoter, codon_usage)
# → scan_result$gene_sites: data frame of all BsaI/BsmBI/PaqCI sites found
# → scan_result$domestication: suggested silent mutations

gene$cds <- apply_domestication(gene$cds, scan_result$domestication, codon_usage)
# Iterative: apply fixes → re-scan → re-fix → until clean
```

---

## Step 5: Mutation Design (`R/04_mutation_design.R`)

### Conceptual
For every mutable position in the protein, generate all 20 mutations: 19 amino acid substitutions + 1 stop codon. Each mutation uses the **most preferred human codon** for the target amino acid.

**Positions skipped:**
- Codon 1 (Met/ATG): always falls in the first tile's oh1 overhang → mutation is overridden during assembly
- Codon 1465 (stop/TAA): always falls in the last tile's oh2 overhang → no downstream tile to rescue it

### GRIN2A numbers
```
Mutable positions: 1463 (codons 2 through 1464)
Mutations per position: 20 (19 AA substitutions + 1 stop)
Total variants: 1463 × 20 = 29,260

Example at position 2 (Gly/GGC):
  G2A  → GCC (Ala)     G2C  → TGC (Cys)     G2D  → GAC (Asp)
  G2E  → GAG (Glu)     G2F  → TTC (Phe)     G2H  → CAC (His)
  ...18 more...         G2*  → TGA (Stop)
```

### Planned: Synonymous mutation controls
Standard DMS practice (DIMPLE, Enrich2/VAMP-seq normalization, Findlay 2018, Dunham & Beltrao 2021) includes **1 synonymous codon per position** as an internal positive control. Synonymous variants anchor the "functional" end of the score distribution (median synonymous score = 1, median nonsense = 0). This would increase to **21 variants per position** (19 missense + 1 stop + 1 synonymous), except at Met/Trp positions (single-codon AAs, no synonym exists). The synonymous codon should differ maximally from WT at the nucleotide level to be distinguishable by sequencing — i.e., pick the most-preferred *alternative* codon for the same amino acid. **This feature is not yet implemented but is planned for `04_mutation_design.R`.**

### Post-check: Inadvertent site creation
After designing all mutations, each mutant codon is checked in its sequence context (±14 nt window). If the mutation accidentally creates a new BsaI/BsmBI/PaqCI site, the pipeline swaps to the next-best codon.

### Code
```r
variants <- design_mutations(gene$cds, codon_usage)
# 29,260 rows: variant_id, position, wt_aa, wt_codon, mut_aa, mut_codon

variants <- check_and_fix_new_sites(variants, gene$cds, codon_usage)
# Fixes any variants that would create enzyme sites
```

---

## Step 5.5: Auto-Size Barcode Length

### Conceptual
If `barcode_length: "auto"`, calculate the minimum barcode length needed to encode all variants × barcodes_per_variant with the desired Hamming distance. For GRIN2A with explicit `barcode_length: 20`, this step confirms 20 nt is sufficient.

### GRIN2A numbers
```
Need: 29,260 unique prefixes (one per variant)
Prefix length: 12 nt → 4^12 = 16,777,216 possible sequences
With Hamming d=3, capacity ≈ 16M / V(12,1) ≈ 16M / 37 ≈ 453,000 prefixes
29,260 << 453,000 → easily sufficient
```

---

## Step 6: Assembly Planning (`R/06_overhang_selection.R` — `plan_assembly()`)

This is the most complex step. It integrates tiling, overhang selection, and superblock partitioning into a single planning system.

### Step 6a: Compute Max Tile Size

### Conceptual
Every oligo has a universal structure with fixed-size enzyme sites. The "mutable region" (where the mutation goes) is whatever's left after subtracting all the fixed overhead from 300 nt.

### Oligo anatomy (universal structure)
```
5'─BsaI_fwd──oh1──[    mutable region    ]──BsmBI_rev_oh2──BsmBI_fwd_oh3──barcode──BsaI_rev_oh4─3'
   |  7 nt  | 4nt |      234 nt           |    11 nt     |    11 nt    |  20 nt |   11 nt    |
   |__________|____|_______________________|______________|_____________|________|____________|
                                                                    Total = 298 nt
```

### GRIN2A numbers
```
Fixed overhead:
  BsaI forward:     GGTCTC + A        =  7 nt  (recognition + spacer)
  oh1 (WT flank):   4 nt from gene    =  4 nt  (BsaI overhang, gene-derived)
  BsmBI reverse oh2: RC(CGTCTC+A+oh2) = 11 nt  (recognition + spacer + overhang)
  BsmBI forward oh3: CGTCTC+A+oh3     = 11 nt  (recognition + spacer + overhang)
  Barcode:                              = 20 nt
  BsaI reverse oh4: RC(GGTCTC+A+oh4)  = 11 nt
                                  Total = 64 nt overhead

Max mutable = floor((300 - 64) / 3) × 3 = floor(236/3) × 3 = 78 × 3 = 234 nt
Max mutable codons = 78 codons
```

### Code
```r
tile_size <- compute_max_tile_size(max_oligo_length = 300, barcode_length = 20)
# → 234 nt (78 codons)
```

---

### Step 6b: Dynamic Tile Boundary Search (DP Optimizer)

### Conceptual
The gene is partitioned into tiles of up to 78 codons each. But tile boundaries aren't placed at arbitrary geometric intervals — instead, a **dynamic programming optimizer** searches all possible boundary positions and picks the ones where the gene-derived overhangs (oh1, oh2) at the boundary fall within the **Potapov Table 1 Set 3** high-fidelity overhang set (25 experimentally validated overhangs with 95.8% predicted set fidelity).

**Why this matters:** When BsaI/BsmBI cuts the oligo, the 4-nt overhang is determined by the gene sequence at that position. Not all 4-nt sequences ligate with equal fidelity. By nudging tile boundaries a few codons left or right, we can land on gene positions where the natural sequence happens to be one of the 25 high-fidelity overhangs.

### The 25 HF overhangs (Potapov 2018, Table 1, Set 3)
```
CCTC  CTAA  GACA  GCAC  AATC
GTAA  TGAA  ATTA  CCAG  AGGA
ACAA  TAGA  CGGA  CATA  CAGC
AACG  AAGT  CTCC  AGAT  ACCA
AGTG  GGTA  GCGA  AAAA  ATGA
```

### How tile boundaries create overhangs

At a boundary between tile N and tile N+1 at codon position B:

```
Gene: ...codon B-1 | codon B | codon B+1 | codon B+2...
                         ↓ boundary here
                    ────XXXX────
                        ↑↑↑↑
                   oh2 = oh1 (SAME 4 nt!)

Tile N includes:   ────[mutable region]────XXXX    (oh2 = last 4 nt)
Tile N+1 includes:                         XXXX────[mutable region]────  (oh1 = first 4 nt)
```

**Critical:** oh1 and oh2 at a boundary are the **same 4 nucleotides** — they are one
sequence read from one position in the gene. oh2 is used in the BsmBI reaction
(connecting tile to 3'WT), and oh1 is used in the BsaI reaction (connecting 5'WT
to the next tile). Both tiles overlap at these 4 nt, which is how the assembly
reconstructs the continuous gene sequence without gaps or insertions.

### OOGGA-style scoring
Each candidate boundary position is scored using the **OOGGA formula** (Mukundan & Madhusudhan 2025):

```
score(oh) = P_fid(oh) × P_eff(oh) × (1 + 0.5 × in_HF)
```

Where:
- `P_fid` = individual fidelity from Potapov 256×256 matrix
- `P_eff` = relative ligation efficiency (diagonal / max diagonal)
- `in_HF` = 1 if overhang is in Potapov Table 1 Set 3 (gives 1.5× bonus)

### DP algorithm pseudocode
```
PRECOMPUTE scores for all n_codons boundary positions:
    FOR each codon b in 1..n_codons-1:
        oh2 = gene[b*3-3 : b*3]     (last 4 nt ending at codon b)
        oh1 = gene[b*3+1 : b*3+4]   (first 4 nt starting after codon b)
        score[b] = oogga(oh1) + oogga(oh2) + pairwise_bonus(oh1, oh_L) + penalty

DP to find K boundaries maximizing total score:
    FOR K in [K_min .. K_max]:                  # try multiple tile counts
        dp[k][b] = max over predecessors b' of:
            dp[k-1][b'] + score[b]
            subject to: min_codons <= b - b' <= max_codons
        best_K = K that maximizes total_score / K    # best average quality

BACKTRACK to recover boundary positions
BUILD tiles data frame with oh1, oh2, fidelity, HF membership
```

### Why not optimize for full set fidelity directly?

Set fidelity (the probability of all ligations succeeding in a one-pot reaction) depends on ALL overhangs simultaneously — adding a new overhang changes the fidelity of every existing one. This violates the DP optimal substructure assumption: choosing boundary k's overhang affects the score of boundaries k+2, k+3, etc. True global set fidelity optimization would require simulated annealing or branch-and-bound (which is what NEB's GetSet algorithm uses for the Potapov Table 1 sets).

The pipeline's approach is pragmatic: each tile's BsaI reaction only has ~3-5 overhangs (oh_L, oh1, oh4, plus 0-2 superblock junctions). With so few overhangs, individual OOGGA scores + pairwise bonus are excellent proxies for set fidelity. Phase 6 computes actual set fidelity post-hoc and reports it.

### GRIN2A numbers
```
Gene: 1465 codons, max tile = 78 codons (with 4-codon overlap, effective = 74)
Ideal K = ceil(1465/74) - 1 = 19 boundaries → 20 tiles
DP searches K in [17..21], picks best average overhang quality

Each boundary yields an oh1 and oh2 pair from the gene sequence.
Goal: maximize the number of boundaries where BOTH oh1 and oh2
are in the Potapov HF set (25 options out of 256 possible).
```

### Code
```r
tiles <- search_tile_boundaries_dp(
    cds = gene$cds,
    max_mutable_nt = 234,        # 78 codons × 3
    hf_set = POTAPOV_TABLE1_SET3_25,
    oh_fidelity = builtin_overhang_fidelity(),
    bsai_matrix = load_pairwise_matrix("BsaI"),
    multi_k = TRUE,              # try K-2..K+2
    overlap_codons = 4,
    eff_lookup = compute_overhang_efficiency(potapov_matrix)
)
```

---

### Step 6c: Fixed Overhang Selection (oh3 and oh4)

### Conceptual
Two overhangs are "fixed" — the same across all tiles:
- **oh3:** BsmBI overhang at the PolIII→barcode junction (connects the 3'WT+PolIII block to the barcode on the oligo)
- **oh4:** BsaI overhang at the barcode→helper plasmid junction (connects the oligo to the helper plasmid backbone)

**oh3 is derived from the PolIII promoter's terminal sequence.** The last 5 nt of the PolIII (`CACCG`) encode:
- oh3 = `CACC` (4-nt overhang)
- spacer = `G` (1 nt, used by BsmBI for recognition)

This means the BsmBI junction seamlessly reconstructs the promoter–barcode boundary with no extra sequence.

**oh4 is auto-selected** from the HF set, avoiding collisions with gene-derived overhangs.

### GRIN2A numbers
```
PolIII promoter: ...GAAACACCG  (250 nt total)
                      ||||  |
                      oh3   spacer
                      CACC   G

oh3 = CACC (PolIII-derived, fidelity ≈ 0.969)
oh4 = auto-selected from Potapov HF set (e.g., CTAA, fidelity = 0.984)
oh_L = ATGG (gene 5' end, fixed)
```

### Constraint: oh3 and oh4 must not collide with any gene-derived overhang (oh1, oh2 at any tile boundary), and must not be reverse complements of each other.

**Important wetlab note:** oh4 is auto-selected by the pipeline from the HF set, but the **helper plasmid must be built with matching oh4**. The pipeline outputs the helper plasmid insert sequence (including oh4) in `GRIN2A_helper_plasmid.csv`. When ordering or cloning the helper plasmid, ensure its BsaI site produces the same oh4 overhang that the pipeline selected. If you re-run the pipeline with different parameters, oh4 may change — always use the helper plasmid insert from the same pipeline run as the oligo pool.

---

### Step 6d: Tile-Boundary Superblock Partitioning

### Conceptual
For long genes like GRIN2A, the WT gene blocks flanking the oligos can exceed the 1800-nt synthesis limit (Twist gene fragments). For example, if tile 15 is near codon 1100, the 5'WT block is the entire gene from nt 1 to nt ~3300 — way over 1800 nt.

**Superblocks** solve this by splitting oversized blocks at tile boundaries. The key insight: tile boundaries already have characterized overhangs (oh1, oh2), so splitting a WT block at a tile boundary reuses these overhangs as sub-block junction overhangs within the same one-pot GG reaction.

### Algorithm
```
Phase 1: Forward greedy partition
    Accumulate tiles left→right
    When accumulated gene content > max_sub_length (1778 nt):
        Close current superblock, start new one

Phase 2: Adjust for downstream cassette
    The last superblock's 3'WT block includes the full downstream cassette.
    With PolIII only: 250 nt. With WPRE + bGH polyA + PolIII: ~1065 nt.
    If gene_content + cassette_len > 1778: split last superblock earlier
    (may iterate: keep peeling tiles into a new penultimate SB until it fits)

Phase 3: Collision detection
    SB boundary overhangs (oh2 of boundary tiles) must not collide
    with oh3 or with each other
    If collision: try shifting boundary ±1 tile
```

### GRIN2A numbers (PolIII only — 250 nt cassette)
```
Gene: 4395 nt, PolIII: 250 nt, max sub-block: 1778 nt (1800 - 22 overhead)

With ~20 tiles, each tile spans ~220 nt. Gene blocks range:
- Tile 1: 5'WT = 0 nt (tile starts at gene start), 3'WT ≈ 4175 nt + 250 nt PolIII
- Tile 10: 5'WT ≈ 2200 nt, 3'WT ≈ 2200 nt + 250 nt PolIII
- Tile 20: 5'WT ≈ 4175 nt, 3'WT = 0 nt + 250 nt PolIII

Superblock partition: tiles grouped into ~3 superblocks
SB1: tiles 1-7    (gene content ≈ 1600 nt)
SB2: tiles 8-14   (gene content ≈ 1600 nt)
SB3: tiles 15-20  (gene content ≈ 1195 nt + 250 nt PolIII ≈ 1445 nt)
```

### GRIN2A numbers (WPRE + bGH polyA + PolIII — ~1065 nt cassette)
```
Gene: 4395 nt, cassette: ~1065 nt, max sub-block: 1778 nt

The larger cassette means the last SB can hold at most ~713 nt of gene content
(1778 - 1065 = 713). This pushes more tiles into earlier superblocks:

SB1: tiles 1-8    (gene content ≈ 1750 nt)
SB2: tiles 9-16   (gene content ≈ 1750 nt)
SB3: tiles 17-20  (gene content ≈ 700 nt + 1065 nt cassette ≈ 1765 nt)

For tiles in earlier superblocks (e.g., tile 1), the 3'WT block still needs to
carry the entire 3' portion of the gene + cassette:
  Tile 1's 3'WT = ~4175 nt gene + 1065 nt cassette = 5240 nt total

This is handled by intra-superblock splitting: the 5240 nt 3'WT block is split
into 3 sub-blocks (~1770 + 1770 + 1700 nt) with BsmBI junction overhangs picked
from the gene sequence at the split points. All sub-blocks ligate in the same
one-pot BsmBI reaction alongside the oligo.
```

### How intra-superblock 3'WT splitting works
```
Before splitting (won't synthesize):
  BsmBI(oh2)—[4175 nt 3'WT gene + 1065 nt cassette]—BsmBI(oh3)  = 5262 nt

After splitting into 3 sub-blocks:
  Sub-block 1: BsmBI(oh2)—[~1766 nt gene]—BsmBI(jxn_A)           = 1788 nt
  Sub-block 2: BsmBI(jxn_A)—[~1766 nt gene]—BsmBI(jxn_B)         = 1788 nt
  Sub-block 3: BsmBI(jxn_B)—[~643 nt gene + 1065 nt cassette]—BsmBI(oh3) = 1730 nt

jxn_A and jxn_B are 4-nt overhangs selected from the gene sequence at codon
boundaries using OOGGA scoring, checked for collisions with oh2, oh3, and each
other. They're unique per-tile and participate in the same BsmBI reaction.
```

### Code
```r
partition_result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = 4395,
    polIII_len = nchar(downstream_cassette),  # 250 or ~1065
    max_sub_length = 1778,   # 1800 - 22 overhead
    oh3 = "CACC"
)
```

---

### Step 6e: Variant-to-Tile Assignment

### Conceptual
Each variant (mutation at a specific codon) is assigned to the tile where that codon falls in the **mutable interior** (not in the oh1/oh2 flanks). With 4-codon overlap between adjacent tiles, most codons near boundaries are interior in one of the two flanking tiles.

### Edge case: partial overhang overlap
Codons at the extreme gene edges (codons 1-2, codons 1463-1465) may only appear in one tile's oh1/oh2 flank with no adjacent tile to rescue them. These are flagged `partial_oh_overlap` and **skipped** — they'd produce chimeric assembled products.

### Code
```r
variants <- assign_variants_to_tiles(variants, tiles)
# Each variant gets a tile_id. Variants with partial_oh_overlap are removed:
skipped_mask <- variants$overhang_note == "partial_oh_overlap"
variants <- variants[!skipped_mask, ]
```

---

## Step 7: Barcode Design (`R/07_barcode_design.R`)

### Conceptual
Each of the 29,260 variants gets 10 unique barcodes (for replicate measurements). Barcodes use a **unified hierarchical prefix-suffix architecture**:

```
barcode = prefix (12 nt) + suffix (8 nt)
          ├─── hard Hamming ───┤  ├── random ──┤
          ├──── d ≥ 3 ─────────┤  ├─ filtered ─┤
```

- **Prefix (12 nt):** One unique prefix per variant. Generated using GF(4) linear algebraic codes (for d=3) that guarantee minimum Hamming distance ≥ 3 between any two prefixes.
- **Suffix (8 nt):** Random filtered sequences. 10 different suffixes per prefix = 10 barcodes per variant. No pairwise Hamming constraint on suffixes (same-variant barcodes are OK to be similar).

### Why GF(4) linear codes?
For Hamming distance d ≤ 3, algebraic codes from Galois Field GF(4) are **deterministic, maximum-capacity, and O(n) per codeword**. This replaces the slower DNABarcodes lexicode approach for the common d=3 case.

### Barcode filtering (applied to both prefixes and full barcodes)
- No BsaI/BsmBI/PaqCI recognition sites
- No homopolymer runs > 4 nt
- GC content in [25%, 75%]
- No PolIII terminator signal (`TTTT`) — barcodes are transcribed by U6 PolIII, which terminates at T-runs
- No enzyme sites at junction context (barcode flanked by BsmBI oh3 on left, BsaI oh4 on right)

### GRIN2A numbers
```
Variants: 29,260
Prefixes needed: 29,260 (one per variant)
Prefix length: 12 nt → GF(4) capacity ≈ 453,000 (easily sufficient)
Barcodes per variant: 10
Total barcodes: 292,600
Full barcode: 20 nt = 12 nt prefix + 8 nt suffix

Minimum Hamming distance:
  Cross-variant: d(full) ≥ d(prefix) ≥ 3
  Within-variant: d(full) = d(suffix) = random (acceptable)
```

### Code
```r
barcode_result <- design_barcodes(
    n_variants          = 29260,
    barcode_length      = 20,
    min_hamming         = 3,
    prefix_length       = 12,
    gc_range            = c(0.25, 0.75),
    max_homopolymer     = 4,
    barcodes_per_variant = 10,
    junction_left_context  = "...last 6 nt of BsmBI_fwd_oh3...",
    junction_right_context = "...first 6 nt of BsaI_rev_oh4..."
)
barcodes <- barcode_result$barcodes   # character vector of 292,600 barcodes
```

---

## Step 8: Oligo Assembly (`R/08_oligo_assembly.R`)

### Conceptual
Build the complete oligo sequence for every variant × barcode combination. The universal 3-enzyme structure means **all oligos have identical layout** — no tile-type branching.

### Universal oligo structure (concrete for GRIN2A tile 10 example)

Say tile 10 spans codons 670-747, and we're assembling the variant `R700K` (Arg→Lys at codon 700) with barcode `ACGTACGTACGTACGTACGT`:

```
5'—GGTCTCA—oh1—[.......mutable region (mutated at R700K).......]—GAGACG_oh2—CGTCTCA_oh3—barcode—GAGACC_oh4—3'
   BsaI_fwd  4nt             ~226 nt (78 codons - 4oh1 - 4oh2)      BsmBI_rev    BsmBI_fwd     20nt   BsaI_rev
     (7)     (4)                                                       (11)         (11)        (20)     (11)
                                                            Total = 7+4+226+11+11+20+11 = 290 nt
```

Where:
- `oh1` = first 4 nt of tile 10's WT sequence (gene-derived BsaI overhang)
- `oh2` = last 4 nt of tile 10's WT sequence (gene-derived BsmBI overhang)
- `oh3` = `CACC` (PolIII-derived, fixed for all tiles)
- `oh4` = auto-selected from HF set (e.g., `CTAA`, fixed for all tiles)
- Mutable region = tile's WT sequence (minus oh1/oh2 flanks) with codon 700 changed from `CGG` (Arg) to `AAG` (Lys)

### Enzyme site orientations

```
BsaI forward:   GGTCTC + A + [oh1 is exposed as overhang after cutting]
                 recog   spacer

BsmBI reverse:  RC( CGTCTC + A + RC(oh2) )  →  oh2 + T + GAGACG
(oh2 site)       enzyme reads on complement strand; oh2 exposed after cutting

BsmBI forward:  CGTCTC + A + oh3  →  CGTCTCA + CACC
(oh3 site)       enzyme reads on sense strand; oh3 exposed after cutting

BsaI reverse:   RC( GGTCTC + A + RC(oh4) )  →  oh4_rc + T + GAGACC
(oh4 site)       enzyme reads on complement strand; oh4 exposed after cutting
```

### Performance
Assembly is **vectorized by tile**:
1. Pre-compute all enzyme site strings (constant)
2. For each tile: extract WT sequence, locally mutate at each variant position, strip oh1/oh2 flanks
3. Single `paste0()` call assembles all oligos in one tile

### GRIN2A numbers
```
Total oligos: ~292,600  (29,260 variants × 10 barcodes)
Oligo lengths: ~290-298 nt (varies by tile size; all ≤ 300)
```

### Code
```r
oligos <- assemble_oligos(
    variants = variants_expanded,   # 292,600 rows (expanded for 10 barcodes/variant)
    cds      = gene$cds,
    barcodes = barcodes,            # 292,600 barcode strings
    tiles    = tiles,               # 20 tiles
    oh3      = "CACC",
    oh4      = "CTAA",              # example
    max_oligo_length = 300
)
```

---

## Step 9: WT Gene Block Design (`R/09_wt_geneblock_design.R`)

### Conceptual
For each tile, design the flanking WT gene blocks that get stitched with the oligo during Golden Gate assembly. There are two types of blocks:

1. **BsaI blocks (5'WT):** Gene sequence upstream of the tile. Used in the Level 1 BsaI reaction to insert the oligo into the helper plasmid.

2. **BsmBI blocks (3'WT + PolIII):** Gene sequence downstream of the tile, plus the PolIII cassette. Used in the Level 1b BsmBI reaction to insert between the tile and barcode.

### Block anatomy for an interior tile (e.g., tile 10 of GRIN2A)

**BsaI 5'WT block:**
```
BsaI_fwd(oh_L) + [gene nt 1..tile10_start-1] + BsaI_rev(oh1_tile10)
    7 nt          ~2010 nt of WT gene            11 nt
Total: ~2028 nt → OVERSIZED! Needs superblock splitting.
```

**BsmBI 3'WT block:**
```
BsmBI_fwd(oh2_tile10) + [gene tile10_end+1..4395] + [PolIII 245 nt] + BsmBI_rev(oh3)
     11 nt              ~2385 nt of WT gene          core PolIII       11 nt
Total: ~2652 nt → OVERSIZED! Needs superblock splitting.
```

### Superblock splitting (using tile-boundary partition)

When a block exceeds 1800 nt, it's split at tile boundaries from the precomputed partition:

```
5'WT block for tile 10 (gene nt 1..2009):
  Sub-block A: BsaI_fwd(oh_L) + [gene nt 1..SB_boundary] + BsaI_rev(oh_boundary)
  Sub-block B: BsaI_fwd(oh_boundary) + [gene SB_boundary+1..2009] + BsaI_rev(oh1_tile10)

All sub-blocks participate in the same one-pot BsaI reaction.
The junction overhang (oh_boundary) ensures correct ordering.
```

### Helper plasmid insert
```
PaqCI**—[oh_L → BsaI target → oh4]—PaqCI*
          |_____ helper plasmid insert _____|

This is the backbone that receives the BsaI assembly product.
```

### GRIN2A numbers
```
Gene blocks: ~60-80 total (deduplicated, many tiles share upstream/downstream blocks)
Each block: ≤ 1800 nt after superblock splitting
Longest content region: ~1778 nt gene + 22 nt enzyme sites = 1800 nt max
PolIII (core): 245 nt (appended to 3'WT blocks, minus 5 nt that's encoded by BsmBI oh3)
```

### Code
```r
geneblock_result <- design_wt_geneblocks(
    cds     = gene$cds,
    polIII  = cfg$downstream_cassette,   # 250 nt or downstream_cassette
    tiles   = tiles,
    oh3     = "CACC",
    oh4     = "CTAA",
    paqci_star2 = "NNNN",               # user-specified for backbone
    paqci_star1 = "NNNN",
    max_block_length = 1800,
    assembly_plan = assembly_plan
)
```

---

## Step 10: QC Checks (`R/10_qc_checks.R`)

### Conceptual
Comprehensive validation of the entire design before output. Nine independent checks:

| # | Check | GRIN2A expectation |
|---|-------|-------------------|
| 1 | Oligo lengths ≤ 300 nt | All ~290-298 nt |
| 2 | Gene block lengths ≤ 1800 nt | All ≤ 1800 after splitting |
| 3 | No enzyme sites at barcode junctions | Clean (filtered during barcode design) |
| 4 | All barcodes unique | 292,600 unique 20-mers |
| 5 | Tiles cover entire gene | Codons 1-1465 all covered |
| 6 | Correct variant count | ~29,260 (minus edge skips) |
| 7 | Each variant = exactly 1 codon change from WT | Verified per-variant |
| 8 | Oligo GC content in [25%, 75%] | Warning if outliers |
| 9 | Gene domestication complete | No residual BsaI/BsmBI/PaqCI sites |

### Code
```r
qc_result <- run_qc_checks(
    oligos, geneblock_result, variants_expanded, barcodes,
    tiles, tile_overhangs, gene$cds, oh3, oh4, ...
)
# qc_result$qc_pass = TRUE/FALSE
```

---

## Step 10b: In-Silico Assembly Simulation (Optional, `R/13_gg_simulator.R`)

### Conceptual
Computationally simulates the BsaI and BsmBI digestion and ligation for sampled variants from each tile. Verifies the assembled product matches the expected sequence: `5'WT + mutant_tile + 3'WT + PolIII + barcode`.

---

## Step 11: Output (`R/11_output.R`)

### GRIN2A output files
```
output/
├── GRIN2A_oligo_pool.csv           # 292,600 oligos for Twist ordering
├── GRIN2A_oligo_pool.fasta         # Same in FASTA format
├── GRIN2A_geneblock_order.csv      # ~60-80 gene blocks for synthesis
├── GRIN2A_geneblock_order.fasta    # Same in FASTA format
├── GRIN2A_variant_barcode_map.csv  # 292,600 rows: variant ↔ barcode mapping
├── GRIN2A_tile_manifests.csv       # Per-tile: which oligos + blocks go in each reaction
├── GRIN2A_helper_plasmid.csv       # Helper plasmid insert structure
├── GRIN2A_qc_report.csv            # 9 QC checks with pass/fail
├── GRIN2A_sequences.fasta          # Original CDS, domesticated CDS, protein
├── GRIN2A_skipped_variants.csv     # Edge variants skipped for oh overlap
└── GRIN2A_wetlab_report.html       # Comprehensive assembly guide
```

---

## Step 12: Wetlab Assembly Report (`R/12_report.R`)

### Conceptual
Generates an HTML report with gene info, domestication summary, tile layout with overhang fidelity scores, barcode design statistics, QC results, and assembly instructions.

---

## Putting It All Together: One Tile's Worth of Assembly

### Wetlab workflow for tile 10 of GRIN2A

**Reaction 1: BsmBI Level 1b (42°C)**
```
Inputs:
  - 3'WT gene block(s): gene downstream of tile 10 + core PolIII (as sub-blocks if needed)

Products:
  - Circular plasmid containing 3'WT+PolIII insert between oh2 and oh3 junctions
```

Wait — actually the reactions happen in a different order. Let me correct:

**Reaction 1: BsaI Level 1 (37°C)** — one pot per tile, all variants pooled
```
Inputs:
  - Oligo pool (all variants for tile 10, ~1,460 oligos × 10 barcodes each)
  - 5'WT gene block(s) (gene upstream of tile 10, may be split into sub-blocks)
  - Helper plasmid (linearized, has BsaI-compatible ends with oh_L and oh4)

BsaI cuts at:
  - Oligo: releases oh1-[mutable]-oh2_rc (5' end) and oh3-barcode-oh4_rc (3' end)
  - 5'WT blocks: releases oh_L-[5'WT gene]-oh1 fragment
  - Helper: opens between oh_L and oh4 sites

BsaI ligation order (directed by overhangs):
  oh_L ↔ oh_L  (5'WT block → helper backbone)
  oh1  ↔ oh1   (5'WT block → oligo's 5' end)
  oh4  ↔ oh4   (oligo's 3' end → helper backbone)

Result in helper plasmid:
  ...[5'WT gene]—oh1—[mutable region]—oh2—BsmBI_rev ··· BsmBI_fwd—oh3—barcode—oh4...
```

**Reaction 2: BsmBI Level 1b (42°C)** — same pot
```
Inputs:
  - Product from Reaction 1
  - 3'WT+PolIII gene block(s) (gene downstream of tile 10 + core PolIII)

BsmBI cuts at:
  - The two BsmBI sites flanking the "gap" in the oligo (oh2 and oh3 sites)
  - 3'WT block: releases oh2-[3'WT+PolIII]-oh3 fragment

BsmBI ligation:
  oh2 ↔ oh2   (oligo's tile end → 3'WT block start)
  oh3 ↔ oh3   (3'WT+PolIII block end → oligo's barcode start)

Result in helper plasmid:
  ...[5'WT]—[mutant tile]—[3'WT]—[PolIII]—[barcode]...
  = complete full-length gene with one mutation + barcode
```

**Reaction 3: PaqCI Level 2 (37°C)**
```
Inputs:
  - Product from Reaction 2 (helper plasmid with complete insert)
  - Destination backbone (linearized, with PaqCI-compatible ends)

PaqCI cuts at:
  - PaqCI** and PaqCI* sites flanking the full insert

PaqCI ligation:
  PaqCI** ↔ PaqCI**  (insert 5' end → backbone)
  PaqCI*  ↔ PaqCI*   (insert 3' end → backbone)

Final construct:
  [Backbone]—PaqCI**—[full gene with 1 mutation]—[PolIII]—[barcode]—PaqCI*—[Backbone]
```

---

## Summary of Key Design Decisions vs. CLAUDE.md

| Aspect | CLAUDE.md Plan | Current Implementation |
|--------|---------------|----------------------|
| Enzymes | BsmBI (Level 1) + PaqCI (Level 2) | **BsaI + BsmBI + PaqCI** (3-enzyme) |
| Oligo structure | 3 tile types (leading/internal/trailing) | **Universal** (all tiles identical) |
| Tile boundary search | Geometric partitioning | **DP optimizer** with OOGGA scoring |
| HF overhang set | Greedy-generated | **Potapov Table 1 Set 3** (25 overhangs, SA-optimized) |
| oh3 selection | From HF set | **Derived from PolIII 3' end** (seamless junction) |
| Barcode generation | DNABarcodes lexicode | **GF(4) linear codes** (d≤3) + DNABarcodes (d≥4) |
| Barcode architecture | Single barcode per variant | **10 barcodes/variant** (prefix-suffix hierarchy) |
| Superblock splitting | Global DP on gene coordinates | **Tile-boundary partitioning** (greedy, collision-aware) |
| Overhang scoring | Individual fidelity only | **OOGGA formula**: P_fid × P_eff × HF bonus |
| Codon usage | Kazusa | **CoCoPUTs** (Alexaki 2019) |
| Domestication | BsmBI + PaqCI | **BsaI + BsmBI + PaqCI** (iterative, handles cascade) |
