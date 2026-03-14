# DMS-GG Assembly Report: GRIN2A

Generated: 2026-03-12 22:26:41
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
| Oligo length range   | 155-290 nt                                                                     |
| Gene blocks to order | 54                                                                             |
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

**Total oligos:** 304290 | **Length range:** 155-290 nt

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
| 10   | 540-584   | 8610   | 191 nt |
| 11   | 581-651   | 14070  | 269 nt |
| 12   | 648-703   | 10920  | 224 nt |
| 13   | 700-767   | 13440  | 260 nt |
| 14   | 768-811   | 8400   | 188 nt |
| 15   | 808-885   | 15540  | 290 nt |
| 16   | 882-955   | 14700  | 278 nt |
| 17   | 952-1029  | 15540  | 290 nt |
| 18   | 1026-1099 | 14700  | 278 nt |
| 19   | 1096-1131 | 6720   | 164 nt |
| 20   | 1128-1196 | 13650  | 263 nt |
| 21   | 1193-1255 | 12390  | 245 nt |
| 22   | 1252-1294 | 8190   | 185 nt |
| 23   | 1291-1323 | 6090   | 155 nt |
| 24   | 1324-1390 | 13230  | 257 nt |
| 25   | 1387-1423 | 6930   | 167 nt |
| 26   | 1420-1465 | 8820   | 194 nt |

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
| GC content mean   | 48%                                |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                  | Description                                                   | Result | Detail                                                                                                                                               |
| ---------------------- | ------------------------------------------------------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths          | All oligos within synthesis length limit                      | PASS   | Range: 155-290 nt (limit: 300)                                                                                                                       |
| block_lengths          | All gene blocks within synthesis length limit                 | PASS   | Range: 165-1758 nt (limit: 1800)                                                                                                                     |
| barcode_junction_sites | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                              |
| barcode_uniqueness     | All barcodes are unique                                       | PASS   | 304290 unique / 304290 total                                                                                                                         |
| tile_coverage          | Tiles cover entire gene without gaps                          | PASS   | 4395 / 4395 nt covered                                                                                                                               |
| variant_count          | Expected number of variants generated                         | PASS   | 30429 unique variants (expected: 30429 across 1449/1463 mutable positions; 27531 missense + 1449 nonsense + 1449 wt_control; 14 position(s) skipped) |
| single_codon_change    | Each non-control variant differs by exactly one codon from WT | PASS   | 289800 / 289800 variants confirmed (WT controls excluded)                                                                                            |
| oligo_gc_content       | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 38.1-67% | 0 oligo(s) with extreme GC                                                                                                      |
| domestication_complete | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                              |
| overhang_fidelity      | Tile boundary overhangs have adequate fidelity                | FAIL   | 25 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                              |
| tile_manifests         | Per-tile assembly manifests complete                          | PASS   | 26 tile manifest(s) generated                                                                                                                        |
| helper_plasmid         | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                   |
| reaction_fidelity      | Per-reaction set-level overhang fidelity                      | FAIL   | Min set fidelity: 0.675 across 52 reactions | 21 reaction(s) below 0.90                                                                              |
| barcode_poliii_term    | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 304290 barcode(s) contain TTTT                                                                                                                   |
| block_min_length       | All gene blocks above synthesis minimum length                | FAIL   | 3 block(s) below 300 nt minimum. Range: 165-1758 nt                                                                                                  |
| sb_overhang_collisions | Superblock boundary overhangs are unique (no collisions)      | PASS   | 3 SB boundary OH(s), all unique                                                                                                                      |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 5         | 0.6847             |
| 2    | 3        | 1.0000            | 5         | 0.6750             |
| 3    | 3        | 1.0000            | 5         | 0.7810             |
| 4    | 3        | 1.0000            | 5         | 0.7810             |
| 5    | 3        | 1.0000            | 4         | 0.7810             |
| 6    | 3        | 1.0000            | 5         | 0.7810             |
| 7    | 3        | 1.0000            | 4         | 0.7810             |
| 8    | 3        | 1.0000            | 4         | 0.9358             |
| 9    | 3        | 1.0000            | 4         | 0.7810             |
| 10   | 3        | 0.9712            | 4         | 0.9358             |
| 11   | 3        | 1.0000            | 4         | 0.9358             |
| 12   | 4        | 1.0000            | 4         | 0.9358             |
| 13   | 4        | 0.9111            | 3         | 0.9358             |
| 14   | 4        | 1.0000            | 3         | 0.9358             |
| 15   | 4        | 0.8940            | 3         | 0.9358             |
| 16   | 5        | 0.8677            | 3         | 0.7149             |
| 17   | 5        | 0.8677            | 3         | 0.9358             |
| 18   | 5        | 0.8677            | 3         | 0.9358             |
| 19   | 5        | 0.7603            | 3         | 0.9358             |
| 20   | 5        | 0.8677            | 3         | 0.9358             |
| 21   | 5        | 0.8136            | 2         | 0.9983             |
| 22   | 5        | 0.8624            | 2         | 1.0000             |
| 23   | 5        | 0.8677            | 2         | 0.9358             |
| 24   | 5        | 0.8677            | 2         | 1.0000             |
| 25   | 6        | 0.7906            | 2         | 1.0000             |
| 26   | 6        | 0.8677            | 2         | 1.0000             |

