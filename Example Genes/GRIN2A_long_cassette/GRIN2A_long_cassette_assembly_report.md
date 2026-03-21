# DMS-GG Assembly Report: GRIN2A_long_cassette

Generated: 2026-03-20 21:57:59
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                          |
| -------------------- | ------------------------------------------------------------------------------ |
| Gene name            | GRIN2A_NM_000833.5 Human GRIN2A native CDS (NM_000833.5, NP_000824.1, 1464 aa) |
| CDS length           | 4395 nt (1465 codons)                                                          |
| Protein length       | 1464 aa                                                                        |
| Number of tiles      | 24                                                                             |
| Total variants       | 30597                                                                          |
| Total oligos         | 305970                                                                         |
| Oligo length range   | 185-294 nt                                                                     |
| Gene blocks to order | 58                                                                             |
| Barcodes per variant | 10                                                                             |

## 2. Assembly Architecture Overview

This pipeline uses a **3-enzyme Golden Gate Assembly** strategy:

1. **BsaI Level 1** (37C): Inserts the oligo (mutant tile + barcode) and 5'WT gene block(s) into a helper plasmid.
2. **BsmBI Level 1b** (42C): Inserts 3'WT+PolIII gene block(s) between the tile and barcode.
3. **PaqCI Level 2** (37C): Moves the complete insert from helper plasmid into the destination backbone.

### Universal Oligo Structure

Every oligo in the pool has the same layout regardless of tile position:

```
5'--[BsaI>>]--oh1--[mutable region]--[<<BsmBI]--[BsmBI>>]--barcode--[<<BsaI]--3'
     7 nt     4 nt    variable          11 nt      11 nt    20 nt    11 nt
```

### Final Assembled Construct

```
[PaqCI**]--[gene+mutation]--[P2A_EGFP]--[WPRE]--[spacer]--[bGH_polyA]--[PolIII]--[barcode]--[PaqCI*]
```

## 3. Oligo Pool Summary

**Total oligos:** 305970 | **Length range:** 185-294 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-78      | 15540  | 294 nt |
| 2    | 73-139    | 12810  | 257 nt |
| 3    | 134-207   | 14280  | 278 nt |
| 4    | 202-277   | 14700  | 284 nt |
| 5    | 272-342   | 13650  | 269 nt |
| 6    | 337-411   | 14490  | 281 nt |
| 7    | 406-478   | 14070  | 275 nt |
| 8    | 473-547   | 14490  | 281 nt |
| 9    | 542-586   | 8400   | 191 nt |
| 10   | 587-644   | 11340  | 230 nt |
| 11   | 639-711   | 14070  | 275 nt |
| 12   | 706-772   | 12810  | 257 nt |
| 13   | 767-835   | 13230  | 263 nt |
| 14   | 830-905   | 14700  | 284 nt |
| 15   | 900-949   | 9240   | 206 nt |
| 16   | 944-986   | 7770   | 185 nt |
| 17   | 981-1054  | 14280  | 278 nt |
| 18   | 1049-1124 | 14700  | 284 nt |
| 19   | 1119-1168 | 9450   | 206 nt |
| 20   | 1169-1244 | 15120  | 284 nt |
| 21   | 1239-1295 | 10710  | 227 nt |
| 22   | 1290-1348 | 11130  | 233 nt |
| 23   | 1343-1412 | 13440  | 266 nt |
| 24   | 1407-1483 | 11550  | 289 nt |

## 4. Barcode Design

### Design Parameters

| Parameter             | Value                                |
| --------------------- | ------------------------------------ |
| Mode                  | Unified hierarchical (prefix-suffix) |
| Barcode length        | 20 nt                                |
| Prefix length         | 12 nt                                |
| Suffix length         | 8 nt                                 |
| Requested min Hamming | 3                                    |
| Effective min Hamming | 3                                    |
| Barcodes per variant  | 10                                   |

### Pool Statistics

