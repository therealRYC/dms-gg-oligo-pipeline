# DMS-GG Assembly Report: AKAP11

Generated: 2026-03-07 18:27:48
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
| Oligo length range   | 185-290 nt                                                                     |
| Gene blocks to order | 64                                                                             |
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

**Total oligos:** 398580 | **Length range:** 185-290 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-77      | 15330  | 287 nt |
| 2    | 74-150    | 15330  | 287 nt |
| 3    | 147-197   | 9870   | 209 nt |
| 4    | 194-265   | 14280  | 272 nt |
| 5    | 262-322   | 11970  | 239 nt |
| 6    | 319-387   | 13650  | 263 nt |
| 7    | 384-443   | 11760  | 236 nt |
| 8    | 440-498   | 11550  | 233 nt |
| 9    | 495-572   | 15540  | 290 nt |
| 10   | 569-638   | 13860  | 266 nt |
| 11   | 635-700   | 13020  | 254 nt |
| 12   | 697-749   | 10290  | 215 nt |
| 13   | 746-812   | 13230  | 257 nt |
| 14   | 809-886   | 15540  | 290 nt |
| 15   | 883-956   | 14700  | 278 nt |
| 16   | 953-1016  | 12600  | 248 nt |
| 17   | 1013-1069 | 11130  | 227 nt |
| 18   | 1066-1130 | 12810  | 251 nt |
| 19   | 1127-1197 | 14070  | 269 nt |
| 20   | 1194-1254 | 11970  | 239 nt |
| 21   | 1251-1325 | 14910  | 281 nt |
| 22   | 1322-1388 | 13230  | 257 nt |
| 23   | 1385-1427 | 8190   | 185 nt |
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
| oligo_lengths          | All oligos within synthesis length limit                      | PASS   | Range: 185-290 nt (limit: 300)                                                                                                                      |
| block_lengths          | All gene blocks within synthesis length limit                 | PASS   | Range: 165-1746 nt (limit: 1800)                                                                                                                    |
| barcode_junction_sites | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='TTCCTG')                                                                             |
| barcode_uniqueness     | All barcodes are unique                                       | PASS   | 398580 unique / 398580 total                                                                                                                        |
| tile_coverage          | Tiles cover entire gene without gaps                          | PASS   | 5706 / 5706 nt covered                                                                                                                              |
| variant_count          | Expected number of variants generated                         | PASS   | 39858 unique variants (expected: 39858 across 1898/1900 mutable positions; 36062 missense + 1898 nonsense + 1898 wt_control; 2 position(s) skipped) |
| single_codon_change    | Each non-control variant differs by exactly one codon from WT | PASS   | 379600 / 379600 variants confirmed (WT controls excluded)                                                                                           |
| oligo_gc_content       | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 32.1-52.4% | 0 oligo(s) with extreme GC                                                                                                   |
| domestication_complete | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                             |
| overhang_fidelity      | Tile boundary overhangs have adequate fidelity                | FAIL   | 19 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                             |
| tile_manifests         | Per-tile assembly manifests complete                          | PASS   | 31 tile manifest(s) generated                                                                                                                       |
| helper_plasmid         | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                  |
| reaction_fidelity      | Per-reaction set-level overhang fidelity                      | PASS   | Min set fidelity: 0.9146 across 62 reactions | 0 reaction(s) below 0.90                                                                             |
| barcode_poliii_term    | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 398580 barcode(s) contain TTTT                                                                                                                  |
| block_min_length       | All gene blocks above synthesis minimum length                | FAIL   | 3 block(s) below 300 nt minimum. Range: 165-1746 nt                                                                                                 |
| sb_overhang_collisions | Superblock boundary overhangs are unique (no collisions)      | PASS   | 5 SB boundary OH(s), all unique                                                                                                                     |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 6         | 0.9985             |
| 2    | 3        | 1.0000            | 6         | 0.9971             |
| 3    | 3        | 1.0000            | 6         | 0.9911             |
| 4    | 3        | 1.0000            | 5         | 0.9146             |
| 5    | 3        | 1.0000            | 5         | 0.9985             |
| 6    | 3        | 0.9485            | 5         | 0.9146             |
| 7    | 3        | 1.0000            | 5         | 1.0000             |
| 8    | 4        | 0.9980            | 5         | 0.9985             |
| 9    | 4        | 1.0000            | 5         | 1.0000             |
| 10   | 4        | 0.9850            | 5         | 1.0000             |
| 11   | 4        | 1.0000            | 5         | 1.0000             |
| 12   | 4        | 1.0000            | 4         | 1.0000             |
| 13   | 4        | 0.9674            | 4         | 1.0000             |
| 14   | 4        | 1.0000            | 4         | 1.0000             |
| 15   | 5        | 0.9357            | 4         | 1.0000             |
| 16   | 5        | 0.9980            | 4         | 1.0000             |
| 17   | 5        | 0.9767            | 4         | 1.0000             |
| 18   | 5        | 0.9654            | 4         | 1.0000             |
| 19   | 5        | 0.9980            | 4         | 1.0000             |
| 20   | 5        | 0.9980            | 3         | 0.9146             |
| 21   | 5        | 0.9980            | 3         | 1.0000             |
| 22   | 5        | 0.9830            | 3         | 1.0000             |
| 23   | 6        | 0.9513            | 3         | 1.0000             |
| 24   | 6        | 0.9513            | 3         | 1.0000             |
| 25   | 6        | 0.9980            | 3         | 1.0000             |
| 26   | 6        | 0.9980            | 3         | 1.0000             |
| 27   | 6        | 0.9980            | 3         | 1.0000             |
| 28   | 6        | 0.9980            | 2         | 1.0000             |
| 29   | 6        | 0.9654            | 2         | 1.0000             |
| 30   | 6        | 0.9980            | 2         | 1.0000             |
| 31   | 6        | 0.9830            | 2         | 1.0000             |

