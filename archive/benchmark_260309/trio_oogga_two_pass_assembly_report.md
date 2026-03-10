# DMS-GG Assembly Report: TRIO

Generated: 2026-03-09 19:04:40
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                         |
| -------------------- | ----------------------------------------------------------------------------- |
| Gene name            | TRIO_NM_007118.4_CDS Homo sapiens triple functional domain protein (TRIO) CDS |
| CDS length           | 9294 nt (3098 codons)                                                         |
| Protein length       | 3097 aa                                                                       |
| Number of tiles      | 45                                                                            |
| Total variants       | 61278                                                                         |
| Total oligos         | 61278                                                                         |
| Oligo length range   | 152-290 nt                                                                    |
| Gene blocks to order | 235                                                                           |
| Barcodes per variant | 1                                                                             |

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

**Total oligos:** 61278 | **Length range:** 152-290 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-76      | 1512   | 284 nt |
| 2    | 77-137    | 1197   | 239 nt |
| 3    | 138-211   | 1470   | 278 nt |
| 4    | 212-285   | 1470   | 278 nt |
| 5    | 286-363   | 1554   | 290 nt |
| 6    | 364-439   | 1512   | 284 nt |
| 7    | 440-492   | 1029   | 215 nt |
| 8    | 493-570   | 1554   | 290 nt |
| 9    | 571-642   | 1428   | 272 nt |
| 10   | 643-720   | 1554   | 290 nt |
| 11   | 721-795   | 1491   | 281 nt |
| 12   | 796-866   | 1407   | 269 nt |
| 13   | 867-939   | 1449   | 275 nt |
| 14   | 940-1016  | 1533   | 287 nt |
| 15   | 1017-1093 | 1533   | 287 nt |
| 16   | 1094-1156 | 1239   | 245 nt |
| 17   | 1157-1226 | 1386   | 266 nt |
| 18   | 1227-1301 | 1491   | 281 nt |
| 19   | 1302-1374 | 1449   | 275 nt |
| 20   | 1375-1449 | 1491   | 281 nt |
| 21   | 1450-1518 | 1365   | 263 nt |
| 22   | 1519-1593 | 1491   | 281 nt |
| 23   | 1594-1662 | 1365   | 263 nt |
| 24   | 1663-1735 | 1449   | 275 nt |
| 25   | 1736-1810 | 1491   | 281 nt |
| 26   | 1811-1872 | 1218   | 242 nt |
| 27   | 1873-1947 | 1491   | 281 nt |
| 28   | 1948-2018 | 1407   | 269 nt |
| 29   | 2019-2058 | 756    | 176 nt |
| 30   | 2059-2096 | 714    | 170 nt |
| 31   | 2097-2159 | 1239   | 245 nt |
| 32   | 2160-2220 | 1197   | 239 nt |
| 33   | 2221-2288 | 1344   | 260 nt |
| 34   | 2289-2365 | 1533   | 287 nt |
| 35   | 2366-2442 | 1533   | 287 nt |
| 36   | 2443-2512 | 1386   | 266 nt |
| 37   | 2513-2582 | 1386   | 266 nt |
| 38   | 2583-2656 | 1470   | 278 nt |
| 39   | 2657-2713 | 1113   | 227 nt |
| 40   | 2714-2745 | 588    | 152 nt |
| 41   | 2746-2823 | 1554   | 290 nt |
| 42   | 2824-2883 | 1176   | 236 nt |
| 43   | 2884-2957 | 1470   | 278 nt |
| 44   | 2958-3024 | 1323   | 257 nt |
| 45   | 3025-3098 | 1470   | 278 nt |

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
| Barcodes per variant  | 1                                    |

### Pool Statistics

| Statistic         | Value                              |
| ----------------- | ---------------------------------- |
| Total barcodes    | 61278                              |
| Unique barcodes   | 61278                              |
| GC content range  | 25% - 75%                          |
| GC content mean   | 48%                                |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                  | Description                                                   | Result | Detail                                                                                                                                                |
| ---------------------- | ------------------------------------------------------------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths          | All oligos within synthesis length limit                      | PASS   | Range: 152-290 nt (limit: 300)                                                                                                                        |
| block_lengths          | All gene blocks within synthesis length limit                 | FAIL   | Range: 246-2336 nt (limit: 1800)                                                                                                                      |
| barcode_junction_sites | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                               |
| barcode_uniqueness     | All barcodes are unique                                       | PASS   | 61278 unique / 61278 total                                                                                                                            |
| tile_coverage          | Tiles cover entire gene without gaps                          | PASS   | 9294 / 9294 nt covered                                                                                                                                |
| variant_count          | Expected number of variants generated                         | PASS   | 61278 unique variants (expected: 61278 across 2918/3096 mutable positions; 55442 missense + 2918 nonsense + 2918 wt_control; 178 position(s) skipped) |
| single_codon_change    | Each non-control variant differs by exactly one codon from WT | PASS   | 58360 / 58360 variants confirmed (WT controls excluded)                                                                                               |
| oligo_gc_content       | Oligo GC content within reasonable range (25-75%)             | FAIL   | GC range: 40-76% | 68 oligo(s) with extreme GC                                                                                                        |
| domestication_complete | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                               |
| overhang_fidelity      | Tile boundary overhangs have adequate fidelity                | FAIL   | 44 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                               |
| tile_manifests         | Per-tile assembly manifests complete                          | PASS   | 45 tile manifest(s) generated                                                                                                                         |
| helper_plasmid         | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                    |
| reaction_fidelity      | Per-reaction set-level overhang fidelity                      | FAIL   | Min set fidelity: 0.7487 across 90 reactions | 11 reaction(s) below 0.90                                                                              |
| barcode_poliii_term    | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 61278 barcode(s) contain TTTT                                                                                                                     |
| block_min_length       | All gene blocks above synthesis minimum length                | FAIL   | 1 block(s) below 300 nt minimum. Range: 246-2336 nt                                                                                                   |
| sb_overhang_collisions | Superblock boundary overhangs are unique (no collisions)      | PASS   | 6 SB boundary OH(s), all unique                                                                                                                       |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 9         | 0.9196             |
| 2    | 3        | 1.0000            | 9         | 0.9430             |
| 3    | 3        | 0.9953            | 9         | 0.9118             |
| 4    | 3        | 1.0000            | 9         | 0.9470             |
| 5    | 3        | 1.0000            | 9         | 0.9429             |
| 6    | 3        | 1.0000            | 9         | 0.9581             |
| 7    | 3        | 1.0000            | 9         | 0.9662             |
| 8    | 3        | 1.0000            | 8         | 0.9645             |
| 9    | 3        | 1.0000            | 8         | 0.9470             |
| 10   | 4        | 1.0000            | 8         | 0.9581             |
| 11   | 4        | 1.0000            | 8         | 0.9624             |
| 12   | 4        | 1.0000            | 8         | 0.9550             |
| 13   | 4        | 1.0000            | 8         | 0.9632             |
| 14   | 4        | 1.0000            | 8         | 0.9714             |
| 15   | 4        | 1.0000            | 8         | 0.9355             |
| 16   | 5        | 1.0000            | 7         | 0.9662             |
| 17   | 5        | 0.9406            | 7         | 0.8765             |
| 18   | 5        | 1.0000            | 7         | 0.9974             |
| 19   | 5        | 0.9430            | 7         | 0.9752             |
| 20   | 5        | 0.9764            | 7         | 0.9662             |
| 21   | 5        | 0.9825            | 7         | 0.9662             |
| 22   | 5        | 0.9096            | 7         | 0.9662             |
| 23   | 6        | 0.9720            | 7         | 0.9662             |
| 24   | 6        | 0.8836            | 6         | 0.9727             |
| 25   | 6        | 0.9403            | 6         | 0.9505             |
| 26   | 6        | 0.9764            | 6         | 0.9662             |
| 27   | 6        | 0.8624            | 6         | 0.9674             |
| 28   | 6        | 0.9674            | 6         | 0.8850             |
| 29   | 6        | 0.9403            | 6         | 0.9842             |
| 30   | 6        | 0.9144            | 5         | 0.9911             |
| 31   | 7        | 0.9398            | 6         | 0.9550             |
| 32   | 7        | 0.9612            | 5         | 0.9381             |
| 33   | 7        | 0.9403            | 4         | 1.0000             |
| 34   | 7        | 0.9144            | 4         | 0.9911             |
| 35   | 7        | 0.8659            | 4         | 0.9911             |
| 36   | 7        | 0.9179            | 4         | 0.9923             |
| 37   | 7        | 0.8921            | 3         | 1.0000             |
| 38   | 7        | 0.8641            | 3         | 1.0000             |
| 39   | 8        | 0.9256            | 3         | 0.7487             |
| 40   | 8        | 0.9764            | 3         | 1.0000             |
| 41   | 8        | 0.9144            | 3         | 1.0000             |
| 42   | 8        | 0.9020            | 2         | 0.9923             |
| 43   | 8        | 0.8839            | 2         | 1.0000             |
| 44   | 8        | 0.8839            | 2         | 1.0000             |
| 45   | 8        | 0.8355            | 2         | 1.0000             |

**Min:** 0.7487 | **Max:** 1.0000 | **Mean:** 0.9564

**Warning:** 11 reaction(s) below 0.90 fidelity — consider alternative split points or overhang reassignment.
## 6. Fixed Overhangs & Helper Plasmid

These overhangs are the same across all tile reactions:

| Overhang    | Sequence | Role                                                    |
| ----------- | -------- | ------------------------------------------------------- |
| oh_L        | ATGA     | Gene start (BsaI, all tiles)                            |
| oh3         | CACC     | Downstream cassette-barcode junction (BsmBI, all tiles) |
| oh4         | AGAA     | Barcode-helper junction (BsaI, all tiles)               |
| paqci_star2 | AATG     | PaqCI 5' end of insert (Level 2)                        |
| paqci_star1 | GCTA     | PaqCI 3' end of insert (Level 2)                        |

### Helper Plasmid Insert

The helper plasmid provides the backbone for each BsaI Level 1 reaction.

```
[PaqCI**]--[BsaI>>ATGA]--STUFFER--[AGAA<<BsaI]--[PaqCI*]
```

Insert length: 72 nt
oh_L = ATGA (first 4 nt of gene)
oh_R = AGAA (= oh4, barcode-helper junction)

## 7. Per-Tile Assembly Guide

