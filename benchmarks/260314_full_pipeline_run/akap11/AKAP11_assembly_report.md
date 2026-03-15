# DMS-GG Assembly Report: AKAP11

Generated: 2026-03-14 11:33:03
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                          |
| -------------------- | ------------------------------------------------------------------------------ |
| Gene name            | AKAP11_NM_016248.4_CDS Homo sapiens A-kinase anchoring protein 11 (AKAP11) CDS |
| CDS length           | 5706 nt (1902 codons)                                                          |
| Protein length       | 1901 aa                                                                        |
| Number of tiles      | 40                                                                             |
| Total variants       | 39627                                                                          |
| Total oligos         | 396270                                                                         |
| Oligo length range   | 143-290 nt                                                                     |
| Gene blocks to order | 83                                                                             |
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

**Total oligos:** 396270 | **Length range:** 143-290 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-78      | 15540  | 290 nt |
| 2    | 73-121    | 9030   | 203 nt |
| 3    | 116-153   | 6720   | 170 nt |
| 4    | 148-195   | 8820   | 200 nt |
| 5    | 190-263   | 14280  | 278 nt |
| 6    | 258-323   | 12600  | 254 nt |
| 7    | 318-366   | 9030   | 203 nt |
| 8    | 361-399   | 7140   | 173 nt |
| 9    | 400-447   | 9240   | 200 nt |
| 10   | 442-480   | 6930   | 173 nt |
| 11   | 475-527   | 9870   | 215 nt |
| 12   | 522-574   | 9870   | 215 nt |
| 13   | 569-635   | 12810  | 257 nt |
| 14   | 630-699   | 13440  | 266 nt |
| 15   | 694-745   | 9660   | 212 nt |
| 16   | 740-779   | 7140   | 176 nt |
| 17   | 774-843   | 13440  | 266 nt |
| 18   | 838-887   | 9450   | 206 nt |
| 19   | 888-935   | 9240   | 200 nt |
| 20   | 930-974   | 8190   | 191 nt |
| 21   | 969-1041  | 14070  | 275 nt |
| 22   | 1036-1068 | 5670   | 155 nt |
| 23   | 1063-1104 | 7560   | 182 nt |
| 24   | 1099-1160 | 11760  | 242 nt |
| 25   | 1155-1217 | 11970  | 245 nt |
| 26   | 1212-1258 | 8610   | 197 nt |
| 27   | 1253-1301 | 9030   | 203 nt |
| 28   | 1296-1340 | 8190   | 191 nt |
| 29   | 1335-1402 | 13020  | 260 nt |
| 30   | 1397-1440 | 8190   | 188 nt |
| 31   | 1441-1491 | 9870   | 209 nt |
| 32   | 1486-1533 | 8820   | 200 nt |
| 33   | 1528-1585 | 10920  | 230 nt |
| 34   | 1580-1655 | 14700  | 284 nt |
| 35   | 1650-1699 | 9240   | 206 nt |
| 36   | 1694-1722 | 5040   | 143 nt |
| 37   | 1723-1773 | 9870   | 209 nt |
| 38   | 1768-1815 | 8820   | 200 nt |
| 39   | 1810-1866 | 10710  | 227 nt |
| 40   | 1861-1902 | 7770   | 182 nt |

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
| Total barcodes    | 396270                             |
| Unique barcodes   | 396270                             |
| GC content range  | 25% - 75%                          |
| GC content mean   | 48.4%                              |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                  | Description                                                   | Result | Detail                                                                                                                                               |
| ---------------------- | ------------------------------------------------------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths          | All oligos within synthesis length limit                      | PASS   | Range: 143-290 nt (limit: 300)                                                                                                                       |
| block_lengths          | All gene blocks within synthesis length limit                 | PASS   | Range: 153-1728 nt (limit: 1800)                                                                                                                     |
| barcode_junction_sites | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                              |
| barcode_uniqueness     | All barcodes are unique                                       | PASS   | 396270 unique / 396270 total                                                                                                                         |
| tile_coverage          | Tiles cover entire gene without gaps                          | PASS   | 5706 / 5706 nt covered                                                                                                                               |
| variant_count          | Expected number of variants generated                         | PASS   | 39627 unique variants (expected: 39627 across 1887/1900 mutable positions; 35853 missense + 1887 nonsense + 1887 wt_control; 13 position(s) skipped) |
| single_codon_change    | Each non-control variant differs by exactly one codon from WT | PASS   | 377400 / 377400 variants confirmed (WT controls excluded)                                                                                            |
| oligo_gc_content       | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 30.7-57.8% | 0 oligo(s) with extreme GC                                                                                                    |
| domestication_complete | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                              |
| overhang_fidelity      | Tile boundary overhangs have adequate fidelity                | FAIL   | 37 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                              |
| tile_manifests         | Per-tile assembly manifests complete                          | PASS   | 40 tile manifest(s) generated                                                                                                                        |
| helper_plasmid         | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                   |
| reaction_fidelity      | Per-reaction set-level overhang fidelity                      | PASS   | Min set fidelity: 0.8328 across 80 reactions | 1 reaction(s) below 0.90                                                                              |
| barcode_poliii_term    | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 396270 barcode(s) contain TTTT                                                                                                                   |
| block_min_length       | All gene blocks above synthesis minimum length                | FAIL   | 5 block(s) below 300 nt minimum. Range: 153-1728 nt                                                                                                  |
| sb_overhang_collisions | Superblock boundary overhangs are unique (no collisions)      | PASS   | 8 SB boundary OH(s), all unique                                                                                                                      |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 5         | 1.0000             |
| 2    | 3        | 1.0000            | 6         | 0.9984             |
| 3    | 3        | 1.0000            | 6         | 1.0000             |
| 4    | 3        | 1.0000            | 6         | 1.0000             |
| 5    | 3        | 1.0000            | 6         | 0.8328             |
| 6    | 3        | 1.0000            | 5         | 1.0000             |
| 7    | 3        | 1.0000            | 5         | 1.0000             |
| 8    | 3        | 1.0000            | 5         | 1.0000             |
| 9    | 3        | 1.0000            | 5         | 0.9927             |
| 10   | 3        | 1.0000            | 5         | 1.0000             |
| 11   | 3        | 1.0000            | 5         | 1.0000             |
| 12   | 4        | 1.0000            | 5         | 1.0000             |
| 13   | 4        | 1.0000            | 5         | 1.0000             |
| 14   | 4        | 1.0000            | 5         | 1.0000             |
| 15   | 4        | 1.0000            | 5         | 0.9154             |
| 16   | 4        | 1.0000            | 5         | 0.9966             |
| 17   | 4        | 1.0000            | 5         | 1.0000             |
| 18   | 4        | 1.0000            | 4         | 1.0000             |
| 19   | 4        | 1.0000            | 4         | 1.0000             |
| 20   | 4        | 1.0000            | 4         | 1.0000             |
| 21   | 4        | 1.0000            | 4         | 1.0000             |
| 22   | 5        | 1.0000            | 4         | 1.0000             |
| 23   | 5        | 1.0000            | 4         | 1.0000             |
| 24   | 5        | 1.0000            | 4         | 1.0000             |
| 25   | 5        | 1.0000            | 4         | 0.9154             |
| 26   | 5        | 1.0000            | 4         | 0.9983             |
| 27   | 5        | 1.0000            | 4         | 1.0000             |
| 28   | 5        | 1.0000            | 4         | 0.9919             |
| 29   | 5        | 1.0000            | 3         | 1.0000             |
| 30   | 5        | 1.0000            | 3         | 1.0000             |
| 31   | 5        | 1.0000            | 3         | 1.0000             |
| 32   | 6        | 0.9979            | 3         | 1.0000             |
| 33   | 6        | 1.0000            | 3         | 1.0000             |
| 34   | 6        | 1.0000            | 3         | 1.0000             |
| 35   | 6        | 1.0000            | 2         | 1.0000             |
| 36   | 6        | 1.0000            | 2         | 1.0000             |
| 37   | 6        | 1.0000            | 2         | 1.0000             |
| 38   | 6        | 1.0000            | 2         | 0.9298             |
| 39   | 6        | 1.0000            | 2         | 1.0000             |
| 40   | 7        | 0.9981            | 2         | 1.0000             |