**Min:** 0.9146 | **Max:** 1.0000 | **Mean:** 0.9890

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

### Tile 1 of 31 -- Codons 1-77 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGG     | 0.5393   |
| oh2 (3' boundary) | AGTT     | 0.6748   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (15330 oligos)              | 287 nt | ATGG  | TTCC  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1     | 753 nt  | AGTT  | TGAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1299 nt | TGAA  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1746 nt | TCAA  | AAGT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1485 nt | AAGT  | GAAT  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGTT]----3'WT sub1----[TGAA]----3'WT sub2----[TCAA]----3'WT sub3----[AAGT]----3'WT sub4----[GAAT]----3'WT+PolIII sub5----[CACC]
   AGTT                   TGAA                   TCAA                   AAGT                   GAAT                          CACC 
```

**Set fidelity:** 0.9985 (6 overhangs)

---

### Tile 2 of 31 -- Codons 74-150 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAG     | 0.8480   |
| oh2 (3' boundary) | TACT     | 0.7445   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 237 nt | ATGG  | TTAG  |
| 2   | Oligo pool      | Tile 2 (15330 oligos) | 287 nt | TTAG  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[TTAG]----oligo+BC----[TTCC]
   ATGG                    TTAG                  TTCC 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1     | 534 nt  | TACT  | TGAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1299 nt | TGAA  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1746 nt | TCAA  | AAGT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1485 nt | AAGT  | GAAT  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TACT]----3'WT sub1----[TGAA]----3'WT sub2----[TCAA]----3'WT sub3----[AAGT]----3'WT sub4----[GAAT]----3'WT+PolIII sub5----[CACC]
   TACT                   TGAA                   TCAA                   AAGT                   GAAT                          CACC 
```

**Set fidelity:** 0.9971 (6 overhangs)

---

### Tile 3 of 31 -- Codons 147-197 (153 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAT     | 0.7737   |
| oh2 (3' boundary) | GGAA     | 0.7463   |

**Variants:** 9870 mutations, 9870 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 456 nt | ATGG  | AAAT  |
| 2   | Oligo pool      | Tile 3 (9870 oligos)  | 209 nt | AAAT  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[AAAT]----oligo+BC----[TTCC]
   ATGG                    AAAT                  TTCC 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1     | 393 nt  | GGAA  | TGAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1299 nt | TGAA  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1746 nt | TCAA  | AAGT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1485 nt | AAGT  | GAAT  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAA]----3'WT sub1----[TGAA]----3'WT sub2----[TCAA]----3'WT sub3----[AAGT]----3'WT sub4----[GAAT]----3'WT+PolIII sub5----[CACC]
   GGAA                   TGAA                   TCAA                   AAGT                   GAAT                          CACC 
```

**Set fidelity:** 0.9911 (6 overhangs)

---

### Tile 4 of 31 -- Codons 194-265 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAG     | 0.8480   |
| oh2 (3' boundary) | GAAA     | 0.8745   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 597 nt | ATGG  | TTAG  |
| 2   | Oligo pool      | Tile 4 (14280 oligos) | 272 nt | TTAG  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[TTAG]----oligo+BC----[TTCC]
   ATGG                    TTAG                  TTCC 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1     | 1470 nt | GAAA  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1746 nt | TCAA  | AAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1485 nt | AAGT  | GAAT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAA]----3'WT sub1----[TCAA]----3'WT sub2----[AAGT]----3'WT sub3----[GAAT]----3'WT+PolIII sub4----[CACC]
   GAAA                   TCAA                   AAGT                   GAAT                          CACC 
```

**Set fidelity:** 0.9146 (5 overhangs)

---

### Tile 5 of 31 -- Codons 262-322 (183 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCTT     | 0.6891   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 11970 mutations, 11970 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 801 nt | ATGG  | CCTT  |
| 2   | Oligo pool      | Tile 5 (11970 oligos) | 239 nt | CCTT  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[CCTT]----oligo+BC----[TTCC]
   ATGG                    CCTT                  TTCC 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1299 nt | TGAA  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1746 nt | TCAA  | AAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1485 nt | AAGT  | GAAT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[TCAA]----3'WT sub2----[AAGT]----3'WT sub3----[GAAT]----3'WT+PolIII sub4----[CACC]
   TGAA                   TCAA                   AAGT                   GAAT                          CACC 
```

**Set fidelity:** 0.9985 (5 overhangs)

---

### Tile 6 of 31 -- Codons 319-387 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCT     | 0.8181   |
| oh2 (3' boundary) | GAAA     | 0.8745   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 972 nt | ATGG  | TTCT  |
| 2   | Oligo pool      | Tile 6 (13650 oligos) | 263 nt | TTCT  | TTCC  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1     | 1104 nt | GAAA  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1746 nt | TCAA  | AAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1485 nt | AAGT  | GAAT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAA]----3'WT sub1----[TCAA]----3'WT sub2----[AAGT]----3'WT sub3----[GAAT]----3'WT+PolIII sub4----[CACC]
   GAAA                   TCAA                   AAGT                   GAAT                          CACC 
```

**Set fidelity:** 0.9146 (5 overhangs)

---

### Tile 7 of 31 -- Codons 384-443 (180 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCGC     | 0.6795   |
| oh2 (3' boundary) | AGAT     | 0.6825   |

**Variants:** 11760 mutations, 11760 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7_sub1   | 1167 nt | ATGG  | TCGC  |
| 2   | Oligo pool      | Tile 7 (11760 oligos) | 236 nt  | TCGC  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[TCGC]----oligo+BC----[TTCC]
   ATGG                    TCGC                  TTCC 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1     | 936 nt  | AGAT  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1746 nt | TCAA  | AAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1485 nt | AAGT  | GAAT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAT]----3'WT sub1----[TCAA]----3'WT sub2----[AAGT]----3'WT sub3----[GAAT]----3'WT+PolIII sub4----[CACC]
   AGAT                   TCAA                   AAGT                   GAAT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 8 of 31 -- Codons 440-498 (177 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAA     | 0.9425   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 11550 mutations, 11550 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1   | 980 nt | ATGG  | TGAA  |
| 2   | 5'WT gene block | bsai_5wt_tile8_sub2   | 373 nt | TGAA  | TCAA  |
| 3   | Oligo pool      | Tile 8 (11550 oligos) | 233 nt | TCAA  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT sub1----[TGAA]----5'WT sub2----[TCAA]----oligo+BC----[TTCC]
   ATGG                   TGAA                   TCAA                  TTCC 
```

**Set fidelity:** 0.9980 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1     | 771 nt  | TGAA  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1746 nt | TCAA  | AAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1485 nt | AAGT  | GAAT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[TCAA]----3'WT sub2----[AAGT]----3'WT sub3----[GAAT]----3'WT+PolIII sub4----[CACC]
   TGAA                   TCAA                   AAGT                   GAAT                          CACC 
```

**Set fidelity:** 0.9985 (5 overhangs)

---

### Tile 9 of 31 -- Codons 495-572 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTT     | 0.7664   |
| oh2 (3' boundary) | AGGA     | 0.7515   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1   | 980 nt | ATGG  | TGAA  |
| 2   | 5'WT gene block | bsai_5wt_tile9_sub2   | 538 nt | TGAA  | ATTT  |
| 3   | Oligo pool      | Tile 9 (15540 oligos) | 290 nt | ATTT  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT sub1----[TGAA]----5'WT sub2----[ATTT]----oligo+BC----[TTCC]
   ATGG                   TGAA                   ATTT                  TTCC 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1     | 549 nt  | AGGA  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1746 nt | TCAA  | AAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1485 nt | AAGT  | GAAT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGGA]----3'WT sub1----[TCAA]----3'WT sub2----[AAGT]----3'WT sub3----[GAAT]----3'WT+PolIII sub4----[CACC]
   AGGA                   TCAA                   AAGT                   GAAT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 10 of 31 -- Codons 569-638 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAC     | 0.8333   |
| oh2 (3' boundary) | GATA     | 0.7029   |

**Variants:** 13860 mutations, 13860 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 980 nt | ATGG  | TGAA  |
| 2   | 5'WT gene block | bsai_5wt_tile10_sub2   | 760 nt | TGAA  | TTAC  |
| 3   | Oligo pool      | Tile 10 (13860 oligos) | 266 nt | TTAC  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --     | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --     | --    | --    |

```
  [ATGG]----5'WT sub1----[TGAA]----5'WT sub2----[TTAC]----oligo+BC----[TTCC]
   ATGG                   TGAA                   TTAC                  TTCC 
```

**Set fidelity:** 0.9850 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1    | 351 nt  | GATA  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1746 nt | TCAA  | AAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1485 nt | AAGT  | GAAT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GATA]----3'WT sub1----[TCAA]----3'WT sub2----[AAGT]----3'WT sub3----[GAAT]----3'WT+PolIII sub4----[CACC]
   GATA                   TCAA                   AAGT                   GAAT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 11 of 31 -- Codons 635-700 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | GGAA     | 0.7463   |

**Variants:** 13020 mutations, 13020 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 980 nt | ATGG  | TGAA  |
| 2   | 5'WT gene block | bsai_5wt_tile11_sub2   | 958 nt | TGAA  | AAGA  |
| 3   | Oligo pool      | Tile 11 (13020 oligos) | 254 nt | AAGA  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --     | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --     | --    | --    |

```
  [ATGG]----5'WT sub1----[TGAA]----5'WT sub2----[AAGA]----oligo+BC----[TTCC]
   ATGG                   TGAA                   AAGA                  TTCC 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1    | 165 nt  | GGAA  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1746 nt | TCAA  | AAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1485 nt | AAGT  | GAAT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAA]----3'WT sub1----[TCAA]----3'WT sub2----[AAGT]----3'WT sub3----[GAAT]----3'WT+PolIII sub4----[CACC]
   GGAA                   TCAA                   AAGT                   GAAT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 12 of 31 -- Codons 697-749 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTAA     | 0.8029   |
| oh2 (3' boundary) | TCAA     | 0.9425   |

**Variants:** 10290 mutations, 10290 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 980 nt  | ATGG  | TGAA  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2   | 1144 nt | TGAA  | GTAA  |
| 3   | Oligo pool      | Tile 12 (10290 oligos) | 215 nt  | GTAA  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGAA]----5'WT sub2----[GTAA]----oligo+BC----[TTCC]
   ATGG                   TGAA                   GTAA                  TTCC 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1746 nt | TCAA  | AAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1485 nt | AAGT  | GAAT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAA]----3'WT sub1----[AAGT]----3'WT sub2----[GAAT]----3'WT+PolIII sub3----[CACC]
   TCAA                   AAGT                   GAAT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 13 of 31 -- Codons 746-812 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTTC     | 0.8348   |
| oh2 (3' boundary) | TTCA     | 0.8824   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 980 nt  | ATGG  | TGAA  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 1291 nt | TGAA  | TTTC  |
| 3   | Oligo pool      | Tile 13 (13230 oligos) | 257 nt  | TTTC  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGAA]----5'WT sub2----[TTTC]----oligo+BC----[TTCC]
   ATGG                   TGAA                   TTTC                  TTCC 
```

**Set fidelity:** 0.9674 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1    | 1557 nt | TTCA  | AAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1485 nt | AAGT  | GAAT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCA]----3'WT sub1----[AAGT]----3'WT sub2----[GAAT]----3'WT+PolIII sub3----[CACC]
   TTCA                   AAGT                   GAAT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 14 of 31 -- Codons 809-886 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GATA     | 0.7029   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 980 nt  | ATGG  | TGAA  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1480 nt | TGAA  | GATA  |
| 3   | Oligo pool      | Tile 14 (15540 oligos) | 290 nt  | GATA  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGAA]----5'WT sub2----[GATA]----oligo+BC----[TTCC]
   ATGG                   TGAA                   GATA                  TTCC 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1    | 1335 nt | TGAA  | AAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1485 nt | AAGT  | GAAT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[AAGT]----3'WT sub2----[GAAT]----3'WT+PolIII sub3----[CACC]
   TGAA                   AAGT                   GAAT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 15 of 31 -- Codons 883-956 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATAG     | 0.7330   |