### Tile 1 of 45 -- Codons 1-76 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGA     | 0.7549   |
| oh2 (3' boundary) | GAGA     | 0.7444   |

**Variants:** 1512 mutations, 1512 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (1512 oligos)               | 284 nt | ATGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert              | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart               | --     | --    | --    |

```
  [ATGA]----oligo+BC----[AGAA]
   ATGA                  AGAA 
```

**Set fidelity:** 1.0000 (2 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1     | 1233 nt | GAGA  | AGAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1077 nt | AGAA  | CAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1143 nt | CAAA  | AAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1275 nt | AAAA  | CCAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 888 nt  | CCAA  | GAAA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1398 nt | GAAA  | TCCC  |
| 8   | 3'WT block        | bsmbi_3wt_tile1_sub7     | 954 nt  | TCCC  | TCCA  |
| 9   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub8     | 2336 nt | TCCA  | CACC  |
| 10  | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAGA]----3'WT sub1----[AGAA]----3'WT sub2----[CAAA]----3'WT sub3----[AAAA]----3'WT sub4----[CCAA]----3'WT sub5----[GAAA]----3'WT sub6----[TCCC]----3'WT sub7----[TCCA]----3'WT+PolIII sub8----[CACC]
   GAGA                   AGAA                   CAAA                   AAAA                   CCAA                   GAAA                   TCCC                   TCCA                          CACC 
```

**Set fidelity:** 0.9196 (9 overhangs)

---

### Tile 2 of 45 -- Codons 77-137 (183 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAG     | 0.7814   |
| oh2 (3' boundary) | CCTT     | 0.6891   |

**Variants:** 1197 mutations, 1197 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 246 nt | ATGA  | TCAG  |
| 2   | Oligo pool      | Tile 2 (1197 oligos)  | 239 nt | TCAG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[TCAG]----oligo+BC----[AGAA]
   ATGA                    TCAG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1     | 1050 nt | CCTT  | AGAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile2_sub2     | 1239 nt | AGAA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile2_sub3     | 1116 nt | AAAA  | CAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile2_sub4     | 1140 nt | CAAA  | CCAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile2_sub5     | 1023 nt | CCAA  | GAAA  |
| 7   | 3'WT block        | bsmbi_3wt_tile2_sub6     | 1263 nt | GAAA  | TCCC  |
| 8   | 3'WT block        | bsmbi_3wt_tile1_sub7     | 954 nt  | TCCC  | TCCA  |
| 9   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub8     | 2336 nt | TCCA  | CACC  |
| 10  | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTT]----3'WT sub1----[AGAA]----3'WT sub2----[AAAA]----3'WT sub3----[CAAA]----3'WT sub4----[CCAA]----3'WT sub5----[GAAA]----3'WT sub6----[TCCC]----3'WT sub7----[TCCA]----3'WT+PolIII sub8----[CACC]
   CCTT                   AGAA                   AAAA                   CAAA                   CCAA                   GAAA                   TCCC                   TCCA                          CACC 
```

**Set fidelity:** 0.9430 (9 overhangs)

---

### Tile 3 of 45 -- Codons 138-211 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCA     | 0.7483   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 1470 mutations, 1470 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 429 nt | ATGA  | ATCA  |
| 2   | Oligo pool      | Tile 3 (1470 oligos)  | 278 nt | ATCA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[ATCA]----oligo+BC----[AGAA]
   ATGA                    ATCA                  AGAA 
```

**Set fidelity:** 0.9953 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1     | 1161 nt | TGAA  | CAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile3_sub2     | 906 nt  | CAAA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile3_sub3     | 1365 nt | AAAA  | AGAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile3_sub4     | 891 nt  | AGAA  | CCAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile3_sub5     | 1134 nt | CCAA  | GAAA  |
| 7   | 3'WT block        | bsmbi_3wt_tile3_sub6     | 1152 nt | GAAA  | TCCC  |
| 8   | 3'WT block        | bsmbi_3wt_tile1_sub7     | 954 nt  | TCCC  | TCCA  |
| 9   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub8     | 2336 nt | TCCA  | CACC  |
| 10  | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[CAAA]----3'WT sub2----[AAAA]----3'WT sub3----[AGAA]----3'WT sub4----[CCAA]----3'WT sub5----[GAAA]----3'WT sub6----[TCCC]----3'WT sub7----[TCCA]----3'WT+PolIII sub8----[CACC]
   TGAA                   CAAA                   AAAA                   AGAA                   CCAA                   GAAA                   TCCC                   TCCA                          CACC 
```

**Set fidelity:** 0.9118 (9 overhangs)

---

### Tile 4 of 45 -- Codons 212-285 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAT     | 0.7246   |
| oh2 (3' boundary) | CAGT     | 0.6512   |

**Variants:** 1470 mutations, 1470 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 651 nt | ATGA  | GAAT  |
| 2   | Oligo pool      | Tile 4 (1470 oligos)  | 278 nt | GAAT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[GAAT]----oligo+BC----[AGAA]
   ATGA                    GAAT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1     | 939 nt  | CAGT  | CAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile4_sub2     | 1158 nt | CAAA  | AGAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile4_sub3     | 1185 nt | AGAA  | AAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile4_sub4     | 894 nt  | AAAA  | TAAG  |
| 6   | 3'WT block        | bsmbi_3wt_tile4_sub5     | 1059 nt | TAAG  | GAAA  |
| 7   | 3'WT block        | bsmbi_3wt_tile3_sub6     | 1152 nt | GAAA  | TCCC  |
| 8   | 3'WT block        | bsmbi_3wt_tile4_sub7     | 1221 nt | TCCC  | TCCA  |
| 9   | 3'WT+PolIII block | bsmbi_3wt_tile4_sub8     | 2069 nt | TCCA  | CACC  |
| 10  | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAGT]----3'WT sub1----[CAAA]----3'WT sub2----[AGAA]----3'WT sub3----[AAAA]----3'WT sub4----[TAAG]----3'WT sub5----[GAAA]----3'WT sub6----[TCCC]----3'WT sub7----[TCCA]----3'WT+PolIII sub8----[CACC]
   CAGT                   CAAA                   AGAA                   AAAA                   TAAG                   GAAA                   TCCC                   TCCA                          CACC 
```

**Set fidelity:** 0.9470 (9 overhangs)

---

### Tile 5 of 45 -- Codons 286-363 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATAC     | 0.6804   |
| oh2 (3' boundary) | CTAC     | 0.6583   |

**Variants:** 1554 mutations, 1554 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 873 nt | ATGA  | ATAC  |
| 2   | Oligo pool      | Tile 5 (1554 oligos)  | 290 nt | ATAC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[ATAC]----oligo+BC----[AGAA]
   ATGA                    ATAC                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1     | 972 nt  | CTAC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile5_sub2     | 1029 nt | GAAA  | CAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile5_sub3     | 1047 nt | CAAA  | AAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile5_sub4     | 1059 nt | AAAA  | AGAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile5_sub5     | 1017 nt | AGAA  | TCCA  |
| 7   | 3'WT block        | bsmbi_3wt_tile5_sub6     | 1029 nt | TCCA  | TCCC  |
| 8   | 3'WT block        | bsmbi_3wt_tile5_sub7     | 1005 nt | TCCC  | TCGA  |
| 9   | 3'WT+PolIII block | bsmbi_3wt_tile5_sub8     | 2285 nt | TCGA  | CACC  |
| 10  | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTAC]----3'WT sub1----[GAAA]----3'WT sub2----[CAAA]----3'WT sub3----[AAAA]----3'WT sub4----[AGAA]----3'WT sub5----[TCCA]----3'WT sub6----[TCCC]----3'WT sub7----[TCGA]----3'WT+PolIII sub8----[CACC]
   CTAC                   GAAA                   CAAA                   AAAA                   AGAA                   TCCA                   TCCC                   TCGA                          CACC 
```

**Set fidelity:** 0.9429 (9 overhangs)

---

### Tile 6 of 45 -- Codons 364-439 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTAA     | 0.8691   |
| oh2 (3' boundary) | CTTG     | 0.7594   |

**Variants:** 1512 mutations, 1512 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 1107 nt | ATGA  | CTAA  |
| 2   | Oligo pool      | Tile 6 (1512 oligos)  | 284 nt  | CTAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT block----[CTAA]----oligo+BC----[AGAA]
   ATGA                    CTAA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1     | 1158 nt | CTTG  | AGAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile6_sub2     | 870 nt  | AGAA  | CAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile6_sub3     | 1020 nt | CAAA  | AAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile6_sub4     | 945 nt  | AAAA  | TCCA  |
| 6   | 3'WT block        | bsmbi_3wt_tile6_sub5     | 1155 nt | TCCA  | TACA  |
| 7   | 3'WT block        | bsmbi_3wt_tile6_sub6     | 903 nt  | TACA  | GAAA  |
| 8   | 3'WT block        | bsmbi_3wt_tile6_sub7     | 1191 nt | GAAA  | TAAG  |
| 9   | 3'WT+PolIII block | bsmbi_3wt_tile6_sub8     | 1973 nt | TAAG  | CACC  |
| 10  | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTTG]----3'WT sub1----[AGAA]----3'WT sub2----[CAAA]----3'WT sub3----[AAAA]----3'WT sub4----[TCCA]----3'WT sub5----[TACA]----3'WT sub6----[GAAA]----3'WT sub7----[TAAG]----3'WT+PolIII sub8----[CACC]
   CTTG                   AGAA                   CAAA                   AAAA                   TCCA                   TACA                   GAAA                   TAAG                          CACC 
```

**Set fidelity:** 0.9581 (9 overhangs)

---

### Tile 7 of 45 -- Codons 440-492 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CGGA     | 0.6609   |
| oh2 (3' boundary) | TCTT     | 0.7985   |

**Variants:** 1029 mutations, 1029 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 1335 nt | ATGA  | CGGA  |
| 2   | Oligo pool      | Tile 7 (1029 oligos)  | 215 nt  | CGGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT block----[CGGA]----oligo+BC----[AGAA]
   ATGA                    CGGA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1     | 1044 nt | TCTT  | CAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile7_sub2     | 1032 nt | CAAA  | TATA  |
| 4   | 3'WT block        | bsmbi_3wt_tile7_sub3     | 813 nt  | TATA  | AAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile6_sub4     | 945 nt  | AAAA  | TCCA  |
| 6   | 3'WT block        | bsmbi_3wt_tile7_sub5     | 1002 nt | TCCA  | AGAA  |
| 7   | 3'WT block        | bsmbi_3wt_tile7_sub6     | 1056 nt | AGAA  | GAAA  |
| 8   | 3'WT block        | bsmbi_3wt_tile6_sub7     | 1191 nt | GAAA  | TAAG  |
| 9   | 3'WT+PolIII block | bsmbi_3wt_tile6_sub8     | 1973 nt | TAAG  | CACC  |
| 10  | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCTT]----3'WT sub1----[CAAA]----3'WT sub2----[TATA]----3'WT sub3----[AAAA]----3'WT sub4----[TCCA]----3'WT sub5----[AGAA]----3'WT sub6----[GAAA]----3'WT sub7----[TAAG]----3'WT+PolIII sub8----[CACC]
   TCTT                   CAAA                   TATA                   AAAA                   TCCA                   AGAA                   GAAA                   TAAG                          CACC 
```

**Set fidelity:** 0.9662 (9 overhangs)

---

### Tile 8 of 45 -- Codons 493-570 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CATA     | 0.7540   |
| oh2 (3' boundary) | GGAC     | 0.5754   |

**Variants:** 1554 mutations, 1554 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1494 nt | ATGA  | CATA  |
| 2   | Oligo pool      | Tile 8 (1554 oligos)  | 290 nt  | CATA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT block----[CATA]----oligo+BC----[AGAA]
   ATGA                    CATA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1     | 972 nt  | GGAC  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile2_sub3     | 1116 nt | AAAA  | CAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile2_sub4     | 1140 nt | CAAA  | CCAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile8_sub4     | 1062 nt | CCAA  | AGAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile8_sub5     | 1350 nt | AGAA  | GAAA  |
| 7   | 3'WT block        | bsmbi_3wt_tile8_sub6     | 828 nt  | GAAA  | TCCA  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub8     | 2336 nt | TCCA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAC]----3'WT sub1----[AAAA]----3'WT sub2----[CAAA]----3'WT sub3----[CCAA]----3'WT sub4----[AGAA]----3'WT sub5----[GAAA]----3'WT sub6----[TCCA]----3'WT+PolIII sub7----[CACC]
   GGAC                   AAAA                   CAAA                   CCAA                   AGAA                   GAAA                   TCCA                          CACC 
```

**Set fidelity:** 0.9645 (8 overhangs)

---

### Tile 9 of 45 -- Codons 571-642 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCC     | 0.7958   |
| oh2 (3' boundary) | TTAT     | 0.8673   |

**Variants:** 1428 mutations, 1428 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1728 nt | ATGA  | TTCC  |
| 2   | Oligo pool      | Tile 9 (1428 oligos)  | 272 nt  | TTCC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT block----[TTCC]----oligo+BC----[AGAA]
   ATGA                    TTCC                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1     | 1146 nt | TTAT  | CAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile5_sub3     | 1047 nt | CAAA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile5_sub4     | 1059 nt | AAAA  | AGAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile9_sub4     | 894 nt  | AGAA  | GAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile3_sub6     | 1152 nt | GAAA  | TCCC  |
| 7   | 3'WT block        | bsmbi_3wt_tile4_sub7     | 1221 nt | TCCC  | TCCA  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile4_sub8     | 2069 nt | TCCA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTAT]----3'WT sub1----[CAAA]----3'WT sub2----[AAAA]----3'WT sub3----[AGAA]----3'WT sub4----[GAAA]----3'WT sub5----[TCCC]----3'WT sub6----[TCCA]----3'WT+PolIII sub7----[CACC]
   TTAT                   CAAA                   AAAA                   AGAA                   GAAA                   TCCC                   TCCA                          CACC 
```

**Set fidelity:** 0.9470 (8 overhangs)

---

### Tile 10 of 45 -- Codons 643-720 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAG     | 0.6752   |
| oh2 (3' boundary) | GACT     | 0.5537   |

**Variants:** 1554 mutations, 1554 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1106 nt | ATGA  | TCTA  |
| 2   | 5'WT gene block | bsai_5wt_tile10_sub2  | 856 nt  | TCTA  | GAAG  |
| 3   | Oligo pool      | Tile 10 (1554 oligos) | 290 nt  | GAAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TCTA]----5'WT sub2----[GAAG]----oligo+BC----[AGAA]
   ATGA                   TCTA                   GAAG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1    | 912 nt  | GACT  | CAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile5_sub3     | 1047 nt | CAAA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile5_sub4     | 1059 nt | AAAA  | AGAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile10_sub4    | 1269 nt | AGAA  | TACA  |
| 6   | 3'WT block        | bsmbi_3wt_tile6_sub6     | 903 nt  | TACA  | GAAA  |
| 7   | 3'WT block        | bsmbi_3wt_tile10_sub6    | 1095 nt | GAAA  | TCCA  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile4_sub8     | 2069 nt | TCCA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GACT]----3'WT sub1----[CAAA]----3'WT sub2----[AAAA]----3'WT sub3----[AGAA]----3'WT sub4----[TACA]----3'WT sub5----[GAAA]----3'WT sub6----[TCCA]----3'WT+PolIII sub7----[CACC]
   GACT                   CAAA                   AAAA                   AGAA                   TACA                   GAAA                   TCCA                          CACC 
```

**Set fidelity:** 0.9581 (8 overhangs)

---

### Tile 11 of 45 -- Codons 721-795 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTCC     | 0.5510   |
| oh2 (3' boundary) | TATC     | 0.8041   |

**Variants:** 1491 mutations, 1491 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1106 nt | ATGA  | TCTA  |
| 2   | 5'WT gene block | bsai_5wt_tile11_sub2  | 1090 nt | TCTA  | CTCC  |
| 3   | Oligo pool      | Tile 11 (1491 oligos) | 281 nt  | CTCC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TCTA]----5'WT sub2----[CTCC]----oligo+BC----[AGAA]
   ATGA                   TCTA                   CTCC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1    | 942 nt  | TATC  | CAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile6_sub3     | 1020 nt | CAAA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile6_sub4     | 945 nt  | AAAA  | TCCA  |
| 5   | 3'WT block        | bsmbi_3wt_tile7_sub5     | 1002 nt | TCCA  | AGAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile7_sub6     | 1056 nt | AGAA  | GAAA  |
| 7   | 3'WT block        | bsmbi_3wt_tile6_sub7     | 1191 nt | GAAA  | TAAG  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile6_sub8     | 1973 nt | TAAG  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TATC]----3'WT sub1----[CAAA]----3'WT sub2----[AAAA]----3'WT sub3----[TCCA]----3'WT sub4----[AGAA]----3'WT sub5----[GAAA]----3'WT sub6----[TAAG]----3'WT+PolIII sub7----[CACC]
   TATC                   CAAA                   AAAA                   TCCA                   AGAA                   GAAA                   TAAG                          CACC 
```

**Set fidelity:** 0.9624 (8 overhangs)

---

### Tile 12 of 45 -- Codons 796-866 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCG     | 0.5700   |
| oh2 (3' boundary) | TAGA     | 0.9115   |

**Variants:** 1407 mutations, 1407 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1106 nt | ATGA  | TCTA  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2  | 1315 nt | TCTA  | ATCG  |
| 3   | Oligo pool      | Tile 12 (1407 oligos) | 269 nt  | ATCG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TCTA]----5'WT sub2----[ATCG]----oligo+BC----[AGAA]
   ATGA                   TCTA                   ATCG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1    | 1047 nt | TAGA  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile12_sub2    | 999 nt  | AAAA  | CAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile12_sub3    | 981 nt  | CAAA  | AGAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile12_sub4    | 918 nt  | AGAA  | GAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile12_sub5    | 867 nt  | GAAA  | TAGC  |
| 7   | 3'WT block        | bsmbi_3wt_tile12_sub6    | 1035 nt | TAGC  | TCCA  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile4_sub8     | 2069 nt | TCCA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAGA]----3'WT sub1----[AAAA]----3'WT sub2----[CAAA]----3'WT sub3----[AGAA]----3'WT sub4----[GAAA]----3'WT sub5----[TAGC]----3'WT sub6----[TCCA]----3'WT+PolIII sub7----[CACC]
   TAGA                   AAAA                   CAAA                   AGAA                   GAAA                   TAGC                   TCCA                          CACC 
```

**Set fidelity:** 0.9550 (8 overhangs)

---

### Tile 13 of 45 -- Codons 867-939 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTGT     | 0.6476   |
| oh2 (3' boundary) | GGCA     | 0.5273   |

**Variants:** 1449 mutations, 1449 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1412 nt | ATGA  | TAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2  | 1222 nt | TAAA  | CTGT  |
| 3   | Oligo pool      | Tile 13 (1449 oligos) | 275 nt  | CTGT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TAAA]----5'WT sub2----[CTGT]----oligo+BC----[AGAA]
   ATGA                   TAAA                   CTGT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1    | 828 nt  | GGCA  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile12_sub2    | 999 nt  | AAAA  | CAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile12_sub3    | 981 nt  | CAAA  | AGAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile12_sub4    | 918 nt  | AGAA  | GAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile13_sub5    | 1116 nt | GAAA  | TACT  |
| 7   | 3'WT block        | bsmbi_3wt_tile13_sub6    | 786 nt  | TACT  | TCCA  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile4_sub8     | 2069 nt | TCCA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGCA]----3'WT sub1----[AAAA]----3'WT sub2----[CAAA]----3'WT sub3----[AGAA]----3'WT sub4----[GAAA]----3'WT sub5----[TACT]----3'WT sub6----[TCCA]----3'WT+PolIII sub7----[CACC]
   GGCA                   AAAA                   CAAA                   AGAA                   GAAA                   TACT                   TCCA                          CACC 
```

**Set fidelity:** 0.9632 (8 overhangs)

---

### Tile 14 of 45 -- Codons 940-1016 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAC     | 0.8333   |
| oh2 (3' boundary) | CTCA     | 0.6872   |

**Variants:** 1533 mutations, 1533 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1412 nt | ATGA  | TAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2  | 1441 nt | TAAA  | TTAC  |
| 3   | Oligo pool      | Tile 14 (1533 oligos) | 287 nt  | TTAC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TAAA]----5'WT sub2----[TTAC]----oligo+BC----[AGAA]
   ATGA                   TAAA                   TTAC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1    | 1053 nt | CTCA  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile14_sub2    | 819 nt  | AAAA  | CCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 888 nt  | CCAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile14_sub4    | 1005 nt | GAAA  | AGAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile14_sub5    | 846 nt  | AGAA  | TACT  |
| 7   | 3'WT block        | bsmbi_3wt_tile13_sub6    | 786 nt  | TACT  | TCCA  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile4_sub8     | 2069 nt | TCCA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTCA]----3'WT sub1----[AAAA]----3'WT sub2----[CCAA]----3'WT sub3----[GAAA]----3'WT sub4----[AGAA]----3'WT sub5----[TACT]----3'WT sub6----[TCCA]----3'WT+PolIII sub7----[CACC]
   CTCA                   AAAA                   CCAA                   GAAA                   AGAA                   TACT                   TCCA                          CACC 
```

**Set fidelity:** 0.9714 (8 overhangs)

---

### Tile 15 of 45 -- Codons 1017-1093 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACA     | 0.8652   |
| oh2 (3' boundary) | AGGA     | 0.7515   |

**Variants:** 1533 mutations, 1533 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1412 nt | ATGA  | TAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2  | 1672 nt | TAAA  | TACA  |
| 3   | Oligo pool      | Tile 15 (1533 oligos) | 287 nt  | TACA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TAAA]----5'WT sub2----[TACA]----oligo+BC----[AGAA]
   ATGA                   TAAA                   TACA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1    | 822 nt  | AGGA  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile5_sub4     | 1059 nt | AAAA  | AGAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile15_sub3    | 648 nt  | AGAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile15_sub4    | 1032 nt | GAAA  | TCCA  |
| 6   | 3'WT block        | bsmbi_3wt_tile15_sub5    | 972 nt  | TCCA  | CCAA  |
| 7   | 3'WT block        | bsmbi_3wt_tile15_sub6    | 729 nt  | CCAA  | TAAG  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile6_sub8     | 1973 nt | TAAG  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGGA]----3'WT sub1----[AAAA]----3'WT sub2----[AGAA]----3'WT sub3----[GAAA]----3'WT sub4----[TCCA]----3'WT sub5----[CCAA]----3'WT sub6----[TAAG]----3'WT+PolIII sub7----[CACC]
   AGGA                   AAAA                   AGAA                   GAAA                   TCCA                   CCAA                   TAAG                          CACC 
```

**Set fidelity:** 0.9355 (8 overhangs)

---

### Tile 16 of 45 -- Codons 1094-1156 (189 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AACA     | 0.8032   |
| oh2 (3' boundary) | GTTC     | 0.5976   |

**Variants:** 1239 mutations, 1239 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1106 nt | ATGA  | TCTA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 969 nt  | TCTA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile16_sub3  | 1258 nt | GAAA  | AACA  |
| 4   | Oligo pool      | Tile 16 (1239 oligos) | 245 nt  | AACA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TCTA]----5'WT sub2----[GAAA]----5'WT sub3----[AACA]----oligo+BC----[AGAA]
   ATGA                   TCTA                   GAAA                   AACA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1    | 861 nt  | GTTC  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile16_sub2    | 1245 nt | AAAA  | CAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile16_sub3    | 861 nt  | CAAA  | AGAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile16_sub4    | 897 nt  | AGAA  | GAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile10_sub6    | 1095 nt | GAAA  | TCCA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile4_sub8     | 2069 nt | TCCA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GTTC]----3'WT sub1----[AAAA]----3'WT sub2----[CAAA]----3'WT sub3----[AGAA]----3'WT sub4----[GAAA]----3'WT sub5----[TCCA]----3'WT+PolIII sub6----[CACC]
   GTTC                   AAAA                   CAAA                   AGAA                   GAAA                   TCCA                          CACC 
```

**Set fidelity:** 0.9662 (7 overhangs)

---

### Tile 17 of 45 -- Codons 1157-1226 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATG     | 0.6412   |
| oh2 (3' boundary) | AGAT     | 0.6825   |

**Variants:** 1386 mutations, 1386 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1106 nt | ATGA  | TCTA  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2  | 1200 nt | TCTA  | TGAA  |
| 3   | 5'WT gene block | bsai_5wt_tile17_sub3  | 1216 nt | TGAA  | AATG  |
| 4   | Oligo pool      | Tile 17 (1386 oligos) | 266 nt  | AATG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TCTA]----5'WT sub2----[TGAA]----5'WT sub3----[AATG]----oligo+BC----[AGAA]
   ATGA                   TCTA                   TGAA                   AATG                  AGAA 
```

**Set fidelity:** 0.9406 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1    | 834 nt  | AGAT  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile17_sub2    | 1062 nt | AAAA  | CAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile16_sub3    | 861 nt  | CAAA  | AGAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile17_sub4    | 1206 nt | AGAA  | TACT  |
| 6   | 3'WT block        | bsmbi_3wt_tile17_sub5    | 816 nt  | TACT  | GAAA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile17_sub6    | 2039 nt | GAAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAT]----3'WT sub1----[AAAA]----3'WT sub2----[CAAA]----3'WT sub3----[AGAA]----3'WT sub4----[TACT]----3'WT sub5----[GAAA]----3'WT+PolIII sub6----[CACC]
   AGAT                   AAAA                   CAAA                   AGAA                   TACT                   GAAA                          CACC 
```

**Set fidelity:** 0.8765 (7 overhangs)

---

### Tile 18 of 45 -- Codons 1227-1301 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGGT     | 0.6250   |
| oh2 (3' boundary) | AAAG     | 0.7511   |

**Variants:** 1491 mutations, 1491 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1106 nt | ATGA  | TCTA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1455 nt | TCTA  | TTTT  |
| 3   | 5'WT gene block | bsai_5wt_tile18_sub3  | 1171 nt | TTTT  | AGGT  |
| 4   | Oligo pool      | Tile 18 (1491 oligos) | 281 nt  | AGGT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TCTA]----5'WT sub2----[TTTT]----5'WT sub3----[AGGT]----oligo+BC----[AGAA]
   ATGA                   TCTA                   TTTT                   AGGT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1    | 777 nt  | AAAG  | CAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile18_sub2    | 927 nt  | CAAA  | AGAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile12_sub4    | 918 nt  | AGAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile13_sub5    | 1116 nt | GAAA  | TACT  |
| 6   | 3'WT block        | bsmbi_3wt_tile13_sub6    | 786 nt  | TACT  | TCCA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile4_sub8     | 2069 nt | TCCA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAG]----3'WT sub1----[CAAA]----3'WT sub2----[AGAA]----3'WT sub3----[GAAA]----3'WT sub4----[TACT]----3'WT sub5----[TCCA]----3'WT+PolIII sub6----[CACC]
   AAAG                   CAAA                   AGAA                   GAAA                   TACT                   TCCA                          CACC 
```

**Set fidelity:** 0.9974 (7 overhangs)

---

### Tile 19 of 45 -- Codons 1302-1374 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAAA     | 0.8948   |
| oh2 (3' boundary) | AGAC     | 0.5696   |

**Variants:** 1449 mutations, 1449 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1412 nt | ATGA  | TAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1284 nt | TAAA  | AAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3  | 1261 nt | AAAA  | CAAA  |
| 4   | Oligo pool      | Tile 19 (1449 oligos) | 275 nt  | CAAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TAAA]----5'WT sub2----[AAAA]----5'WT sub3----[CAAA]----oligo+BC----[AGAA]
   ATGA                   TAAA                   AAAA                   CAAA                  AGAA 
```

**Set fidelity:** 0.9430 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1    | 1020 nt | AGAC  | AGAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile15_sub3    | 648 nt  | AGAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile19_sub3    | 1092 nt | GAAA  | TTTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile19_sub4    | 876 nt  | TTTT  | TTAC  |
| 6   | 3'WT block        | bsmbi_3wt_tile19_sub5    | 669 nt  | TTAC  | TCCA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile4_sub8     | 2069 nt | TCCA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAC]----3'WT sub1----[AGAA]----3'WT sub2----[GAAA]----3'WT sub3----[TTTT]----3'WT sub4----[TTAC]----3'WT sub5----[TCCA]----3'WT+PolIII sub6----[CACC]
   AGAC                   AGAA                   GAAA                   TTTT                   TTAC                   TCCA                          CACC 
```

**Set fidelity:** 0.9752 (7 overhangs)

---

### Tile 20 of 45 -- Codons 1375-1449 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACTT     | 0.7315   |
| oh2 (3' boundary) | TGGC     | 0.5926   |

**Variants:** 1491 mutations, 1491 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1412 nt | ATGA  | TAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1284 nt | TAAA  | AAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile20_sub3  | 1480 nt | AAAA  | ACTT  |
| 4   | Oligo pool      | Tile 20 (1491 oligos) | 281 nt  | ACTT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TAAA]----5'WT sub2----[AAAA]----5'WT sub3----[ACTT]----oligo+BC----[AGAA]
   ATGA                   TAAA                   AAAA                   ACTT                  AGAA 
```

**Set fidelity:** 0.9764 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1    | 873 nt  | TGGC  | CAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile20_sub2    | 849 nt  | CAAA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile20_sub3    | 726 nt  | AAAA  | AGAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile20_sub4    | 999 nt  | AGAA  | CCAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile20_sub5    | 663 nt  | CCAA  | GAAA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile17_sub6    | 2039 nt | GAAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGGC]----3'WT sub1----[CAAA]----3'WT sub2----[AAAA]----3'WT sub3----[AGAA]----3'WT sub4----[CCAA]----3'WT sub5----[GAAA]----3'WT+PolIII sub6----[CACC]
   TGGC                   CAAA                   AAAA                   AGAA                   CCAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9662 (7 overhangs)

---

### Tile 21 of 45 -- Codons 1450-1518 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTA     | 0.7818   |
| oh2 (3' boundary) | AGTG     | 0.5190   |

**Variants:** 1365 mutations, 1365 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1412 nt | ATGA  | TAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1443 nt | TAAA  | ACAA  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3  | 1546 nt | ACAA  | ATTA  |
| 4   | Oligo pool      | Tile 21 (1365 oligos) | 263 nt  | ATTA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TAAA]----5'WT sub2----[ACAA]----5'WT sub3----[ATTA]----oligo+BC----[AGAA]
   ATGA                   TAAA                   ACAA                   ATTA                  AGAA 
```

**Set fidelity:** 0.9825 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1    | 666 nt  | AGTG  | CAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile20_sub2    | 849 nt  | CAAA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile21_sub3    | 798 nt  | AAAA  | AGAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile21_sub4    | 1026 nt | AGAA  | TCCA  |
| 6   | 3'WT block        | bsmbi_3wt_tile21_sub5    | 564 nt  | TCCA  | GAAA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile17_sub6    | 2039 nt | GAAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGTG]----3'WT sub1----[CAAA]----3'WT sub2----[AAAA]----3'WT sub3----[AGAA]----3'WT sub4----[TCCA]----3'WT sub5----[GAAA]----3'WT+PolIII sub6----[CACC]
   AGTG                   CAAA                   AAAA                   AGAA                   TCCA                   GAAA                          CACC 
```

**Set fidelity:** 0.9662 (7 overhangs)

---

### Tile 22 of 45 -- Codons 1519-1593 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGTA     | 0.7286   |
| oh2 (3' boundary) | CCTG     | 0.6383   |

**Variants:** 1491 mutations, 1491 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1412 nt | ATGA  | TAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2  | 1776 nt | TAAA  | TGAA  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1420 nt | TGAA  | AGTA  |
| 4   | Oligo pool      | Tile 22 (1491 oligos) | 281 nt  | AGTA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TAAA]----5'WT sub2----[TGAA]----5'WT sub3----[AGTA]----oligo+BC----[AGAA]
   ATGA                   TAAA                   TGAA                   AGTA                  AGAA 
```

**Set fidelity:** 0.9096 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1    | 777 nt  | CCTG  | CAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile22_sub2    | 702 nt  | CAAA  | AGAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile22_sub3    | 930 nt  | AGAA  | TCCC  |
| 5   | 3'WT block        | bsmbi_3wt_tile22_sub4    | 807 nt  | TCCC  | AAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile22_sub5    | 531 nt  | AAAA  | GAAA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile22_sub6    | 1970 nt | GAAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTG]----3'WT sub1----[CAAA]----3'WT sub2----[AGAA]----3'WT sub3----[TCCC]----3'WT sub4----[AAAA]----3'WT sub5----[GAAA]----3'WT+PolIII sub6----[CACC]
   CCTG                   CAAA                   AGAA                   TCCC                   AAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9662 (7 overhangs)

---

### Tile 23 of 45 -- Codons 1594-1662 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACGA     | 0.7639   |
| oh2 (3' boundary) | TGAC     | 0.6485   |

**Variants:** 1365 mutations, 1365 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1106 nt | ATGA  | TCTA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1455 nt | TCTA  | TTTT  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3  | 1005 nt | TTTT  | TATA  |
| 4   | 5'WT gene block | bsai_5wt_tile23_sub4  | 1285 nt | TATA  | ACGA  |
| 5   | Oligo pool      | Tile 23 (1365 oligos) | 263 nt  | ACGA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TCTA]----5'WT sub2----[TTTT]----5'WT sub3----[TATA]----5'WT sub4----[ACGA]----oligo+BC----[AGAA]
   ATGA                   TCTA                   TTTT                   TATA                   ACGA                  AGAA 
```

**Set fidelity:** 0.9720 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1    | 603 nt  | TGAC  | AGAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile23_sub2    | 744 nt  | AGAA  | CAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile23_sub3    | 981 nt  | CAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile23_sub4    | 681 nt  | GAAA  | AAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile23_sub5    | 528 nt  | AAAA  | TAAG  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile6_sub8     | 1973 nt | TAAG  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAC]----3'WT sub1----[AGAA]----3'WT sub2----[CAAA]----3'WT sub3----[GAAA]----3'WT sub4----[AAAA]----3'WT sub5----[TAAG]----3'WT+PolIII sub6----[CACC]
   TGAC                   AGAA                   CAAA                   GAAA                   AAAA                   TAAG                          CACC 
```

**Set fidelity:** 0.9662 (7 overhangs)

---

### Tile 24 of 45 -- Codons 1663-1735 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTGA     | 0.5613   |
| oh2 (3' boundary) | TGTC     | 0.6650   |

**Variants:** 1449 mutations, 1449 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile24_sub1  | 1403 nt | ATGA  | TTCA  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2  | 1239 nt | TTCA  | TAGA  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3  | 1035 nt | TAGA  | AAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile24_sub4  | 1381 nt | AAAA  | GTGA  |
| 5   | Oligo pool      | Tile 24 (1449 oligos) | 275 nt  | GTGA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTCA]----5'WT sub2----[TAGA]----5'WT sub3----[AAAA]----5'WT sub4----[GTGA]----oligo+BC----[AGAA]
   ATGA                   TTCA                   TAGA                   AAAA                   GTGA                  AGAA 
```

**Set fidelity:** 0.8836 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile24_sub1    | 846 nt  | TGTC  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile20_sub3    | 726 nt  | AAAA  | AGAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile20_sub4    | 999 nt  | AGAA  | CCAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile20_sub5    | 663 nt  | CCAA  | GAAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile17_sub6    | 2039 nt | GAAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGTC]----3'WT sub1----[AAAA]----3'WT sub2----[AGAA]----3'WT sub3----[CCAA]----3'WT sub4----[GAAA]----3'WT+PolIII sub5----[CACC]
   TGTC                   AAAA                   AGAA                   CCAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9727 (6 overhangs)

---

### Tile 25 of 45 -- Codons 1736-1810 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCGC     | 0.6795   |
| oh2 (3' boundary) | CTCG     | 0.7252   |

**Variants:** 1491 mutations, 1491 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1412 nt | ATGA  | TAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1284 nt | TAAA  | AAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3  | 1176 nt | AAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4  | 1405 nt | GAAA  | TCGC  |
| 5   | Oligo pool      | Tile 25 (1491 oligos) | 281 nt  | TCGC  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TAAA]----5'WT sub2----[AAAA]----5'WT sub3----[GAAA]----5'WT sub4----[TCGC]----oligo+BC----[AGAA]
   ATGA                   TAAA                   AAAA                   GAAA                   TCGC                  AGAA 
```

**Set fidelity:** 0.9403 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile25_sub1    | 717 nt  | CTCG  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile25_sub2    | 723 nt  | AAAA  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile25_sub3    | 1005 nt | AAAT  | TCCA  |
| 5   | 3'WT block        | bsmbi_3wt_tile25_sub4    | 807 nt  | TCCA  | AGAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile25_sub5    | 1796 nt | AGAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTCG]----3'WT sub1----[AAAA]----3'WT sub2----[AAAT]----3'WT sub3----[TCCA]----3'WT sub4----[AGAA]----3'WT+PolIII sub5----[CACC]
   CTCG                   AAAA                   AAAT                   TCCA                   AGAA                          CACC 
```

**Set fidelity:** 0.9505 (6 overhangs)

---

### Tile 26 of 45 -- Codons 1811-1872 (186 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GACG     | 0.4599   |
| oh2 (3' boundary) | CCAG     | 0.6122   |

**Variants:** 1218 mutations, 1218 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1412 nt | ATGA  | TAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1284 nt | TAAA  | AAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3  | 1275 nt | AAAA  | TTAT  |
| 4   | 5'WT gene block | bsai_5wt_tile26_sub4  | 1531 nt | TTAT  | GACG  |
| 5   | Oligo pool      | Tile 26 (1218 oligos) | 242 nt  | GACG  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TAAA]----5'WT sub2----[AAAA]----5'WT sub3----[TTAT]----5'WT sub4----[GACG]----oligo+BC----[AGAA]
   ATGA                   TAAA                   AAAA                   TTAT                   GACG                  AGAA 
```

**Set fidelity:** 0.9764 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile26_sub1    | 699 nt  | CCAG  | CAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile26_sub2    | 936 nt  | CAAA  | AGAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile26_sub3    | 726 nt  | AGAA  | AAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile22_sub5    | 531 nt  | AAAA  | GAAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile22_sub6    | 1970 nt | GAAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCAG]----3'WT sub1----[CAAA]----3'WT sub2----[AGAA]----3'WT sub3----[AAAA]----3'WT sub4----[GAAA]----3'WT+PolIII sub5----[CACC]
   CCAG                   CAAA                   AGAA                   AAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9662 (6 overhangs)