**Min:** 0.8328 | **Max:** 1.0000 | **Mean:** 0.9946

**Warning:** 1 reaction(s) below 0.90 fidelity — consider alternative split points or overhang reassignment.
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

### Tile 1 of 40 -- Codons 1-78 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGG     | 0.5393   |
| oh2 (3' boundary) | TATT     | 0.8134   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (15540 oligos)              | 290 nt | ATGG  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1     | 999 nt  | TATT  | TCGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1482 nt | TCGT  | ATCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1677 nt | ATCA  | TCCA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 864 nt  | TCCA  | TATT  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TATT]----3'WT sub1----[TCGT]----3'WT sub2----[ATCA]----3'WT sub3----[TCCA]----3'WT sub4----[TATT]----3'WT+PolIII sub5----[CACC]
   TATT                   TCGT                   ATCA                   TCCA                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 2 of 40 -- Codons 73-121 (147 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GATT     | 0.6417   |
| oh2 (3' boundary) | CATG     | 0.6046   |

**Variants:** 9030 mutations, 9030 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 234 nt | ATGG  | GATT  |
| 2   | Oligo pool      | Tile 2 (9030 oligos)  | 203 nt | GATT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[GATT]----oligo+BC----[AGAA]
   ATGG                    GATT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1     | 870 nt  | CATG  | TCGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1482 nt | TCGT  | ATCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1677 nt | ATCA  | TCCA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 864 nt  | TCCA  | TATT  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CATG]----3'WT sub1----[TCGT]----3'WT sub2----[ATCA]----3'WT sub3----[TCCA]----3'WT sub4----[TATT]----3'WT+PolIII sub5----[CACC]
   CATG                   TCGT                   ATCA                   TCCA                   TATT                          CACC 
```

**Set fidelity:** 0.9984 (6 overhangs)

---

### Tile 3 of 40 -- Codons 116-153 (114 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATC     | 0.7116   |
| oh2 (3' boundary) | ATTC     | 0.7084   |

**Variants:** 6720 mutations, 6720 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 363 nt | ATGG  | AATC  |
| 2   | Oligo pool      | Tile 3 (6720 oligos)  | 170 nt | AATC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[AATC]----oligo+BC----[AGAA]
   ATGG                    AATC                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1     | 774 nt  | ATTC  | TCGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1482 nt | TCGT  | ATCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1677 nt | ATCA  | TCCA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 864 nt  | TCCA  | TATT  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATTC]----3'WT sub1----[TCGT]----3'WT sub2----[ATCA]----3'WT sub3----[TCCA]----3'WT sub4----[TATT]----3'WT+PolIII sub5----[CACC]
   ATTC                   TCGT                   ATCA                   TCCA                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 4 of 40 -- Codons 148-195 (144 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TATG     | 0.7006   |
| oh2 (3' boundary) | AAAG     | 0.7511   |

**Variants:** 8820 mutations, 8820 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 459 nt | ATGG  | TATG  |
| 2   | Oligo pool      | Tile 4 (8820 oligos)  | 200 nt | TATG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[TATG]----oligo+BC----[AGAA]
   ATGG                    TATG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1     | 648 nt  | AAAG  | TCGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1482 nt | TCGT  | ATCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1677 nt | ATCA  | TCCA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 864 nt  | TCCA  | TATT  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAG]----3'WT sub1----[TCGT]----3'WT sub2----[ATCA]----3'WT sub3----[TCCA]----3'WT sub4----[TATT]----3'WT+PolIII sub5----[CACC]
   AAAG                   TCGT                   ATCA                   TCCA                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 5 of 40 -- Codons 190-263 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCTT     | 0.5632   |
| oh2 (3' boundary) | CACA     | 0.6141   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 585 nt | ATGG  | GCTT  |
| 2   | Oligo pool      | Tile 5 (14280 oligos) | 278 nt | GCTT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[GCTT]----oligo+BC----[AGAA]
   ATGG                    GCTT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1     | 444 nt  | CACA  | TCGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1482 nt | TCGT  | ATCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1677 nt | ATCA  | TCCA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 864 nt  | TCCA  | TATT  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CACA]----3'WT sub1----[TCGT]----3'WT sub2----[ATCA]----3'WT sub3----[TCCA]----3'WT sub4----[TATT]----3'WT+PolIII sub5----[CACC]
   CACA                   TCGT                   ATCA                   TCCA                   TATT                          CACC 
```

**Set fidelity:** 0.8328 (6 overhangs)

---

### Tile 6 of 40 -- Codons 258-323 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CATA     | 0.7540   |
| oh2 (3' boundary) | CTTA     | 0.7183   |

**Variants:** 12600 mutations, 12600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 789 nt | ATGG  | CATA  |
| 2   | Oligo pool      | Tile 6 (12600 oligos) | 254 nt | CATA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[CATA]----oligo+BC----[AGAA]
   ATGG                    CATA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1     | 1728 nt | CTTA  | ATCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1677 nt | ATCA  | TCCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 864 nt  | TCCA  | TATT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTTA]----3'WT sub1----[ATCA]----3'WT sub2----[TCCA]----3'WT sub3----[TATT]----3'WT+PolIII sub4----[CACC]
   CTTA                   ATCA                   TCCA                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 7 of 40 -- Codons 318-366 (147 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTT     | 0.7664   |
| oh2 (3' boundary) | TTGC     | 0.7336   |

**Variants:** 9030 mutations, 9030 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 969 nt | ATGG  | ATTT  |
| 2   | Oligo pool      | Tile 7 (9030 oligos)  | 203 nt | ATTT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[ATTT]----oligo+BC----[AGAA]
   ATGG                    ATTT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1     | 1599 nt | TTGC  | ATCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1677 nt | ATCA  | TCCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 864 nt  | TCCA  | TATT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTGC]----3'WT sub1----[ATCA]----3'WT sub2----[TCCA]----3'WT sub3----[TATT]----3'WT+PolIII sub4----[CACC]
   TTGC                   ATCA                   TCCA                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 8 of 40 -- Codons 361-399 (117 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGT     | 0.6512   |
| oh2 (3' boundary) | TCGT     | 0.7335   |

**Variants:** 7140 mutations, 7140 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1098 nt | ATGG  | CAGT  |
| 2   | Oligo pool      | Tile 8 (7140 oligos)  | 173 nt  | CAGT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[CAGT]----oligo+BC----[AGAA]
   ATGG                    CAGT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1     | 1500 nt | TCGT  | ATCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1677 nt | ATCA  | TCCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 864 nt  | TCCA  | TATT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCGT]----3'WT sub1----[ATCA]----3'WT sub2----[TCCA]----3'WT sub3----[TATT]----3'WT+PolIII sub4----[CACC]
   TCGT                   ATCA                   TCCA                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 9 of 40 -- Codons 400-447 (144 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAT     | 0.7737   |
| oh2 (3' boundary) | CTCT     | 0.6347   |

**Variants:** 9240 mutations, 9240 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1215 nt | ATGG  | AAAT  |
| 2   | Oligo pool      | Tile 9 (9240 oligos)  | 200 nt  | AAAT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[AAAT]----oligo+BC----[AGAA]
   ATGG                    AAAT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1     | 1356 nt | CTCT  | ATCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1677 nt | ATCA  | TCCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 864 nt  | TCCA  | TATT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTCT]----3'WT sub1----[ATCA]----3'WT sub2----[TCCA]----3'WT sub3----[TATT]----3'WT+PolIII sub4----[CACC]
   CTCT                   ATCA                   TCCA                   TATT                          CACC 
```

**Set fidelity:** 0.9927 (5 overhangs)

---

### Tile 10 of 40 -- Codons 442-480 (117 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAG     | 0.6752   |
| oh2 (3' boundary) | TTAC     | 0.8333   |

**Variants:** 6930 mutations, 6930 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1341 nt | ATGG  | GAAG  |
| 2   | Oligo pool      | Tile 10 (6930 oligos) | 173 nt  | GAAG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[GAAG]----oligo+BC----[AGAA]
   ATGG                    GAAG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1    | 1257 nt | TTAC  | ATCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1677 nt | ATCA  | TCCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 864 nt  | TCCA  | TATT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTAC]----3'WT sub1----[ATCA]----3'WT sub2----[TCCA]----3'WT sub3----[TATT]----3'WT+PolIII sub4----[CACC]
   TTAC                   ATCA                   TCCA                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 11 of 40 -- Codons 475-527 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GATA     | 0.7029   |
| oh2 (3' boundary) | CCTT     | 0.6891   |

**Variants:** 9870 mutations, 9870 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1440 nt | ATGG  | GATA  |
| 2   | Oligo pool      | Tile 11 (9870 oligos) | 215 nt  | GATA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[GATA]----oligo+BC----[AGAA]
   ATGG                    GATA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1    | 1116 nt | CCTT  | ATCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1677 nt | ATCA  | TCCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 864 nt  | TCCA  | TATT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTT]----3'WT sub1----[ATCA]----3'WT sub2----[TCCA]----3'WT sub3----[TATT]----3'WT+PolIII sub4----[CACC]
   CCTT                   ATCA                   TCCA                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 12 of 40 -- Codons 522-574 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | TTTG     | 0.7063   |

**Variants:** 9870 mutations, 9870 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1215 nt | ATGG  | AAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2  | 384 nt  | AAAT  | GAAA  |
| 3   | Oligo pool      | Tile 12 (9870 oligos) | 215 nt  | GAAA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAT]----5'WT sub2----[GAAA]----oligo+BC----[AGAA]
   ATGG                   AAAT                   GAAA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1    | 975 nt  | TTTG  | ATCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1677 nt | ATCA  | TCCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 864 nt  | TCCA  | TATT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTTG]----3'WT sub1----[ATCA]----3'WT sub2----[TCCA]----3'WT sub3----[TATT]----3'WT+PolIII sub4----[CACC]
   TTTG                   ATCA                   TCCA                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 13 of 40 -- Codons 569-635 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAC     | 0.8333   |
| oh2 (3' boundary) | AAAC     | 0.6694   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9         | 1215 nt | ATGG  | AAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 525 nt  | AAAT  | TTAC  |
| 3   | Oligo pool      | Tile 13 (12810 oligos) | 257 nt  | TTAC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAT]----5'WT sub2----[TTAC]----oligo+BC----[AGAA]
   ATGG                   AAAT                   TTAC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1    | 792 nt  | AAAC  | ATCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1677 nt | ATCA  | TCCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 864 nt  | TCCA  | TATT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAC]----3'WT sub1----[ATCA]----3'WT sub2----[TCCA]----3'WT sub3----[TATT]----3'WT+PolIII sub4----[CACC]
   AAAC                   ATCA                   TCCA                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 14 of 40 -- Codons 630-699 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GATT     | 0.6417   |
| oh2 (3' boundary) | GCTA     | 0.5810   |

**Variants:** 13440 mutations, 13440 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9         | 1215 nt | ATGG  | AAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 708 nt  | AAAT  | GATT  |
| 3   | Oligo pool      | Tile 14 (13440 oligos) | 266 nt  | GATT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAT]----5'WT sub2----[GATT]----oligo+BC----[AGAA]
   ATGG                   AAAT                   GATT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1    | 600 nt  | GCTA  | ATCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1677 nt | ATCA  | TCCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 864 nt  | TCCA  | TATT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCTA]----3'WT sub1----[ATCA]----3'WT sub2----[TCCA]----3'WT sub3----[TATT]----3'WT+PolIII sub4----[CACC]
   GCTA                   ATCA                   TCCA                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 15 of 40 -- Codons 694-745 (156 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTG     | 0.6684   |
| oh2 (3' boundary) | AATT     | 0.8007   |

**Variants:** 9660 mutations, 9660 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1215 nt | ATGG  | AAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2  | 900 nt  | AAAT  | TCTG  |
| 3   | Oligo pool      | Tile 15 (9660 oligos) | 212 nt  | TCTG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAT]----5'WT sub2----[TCTG]----oligo+BC----[AGAA]
   ATGG                   AAAT                   TCTG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1    | 462 nt  | AATT  | ATCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1677 nt | ATCA  | TCCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 864 nt  | TCCA  | TATT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AATT]----3'WT sub1----[ATCA]----3'WT sub2----[TCCA]----3'WT sub3----[TATT]----3'WT+PolIII sub4----[CACC]
   AATT                   ATCA                   TCCA                   TATT                          CACC 
```

**Set fidelity:** 0.9154 (5 overhangs)

---

### Tile 16 of 40 -- Codons 740-779 (120 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTCA     | 0.5915   |
| oh2 (3' boundary) | GGCA     | 0.5273   |

**Variants:** 7140 mutations, 7140 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1215 nt | ATGG  | AAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1038 nt | AAAT  | GTCA  |
| 3   | Oligo pool      | Tile 16 (7140 oligos) | 176 nt  | GTCA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAT]----5'WT sub2----[GTCA]----oligo+BC----[AGAA]
   ATGG                   AAAT                   GTCA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1    | 360 nt  | GGCA  | ATCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1677 nt | ATCA  | TCCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 864 nt  | TCCA  | TATT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGCA]----3'WT sub1----[ATCA]----3'WT sub2----[TCCA]----3'WT sub3----[TATT]----3'WT+PolIII sub4----[CACC]
   GGCA                   ATCA                   TCCA                   TATT                          CACC 
```

**Set fidelity:** 0.9966 (5 overhangs)

---

### Tile 17 of 40 -- Codons 774-843 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTG     | 0.6684   |
| oh2 (3' boundary) | TGAT     | 0.6933   |

**Variants:** 13440 mutations, 13440 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9         | 1215 nt | ATGG  | AAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 1140 nt | AAAT  | TCTG  |
| 3   | Oligo pool      | Tile 17 (13440 oligos) | 266 nt  | TCTG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAT]----5'WT sub2----[TCTG]----oligo+BC----[AGAA]
   ATGG                   AAAT                   TCTG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1    | 168 nt  | TGAT  | ATCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1677 nt | ATCA  | TCCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 864 nt  | TCCA  | TATT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAT]----3'WT sub1----[ATCA]----3'WT sub2----[TCCA]----3'WT sub3----[TATT]----3'WT+PolIII sub4----[CACC]
   TGAT                   ATCA                   TCCA                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 18 of 40 -- Codons 838-887 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAC     | 0.8333   |
| oh2 (3' boundary) | ATCA     | 0.7483   |

**Variants:** 9450 mutations, 9450 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1215 nt | ATGG  | AAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1332 nt | AAAT  | TTAC  |
| 3   | Oligo pool      | Tile 18 (9450 oligos) | 206 nt  | TTAC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAT]----5'WT sub2----[TTAC]----oligo+BC----[AGAA]
   ATGG                   AAAT                   TTAC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1    | 1695 nt | ATCA  | TCCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 864 nt  | TCCA  | TATT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATCA]----3'WT sub1----[TCCA]----3'WT sub2----[TATT]----3'WT+PolIII sub3----[CACC]
   ATCA                   TCCA                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 19 of 40 -- Codons 888-935 (144 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAG     | 0.8480   |
| oh2 (3' boundary) | CCGG     | 0.5642   |

**Variants:** 9240 mutations, 9240 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1215 nt | ATGG  | AAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1482 nt | AAAT  | TTAG  |
| 3   | Oligo pool      | Tile 19 (9240 oligos) | 200 nt  | TTAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAT]----5'WT sub2----[TTAG]----oligo+BC----[AGAA]
   ATGG                   AAAT                   TTAG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1    | 1551 nt | CCGG  | TCCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 864 nt  | TCCA  | TATT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCGG]----3'WT sub1----[TCCA]----3'WT sub2----[TATT]----3'WT+PolIII sub3----[CACC]
   CCGG                   TCCA                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 20 of 40 -- Codons 930-974 (135 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAG     | 0.6752   |
| oh2 (3' boundary) | GTTG     | 0.4759   |

**Variants:** 8190 mutations, 8190 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1215 nt | ATGG  | AAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2  | 1608 nt | AAAT  | GAAG  |
| 3   | Oligo pool      | Tile 20 (8190 oligos) | 191 nt  | GAAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAT]----5'WT sub2----[GAAG]----oligo+BC----[AGAA]
   ATGG                   AAAT                   GAAG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1    | 1434 nt | GTTG  | TCCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 864 nt  | TCCA  | TATT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GTTG]----3'WT sub1----[TCCA]----3'WT sub2----[TATT]----3'WT+PolIII sub3----[CACC]
   GTTG                   TCCA                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 21 of 40 -- Codons 969-1041 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | AAAG     | 0.7511   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9         | 1215 nt | ATGG  | AAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1725 nt | AAAT  | GAAA  |
| 3   | Oligo pool      | Tile 21 (14070 oligos) | 275 nt  | GAAA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAT]----5'WT sub2----[GAAA]----oligo+BC----[AGAA]
   ATGG                   AAAT                   GAAA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1    | 1233 nt | AAAG  | TCCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 864 nt  | TCCA  | TATT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAG]----3'WT sub1----[TCCA]----3'WT sub2----[TATT]----3'WT+PolIII sub3----[CACC]
   AAAG                   TCCA                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 22 of 40 -- Codons 1036-1068 (99 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTGA     | 0.8853   |
| oh2 (3' boundary) | ATCT     | 0.7151   |

**Variants:** 5670 mutations, 5670 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1215 nt | ATGG  | AAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1482 nt | AAAT  | TTAG  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 462 nt  | TTAG  | TTGA  |
| 4   | Oligo pool      | Tile 22 (5670 oligos) | 155 nt  | TTGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAT]----5'WT sub2----[TTAG]----5'WT sub3----[TTGA]----oligo+BC----[AGAA]
   ATGG                   AAAT                   TTAG                   TTGA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1    | 1152 nt | ATCT  | TCCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 864 nt  | TCCA  | TATT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATCT]----3'WT sub1----[TCCA]----3'WT sub2----[TATT]----3'WT+PolIII sub3----[CACC]
   ATCT                   TCCA                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 23 of 40 -- Codons 1063-1104 (126 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | CCGG     | 0.5642   |

**Variants:** 7560 mutations, 7560 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1215 nt | ATGG  | AAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1482 nt | AAAT  | TTAG  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3  | 543 nt  | TTAG  | GAAA  |
| 4   | Oligo pool      | Tile 23 (7560 oligos) | 182 nt  | GAAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAT]----5'WT sub2----[TTAG]----5'WT sub3----[GAAA]----oligo+BC----[AGAA]
   ATGG                   AAAT                   TTAG                   GAAA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1    | 1044 nt | CCGG  | TCCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 864 nt  | TCCA  | TATT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCGG]----3'WT sub1----[TCCA]----3'WT sub2----[TATT]----3'WT+PolIII sub3----[CACC]
   CCGG                   TCCA                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 24 of 40 -- Codons 1099-1160 (186 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GATA     | 0.7029   |
| oh2 (3' boundary) | ACTC     | 0.5979   |

**Variants:** 11760 mutations, 11760 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9         | 1215 nt | ATGG  | AAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1482 nt | AAAT  | TTAG  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3   | 651 nt  | TTAG  | GATA  |
| 4   | Oligo pool      | Tile 24 (11760 oligos) | 242 nt  | GATA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAT]----5'WT sub2----[TTAG]----5'WT sub3----[GATA]----oligo+BC----[AGAA]
   ATGG                   AAAT                   TTAG                   GATA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile24_sub1    | 876 nt  | ACTC  | TCCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 864 nt  | TCCA  | TATT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACTC]----3'WT sub1----[TCCA]----3'WT sub2----[TATT]----3'WT+PolIII sub3----[CACC]
   ACTC                   TCCA                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 25 of 40 -- Codons 1155-1217 (189 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATA     | 0.8816   |
| oh2 (3' boundary) | AATT     | 0.8007   |

**Variants:** 11970 mutations, 11970 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9         | 1215 nt | ATGG  | AAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1482 nt | AAAT  | TTAG  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3   | 819 nt  | TTAG  | AATA  |
| 4   | Oligo pool      | Tile 25 (11970 oligos) | 245 nt  | AATA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAT]----5'WT sub2----[TTAG]----5'WT sub3----[AATA]----oligo+BC----[AGAA]
   ATGG                   AAAT                   TTAG                   AATA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile25_sub1    | 705 nt  | AATT  | TCCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 864 nt  | TCCA  | TATT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AATT]----3'WT sub1----[TCCA]----3'WT sub2----[TATT]----3'WT+PolIII sub3----[CACC]
   AATT                   TCCA                   TATT                          CACC 
```

**Set fidelity:** 0.9154 (4 overhangs)

---

### Tile 26 of 40 -- Codons 1212-1258 (141 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | GGCA     | 0.5273   |

**Variants:** 8610 mutations, 8610 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1215 nt | ATGG  | AAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1482 nt | AAAT  | TTAG  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3  | 990 nt  | TTAG  | GAAA  |
| 4   | Oligo pool      | Tile 26 (8610 oligos) | 197 nt  | GAAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAT]----5'WT sub2----[TTAG]----5'WT sub3----[GAAA]----oligo+BC----[AGAA]
   ATGG                   AAAT                   TTAG                   GAAA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile26_sub1    | 582 nt  | GGCA  | TCCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 864 nt  | TCCA  | TATT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGCA]----3'WT sub1----[TCCA]----3'WT sub2----[TATT]----3'WT+PolIII sub3----[CACC]
   GGCA                   TCCA                   TATT                          CACC 
```

**Set fidelity:** 0.9983 (4 overhangs)

---

### Tile 27 of 40 -- Codons 1253-1301 (147 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTGA     | 0.8853   |
| oh2 (3' boundary) | AGAG     | 0.6016   |

**Variants:** 9030 mutations, 9030 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1215 nt | ATGG  | AAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1482 nt | AAAT  | TTAG  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3  | 1113 nt | TTAG  | TTGA  |
| 4   | Oligo pool      | Tile 27 (9030 oligos) | 203 nt  | TTGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAT]----5'WT sub2----[TTAG]----5'WT sub3----[TTGA]----oligo+BC----[AGAA]
   ATGG                   AAAT                   TTAG                   TTGA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile27_sub1    | 453 nt  | AGAG  | TCCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 864 nt  | TCCA  | TATT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAG]----3'WT sub1----[TCCA]----3'WT sub2----[TATT]----3'WT+PolIII sub3----[CACC]
   AGAG                   TCCA                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 28 of 40 -- Codons 1296-1340 (135 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAG     | 0.6752   |
| oh2 (3' boundary) | TGCA     | 0.6831   |

**Variants:** 8190 mutations, 8190 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1215 nt | ATGG  | AAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1482 nt | AAAT  | TTAG  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3  | 1242 nt | TTAG  | GAAG  |
| 4   | Oligo pool      | Tile 28 (8190 oligos) | 191 nt  | GAAG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAT]----5'WT sub2----[TTAG]----5'WT sub3----[GAAG]----oligo+BC----[AGAA]
   ATGG                   AAAT                   TTAG                   GAAG                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile28_sub1    | 336 nt  | TGCA  | TCCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 864 nt  | TCCA  | TATT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGCA]----3'WT sub1----[TCCA]----3'WT sub2----[TATT]----3'WT+PolIII sub3----[CACC]
   TGCA                   TCCA                   TATT                          CACC 
```

**Set fidelity:** 0.9919 (4 overhangs)

---

### Tile 29 of 40 -- Codons 1335-1402 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TATC     | 0.8041   |
| oh2 (3' boundary) | GGAA     | 0.7463   |

**Variants:** 13020 mutations, 13020 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9         | 1215 nt | ATGG  | AAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1482 nt | AAAT  | TTAG  |
| 3   | 5'WT gene block | bsai_5wt_tile29_sub3   | 1359 nt | TTAG  | TATC  |
| 4   | Oligo pool      | Tile 29 (13020 oligos) | 260 nt  | TATC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAT]----5'WT sub2----[TTAG]----5'WT sub3----[TATC]----oligo+BC----[AGAA]
   ATGG                   AAAT                   TTAG                   TATC                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile29_sub1    | 996 nt  | GGAA  | TATT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAA]----3'WT sub1----[TATT]----3'WT+PolIII sub2----[CACC]
   GGAA                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 30 of 40 -- Codons 1397-1440 (132 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCTG     | 0.6383   |
| oh2 (3' boundary) | TCCA     | 0.8519   |

**Variants:** 8190 mutations, 8190 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1215 nt | ATGG  | AAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1482 nt | AAAT  | TTAG  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3  | 1545 nt | TTAG  | CCTG  |
| 4   | Oligo pool      | Tile 30 (8190 oligos) | 188 nt  | CCTG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAT]----5'WT sub2----[TTAG]----5'WT sub3----[CCTG]----oligo+BC----[AGAA]
   ATGG                   AAAT                   TTAG                   CCTG                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile30_sub1    | 882 nt  | TCCA  | TATT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCCA]----3'WT sub1----[TATT]----3'WT+PolIII sub2----[CACC]
   TCCA                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 31 of 40 -- Codons 1441-1491 (153 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | AGAA     | 0.8847   |

**Variants:** 9870 mutations, 9870 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1215 nt | ATGG  | AAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1482 nt | AAAT  | TTAG  |
| 3   | 5'WT gene block | bsai_5wt_tile31_sub3  | 1677 nt | TTAG  | GAAA  |
| 4   | Oligo pool      | Tile 31 (9870 oligos) | 209 nt  | GAAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAT]----5'WT sub2----[TTAG]----5'WT sub3----[GAAA]----oligo+BC----[AGAA]
   ATGG                   AAAT                   TTAG                   GAAA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile31_sub1    | 729 nt  | AGAA  | TATT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAA]----3'WT sub1----[TATT]----3'WT+PolIII sub2----[CACC]
   AGAA                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 32 of 40 -- Codons 1486-1533 (144 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GATT     | 0.6417   |
| oh2 (3' boundary) | AGCT     | 0.5117   |

**Variants:** 8820 mutations, 8820 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1215 nt | ATGG  | AAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1482 nt | AAAT  | TTAG  |
| 3   | 5'WT gene block | bsai_5wt_tile31_sub3  | 1677 nt | TTAG  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile32_sub4  | 153 nt  | GAAA  | GATT  |
| 5   | Oligo pool      | Tile 32 (8820 oligos) | 200 nt  | GATT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAT]----5'WT sub2----[TTAG]----5'WT sub3----[GAAA]----5'WT sub4----[GATT]----oligo+BC----[AGAA]
   ATGG                   AAAT                   TTAG                   GAAA                   GATT                  AGAA 
```

**Set fidelity:** 0.9979 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile32_sub1    | 603 nt  | AGCT  | TATT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGCT]----3'WT sub1----[TATT]----3'WT+PolIII sub2----[CACC]
   AGCT                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 33 of 40 -- Codons 1528-1585 (174 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATG     | 0.6412   |
| oh2 (3' boundary) | TGAC     | 0.6485   |

**Variants:** 10920 mutations, 10920 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9         | 1215 nt | ATGG  | AAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1482 nt | AAAT  | TTAG  |
| 3   | 5'WT gene block | bsai_5wt_tile31_sub3   | 1677 nt | TTAG  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile33_sub4   | 279 nt  | GAAA  | AATG  |
| 5   | Oligo pool      | Tile 33 (10920 oligos) | 230 nt  | AATG  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAT]----5'WT sub2----[TTAG]----5'WT sub3----[GAAA]----5'WT sub4----[AATG]----oligo+BC----[AGAA]
   ATGG                   AAAT                   TTAG                   GAAA                   AATG                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile33_sub1    | 447 nt  | TGAC  | TATT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAC]----3'WT sub1----[TATT]----3'WT+PolIII sub2----[CACC]
   TGAC                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 34 of 40 -- Codons 1580-1655 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAC     | 0.7626   |
| oh2 (3' boundary) | AAAA     | 0.9502   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9         | 1215 nt | ATGG  | AAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1482 nt | AAAT  | TTAG  |
| 3   | 5'WT gene block | bsai_5wt_tile31_sub3   | 1677 nt | TTAG  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile34_sub4   | 435 nt  | GAAA  | TCAC  |
| 5   | Oligo pool      | Tile 34 (14700 oligos) | 284 nt  | TCAC  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAT]----5'WT sub2----[TTAG]----5'WT sub3----[GAAA]----5'WT sub4----[TCAC]----oligo+BC----[AGAA]
   ATGG                   AAAT                   TTAG                   GAAA                   TCAC                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile34_sub1    | 237 nt  | AAAA  | TATT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1634 nt | TATT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAA]----3'WT sub1----[TATT]----3'WT+PolIII sub2----[CACC]
   AAAA                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 35 of 40 -- Codons 1650-1699 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTTG     | 0.7594   |
| oh2 (3' boundary) | TAGC     | 0.7011   |

**Variants:** 9240 mutations, 9240 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1215 nt | ATGG  | AAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1482 nt | AAAT  | TTAG  |
| 3   | 5'WT gene block | bsai_5wt_tile31_sub3  | 1677 nt | TTAG  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile35_sub4  | 645 nt  | GAAA  | CTTG  |
| 5   | Oligo pool      | Tile 35 (9240 oligos) | 206 nt  | CTTG  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAT]----5'WT sub2----[TTAG]----5'WT sub3----[GAAA]----5'WT sub4----[CTTG]----oligo+BC----[AGAA]
   ATGG                   AAAT                   TTAG                   GAAA                   CTTG                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile35_sub1    | 1721 nt | TAGC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAGC]----3'WT+PolIII----[CACC]
   TAGC                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 36 of 40 -- Codons 1694-1722 (87 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACAG     | 0.5793   |
| oh2 (3' boundary) | TATT     | 0.8134   |

**Variants:** 5040 mutations, 5040 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1215 nt | ATGG  | AAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1482 nt | AAAT  | TTAG  |
| 3   | 5'WT gene block | bsai_5wt_tile31_sub3  | 1677 nt | TTAG  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4  | 777 nt  | GAAA  | ACAG  |
| 5   | Oligo pool      | Tile 36 (5040 oligos) | 143 nt  | ACAG  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAT]----5'WT sub2----[TTAG]----5'WT sub3----[GAAA]----5'WT sub4----[ACAG]----oligo+BC----[AGAA]
   ATGG                   AAAT                   TTAG                   GAAA                   ACAG                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile36         | 1652 nt | TATT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TATT]----3'WT+PolIII----[CACC]
   TATT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 37 of 40 -- Codons 1723-1773 (153 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGA     | 0.8175   |
| oh2 (3' boundary) | TTTA     | 0.9147   |

**Variants:** 9870 mutations, 9870 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1215 nt | ATGG  | AAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1482 nt | AAAT  | TTAG  |
| 3   | 5'WT gene block | bsai_5wt_tile31_sub3  | 1677 nt | TTAG  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile37_sub4  | 864 nt  | GAAA  | CAGA  |
| 5   | Oligo pool      | Tile 37 (9870 oligos) | 209 nt  | CAGA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAT]----5'WT sub2----[TTAG]----5'WT sub3----[GAAA]----5'WT sub4----[CAGA]----oligo+BC----[AGAA]
   ATGG                   AAAT                   TTAG                   GAAA                   CAGA                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile37         | 1499 nt | TTTA  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTTA]----3'WT+PolIII----[CACC]
   TTTA                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 38 of 40 -- Codons 1768-1815 (144 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTTG     | 0.7594   |
| oh2 (3' boundary) | CACG     | 0.4648   |

**Variants:** 8820 mutations, 8820 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1215 nt | ATGG  | AAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1482 nt | AAAT  | TTAG  |
| 3   | 5'WT gene block | bsai_5wt_tile31_sub3  | 1677 nt | TTAG  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile38_sub4  | 999 nt  | GAAA  | CTTG  |
| 5   | Oligo pool      | Tile 38 (8820 oligos) | 200 nt  | CTTG  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAT]----5'WT sub2----[TTAG]----5'WT sub3----[GAAA]----5'WT sub4----[CTTG]----oligo+BC----[AGAA]
   ATGG                   AAAT                   TTAG                   GAAA                   CTTG                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile38         | 1373 nt | CACG  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CACG]----3'WT+PolIII----[CACC]
   CACG                     CACC 
```

**Set fidelity:** 0.9298 (2 overhangs)

---

### Tile 39 of 40 -- Codons 1810-1866 (171 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTGC     | 0.5642   |
| oh2 (3' boundary) | GCAG     | 0.5118   |

**Variants:** 10710 mutations, 10710 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9         | 1215 nt | ATGG  | AAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1482 nt | AAAT  | TTAG  |
| 3   | 5'WT gene block | bsai_5wt_tile31_sub3   | 1677 nt | TTAG  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile39_sub4   | 1125 nt | GAAA  | CTGC  |
| 5   | Oligo pool      | Tile 39 (10710 oligos) | 227 nt  | CTGC  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAT]----5'WT sub2----[TTAG]----5'WT sub3----[GAAA]----5'WT sub4----[CTGC]----oligo+BC----[AGAA]
   ATGG                   AAAT                   TTAG                   GAAA                   CTGC                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile39         | 1220 nt | GCAG  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCAG]----3'WT+PolIII----[CACC]
   GCAG                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 40 of 40 -- Codons 1861-1902 (126 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAAG     | 0.6640   |
| oh2 (3' boundary) | ATAG     | 0.7330   |

**Variants:** 7770 mutations, 7770 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1215 nt | ATGG  | AAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1482 nt | AAAT  | TTAG  |
| 3   | 5'WT gene block | bsai_5wt_tile31_sub3  | 1677 nt | TTAG  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile37_sub4  | 864 nt  | GAAA  | CAGA  |
| 5   | 5'WT gene block | bsai_5wt_tile40_sub5  | 432 nt  | CAGA  | CAAG  |
| 6   | Oligo pool      | Tile 40 (7770 oligos) | 182 nt  | CAAG  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAT]----5'WT sub2----[TTAG]----5'WT sub3----[GAAA]----5'WT sub4----[CAGA]----5'WT sub5----[CAAG]----oligo+BC----[AGAA]
   ATGG                   AAAT                   TTAG                   GAAA                   CAGA                   CAAG                  AGAA 
```

**Set fidelity:** 0.9981 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component            | Part name                | Length  | 5' OH | 3' OH |
| --- | -------------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product         | (in helper plasmid)      | --      | --    | --    |
| 2   | PolIII-only fragment | bsmbi_polIII_tile40      | 1112 nt | ATAG  | CACC  |
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

**Total blocks:** 83

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| --------------------- | ----------- | ----------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10_sub1  | 1341        | BsaI        | 5wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile11_sub1  | 1440        | BsaI        | 5wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile12_sub2  | 384         | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile13_sub2  | 525         | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile14_sub2  | 708         | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile15_sub2  | 900         | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile16_sub2  | 1038        | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile17_sub2  | 1140        | BsaI        | 5wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile18_sub2  | 1332        | BsaI        | 5wt_tile18_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile19_sub2  | 1482        | BsaI        | 5wt_tile19_sub2;5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2;5wt_tile26_sub2;5wt_tile27_sub2;5wt_tile28_sub2;5wt_tile29_sub2;5wt_tile30_sub2;5wt_tile31_sub2;5wt_tile32_sub2;5wt_tile33_sub2;5wt_tile34_sub2;5wt_tile35_sub2;5wt_tile36_sub2;5wt_tile37_sub2;5wt_tile38_sub2;5wt_tile39_sub2;5wt_tile40_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile2        | 234         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile20_sub2  | 1608        | BsaI        | 5wt_tile20_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile21_sub2  | 1725        | BsaI        | 5wt_tile21_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile22_sub3  | 462         | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile23_sub3  | 543         | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile24_sub3  | 651         | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile25_sub3  | 819         | BsaI        | 5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile26_sub3  | 990         | BsaI        | 5wt_tile26_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile27_sub3  | 1113        | BsaI        | 5wt_tile27_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile28_sub3  | 1242        | BsaI        | 5wt_tile28_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile29_sub3  | 1359        | BsaI        | 5wt_tile29_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile3        | 363         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile30_sub3  | 1545        | BsaI        | 5wt_tile30_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile31_sub3  | 1677        | BsaI        | 5wt_tile31_sub3;5wt_tile32_sub3;5wt_tile33_sub3;5wt_tile34_sub3;5wt_tile35_sub3;5wt_tile36_sub3;5wt_tile37_sub3;5wt_tile38_sub3;5wt_tile39_sub3;5wt_tile40_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile32_sub4  | 153         | BsaI        | 5wt_tile32_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile33_sub4  | 279         | BsaI        | 5wt_tile33_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile34_sub4  | 435         | BsaI        | 5wt_tile34_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile35_sub4  | 645         | BsaI        | 5wt_tile35_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile36_sub4  | 777         | BsaI        | 5wt_tile36_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile37_sub4  | 864         | BsaI        | 5wt_tile37_sub4;5wt_tile40_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile38_sub4  | 999         | BsaI        | 5wt_tile38_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile39_sub4  | 1125        | BsaI        | 5wt_tile39_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile4        | 459         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile40_sub5  | 432         | BsaI        | 5wt_tile40_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile5        | 585         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile6        | 789         | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile7        | 969         | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile8        | 1098        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile9        | 1215        | BsaI        | 5wt_tile9;5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1;5wt_tile26_sub1;5wt_tile27_sub1;5wt_tile28_sub1;5wt_tile29_sub1;5wt_tile30_sub1;5wt_tile31_sub1;5wt_tile32_sub1;5wt_tile33_sub1;5wt_tile34_sub1;5wt_tile35_sub1;5wt_tile36_sub1;5wt_tile37_sub1;5wt_tile38_sub1;5wt_tile39_sub1;5wt_tile40_sub1                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile1_sub1  | 999         | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile1_sub2  | 1482        | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile1_sub3  | 1677        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile8_sub2;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2;3wt_tile16_sub2;3wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile1_sub4  | 864         | BsmBI       | 3wt_tile1_sub4;3wt_tile2_sub4;3wt_tile3_sub4;3wt_tile4_sub4;3wt_tile5_sub4;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub3;3wt_tile9_sub3;3wt_tile10_sub3;3wt_tile11_sub3;3wt_tile12_sub3;3wt_tile13_sub3;3wt_tile14_sub3;3wt_tile15_sub3;3wt_tile16_sub3;3wt_tile17_sub3;3wt_tile18_sub2;3wt_tile19_sub2;3wt_tile20_sub2;3wt_tile21_sub2;3wt_tile22_sub2;3wt_tile23_sub2;3wt_tile24_sub2;3wt_tile25_sub2;3wt_tile26_sub2;3wt_tile27_sub2;3wt_tile28_sub2                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile1_sub5  | 1634        | BsmBI       | 3wt_polIII_tile1_sub5;3wt_polIII_tile2_sub5;3wt_polIII_tile3_sub5;3wt_polIII_tile4_sub5;3wt_polIII_tile5_sub5;3wt_polIII_tile6_sub4;3wt_polIII_tile7_sub4;3wt_polIII_tile8_sub4;3wt_polIII_tile9_sub4;3wt_polIII_tile10_sub4;3wt_polIII_tile11_sub4;3wt_polIII_tile12_sub4;3wt_polIII_tile13_sub4;3wt_polIII_tile14_sub4;3wt_polIII_tile15_sub4;3wt_polIII_tile16_sub4;3wt_polIII_tile17_sub4;3wt_polIII_tile18_sub3;3wt_polIII_tile19_sub3;3wt_polIII_tile20_sub3;3wt_polIII_tile21_sub3;3wt_polIII_tile22_sub3;3wt_polIII_tile23_sub3;3wt_polIII_tile24_sub3;3wt_polIII_tile25_sub3;3wt_polIII_tile26_sub3;3wt_polIII_tile27_sub3;3wt_polIII_tile28_sub3;3wt_polIII_tile29_sub2;3wt_polIII_tile30_sub2;3wt_polIII_tile31_sub2;3wt_polIII_tile32_sub2;3wt_polIII_tile33_sub2;3wt_polIII_tile34_sub2 |
| bsmbi_3wt_tile10_sub1 | 1257        | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile11_sub1 | 1116        | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile12_sub1 | 975         | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile13_sub1 | 792         | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile14_sub1 | 600         | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile15_sub1 | 462         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile16_sub1 | 360         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile17_sub1 | 168         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile18_sub1 | 1695        | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile19_sub1 | 1551        | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile2_sub1  | 870         | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile20_sub1 | 1434        | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile21_sub1 | 1233        | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile22_sub1 | 1152        | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile23_sub1 | 1044        | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile24_sub1 | 876         | BsmBI       | 3wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile25_sub1 | 705         | BsmBI       | 3wt_tile25_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile26_sub1 | 582         | BsmBI       | 3wt_tile26_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile27_sub1 | 453         | BsmBI       | 3wt_tile27_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile28_sub1 | 336         | BsmBI       | 3wt_tile28_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile29_sub1 | 996         | BsmBI       | 3wt_tile29_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile3_sub1  | 774         | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile30_sub1 | 882         | BsmBI       | 3wt_tile30_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile31_sub1 | 729         | BsmBI       | 3wt_tile31_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile32_sub1 | 603         | BsmBI       | 3wt_tile32_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile33_sub1 | 447         | BsmBI       | 3wt_tile33_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile34_sub1 | 237         | BsmBI       | 3wt_tile34_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile35_sub1 | 1721        | BsmBI       | 3wt_polIII_tile35_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile36      | 1652        | BsmBI       | 3wt_polIII_tile36                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile37      | 1499        | BsmBI       | 3wt_polIII_tile37                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile38      | 1373        | BsmBI       | 3wt_polIII_tile38                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile39      | 1220        | BsmBI       | 3wt_polIII_tile39                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile4_sub1  | 648         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile5_sub1  | 444         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile6_sub1  | 1728        | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile7_sub1  | 1599        | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile8_sub1  | 1500        | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile9_sub1  | 1356        | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_polIII_tile40   | 1112        | BsmBI       | polIII_tile40                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |

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