| oh2 (3' boundary) | ATCA     | 0.7483   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 980 nt  | ATGG  | TGAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1299 nt | TGAA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile15_sub3   | 421 nt  | TCAA  | ATAG  |
| 4   | Oligo pool      | Tile 15 (14700 oligos) | 278 nt  | ATAG  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGAA]----5'WT sub2----[TCAA]----5'WT sub3----[ATAG]----oligo+BC----[TTCC]
   ATGG                   TGAA                   TCAA                   ATAG                  TTCC 
```

**Set fidelity:** 0.9357 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1    | 1125 nt | ATCA  | AAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1485 nt | AAGT  | GAAT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATCA]----3'WT sub1----[AAGT]----3'WT sub2----[GAAT]----3'WT+PolIII sub3----[CACC]
   ATCA                   AAGT                   GAAT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 16 of 31 -- Codons 953-1016 (192 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | TCAT     | 0.8102   |

**Variants:** 12600 mutations, 12600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 980 nt  | ATGG  | TGAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1299 nt | TGAA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile16_sub3   | 631 nt  | TCAA  | AAGA  |
| 4   | Oligo pool      | Tile 16 (12600 oligos) | 248 nt  | AAGA  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGAA]----5'WT sub2----[TCAA]----5'WT sub3----[AAGA]----oligo+BC----[TTCC]
   ATGG                   TGAA                   TCAA                   AAGA                  TTCC 
```