---

### Tile 27 of 45 -- Codons 1873-1947 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGG     | 0.5393   |
| oh2 (3' boundary) | CTCT     | 0.6347   |

**Variants:** 1491 mutations, 1491 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1412 nt | ATGA  | TAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1284 nt | TAAA  | AAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3  | 1641 nt | AAAA  | AATA  |
| 4   | 5'WT gene block | bsai_5wt_tile27_sub4  | 1351 nt | AATA  | ATGG  |
| 5   | Oligo pool      | Tile 27 (1491 oligos) | 281 nt  | ATGG  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TAAA]----5'WT sub2----[AAAA]----5'WT sub3----[AATA]----5'WT sub4----[ATGG]----oligo+BC----[AGAA]
   ATGA                   TAAA                   AAAA                   AATA                   ATGG                  AGAA 
```

**Set fidelity:** 0.8624 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile27_sub1    | 558 nt  | CTCT  | AGAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile16_sub4    | 897 nt  | AGAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile23_sub4    | 681 nt  | GAAA  | AAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile27_sub4    | 570 nt  | AAAA  | TAAG  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile27_sub5    | 1931 nt | TAAG  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTCT]----3'WT sub1----[AGAA]----3'WT sub2----[GAAA]----3'WT sub3----[AAAA]----3'WT sub4----[TAAG]----3'WT+PolIII sub5----[CACC]
   CTCT                   AGAA                   GAAA                   AAAA                   TAAG                          CACC 
```