| Statistic         | Value                              |
| ----------------- | ---------------------------------- |
| Total barcodes    | 305970                             |
| Unique barcodes   | 305970                             |
| GC content range  | 35% - 65%                          |
| GC content mean   | 48.5%                              |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                     | Description                                                   | Result | Detail                                                                                                                                              |
| ------------------------- | ------------------------------------------------------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths             | All oligos within synthesis length limit                      | PASS   | Range: 185-294 nt (limit: 300)                                                                                                                      |
| block_lengths             | All gene blocks within synthesis length limit                 | PASS   | Range: 34-1794 nt (limit: 1800)                                                                                                                     |
| barcode_junction_sites    | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                             |
| barcode_uniqueness        | All barcodes are unique                                       | PASS   | 305970 unique / 305970 total                                                                                                                        |
| tile_coverage             | Tiles cover entire gene without gaps                          | PASS   | 4395 / 4395 nt covered                                                                                                                              |
| variant_count             | Expected number of variants generated                         | PASS   | 30597 unique variants (expected: 30597 across 1457/1463 mutable positions; 27683 missense + 1457 nonsense + 1457 wt_control; 6 position(s) skipped) |
| single_codon_change       | Each non-control variant differs by exactly one codon from WT | PASS   | 291400 / 291400 variants confirmed (WT controls excluded)                                                                                           |
| oligo_gc_content          | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 43.7-66.3% | 0 oligo(s) with extreme GC                                                                                                   |
| domestication_complete    | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                             |
| overhang_fidelity         | Tile boundary overhangs have adequate fidelity                | FAIL   | 21 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                             |
| tile_manifests            | Per-tile assembly manifests complete                          | PASS   | 24 tile manifest(s) generated                                                                                                                       |
| helper_plasmid            | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                  |
| reaction_fidelity         | Per-reaction set-level overhang fidelity                      | PASS   | Min set fidelity: 0.9979 across 48 reactions | 0 reaction(s) below 0.90                                                                             |
| barcode_poliii_term       | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 305970 barcode(s) contain TTTT                                                                                                                  |
| barcode_hairpins          | No barcodes have hairpin stems > 3 bp                         | PASS   | 0 / 305970 barcode(s) have hairpin stems > 3 bp                                                                                                     |
| barcode_dinuc_repeats     | No barcodes have dinucleotide repeats > 4 units               | PASS   | 0 / 305970 barcode(s) exceed 4 dinuc repeat units                                                                                                   |
| barcode_tm_distribution   | Barcode Tm distribution (informational)                       | PASS   | Tm: median=53.3, range=[42.2, 65.7], sd=4 C                                                                                                         |
| block_min_length          | All gene blocks above synthesis minimum length                | FAIL   | 12 block(s) below 300 nt minimum. Range: 34-1794 nt                                                                                                 |
| cassette_fragment_lengths | Cassette fragments within synthesis limits                    | FAIL   | 2 cassette fragment(s). Range: 297-1587 nt. 0 over max, 1 under min.                                                                                |
| sb_overhang_collisions    | Superblock boundary overhangs are unique (no collisions)      | PASS   | 5 SB boundary OH(s), all unique                                                                                                                     |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 5         | 1.0000             |
| 2    | 3        | 1.0000            | 5         | 0.9979             |
| 3    | 3        | 1.0000            | 5         | 0.9983             |
| 4    | 3        | 1.0000            | 5         | 1.0000             |
| 5    | 3        | 1.0000            | 5         | 1.0000             |
| 6    | 3        | 1.0000            | 5         | 1.0000             |
| 7    | 3        | 1.0000            | 5         | 1.0000             |
| 8    | 3        | 1.0000            | 5         | 1.0000             |
| 9    | 3        | 1.0000            | 4         | 1.0000             |
| 10   | 3        | 1.0000            | 4         | 1.0000             |
| 11   | 4        | 1.0000            | 4         | 1.0000             |
| 12   | 4        | 1.0000            | 4         | 1.0000             |
| 13   | 4        | 1.0000            | 4         | 0.9984             |
| 14   | 4        | 1.0000            | 4         | 0.9988             |
| 15   | 4        | 1.0000            | 4         | 1.0000             |
| 16   | 4        | 1.0000            | 4         | 1.0000             |
| 17   | 4        | 1.0000            | 4         | 1.0000             |
| 18   | 4        | 1.0000            | 4         | 1.0000             |
| 19   | 4        | 1.0000            | 5         | 1.0000             |
| 20   | 4        | 1.0000            | 5         | 0.9985             |
| 21   | 5        | 1.0000            | 4         | 1.0000             |
| 22   | 5        | 1.0000            | 5         | 0.9985             |
| 23   | 5        | 1.0000            | 4         | 1.0000             |
| 24   | 5        | 1.0000            | 3         | 1.0000             |

**Min:** 0.9979 | **Max:** 1.0000 | **Mean:** 0.9998

## 6. Fixed Overhangs & Helper Plasmid