**Set fidelity:** 0.9980 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1    | 945 nt  | TCAT  | AAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1485 nt | AAGT  | GAAT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAT]----3'WT sub1----[AAGT]----3'WT sub2----[GAAT]----3'WT+PolIII sub3----[CACC]
   TCAT                   AAGT                   GAAT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 17 of 31 -- Codons 1013-1069 (171 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTA     | 0.8892   |
| oh2 (3' boundary) | TTCA     | 0.8824   |

**Variants:** 11130 mutations, 11130 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 980 nt  | ATGG  | TGAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1299 nt | TGAA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile17_sub3   | 811 nt  | TCAA  | TCTA  |
| 4   | Oligo pool      | Tile 17 (11130 oligos) | 227 nt  | TCTA  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGAA]----5'WT sub2----[TCAA]----5'WT sub3----[TCTA]----oligo+BC----[TTCC]
   ATGG                   TGAA                   TCAA                   TCTA                  TTCC 
```

**Set fidelity:** 0.9767 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1    | 786 nt  | TTCA  | AAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1485 nt | AAGT  | GAAT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCA]----3'WT sub1----[AAGT]----3'WT sub2----[GAAT]----3'WT+PolIII sub3----[CACC]
   TTCA                   AAGT                   GAAT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 18 of 31 -- Codons 1066-1130 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTTC     | 0.8348   |
| oh2 (3' boundary) | CAAA     | 0.8948   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 980 nt  | ATGG  | TGAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1299 nt | TGAA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile18_sub3   | 970 nt  | TCAA  | TTTC  |
| 4   | Oligo pool      | Tile 18 (12810 oligos) | 251 nt  | TTTC  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGAA]----5'WT sub2----[TCAA]----5'WT sub3----[TTTC]----oligo+BC----[TTCC]
   ATGG                   TGAA                   TCAA                   TTTC                  TTCC 
```

**Set fidelity:** 0.9654 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1    | 603 nt  | CAAA  | AAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1485 nt | AAGT  | GAAT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAA]----3'WT sub1----[AAGT]----3'WT sub2----[GAAT]----3'WT+PolIII sub3----[CACC]
   CAAA                   AAGT                   GAAT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 19 of 31 -- Codons 1127-1197 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAT     | 0.7246   |