**Min:** 0.6750 | **Max:** 1.0000 | **Mean:** 0.9051

**Warning:** 21 reaction(s) below 0.90 fidelity — consider alternative split points or overhang reassignment.
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
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 702 nt  | CACA  | TTGG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1686 nt | TTGG  | CAGC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1538 nt | CAGC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCCC]----3'WT sub1----[CACA]----3'WT sub2----[TTGG]----3'WT sub3----[CAGC]----3'WT+PolIII sub4----[CACC]
   CCCC                   CACA                   TTGG                   CAGC                          CACC 
```

**Set fidelity:** 0.6847 (5 overhangs)

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
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 702 nt  | CACA  | TTGG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1686 nt | TTGG  | CAGC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1538 nt | CAGC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CGCA]----3'WT sub1----[CACA]----3'WT sub2----[TTGG]----3'WT sub3----[CAGC]----3'WT+PolIII sub4----[CACC]
   CGCA                   CACA                   TTGG                   CAGC                          CACC 
```

**Set fidelity:** 0.6750 (5 overhangs)

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
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 702 nt  | CACA  | TTGG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1686 nt | TTGG  | CAGC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1538 nt | CAGC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CGTC]----3'WT sub1----[CACA]----3'WT sub2----[TTGG]----3'WT sub3----[CAGC]----3'WT+PolIII sub4----[CACC]
   CGTC                   CACA                   TTGG                   CAGC                          CACC 
```

**Set fidelity:** 0.7810 (5 overhangs)

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
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 702 nt  | CACA  | TTGG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1686 nt | TTGG  | CAGC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1538 nt | CAGC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGTT]----3'WT sub1----[CACA]----3'WT sub2----[TTGG]----3'WT sub3----[CAGC]----3'WT+PolIII sub4----[CACC]
   TGTT                   CACA                   TTGG                   CAGC                          CACC 
```

**Set fidelity:** 0.7810 (5 overhangs)

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
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 702 nt  | CACA  | TTGG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1686 nt | TTGG  | CAGC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1538 nt | CAGC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAGC]----3'WT sub1----[CACA]----3'WT sub2----[TTGG]----3'WT sub3----[CAGC]----3'WT+PolIII sub4----[CACC]
   CAGC                   CACA                   TTGG                   CAGC                          CACC 
```

**Set fidelity:** 0.7810 (4 overhangs)

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
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 702 nt  | CACA  | TTGG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1686 nt | TTGG  | CAGC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1538 nt | CAGC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGTG]----3'WT sub1----[CACA]----3'WT sub2----[TTGG]----3'WT sub3----[CAGC]----3'WT+PolIII sub4----[CACC]
   GGTG                   CACA                   TTGG                   CAGC                          CACC 
```

**Set fidelity:** 0.7810 (5 overhangs)

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
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 702 nt  | CACA  | TTGG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1686 nt | TTGG  | CAGC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1538 nt | CAGC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CACC]----3'WT sub1----[CACA]----3'WT sub2----[TTGG]----3'WT sub3----[CAGC]----3'WT+PolIII sub4----[CACC]
   CACC                   CACA                   TTGG                   CAGC                          CACC 
```

**Set fidelity:** 0.7810 (4 overhangs)

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
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1     | 894 nt  | TCTG  | TTGG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1686 nt | TTGG  | CAGC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1538 nt | CAGC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCTG]----3'WT sub1----[TTGG]----3'WT sub2----[CAGC]----3'WT+PolIII sub3----[CACC]
   TCTG                   TTGG                   CAGC                          CACC 
```

**Set fidelity:** 0.9358 (4 overhangs)

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
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 702 nt  | CACA  | TTGG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1686 nt | TTGG  | CAGC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1538 nt | CAGC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CACA]----3'WT sub1----[TTGG]----3'WT sub2----[CAGC]----3'WT+PolIII sub3----[CACC]
   CACA                   TTGG                   CAGC                          CACC 