These overhangs are the same across all tile reactions:

| Overhang    | Sequence | Role                                                    |
| ----------- | -------- | ------------------------------------------------------- |
| oh_L        | AAGA     | Gene start (BsaI, user-specified, upstream of ATG)      |
| oh3         | CACC     | Downstream cassette-barcode junction (BsmBI, all tiles) |
| oh4         | AGAA     | Barcode-helper junction (BsaI, all tiles)               |
| paqci_star2 | auto     | PaqCI 5' end of insert (Level 2)                        |
| paqci_star1 | auto     | PaqCI 3' end of insert (Level 2)                        |

### Helper Plasmid Insert

The helper plasmid provides the backbone for each BsaI Level 1 reaction.

```
[PaqCI**]--[BsaI>>AAGA]--STUFFER--[AGAA<<BsaI]--[PaqCI*]
```

Insert length: 72 nt
oh_L = AAGA (user-specified, upstream of ATG)
oh_R = AGAA (= oh4, barcode-helper junction)
upstream_cassette = (none)

## 7. Per-Tile Assembly Guide

### Tile 1 of 24 -- Codons 1-78 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | CGAC     | 0.4695   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (15540 oligos)              | 294 nt | AAGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert              | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart               | --     | --    | --    |

```
  [AAGA]----oligo+BC----[AGAA]
   AAGA                  AGAA 
```

**Set fidelity:** 1.0000 (2 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1      | 1572 nt | CGAC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1776 nt | GAAA  | TAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1226 nt | TAAT  | TCAA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1587 nt | TCAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CGAC]----3'WT sub1----[GAAA]----3'WT sub2----[TAAT]----3'WT sub3----[TCAA]----3'WT+PolIII sub4----[CACC]
   CGAC                   GAAA                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 2 of 24 -- Codons 73-139 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTGA     | 0.6791   |
| oh2 (3' boundary) | GGAT     | 0.5385   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 250 nt | AAGA  | CTGA  |
| 2   | Oligo pool      | Tile 2 (12810 oligos) | 257 nt | CTGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [AAGA]----5'WT block----[CTGA]----oligo+BC----[AGAA]
   AAGA                    CTGA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1      | 1389 nt | GGAT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1776 nt | GAAA  | TAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1226 nt | TAAT  | TCAA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1587 nt | TCAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GGAT]----3'WT sub1----[GAAA]----3'WT sub2----[TAAT]----3'WT sub3----[TCAA]----3'WT+PolIII sub4----[CACC]
   GGAT                   GAAA                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 0.9979 (5 overhangs)

---

### Tile 3 of 24 -- Codons 134-207 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCA     | 0.7483   |
| oh2 (3' boundary) | GGAC     | 0.5754   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 433 nt | AAGA  | ATCA  |
| 2   | Oligo pool      | Tile 3 (14280 oligos) | 278 nt | ATCA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [AAGA]----5'WT block----[ATCA]----oligo+BC----[AGAA]
   AAGA                    ATCA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1      | 1185 nt | GGAC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1776 nt | GAAA  | TAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1226 nt | TAAT  | TCAA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1587 nt | TCAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GGAC]----3'WT sub1----[GAAA]----3'WT sub2----[TAAT]----3'WT sub3----[TCAA]----3'WT+PolIII sub4----[CACC]
   GGAC                   GAAA                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 0.9983 (5 overhangs)

---

### Tile 4 of 24 -- Codons 202-277 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATG     | 0.6412   |
| oh2 (3' boundary) | CATT     | 0.6770   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 637 nt | AAGA  | AATG  |
| 2   | Oligo pool      | Tile 4 (14700 oligos) | 284 nt | AATG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [AAGA]----5'WT block----[AATG]----oligo+BC----[AGAA]
   AAGA                    AATG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1      | 975 nt  | CATT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1776 nt | GAAA  | TAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1226 nt | TAAT  | TCAA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1587 nt | TCAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CATT]----3'WT sub1----[GAAA]----3'WT sub2----[TAAT]----3'WT sub3----[TCAA]----3'WT+PolIII sub4----[CACC]
   CATT                   GAAA                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 5 of 24 -- Codons 272-342 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTTC     | 0.8348   |