| oh2 (3' boundary) | TCAG     | 0.7814   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 980 nt  | ATGG  | TGAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1299 nt | TGAA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3   | 1153 nt | TCAA  | GAAT  |
| 4   | Oligo pool      | Tile 19 (14070 oligos) | 269 nt  | GAAT  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGAA]----5'WT sub2----[TCAA]----5'WT sub3----[GAAT]----oligo+BC----[TTCC]
   ATGG                   TGAA                   TCAA                   GAAT                  TTCC 
```

**Set fidelity:** 0.9980 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1    | 402 nt  | TCAG  | AAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1485 nt | AAGT  | GAAT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAG]----3'WT sub1----[AAGT]----3'WT sub2----[GAAT]----3'WT+PolIII sub3----[CACC]
   TCAG                   AAGT                   GAAT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 20 of 31 -- Codons 1194-1254 (183 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | GAAA     | 0.8745   |

**Variants:** 11970 mutations, 11970 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 980 nt  | ATGG  | TGAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1299 nt | TGAA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile20_sub3   | 1354 nt | TCAA  | AAGA  |
| 4   | Oligo pool      | Tile 20 (11970 oligos) | 239 nt  | AAGA  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGAA]----5'WT sub2----[TCAA]----5'WT sub3----[AAGA]----oligo+BC----[TTCC]
   ATGG                   TGAA                   TCAA                   AAGA                  TTCC 
```