```

**Set fidelity:** 0.7810 (4 overhangs)

---

### Tile 10 of 26 -- Codons 540-584 (135 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGTA     | 0.7286   |
| oh2 (3' boundary) | CTTA     | 0.7183   |

**Variants:** 8610 mutations, 8610 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1635 nt | ATGG  | AGTA  |
| 2   | Oligo pool      | Tile 10 (8610 oligos) | 191 nt  | AGTA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1    | 567 nt  | CTTA  | TTGG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1686 nt | TTGG  | CAGC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1538 nt | CAGC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTTA]----3'WT sub1----[TTGG]----3'WT sub2----[CAGC]----3'WT+PolIII sub3----[CACC]
   CTTA                   TTGG                   CAGC                          CACC 
```

**Set fidelity:** 0.9358 (4 overhangs)

---

### Tile 11 of 26 -- Codons 581-651 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCTG     | 0.6383   |
| oh2 (3' boundary) | CCAA     | 0.8439   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1758 nt | ATGG  | CCTG  |
| 2   | Oligo pool      | Tile 11 (14070 oligos) | 269 nt  | CCTG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT block----[CCTG]----oligo+BC----[AGAA]
   ATGG                    CCTG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1    | 366 nt  | CCAA  | TTGG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1686 nt | TTGG  | CAGC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1538 nt | CAGC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCAA]----3'WT sub1----[TTGG]----3'WT sub2----[CAGC]----3'WT+PolIII sub3----[CACC]
   CCAA                   TTGG                   CAGC                          CACC 
```

**Set fidelity:** 0.9358 (4 overhangs)

---

### Tile 12 of 26 -- Codons 648-703 (168 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATC     | 0.7116   |
| oh2 (3' boundary) | CAAA     | 0.8948   |

**Variants:** 10920 mutations, 10920 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2   | 346 nt  | CACA  | AATC  |
| 3   | Oligo pool      | Tile 12 (10920 oligos) | 224 nt  | AATC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[AATC]----oligo+BC----[AGAA]
   ATGG                   CACA                   AATC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1    | 210 nt  | CAAA  | TTGG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1686 nt | TTGG  | CAGC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1538 nt | CAGC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAA]----3'WT sub1----[TTGG]----3'WT sub2----[CAGC]----3'WT+PolIII sub3----[CACC]
   CAAA                   TTGG                   CAGC                          CACC 
```

**Set fidelity:** 0.9358 (4 overhangs)

---

### Tile 13 of 26 -- Codons 700-767 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACA     | 0.8652   |
| oh2 (3' boundary) | TTGG     | 0.6005   |

**Variants:** 13440 mutations, 13440 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 502 nt  | CACA  | TACA  |
| 3   | Oligo pool      | Tile 13 (13440 oligos) | 260 nt  | TACA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TACA]----oligo+BC----[AGAA]
   ATGG                   CACA                   TACA                  AGAA 
```

**Set fidelity:** 0.9111 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1686 nt | TTGG  | CAGC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1538 nt | CAGC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTGG]----3'WT sub1----[CAGC]----3'WT+PolIII sub2----[CACC]
   TTGG                   CAGC                          CACC 
```

**Set fidelity:** 0.9358 (3 overhangs)

---

### Tile 14 of 26 -- Codons 768-811 (132 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGCT     | 0.4697   |
| oh2 (3' boundary) | TGAC     | 0.6485   |

**Variants:** 8400 mutations, 8400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1631 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2  | 706 nt  | CACA  | GGCT  |
| 3   | Oligo pool      | Tile 14 (8400 oligos) | 188 nt  | GGCT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[GGCT]----oligo+BC----[AGAA]
   ATGG                   CACA                   GGCT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1    | 1554 nt | TGAC  | CAGC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1538 nt | CAGC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAC]----3'WT sub1----[CAGC]----3'WT+PolIII sub2----[CACC]
   TGAC                   CAGC                          CACC 
```

**Set fidelity:** 0.9358 (3 overhangs)

---

### Tile 15 of 26 -- Codons 808-885 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGA     | 0.7549   |
| oh2 (3' boundary) | GGGA     | 0.6194   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 826 nt  | CACA  | ATGA  |
| 3   | Oligo pool      | Tile 15 (15540 oligos) | 290 nt  | ATGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[ATGA]----oligo+BC----[AGAA]
   ATGG                   CACA                   ATGA                  AGAA 
```

