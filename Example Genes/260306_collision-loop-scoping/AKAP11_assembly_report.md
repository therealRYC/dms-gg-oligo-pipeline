# DMS-GG Assembly Report: AKAP11

Generated: 2026-03-06 18:33:45
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                          |
| -------------------- | ------------------------------------------------------------------------------ |
| Gene name            | AKAP11_NM_016248.4_CDS Homo sapiens A-kinase anchoring protein 11 (AKAP11) CDS |
| CDS length           | 5706 nt (1902 codons)                                                          |
| Protein length       | 1901 aa                                                                        |
| Number of tiles      | 31                                                                             |
| Total variants       | 39858                                                                          |
| Total oligos         | 398580                                                                         |
| Oligo length range   | 167-290 nt                                                                     |
| Gene blocks to order | 65                                                                             |
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

**Total oligos:** 398580 | **Length range:** 167-290 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-37      | 6930   | 167 nt |
| 2    | 34-105    | 14280  | 272 nt |
| 3    | 102-162   | 11970  | 239 nt |
| 4    | 159-232   | 14700  | 278 nt |
| 5    | 229-281   | 10290  | 215 nt |
| 6    | 278-355   | 15540  | 290 nt |
| 7    | 352-416   | 12810  | 251 nt |
| 8    | 413-480   | 13440  | 260 nt |
| 9    | 477-539   | 12390  | 245 nt |
| 10   | 536-596   | 11970  | 239 nt |
| 11   | 593-668   | 15120  | 284 nt |
| 12   | 665-724   | 11760  | 236 nt |
| 13   | 721-797   | 15330  | 287 nt |
| 14   | 794-867   | 14700  | 278 nt |
| 15   | 864-917   | 10500  | 218 nt |
| 16   | 914-988   | 14910  | 281 nt |
| 17   | 985-1049  | 12810  | 251 nt |
| 18   | 1046-1106 | 11970  | 239 nt |
| 19   | 1103-1165 | 12390  | 245 nt |
| 20   | 1162-1224 | 12390  | 245 nt |
| 21   | 1221-1283 | 12390  | 245 nt |
| 22   | 1280-1356 | 15330  | 287 nt |
| 23   | 1353-1427 | 14910  | 281 nt |
| 24   | 1424-1494 | 14070  | 269 nt |
| 25   | 1491-1557 | 13230  | 257 nt |
| 26   | 1554-1630 | 15330  | 287 nt |
| 27   | 1627-1694 | 13440  | 260 nt |
| 28   | 1691-1755 | 12810  | 251 nt |
| 29   | 1752-1814 | 12390  | 245 nt |
| 30   | 1811-1863 | 10290  | 215 nt |
| 31   | 1860-1902 | 8190   | 185 nt |

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
| Total barcodes    | 398580                             |
| Unique barcodes   | 398580                             |
| GC content range  | 25% - 75%                          |
| GC content mean   | 48.4%                              |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                  | Description                                                   | Result | Detail                                                                                                                                              |
| ---------------------- | ------------------------------------------------------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths          | All oligos within synthesis length limit                      | PASS   | Range: 167-290 nt (limit: 300)                                                                                                                      |
| block_lengths          | All gene blocks within synthesis length limit                 | PASS   | Range: 117-1788 nt (limit: 1800)                                                                                                                    |
| barcode_junction_sites | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='TTCCTG')                                                                             |
| barcode_uniqueness     | All barcodes are unique                                       | PASS   | 398580 unique / 398580 total                                                                                                                        |
| tile_coverage          | Tiles cover entire gene without gaps                          | PASS   | 5706 / 5706 nt covered                                                                                                                              |
| variant_count          | Expected number of variants generated                         | PASS   | 39858 unique variants (expected: 39858 across 1898/1900 mutable positions; 36062 missense + 1898 nonsense + 1898 wt_control; 2 position(s) skipped) |
| single_codon_change    | Each non-control variant differs by exactly one codon from WT | PASS   | 379600 / 379600 variants confirmed (WT controls excluded)                                                                                           |
| oligo_gc_content       | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 33.1-52.7% | 0 oligo(s) with extreme GC                                                                                                   |
| domestication_complete | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                             |
| overhang_fidelity      | Tile boundary overhangs have adequate fidelity                | FAIL   | 23 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                             |
| tile_manifests         | Per-tile assembly manifests complete                          | PASS   | 31 tile manifest(s) generated                                                                                                                       |
| helper_plasmid         | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                  |
| reaction_fidelity      | Per-reaction set-level overhang fidelity                      | PASS   | Min set fidelity: 0.8615 across 62 reactions | 1 reaction(s) below 0.90                                                                             |
| barcode_poliii_term    | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 398580 barcode(s) contain TTTT                                                                                                                  |
| block_min_length       | All gene blocks above synthesis minimum length                | FAIL   | 5 block(s) below 300 nt minimum. Range: 117-1788 nt                                                                                                 |
| sb_overhang_collisions | Superblock boundary overhangs are unique (no collisions)      | PASS   | 5 SB boundary OH(s), all unique                                                                                                                     |

## 6. Fixed Overhangs & Helper Plasmid

These overhangs are the same across all tile reactions:

| Overhang    | Sequence | Role                                                    |
| ----------- | -------- | ------------------------------------------------------- |
| oh_L        | ATGG     | Gene start (BsaI, all tiles)                            |
| oh3         | CACC     | Downstream cassette-barcode junction (BsmBI, all tiles) |
| oh4         | TTCC     | Barcode-helper junction (BsaI, all tiles)               |
| paqci_star2 | AATG     | PaqCI 5' end of insert (Level 2)                        |
| paqci_star1 | GCTA     | PaqCI 3' end of insert (Level 2)                        |

### Helper Plasmid Insert

The helper plasmid provides the backbone for each BsaI Level 1 reaction.

```
[PaqCI**]--[BsaI>>ATGG]--STUFFER--[TTCC<<BsaI]--[PaqCI*]
```

Insert length: 72 nt
oh_L = ATGG (first 4 nt of gene)
oh_R = TTCC (= oh4, barcode-helper junction)

## 7. Per-Tile Assembly Guide

### Tile 1 of 31 -- Codons 1-37 (111 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGG     | 0.5393   |
| oh2 (3' boundary) | ACTA     | 0.7946   |

**Variants:** 6930 mutations, 6930 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (6930 oligos)               | 167 nt | ATGG  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert              | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart               | --     | --    | --    |

```
  [ATGG]----oligo+BC----[TTCC]
   ATGG                  TTCC 
```

**Set fidelity:** 1.0000 (2 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1     | 393 nt  | ACTA  | TCAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1536 nt | TCAG  | TCCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1686 nt | TCCT  | TCAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | TCAA  | GAAT  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACTA]----3'WT sub1----[TCAG]----3'WT sub2----[TCCT]----3'WT sub3----[TCAA]----3'WT sub4----[GAAT]----3'WT+PolIII sub5----[CACC]
   ACTA                   TCAG                   TCCT                   TCAA                   GAAT                          CACC 
```

**Set fidelity:** 0.9553 (6 overhangs)

---

### Tile 2 of 31 -- Codons 34-105 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGA     | 0.8175   |
| oh2 (3' boundary) | AAAT     | 0.7737   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 117 nt | ATGG  | CAGA  |
| 2   | Oligo pool      | Tile 2 (14280 oligos) | 272 nt | CAGA  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[CAGA]----oligo+BC----[TTCC]
   ATGG                    CAGA                  TTCC 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1     | 1707 nt | AAAT  | TCAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1686 nt | TCAG  | TCCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | TCCT  | TCAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | TCAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAT]----3'WT sub1----[TCAG]----3'WT sub2----[TCCT]----3'WT sub3----[TCAA]----3'WT+PolIII sub4----[GAAT][CACC]
   AAAT                   TCAG                   TCCT                   TCAA                          GAAT  CACC 
```

**Set fidelity:** 0.8615 (6 overhangs)

---

### Tile 3 of 31 -- Codons 102-162 (183 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | TCAG     | 0.7814   |

**Variants:** 11970 mutations, 11970 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 321 nt | ATGG  | AAGA  |
| 2   | Oligo pool      | Tile 3 (11970 oligos) | 239 nt | AAGA  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[AAGA]----oligo+BC----[TTCC]
   ATGG                    AAGA                  TTCC 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1536 nt | TCAG  | TCCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1686 nt | TCCT  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | TCAA  | GAAT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAG]----3'WT sub1----[TCCT]----3'WT sub2----[TCAA]----3'WT sub3----[GAAT]----3'WT+PolIII sub4----[CACC]
   TCAG                   TCCT                   TCAA                   GAAT                          CACC 
```

**Set fidelity:** 0.9553 (5 overhangs)

---

### Tile 4 of 31 -- Codons 159-232 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCT     | 0.8181   |
| oh2 (3' boundary) | TGAT     | 0.6933   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 492 nt | ATGG  | TTCT  |
| 2   | Oligo pool      | Tile 4 (14700 oligos) | 278 nt | TTCT  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[TTCT]----oligo+BC----[TTCC]
   ATGG                    TTCT                  TTCC 
```

**Set fidelity:** 0.9485 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1     | 1326 nt | TGAT  | TCCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1686 nt | TCCT  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | TCAA  | GAAT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAT]----3'WT sub1----[TCCT]----3'WT sub2----[TCAA]----3'WT sub3----[GAAT]----3'WT+PolIII sub4----[CACC]
   TGAT                   TCCT                   TCAA                   GAAT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 5 of 31 -- Codons 229-281 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | TTTC     | 0.8348   |

**Variants:** 10290 mutations, 10290 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5_sub1   | 702 nt | ATGG  | GAAA  |
| 2   | Oligo pool      | Tile 5 (10290 oligos) | 215 nt | GAAA  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT sub1----[TCAG]----oligo+BC----[GAAA][TTCC]
   ATGG                   TCAG                  GAAA  TTCC 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1     | 1179 nt | TTTC  | TCCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1686 nt | TCCT  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | TCAA  | GAAT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTTC]----3'WT sub1----[TCCT]----3'WT sub2----[TCAA]----3'WT sub3----[GAAT]----3'WT+PolIII sub4----[CACC]
   TTTC                   TCCT                   TCAA                   GAAT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 6 of 31 -- Codons 278-355 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAAA     | 0.8948   |