**Set fidelity:** 0.9674 (6 overhangs)

---

### Tile 28 of 45 -- Codons 1948-2018 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCC     | 0.7759   |
| oh2 (3' boundary) | GATT     | 0.6417   |

**Variants:** 1407 mutations, 1407 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1412 nt | ATGA  | TAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1443 nt | TAAA  | ACAA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3  | 1506 nt | ACAA  | AAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4  | 1552 nt | AAAA  | TCCC  |
| 5   | Oligo pool      | Tile 28 (1407 oligos) | 269 nt  | TCCC  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TAAA]----5'WT sub2----[ACAA]----5'WT sub3----[AAAA]----5'WT sub4----[TCCC]----oligo+BC----[AGAA]
   ATGA                   TAAA                   ACAA                   AAAA                   TCCC                  AGAA 
```

**Set fidelity:** 0.9674 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile28_sub1    | 705 nt  | GATT  | AGAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile28_sub2    | 537 nt  | AGAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile23_sub4    | 681 nt  | GAAA  | AAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile28_sub4    | 798 nt  | AAAA  | GGAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile28_sub5    | 1703 nt | GGAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GATT]----3'WT sub1----[AGAA]----3'WT sub2----[GAAA]----3'WT sub3----[AAAA]----3'WT sub4----[GGAA]----3'WT+PolIII sub5----[CACC]
   GATT                   AGAA                   GAAA                   AAAA                   GGAA                          CACC 
```