**Set fidelity:** 0.9980 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1    | 1698 nt | GAAA  | GAAT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAA]----3'WT sub1----[GAAT]----3'WT+PolIII sub2----[CACC]
   GAAA                   GAAT                          CACC 
```

**Set fidelity:** 0.9146 (3 overhangs)

---

### Tile 21 of 31 -- Codons 1251-1325 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | AAGT     | 0.7629   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 980 nt  | ATGG  | TGAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1299 nt | TGAA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3   | 1525 nt | TCAA  | GAAA  |
| 4   | Oligo pool      | Tile 21 (14910 oligos) | 281 nt  | GAAA  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGAA]----5'WT sub2----[TCAA]----5'WT sub3----[GAAA]----oligo+BC----[TTCC]
   ATGG                   TGAA                   TCAA                   GAAA                  TTCC 
```

**Set fidelity:** 0.9980 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1485 nt | AAGT  | GAAT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAGT]----3'WT sub1----[GAAT]----3'WT+PolIII sub2----[CACC]
   AAGT                   GAAT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 22 of 31 -- Codons 1322-1388 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAC     | 0.8333   |
| oh2 (3' boundary) | CAAA     | 0.8948   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 980 nt  | ATGG  | TGAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1299 nt | TGAA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1738 nt | TCAA  | TTAC  |
| 4   | Oligo pool      | Tile 22 (13230 oligos) | 257 nt  | TTAC  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGAA]----5'WT sub2----[TCAA]----5'WT sub3----[TTAC]----oligo+BC----[TTCC]
   ATGG                   TGAA                   TCAA                   TTAC                  TTCC 
```

**Set fidelity:** 0.9830 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1    | 1296 nt | CAAA  | GAAT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1376 nt | GAAT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAA]----3'WT sub1----[GAAT]----3'WT+PolIII sub2----[CACC]
   CAAA                   GAAT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 23 of 31 -- Codons 1385-1427 (129 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | AAGT     | 0.7629   |

**Variants:** 8190 mutations, 8190 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1   | 980 nt  | ATGG  | TGAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2  | 1299 nt | TGAA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3  | 1746 nt | TCAA  | AAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile23_sub4  | 199 nt  | AAGT  | AAGA  |
| 5   | Oligo pool      | Tile 23 (8190 oligos) | 185 nt  | AAGA  | TTCC  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGAA]----5'WT sub2----[TCAA]----5'WT sub3----[AAGT]----5'WT sub4----[AAGA]----oligo+BC----[TTCC]
   ATGG                   TGAA                   TCAA                   AAGT                   AAGA                  TTCC 
```

**Set fidelity:** 0.9513 (6 overhangs)

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
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 980 nt  | ATGG  | TGAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1299 nt | TGAA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 1746 nt | TCAA  | AAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile24_sub4   | 316 nt  | AAGT  | AAGA  |
| 5   | Oligo pool      | Tile 24 (14070 oligos) | 269 nt  | AAGA  | TTCC  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGAA]----5'WT sub2----[TCAA]----5'WT sub3----[AAGT]----5'WT sub4----[AAGA]----oligo+BC----[TTCC]
   ATGG                   TGAA                   TCAA                   AAGT                   AAGA                  TTCC 
```

**Set fidelity:** 0.9513 (6 overhangs)

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
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 980 nt  | ATGG  | TGAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1299 nt | TGAA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 1746 nt | TCAA  | AAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4   | 517 nt  | AAGT  | GAAA  |
| 5   | Oligo pool      | Tile 25 (13230 oligos) | 257 nt  | GAAA  | TTCC  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGAA]----5'WT sub2----[TCAA]----5'WT sub3----[AAGT]----5'WT sub4----[GAAA]----oligo+BC----[TTCC]
   ATGG                   TGAA                   TCAA                   AAGT                   GAAA                  TTCC 
```

**Set fidelity:** 0.9980 (6 overhangs)

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
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 980 nt  | ATGG  | TGAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1299 nt | TGAA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 1746 nt | TCAA  | AAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile26_sub4   | 706 nt  | AAGT  | CTAA  |
| 5   | Oligo pool      | Tile 26 (15330 oligos) | 287 nt  | CTAA  | TTCC  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGAA]----5'WT sub2----[TCAA]----5'WT sub3----[AAGT]----5'WT sub4----[CTAA]----oligo+BC----[TTCC]
   ATGG                   TGAA                   TCAA                   AAGT                   CTAA                  TTCC 