| oh2 (3' boundary) | ATTT     | 0.7664   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1   | 500 nt | ATGG  | TCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile6_sub2   | 367 nt | TCAG  | CAAA  |
| 3   | Oligo pool      | Tile 6 (15540 oligos) | 290 nt | CAAA  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT sub1----[TCAG]----5'WT sub2----[CAAA]----oligo+BC----[TTCC]
   ATGG                   TCAG                   CAAA                  TTCC 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1     | 957 nt  | ATTT  | TCCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1686 nt | TCCT  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | TCAA  | GAAT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATTT]----3'WT sub1----[TCCT]----3'WT sub2----[TCAA]----3'WT sub3----[GAAT]----3'WT+PolIII sub4----[CACC]
   ATTT                   TCCT                   TCAA                   GAAT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 7 of 31 -- Codons 352-416 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTAA     | 0.8029   |
| oh2 (3' boundary) | AACT     | 0.6635   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1   | 500 nt | ATGG  | TCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile7_sub2   | 589 nt | TCAG  | GTAA  |
| 3   | Oligo pool      | Tile 7 (12810 oligos) | 251 nt | GTAA  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT sub1----[TCAG]----5'WT sub2----[GTAA]----oligo+BC----[TTCC]
   ATGG                   TCAG                   GTAA                  TTCC 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1     | 774 nt  | AACT  | TCCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1686 nt | TCCT  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | TCAA  | GAAT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AACT]----3'WT sub1----[TCCT]----3'WT sub2----[TCAA]----3'WT sub3----[GAAT]----3'WT+PolIII sub4----[CACC]
   AACT                   TCCT                   TCAA                   GAAT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 8 of 31 -- Codons 413-480 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGAA     | 0.8847   |
| oh2 (3' boundary) | AAAT     | 0.7737   |

**Variants:** 13440 mutations, 13440 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1   | 500 nt | ATGG  | TCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile8_sub2   | 772 nt | TCAG  | AGAA  |
| 3   | Oligo pool      | Tile 8 (13440 oligos) | 260 nt | AGAA  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT sub1----[TCAG]----5'WT sub2----[AGAA]----oligo+BC----[TTCC]
   ATGG                   TCAG                   AGAA                  TTCC 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1     | 582 nt  | AAAT  | TCCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1686 nt | TCCT  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | TCAA  | GAAT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAT]----3'WT sub1----[TCCT]----3'WT sub2----[TCAA]----3'WT sub3----[GAAT]----3'WT+PolIII sub4----[CACC]
   AAAT                   TCCT                   TCAA                   GAAT                          CACC 
```

**Set fidelity:** 0.9018 (5 overhangs)

---

### Tile 9 of 31 -- Codons 477-539 (189 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTC     | 0.7084   |
| oh2 (3' boundary) | ATCT     | 0.7151   |

**Variants:** 12390 mutations, 12390 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1   | 500 nt | ATGG  | TCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile9_sub2   | 964 nt | TCAG  | ATTC  |
| 3   | Oligo pool      | Tile 9 (12390 oligos) | 245 nt | ATTC  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT sub1----[TCAG]----5'WT sub2----[ATTC]----oligo+BC----[TTCC]
   ATGG                   TCAG                   ATTC                  TTCC 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1     | 405 nt  | ATCT  | TCCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1686 nt | TCCT  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | TCAA  | GAAT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATCT]----3'WT sub1----[TCCT]----3'WT sub2----[TCAA]----3'WT sub3----[GAAT]----3'WT+PolIII sub4----[CACC]
   ATCT                   TCCT                   TCAA                   GAAT                          CACC 
```

**Set fidelity:** 0.9987 (5 overhangs)

---

### Tile 10 of 31 -- Codons 536-596 (183 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAA     | 0.9502   |
| oh2 (3' boundary) | ATTT     | 0.7664   |

**Variants:** 11970 mutations, 11970 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 500 nt  | ATGG  | TCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile10_sub2   | 1141 nt | TCAG  | AAAA  |
| 3   | Oligo pool      | Tile 10 (11970 oligos) | 239 nt  | AAAA  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TCAG]----5'WT sub2----[AAAA]----oligo+BC----[TTCC]
   ATGG                   TCAG                   AAAA                  TTCC 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1    | 234 nt  | ATTT  | TCCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1686 nt | TCCT  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | TCAA  | GAAT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATTT]----3'WT sub1----[TCCT]----3'WT sub2----[TCAA]----3'WT sub3----[GAAT]----3'WT+PolIII sub4----[CACC]
   ATTT                   TCCT                   TCAA                   GAAT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 11 of 31 -- Codons 593-668 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGA     | 0.8175   |
| oh2 (3' boundary) | TCCT     | 0.7573   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 500 nt  | ATGG  | TCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile11_sub2   | 1312 nt | TCAG  | CAGA  |
| 3   | Oligo pool      | Tile 11 (15120 oligos) | 284 nt  | CAGA  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TCAG]----5'WT sub2----[CAGA]----oligo+BC----[TTCC]
   ATGG                   TCAG                   CAGA                  TTCC 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1686 nt | TCCT  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | TCAA  | GAAT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCCT]----3'WT sub1----[TCAA]----3'WT sub2----[GAAT]----3'WT+PolIII sub3----[CACC]
   TCCT                   TCAA                   GAAT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 12 of 31 -- Codons 665-724 (180 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTTT     | 0.8623   |
| oh2 (3' boundary) | TAAT     | 0.8165   |

**Variants:** 11760 mutations, 11760 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 500 nt  | ATGG  | TCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2   | 1528 nt | TCAG  | TTTT  |
| 3   | Oligo pool      | Tile 12 (11760 oligos) | 236 nt  | TTTT  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TCAG]----5'WT sub2----[TTTT]----oligo+BC----[TTCC]
   ATGG                   TCAG                   TTTT                  TTCC 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1    | 1518 nt | TAAT  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | TCAA  | GAAT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAAT]----3'WT sub1----[TCAA]----3'WT sub2----[GAAT]----3'WT+PolIII sub3----[CACC]
   TAAT                   TCAA                   GAAT                          CACC 