**Set fidelity:** 0.8940 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1    | 1332 nt | GGGA  | CAGC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1538 nt | CAGC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGGA]----3'WT sub1----[CAGC]----3'WT+PolIII sub2----[CACC]
   GGGA                   CAGC                          CACC 
```

**Set fidelity:** 0.9358 (3 overhangs)

---

### Tile 16 of 26 -- Codons 882-955 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTC     | 0.8105   |
| oh2 (3' boundary) | CAAC     | 0.5780   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 702 nt  | CACA  | TTGG  |
| 3   | 5'WT gene block | bsai_5wt_tile16_sub3   | 364 nt  | TTGG  | TCTC  |
| 4   | Oligo pool      | Tile 16 (14700 oligos) | 278 nt  | TCTC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TTGG]----5'WT sub3----[TCTC]----oligo+BC----[AGAA]
   ATGG                   CACA                   TTGG                   TCTC                  AGAA 
```

**Set fidelity:** 0.8677 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1    | 1122 nt | CAAC  | CAGC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1538 nt | CAGC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAC]----3'WT sub1----[CAGC]----3'WT+PolIII sub2----[CACC]
   CAAC                   CAGC                          CACC 
```

**Set fidelity:** 0.7149 (3 overhangs)

---

### Tile 17 of 26 -- Codons 952-1029 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAG     | 0.7511   |
| oh2 (3' boundary) | CCAG     | 0.6122   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 702 nt  | CACA  | TTGG  |
| 3   | 5'WT gene block | bsai_5wt_tile17_sub3   | 574 nt  | TTGG  | AAAG  |
| 4   | Oligo pool      | Tile 17 (15540 oligos) | 290 nt  | AAAG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TTGG]----5'WT sub3----[AAAG]----oligo+BC----[AGAA]
   ATGG                   CACA                   TTGG                   AAAG                  AGAA 
```

**Set fidelity:** 0.8677 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1    | 900 nt  | CCAG  | CAGC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1538 nt | CAGC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCAG]----3'WT sub1----[CAGC]----3'WT+PolIII sub2----[CACC]
   CCAG                   CAGC                          CACC 
```

**Set fidelity:** 0.9358 (3 overhangs)

---

### Tile 18 of 26 -- Codons 1026-1099 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTAT     | 0.7299   |
| oh2 (3' boundary) | GCGC     | 0.4318   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 702 nt  | CACA  | TTGG  |
| 3   | 5'WT gene block | bsai_5wt_tile18_sub3   | 796 nt  | TTGG  | CTAT  |
| 4   | Oligo pool      | Tile 18 (14700 oligos) | 278 nt  | CTAT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TTGG]----5'WT sub3----[CTAT]----oligo+BC----[AGAA]
   ATGG                   CACA                   TTGG                   CTAT                  AGAA 
```

**Set fidelity:** 0.8677 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1    | 690 nt  | GCGC  | CAGC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1538 nt | CAGC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCGC]----3'WT sub1----[CAGC]----3'WT+PolIII sub2----[CACC]
   GCGC                   CAGC                          CACC 
```

**Set fidelity:** 0.9358 (3 overhangs)

---

### Tile 19 of 26 -- Codons 1096-1131 (108 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGG     | 0.6552   |
| oh2 (3' boundary) | GTTT     | 0.5873   |

**Variants:** 6720 mutations, 6720 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1631 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 702 nt  | CACA  | TTGG  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3  | 1006 nt | TTGG  | AAGG  |
| 4   | Oligo pool      | Tile 19 (6720 oligos) | 164 nt  | AAGG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TTGG]----5'WT sub3----[AAGG]----oligo+BC----[AGAA]
   ATGG                   CACA                   TTGG                   AAGG                  AGAA 
```

**Set fidelity:** 0.7603 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1    | 594 nt  | GTTT  | CAGC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1538 nt | CAGC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GTTT]----3'WT sub1----[CAGC]----3'WT+PolIII sub2----[CACC]
   GTTT                   CAGC                          CACC 
```

**Set fidelity:** 0.9358 (3 overhangs)

---

### Tile 20 of 26 -- Codons 1128-1196 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCC     | 0.7958   |
| oh2 (3' boundary) | GCAC     | 0.5057   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 702 nt  | CACA  | TTGG  |
| 3   | 5'WT gene block | bsai_5wt_tile20_sub3   | 1102 nt | TTGG  | TTCC  |
| 4   | Oligo pool      | Tile 20 (13650 oligos) | 263 nt  | TTCC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TTGG]----5'WT sub3----[TTCC]----oligo+BC----[AGAA]
   ATGG                   CACA                   TTGG                   TTCC                  AGAA 
```

