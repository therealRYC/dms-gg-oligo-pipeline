# DMS-GG Assembly Report: GRIN2A

Generated: 2026-03-12 23:02:10
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                          |
| -------------------- | ------------------------------------------------------------------------------ |
| Gene name            | GRIN2A_NM_000833.5 Human GRIN2A native CDS (NM_000833.5, NP_000824.1, 1464 aa) |
| CDS length           | 4395 nt (1465 codons)                                                          |
| Protein length       | 1464 aa                                                                        |
| Number of tiles      | 26                                                                             |
| Total variants       | 30429                                                                          |
| Total oligos         | 304290                                                                         |
| Oligo length range   | 185-290 nt                                                                     |
| Gene blocks to order | 53                                                                             |
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
[PaqCI**]--[gene+mutation]--[WPRE]--[spacer]--[bGH_polyA]--[PolIII]--[barcode]--[PaqCI*]
```

## 3. Oligo Pool Summary

**Total oligos:** 304290 | **Length range:** 185-290 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-53      | 10290  | 215 nt |
| 2    | 50-127    | 15540  | 290 nt |
| 3    | 124-183   | 11760  | 236 nt |
| 4    | 180-233   | 10500  | 218 nt |
| 5    | 230-283   | 10500  | 218 nt |
| 6    | 280-353   | 14700  | 278 nt |
| 7    | 350-406   | 11130  | 227 nt |
| 8    | 403-475   | 14490  | 275 nt |
| 9    | 472-539   | 13440  | 260 nt |
| 10   | 540-582   | 8190   | 185 nt |
| 11   | 579-632   | 10500  | 218 nt |
| 12   | 629-674   | 8820   | 194 nt |
| 13   | 671-713   | 8190   | 185 nt |
| 14   | 710-770   | 11970  | 239 nt |
| 15   | 767-830   | 12600  | 248 nt |
| 16   | 827-885   | 11550  | 233 nt |
| 17   | 882-940   | 11550  | 233 nt |
| 18   | 937-979   | 8190   | 185 nt |
| 19   | 976-1020  | 8610   | 191 nt |
| 20   | 1017-1066 | 9660   | 206 nt |
| 21   | 1067-1141 | 14910  | 281 nt |
| 22   | 1138-1214 | 15330  | 287 nt |
| 23   | 1211-1287 | 15330  | 287 nt |
| 24   | 1284-1339 | 10920  | 224 nt |
| 25   | 1340-1416 | 15330  | 287 nt |
| 26   | 1413-1465 | 10290  | 215 nt |

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
| Total barcodes    | 304290                             |
| Unique barcodes   | 304290                             |
| GC content range  | 25% - 75%                          |
| GC content mean   | 47.9%                              |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                  | Description                                                   | Result | Detail                                                                                                                                               |
| ---------------------- | ------------------------------------------------------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths          | All oligos within synthesis length limit                      | PASS   | Range: 185-290 nt (limit: 300)                                                                                                                       |
| block_lengths          | All gene blocks within synthesis length limit                 | PASS   | Range: 165-1791 nt (limit: 1800)                                                                                                                     |
| barcode_junction_sites | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                              |
| barcode_uniqueness     | All barcodes are unique                                       | PASS   | 304290 unique / 304290 total                                                                                                                         |
| tile_coverage          | Tiles cover entire gene without gaps                          | PASS   | 4395 / 4395 nt covered                                                                                                                               |
| variant_count          | Expected number of variants generated                         | PASS   | 30429 unique variants (expected: 30429 across 1449/1463 mutable positions; 27531 missense + 1449 nonsense + 1449 wt_control; 14 position(s) skipped) |
| single_codon_change    | Each non-control variant differs by exactly one codon from WT | PASS   | 289800 / 289800 variants confirmed (WT controls excluded)                                                                                            |
| oligo_gc_content       | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 40.9-67.4% | 0 oligo(s) with extreme GC                                                                                                    |
| domestication_complete | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                              |
| overhang_fidelity      | Tile boundary overhangs have adequate fidelity                | FAIL   | 25 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                              |
| tile_manifests         | Per-tile assembly manifests complete                          | PASS   | 26 tile manifest(s) generated                                                                                                                        |
| helper_plasmid         | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                   |
| reaction_fidelity      | Per-reaction set-level overhang fidelity                      | FAIL   | Min set fidelity: 0.7197 across 52 reactions | 8 reaction(s) below 0.90                                                                              |
| barcode_poliii_term    | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 304290 barcode(s) contain TTTT                                                                                                                   |
| block_min_length       | All gene blocks above synthesis minimum length                | FAIL   | 3 block(s) below 300 nt minimum. Range: 165-1791 nt                                                                                                  |
| sb_overhang_collisions | Superblock boundary overhangs are unique (no collisions)      | PASS   | 3 SB boundary OH(s), all unique                                                                                                                      |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 5         | 0.7282             |
| 2    | 3        | 1.0000            | 5         | 0.7197             |
| 3    | 3        | 1.0000            | 5         | 0.8328             |
| 4    | 3        | 1.0000            | 5         | 0.8328             |
| 5    | 3        | 1.0000            | 5         | 0.7810             |
| 6    | 3        | 1.0000            | 5         | 0.8328             |
| 7    | 3        | 1.0000            | 4         | 0.8328             |
| 8    | 3        | 1.0000            | 4         | 1.0000             |
| 9    | 3        | 1.0000            | 4         | 0.8328             |
| 10   | 3        | 0.9712            | 4         | 1.0000             |
| 11   | 3        | 1.0000            | 4         | 0.9984             |
| 12   | 4        | 1.0000            | 4         | 1.0000             |
| 13   | 4        | 0.9800            | 4         | 1.0000             |
| 14   | 4        | 0.9939            | 4         | 1.0000             |
| 15   | 4        | 1.0000            | 3         | 1.0000             |
| 16   | 4        | 1.0000            | 4         | 1.0000             |
| 17   | 4        | 1.0000            | 4         | 1.0000             |
| 18   | 4        | 1.0000            | 3         | 1.0000             |
| 19   | 4        | 1.0000            | 3         | 1.0000             |
| 20   | 4        | 1.0000            | 3         | 1.0000             |
| 21   | 4        | 0.9981            | 3         | 1.0000             |
| 22   | 5        | 1.0000            | 2         | 1.0000             |
| 23   | 5        | 1.0000            | 2         | 0.9988             |
| 24   | 5        | 1.0000            | 2         | 1.0000             |
| 25   | 5        | 0.9907            | 2         | 1.0000             |
| 26   | 5        | 1.0000            | 2         | 1.0000             |

**Min:** 0.7197 | **Max:** 1.0000 | **Mean:** 0.9678

**Warning:** 8 reaction(s) below 0.90 fidelity — consider alternative split points or overhang reassignment.
## 6. Fixed Overhangs & Helper Plasmid

These overhangs are the same across all tile reactions:

| Overhang    | Sequence | Role                                                    |
| ----------- | -------- | ------------------------------------------------------- |
| oh_L        | ATGG     | Gene start (BsaI, all tiles)                            |
| oh3         | CACC     | Downstream cassette-barcode junction (BsmBI, all tiles) |
| oh4         | AGAA     | Barcode-helper junction (BsaI, all tiles)               |
| paqci_star2 | AATG     | PaqCI 5' end of insert (Level 2)                        |
| paqci_star1 | GCTA     | PaqCI 3' end of insert (Level 2)                        |

### Helper Plasmid Insert

The helper plasmid provides the backbone for each BsaI Level 1 reaction.

```
[PaqCI**]--[BsaI>>ATGG]--STUFFER--[AGAA<<BsaI]--[PaqCI*]
```

Insert length: 72 nt
oh_L = ATGG (first 4 nt of gene)
oh_R = AGAA (= oh4, barcode-helper junction)

## 7. Per-Tile Assembly Guide

### Tile 1 of 26 -- Codons 1-53 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGG     | 0.5393   |
| oh2 (3' boundary) | CCCC     | 0.5515   |

**Variants:** 10290 mutations, 10290 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (10290 oligos)              | 215 nt | ATGG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert              | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart               | --     | --    | --    |

```
  [ATGG]----oligo+BC----[AGAA]
   ATGG                  AGAA 