```

**Set fidelity:** 0.9307 (4 overhangs)

---

### Tile 13 of 31 -- Codons 721-797 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTA     | 0.8892   |
| oh2 (3' boundary) | TACT     | 0.7445   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 500 nt  | ATGG  | TCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 1696 nt | TCAG  | TCTA  |
| 3   | Oligo pool      | Tile 13 (15330 oligos) | 287 nt  | TCTA  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TCAG]----5'WT sub2----[TCCT]----oligo+BC----[TCTA][TTCC]
   ATGG                   TCAG                   TCCT                  TCTA  TTCC 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1    | 1299 nt | TACT  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | TCAA  | GAAT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TACT]----3'WT sub1----[TCAA]----3'WT sub2----[GAAT]----3'WT+PolIII sub3----[CACC]
   TACT                   TCAA                   GAAT                          CACC 
```

**Set fidelity:** 0.9986 (4 overhangs)

---

### Tile 14 of 31 -- Codons 794-867 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTT     | 0.7664   |
| oh2 (3' boundary) | AAAT     | 0.7737   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 500 nt  | ATGG  | TCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1536 nt | TCAG  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile14_sub3   | 397 nt  | TCCT  | ATTT  |
| 4   | Oligo pool      | Tile 14 (14700 oligos) | 278 nt  | ATTT  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TCAG]----5'WT sub2----[TCCT]----5'WT sub3----[ATTT]----oligo+BC----[TTCC]
   ATGG                   TCAG                   TCCT                   ATTT                  TTCC 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1    | 1089 nt | AAAT  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | TCAA  | GAAT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAT]----3'WT sub1----[TCAA]----3'WT sub2----[GAAT]----3'WT+PolIII sub3----[CACC]
   AAAT                   TCAA                   GAAT                          CACC 
```

**Set fidelity:** 0.9018 (4 overhangs)

---

### Tile 15 of 31 -- Codons 864-917 (162 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAT     | 0.7737   |
| oh2 (3' boundary) | TCCA     | 0.8519   |

**Variants:** 10500 mutations, 10500 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 500 nt  | ATGG  | TCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1536 nt | TCAG  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile15_sub3   | 607 nt  | TCCT  | AAAT  |
| 4   | Oligo pool      | Tile 15 (10500 oligos) | 218 nt  | AAAT  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TCAG]----5'WT sub2----[TCCT]----5'WT sub3----[AAAT]----oligo+BC----[TTCC]
   ATGG                   TCAG                   TCCT                   AAAT                  TTCC 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1    | 939 nt  | TCCA  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | TCAA  | GAAT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCCA]----3'WT sub1----[TCAA]----3'WT sub2----[GAAT]----3'WT+PolIII sub3----[CACC]
   TCCA                   TCAA                   GAAT                          CACC 
```

**Set fidelity:** 0.9954 (4 overhangs)

---

### Tile 16 of 31 -- Codons 914-988 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAA     | 0.9502   |
| oh2 (3' boundary) | ATTT     | 0.7664   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 500 nt  | ATGG  | TCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1536 nt | TCAG  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile16_sub3   | 757 nt  | TCCT  | AAAA  |
| 4   | Oligo pool      | Tile 16 (14910 oligos) | 281 nt  | AAAA  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TCAG]----5'WT sub2----[TCCT]----5'WT sub3----[AAAA]----oligo+BC----[TTCC]
   ATGG                   TCAG                   TCCT                   AAAA                  TTCC 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1    | 726 nt  | ATTT  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | TCAA  | GAAT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATTT]----3'WT sub1----[TCAA]----3'WT sub2----[GAAT]----3'WT+PolIII sub3----[CACC]
   ATTT                   TCAA                   GAAT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 17 of 31 -- Codons 985-1049 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTC     | 0.8105   |
| oh2 (3' boundary) | TAAC     | 0.7715   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 500 nt  | ATGG  | TCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1536 nt | TCAG  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile17_sub3   | 970 nt  | TCCT  | TCTC  |
| 4   | Oligo pool      | Tile 17 (12810 oligos) | 251 nt  | TCTC  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TCAG]----5'WT sub2----[TCCT]----5'WT sub3----[TCTC]----oligo+BC----[TTCC]
   ATGG                   TCAG                   TCCT                   TCTC                  TTCC 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1    | 543 nt  | TAAC  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | TCAA  | GAAT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAAC]----3'WT sub1----[TCAA]----3'WT sub2----[GAAT]----3'WT+PolIII sub3----[CACC]
   TAAC                   TCAA                   GAAT                          CACC 