**Set fidelity:** 0.8677 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1    | 399 nt  | GCAC  | CAGC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1538 nt | CAGC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCAC]----3'WT sub1----[CAGC]----3'WT+PolIII sub2----[CACC]
   GCAC                   CAGC                          CACC 
```

**Set fidelity:** 0.9358 (3 overhangs)

---

### Tile 21 of 26 -- Codons 1193-1255 (189 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTGA     | 0.8853   |
| oh2 (3' boundary) | TAAC     | 0.7715   |

**Variants:** 12390 mutations, 12390 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 702 nt  | CACA  | TTGG  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3   | 1297 nt | TTGG  | TTGA  |
| 4   | Oligo pool      | Tile 21 (12390 oligos) | 245 nt  | TTGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TTGG]----5'WT sub3----[TTGA]----oligo+BC----[AGAA]
   ATGG                   CACA                   TTGG                   TTGA                  AGAA 
```

**Set fidelity:** 0.8136 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile21_sub1    | 1742 nt | TAAC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAAC]----3'WT+PolIII----[CACC]
   TAAC                     CACC 
```

**Set fidelity:** 0.9983 (2 overhangs)

---

### Tile 22 of 26 -- Codons 1252-1294 (129 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGA     | 0.8175   |
| oh2 (3' boundary) | CAAA     | 0.8948   |

**Variants:** 8190 mutations, 8190 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1631 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 702 nt  | CACA  | TTGG  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1474 nt | TTGG  | CAGA  |
| 4   | Oligo pool      | Tile 22 (8190 oligos) | 185 nt  | CAGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TTGG]----5'WT sub3----[CAGA]----oligo+BC----[AGAA]
   ATGG                   CACA                   TTGG                   CAGA                  AGAA 
```