**Set fidelity:** 0.8850 (6 overhangs)

---

### Tile 29 of 45 -- Codons 2019-2058 (120 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCC     | 0.6015   |
| oh2 (3' boundary) | TTGT     | 0.7145   |

**Variants:** 756 mutations, 756 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1412 nt | ATGA  | TAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile29_sub2  | 1497 nt | TAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile29_sub3  | 1635 nt | GAAA  | AAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile29_sub4  | 1582 nt | AAAA  | ATCC  |
| 5   | Oligo pool      | Tile 29 (756 oligos)  | 176 nt  | ATCC  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TAAA]----5'WT sub2----[GAAA]----5'WT sub3----[AAAA]----5'WT sub4----[ATCC]----oligo+BC----[AGAA]
   ATGA                   TAAA                   GAAA                   AAAA                   ATCC                  AGAA 
```

**Set fidelity:** 0.9403 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile29_sub1    | 585 nt  | TTGT  | AGAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile14_sub5    | 846 nt  | AGAA  | TACT  |
| 4   | 3'WT block        | bsmbi_3wt_tile29_sub3    | 372 nt  | TACT  | AAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile29_sub4    | 894 nt  | AAAA  | CAAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile29_sub5    | 1607 nt | CAAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTGT]----3'WT sub1----[AGAA]----3'WT sub2----[TACT]----3'WT sub3----[AAAA]----3'WT sub4----[CAAA]----3'WT+PolIII sub5----[CACC]
   TTGT                   AGAA                   TACT                   AAAA                   CAAA                          CACC 
```

**Set fidelity:** 0.9842 (6 overhangs)

---

### Tile 30 of 45 -- Codons 2059-2096 (114 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATAG     | 0.7330   |
| oh2 (3' boundary) | ACCA     | 0.7200   |

**Variants:** 714 mutations, 714 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1412 nt | ATGA  | TAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2  | 1776 nt | TAAA  | TGAA  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3  | 1356 nt | TGAA  | AAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile30_sub4  | 1702 nt | AAAA  | ATAG  |
| 5   | Oligo pool      | Tile 30 (714 oligos)  | 170 nt  | ATAG  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TAAA]----5'WT sub2----[TGAA]----5'WT sub3----[AAAA]----5'WT sub4----[ATAG]----oligo+BC----[AGAA]
   ATGA                   TAAA                   TGAA                   AAAA                   ATAG                  AGAA 
```

**Set fidelity:** 0.9144 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile30_sub1    | 864 nt  | ACCA  | TCCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile22_sub4    | 807 nt  | TCCC  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile30_sub3    | 705 nt  | AAAA  | AGAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile25_sub5    | 1796 nt | AGAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACCA]----3'WT sub1----[TCCC]----3'WT sub2----[AAAA]----3'WT sub3----[AGAA]----3'WT+PolIII sub4----[CACC]
   ACCA                   TCCC                   AAAA                   AGAA                          CACC 
```

**Set fidelity:** 0.9911 (5 overhangs)

---

### Tile 31 of 45 -- Codons 2097-2159 (189 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTGA     | 0.8853   |
| oh2 (3' boundary) | TAAA     | 0.9392   |

**Variants:** 1239 mutations, 1239 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1412 nt | ATGA  | TAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1284 nt | TAAA  | AAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile31_sub3  | 1104 nt | AAAA  | TTCA  |
| 4   | 5'WT gene block | bsai_5wt_tile31_sub4  | 1152 nt | TTCA  | CCAA  |
| 5   | 5'WT gene block | bsai_5wt_tile31_sub5  | 1426 nt | CCAA  | TTGA  |
| 6   | Oligo pool      | Tile 31 (1239 oligos) | 245 nt  | TTGA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TAAA]----5'WT sub2----[AAAA]----5'WT sub3----[TTCA]----5'WT sub4----[CCAA]----5'WT sub5----[TTGA]----oligo+BC----[AGAA]
   ATGA                   TAAA                   AAAA                   TTCA                   CCAA                   TTGA                  AGAA 
```

**Set fidelity:** 0.9398 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile31_sub1    | 675 nt  | TAAA  | TCCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile31_sub2    | 606 nt  | TCCC  | CCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile31_sub3    | 435 nt  | CCAA  | CAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile31_sub4    | 489 nt  | CAAA  | AGAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile25_sub5    | 1796 nt | AGAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAAA]----3'WT sub1----[TCCC]----3'WT sub2----[CCAA]----3'WT sub3----[CAAA]----3'WT sub4----[AGAA]----3'WT+PolIII sub5----[CACC]
   TAAA                   TCCC                   CCAA                   CAAA                   AGAA                          CACC 
```

**Set fidelity:** 0.9550 (6 overhangs)

---

### Tile 32 of 45 -- Codons 2160-2220 (183 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCCC     | 0.5462   |
| oh2 (3' boundary) | TTGC     | 0.7336   |

**Variants:** 1197 mutations, 1197 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1412 nt | ATGA  | TAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1284 nt | TAAA  | AAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile31_sub3  | 1104 nt | AAAA  | TTCA  |
| 4   | 5'WT gene block | bsai_5wt_tile32_sub4  | 1506 nt | TTCA  | TCCA  |
| 5   | 5'WT gene block | bsai_5wt_tile32_sub5  | 1261 nt | TCCA  | GCCC  |
| 6   | Oligo pool      | Tile 32 (1197 oligos) | 239 nt  | GCCC  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TAAA]----5'WT sub2----[AAAA]----5'WT sub3----[TTCA]----5'WT sub4----[TCCA]----5'WT sub5----[GCCC]----oligo+BC----[AGAA]
   ATGA                   TAAA                   AAAA                   TTCA                   TCCA                   GCCC                  AGAA 
```

**Set fidelity:** 0.9612 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile32_sub1    | 573 nt  | TTGC  | AGAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile26_sub3    | 726 nt  | AGAA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile28_sub4    | 798 nt  | AAAA  | GGAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile28_sub5    | 1703 nt | GGAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTGC]----3'WT sub1----[AGAA]----3'WT sub2----[AAAA]----3'WT sub3----[GGAA]----3'WT+PolIII sub4----[CACC]
   TTGC                   AGAA                   AAAA                   GGAA                          CACC 
```

**Set fidelity:** 0.9381 (5 overhangs)

---

### Tile 33 of 45 -- Codons 2221-2288 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGTT     | 0.6748   |
| oh2 (3' boundary) | CGGG     | 0.5212   |

**Variants:** 1344 mutations, 1344 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1412 nt | ATGA  | TAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1284 nt | TAAA  | AAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile33_sub3  | 1218 nt | AAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile33_sub4  | 1392 nt | GAAA  | TCCA  |
| 5   | 5'WT gene block | bsai_5wt_tile33_sub5  | 1444 nt | TCCA  | AGTT  |
| 6   | Oligo pool      | Tile 33 (1344 oligos) | 260 nt  | AGTT  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TAAA]----5'WT sub2----[AAAA]----5'WT sub3----[GAAA]----5'WT sub4----[TCCA]----5'WT sub5----[AGTT]----oligo+BC----[AGAA]
   ATGA                   TAAA                   AAAA                   GAAA                   TCCA                   AGTT                  AGAA 
```

**Set fidelity:** 0.9403 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile33_sub1    | 975 nt  | CGGG  | TCCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile25_sub4    | 807 nt  | TCCA  | AGAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile25_sub5    | 1796 nt | AGAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CGGG]----3'WT sub1----[TCCA]----3'WT sub2----[AGAA]----3'WT+PolIII sub3----[CACC]
   CGGG                   TCCA                   AGAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 34 of 45 -- Codons 2289-2365 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AACC     | 0.5451   |
| oh2 (3' boundary) | TACG     | 0.6478   |

**Variants:** 1533 mutations, 1533 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1412 nt | ATGA  | TAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1284 nt | TAAA  | AAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3  | 1443 nt | AAAA  | TGAA  |
| 4   | 5'WT gene block | bsai_5wt_tile34_sub4  | 1461 nt | TGAA  | TCTC  |
| 5   | 5'WT gene block | bsai_5wt_tile34_sub5  | 1354 nt | TCTC  | AACC  |
| 6   | Oligo pool      | Tile 34 (1533 oligos) | 287 nt  | AACC  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TAAA]----5'WT sub2----[AAAA]----5'WT sub3----[TGAA]----5'WT sub4----[TCTC]----5'WT sub5----[AACC]----oligo+BC----[AGAA]
   ATGA                   TAAA                   AAAA                   TGAA                   TCTC                   AACC                  AGAA 
```

**Set fidelity:** 0.9144 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile34_sub1    | 846 nt  | TACG  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile30_sub3    | 705 nt  | AAAA  | AGAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile25_sub5    | 1796 nt | AGAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TACG]----3'WT sub1----[AAAA]----3'WT sub2----[AGAA]----3'WT+PolIII sub3----[CACC]
   TACG                   AAAA                   AGAA                          CACC 
```

**Set fidelity:** 0.9911 (4 overhangs)

---

### Tile 35 of 45 -- Codons 2366-2442 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGT     | 0.6822   |
| oh2 (3' boundary) | GCTT     | 0.5632   |

**Variants:** 1533 mutations, 1533 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1412 nt | ATGA  | TAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1443 nt | TAAA  | ACAA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3  | 1506 nt | ACAA  | AAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile35_sub4  | 1461 nt | AAAA  | GAAA  |
| 5   | 5'WT gene block | bsai_5wt_tile35_sub5  | 1363 nt | GAAA  | ATGT  |
| 6   | Oligo pool      | Tile 35 (1533 oligos) | 287 nt  | ATGT  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TAAA]----5'WT sub2----[ACAA]----5'WT sub3----[AAAA]----5'WT sub4----[GAAA]----5'WT sub5----[ATGT]----oligo+BC----[AGAA]
   ATGA                   TAAA                   ACAA                   AAAA                   GAAA                   ATGT                  AGAA 
```