```

**Set fidelity:** 0.9980 (6 overhangs)

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
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 980 nt  | ATGG  | TGAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1299 nt | TGAA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 1746 nt | TCAA  | AAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile27_sub4   | 925 nt  | AAGT  | TATC  |
| 5   | Oligo pool      | Tile 27 (13440 oligos) | 260 nt  | TATC  | TTCC  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGAA]----5'WT sub2----[TCAA]----5'WT sub3----[AAGT]----5'WT sub4----[TATC]----oligo+BC----[TTCC]
   ATGG                   TGAA                   TCAA                   AAGT                   TATC                  TTCC 
```

**Set fidelity:** 0.9980 (6 overhangs)

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
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 980 nt  | ATGG  | TGAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1299 nt | TGAA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 1746 nt | TCAA  | AAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4   | 1117 nt | AAGT  | GAAA  |
| 5   | Oligo pool      | Tile 28 (12810 oligos) | 251 nt  | GAAA  | TTCC  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGAA]----5'WT sub2----[TCAA]----5'WT sub3----[AAGT]----5'WT sub4----[GAAA]----oligo+BC----[TTCC]
   ATGG                   TGAA                   TCAA                   AAGT                   GAAA                  TTCC 
```

**Set fidelity:** 0.9980 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile28_sub1    | 1553 nt | TCTA  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCTA]----3'WT+PolIII----[CACC]
   TCTA                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

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
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 980 nt  | ATGG  | TGAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1299 nt | TGAA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 1746 nt | TCAA  | AAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile29_sub4   | 1300 nt | AAGT  | TTTC  |
| 5   | Oligo pool      | Tile 29 (12390 oligos) | 245 nt  | TTTC  | TTCC  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGAA]----5'WT sub2----[TCAA]----5'WT sub3----[AAGT]----5'WT sub4----[TTTC]----oligo+BC----[TTCC]
   ATGG                   TGAA                   TCAA                   AAGT                   TTTC                  TTCC 
```

**Set fidelity:** 0.9654 (6 overhangs)

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
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 980 nt  | ATGG  | TGAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1299 nt | TGAA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 1746 nt | TCAA  | AAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile30_sub4   | 1477 nt | AAGT  | CTAA  |
| 5   | Oligo pool      | Tile 30 (10290 oligos) | 215 nt  | CTAA  | TTCC  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGAA]----5'WT sub2----[TCAA]----5'WT sub3----[AAGT]----5'WT sub4----[CTAA]----oligo+BC----[TTCC]
   ATGG                   TGAA                   TCAA                   AAGT                   CTAA                  TTCC 
```

**Set fidelity:** 0.9980 (6 overhangs)

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
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1   | 980 nt  | ATGG  | TGAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2  | 1299 nt | TGAA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3  | 1746 nt | TCAA  | AAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile31_sub4  | 1624 nt | AAGT  | TTAC  |
| 5   | Oligo pool      | Tile 31 (8190 oligos) | 185 nt  | TTAC  | TTCC  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGAA]----5'WT sub2----[TCAA]----5'WT sub3----[AAGT]----5'WT sub4----[TTAC]----oligo+BC----[TTCC]
   ATGG                   TGAA                   TCAA                   AAGT                   TTAC                  TTCC 
```

**Set fidelity:** 0.9830 (6 overhangs)

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