```

**Set fidelity:** 1.0000 (2 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1     | 1476 nt | CCCC  | CACA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1599 nt | CACA  | GTGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 837 nt  | GTGC  | CCTT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | CCTT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCCC]----3'WT sub1----[CACA]----3'WT sub2----[GTGC]----3'WT sub3----[CCTT]----3'WT+PolIII sub4----[CACC]
   CCCC                   CACA                   GTGC                   CCTT                          CACC 
```

**Set fidelity:** 0.7282 (5 overhangs)

---

### Tile 2 of 26 -- Codons 50-127 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAC     | 0.6079   |
| oh2 (3' boundary) | CGCA     | 0.4675   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 165 nt | ATGG  | GAAC  |
| 2   | Oligo pool      | Tile 2 (15540 oligos) | 290 nt | GAAC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[GAAC]----oligo+BC----[AGAA]
   ATGG                    GAAC                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1     | 1254 nt | CGCA  | CACA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1599 nt | CACA  | GTGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 837 nt  | GTGC  | CCTT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | CCTT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CGCA]----3'WT sub1----[CACA]----3'WT sub2----[GTGC]----3'WT sub3----[CCTT]----3'WT+PolIII sub4----[CACC]
   CGCA                   CACA                   GTGC                   CCTT                          CACC 