**Set fidelity:** 0.8659 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile35_sub1    | 615 nt  | GCTT  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile30_sub3    | 705 nt  | AAAA  | AGAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile25_sub5    | 1796 nt | AGAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCTT]----3'WT sub1----[AAAA]----3'WT sub2----[AGAA]----3'WT+PolIII sub3----[CACC]
   GCTT                   AAAA                   AGAA                          CACC 
```

**Set fidelity:** 0.9911 (4 overhangs)

---

### Tile 36 of 45 -- Codons 2443-2512 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACCC     | 0.5528   |
| oh2 (3' boundary) | CCAC     | 0.5426   |

**Variants:** 1386 mutations, 1386 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1412 nt | ATGA  | TAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1443 nt | TAAA  | ACAA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3  | 1506 nt | ACAA  | AAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4  | 1617 nt | AAAA  | AAGA  |
| 5   | 5'WT gene block | bsai_5wt_tile36_sub5  | 1438 nt | AAGA  | ACCC  |
| 6   | Oligo pool      | Tile 36 (1386 oligos) | 266 nt  | ACCC  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TAAA]----5'WT sub2----[ACAA]----5'WT sub3----[AAAA]----5'WT sub4----[AAGA]----5'WT sub5----[ACCC]----oligo+BC----[AGAA]
   ATGA                   TAAA                   ACAA                   AAAA                   AAGA                   ACCC                  AGAA 
```

**Set fidelity:** 0.9179 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile36_sub1    | 621 nt  | CCAC  | CAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile31_sub4    | 489 nt  | CAAA  | AGAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile25_sub5    | 1796 nt | AGAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCAC]----3'WT sub1----[CAAA]----3'WT sub2----[AGAA]----3'WT+PolIII sub3----[CACC]
   CCAC                   CAAA                   AGAA                          CACC 
```

**Set fidelity:** 0.9923 (4 overhangs)

---

### Tile 37 of 45 -- Codons 2513-2582 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACAC     | 0.5629   |
| oh2 (3' boundary) | GCAG     | 0.5118   |

**Variants:** 1386 mutations, 1386 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1412 nt | ATGA  | TAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile29_sub2  | 1497 nt | TAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile29_sub3  | 1635 nt | GAAA  | AAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile37_sub4  | 1434 nt | AAAA  | AAGA  |
| 5   | 5'WT gene block | bsai_5wt_tile37_sub5  | 1648 nt | AAGA  | ACAC  |
| 6   | Oligo pool      | Tile 37 (1386 oligos) | 266 nt  | ACAC  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TAAA]----5'WT sub2----[GAAA]----5'WT sub3----[AAAA]----5'WT sub4----[AAGA]----5'WT sub5----[ACAC]----oligo+BC----[AGAA]
   ATGA                   TAAA                   GAAA                   AAAA                   AAGA                   ACAC                  AGAA 
```

**Set fidelity:** 0.8921 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile37_sub1    | 882 nt  | GCAG  | AGAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile25_sub5    | 1796 nt | AGAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCAG]----3'WT sub1----[AGAA]----3'WT+PolIII sub2----[CACC]
   GCAG                   AGAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 38 of 45 -- Codons 2583-2656 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGCA     | 0.5690   |
| oh2 (3' boundary) | TCGG     | 0.6343   |

**Variants:** 1470 mutations, 1470 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1412 nt | ATGA  | TAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2  | 1776 nt | TAAA  | TGAA  |
| 3   | 5'WT gene block | bsai_5wt_tile38_sub3  | 1431 nt | TGAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile38_sub4  | 1578 nt | GAAA  | AAAA  |
| 5   | 5'WT gene block | bsai_5wt_tile38_sub5  | 1639 nt | AAAA  | AGCA  |
| 6   | Oligo pool      | Tile 38 (1470 oligos) | 278 nt  | AGCA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TAAA]----5'WT sub2----[TGAA]----5'WT sub3----[GAAA]----5'WT sub4----[AAAA]----5'WT sub5----[AGCA]----oligo+BC----[AGAA]
   ATGA                   TAAA                   TGAA                   GAAA                   AAAA                   AGCA                  AGAA 
```

**Set fidelity:** 0.8641 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile38_sub1    | 660 nt  | TCGG  | AGAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile25_sub5    | 1796 nt | AGAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCGG]----3'WT sub1----[AGAA]----3'WT+PolIII sub2----[CACC]
   TCGG                   AGAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 39 of 45 -- Codons 2657-2713 (171 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AACG     | 0.5566   |
| oh2 (3' boundary) | TACC     | 0.7054   |

**Variants:** 1113 mutations, 1113 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1412 nt | ATGA  | TAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1284 nt | TAAA  | AAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile33_sub3  | 1218 nt | AAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile33_sub4  | 1392 nt | GAAA  | TCCA  |
| 5   | 5'WT gene block | bsai_5wt_tile39_sub5  | 1539 nt | TCCA  | TTCA  |
| 6   | 5'WT gene block | bsai_5wt_tile39_sub6  | 1231 nt | TTCA  | AACG  |
| 7   | Oligo pool      | Tile 39 (1113 oligos) | 227 nt  | AACG  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TAAA]----5'WT sub2----[AAAA]----5'WT sub3----[GAAA]----5'WT sub4----[TCCA]----5'WT sub5----[TTCA]----5'WT sub6----[AACG]----oligo+BC----[AGAA]
   ATGA                   TAAA                   AAAA                   GAAA                   TCCA                   TTCA                   AACG                  AGAA 
```

**Set fidelity:** 0.9256 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile39_sub1    | 678 nt  | TACC  | CAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile29_sub5    | 1607 nt | CAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TACC]----3'WT sub1----[CAAA]----3'WT+PolIII sub2----[CACC]
   TACC                   CAAA                          CACC 
```

**Set fidelity:** 0.7487 (3 overhangs)

---

### Tile 40 of 45 -- Codons 2714-2745 (96 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCCT     | 0.5289   |
| oh2 (3' boundary) | CGTG     | 0.5892   |

**Variants:** 588 mutations, 588 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1412 nt | ATGA  | TAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1284 nt | TAAA  | AAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3  | 1275 nt | AAAA  | TTAT  |
| 4   | 5'WT gene block | bsai_5wt_tile40_sub4  | 1629 nt | TTAT  | TCTC  |
| 5   | 5'WT gene block | bsai_5wt_tile40_sub5  | 1245 nt | TCTC  | TTCA  |
| 6   | 5'WT gene block | bsai_5wt_tile40_sub6  | 1402 nt | TTCA  | GCCT  |
| 7   | Oligo pool      | Tile 40 (588 oligos)  | 152 nt  | GCCT  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TAAA]----5'WT sub2----[AAAA]----5'WT sub3----[TTAT]----5'WT sub4----[TCTC]----5'WT sub5----[TTCA]----5'WT sub6----[GCCT]----oligo+BC----[AGAA]
   ATGA                   TAAA                   AAAA                   TTAT                   TCTC                   TTCA                   GCCT                  AGAA 
```

**Set fidelity:** 0.9764 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile40_sub1    | 582 nt  | CGTG  | CAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile29_sub5    | 1607 nt | CAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CGTG]----3'WT sub1----[CAAA]----3'WT+PolIII sub2----[CACC]
   CGTG                   CAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 41 of 45 -- Codons 2746-2823 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTG     | 0.6124   |
| oh2 (3' boundary) | TGTG     | 0.5408   |

**Variants:** 1554 mutations, 1554 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1412 nt | ATGA  | TAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1284 nt | TAAA  | AAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3  | 1443 nt | AAAA  | TGAA  |
| 4   | 5'WT gene block | bsai_5wt_tile34_sub4  | 1461 nt | TGAA  | TCTC  |
| 5   | 5'WT gene block | bsai_5wt_tile41_sub5  | 1254 nt | TCTC  | TCCA  |
| 6   | 5'WT gene block | bsai_5wt_tile41_sub6  | 1489 nt | TCCA  | ATTG  |
| 7   | Oligo pool      | Tile 41 (1554 oligos) | 290 nt  | ATTG  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TAAA]----5'WT sub2----[AAAA]----5'WT sub3----[TGAA]----5'WT sub4----[TCTC]----5'WT sub5----[TCCA]----5'WT sub6----[ATTG]----oligo+BC----[AGAA]
   ATGA                   TAAA                   AAAA                   TGAA                   TCTC                   TCCA                   ATTG                  AGAA 
```

**Set fidelity:** 0.9144 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile41_sub1    | 348 nt  | TGTG  | CAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile29_sub5    | 1607 nt | CAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGTG]----3'WT sub1----[CAAA]----3'WT+PolIII sub2----[CACC]
   TGTG                   CAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 42 of 45 -- Codons 2824-2883 (180 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACTA     | 0.7946   |
| oh2 (3' boundary) | CCTC     | 0.5668   |

**Variants:** 1176 mutations, 1176 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1412 nt | ATGA  | TAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1443 nt | TAAA  | ACAA  |
| 3   | 5'WT gene block | bsai_5wt_tile42_sub3  | 1278 nt | ACAA  | AAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile42_sub4  | 1689 nt | AAAA  | GAAA  |
| 5   | 5'WT gene block | bsai_5wt_tile42_sub5  | 1338 nt | GAAA  | CTCG  |
| 6   | 5'WT gene block | bsai_5wt_tile42_sub6  | 1417 nt | CTCG  | ACTA  |
| 7   | Oligo pool      | Tile 42 (1176 oligos) | 236 nt  | ACTA  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TAAA]----5'WT sub2----[ACAA]----5'WT sub3----[AAAA]----5'WT sub4----[GAAA]----5'WT sub5----[CTCG]----5'WT sub6----[ACTA]----oligo+BC----[AGAA]
   ATGA                   TAAA                   ACAA                   AAAA                   GAAA                   CTCG                   ACTA                  AGAA 
```

**Set fidelity:** 0.9020 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile42         | 1757 nt | CCTC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTC]----3'WT+PolIII----[CACC]
   CCTC                     CACC 
```

**Set fidelity:** 0.9923 (2 overhangs)

---

### Tile 43 of 45 -- Codons 2884-2957 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TGGG     | 0.5031   |
| oh2 (3' boundary) | CCCT     | 0.6204   |

**Variants:** 1470 mutations, 1470 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1412 nt | ATGA  | TAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1443 nt | TAAA  | ACAA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3  | 1506 nt | ACAA  | AAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4  | 1617 nt | AAAA  | AAGA  |
| 5   | 5'WT gene block | bsai_5wt_tile43_sub5  | 1368 nt | AAGA  | GAAA  |
| 6   | 5'WT gene block | bsai_5wt_tile43_sub6  | 1411 nt | GAAA  | TGGG  |
| 7   | Oligo pool      | Tile 43 (1470 oligos) | 278 nt  | TGGG  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TAAA]----5'WT sub2----[ACAA]----5'WT sub3----[AAAA]----5'WT sub4----[AAGA]----5'WT sub5----[GAAA]----5'WT sub6----[TGGG]----oligo+BC----[AGAA]
   ATGA                   TAAA                   ACAA                   AAAA                   AAGA                   GAAA                   TGGG                  AGAA 
```

**Set fidelity:** 0.8839 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile43         | 1535 nt | CCCT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCCT]----3'WT+PolIII----[CACC]
   CCCT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 44 of 45 -- Codons 2958-3024 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCG     | 0.6891   |
| oh2 (3' boundary) | GTGC     | 0.4969   |

**Variants:** 1323 mutations, 1323 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1412 nt | ATGA  | TAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1443 nt | TAAA  | ACAA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3  | 1506 nt | ACAA  | AAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4  | 1617 nt | AAAA  | AAGA  |
| 5   | 5'WT gene block | bsai_5wt_tile43_sub5  | 1368 nt | AAGA  | GAAA  |
| 6   | 5'WT gene block | bsai_5wt_tile44_sub6  | 1633 nt | GAAA  | TTCG  |
| 7   | Oligo pool      | Tile 44 (1323 oligos) | 257 nt  | TTCG  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TAAA]----5'WT sub2----[ACAA]----5'WT sub3----[AAAA]----5'WT sub4----[AAGA]----5'WT sub5----[GAAA]----5'WT sub6----[TTCG]----oligo+BC----[AGAA]
   ATGA                   TAAA                   ACAA                   AAAA                   AAGA                   GAAA                   TTCG                  AGAA 