**Total blocks:** 64

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| --------------------- | ----------- | ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10_sub2  | 760         | BsaI        | 5wt_tile10_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile11_sub2  | 958         | BsaI        | 5wt_tile11_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile12_sub2  | 1144        | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile13_sub2  | 1291        | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile14_sub2  | 1480        | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile15_sub2  | 1299        | BsaI        | 5wt_tile15_sub2;5wt_tile16_sub2;5wt_tile17_sub2;5wt_tile18_sub2;5wt_tile19_sub2;5wt_tile20_sub2;5wt_tile21_sub2;5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2;5wt_tile26_sub2;5wt_tile27_sub2;5wt_tile28_sub2;5wt_tile29_sub2;5wt_tile30_sub2;5wt_tile31_sub2                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile15_sub3  | 421         | BsaI        | 5wt_tile15_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile16_sub3  | 631         | BsaI        | 5wt_tile16_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile17_sub3  | 811         | BsaI        | 5wt_tile17_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile18_sub3  | 970         | BsaI        | 5wt_tile18_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile19_sub3  | 1153        | BsaI        | 5wt_tile19_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile2        | 237         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile20_sub3  | 1354        | BsaI        | 5wt_tile20_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile21_sub3  | 1525        | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile22_sub3  | 1738        | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile23_sub3  | 1746        | BsaI        | 5wt_tile23_sub3;5wt_tile24_sub3;5wt_tile25_sub3;5wt_tile26_sub3;5wt_tile27_sub3;5wt_tile28_sub3;5wt_tile29_sub3;5wt_tile30_sub3;5wt_tile31_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile23_sub4  | 199         | BsaI        | 5wt_tile23_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile24_sub4  | 316         | BsaI        | 5wt_tile24_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile25_sub4  | 517         | BsaI        | 5wt_tile25_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile26_sub4  | 706         | BsaI        | 5wt_tile26_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile27_sub4  | 925         | BsaI        | 5wt_tile27_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile28_sub4  | 1117        | BsaI        | 5wt_tile28_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile29_sub4  | 1300        | BsaI        | 5wt_tile29_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile3        | 456         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile30_sub4  | 1477        | BsaI        | 5wt_tile30_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile31_sub4  | 1624        | BsaI        | 5wt_tile31_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile4        | 597         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile5        | 801         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile6        | 972         | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile7_sub1   | 1167        | BsaI        | 5wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile8_sub1   | 980         | BsaI        | 5wt_tile8_sub1;5wt_tile9_sub1;5wt_tile10_sub1;5wt_tile11_sub1;5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1;5wt_tile26_sub1;5wt_tile27_sub1;5wt_tile28_sub1;5wt_tile29_sub1;5wt_tile30_sub1;5wt_tile31_sub1                                                                                                                                                                                                                                                         |
| bsai_5wt_tile8_sub2   | 373         | BsaI        | 5wt_tile8_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile9_sub2   | 538         | BsaI        | 5wt_tile9_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile1_sub1  | 753         | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile1_sub2  | 1299        | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile1_sub3  | 1746        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile8_sub2;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile1_sub4  | 1485        | BsmBI       | 3wt_tile1_sub4;3wt_tile2_sub4;3wt_tile3_sub4;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub3;3wt_tile9_sub3;3wt_tile10_sub3;3wt_tile11_sub3;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2;3wt_tile16_sub2;3wt_tile17_sub2;3wt_tile18_sub2;3wt_tile19_sub2;3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile1_sub5  | 1376        | BsmBI       | 3wt_polIII_tile1_sub5;3wt_polIII_tile2_sub5;3wt_polIII_tile3_sub5;3wt_polIII_tile4_sub4;3wt_polIII_tile5_sub4;3wt_polIII_tile6_sub4;3wt_polIII_tile7_sub4;3wt_polIII_tile8_sub4;3wt_polIII_tile9_sub4;3wt_polIII_tile10_sub4;3wt_polIII_tile11_sub4;3wt_polIII_tile12_sub3;3wt_polIII_tile13_sub3;3wt_polIII_tile14_sub3;3wt_polIII_tile15_sub3;3wt_polIII_tile16_sub3;3wt_polIII_tile17_sub3;3wt_polIII_tile18_sub3;3wt_polIII_tile19_sub3;3wt_polIII_tile20_sub2;3wt_polIII_tile21_sub2;3wt_polIII_tile22_sub2;3wt_polIII_tile23_sub2;3wt_polIII_tile24_sub2;3wt_polIII_tile25_sub2;3wt_polIII_tile26_sub2;3wt_polIII_tile27_sub2;3wt_polIII_tile29 |
| bsmbi_3wt_tile10_sub1 | 351         | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile11_sub1 | 165         | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile13_sub1 | 1557        | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile14_sub1 | 1335        | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile15_sub1 | 1125        | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile16_sub1 | 945         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile17_sub1 | 786         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile18_sub1 | 603         | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile19_sub1 | 402         | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile2_sub1  | 534         | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile20_sub1 | 1698        | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile22_sub1 | 1296        | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile23_sub1 | 1179        | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile24_sub1 | 978         | BsmBI       | 3wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile25_sub1 | 789         | BsmBI       | 3wt_tile25_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile26_sub1 | 570         | BsmBI       | 3wt_tile26_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile27_sub1 | 378         | BsmBI       | 3wt_tile27_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile28_sub1 | 1553        | BsmBI       | 3wt_polIII_tile28_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile3_sub1  | 393         | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile30      | 1229        | BsmBI       | 3wt_polIII_tile30                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile4_sub1  | 1470        | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile6_sub1  | 1104        | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile7_sub1  | 936         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile8_sub1  | 771         | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile9_sub1  | 549         | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
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