| oh2 (3' boundary) | TACA     | 0.8652   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 847 nt | AAGA  | TTTC  |
| 2   | Oligo pool      | Tile 5 (13650 oligos) | 269 nt | TTTC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [AAGA]----5'WT block----[TTTC]----oligo+BC----[AGAA]
   AAGA                    TTTC                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1      | 780 nt  | TACA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1776 nt | GAAA  | TAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1226 nt | TAAT  | TCAA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1587 nt | TCAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TACA]----3'WT sub1----[GAAA]----3'WT sub2----[TAAT]----3'WT sub3----[TCAA]----3'WT+PolIII sub4----[CACC]
   TACA                   GAAA                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 6 of 24 -- Codons 337-411 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTTA     | 0.9147   |
| oh2 (3' boundary) | CCTG     | 0.6383   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 1042 nt | AAGA  | TTTA  |
| 2   | Oligo pool      | Tile 6 (14490 oligos) | 281 nt  | TTTA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [AAGA]----5'WT block----[TTTA]----oligo+BC----[AGAA]
   AAGA                    TTTA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1      | 573 nt  | CCTG  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1776 nt | GAAA  | TAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1226 nt | TAAT  | TCAA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1587 nt | TCAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CCTG]----3'WT sub1----[GAAA]----3'WT sub2----[TAAT]----3'WT sub3----[TCAA]----3'WT+PolIII sub4----[CACC]
   CCTG                   GAAA                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 7 of 24 -- Codons 406-478 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTCA     | 0.6872   |
| oh2 (3' boundary) | CTAT     | 0.7299   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 1249 nt | AAGA  | CTCA  |
| 2   | Oligo pool      | Tile 7 (14070 oligos) | 275 nt  | CTCA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [AAGA]----5'WT block----[CTCA]----oligo+BC----[AGAA]
   AAGA                    CTCA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1      | 372 nt  | CTAT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1776 nt | GAAA  | TAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1226 nt | TAAT  | TCAA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1587 nt | TCAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTAT]----3'WT sub1----[GAAA]----3'WT sub2----[TAAT]----3'WT sub3----[TCAA]----3'WT+PolIII sub4----[CACC]
   CTAT                   GAAA                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 8 of 24 -- Codons 473-547 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTTA     | 0.9147   |