```

**Set fidelity:** 0.9970 (4 overhangs)

---

### Tile 18 of 31 -- Codons 1046-1106 (183 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAA     | 0.9502   |
| oh2 (3' boundary) | TCTA     | 0.8892   |

**Variants:** 11970 mutations, 11970 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 500 nt  | ATGG  | TCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1536 nt | TCAG  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile18_sub3   | 1153 nt | TCCT  | AAAA  |
| 4   | Oligo pool      | Tile 18 (11970 oligos) | 239 nt  | AAAA  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TCAG]----5'WT sub2----[TCCT]----5'WT sub3----[AAAA]----oligo+BC----[TTCC]
   ATGG                   TCAG                   TCCT                   AAAA                  TTCC 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1    | 372 nt  | TCTA  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | TCAA  | GAAT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCTA]----3'WT sub1----[TCAA]----3'WT sub2----[GAAT]----3'WT+PolIII sub3----[CACC]
   TCTA                   TCAA                   GAAT                          CACC 
```

**Set fidelity:** 0.9953 (4 overhangs)

---

### Tile 19 of 31 -- Codons 1103-1165 (189 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAA     | 0.9425   |
| oh2 (3' boundary) | GAAA     | 0.8745   |

**Variants:** 12390 mutations, 12390 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 500 nt  | ATGG  | TCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1536 nt | TCAG  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3   | 1324 nt | TCCT  | TCAA  |
| 4   | Oligo pool      | Tile 19 (12390 oligos) | 245 nt  | TCAA  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TCAG]----5'WT sub2----[TCCT]----5'WT sub3----[TCAA]----oligo+BC----[TTCC]
   ATGG                   TCAG                   TCCT                   TCAA                  TTCC 
```

**Set fidelity:** 0.9448 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1    | 195 nt  | GAAA  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | TCAA  | GAAT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAA]----3'WT sub1----[TCAA]----3'WT sub2----[GAAT]----3'WT+PolIII sub3----[CACC]
   GAAA                   TCAA                   GAAT                          CACC 
```

**Set fidelity:** 0.9146 (4 overhangs)

---

### Tile 20 of 31 -- Codons 1162-1224 (189 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCA     | 0.8824   |
| oh2 (3' boundary) | TCAA     | 0.9425   |

**Variants:** 12390 mutations, 12390 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 500 nt  | ATGG  | TCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1536 nt | TCAG  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile20_sub3   | 1501 nt | TCCT  | TTCA  |
| 4   | Oligo pool      | Tile 20 (12390 oligos) | 245 nt  | TTCA  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TCAG]----5'WT sub2----[TCCT]----5'WT sub3----[TTCA]----oligo+BC----[TTCC]
   ATGG                   TCAG                   TCCT                   TTCA                  TTCC 
```

**Set fidelity:** 0.9899 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | TCAA  | GAAT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAA]----3'WT sub1----[GAAT]----3'WT+PolIII sub2----[CACC]
   TCAA                   GAAT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 21 of 31 -- Codons 1221-1283 (189 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAA     | 0.9502   |
| oh2 (3' boundary) | TTTC     | 0.8348   |

**Variants:** 12390 mutations, 12390 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 500 nt  | ATGG  | TCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1536 nt | TCAG  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3   | 1678 nt | TCCT  | AAAA  |
| 4   | Oligo pool      | Tile 21 (12390 oligos) | 245 nt  | AAAA  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TCAG]----5'WT sub2----[TCCT]----5'WT sub3----[AAAA]----oligo+BC----[TTCC]
   ATGG                   TCAG                   TCCT                   AAAA                  TTCC 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1    | 1611 nt | TTTC  | GAAT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTTC]----3'WT sub1----[GAAT]----3'WT+PolIII sub2----[CACC]
   TTTC                   GAAT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 22 of 31 -- Codons 1280-1356 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TGTA     | 0.7693   |
| oh2 (3' boundary) | GGAA     | 0.7463   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 500 nt  | ATGG  | TCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1536 nt | TCAG  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1686 nt | TCCT  | TCAA  |
| 4   | 5'WT gene block | bsai_5wt_tile22_sub4   | 187 nt  | TCAA  | TGTA  |
| 5   | Oligo pool      | Tile 22 (15330 oligos) | 287 nt  | TGTA  | TTCC  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TCAG]----5'WT sub2----[TCCT]----5'WT sub3----[TCAA]----5'WT sub4----[TGTA]----oligo+BC----[TTCC]
   ATGG                   TCAG                   TCCT                   TCAA                   TGTA                  TTCC 
```

**Set fidelity:** 0.9448 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1    | 1392 nt | GGAA  | GAAT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAA]----3'WT sub1----[GAAT]----3'WT+PolIII sub2----[CACC]
   GGAA                   GAAT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 23 of 31 -- Codons 1353-1427 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTAA     | 0.8691   |
| oh2 (3' boundary) | AAGT     | 0.7629   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 500 nt  | ATGG  | TCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1536 nt | TCAG  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1686 nt | TCCT  | TCAA  |
| 4   | 5'WT gene block | bsai_5wt_tile23_sub4   | 406 nt  | TCAA  | CTAA  |
| 5   | Oligo pool      | Tile 23 (14910 oligos) | 281 nt  | CTAA  | TTCC  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TCAG]----5'WT sub2----[TCCT]----5'WT sub3----[TCAA]----5'WT sub4----[CTAA]----oligo+BC----[TTCC]
   ATGG                   TCAG                   TCCT                   TCAA                   CTAA                  TTCC 