```

**Set fidelity:** 0.8839 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile44         | 1334 nt | GTGC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GTGC]----3'WT+PolIII----[CACC]
   GTGC                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 45 of 45 -- Codons 3025-3098 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAGT     | 0.6209   |
| oh2 (3' boundary) | TTGA     | 0.8853   |

**Variants:** 1470 mutations, 1470 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1412 nt | ATGA  | TAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile29_sub2  | 1497 nt | TAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile29_sub3  | 1635 nt | GAAA  | AAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile37_sub4  | 1434 nt | AAAA  | AAGA  |
| 5   | 5'WT gene block | bsai_5wt_tile45_sub5  | 1746 nt | AAGA  | TGAA  |
| 6   | 5'WT gene block | bsai_5wt_tile45_sub6  | 1456 nt | TGAA  | GAGT  |
| 7   | Oligo pool      | Tile 45 (1470 oligos) | 278 nt  | GAGT  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TAAA]----5'WT sub2----[GAAA]----5'WT sub3----[AAAA]----5'WT sub4----[AAGA]----5'WT sub5----[TGAA]----5'WT sub6----[GAGT]----oligo+BC----[AGAA]
   ATGA                   TAAA                   GAAA                   AAAA                   AAGA                   TGAA                   GAGT                  AGAA 
```

**Set fidelity:** 0.8355 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component            | Part name                | Length  | 5' OH | 3' OH |
| --- | -------------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product         | (in helper plasmid)      | --      | --    | --    |
| 2   | PolIII-only fragment | bsmbi_polIII_tile45      | 1112 nt | TTGA  | CACC  |
| 3   | Enzyme + buffer      | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTGA]----PolIII----[CACC]
   TTGA                CACC 
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

**Total blocks:** 235

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| --------------------- | ----------- | ----------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10_sub1  | 1106        | BsaI        | 5wt_tile10_sub1;5wt_tile11_sub1;5wt_tile12_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile10_sub2  | 856         | BsaI        | 5wt_tile10_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile11_sub2  | 1090        | BsaI        | 5wt_tile11_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile12_sub2  | 1315        | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile13_sub1  | 1412        | BsaI        | 5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile25_sub1;5wt_tile26_sub1;5wt_tile27_sub1;5wt_tile28_sub1;5wt_tile29_sub1;5wt_tile30_sub1;5wt_tile31_sub1;5wt_tile32_sub1;5wt_tile33_sub1;5wt_tile34_sub1;5wt_tile35_sub1;5wt_tile36_sub1;5wt_tile37_sub1;5wt_tile38_sub1;5wt_tile39_sub1;5wt_tile40_sub1;5wt_tile41_sub1;5wt_tile42_sub1;5wt_tile43_sub1;5wt_tile44_sub1;5wt_tile45_sub1 |
| bsai_5wt_tile13_sub2  | 1222        | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile14_sub2  | 1441        | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile15_sub2  | 1672        | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile16_sub2  | 969         | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile16_sub3  | 1258        | BsaI        | 5wt_tile16_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile17_sub2  | 1200        | BsaI        | 5wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile17_sub3  | 1216        | BsaI        | 5wt_tile17_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile18_sub2  | 1455        | BsaI        | 5wt_tile18_sub2;5wt_tile23_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile18_sub3  | 1171        | BsaI        | 5wt_tile18_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile19_sub2  | 1284        | BsaI        | 5wt_tile19_sub2;5wt_tile20_sub2;5wt_tile25_sub2;5wt_tile26_sub2;5wt_tile27_sub2;5wt_tile31_sub2;5wt_tile32_sub2;5wt_tile33_sub2;5wt_tile34_sub2;5wt_tile39_sub2;5wt_tile40_sub2;5wt_tile41_sub2                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile19_sub3  | 1261        | BsaI        | 5wt_tile19_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile2        | 246         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile20_sub3  | 1480        | BsaI        | 5wt_tile20_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile21_sub2  | 1443        | BsaI        | 5wt_tile21_sub2;5wt_tile28_sub2;5wt_tile35_sub2;5wt_tile36_sub2;5wt_tile42_sub2;5wt_tile43_sub2;5wt_tile44_sub2                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile21_sub3  | 1546        | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile22_sub2  | 1776        | BsaI        | 5wt_tile22_sub2;5wt_tile30_sub2;5wt_tile38_sub2                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile22_sub3  | 1420        | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile23_sub3  | 1005        | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile23_sub4  | 1285        | BsaI        | 5wt_tile23_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile24_sub1  | 1403        | BsaI        | 5wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile24_sub2  | 1239        | BsaI        | 5wt_tile24_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile24_sub3  | 1035        | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile24_sub4  | 1381        | BsaI        | 5wt_tile24_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile25_sub3  | 1176        | BsaI        | 5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile25_sub4  | 1405        | BsaI        | 5wt_tile25_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile26_sub3  | 1275        | BsaI        | 5wt_tile26_sub3;5wt_tile40_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile26_sub4  | 1531        | BsaI        | 5wt_tile26_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile27_sub3  | 1641        | BsaI        | 5wt_tile27_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile27_sub4  | 1351        | BsaI        | 5wt_tile27_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile28_sub3  | 1506        | BsaI        | 5wt_tile28_sub3;5wt_tile35_sub3;5wt_tile36_sub3;5wt_tile43_sub3;5wt_tile44_sub3                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile28_sub4  | 1552        | BsaI        | 5wt_tile28_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile29_sub2  | 1497        | BsaI        | 5wt_tile29_sub2;5wt_tile37_sub2;5wt_tile45_sub2                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile29_sub3  | 1635        | BsaI        | 5wt_tile29_sub3;5wt_tile37_sub3;5wt_tile45_sub3                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile29_sub4  | 1582        | BsaI        | 5wt_tile29_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile3        | 429         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile30_sub3  | 1356        | BsaI        | 5wt_tile30_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile30_sub4  | 1702        | BsaI        | 5wt_tile30_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile31_sub3  | 1104        | BsaI        | 5wt_tile31_sub3;5wt_tile32_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile31_sub4  | 1152        | BsaI        | 5wt_tile31_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile31_sub5  | 1426        | BsaI        | 5wt_tile31_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile32_sub4  | 1506        | BsaI        | 5wt_tile32_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile32_sub5  | 1261        | BsaI        | 5wt_tile32_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile33_sub3  | 1218        | BsaI        | 5wt_tile33_sub3;5wt_tile39_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile33_sub4  | 1392        | BsaI        | 5wt_tile33_sub4;5wt_tile39_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile33_sub5  | 1444        | BsaI        | 5wt_tile33_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile34_sub3  | 1443        | BsaI        | 5wt_tile34_sub3;5wt_tile41_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile34_sub4  | 1461        | BsaI        | 5wt_tile34_sub4;5wt_tile41_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile34_sub5  | 1354        | BsaI        | 5wt_tile34_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile35_sub4  | 1461        | BsaI        | 5wt_tile35_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile35_sub5  | 1363        | BsaI        | 5wt_tile35_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile36_sub4  | 1617        | BsaI        | 5wt_tile36_sub4;5wt_tile43_sub4;5wt_tile44_sub4                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile36_sub5  | 1438        | BsaI        | 5wt_tile36_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile37_sub4  | 1434        | BsaI        | 5wt_tile37_sub4;5wt_tile45_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile37_sub5  | 1648        | BsaI        | 5wt_tile37_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile38_sub3  | 1431        | BsaI        | 5wt_tile38_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile38_sub4  | 1578        | BsaI        | 5wt_tile38_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile38_sub5  | 1639        | BsaI        | 5wt_tile38_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile39_sub5  | 1539        | BsaI        | 5wt_tile39_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile39_sub6  | 1231        | BsaI        | 5wt_tile39_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile4        | 651         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile40_sub4  | 1629        | BsaI        | 5wt_tile40_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile40_sub5  | 1245        | BsaI        | 5wt_tile40_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile40_sub6  | 1402        | BsaI        | 5wt_tile40_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile41_sub5  | 1254        | BsaI        | 5wt_tile41_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile41_sub6  | 1489        | BsaI        | 5wt_tile41_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile42_sub3  | 1278        | BsaI        | 5wt_tile42_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile42_sub4  | 1689        | BsaI        | 5wt_tile42_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile42_sub5  | 1338        | BsaI        | 5wt_tile42_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile42_sub6  | 1417        | BsaI        | 5wt_tile42_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile43_sub5  | 1368        | BsaI        | 5wt_tile43_sub5;5wt_tile44_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile43_sub6  | 1411        | BsaI        | 5wt_tile43_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile44_sub6  | 1633        | BsaI        | 5wt_tile44_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile45_sub5  | 1746        | BsaI        | 5wt_tile45_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile45_sub6  | 1456        | BsaI        | 5wt_tile45_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile5        | 873         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile6        | 1107        | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile7        | 1335        | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile8        | 1494        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile9        | 1728        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile1_sub1  | 1233        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile1_sub2  | 1077        | BsmBI       | 3wt_tile1_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile1_sub3  | 1143        | BsmBI       | 3wt_tile1_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile1_sub4  | 1275        | BsmBI       | 3wt_tile1_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile1_sub5  | 888         | BsmBI       | 3wt_tile1_sub5;3wt_tile14_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile1_sub6  | 1398        | BsmBI       | 3wt_tile1_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile1_sub7  | 954         | BsmBI       | 3wt_tile1_sub7;3wt_tile2_sub7;3wt_tile3_sub7                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile1_sub8  | 2336        | BsmBI       | 3wt_polIII_tile1_sub8;3wt_polIII_tile2_sub8;3wt_polIII_tile3_sub8;3wt_polIII_tile8_sub7                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile10_sub1 | 912         | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile10_sub4 | 1269        | BsmBI       | 3wt_tile10_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile10_sub6 | 1095        | BsmBI       | 3wt_tile10_sub6;3wt_tile16_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile11_sub1 | 942         | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile12_sub1 | 1047        | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile12_sub2 | 999         | BsmBI       | 3wt_tile12_sub2;3wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile12_sub3 | 981         | BsmBI       | 3wt_tile12_sub3;3wt_tile13_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile12_sub4 | 918         | BsmBI       | 3wt_tile12_sub4;3wt_tile13_sub4;3wt_tile18_sub3                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile12_sub5 | 867         | BsmBI       | 3wt_tile12_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile12_sub6 | 1035        | BsmBI       | 3wt_tile12_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile13_sub1 | 828         | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile13_sub5 | 1116        | BsmBI       | 3wt_tile13_sub5;3wt_tile18_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile13_sub6 | 786         | BsmBI       | 3wt_tile13_sub6;3wt_tile14_sub6;3wt_tile18_sub5                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile14_sub1 | 1053        | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile14_sub2 | 819         | BsmBI       | 3wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile14_sub4 | 1005        | BsmBI       | 3wt_tile14_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile14_sub5 | 846         | BsmBI       | 3wt_tile14_sub5;3wt_tile29_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile15_sub1 | 822         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile15_sub3 | 648         | BsmBI       | 3wt_tile15_sub3;3wt_tile19_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile15_sub4 | 1032        | BsmBI       | 3wt_tile15_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile15_sub5 | 972         | BsmBI       | 3wt_tile15_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile15_sub6 | 729         | BsmBI       | 3wt_tile15_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile16_sub1 | 861         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile16_sub2 | 1245        | BsmBI       | 3wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile16_sub3 | 861         | BsmBI       | 3wt_tile16_sub3;3wt_tile17_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile16_sub4 | 897         | BsmBI       | 3wt_tile16_sub4;3wt_tile27_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile17_sub1 | 834         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile17_sub2 | 1062        | BsmBI       | 3wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile17_sub4 | 1206        | BsmBI       | 3wt_tile17_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile17_sub5 | 816         | BsmBI       | 3wt_tile17_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile17_sub6 | 2039        | BsmBI       | 3wt_polIII_tile17_sub6;3wt_polIII_tile20_sub6;3wt_polIII_tile21_sub6;3wt_polIII_tile24_sub5                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile18_sub1 | 777         | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile18_sub2 | 927         | BsmBI       | 3wt_tile18_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile19_sub1 | 1020        | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile19_sub3 | 1092        | BsmBI       | 3wt_tile19_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile19_sub4 | 876         | BsmBI       | 3wt_tile19_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile19_sub5 | 669         | BsmBI       | 3wt_tile19_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile2_sub1  | 1050        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile2_sub2  | 1239        | BsmBI       | 3wt_tile2_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile2_sub3  | 1116        | BsmBI       | 3wt_tile2_sub3;3wt_tile8_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile2_sub4  | 1140        | BsmBI       | 3wt_tile2_sub4;3wt_tile8_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile2_sub5  | 1023        | BsmBI       | 3wt_tile2_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile2_sub6  | 1263        | BsmBI       | 3wt_tile2_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile20_sub1 | 873         | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile20_sub2 | 849         | BsmBI       | 3wt_tile20_sub2;3wt_tile21_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile20_sub3 | 726         | BsmBI       | 3wt_tile20_sub3;3wt_tile24_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile20_sub4 | 999         | BsmBI       | 3wt_tile20_sub4;3wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile20_sub5 | 663         | BsmBI       | 3wt_tile20_sub5;3wt_tile24_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile21_sub1 | 666         | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile21_sub3 | 798         | BsmBI       | 3wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile21_sub4 | 1026        | BsmBI       | 3wt_tile21_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile21_sub5 | 564         | BsmBI       | 3wt_tile21_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile22_sub1 | 777         | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile22_sub2 | 702         | BsmBI       | 3wt_tile22_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile22_sub3 | 930         | BsmBI       | 3wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile22_sub4 | 807         | BsmBI       | 3wt_tile22_sub4;3wt_tile30_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile22_sub5 | 531         | BsmBI       | 3wt_tile22_sub5;3wt_tile26_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile22_sub6 | 1970        | BsmBI       | 3wt_polIII_tile22_sub6;3wt_polIII_tile26_sub5                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile23_sub1 | 603         | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile23_sub2 | 744         | BsmBI       | 3wt_tile23_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile23_sub3 | 981         | BsmBI       | 3wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile23_sub4 | 681         | BsmBI       | 3wt_tile23_sub4;3wt_tile27_sub3;3wt_tile28_sub3                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile23_sub5 | 528         | BsmBI       | 3wt_tile23_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile24_sub1 | 846         | BsmBI       | 3wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile25_sub1 | 717         | BsmBI       | 3wt_tile25_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile25_sub2 | 723         | BsmBI       | 3wt_tile25_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile25_sub3 | 1005        | BsmBI       | 3wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile25_sub4 | 807         | BsmBI       | 3wt_tile25_sub4;3wt_tile33_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile25_sub5 | 1796        | BsmBI       | 3wt_polIII_tile25_sub5;3wt_polIII_tile30_sub4;3wt_polIII_tile31_sub5;3wt_polIII_tile33_sub3;3wt_polIII_tile34_sub3;3wt_polIII_tile35_sub3;3wt_polIII_tile36_sub3;3wt_polIII_tile37_sub2;3wt_polIII_tile38_sub2                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile26_sub1 | 699         | BsmBI       | 3wt_tile26_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile26_sub2 | 936         | BsmBI       | 3wt_tile26_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile26_sub3 | 726         | BsmBI       | 3wt_tile26_sub3;3wt_tile32_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile27_sub1 | 558         | BsmBI       | 3wt_tile27_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile27_sub4 | 570         | BsmBI       | 3wt_tile27_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile27_sub5 | 1931        | BsmBI       | 3wt_polIII_tile27_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile28_sub1 | 705         | BsmBI       | 3wt_tile28_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile28_sub2 | 537         | BsmBI       | 3wt_tile28_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile28_sub4 | 798         | BsmBI       | 3wt_tile28_sub4;3wt_tile32_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile28_sub5 | 1703        | BsmBI       | 3wt_polIII_tile28_sub5;3wt_polIII_tile32_sub4                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile29_sub1 | 585         | BsmBI       | 3wt_tile29_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile29_sub3 | 372         | BsmBI       | 3wt_tile29_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile29_sub4 | 894         | BsmBI       | 3wt_tile29_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile29_sub5 | 1607        | BsmBI       | 3wt_polIII_tile29_sub5;3wt_polIII_tile39_sub2;3wt_polIII_tile40_sub2;3wt_polIII_tile41_sub2                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile3_sub1  | 1161        | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile3_sub2  | 906         | BsmBI       | 3wt_tile3_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile3_sub3  | 1365        | BsmBI       | 3wt_tile3_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile3_sub4  | 891         | BsmBI       | 3wt_tile3_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile3_sub5  | 1134        | BsmBI       | 3wt_tile3_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile3_sub6  | 1152        | BsmBI       | 3wt_tile3_sub6;3wt_tile4_sub6;3wt_tile9_sub5                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile30_sub1 | 864         | BsmBI       | 3wt_tile30_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile30_sub3 | 705         | BsmBI       | 3wt_tile30_sub3;3wt_tile34_sub2;3wt_tile35_sub2                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile31_sub1 | 675         | BsmBI       | 3wt_tile31_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile31_sub2 | 606         | BsmBI       | 3wt_tile31_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile31_sub3 | 435         | BsmBI       | 3wt_tile31_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile31_sub4 | 489         | BsmBI       | 3wt_tile31_sub4;3wt_tile36_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile32_sub1 | 573         | BsmBI       | 3wt_tile32_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile33_sub1 | 975         | BsmBI       | 3wt_tile33_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile34_sub1 | 846         | BsmBI       | 3wt_tile34_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile35_sub1 | 615         | BsmBI       | 3wt_tile35_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile36_sub1 | 621         | BsmBI       | 3wt_tile36_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile37_sub1 | 882         | BsmBI       | 3wt_tile37_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile38_sub1 | 660         | BsmBI       | 3wt_tile38_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile39_sub1 | 678         | BsmBI       | 3wt_tile39_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile4_sub1  | 939         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile4_sub2  | 1158        | BsmBI       | 3wt_tile4_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile4_sub3  | 1185        | BsmBI       | 3wt_tile4_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile4_sub4  | 894         | BsmBI       | 3wt_tile4_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile4_sub5  | 1059        | BsmBI       | 3wt_tile4_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile4_sub7  | 1221        | BsmBI       | 3wt_tile4_sub7;3wt_tile9_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile4_sub8  | 2069        | BsmBI       | 3wt_polIII_tile4_sub8;3wt_polIII_tile9_sub7;3wt_polIII_tile10_sub7;3wt_polIII_tile12_sub7;3wt_polIII_tile13_sub7;3wt_polIII_tile14_sub7;3wt_polIII_tile16_sub6;3wt_polIII_tile18_sub6;3wt_polIII_tile19_sub6                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile40_sub1 | 582         | BsmBI       | 3wt_tile40_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile41_sub1 | 348         | BsmBI       | 3wt_tile41_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile42      | 1757        | BsmBI       | 3wt_polIII_tile42                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile43      | 1535        | BsmBI       | 3wt_polIII_tile43                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile44      | 1334        | BsmBI       | 3wt_polIII_tile44                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile5_sub1  | 972         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile5_sub2  | 1029        | BsmBI       | 3wt_tile5_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile5_sub3  | 1047        | BsmBI       | 3wt_tile5_sub3;3wt_tile9_sub2;3wt_tile10_sub2                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile5_sub4  | 1059        | BsmBI       | 3wt_tile5_sub4;3wt_tile9_sub3;3wt_tile10_sub3;3wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile5_sub5  | 1017        | BsmBI       | 3wt_tile5_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile5_sub6  | 1029        | BsmBI       | 3wt_tile5_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile5_sub7  | 1005        | BsmBI       | 3wt_tile5_sub7                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile5_sub8  | 2285        | BsmBI       | 3wt_polIII_tile5_sub8                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile6_sub1  | 1158        | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile6_sub2  | 870         | BsmBI       | 3wt_tile6_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile6_sub3  | 1020        | BsmBI       | 3wt_tile6_sub3;3wt_tile11_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile6_sub4  | 945         | BsmBI       | 3wt_tile6_sub4;3wt_tile7_sub4;3wt_tile11_sub3                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile6_sub5  | 1155        | BsmBI       | 3wt_tile6_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile6_sub6  | 903         | BsmBI       | 3wt_tile6_sub6;3wt_tile10_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile6_sub7  | 1191        | BsmBI       | 3wt_tile6_sub7;3wt_tile7_sub7;3wt_tile11_sub6                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile6_sub8  | 1973        | BsmBI       | 3wt_polIII_tile6_sub8;3wt_polIII_tile7_sub8;3wt_polIII_tile11_sub7;3wt_polIII_tile15_sub7;3wt_polIII_tile23_sub6                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile7_sub1  | 1044        | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile7_sub2  | 1032        | BsmBI       | 3wt_tile7_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile7_sub3  | 813         | BsmBI       | 3wt_tile7_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile7_sub5  | 1002        | BsmBI       | 3wt_tile7_sub5;3wt_tile11_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile7_sub6  | 1056        | BsmBI       | 3wt_tile7_sub6;3wt_tile11_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile8_sub1  | 972         | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile8_sub4  | 1062        | BsmBI       | 3wt_tile8_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile8_sub5  | 1350        | BsmBI       | 3wt_tile8_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile8_sub6  | 828         | BsmBI       | 3wt_tile8_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile9_sub1  | 1146        | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile9_sub4  | 894         | BsmBI       | 3wt_tile9_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_polIII_tile45   | 1112        | BsmBI       | polIII_tile45                                                                                                                                                                                                                                                                                                                                                                                                                                                   |