| oh2 (3' boundary) | TTCT     | 0.8181   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1450 nt | AAGA  | TTTA  |
| 2   | Oligo pool      | Tile 8 (14490 oligos) | 281 nt  | TTTA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [AAGA]----5'WT block----[TTTA]----oligo+BC----[AGAA]
   AAGA                    TTTA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1      | 165 nt  | TTCT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1776 nt | GAAA  | TAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1226 nt | TAAT  | TCAA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1587 nt | TCAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TTCT]----3'WT sub1----[GAAA]----3'WT sub2----[TAAT]----3'WT sub3----[TCAA]----3'WT+PolIII sub4----[CACC]
   TTCT                   GAAA                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 9 of 24 -- Codons 542-586 (135 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGCA     | 0.5273   |
| oh2 (3' boundary) | CAGA     | 0.8175   |

**Variants:** 8400 mutations, 8400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1657 nt | AAGA  | GGCA  |
| 2   | Oligo pool      | Tile 9 (8400 oligos)  | 191 nt  | GGCA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [AAGA]----5'WT block----[GGCA]----oligo+BC----[AGAA]
   AAGA                    GGCA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1      | 1794 nt | CAGA  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1226 nt | TAAT  | TCAA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1587 nt | TCAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CAGA]----3'WT sub1----[TAAT]----3'WT sub2----[TCAA]----3'WT+PolIII sub3----[CACC]
   CAGA                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 10 of 24 -- Codons 587-644 (174 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AACT     | 0.6635   |
| oh2 (3' boundary) | TAGC     | 0.7011   |

**Variants:** 11340 mutations, 11340 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1792 nt | AAGA  | AACT  |
| 2   | Oligo pool      | Tile 10 (11340 oligos) | 230 nt  | AACT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT block----[AACT]----oligo+BC----[AGAA]
   AAGA                    AACT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1     | 1620 nt | TAGC  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1226 nt | TAAT  | TCAA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1587 nt | TCAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TAGC]----3'WT sub1----[TAAT]----3'WT sub2----[TCAA]----3'WT+PolIII sub3----[CACC]
   TAGC                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 11 of 24 -- Codons 639-711 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTCA     | 0.5915   |
| oh2 (3' boundary) | GAAA     | 0.8745   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1792 nt | AAGA  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile11_sub2   | 186 nt  | AACT  | GTCA  |
| 3   | Oligo pool      | Tile 11 (14070 oligos) | 275 nt  | GTCA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[AACT]----5'WT sub2----[GTCA]----oligo+BC----[AGAA]
   AAGA                   AACT                   GTCA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1     | 1419 nt | GAAA  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1226 nt | TAAT  | TCAA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1587 nt | TCAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAAA]----3'WT sub1----[TAAT]----3'WT sub2----[TCAA]----3'WT+PolIII sub3----[CACC]
   GAAA                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 12 of 24 -- Codons 706-772 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACCA     | 0.7200   |
| oh2 (3' boundary) | GAAG     | 0.6752   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1792 nt | AAGA  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2   | 387 nt  | AACT  | ACCA  |
| 3   | Oligo pool      | Tile 12 (12810 oligos) | 257 nt  | ACCA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[AACT]----5'WT sub2----[ACCA]----oligo+BC----[AGAA]
   AAGA                   AACT                   ACCA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1     | 1236 nt | GAAG  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1226 nt | TAAT  | TCAA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1587 nt | TCAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAAG]----3'WT sub1----[TAAT]----3'WT sub2----[TCAA]----3'WT+PolIII sub3----[CACC]
   GAAG                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 13 of 24 -- Codons 767-835 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAG     | 0.7511   |
| oh2 (3' boundary) | CTTC     | 0.6384   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1792 nt | AAGA  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 570 nt  | AACT  | AAAG  |
| 3   | Oligo pool      | Tile 13 (13230 oligos) | 263 nt  | AAAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[AACT]----5'WT sub2----[AAAG]----oligo+BC----[AGAA]
   AAGA                   AACT                   AAAG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1     | 1047 nt | CTTC  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1226 nt | TAAT  | TCAA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1587 nt | TCAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTTC]----3'WT sub1----[TAAT]----3'WT sub2----[TCAA]----3'WT+PolIII sub3----[CACC]
   CTTC                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 0.9984 (4 overhangs)

---

### Tile 14 of 24 -- Codons 830-905 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTTA     | 0.7183   |
| oh2 (3' boundary) | TTCC     | 0.7958   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1792 nt | AAGA  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 759 nt  | AACT  | CTTA  |
| 3   | Oligo pool      | Tile 14 (14700 oligos) | 284 nt  | CTTA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[AACT]----5'WT sub2----[CTTA]----oligo+BC----[AGAA]
   AAGA                   AACT                   CTTA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1     | 837 nt  | TTCC  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1226 nt | TAAT  | TCAA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1587 nt | TCAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TTCC]----3'WT sub1----[TAAT]----3'WT sub2----[TCAA]----3'WT+PolIII sub3----[CACC]
   TTCC                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 0.9988 (4 overhangs)

---

### Tile 15 of 24 -- Codons 900-949 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAG     | 0.7814   |
| oh2 (3' boundary) | CTTT     | 0.6635   |

**Variants:** 9240 mutations, 9240 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10       | 1792 nt | AAGA  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2  | 969 nt  | AACT  | TCAG  |
| 3   | Oligo pool      | Tile 15 (9240 oligos) | 206 nt  | TCAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[AACT]----5'WT sub2----[TCAG]----oligo+BC----[AGAA]
   AAGA                   AACT                   TCAG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1     | 705 nt  | CTTT  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1226 nt | TAAT  | TCAA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1587 nt | TCAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTTT]----3'WT sub1----[TAAT]----3'WT sub2----[TCAA]----3'WT+PolIII sub3----[CACC]
   CTTT                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 16 of 24 -- Codons 944-986 (129 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAG     | 0.7814   |
| oh2 (3' boundary) | TCTT     | 0.7985   |

**Variants:** 7770 mutations, 7770 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10       | 1792 nt | AAGA  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1101 nt | AACT  | TCAG  |
| 3   | Oligo pool      | Tile 16 (7770 oligos) | 185 nt  | TCAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[AACT]----5'WT sub2----[TCAG]----oligo+BC----[AGAA]
   AAGA                   AACT                   TCAG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1     | 594 nt  | TCTT  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1226 nt | TAAT  | TCAA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1587 nt | TCAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TCTT]----3'WT sub1----[TAAT]----3'WT sub2----[TCAA]----3'WT+PolIII sub3----[CACC]
   TCTT                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 17 of 24 -- Codons 981-1054 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGG     | 0.5358   |
| oh2 (3' boundary) | AGAA     | 0.8847   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1792 nt | AAGA  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 1212 nt | AACT  | CAGG  |
| 3   | Oligo pool      | Tile 17 (14280 oligos) | 278 nt  | CAGG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[AACT]----5'WT sub2----[CAGG]----oligo+BC----[AGAA]
   AAGA                   AACT                   CAGG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1     | 390 nt  | AGAA  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1226 nt | TAAT  | TCAA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1587 nt | TCAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AGAA]----3'WT sub1----[TAAT]----3'WT sub2----[TCAA]----3'WT+PolIII sub3----[CACC]
   AGAA                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 18 of 24 -- Codons 1049-1124 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCTA     | 0.6679   |
| oh2 (3' boundary) | GAAG     | 0.6752   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1792 nt | AAGA  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1416 nt | AACT  | CCTA  |
| 3   | Oligo pool      | Tile 18 (14700 oligos) | 284 nt  | CCTA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[AACT]----5'WT sub2----[CCTA]----oligo+BC----[AGAA]
   AAGA                   AACT                   CCTA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1     | 180 nt  | GAAG  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1226 nt | TAAT  | TCAA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1587 nt | TCAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAAG]----3'WT sub1----[TAAT]----3'WT sub2----[TCAA]----3'WT+PolIII sub3----[CACC]
   GAAG                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 19 of 24 -- Codons 1119-1168 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACTA     | 0.7946   |
| oh2 (3' boundary) | GAAC     | 0.6079   |

**Variants:** 9450 mutations, 9450 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10       | 1792 nt | AAGA  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1626 nt | AACT  | ACTA  |
| 3   | Oligo pool      | Tile 19 (9450 oligos) | 206 nt  | ACTA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[AACT]----5'WT sub2----[ACTA]----oligo+BC----[AGAA]
   AAGA                   AACT                   ACTA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1     | 360 nt  | GAAC  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile19_sub2     | 34 nt   | TCAA  | ATTA  |
| 4   | 3'WT block        | bsmbi_3wt_tile19_sub3     | 234 nt  | ATTA  | AGGT  |
| 5   | 3'WT block        | bsmbi_3wt_tile19_sub4     | 707 nt  | AGGT  | TCAA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1587 nt | TCAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAAC]----3'WT sub1----[TCAA]----3'WT sub2----[ATTA]----3'WT sub3----[AGGT]----3'WT sub4----[TCAA]----3'WT+PolIII sub5----[CACC]
   GAAC                   TCAA                   ATTA                   AGGT                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 20 of 24 -- Codons 1169-1244 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CGGA     | 0.6609   |
| oh2 (3' boundary) | GAAC     | 0.6079   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1792 nt | AAGA  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1776 nt | AACT  | CGGA  |
| 3   | Oligo pool      | Tile 20 (15120 oligos) | 284 nt  | CGGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[AACT]----5'WT sub2----[CGGA]----oligo+BC----[AGAA]
   AAGA                   AACT                   CGGA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1     | 297 nt  | GAAC  | CTCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile20_sub2     | 342 nt  | CTCA  | TAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile20_sub3     | 437 nt  | TAAT  | TCAA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1587 nt | TCAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAAC]----3'WT sub1----[CTCA]----3'WT sub2----[TAAT]----3'WT sub3----[TCAA]----3'WT+PolIII sub4----[CACC]
   GAAC                   CTCA                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 0.9985 (5 overhangs)

---

### Tile 21 of 24 -- Codons 1239-1295 (171 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TGCC     | 0.5867   |
| oh2 (3' boundary) | CATT     | 0.6770   |

**Variants:** 10710 mutations, 10710 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1792 nt | AAGA  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1776 nt | AACT  | CGGA  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3   | 240 nt  | CGGA  | TGCC  |
| 4   | Oligo pool      | Tile 21 (10710 oligos) | 227 nt  | TGCC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[AACT]----5'WT sub2----[CGGA]----5'WT sub3----[TGCC]----oligo+BC----[AGAA]
   AAGA                   AACT                   CGGA                   TGCC                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1     | 456 nt  | CATT  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile20_sub3     | 437 nt  | TAAT  | TCAA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1587 nt | TCAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CATT]----3'WT sub1----[TAAT]----3'WT sub2----[TCAA]----3'WT+PolIII sub3----[CACC]
   CATT                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 22 of 24 -- Codons 1290-1348 (177 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CATT     | 0.6770   |
| oh2 (3' boundary) | TCTG     | 0.6684   |

**Variants:** 11130 mutations, 11130 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1792 nt | AAGA  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1776 nt | AACT  | CGGA  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 393 nt  | CGGA  | CATT  |
| 4   | Oligo pool      | Tile 22 (11130 oligos) | 233 nt  | CATT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[AACT]----5'WT sub2----[CGGA]----5'WT sub3----[CATT]----oligo+BC----[AGAA]
   AAGA                   AACT                   CGGA                   CATT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1     | 297 nt  | TCTG  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile22_sub2     | 34 nt   | TAAT  | CCCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile22_sub3     | 590 nt  | CCCT  | TCAA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1587 nt | TCAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TCTG]----3'WT sub1----[TAAT]----3'WT sub2----[CCCT]----3'WT sub3----[TCAA]----3'WT+PolIII sub4----[CACC]
   TCTG                   TAAT                   CCCT                   TCAA                          CACC 
```

**Set fidelity:** 0.9985 (5 overhangs)

---

### Tile 23 of 24 -- Codons 1343-1412 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTTT     | 0.6635   |
| oh2 (3' boundary) | CTGT     | 0.6476   |

**Variants:** 13440 mutations, 13440 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1792 nt | AAGA  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1776 nt | AACT  | CGGA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 552 nt  | CGGA  | CTTT  |
| 4   | Oligo pool      | Tile 23 (13440 oligos) | 266 nt  | CTTT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[AACT]----5'WT sub2----[CGGA]----5'WT sub3----[CTTT]----oligo+BC----[AGAA]
   AAGA                   AACT                   CGGA                   CTTT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1     | 129 nt  | CTGT  | TTTA  |
| 3   | 3'WT block        | bsmbi_3wt_tile23_sub2     | 413 nt  | TTTA  | TCAA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1587 nt | TCAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTGT]----3'WT sub1----[TTTA]----3'WT sub2----[TCAA]----3'WT+PolIII sub3----[CACC]
   CTGT                   TTTA                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 24 of 24 -- Codons 1407-1483 (233 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAA     | 0.9425   |
| oh2 (3' boundary) | AGAA     | 0.8847   |

**Variants:** 11550 mutations, 11550 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1792 nt | AAGA  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1776 nt | AACT  | CGGA  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3   | 744 nt  | CGGA  | TCAA  |
| 4   | Oligo pool      | Tile 24 (11550 oligos) | 289 nt  | TCAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[AACT]----5'WT sub2----[CGGA]----5'WT sub3----[TCAA]----oligo+BC----[AGAA]
   AAGA                   AACT                   CGGA                   TCAA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                  | Length  | 5' OH | 3' OH |
| --- | ----------------- | -------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)        | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_cassette_tile24_sub1 | 297 nt  | AGAA  | TCAA  |
| 3   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4  | 1587 nt | TCAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1   | --      | --    | --    |

```
  [AGAA]----3'WT sub1----[TCAA]----3'WT+PolIII sub2----[CACC]
   AGAA                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

## 8. PaqCI Level 2 Reaction (37C)

The final cloning step transfers the complete insert from the helper plasmid
into the destination backbone.

**Components per reaction:**

| # | Component | Detail |
| --- | --- | --- |
| 1 | BsmBI product | Complete insert in helper plasmid |
| 2 | Destination backbone | PaqCI-compatible receiving vector |
| 3 | Enzyme + buffer | PaqCI + CutSmart (37C) |

**PaqCI overhangs:**

- paqci_star2 (5'): `auto`
- paqci_star1 (3'): `auto`

```
[PaqCI** auto]--[gene+mutation]--[P2A_EGFP]--[WPRE]--[spacer]--[bGH_polyA]--[PolIII]--[barcode]--[PaqCI* auto]
```

## 9. Gene Block Order Sheet

Order these gene blocks as synthesized gene fragments (e.g., Twist gene fragments, IDT gBlocks).
Gene blocks are synthesized once and reused across experiments.

**Total blocks:** 58

| Block name                 | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| -------------------------- | ----------- | ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10            | 1792        | BsaI        | 5wt_tile10;5wt_tile11_sub1;5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile11_sub2       | 186         | BsaI        | 5wt_tile11_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile12_sub2       | 387         | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile13_sub2       | 570         | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile14_sub2       | 759         | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile15_sub2       | 969         | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile16_sub2       | 1101        | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile17_sub2       | 1212        | BsaI        | 5wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile18_sub2       | 1416        | BsaI        | 5wt_tile18_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile19_sub2       | 1626        | BsaI        | 5wt_tile19_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile2             | 250         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile20_sub2       | 1776        | BsaI        | 5wt_tile20_sub2;5wt_tile21_sub2;5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile21_sub3       | 240         | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile22_sub3       | 393         | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile23_sub3       | 552         | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile24_sub3       | 744         | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile3             | 433         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile4             | 637         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile5             | 847         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile6             | 1042        | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile7             | 1249        | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile8             | 1450        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile9             | 1657        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile1_sub1       | 1572        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile1_sub2       | 1776        | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile8_sub2                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile1_sub3       | 1226        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub3;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2;3wt_tile16_sub2;3wt_tile17_sub2;3wt_tile18_sub2                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile10_sub1      | 1620        | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile11_sub1      | 1419        | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile12_sub1      | 1236        | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile13_sub1      | 1047        | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile14_sub1      | 837         | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile15_sub1      | 705         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile16_sub1      | 594         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile17_sub1      | 390         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile18_sub1      | 180         | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile19_sub1      | 360         | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile19_sub2      | 34          | BsmBI       | 3wt_tile19_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile19_sub3      | 234         | BsmBI       | 3wt_tile19_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile19_sub4      | 707         | BsmBI       | 3wt_tile19_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile2_sub1       | 1389        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile20_sub1      | 297         | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile20_sub2      | 342         | BsmBI       | 3wt_tile20_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile20_sub3      | 437         | BsmBI       | 3wt_tile20_sub3;3wt_tile21_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile21_sub1      | 456         | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile22_sub1      | 297         | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile22_sub2      | 34          | BsmBI       | 3wt_tile22_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile22_sub3      | 590         | BsmBI       | 3wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile23_sub1      | 129         | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile23_sub2      | 413         | BsmBI       | 3wt_tile23_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile3_sub1       | 1185        | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile4_sub1       | 975         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile5_sub1       | 780         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile6_sub1       | 573         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile7_sub1       | 372         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile8_sub1       | 165         | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile9_sub1       | 1794        | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_cassette_tile1_sub4  | 1587        | BsmBI       | cassette_tile1_frag1;cassette_tile2_frag1;cassette_tile3_frag1;cassette_tile4_frag1;cassette_tile5_frag1;cassette_tile6_frag1;cassette_tile7_frag1;cassette_tile8_frag1;cassette_tile9_frag1;cassette_tile10_frag1;cassette_tile11_frag1;cassette_tile12_frag1;cassette_tile13_frag1;cassette_tile14_frag1;cassette_tile15_frag1;cassette_tile16_frag1;cassette_tile17_frag1;cassette_tile18_frag1;cassette_tile19_frag1;cassette_tile20_frag1;cassette_tile21_frag1;cassette_tile22_frag1;cassette_tile23_frag1;cassette_tile24_frag2 |
| bsmbi_cassette_tile24_sub1 | 297         | BsmBI       | cassette_tile24_frag1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |

## 10. Domestication Log

6 endogenous enzyme site(s) were removed via silent mutations:

| site_start | enzyme | strand | codon_pos | original_codon | new_codon | aa  |
| ---------- | ------ | ------ | --------- | -------------- | --------- | --- |
| 780        | BsaI   | +      | 260       | TTG            | CTT       | L   |
| 2013       | BsaI   | -      | 671       | CAG            | CAA       | Q   |
| 2374       | BsaI   | -      | 792       | GAG            | GAA       | E   |
| 3604       | BsaI   | -      | 1202      | GAG            | GAA       | E   |
| 1279       | BsmBI  | -      | 427       | GAG            | GAA       | E   |
| 1629       | BsmBI  | +      | 543       | ACC            | ACA       | T   |

## 11. Configuration Parameters

| Parameter             | Value          |
| --------------------- | -------------- |
| max_oligo_length      | 300            |
| max_geneblock_length  | 1800           |
| barcode_length        | 20             |
| min_hamming_distance  | 3              |
| barcode_prefix_length | 12             |
| barcodes_per_variant  | 10             |
| boundary_method       | oogga_two_pass |
| multi_k_search        | TRUE           |
| auto_domesticate      | TRUE           |