```

**Set fidelity:** 0.9448 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1    | 1179 nt | AAGT  | GAAT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAGT]----3'WT sub1----[GAAT]----3'WT+PolIII sub2----[CACC]
   AAGT                   GAAT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 24 of 31 -- Codons 1424-1494 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | TGGA     | 0.7377   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 500 nt  | ATGG  | TCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1536 nt | TCAG  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1686 nt | TCCT  | TCAA  |
| 4   | 5'WT gene block | bsai_5wt_tile24_sub4   | 619 nt  | TCAA  | AAGA  |
| 5   | Oligo pool      | Tile 24 (14070 oligos) | 269 nt  | AAGA  | TTCC  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TCAG]----5'WT sub2----[TCCT]----5'WT sub3----[TCAA]----5'WT sub4----[AAGA]----oligo+BC----[TTCC]
   ATGG                   TCAG                   TCCT                   TCAA                   AAGA                  TTCC 
```

**Set fidelity:** 0.9448 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile24_sub1    | 978 nt  | TGGA  | GAAT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGGA]----3'WT sub1----[GAAT]----3'WT+PolIII sub2----[CACC]
   TGGA                   GAAT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 25 of 31 -- Codons 1491-1557 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | AGGA     | 0.7515   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 500 nt  | ATGG  | TCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1536 nt | TCAG  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1686 nt | TCCT  | TCAA  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4   | 820 nt  | TCAA  | GAAA  |
| 5   | Oligo pool      | Tile 25 (13230 oligos) | 257 nt  | GAAA  | TTCC  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TCAG]----5'WT sub2----[TCCT]----5'WT sub3----[TCAA]----5'WT sub4----[GAAA]----oligo+BC----[TTCC]
   ATGG                   TCAG                   TCCT                   TCAA                   GAAA                  TTCC 
```

**Set fidelity:** 0.9448 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile25_sub1    | 789 nt  | AGGA  | GAAT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGGA]----3'WT sub1----[GAAT]----3'WT+PolIII sub2----[CACC]
   AGGA                   GAAT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 26 of 31 -- Codons 1554-1630 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTAA     | 0.8691   |
| oh2 (3' boundary) | ATCT     | 0.7151   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 500 nt  | ATGG  | TCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1536 nt | TCAG  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1686 nt | TCCT  | TCAA  |
| 4   | 5'WT gene block | bsai_5wt_tile26_sub4   | 1009 nt | TCAA  | CTAA  |
| 5   | Oligo pool      | Tile 26 (15330 oligos) | 287 nt  | CTAA  | TTCC  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TCAG]----5'WT sub2----[TCCT]----5'WT sub3----[TCAA]----5'WT sub4----[CTAA]----oligo+BC----[TTCC]
   ATGG                   TCAG                   TCCT                   TCAA                   CTAA                  TTCC 
```

**Set fidelity:** 0.9448 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile26_sub1    | 570 nt  | ATCT  | GAAT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATCT]----3'WT sub1----[GAAT]----3'WT+PolIII sub2----[CACC]
   ATCT                   GAAT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 27 of 31 -- Codons 1627-1694 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TATC     | 0.8041   |
| oh2 (3' boundary) | GACA     | 0.6127   |

**Variants:** 13440 mutations, 13440 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 500 nt  | ATGG  | TCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1536 nt | TCAG  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1686 nt | TCCT  | TCAA  |
| 4   | 5'WT gene block | bsai_5wt_tile27_sub4   | 1228 nt | TCAA  | TATC  |
| 5   | Oligo pool      | Tile 27 (13440 oligos) | 260 nt  | TATC  | TTCC  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TCAG]----5'WT sub2----[TCCT]----5'WT sub3----[TCAA]----5'WT sub4----[TATC]----oligo+BC----[TTCC]
   ATGG                   TCAG                   TCCT                   TCAA                   TATC                  TTCC 
```

**Set fidelity:** 0.9448 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile27_sub1    | 378 nt  | GACA  | GAAT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GACA]----3'WT sub1----[GAAT]----3'WT+PolIII sub2----[CACC]
   GACA                   GAAT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 28 of 31 -- Codons 1691-1755 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | TCTA     | 0.8892   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 500 nt  | ATGG  | TCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1536 nt | TCAG  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1686 nt | TCCT  | TCAA  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4   | 1420 nt | TCAA  | GAAA  |
| 5   | Oligo pool      | Tile 28 (12810 oligos) | 251 nt  | GAAA  | TTCC  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TCAG]----5'WT sub2----[TCCT]----5'WT sub3----[TCAA]----5'WT sub4----[GAAA]----oligo+BC----[TTCC]
   ATGG                   TCAG                   TCCT                   TCAA                   GAAA                  TTCC 
```