**Set fidelity:** 0.8624 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile22_sub1    | 1625 nt | CAAA  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAA]----3'WT+PolIII----[CACC]
   CAAA                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 23 of 26 -- Codons 1291-1323 (99 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCT     | 0.7573   |
| oh2 (3' boundary) | CAGC     | 0.4815   |

**Variants:** 6090 mutations, 6090 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1631 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 702 nt  | CACA  | TTGG  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3  | 1591 nt | TTGG  | TCCT  |
| 4   | Oligo pool      | Tile 23 (6090 oligos) | 155 nt  | TCCT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TTGG]----5'WT sub3----[TCCT]----oligo+BC----[AGAA]
   ATGG                   CACA                   TTGG                   TCCT                  AGAA 
```

**Set fidelity:** 0.8677 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1538 nt | CAGC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAGC]----3'WT+PolIII----[CACC]
   CAGC                     CACC 
```

**Set fidelity:** 0.9358 (2 overhangs)

---

### Tile 24 of 26 -- Codons 1324-1390 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTTT     | 0.8623   |
| oh2 (3' boundary) | CCAG     | 0.6122   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 702 nt  | CACA  | TTGG  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3   | 1690 nt | TTGG  | TTTT  |
| 4   | Oligo pool      | Tile 24 (13230 oligos) | 257 nt  | TTTT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TTGG]----5'WT sub3----[TTTT]----oligo+BC----[AGAA]
   ATGG                   CACA                   TTGG                   TTTT                  AGAA 
```

**Set fidelity:** 0.8677 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile24         | 1337 nt | CCAG  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCAG]----3'WT+PolIII----[CACC]
   CCAG                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 25 of 26 -- Codons 1387-1423 (111 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACA     | 0.8652   |
| oh2 (3' boundary) | GCAT     | 0.5827   |

**Variants:** 6930 mutations, 6930 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1631 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 702 nt  | CACA  | TTGG  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3  | 1686 nt | TTGG  | CAGC  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4  | 211 nt  | CAGC  | TACA  |
| 5   | Oligo pool      | Tile 25 (6930 oligos) | 167 nt  | TACA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TTGG]----5'WT sub3----[CAGC]----5'WT sub4----[TACA]----oligo+BC----[AGAA]
   ATGG                   CACA                   TTGG                   CAGC                   TACA                  AGAA 
```

**Set fidelity:** 0.7906 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile25         | 1238 nt | GCAT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCAT]----3'WT+PolIII----[CACC]
   GCAT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 26 of 26 -- Codons 1420-1465 (138 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATG     | 0.6412   |
| oh2 (3' boundary) | TTAA     | 0.9448   |

**Variants:** 8820 mutations, 8820 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1631 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 702 nt  | CACA  | TTGG  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3  | 1686 nt | TTGG  | CAGC  |
| 4   | 5'WT gene block | bsai_5wt_tile26_sub4  | 310 nt  | CAGC  | AATG  |
| 5   | Oligo pool      | Tile 26 (8820 oligos) | 194 nt  | AATG  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TTGG]----5'WT sub3----[CAGC]----5'WT sub4----[AATG]----oligo+BC----[AGAA]
   ATGG                   CACA                   TTGG                   CAGC                   AATG                  AGAA 
```

**Set fidelity:** 0.8677 (6 overhangs)

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

**Total blocks:** 54

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| --------------------- | ----------- | ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| bsai_5wt_tile10_sub1  | 1635        | BsaI        | 5wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile11_sub1  | 1758        | BsaI        | 5wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile12_sub1  | 1631        | BsaI        | 5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1;5wt_tile26_sub1                                                                                                                                                                                                                                      |
| bsai_5wt_tile12_sub2  | 346         | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile13_sub2  | 502         | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile14_sub2  | 706         | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile15_sub2  | 826         | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile16_sub2  | 702         | BsaI        | 5wt_tile16_sub2;5wt_tile17_sub2;5wt_tile18_sub2;5wt_tile19_sub2;5wt_tile20_sub2;5wt_tile21_sub2;5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2;5wt_tile26_sub2                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile16_sub3  | 364         | BsaI        | 5wt_tile16_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile17_sub3  | 574         | BsaI        | 5wt_tile17_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile18_sub3  | 796         | BsaI        | 5wt_tile18_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile19_sub3  | 1006        | BsaI        | 5wt_tile19_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile2        | 165         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile20_sub3  | 1102        | BsaI        | 5wt_tile20_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile21_sub3  | 1297        | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile22_sub3  | 1474        | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile23_sub3  | 1591        | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile24_sub3  | 1690        | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile25_sub3  | 1686        | BsaI        | 5wt_tile25_sub3;5wt_tile26_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile25_sub4  | 211         | BsaI        | 5wt_tile25_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile26_sub4  | 310         | BsaI        | 5wt_tile26_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile3        | 387         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile4        | 555         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile5        | 705         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile6        | 855         | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile7        | 1065        | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile8        | 1224        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile9        | 1431        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile1_sub1  | 1476        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile1_sub2  | 702         | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile1_sub3  | 1686        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub2;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub1                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile1_sub4  | 1538        | BsmBI       | 3wt_polIII_tile1_sub4;3wt_polIII_tile2_sub4;3wt_polIII_tile3_sub4;3wt_polIII_tile4_sub4;3wt_polIII_tile5_sub4;3wt_polIII_tile6_sub4;3wt_polIII_tile7_sub4;3wt_polIII_tile8_sub3;3wt_polIII_tile9_sub3;3wt_polIII_tile10_sub3;3wt_polIII_tile11_sub3;3wt_polIII_tile12_sub3;3wt_polIII_tile13_sub2;3wt_polIII_tile14_sub2;3wt_polIII_tile15_sub2;3wt_polIII_tile16_sub2;3wt_polIII_tile17_sub2;3wt_polIII_tile18_sub2;3wt_polIII_tile19_sub2;3wt_polIII_tile20_sub2;3wt_polIII_tile23 |
| bsmbi_3wt_tile10_sub1 | 567         | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile11_sub1 | 366         | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile12_sub1 | 210         | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile14_sub1 | 1554        | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile15_sub1 | 1332        | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile16_sub1 | 1122        | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile17_sub1 | 900         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile18_sub1 | 690         | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile19_sub1 | 594         | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile2_sub1  | 1254        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile20_sub1 | 399         | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile21_sub1 | 1742        | BsmBI       | 3wt_polIII_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile22_sub1 | 1625        | BsmBI       | 3wt_polIII_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile24      | 1337        | BsmBI       | 3wt_polIII_tile24                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile25      | 1238        | BsmBI       | 3wt_polIII_tile25                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile3_sub1  | 1086        | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile4_sub1  | 936         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile5_sub1  | 786         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile6_sub1  | 576         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile7_sub1  | 417         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile8_sub1  | 894         | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_polIII_tile26   | 1112        | BsmBI       | polIII_tile26                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |

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