```

**Set fidelity:** 0.7197 (5 overhangs)

---

### Tile 3 of 26 -- Codons 124-183 (180 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCT     | 0.7151   |
| oh2 (3' boundary) | CGTC     | 0.5136   |

**Variants:** 11760 mutations, 11760 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 387 nt | ATGG  | ATCT  |
| 2   | Oligo pool      | Tile 3 (11760 oligos) | 236 nt | ATCT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[ATCT]----oligo+BC----[AGAA]
   ATGG                    ATCT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1     | 1086 nt | CGTC  | CACA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1599 nt | CACA  | GTGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 837 nt  | GTGC  | CCTT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | CCTT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CGTC]----3'WT sub1----[CACA]----3'WT sub2----[GTGC]----3'WT sub3----[CCTT]----3'WT+PolIII sub4----[CACC]
   CGTC                   CACA                   GTGC                   CCTT                          CACC 
```

**Set fidelity:** 0.8328 (5 overhangs)

---

### Tile 4 of 26 -- Codons 180-233 (162 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACA     | 0.8652   |
| oh2 (3' boundary) | TGTT     | 0.6450   |

**Variants:** 10500 mutations, 10500 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 555 nt | ATGG  | TACA  |
| 2   | Oligo pool      | Tile 4 (10500 oligos) | 218 nt | TACA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[TACA]----oligo+BC----[AGAA]
   ATGG                    TACA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1     | 936 nt  | TGTT  | CACA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1599 nt | CACA  | GTGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 837 nt  | GTGC  | CCTT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | CCTT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGTT]----3'WT sub1----[CACA]----3'WT sub2----[GTGC]----3'WT sub3----[CCTT]----3'WT+PolIII sub4----[CACC]
   TGTT                   CACA                   GTGC                   CCTT                          CACC 
```

**Set fidelity:** 0.8328 (5 overhangs)

---

### Tile 5 of 26 -- Codons 230-283 (162 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACT     | 0.7445   |
| oh2 (3' boundary) | CAGC     | 0.4815   |

**Variants:** 10500 mutations, 10500 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 705 nt | ATGG  | TACT  |
| 2   | Oligo pool      | Tile 5 (10500 oligos) | 218 nt | TACT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[TACT]----oligo+BC----[AGAA]
   ATGG                    TACT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1     | 786 nt  | CAGC  | CACA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1599 nt | CACA  | GTGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 837 nt  | GTGC  | CCTT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | CCTT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAGC]----3'WT sub1----[CACA]----3'WT sub2----[GTGC]----3'WT sub3----[CCTT]----3'WT+PolIII sub4----[CACC]
   CAGC                   CACA                   GTGC                   CCTT                          CACC 
```