## 10. Domestication Log

20 endogenous enzyme site(s) were removed via silent mutations:

| site_start | enzyme | strand | codon_pos | original_codon | new_codon | aa  |
| ---------- | ------ | ------ | --------- | -------------- | --------- | --- |
| 549        | BsaI   | +      | 184       | GTC            | GTG       | V   |
| 3926       | BsaI   | -      | 1309      | AGA            | AGG       | R   |
| 4649       | BsaI   | -      | 1550      | GGA            | GGC       | G   |
| 6739       | BsaI   | -      | 2247      | GAG            | GAA       | E   |
| 7056       | BsaI   | +      | 2352      | CTG            | CTT       | L   |
| 8098       | BsaI   | -      | 2700      | GAG            | GAA       | E   |
| 8578       | BsaI   | -      | 2860      | GAG            | GAA       | E   |
| 8995       | BsaI   | -      | 2999      | GAG            | GAA       | E   |
| 2272       | BsmBI  | -      | 758       | GAG            | GAA       | E   |
| 2978       | BsmBI  | +      | 993       | GCG            | GCC       | A   |
| 3154       | BsmBI  | -      | 1052      | GAG            | GAA       | E   |
| 3393       | BsmBI  | -      | 1131      | AAG            | AAA       | K   |
| 4886       | BsmBI  | -      | 1629      | GGA            | GGC       | G   |
| 4931       | BsmBI  | +      | 1644      | ACG            | ACC       | T   |
| 5214       | BsmBI  | +      | 1738      | TCC            | TCT       | S   |
| 5482       | BsmBI  | -      | 1828      | GAG            | GAA       | E   |
| 1728       | PaqCI  | -      | 576       | CAG            | CAA       | Q   |
| 2163       | PaqCI  | -      | 721       | CTG            | CTC       | L   |
| 2731       | PaqCI  | +      | 911       | CAC            | CAT       | H   |
| 2895       | PaqCI  | -      | 965       | CTG            | CTC       | L   |

## 11. Configuration Parameters

| Parameter             | Value          |
| --------------------- | -------------- |
| max_oligo_length      | 300            |
| max_geneblock_length  | 1800           |
| barcode_length        | 20             |
| min_hamming_distance  | 3              |
| barcode_prefix_length | 12             |
| barcodes_per_variant  | 1              |
| boundary_method       | oogga_two_pass |
| multi_k_search        | TRUE           |
| auto_domesticate      | TRUE           |