**Set fidelity:** 0.9448 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile28_sub1    | 1553 nt | TCTA  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCTA]----3'WT+PolIII sub1----[GAAT][CACC]
   TCTA                          GAAT  CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 29 of 31 -- Codons 1752-1814 (189 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTTC     | 0.8348   |
| oh2 (3' boundary) | GAAT     | 0.7246   |

**Variants:** 12390 mutations, 12390 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 500 nt  | ATGG  | TCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1536 nt | TCAG  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1686 nt | TCCT  | TCAA  |
| 4   | 5'WT gene block | bsai_5wt_tile29_sub4   | 1603 nt | TCAA  | TTTC  |
| 5   | Oligo pool      | Tile 29 (12390 oligos) | 245 nt  | TTTC  | TTCC  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TCAG]----5'WT sub2----[TCCT]----5'WT sub3----[TCAA]----5'WT sub4----[TTTC]----oligo+BC----[TTCC]
   ATGG                   TCAG                   TCCT                   TCAA                   TTTC                  TTCC 
```

**Set fidelity:** 0.9140 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAT]----3'WT+PolIII----[CACC]
   GAAT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 30 of 31 -- Codons 1811-1863 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTAA     | 0.8691   |
| oh2 (3' boundary) | GAAA     | 0.8745   |

**Variants:** 10290 mutations, 10290 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 500 nt  | ATGG  | TCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1536 nt | TCAG  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1686 nt | TCCT  | TCAA  |
| 4   | 5'WT gene block | bsai_5wt_tile30_sub4   | 1780 nt | TCAA  | CTAA  |
| 5   | Oligo pool      | Tile 30 (10290 oligos) | 215 nt  | CTAA  | TTCC  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TCAG]----5'WT sub2----[TCCT]----5'WT sub3----[TCAA]----5'WT sub4----[CTAA]----oligo+BC----[TTCC]
   ATGG                   TCAG                   TCCT                   TCAA                   CTAA                  TTCC 
```

**Set fidelity:** 0.9448 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile30         | 1229 nt | GAAA  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAA]----3'WT+PolIII----[CACC]
   GAAA                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 31 of 31 -- Codons 1860-1902 (129 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAC     | 0.8333   |
| oh2 (3' boundary) | ATAG     | 0.7330   |

**Variants:** 8190 mutations, 8190 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1   | 500 nt  | ATGG  | TCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2  | 1536 nt | TCAG  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1686 nt | TCCT  | TCAA  |
| 4   | 5'WT gene block | bsai_5wt_tile31_sub4  | 1788 nt | TCAA  | GAAT  |
| 5   | 5'WT gene block | bsai_5wt_tile31_sub5  | 157 nt  | GAAT  | TTAC  |
| 6   | Oligo pool      | Tile 31 (8190 oligos) | 185 nt  | TTAC  | TTCC  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TCAG]----5'WT sub2----[TCCT]----5'WT sub3----[TCAA]----5'WT sub4----[GAAT]----5'WT sub5----[TTAC]----oligo+BC----[TTCC]
   ATGG                   TCAG                   TCCT                   TCAA                   GAAT                   TTAC                  TTCC 
```

**Set fidelity:** 0.9306 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component            | Part name                | Length  | 5' OH | 3' OH |
| --- | -------------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product         | (in helper plasmid)      | --      | --    | --    |
| 2   | PolIII-only fragment | bsmbi_polIII_tile31      | 1112 nt | ATAG  | CACC  |
| 3   | Enzyme + buffer      | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATAG]----PolIII----[CACC]
   ATAG                CACC 
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

**Total blocks:** 65

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| --------------------- | ----------- | ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10_sub2  | 1141        | BsaI        | 5wt_tile10_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile11_sub2  | 1312        | BsaI        | 5wt_tile11_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile12_sub2  | 1528        | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile13_sub2  | 1696        | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile14_sub2  | 1536        | BsaI        | 5wt_tile14_sub2;5wt_tile15_sub2;5wt_tile16_sub2;5wt_tile17_sub2;5wt_tile18_sub2;5wt_tile19_sub2;5wt_tile20_sub2;5wt_tile21_sub2;5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2;5wt_tile26_sub2;5wt_tile27_sub2;5wt_tile28_sub2;5wt_tile29_sub2;5wt_tile30_sub2;5wt_tile31_sub2                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile14_sub3  | 397         | BsaI        | 5wt_tile14_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile15_sub3  | 607         | BsaI        | 5wt_tile15_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile16_sub3  | 757         | BsaI        | 5wt_tile16_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile17_sub3  | 970         | BsaI        | 5wt_tile17_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile18_sub3  | 1153        | BsaI        | 5wt_tile18_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile19_sub3  | 1324        | BsaI        | 5wt_tile19_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile2        | 117         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile20_sub3  | 1501        | BsaI        | 5wt_tile20_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile21_sub3  | 1678        | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile22_sub3  | 1686        | BsaI        | 5wt_tile22_sub3;5wt_tile23_sub3;5wt_tile24_sub3;5wt_tile25_sub3;5wt_tile26_sub3;5wt_tile27_sub3;5wt_tile28_sub3;5wt_tile29_sub3;5wt_tile30_sub3;5wt_tile31_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile22_sub4  | 187         | BsaI        | 5wt_tile22_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile23_sub4  | 406         | BsaI        | 5wt_tile23_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile24_sub4  | 619         | BsaI        | 5wt_tile24_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile25_sub4  | 820         | BsaI        | 5wt_tile25_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile26_sub4  | 1009        | BsaI        | 5wt_tile26_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile27_sub4  | 1228        | BsaI        | 5wt_tile27_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile28_sub4  | 1420        | BsaI        | 5wt_tile28_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile29_sub4  | 1603        | BsaI        | 5wt_tile29_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile3        | 321         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile30_sub4  | 1780        | BsaI        | 5wt_tile30_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile31_sub4  | 1788        | BsaI        | 5wt_tile31_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile31_sub5  | 157         | BsaI        | 5wt_tile31_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile4        | 492         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile5_sub1   | 702         | BsaI        | 5wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile6_sub1   | 500         | BsaI        | 5wt_tile6_sub1;5wt_tile7_sub1;5wt_tile8_sub1;5wt_tile9_sub1;5wt_tile10_sub1;5wt_tile11_sub1;5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1;5wt_tile26_sub1;5wt_tile27_sub1;5wt_tile28_sub1;5wt_tile29_sub1;5wt_tile30_sub1;5wt_tile31_sub1                                                                                                                                                                                                                           |
| bsai_5wt_tile6_sub2   | 367         | BsaI        | 5wt_tile6_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile7_sub2   | 589         | BsaI        | 5wt_tile7_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile8_sub2   | 772         | BsaI        | 5wt_tile8_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile9_sub2   | 964         | BsaI        | 5wt_tile9_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile1_sub1  | 393         | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile1_sub2  | 1536        | BsmBI       | 3wt_tile1_sub2;3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile1_sub3  | 1686        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile8_sub2;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile1_sub4  | 1788        | BsmBI       | 3wt_tile1_sub4;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub3;3wt_tile9_sub3;3wt_tile10_sub3;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2;3wt_tile16_sub2;3wt_tile17_sub2;3wt_tile18_sub2;3wt_tile19_sub2;3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile1_sub5  | 1376        | BsmBI       | 3wt_polIII_tile1_sub5;3wt_polIII_tile2_sub4;3wt_polIII_tile3_sub4;3wt_polIII_tile4_sub4;3wt_polIII_tile5_sub4;3wt_polIII_tile6_sub4;3wt_polIII_tile7_sub4;3wt_polIII_tile8_sub4;3wt_polIII_tile9_sub4;3wt_polIII_tile10_sub4;3wt_polIII_tile11_sub3;3wt_polIII_tile12_sub3;3wt_polIII_tile13_sub3;3wt_polIII_tile14_sub3;3wt_polIII_tile15_sub3;3wt_polIII_tile16_sub3;3wt_polIII_tile17_sub3;3wt_polIII_tile18_sub3;3wt_polIII_tile19_sub3;3wt_polIII_tile20_sub2;3wt_polIII_tile21_sub2;3wt_polIII_tile22_sub2;3wt_polIII_tile23_sub2;3wt_polIII_tile24_sub2;3wt_polIII_tile25_sub2;3wt_polIII_tile26_sub2;3wt_polIII_tile27_sub2;3wt_polIII_tile29 |
| bsmbi_3wt_tile10_sub1 | 234         | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile12_sub1 | 1518        | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile13_sub1 | 1299        | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile14_sub1 | 1089        | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile15_sub1 | 939         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile16_sub1 | 726         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile17_sub1 | 543         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile18_sub1 | 372         | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile19_sub1 | 195         | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile2_sub1  | 1707        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile21_sub1 | 1611        | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile22_sub1 | 1392        | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile23_sub1 | 1179        | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile24_sub1 | 978         | BsmBI       | 3wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile25_sub1 | 789         | BsmBI       | 3wt_tile25_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile26_sub1 | 570         | BsmBI       | 3wt_tile26_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile27_sub1 | 378         | BsmBI       | 3wt_tile27_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile28_sub1 | 1553        | BsmBI       | 3wt_polIII_tile28_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile30      | 1229        | BsmBI       | 3wt_polIII_tile30                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile4_sub1  | 1326        | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile5_sub1  | 1179        | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile6_sub1  | 957         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile7_sub1  | 774         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile8_sub1  | 582         | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile9_sub1  | 405         | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_polIII_tile31   | 1112        | BsmBI       | polIII_tile31                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |

## 10. Domestication Log

5 endogenous enzyme site(s) were removed via silent mutations:

| site_start | enzyme | strand | codon_pos | original_codon | new_codon | aa  |
| ---------- | ------ | ------ | --------- | -------------- | --------- | --- |
| 499        | BsaI   | -      | 167       | GAG            | GAA       | E   |
| 4350       | BsaI   | +      | 1450      | GAG            | GAA       | E   |
| 4693       | BsaI   | -      | 1565      | GAG            | GAA       | E   |
| 5603       | BsaI   | -      | 1868      | GGA            | GGC       | G   |
| 3398       | PaqCI  | +      | 1133      | GCA            | GCC       | A   |

## 11. Configuration Parameters

| Parameter                   | Value |
| --------------------------- | ----- |
| max_oligo_length            | 300   |
| max_geneblock_length        | 1800  |
| barcode_length              | 20    |
| min_hamming_distance        | 3     |
| barcode_prefix_length       | 12    |
| barcodes_per_variant        | 10    |
| overhang_fidelity_threshold | 0.95  |
| boundary_method             | dp    |
| multi_k_search              | TRUE  |
| auto_domesticate            | TRUE  |