**Set fidelity:** 0.7810 (5 overhangs)

---

### Tile 6 of 26 -- Codons 280-353 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCT     | 0.7573   |
| oh2 (3' boundary) | GGTG     | 0.4454   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 855 nt | ATGG  | TCCT  |
| 2   | Oligo pool      | Tile 6 (14700 oligos) | 278 nt | TCCT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[TCCT]----oligo+BC----[AGAA]
   ATGG                    TCCT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1     | 576 nt  | GGTG  | CACA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1599 nt | CACA  | GTGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 837 nt  | GTGC  | CCTT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | CCTT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGTG]----3'WT sub1----[CACA]----3'WT sub2----[GTGC]----3'WT sub3----[CCTT]----3'WT+PolIII sub4----[CACC]
   GGTG                   CACA                   GTGC                   CCTT                          CACC 
```

**Set fidelity:** 0.8328 (5 overhangs)

---

### Tile 7 of 26 -- Codons 350-406 (171 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCA     | 0.8824   |
| oh2 (3' boundary) | CACC     | 0.4172   |

**Variants:** 11130 mutations, 11130 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 1065 nt | ATGG  | TTCA  |
| 2   | Oligo pool      | Tile 7 (11130 oligos) | 227 nt  | TTCA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[TTCA]----oligo+BC----[AGAA]
   ATGG                    TTCA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1     | 417 nt  | CACC  | CACA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1599 nt | CACA  | GTGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 837 nt  | GTGC  | CCTT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | CCTT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CACC]----3'WT sub1----[CACA]----3'WT sub2----[GTGC]----3'WT sub3----[CCTT]----3'WT+PolIII sub4----[CACC]
   CACC                   CACA                   GTGC                   CCTT                          CACC 
```

**Set fidelity:** 0.8328 (4 overhangs)

---

### Tile 8 of 26 -- Codons 403-475 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GACA     | 0.6127   |
| oh2 (3' boundary) | TCTG     | 0.6684   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1224 nt | ATGG  | GACA  |
| 2   | Oligo pool      | Tile 8 (14490 oligos) | 275 nt  | GACA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[GACA]----oligo+BC----[AGAA]
   ATGG                    GACA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1     | 1791 nt | TCTG  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 837 nt  | GTGC  | CCTT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | CCTT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCTG]----3'WT sub1----[GTGC]----3'WT sub2----[CCTT]----3'WT+PolIII sub3----[CACC]
   TCTG                   GTGC                   CCTT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 9 of 26 -- Codons 472-539 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGT     | 0.7629   |
| oh2 (3' boundary) | CACA     | 0.6141   |

**Variants:** 13440 mutations, 13440 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1431 nt | ATGG  | AAGT  |
| 2   | Oligo pool      | Tile 9 (13440 oligos) | 260 nt  | AAGT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[AAGT]----oligo+BC----[AGAA]
   ATGG                    AAGT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1599 nt | CACA  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 837 nt  | GTGC  | CCTT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | CCTT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CACA]----3'WT sub1----[GTGC]----3'WT sub2----[CCTT]----3'WT+PolIII sub3----[CACC]
   CACA                   GTGC                   CCTT                          CACC 
```

**Set fidelity:** 0.8328 (4 overhangs)

---

### Tile 10 of 26 -- Codons 540-582 (129 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGTA     | 0.7286   |
| oh2 (3' boundary) | CAGA     | 0.8175   |

**Variants:** 8190 mutations, 8190 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1635 nt | ATGG  | AGTA  |
| 2   | Oligo pool      | Tile 10 (8190 oligos) | 185 nt  | AGTA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[AGTA]----oligo+BC----[AGAA]
   ATGG                    AGTA                  AGAA 
```

**Set fidelity:** 0.9712 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1    | 1470 nt | CAGA  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 837 nt  | GTGC  | CCTT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | CCTT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAGA]----3'WT sub1----[GTGC]----3'WT sub2----[CCTT]----3'WT+PolIII sub3----[CACC]
   CAGA                   GTGC                   CCTT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 11 of 26 -- Codons 579-632 (162 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCA     | 0.8824   |
| oh2 (3' boundary) | CTTC     | 0.6384   |

**Variants:** 10500 mutations, 10500 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1752 nt | ATGG  | TTCA  |
| 2   | Oligo pool      | Tile 11 (10500 oligos) | 218 nt  | TTCA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT block----[TTCA]----oligo+BC----[AGAA]
   ATGG                    TTCA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1    | 1320 nt | CTTC  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 837 nt  | GTGC  | CCTT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | CCTT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTTC]----3'WT sub1----[GTGC]----3'WT sub2----[CCTT]----3'WT+PolIII sub3----[CACC]
   CTTC                   GTGC                   CCTT                          CACC 
```

**Set fidelity:** 0.9984 (4 overhangs)

---

### Tile 12 of 26 -- Codons 629-674 (138 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCA     | 0.7483   |
| oh2 (3' boundary) | CCCA     | 0.6687   |

**Variants:** 8820 mutations, 8820 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1631 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2  | 289 nt  | CACA  | ATCA  |
| 3   | Oligo pool      | Tile 12 (8820 oligos) | 194 nt  | ATCA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[ATCA]----oligo+BC----[AGAA]
   ATGG                   CACA                   ATCA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1    | 1194 nt | CCCA  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 837 nt  | GTGC  | CCTT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | CCTT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCCA]----3'WT sub1----[GTGC]----3'WT sub2----[CCTT]----3'WT+PolIII sub3----[CACC]
   CCCA                   GTGC                   CCTT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 13 of 26 -- Codons 671-713 (129 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAAA     | 0.8948   |
| oh2 (3' boundary) | CTTG     | 0.7594   |

**Variants:** 8190 mutations, 8190 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1631 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2  | 415 nt  | CACA  | CAAA  |
| 3   | Oligo pool      | Tile 13 (8190 oligos) | 185 nt  | CAAA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[CAAA]----oligo+BC----[AGAA]
   ATGG                   CACA                   CAAA                  AGAA 
```

**Set fidelity:** 0.9800 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1    | 1077 nt | CTTG  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 837 nt  | GTGC  | CCTT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | CCTT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTTG]----3'WT sub1----[GTGC]----3'WT sub2----[CCTT]----3'WT+PolIII sub3----[CACC]
   CTTG                   GTGC                   CCTT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 14 of 26 -- Codons 710-770 (183 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGA     | 0.8175   |
| oh2 (3' boundary) | GCAG     | 0.5118   |

**Variants:** 11970 mutations, 11970 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 532 nt  | CACA  | CAGA  |
| 3   | Oligo pool      | Tile 14 (11970 oligos) | 239 nt  | CAGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[CAGA]----oligo+BC----[AGAA]
   ATGG                   CACA                   CAGA                  AGAA 
```

**Set fidelity:** 0.9939 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1    | 906 nt  | GCAG  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 837 nt  | GTGC  | CCTT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | CCTT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCAG]----3'WT sub1----[GTGC]----3'WT sub2----[CCTT]----3'WT+PolIII sub3----[CACC]
   GCAG                   GTGC                   CCTT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 15 of 26 -- Codons 767-830 (192 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAG     | 0.7511   |
| oh2 (3' boundary) | CACC     | 0.4172   |

**Variants:** 12600 mutations, 12600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 703 nt  | CACA  | AAAG  |
| 3   | Oligo pool      | Tile 15 (12600 oligos) | 248 nt  | AAAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[AAAG]----oligo+BC----[AGAA]
   ATGG                   CACA                   AAAG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1    | 726 nt  | CACC  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 837 nt  | GTGC  | CCTT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | CCTT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CACC]----3'WT sub1----[GTGC]----3'WT sub2----[CCTT]----3'WT+PolIII sub3----[CACC]
   CACC                   GTGC                   CCTT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 16 of 26 -- Codons 827-885 (177 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCCA     | 0.5727   |
| oh2 (3' boundary) | GGGA     | 0.6194   |

**Variants:** 11550 mutations, 11550 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 883 nt  | CACA  | GCCA  |
| 3   | Oligo pool      | Tile 16 (11550 oligos) | 233 nt  | GCCA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[GCCA]----oligo+BC----[AGAA]
   ATGG                   CACA                   GCCA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1    | 561 nt  | GGGA  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 837 nt  | GTGC  | CCTT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | CCTT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGGA]----3'WT sub1----[GTGC]----3'WT sub2----[CCTT]----3'WT+PolIII sub3----[CACC]
   GGGA                   GTGC                   CCTT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 17 of 26 -- Codons 882-940 (177 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTC     | 0.8105   |
| oh2 (3' boundary) | CTCA     | 0.6872   |

**Variants:** 11550 mutations, 11550 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 1048 nt | CACA  | TCTC  |
| 3   | Oligo pool      | Tile 17 (11550 oligos) | 233 nt  | TCTC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TCTC]----oligo+BC----[AGAA]
   ATGG                   CACA                   TCTC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1    | 396 nt  | CTCA  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 837 nt  | GTGC  | CCTT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | CCTT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTCA]----3'WT sub1----[GTGC]----3'WT sub2----[CCTT]----3'WT+PolIII sub3----[CACC]
   CTCA                   GTGC                   CCTT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 18 of 26 -- Codons 937-979 (129 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GATA     | 0.7029   |
| oh2 (3' boundary) | ACAA     | 0.8919   |

**Variants:** 8190 mutations, 8190 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1631 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1213 nt | CACA  | GATA  |
| 3   | Oligo pool      | Tile 18 (8190 oligos) | 185 nt  | GATA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[GATA]----oligo+BC----[AGAA]
   ATGG                   CACA                   GATA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1    | 1098 nt | ACAA  | CCTT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | CCTT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACAA]----3'WT sub1----[CCTT]----3'WT+PolIII sub2----[CACC]
   ACAA                   CCTT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 19 of 26 -- Codons 976-1020 (135 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATA     | 0.8816   |
| oh2 (3' boundary) | GGAT     | 0.5385   |

**Variants:** 8610 mutations, 8610 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1631 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1330 nt | CACA  | AATA  |
| 3   | Oligo pool      | Tile 19 (8610 oligos) | 191 nt  | AATA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[AATA]----oligo+BC----[AGAA]
   ATGG                   CACA                   AATA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1    | 975 nt  | GGAT  | CCTT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | CCTT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAT]----3'WT sub1----[CCTT]----3'WT+PolIII sub2----[CACC]
   GGAT                   CCTT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 20 of 26 -- Codons 1017-1066 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCG     | 0.7234   |
| oh2 (3' boundary) | GTGC     | 0.4969   |

**Variants:** 9660 mutations, 9660 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1631 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2  | 1453 nt | CACA  | TCCG  |
| 3   | Oligo pool      | Tile 20 (9660 oligos) | 206 nt  | TCCG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TCCG]----oligo+BC----[AGAA]
   ATGG                   CACA                   TCCG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 837 nt  | GTGC  | CCTT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | CCTT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GTGC]----3'WT sub1----[CCTT]----3'WT+PolIII sub2----[CACC]
   GTGC                   CCTT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 21 of 26 -- Codons 1067-1141 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CGGG     | 0.5212   |
| oh2 (3' boundary) | CGTG     | 0.5892   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1603 nt | CACA  | CGGG  |
| 3   | Oligo pool      | Tile 21 (14910 oligos) | 281 nt  | CGGG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[CGGG]----oligo+BC----[AGAA]
   ATGG                   CACA                   CGGG                  AGAA 
```

**Set fidelity:** 0.9981 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1    | 612 nt  | CGTG  | CCTT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | CCTT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CGTG]----3'WT sub1----[CCTT]----3'WT+PolIII sub2----[CACC]
   CGTG                   CCTT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 22 of 26 -- Codons 1138-1214 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATG     | 0.6412   |
| oh2 (3' boundary) | CCTT     | 0.6891   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1599 nt | CACA  | GTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 235 nt  | GTGC  | AATG  |
| 4   | Oligo pool      | Tile 22 (15330 oligos) | 287 nt  | AATG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[GTGC]----5'WT sub3----[AATG]----oligo+BC----[AGAA]
   ATGG                   CACA                   GTGC                   AATG                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1    | 393 nt  | CCTT  | CCTT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | CCTT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTT]----3'WT sub1----[CCTT]----3'WT+PolIII sub2----[CACC]
   CCTT                   CCTT                          CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 23 of 26 -- Codons 1211-1287 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCA     | 0.8519   |
| oh2 (3' boundary) | TTCC     | 0.7958   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1599 nt | CACA  | GTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 454 nt  | GTGC  | TCCA  |
| 4   | Oligo pool      | Tile 23 (15330 oligos) | 287 nt  | TCCA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[GTGC]----5'WT sub3----[TCCA]----oligo+BC----[AGAA]
   ATGG                   CACA                   GTGC                   TCCA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile23_sub1    | 1646 nt | TTCC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCC]----3'WT+PolIII----[CACC]
   TTCC                     CACC 
```

**Set fidelity:** 0.9988 (2 overhangs)

---

### Tile 24 of 26 -- Codons 1284-1339 (168 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTAA     | 0.8691   |
| oh2 (3' boundary) | CCTT     | 0.6891   |

**Variants:** 10920 mutations, 10920 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1599 nt | CACA  | GTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3   | 673 nt  | GTGC  | CTAA  |
| 4   | Oligo pool      | Tile 24 (10920 oligos) | 224 nt  | CTAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[GTGC]----5'WT sub3----[CTAA]----oligo+BC----[AGAA]
   ATGG                   CACA                   GTGC                   CTAA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | CCTT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTT]----3'WT+PolIII----[CACC]
   CCTT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 25 of 26 -- Codons 1340-1416 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAA     | 0.9502   |
| oh2 (3' boundary) | CAAT     | 0.7361   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1599 nt | CACA  | GTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3   | 841 nt  | GTGC  | AAAA  |
| 4   | Oligo pool      | Tile 25 (15330 oligos) | 287 nt  | AAAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[GTGC]----5'WT sub3----[AAAA]----oligo+BC----[AGAA]
   ATGG                   CACA                   GTGC                   AAAA                  AGAA 
```

**Set fidelity:** 0.9907 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile25         | 1259 nt | CAAT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAT]----3'WT+PolIII----[CACC]
   CAAT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 26 of 26 -- Codons 1413-1465 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCA     | 0.8519   |
| oh2 (3' boundary) | TTAA     | 0.9448   |

**Variants:** 10290 mutations, 10290 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1599 nt | CACA  | GTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3   | 1060 nt | GTGC  | TCCA  |
| 4   | Oligo pool      | Tile 26 (10290 oligos) | 215 nt  | TCCA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[GTGC]----5'WT sub3----[TCCA]----oligo+BC----[AGAA]
   ATGG                   CACA                   GTGC                   TCCA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component            | Part name                | Length  | 5' OH | 3' OH |
| --- | -------------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product         | (in helper plasmid)      | --      | --    | --    |
| 2   | PolIII-only fragment | bsmbi_polIII_tile26      | 1112 nt | TTAA  | CACC  |
| 3   | Enzyme + buffer      | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTAA]----PolIII----[CACC]
   TTAA                CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

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

- paqci_star2 (5'): `AATG`
- paqci_star1 (3'): `GCTA`

```
[PaqCI** AATG]--[gene+mutation]--[WPRE]--[spacer]--[bGH_polyA]--[PolIII]--[barcode]--[PaqCI* GCTA]
```

## 9. Gene Block Order Sheet

Order these gene blocks as synthesized gene fragments (e.g., Twist gene fragments, IDT gBlocks).
Gene blocks are synthesized once and reused across experiments.

**Total blocks:** 53

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| --------------------- | ----------- | ----------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10_sub1  | 1635        | BsaI        | 5wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile11_sub1  | 1752        | BsaI        | 5wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile12_sub1  | 1631        | BsaI        | 5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1;5wt_tile26_sub1                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile12_sub2  | 289         | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile13_sub2  | 415         | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile14_sub2  | 532         | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile15_sub2  | 703         | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile16_sub2  | 883         | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile17_sub2  | 1048        | BsaI        | 5wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile18_sub2  | 1213        | BsaI        | 5wt_tile18_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile19_sub2  | 1330        | BsaI        | 5wt_tile19_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile2        | 165         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile20_sub2  | 1453        | BsaI        | 5wt_tile20_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile21_sub2  | 1603        | BsaI        | 5wt_tile21_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile22_sub2  | 1599        | BsaI        | 5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2;5wt_tile26_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile22_sub3  | 235         | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile23_sub3  | 454         | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile24_sub3  | 673         | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile25_sub3  | 841         | BsaI        | 5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile26_sub3  | 1060        | BsaI        | 5wt_tile26_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile3        | 387         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile4        | 555         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile5        | 705         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile6        | 855         | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile7        | 1065        | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile8        | 1224        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile9        | 1431        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile1_sub1  | 1476        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile1_sub2  | 1599        | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile1_sub3  | 837         | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub2;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2;3wt_tile16_sub2;3wt_tile17_sub2;3wt_tile20_sub1                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile1_sub4  | 1490        | BsmBI       | 3wt_polIII_tile1_sub4;3wt_polIII_tile2_sub4;3wt_polIII_tile3_sub4;3wt_polIII_tile4_sub4;3wt_polIII_tile5_sub4;3wt_polIII_tile6_sub4;3wt_polIII_tile7_sub4;3wt_polIII_tile8_sub3;3wt_polIII_tile9_sub3;3wt_polIII_tile10_sub3;3wt_polIII_tile11_sub3;3wt_polIII_tile12_sub3;3wt_polIII_tile13_sub3;3wt_polIII_tile14_sub3;3wt_polIII_tile15_sub3;3wt_polIII_tile16_sub3;3wt_polIII_tile17_sub3;3wt_polIII_tile18_sub2;3wt_polIII_tile19_sub2;3wt_polIII_tile20_sub2;3wt_polIII_tile21_sub2;3wt_polIII_tile22_sub2;3wt_polIII_tile24 |
| bsmbi_3wt_tile10_sub1 | 1470        | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile11_sub1 | 1320        | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile12_sub1 | 1194        | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile13_sub1 | 1077        | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile14_sub1 | 906         | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile15_sub1 | 726         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile16_sub1 | 561         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile17_sub1 | 396         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile18_sub1 | 1098        | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile19_sub1 | 975         | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile2_sub1  | 1254        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile21_sub1 | 612         | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile22_sub1 | 393         | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile23_sub1 | 1646        | BsmBI       | 3wt_polIII_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile25      | 1259        | BsmBI       | 3wt_polIII_tile25                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile3_sub1  | 1086        | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile4_sub1  | 936         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile5_sub1  | 786         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile6_sub1  | 576         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile7_sub1  | 417         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile8_sub1  | 1791        | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_polIII_tile26   | 1112        | BsmBI       | polIII_tile26                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |

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

