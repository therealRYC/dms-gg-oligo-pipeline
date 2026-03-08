# DMS-GG Assembly Report: TRIO

Generated: 2026-03-08 14:42:46
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                         |
| -------------------- | ----------------------------------------------------------------------------- |
| Gene name            | TRIO_NM_007118.4_CDS Homo sapiens triple functional domain protein (TRIO) CDS |
| CDS length           | 9294 nt (3098 codons)                                                         |
| Protein length       | 3097 aa                                                                       |
| Number of tiles      | 45                                                                            |
| Total variants       | 64974                                                                         |
| Total oligos         | 649740                                                                        |
| Oligo length range   | 152-290 nt                                                                    |
| Gene blocks to order | 94                                                                            |
| Barcodes per variant | 10                                                                            |

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

**Total oligos:** 649740 | **Length range:** 152-290 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-67      | 13230  | 257 nt |
| 2    | 64-140    | 15330  | 287 nt |
| 3    | 137-207   | 14070  | 269 nt |
| 4    | 204-277   | 14700  | 278 nt |
| 5    | 274-351   | 15540  | 290 nt |
| 6    | 348-425   | 15540  | 290 nt |
| 7    | 422-498   | 15330  | 287 nt |
| 8    | 495-572   | 15540  | 290 nt |
| 9    | 569-600   | 5880   | 152 nt |
| 10   | 597-658   | 12180  | 242 nt |
| 11   | 655-732   | 15540  | 290 nt |
| 12   | 729-800   | 14280  | 272 nt |
| 13   | 797-871   | 14910  | 281 nt |
| 14   | 868-943   | 15120  | 284 nt |
| 15   | 940-1017  | 15540  | 290 nt |
| 16   | 1014-1087 | 14700  | 278 nt |
| 17   | 1084-1161 | 15540  | 290 nt |
| 18   | 1158-1213 | 10920  | 224 nt |
| 19   | 1210-1286 | 15330  | 287 nt |
| 20   | 1283-1360 | 15540  | 290 nt |
| 21   | 1357-1434 | 15540  | 290 nt |
| 22   | 1431-1506 | 15120  | 284 nt |
| 23   | 1503-1580 | 15540  | 290 nt |
| 24   | 1577-1654 | 15540  | 290 nt |
| 25   | 1651-1728 | 15540  | 290 nt |
| 26   | 1725-1794 | 13860  | 266 nt |
| 27   | 1791-1868 | 15540  | 290 nt |
| 28   | 1865-1941 | 15330  | 287 nt |
| 29   | 1938-2015 | 15540  | 290 nt |
| 30   | 2012-2089 | 15540  | 290 nt |
| 31   | 2086-2163 | 15540  | 290 nt |
| 32   | 2160-2236 | 15330  | 287 nt |
| 33   | 2233-2308 | 15120  | 284 nt |
| 34   | 2305-2336 | 5880   | 152 nt |
| 35   | 2333-2386 | 10500  | 218 nt |
| 36   | 2383-2460 | 15540  | 290 nt |
| 37   | 2457-2534 | 15540  | 290 nt |
| 38   | 2531-2603 | 14490  | 275 nt |
| 39   | 2600-2677 | 15540  | 290 nt |
| 40   | 2674-2751 | 15540  | 290 nt |
| 41   | 2748-2825 | 15540  | 290 nt |
| 42   | 2822-2897 | 15120  | 284 nt |
| 43   | 2894-2955 | 12180  | 242 nt |
| 44   | 2952-3029 | 15540  | 290 nt |
| 45   | 3026-3098 | 14490  | 275 nt |

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
| Total barcodes    | 649740                             |
| Unique barcodes   | 649740                             |
| GC content range  | 25% - 75%                          |
| GC content mean   | 47.9%                              |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                  | Description                                                   | Result | Detail                                                                                                                                              |
| ---------------------- | ------------------------------------------------------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths          | All oligos within synthesis length limit                      | PASS   | Range: 152-290 nt (limit: 300)                                                                                                                      |
| block_lengths          | All gene blocks within synthesis length limit                 | PASS   | Range: 94-1785 nt (limit: 1800)                                                                                                                     |
| barcode_junction_sites | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                             |
| barcode_uniqueness     | All barcodes are unique                                       | PASS   | 649740 unique / 649740 total                                                                                                                        |
| tile_coverage          | Tiles cover entire gene without gaps                          | PASS   | 9294 / 9294 nt covered                                                                                                                              |
| variant_count          | Expected number of variants generated                         | PASS   | 64974 unique variants (expected: 64974 across 3094/3096 mutable positions; 58786 missense + 3094 nonsense + 3094 wt_control; 2 position(s) skipped) |
| single_codon_change    | Each non-control variant differs by exactly one codon from WT | PASS   | 618800 / 618800 variants confirmed (WT controls excluded)                                                                                           |
| oligo_gc_content       | Oligo GC content within reasonable range (25-75%)             | FAIL   | GC range: 39.7-76.3% | 11 oligo(s) with extreme GC                                                                                                  |
| domestication_complete | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                             |
| overhang_fidelity      | Tile boundary overhangs have adequate fidelity                | FAIL   | 45 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                             |
| tile_manifests         | Per-tile assembly manifests complete                          | PASS   | 45 tile manifest(s) generated                                                                                                                       |
| helper_plasmid         | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                  |
| reaction_fidelity      | Per-reaction set-level overhang fidelity                      | FAIL   | Min set fidelity: 0.693 across 90 reactions | 33 reaction(s) below 0.90                                                                             |
| barcode_poliii_term    | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 649740 barcode(s) contain TTTT                                                                                                                  |
| block_min_length       | All gene blocks above synthesis minimum length                | FAIL   | 13 block(s) below 300 nt minimum. Range: 94-1785 nt                                                                                                 |
| sb_overhang_collisions | Superblock boundary overhangs are unique (no collisions)      | PASS   | 5 SB boundary OH(s), all unique                                                                                                                     |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 7         | 0.8194             |
| 2    | 3        | 1.0000            | 7         | 0.8194             |
| 3    | 3        | 1.0000            | 7         | 0.6930             |
| 4    | 3        | 1.0000            | 7         | 0.8194             |
| 5    | 3        | 1.0000            | 7         | 0.7043             |
| 6    | 3        | 1.0000            | 7         | 0.7032             |
| 7    | 3        | 1.0000            | 7         | 0.8194             |
| 8    | 3        | 1.0000            | 6         | 0.8194             |
| 9    | 3        | 1.0000            | 6         | 0.8194             |
| 10   | 4        | 1.0000            | 6         | 0.8194             |
| 11   | 4        | 1.0000            | 5         | 0.8194             |
| 12   | 4        | 1.0000            | 6         | 0.8194             |
| 13   | 4        | 1.0000            | 6         | 0.8194             |
| 14   | 4        | 1.0000            | 6         | 0.8194             |
| 15   | 4        | 1.0000            | 5         | 0.8194             |
| 16   | 4        | 1.0000            | 6         | 0.7935             |
| 17   | 4        | 1.0000            | 5         | 0.8194             |
| 18   | 4        | 1.0000            | 5         | 0.8213             |
| 19   | 5        | 1.0000            | 5         | 0.7060             |
| 20   | 5        | 1.0000            | 5         | 0.6946             |
| 21   | 5        | 1.0000            | 5         | 0.8213             |
| 22   | 5        | 1.0000            | 5         | 0.8213             |
| 23   | 5        | 1.0000            | 5         | 0.7746             |
| 24   | 5        | 1.0000            | 5         | 0.8213             |
| 25   | 5        | 1.0000            | 4         | 0.8213             |
| 26   | 5        | 0.8940            | 4         | 0.9358             |
| 27   | 6        | 0.9925            | 4         | 0.9358             |
| 28   | 6        | 0.9900            | 4         | 0.9346             |
| 29   | 6        | 0.9738            | 4         | 0.9358             |
| 30   | 6        | 0.9925            | 4         | 0.9287             |
| 31   | 6        | 0.9881            | 4         | 0.9358             |
| 32   | 6        | 0.9925            | 4         | 0.9358             |
| 33   | 6        | 0.9925            | 3         | 0.9358             |
| 34   | 6        | 0.7466            | 3         | 1.0000             |
| 35   | 7        | 0.9672            | 3         | 1.0000             |
| 36   | 7        | 0.8912            | 3         | 1.0000             |
| 37   | 7        | 0.9854            | 3         | 1.0000             |
| 38   | 7        | 0.9909            | 3         | 1.0000             |
| 39   | 7        | 0.8912            | 3         | 1.0000             |
| 40   | 7        | 0.8545            | 3         | 0.9298             |
| 41   | 7        | 0.8174            | 3         | 1.0000             |
| 42   | 7        | 0.9890            | 2         | 1.0000             |
| 43   | 7        | 0.9925            | 2         | 1.0000             |
| 44   | 8        | 0.8310            | 2         | 0.9984             |
| 45   | 8        | 0.8865            | 2         | 1.0000             |

**Min:** 0.6930 | **Max:** 1.0000 | **Mean:** 0.9210

**Warning:** 33 reaction(s) below 0.90 fidelity — consider alternative split points or overhang reassignment.
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

### Tile 1 of 45 -- Codons 1-67 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGA     | 0.7549   |
| oh2 (3' boundary) | ACCA     | 0.7200   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (13230 oligos)              | 257 nt | ATGA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1     | 1533 nt | ACCA  | CCAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1785 nt | CCAG  | CTAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1719 nt | CTAC  | GGAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1758 nt | GGAG  | CAGC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACCA]----3'WT sub1----[CCAG]----3'WT sub2----[CTAC]----3'WT sub3----[GGAG]----3'WT sub4----[CAGC]----3'WT sub5----[GGGG]----3'WT+PolIII sub6----[CACC]
   ACCA                   CCAG                   CTAC                   GGAG                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.8194 (7 overhangs)

---

### Tile 2 of 45 -- Codons 64-140 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GATG     | 0.4742   |
| oh2 (3' boundary) | GCCC     | 0.5462   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 207 nt | ATGA  | GATG  |
| 2   | Oligo pool      | Tile 2 (15330 oligos) | 287 nt | GATG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[GATG]----oligo+BC----[AGAA]
   ATGA                    GATG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1     | 1314 nt | GCCC  | CCAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1785 nt | CCAG  | CTAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1719 nt | CTAC  | GGAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1758 nt | GGAG  | CAGC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCCC]----3'WT sub1----[CCAG]----3'WT sub2----[CTAC]----3'WT sub3----[GGAG]----3'WT sub4----[CAGC]----3'WT sub5----[GGGG]----3'WT+PolIII sub6----[CACC]
   GCCC                   CCAG                   CTAC                   GGAG                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.8194 (7 overhangs)

---

### Tile 3 of 45 -- Codons 137-207 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCA     | 0.8519   |
| oh2 (3' boundary) | GGAA     | 0.7463   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 426 nt | ATGA  | TCCA  |
| 2   | Oligo pool      | Tile 3 (14070 oligos) | 269 nt | TCCA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[TCCA]----oligo+BC----[AGAA]
   ATGA                    TCCA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1     | 1113 nt | GGAA  | CCAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1785 nt | CCAG  | CTAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1719 nt | CTAC  | GGAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1758 nt | GGAG  | CAGC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAA]----3'WT sub1----[CCAG]----3'WT sub2----[CTAC]----3'WT sub3----[GGAG]----3'WT sub4----[CAGC]----3'WT sub5----[GGGG]----3'WT+PolIII sub6----[CACC]
   GGAA                   CCAG                   CTAC                   GGAG                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.6930 (7 overhangs)

---

### Tile 4 of 45 -- Codons 204-277 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGCT     | 0.4697   |
| oh2 (3' boundary) | TTTG     | 0.7063   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 627 nt | ATGA  | GGCT  |
| 2   | Oligo pool      | Tile 4 (14700 oligos) | 278 nt | GGCT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[GGCT]----oligo+BC----[AGAA]
   ATGA                    GGCT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1     | 903 nt  | TTTG  | CCAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1785 nt | CCAG  | CTAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1719 nt | CTAC  | GGAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1758 nt | GGAG  | CAGC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTTG]----3'WT sub1----[CCAG]----3'WT sub2----[CTAC]----3'WT sub3----[GGAG]----3'WT sub4----[CAGC]----3'WT sub5----[GGGG]----3'WT+PolIII sub6----[CACC]
   TTTG                   CCAG                   CTAC                   GGAG                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.8194 (7 overhangs)

---

### Tile 5 of 45 -- Codons 274-351 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GACC     | 0.5155   |
| oh2 (3' boundary) | GAAG     | 0.6752   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 837 nt | ATGA  | GACC  |
| 2   | Oligo pool      | Tile 5 (15540 oligos) | 290 nt | GACC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[GACC]----oligo+BC----[AGAA]
   ATGA                    GACC                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1     | 681 nt  | GAAG  | CCAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1785 nt | CCAG  | CTAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1719 nt | CTAC  | GGAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1758 nt | GGAG  | CAGC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAG]----3'WT sub1----[CCAG]----3'WT sub2----[CTAC]----3'WT sub3----[GGAG]----3'WT sub4----[CAGC]----3'WT sub5----[GGGG]----3'WT+PolIII sub6----[CACC]
   GAAG                   CCAG                   CTAC                   GGAG                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.7043 (7 overhangs)

---

### Tile 6 of 45 -- Codons 348-425 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GATG     | 0.4742   |
| oh2 (3' boundary) | TCAG     | 0.7814   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 1059 nt | ATGA  | GATG  |
| 2   | Oligo pool      | Tile 6 (15540 oligos) | 290 nt  | GATG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT block----[GATG]----oligo+BC----[AGAA]
   ATGA                    GATG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1     | 459 nt  | TCAG  | CCAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1785 nt | CCAG  | CTAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1719 nt | CTAC  | GGAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1758 nt | GGAG  | CAGC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAG]----3'WT sub1----[CCAG]----3'WT sub2----[CTAC]----3'WT sub3----[GGAG]----3'WT sub4----[CAGC]----3'WT sub5----[GGGG]----3'WT+PolIII sub6----[CACC]
   TCAG                   CCAG                   CTAC                   GGAG                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.7032 (7 overhangs)

---

### Tile 7 of 45 -- Codons 422-498 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCG     | 0.5700   |
| oh2 (3' boundary) | TTAT     | 0.8673   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 1281 nt | ATGA  | ATCG  |
| 2   | Oligo pool      | Tile 7 (15330 oligos) | 287 nt  | ATCG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT block----[ATCG]----oligo+BC----[AGAA]
   ATGA                    ATCG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1     | 240 nt  | TTAT  | CCAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1785 nt | CCAG  | CTAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1719 nt | CTAC  | GGAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1758 nt | GGAG  | CAGC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTAT]----3'WT sub1----[CCAG]----3'WT sub2----[CTAC]----3'WT sub3----[GGAG]----3'WT sub4----[CAGC]----3'WT sub5----[GGGG]----3'WT+PolIII sub6----[CACC]
   TTAT                   CCAG                   CTAC                   GGAG                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.8194 (7 overhangs)

---

### Tile 8 of 45 -- Codons 495-572 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACTC     | 0.5979   |
| oh2 (3' boundary) | CCAG     | 0.6122   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1500 nt | ATGA  | ACTC  |
| 2   | Oligo pool      | Tile 8 (15540 oligos) | 290 nt  | ACTC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT block----[ACTC]----oligo+BC----[AGAA]
   ATGA                    ACTC                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1785 nt | CCAG  | CTAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1719 nt | CTAC  | GGAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1758 nt | GGAG  | CAGC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCAG]----3'WT sub1----[CTAC]----3'WT sub2----[GGAG]----3'WT sub3----[CAGC]----3'WT sub4----[GGGG]----3'WT+PolIII sub5----[CACC]
   CCAG                   CTAC                   GGAG                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.8194 (6 overhangs)

---

### Tile 9 of 45 -- Codons 569-600 (96 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TGTG     | 0.5408   |
| oh2 (3' boundary) | TCTT     | 0.7985   |

**Variants:** 5880 mutations, 5880 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1722 nt | ATGA  | TGTG  |
| 2   | Oligo pool      | Tile 9 (5880 oligos)  | 152 nt  | TGTG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT block----[TGTG]----oligo+BC----[AGAA]
   ATGA                    TGTG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1     | 1701 nt | TCTT  | CTAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1719 nt | CTAC  | GGAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1758 nt | GGAG  | CAGC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCTT]----3'WT sub1----[CTAC]----3'WT sub2----[GGAG]----3'WT sub3----[CAGC]----3'WT sub4----[GGGG]----3'WT+PolIII sub5----[CACC]
   TCTT                   CTAC                   GGAG                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.8194 (6 overhangs)

---

### Tile 10 of 45 -- Codons 597-658 (186 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGGA     | 0.6194   |
| oh2 (3' boundary) | AGAT     | 0.6825   |

**Variants:** 12180 mutations, 12180 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile10_sub2   | 94 nt   | CCAG  | GGGA  |
| 3   | Oligo pool      | Tile 10 (12180 oligos) | 242 nt  | GGGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[GGGA]----oligo+BC----[AGAA]
   ATGA                   CCAG                   GGGA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1    | 1527 nt | AGAT  | CTAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1719 nt | CTAC  | GGAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1758 nt | GGAG  | CAGC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAT]----3'WT sub1----[CTAC]----3'WT sub2----[GGAG]----3'WT sub3----[CAGC]----3'WT sub4----[GGGG]----3'WT+PolIII sub5----[CACC]
   AGAT                   CTAC                   GGAG                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.8194 (6 overhangs)

---

### Tile 11 of 45 -- Codons 655-732 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CGGA     | 0.6609   |
| oh2 (3' boundary) | GGAG     | 0.5228   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile11_sub2   | 268 nt  | CCAG  | CGGA  |
| 3   | Oligo pool      | Tile 11 (15540 oligos) | 290 nt  | CGGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[CGGA]----oligo+BC----[AGAA]
   ATGA                   CCAG                   CGGA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1    | 1305 nt | GGAG  | CTAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1719 nt | CTAC  | GGAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1758 nt | GGAG  | CAGC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAG]----3'WT sub1----[CTAC]----3'WT sub2----[GGAG]----3'WT sub3----[CAGC]----3'WT sub4----[GGGG]----3'WT+PolIII sub5----[CACC]
   GGAG                   CTAC                   GGAG                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.8194 (5 overhangs)

---

### Tile 12 of 45 -- Codons 729-800 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGG     | 0.6552   |
| oh2 (3' boundary) | CTCA     | 0.6872   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2   | 490 nt  | CCAG  | AAGG  |
| 3   | Oligo pool      | Tile 12 (14280 oligos) | 272 nt  | AAGG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[AAGG]----oligo+BC----[AGAA]
   ATGA                   CCAG                   AAGG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1    | 1101 nt | CTCA  | CTAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1719 nt | CTAC  | GGAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1758 nt | GGAG  | CAGC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTCA]----3'WT sub1----[CTAC]----3'WT sub2----[GGAG]----3'WT sub3----[CAGC]----3'WT sub4----[GGGG]----3'WT+PolIII sub5----[CACC]
   CTCA                   CTAC                   GGAG                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.8194 (6 overhangs)

---

### Tile 13 of 45 -- Codons 797-871 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GACA     | 0.6127   |
| oh2 (3' boundary) | AGAT     | 0.6825   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 694 nt  | CCAG  | GACA  |
| 3   | Oligo pool      | Tile 13 (14910 oligos) | 281 nt  | GACA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[GACA]----oligo+BC----[AGAA]
   ATGA                   CCAG                   GACA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1    | 888 nt  | AGAT  | CTAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1719 nt | CTAC  | GGAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1758 nt | GGAG  | CAGC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAT]----3'WT sub1----[CTAC]----3'WT sub2----[GGAG]----3'WT sub3----[CAGC]----3'WT sub4----[GGGG]----3'WT+PolIII sub5----[CACC]
   AGAT                   CTAC                   GGAG                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.8194 (6 overhangs)

---

### Tile 14 of 45 -- Codons 868-943 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TGTG     | 0.5408   |
| oh2 (3' boundary) | GGCA     | 0.5273   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 907 nt  | CCAG  | TGTG  |
| 3   | Oligo pool      | Tile 14 (15120 oligos) | 284 nt  | TGTG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[TGTG]----oligo+BC----[AGAA]
   ATGA                   CCAG                   TGTG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1    | 672 nt  | GGCA  | CTAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1719 nt | CTAC  | GGAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1758 nt | GGAG  | CAGC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGCA]----3'WT sub1----[CTAC]----3'WT sub2----[GGAG]----3'WT sub3----[CAGC]----3'WT sub4----[GGGG]----3'WT+PolIII sub5----[CACC]
   GGCA                   CTAC                   GGAG                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.8194 (6 overhangs)

---

### Tile 15 of 45 -- Codons 940-1017 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAC     | 0.8333   |
| oh2 (3' boundary) | CTAC     | 0.6583   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1123 nt | CCAG  | TTAC  |
| 3   | Oligo pool      | Tile 15 (15540 oligos) | 290 nt  | TTAC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[TTAC]----oligo+BC----[AGAA]
   ATGA                   CCAG                   TTAC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1    | 450 nt  | CTAC  | CTAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1719 nt | CTAC  | GGAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1758 nt | GGAG  | CAGC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTAC]----3'WT sub1----[CTAC]----3'WT sub2----[GGAG]----3'WT sub3----[CAGC]----3'WT sub4----[GGGG]----3'WT+PolIII sub5----[CACC]
   CTAC                   CTAC                   GGAG                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.8194 (5 overhangs)

---

### Tile 16 of 45 -- Codons 1014-1087 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTCG     | 0.4866   |
| oh2 (3' boundary) | ATAC     | 0.6804   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1345 nt | CCAG  | GTCG  |
| 3   | Oligo pool      | Tile 16 (14700 oligos) | 278 nt  | GTCG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[GTCG]----oligo+BC----[AGAA]
   ATGA                   CCAG                   GTCG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1    | 240 nt  | ATAC  | CTAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1719 nt | CTAC  | GGAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1758 nt | GGAG  | CAGC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATAC]----3'WT sub1----[CTAC]----3'WT sub2----[GGAG]----3'WT sub3----[CAGC]----3'WT sub4----[GGGG]----3'WT+PolIII sub5----[CACC]
   ATAC                   CTAC                   GGAG                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.7935 (6 overhangs)

---

### Tile 17 of 45 -- Codons 1084-1161 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCC     | 0.7958   |
| oh2 (3' boundary) | CTAC     | 0.6583   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 1555 nt | CCAG  | TTCC  |
| 3   | Oligo pool      | Tile 17 (15540 oligos) | 290 nt  | TTCC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[TTCC]----oligo+BC----[AGAA]
   ATGA                   CCAG                   TTCC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1719 nt | CTAC  | GGAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1758 nt | GGAG  | CAGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTAC]----3'WT sub1----[GGAG]----3'WT sub2----[CAGC]----3'WT sub3----[GGGG]----3'WT+PolIII sub4----[CACC]
   CTAC                   GGAG                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.8194 (5 overhangs)

---

### Tile 18 of 45 -- Codons 1158-1213 (168 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGCG     | 0.4302   |
| oh2 (3' boundary) | CCAT     | 0.6470   |

**Variants:** 10920 mutations, 10920 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1777 nt | CCAG  | GGCG  |
| 3   | Oligo pool      | Tile 18 (10920 oligos) | 224 nt  | GGCG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[GGCG]----oligo+BC----[AGAA]
   ATGA                   CCAG                   GGCG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1    | 1563 nt | CCAT  | GGAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1758 nt | GGAG  | CAGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCAT]----3'WT sub1----[GGAG]----3'WT sub2----[CAGC]----3'WT sub3----[GGGG]----3'WT+PolIII sub4----[CACC]
   CCAT                   GGAG                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.8213 (5 overhangs)

---

### Tile 19 of 45 -- Codons 1210-1286 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGGC     | 0.4951   |
| oh2 (3' boundary) | GAAG     | 0.6752   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1785 nt | CCAG  | CTAC  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3   | 166 nt  | CTAC  | GGGC  |
| 4   | Oligo pool      | Tile 19 (15330 oligos) | 287 nt  | GGGC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[CTAC]----5'WT sub3----[GGGC]----oligo+BC----[AGAA]
   ATGA                   CCAG                   CTAC                   GGGC                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1    | 1344 nt | GAAG  | GGAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1758 nt | GGAG  | CAGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAG]----3'WT sub1----[GGAG]----3'WT sub2----[CAGC]----3'WT sub3----[GGGG]----3'WT+PolIII sub4----[CACC]
   GAAG                   GGAG                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.7060 (5 overhangs)

---

### Tile 20 of 45 -- Codons 1283-1360 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATG     | 0.6412   |
| oh2 (3' boundary) | GGAA     | 0.7463   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1785 nt | CCAG  | CTAC  |
| 3   | 5'WT gene block | bsai_5wt_tile20_sub3   | 385 nt  | CTAC  | AATG  |
| 4   | Oligo pool      | Tile 20 (15540 oligos) | 290 nt  | AATG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[CTAC]----5'WT sub3----[AATG]----oligo+BC----[AGAA]
   ATGA                   CCAG                   CTAC                   AATG                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1    | 1122 nt | GGAA  | GGAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1758 nt | GGAG  | CAGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAA]----3'WT sub1----[GGAG]----3'WT sub2----[CAGC]----3'WT sub3----[GGGG]----3'WT+PolIII sub4----[CACC]
   GGAA                   GGAG                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.6946 (5 overhangs)

---

### Tile 21 of 45 -- Codons 1357-1434 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGG     | 0.6552   |
| oh2 (3' boundary) | GCTC     | 0.5230   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1785 nt | CCAG  | CTAC  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3   | 607 nt  | CTAC  | AAGG  |
| 4   | Oligo pool      | Tile 21 (15540 oligos) | 290 nt  | AAGG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[CTAC]----5'WT sub3----[AAGG]----oligo+BC----[AGAA]
   ATGA                   CCAG                   CTAC                   AAGG                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1    | 900 nt  | GCTC  | GGAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1758 nt | GGAG  | CAGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCTC]----3'WT sub1----[GGAG]----3'WT sub2----[CAGC]----3'WT sub3----[GGGG]----3'WT+PolIII sub4----[CACC]
   GCTC                   GGAG                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.8213 (5 overhangs)

---

### Tile 22 of 45 -- Codons 1431-1506 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGT     | 0.7629   |
| oh2 (3' boundary) | AGAA     | 0.8847   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1785 nt | CCAG  | CTAC  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 829 nt  | CTAC  | AAGT  |
| 4   | Oligo pool      | Tile 22 (15120 oligos) | 284 nt  | AAGT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[CTAC]----5'WT sub3----[AAGT]----oligo+BC----[AGAA]
   ATGA                   CCAG                   CTAC                   AAGT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1    | 684 nt  | AGAA  | GGAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1758 nt | GGAG  | CAGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAA]----3'WT sub1----[GGAG]----3'WT sub2----[CAGC]----3'WT sub3----[GGGG]----3'WT+PolIII sub4----[CACC]
   AGAA                   GGAG                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.8213 (5 overhangs)

---

### Tile 23 of 45 -- Codons 1503-1580 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGG     | 0.6552   |
| oh2 (3' boundary) | GCAG     | 0.5118   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1785 nt | CCAG  | CTAC  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 1045 nt | CTAC  | AAGG  |
| 4   | Oligo pool      | Tile 23 (15540 oligos) | 290 nt  | AAGG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[CTAC]----5'WT sub3----[AAGG]----oligo+BC----[AGAA]
   ATGA                   CCAG                   CTAC                   AAGG                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1    | 462 nt  | GCAG  | GGAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1758 nt | GGAG  | CAGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCAG]----3'WT sub1----[GGAG]----3'WT sub2----[CAGC]----3'WT sub3----[GGGG]----3'WT+PolIII sub4----[CACC]
   GCAG                   GGAG                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.7746 (5 overhangs)

---

### Tile 24 of 45 -- Codons 1577-1654 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAGA     | 0.7444   |
| oh2 (3' boundary) | GCTC     | 0.5230   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1785 nt | CCAG  | CTAC  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3   | 1267 nt | CTAC  | GAGA  |
| 4   | Oligo pool      | Tile 24 (15540 oligos) | 290 nt  | GAGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[CTAC]----5'WT sub3----[GAGA]----oligo+BC----[AGAA]
   ATGA                   CCAG                   CTAC                   GAGA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile24_sub1    | 240 nt  | GCTC  | GGAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1758 nt | GGAG  | CAGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCTC]----3'WT sub1----[GGAG]----3'WT sub2----[CAGC]----3'WT sub3----[GGGG]----3'WT+PolIII sub4----[CACC]
   GCTC                   GGAG                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.8213 (5 overhangs)

---

### Tile 25 of 45 -- Codons 1651-1728 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGCG     | 0.4197   |
| oh2 (3' boundary) | GGAG     | 0.5228   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1785 nt | CCAG  | CTAC  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3   | 1489 nt | CTAC  | AGCG  |
| 4   | Oligo pool      | Tile 25 (15540 oligos) | 290 nt  | AGCG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[CTAC]----5'WT sub3----[AGCG]----oligo+BC----[AGAA]
   ATGA                   CCAG                   CTAC                   AGCG                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1758 nt | GGAG  | CAGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAG]----3'WT sub1----[CAGC]----3'WT sub2----[GGGG]----3'WT+PolIII sub3----[CACC]
   GGAG                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.8213 (4 overhangs)

---

### Tile 26 of 45 -- Codons 1725-1794 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGG     | 0.5393   |
| oh2 (3' boundary) | GAAG     | 0.6752   |

**Variants:** 13860 mutations, 13860 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1785 nt | CCAG  | CTAC  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3   | 1711 nt | CTAC  | ATGG  |
| 4   | Oligo pool      | Tile 26 (13860 oligos) | 266 nt  | ATGG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[CTAC]----5'WT sub3----[ATGG]----oligo+BC----[AGAA]
   ATGA                   CCAG                   CTAC                   ATGG                  AGAA 
```

**Set fidelity:** 0.8940 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile26_sub1    | 1560 nt | GAAG  | CAGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAG]----3'WT sub1----[CAGC]----3'WT sub2----[GGGG]----3'WT+PolIII sub3----[CACC]
   GAAG                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.9358 (4 overhangs)

---

### Tile 27 of 45 -- Codons 1791-1868 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGGC     | 0.4951   |
| oh2 (3' boundary) | GCCC     | 0.5462   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1785 nt | CCAG  | CTAC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1719 nt | CTAC  | GGAG  |
| 4   | 5'WT gene block | bsai_5wt_tile27_sub4   | 208 nt  | GGAG  | GGGC  |
| 5   | Oligo pool      | Tile 27 (15540 oligos) | 290 nt  | GGGC  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[CTAC]----5'WT sub3----[GGAG]----5'WT sub4----[GGGC]----oligo+BC----[AGAA]
   ATGA                   CCAG                   CTAC                   GGAG                   GGGC                  AGAA 
```

**Set fidelity:** 0.9925 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile27_sub1    | 1338 nt | GCCC  | CAGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCCC]----3'WT sub1----[CAGC]----3'WT sub2----[GGGG]----3'WT+PolIII sub3----[CACC]
   GCCC                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.9358 (4 overhangs)

---

### Tile 28 of 45 -- Codons 1865-1941 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GACG     | 0.4599   |
| oh2 (3' boundary) | TTCC     | 0.7958   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1785 nt | CCAG  | CTAC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1719 nt | CTAC  | GGAG  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4   | 430 nt  | GGAG  | GACG  |
| 5   | Oligo pool      | Tile 28 (15330 oligos) | 287 nt  | GACG  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[CTAC]----5'WT sub3----[GGAG]----5'WT sub4----[GACG]----oligo+BC----[AGAA]
   ATGA                   CCAG                   CTAC                   GGAG                   GACG                  AGAA 
```

**Set fidelity:** 0.9900 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile28_sub1    | 1119 nt | TTCC  | CAGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCC]----3'WT sub1----[CAGC]----3'WT sub2----[GGGG]----3'WT+PolIII sub3----[CACC]
   TTCC                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.9346 (4 overhangs)

---

### Tile 29 of 45 -- Codons 1938-2015 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGCA     | 0.5690   |
| oh2 (3' boundary) | TGTG     | 0.5408   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1785 nt | CCAG  | CTAC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1719 nt | CTAC  | GGAG  |
| 4   | 5'WT gene block | bsai_5wt_tile29_sub4   | 649 nt  | GGAG  | AGCA  |
| 5   | Oligo pool      | Tile 29 (15540 oligos) | 290 nt  | AGCA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[CTAC]----5'WT sub3----[GGAG]----5'WT sub4----[AGCA]----oligo+BC----[AGAA]
   ATGA                   CCAG                   CTAC                   GGAG                   AGCA                  AGAA 
```

**Set fidelity:** 0.9738 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile29_sub1    | 897 nt  | TGTG  | CAGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGTG]----3'WT sub1----[CAGC]----3'WT sub2----[GGGG]----3'WT+PolIII sub3----[CACC]
   TGTG                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.9358 (4 overhangs)

---

### Tile 30 of 45 -- Codons 2012-2089 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GACA     | 0.6127   |
| oh2 (3' boundary) | CCAC     | 0.5426   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1785 nt | CCAG  | CTAC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1719 nt | CTAC  | GGAG  |
| 4   | 5'WT gene block | bsai_5wt_tile30_sub4   | 871 nt  | GGAG  | GACA  |
| 5   | Oligo pool      | Tile 30 (15540 oligos) | 290 nt  | GACA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[CTAC]----5'WT sub3----[GGAG]----5'WT sub4----[GACA]----oligo+BC----[AGAA]
   ATGA                   CCAG                   CTAC                   GGAG                   GACA                  AGAA 
```

**Set fidelity:** 0.9925 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile30_sub1    | 675 nt  | CCAC  | CAGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCAC]----3'WT sub1----[CAGC]----3'WT sub2----[GGGG]----3'WT+PolIII sub3----[CACC]
   CCAC                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.9287 (4 overhangs)

---

### Tile 31 of 45 -- Codons 2086-2163 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CGTC     | 0.5136   |
| oh2 (3' boundary) | TAAA     | 0.9392   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1785 nt | CCAG  | CTAC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1719 nt | CTAC  | GGAG  |
| 4   | 5'WT gene block | bsai_5wt_tile31_sub4   | 1093 nt | GGAG  | CGTC  |
| 5   | Oligo pool      | Tile 31 (15540 oligos) | 290 nt  | CGTC  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[CTAC]----5'WT sub3----[GGAG]----5'WT sub4----[CGTC]----oligo+BC----[AGAA]
   ATGA                   CCAG                   CTAC                   GGAG                   CGTC                  AGAA 
```

**Set fidelity:** 0.9881 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile31_sub1    | 453 nt  | TAAA  | CAGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAAA]----3'WT sub1----[CAGC]----3'WT sub2----[GGGG]----3'WT+PolIII sub3----[CACC]
   TAAA                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.9358 (4 overhangs)

---

### Tile 32 of 45 -- Codons 2160-2236 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCCC     | 0.5462   |
| oh2 (3' boundary) | ATTT     | 0.7664   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1785 nt | CCAG  | CTAC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1719 nt | CTAC  | GGAG  |
| 4   | 5'WT gene block | bsai_5wt_tile32_sub4   | 1315 nt | GGAG  | GCCC  |
| 5   | Oligo pool      | Tile 32 (15330 oligos) | 287 nt  | GCCC  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[CTAC]----5'WT sub3----[GGAG]----5'WT sub4----[GCCC]----oligo+BC----[AGAA]
   ATGA                   CCAG                   CTAC                   GGAG                   GCCC                  AGAA 
```

**Set fidelity:** 0.9925 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile32_sub1    | 234 nt  | ATTT  | CAGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATTT]----3'WT sub1----[CAGC]----3'WT sub2----[GGGG]----3'WT+PolIII sub3----[CACC]
   ATTT                   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.9358 (4 overhangs)

---

### Tile 33 of 45 -- Codons 2233-2308 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCCT     | 0.6204   |
| oh2 (3' boundary) | CAGC     | 0.4815   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1785 nt | CCAG  | CTAC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1719 nt | CTAC  | GGAG  |
| 4   | 5'WT gene block | bsai_5wt_tile33_sub4   | 1534 nt | GGAG  | CCCT  |
| 5   | Oligo pool      | Tile 33 (15120 oligos) | 284 nt  | CCCT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[CTAC]----5'WT sub3----[GGAG]----5'WT sub4----[CCCT]----oligo+BC----[AGAA]
   ATGA                   CCAG                   CTAC                   GGAG                   CCCT                  AGAA 
```

**Set fidelity:** 0.9925 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1785 nt | CAGC  | GGGG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAGC]----3'WT sub1----[GGGG]----3'WT+PolIII sub2----[CACC]
   CAGC                   GGGG                          CACC 
```

**Set fidelity:** 0.9358 (3 overhangs)

---

### Tile 34 of 45 -- Codons 2305-2336 (96 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGTG     | 0.4454   |
| oh2 (3' boundary) | GAGC     | 0.5446   |

**Variants:** 5880 mutations, 5880 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1785 nt | CCAG  | CTAC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3  | 1719 nt | CTAC  | GGAG  |
| 4   | 5'WT gene block | bsai_5wt_tile34_sub4  | 1750 nt | GGAG  | GGTG  |
| 5   | Oligo pool      | Tile 34 (5880 oligos) | 152 nt  | GGTG  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[CTAC]----5'WT sub3----[GGAG]----5'WT sub4----[GGTG]----oligo+BC----[AGAA]
   ATGA                   CCAG                   CTAC                   GGAG                   GGTG                  AGAA 
```

**Set fidelity:** 0.7466 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile34_sub1    | 1701 nt | GAGC  | GGGG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAGC]----3'WT sub1----[GGGG]----3'WT+PolIII sub2----[CACC]
   GAGC                   GGGG                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 35 of 45 -- Codons 2333-2386 (162 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACGA     | 0.7639   |
| oh2 (3' boundary) | CGGC     | 0.4309   |

**Variants:** 10500 mutations, 10500 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1785 nt | CCAG  | CTAC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1719 nt | CTAC  | GGAG  |
| 4   | 5'WT gene block | bsai_5wt_tile35_sub4   | 1758 nt | GGAG  | CAGC  |
| 5   | 5'WT gene block | bsai_5wt_tile35_sub5   | 94 nt   | CAGC  | ACGA  |
| 6   | Oligo pool      | Tile 35 (10500 oligos) | 218 nt  | ACGA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[CTAC]----5'WT sub3----[GGAG]----5'WT sub4----[CAGC]----5'WT sub5----[ACGA]----oligo+BC----[AGAA]
   ATGA                   CCAG                   CTAC                   GGAG                   CAGC                   ACGA                  AGAA 
```

**Set fidelity:** 0.9672 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile35_sub1    | 1551 nt | CGGC  | GGGG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CGGC]----3'WT sub1----[GGGG]----3'WT+PolIII sub2----[CACC]
   CGGC                   GGGG                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 36 of 45 -- Codons 2383-2460 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCCG     | 0.5823   |
| oh2 (3' boundary) | GCCG     | 0.4517   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1785 nt | CCAG  | CTAC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1719 nt | CTAC  | GGAG  |
| 4   | 5'WT gene block | bsai_5wt_tile35_sub4   | 1758 nt | GGAG  | CAGC  |
| 5   | 5'WT gene block | bsai_5wt_tile36_sub5   | 244 nt  | CAGC  | CCCG  |
| 6   | Oligo pool      | Tile 36 (15540 oligos) | 290 nt  | CCCG  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[CTAC]----5'WT sub3----[GGAG]----5'WT sub4----[CAGC]----5'WT sub5----[CCCG]----oligo+BC----[AGAA]
   ATGA                   CCAG                   CTAC                   GGAG                   CAGC                   CCCG                  AGAA 
```

**Set fidelity:** 0.8912 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile36_sub1    | 1329 nt | GCCG  | GGGG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCCG]----3'WT sub1----[GGGG]----3'WT+PolIII sub2----[CACC]
   GCCG                   GGGG                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 37 of 45 -- Codons 2457-2534 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTGA     | 0.6791   |
| oh2 (3' boundary) | CGAG     | 0.5351   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1785 nt | CCAG  | CTAC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1719 nt | CTAC  | GGAG  |
| 4   | 5'WT gene block | bsai_5wt_tile35_sub4   | 1758 nt | GGAG  | CAGC  |
| 5   | 5'WT gene block | bsai_5wt_tile37_sub5   | 466 nt  | CAGC  | CTGA  |
| 6   | Oligo pool      | Tile 37 (15540 oligos) | 290 nt  | CTGA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[CTAC]----5'WT sub3----[GGAG]----5'WT sub4----[CAGC]----5'WT sub5----[CTGA]----oligo+BC----[AGAA]
   ATGA                   CCAG                   CTAC                   GGAG                   CAGC                   CTGA                  AGAA 
```

**Set fidelity:** 0.9854 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile37_sub1    | 1107 nt | CGAG  | GGGG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CGAG]----3'WT sub1----[GGGG]----3'WT+PolIII sub2----[CACC]
   CGAG                   GGGG                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 38 of 45 -- Codons 2531-2603 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCGG     | 0.6343   |
| oh2 (3' boundary) | TGAG     | 0.6546   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1785 nt | CCAG  | CTAC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1719 nt | CTAC  | GGAG  |
| 4   | 5'WT gene block | bsai_5wt_tile35_sub4   | 1758 nt | GGAG  | CAGC  |
| 5   | 5'WT gene block | bsai_5wt_tile38_sub5   | 688 nt  | CAGC  | TCGG  |
| 6   | Oligo pool      | Tile 38 (14490 oligos) | 275 nt  | TCGG  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[CTAC]----5'WT sub3----[GGAG]----5'WT sub4----[CAGC]----5'WT sub5----[TCGG]----oligo+BC----[AGAA]
   ATGA                   CCAG                   CTAC                   GGAG                   CAGC                   TCGG                  AGAA 
```

**Set fidelity:** 0.9909 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile38_sub1    | 900 nt  | TGAG  | GGGG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAG]----3'WT sub1----[GGGG]----3'WT+PolIII sub2----[CACC]
   TGAG                   GGGG                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 39 of 45 -- Codons 2600-2677 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCCG     | 0.5823   |
| oh2 (3' boundary) | TCCC     | 0.7759   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1785 nt | CCAG  | CTAC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1719 nt | CTAC  | GGAG  |
| 4   | 5'WT gene block | bsai_5wt_tile35_sub4   | 1758 nt | GGAG  | CAGC  |
| 5   | 5'WT gene block | bsai_5wt_tile39_sub5   | 895 nt  | CAGC  | CCCG  |
| 6   | Oligo pool      | Tile 39 (15540 oligos) | 290 nt  | CCCG  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[CTAC]----5'WT sub3----[GGAG]----5'WT sub4----[CAGC]----5'WT sub5----[CCCG]----oligo+BC----[AGAA]
   ATGA                   CCAG                   CTAC                   GGAG                   CAGC                   CCCG                  AGAA 
```

**Set fidelity:** 0.8912 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile39_sub1    | 678 nt  | TCCC  | GGGG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCCC]----3'WT sub1----[GGGG]----3'WT+PolIII sub2----[CACC]
   TCCC                   GGGG                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 40 of 45 -- Codons 2674-2751 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTTC     | 0.6384   |
| oh2 (3' boundary) | CACG     | 0.4648   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1785 nt | CCAG  | CTAC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1719 nt | CTAC  | GGAG  |
| 4   | 5'WT gene block | bsai_5wt_tile35_sub4   | 1758 nt | GGAG  | CAGC  |
| 5   | 5'WT gene block | bsai_5wt_tile40_sub5   | 1117 nt | CAGC  | CTTC  |
| 6   | Oligo pool      | Tile 40 (15540 oligos) | 290 nt  | CTTC  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[CTAC]----5'WT sub3----[GGAG]----5'WT sub4----[CAGC]----5'WT sub5----[CTTC]----oligo+BC----[AGAA]
   ATGA                   CCAG                   CTAC                   GGAG                   CAGC                   CTTC                  AGAA 
```

**Set fidelity:** 0.8545 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile40_sub1    | 456 nt  | CACG  | GGGG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CACG]----3'WT sub1----[GGGG]----3'WT+PolIII sub2----[CACC]
   CACG                   GGGG                          CACC 
```

**Set fidelity:** 0.9298 (3 overhangs)

---

### Tile 41 of 45 -- Codons 2748-2825 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGCG     | 0.4302   |
| oh2 (3' boundary) | TAAG     | 0.8377   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1785 nt | CCAG  | CTAC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1719 nt | CTAC  | GGAG  |
| 4   | 5'WT gene block | bsai_5wt_tile35_sub4   | 1758 nt | GGAG  | CAGC  |
| 5   | 5'WT gene block | bsai_5wt_tile41_sub5   | 1339 nt | CAGC  | GGCG  |
| 6   | Oligo pool      | Tile 41 (15540 oligos) | 290 nt  | GGCG  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[CTAC]----5'WT sub3----[GGAG]----5'WT sub4----[CAGC]----5'WT sub5----[GGCG]----oligo+BC----[AGAA]
   ATGA                   CCAG                   CTAC                   GGAG                   CAGC                   GGCG                  AGAA 
```

**Set fidelity:** 0.8174 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile41_sub1    | 234 nt  | TAAG  | GGGG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAAG]----3'WT sub1----[GGGG]----3'WT+PolIII sub2----[CACC]
   TAAG                   GGGG                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 42 of 45 -- Codons 2822-2897 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTGG     | 0.4666   |
| oh2 (3' boundary) | GGGG     | 0.5299   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1785 nt | CCAG  | CTAC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1719 nt | CTAC  | GGAG  |
| 4   | 5'WT gene block | bsai_5wt_tile35_sub4   | 1758 nt | GGAG  | CAGC  |
| 5   | 5'WT gene block | bsai_5wt_tile42_sub5   | 1561 nt | CAGC  | GTGG  |
| 6   | Oligo pool      | Tile 42 (15120 oligos) | 284 nt  | GTGG  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[CTAC]----5'WT sub3----[GGAG]----5'WT sub4----[CAGC]----5'WT sub5----[GTGG]----oligo+BC----[AGAA]
   ATGA                   CCAG                   CTAC                   GGAG                   CAGC                   GTGG                  AGAA 
```

**Set fidelity:** 0.9890 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1715 nt | GGGG  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGGG]----3'WT+PolIII----[CACC]
   GGGG                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 43 of 45 -- Codons 2894-2955 (186 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCGC     | 0.4318   |
| oh2 (3' boundary) | GAAC     | 0.6079   |

**Variants:** 12180 mutations, 12180 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1785 nt | CCAG  | CTAC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1719 nt | CTAC  | GGAG  |
| 4   | 5'WT gene block | bsai_5wt_tile35_sub4   | 1758 nt | GGAG  | CAGC  |
| 5   | 5'WT gene block | bsai_5wt_tile43_sub5   | 1777 nt | CAGC  | GCGC  |
| 6   | Oligo pool      | Tile 43 (12180 oligos) | 242 nt  | GCGC  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[CTAC]----5'WT sub3----[GGAG]----5'WT sub4----[CAGC]----5'WT sub5----[GCGC]----oligo+BC----[AGAA]
   ATGA                   CCAG                   CTAC                   GGAG                   CAGC                   GCGC                  AGAA 
```

**Set fidelity:** 0.9925 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile43         | 1541 nt | GAAC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAC]----3'WT+PolIII----[CACC]
   GAAC                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 44 of 45 -- Codons 2952-3029 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAC     | 0.8333   |
| oh2 (3' boundary) | CTTC     | 0.6384   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1785 nt | CCAG  | CTAC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1719 nt | CTAC  | GGAG  |
| 4   | 5'WT gene block | bsai_5wt_tile35_sub4   | 1758 nt | GGAG  | CAGC  |
| 5   | 5'WT gene block | bsai_5wt_tile44_sub5   | 1785 nt | CAGC  | GGGG  |
| 6   | 5'WT gene block | bsai_5wt_tile44_sub6   | 184 nt  | GGGG  | TTAC  |
| 7   | Oligo pool      | Tile 44 (15540 oligos) | 290 nt  | TTAC  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[CTAC]----5'WT sub3----[GGAG]----5'WT sub4----[CAGC]----5'WT sub5----[GGGG]----5'WT sub6----[TTAC]----oligo+BC----[AGAA]
   ATGA                   CCAG                   CTAC                   GGAG                   CAGC                   GGGG                   TTAC                  AGAA 
```

**Set fidelity:** 0.8310 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile44         | 1319 nt | CTTC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTTC]----3'WT+PolIII----[CACC]
   CTTC                     CACC 
```

**Set fidelity:** 0.9984 (2 overhangs)

---

### Tile 45 of 45 -- Codons 3026-3098 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCG     | 0.6891   |
| oh2 (3' boundary) | TTGA     | 0.8853   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1730 nt | ATGA  | CCAG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1785 nt | CCAG  | CTAC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1719 nt | CTAC  | GGAG  |
| 4   | 5'WT gene block | bsai_5wt_tile35_sub4   | 1758 nt | GGAG  | CAGC  |
| 5   | 5'WT gene block | bsai_5wt_tile44_sub5   | 1785 nt | CAGC  | GGGG  |
| 6   | 5'WT gene block | bsai_5wt_tile45_sub6   | 406 nt  | GGGG  | TTCG  |
| 7   | Oligo pool      | Tile 45 (14490 oligos) | 275 nt  | TTCG  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CCAG]----5'WT sub2----[CTAC]----5'WT sub3----[GGAG]----5'WT sub4----[CAGC]----5'WT sub5----[GGGG]----5'WT sub6----[TTCG]----oligo+BC----[AGAA]
   ATGA                   CCAG                   CTAC                   GGAG                   CAGC                   GGGG                   TTCG                  AGAA 
```

**Set fidelity:** 0.8865 (8 overhangs)

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

**Total blocks:** 94

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| --------------------- | ----------- | ----------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10_sub1  | 1730        | BsaI        | 5wt_tile10_sub1;5wt_tile11_sub1;5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1;5wt_tile26_sub1;5wt_tile27_sub1;5wt_tile28_sub1;5wt_tile29_sub1;5wt_tile30_sub1;5wt_tile31_sub1;5wt_tile32_sub1;5wt_tile33_sub1;5wt_tile34_sub1;5wt_tile35_sub1;5wt_tile36_sub1;5wt_tile37_sub1;5wt_tile38_sub1;5wt_tile39_sub1;5wt_tile40_sub1;5wt_tile41_sub1;5wt_tile42_sub1;5wt_tile43_sub1;5wt_tile44_sub1;5wt_tile45_sub1                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile10_sub2  | 94          | BsaI        | 5wt_tile10_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile11_sub2  | 268         | BsaI        | 5wt_tile11_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile12_sub2  | 490         | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile13_sub2  | 694         | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile14_sub2  | 907         | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile15_sub2  | 1123        | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile16_sub2  | 1345        | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile17_sub2  | 1555        | BsaI        | 5wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile18_sub2  | 1777        | BsaI        | 5wt_tile18_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile19_sub2  | 1785        | BsaI        | 5wt_tile19_sub2;5wt_tile20_sub2;5wt_tile21_sub2;5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2;5wt_tile26_sub2;5wt_tile27_sub2;5wt_tile28_sub2;5wt_tile29_sub2;5wt_tile30_sub2;5wt_tile31_sub2;5wt_tile32_sub2;5wt_tile33_sub2;5wt_tile34_sub2;5wt_tile35_sub2;5wt_tile36_sub2;5wt_tile37_sub2;5wt_tile38_sub2;5wt_tile39_sub2;5wt_tile40_sub2;5wt_tile41_sub2;5wt_tile42_sub2;5wt_tile43_sub2;5wt_tile44_sub2;5wt_tile45_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile19_sub3  | 166         | BsaI        | 5wt_tile19_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile2        | 207         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile20_sub3  | 385         | BsaI        | 5wt_tile20_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile21_sub3  | 607         | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile22_sub3  | 829         | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile23_sub3  | 1045        | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile24_sub3  | 1267        | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile25_sub3  | 1489        | BsaI        | 5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile26_sub3  | 1711        | BsaI        | 5wt_tile26_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile27_sub3  | 1719        | BsaI        | 5wt_tile27_sub3;5wt_tile28_sub3;5wt_tile29_sub3;5wt_tile30_sub3;5wt_tile31_sub3;5wt_tile32_sub3;5wt_tile33_sub3;5wt_tile34_sub3;5wt_tile35_sub3;5wt_tile36_sub3;5wt_tile37_sub3;5wt_tile38_sub3;5wt_tile39_sub3;5wt_tile40_sub3;5wt_tile41_sub3;5wt_tile42_sub3;5wt_tile43_sub3;5wt_tile44_sub3;5wt_tile45_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile27_sub4  | 208         | BsaI        | 5wt_tile27_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile28_sub4  | 430         | BsaI        | 5wt_tile28_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile29_sub4  | 649         | BsaI        | 5wt_tile29_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile3        | 426         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile30_sub4  | 871         | BsaI        | 5wt_tile30_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile31_sub4  | 1093        | BsaI        | 5wt_tile31_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile32_sub4  | 1315        | BsaI        | 5wt_tile32_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile33_sub4  | 1534        | BsaI        | 5wt_tile33_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile34_sub4  | 1750        | BsaI        | 5wt_tile34_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile35_sub4  | 1758        | BsaI        | 5wt_tile35_sub4;5wt_tile36_sub4;5wt_tile37_sub4;5wt_tile38_sub4;5wt_tile39_sub4;5wt_tile40_sub4;5wt_tile41_sub4;5wt_tile42_sub4;5wt_tile43_sub4;5wt_tile44_sub4;5wt_tile45_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile35_sub5  | 94          | BsaI        | 5wt_tile35_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile36_sub5  | 244         | BsaI        | 5wt_tile36_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile37_sub5  | 466         | BsaI        | 5wt_tile37_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile38_sub5  | 688         | BsaI        | 5wt_tile38_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile39_sub5  | 895         | BsaI        | 5wt_tile39_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile4        | 627         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile40_sub5  | 1117        | BsaI        | 5wt_tile40_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile41_sub5  | 1339        | BsaI        | 5wt_tile41_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile42_sub5  | 1561        | BsaI        | 5wt_tile42_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile43_sub5  | 1777        | BsaI        | 5wt_tile43_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile44_sub5  | 1785        | BsaI        | 5wt_tile44_sub5;5wt_tile45_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile44_sub6  | 184         | BsaI        | 5wt_tile44_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile45_sub6  | 406         | BsaI        | 5wt_tile45_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile5        | 837         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile6        | 1059        | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile7        | 1281        | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile8        | 1500        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile9        | 1722        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile1_sub1  | 1533        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile1_sub2  | 1785        | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile1_sub3  | 1719        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub2;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2;3wt_tile16_sub2;3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile1_sub4  | 1758        | BsmBI       | 3wt_tile1_sub4;3wt_tile2_sub4;3wt_tile3_sub4;3wt_tile4_sub4;3wt_tile5_sub4;3wt_tile6_sub4;3wt_tile7_sub4;3wt_tile8_sub3;3wt_tile9_sub3;3wt_tile10_sub3;3wt_tile11_sub3;3wt_tile12_sub3;3wt_tile13_sub3;3wt_tile14_sub3;3wt_tile15_sub3;3wt_tile16_sub3;3wt_tile17_sub2;3wt_tile18_sub2;3wt_tile19_sub2;3wt_tile20_sub2;3wt_tile21_sub2;3wt_tile22_sub2;3wt_tile23_sub2;3wt_tile24_sub2;3wt_tile25_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile1_sub5  | 1785        | BsmBI       | 3wt_tile1_sub5;3wt_tile2_sub5;3wt_tile3_sub5;3wt_tile4_sub5;3wt_tile5_sub5;3wt_tile6_sub5;3wt_tile7_sub5;3wt_tile8_sub4;3wt_tile9_sub4;3wt_tile10_sub4;3wt_tile11_sub4;3wt_tile12_sub4;3wt_tile13_sub4;3wt_tile14_sub4;3wt_tile15_sub4;3wt_tile16_sub4;3wt_tile17_sub3;3wt_tile18_sub3;3wt_tile19_sub3;3wt_tile20_sub3;3wt_tile21_sub3;3wt_tile22_sub3;3wt_tile23_sub3;3wt_tile24_sub3;3wt_tile25_sub2;3wt_tile26_sub2;3wt_tile27_sub2;3wt_tile28_sub2;3wt_tile29_sub2;3wt_tile30_sub2;3wt_tile31_sub2;3wt_tile32_sub2;3wt_tile33_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile1_sub6  | 1715        | BsmBI       | 3wt_polIII_tile1_sub6;3wt_polIII_tile2_sub6;3wt_polIII_tile3_sub6;3wt_polIII_tile4_sub6;3wt_polIII_tile5_sub6;3wt_polIII_tile6_sub6;3wt_polIII_tile7_sub6;3wt_polIII_tile8_sub5;3wt_polIII_tile9_sub5;3wt_polIII_tile10_sub5;3wt_polIII_tile11_sub5;3wt_polIII_tile12_sub5;3wt_polIII_tile13_sub5;3wt_polIII_tile14_sub5;3wt_polIII_tile15_sub5;3wt_polIII_tile16_sub5;3wt_polIII_tile17_sub4;3wt_polIII_tile18_sub4;3wt_polIII_tile19_sub4;3wt_polIII_tile20_sub4;3wt_polIII_tile21_sub4;3wt_polIII_tile22_sub4;3wt_polIII_tile23_sub4;3wt_polIII_tile24_sub4;3wt_polIII_tile25_sub3;3wt_polIII_tile26_sub3;3wt_polIII_tile27_sub3;3wt_polIII_tile28_sub3;3wt_polIII_tile29_sub3;3wt_polIII_tile30_sub3;3wt_polIII_tile31_sub3;3wt_polIII_tile32_sub3;3wt_polIII_tile33_sub2;3wt_polIII_tile34_sub2;3wt_polIII_tile35_sub2;3wt_polIII_tile36_sub2;3wt_polIII_tile37_sub2;3wt_polIII_tile38_sub2;3wt_polIII_tile39_sub2;3wt_polIII_tile40_sub2;3wt_polIII_tile41_sub2;3wt_polIII_tile42 |
| bsmbi_3wt_tile10_sub1 | 1527        | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile11_sub1 | 1305        | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile12_sub1 | 1101        | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile13_sub1 | 888         | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile14_sub1 | 672         | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile15_sub1 | 450         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile16_sub1 | 240         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile18_sub1 | 1563        | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile19_sub1 | 1344        | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile2_sub1  | 1314        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile20_sub1 | 1122        | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile21_sub1 | 900         | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile22_sub1 | 684         | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile23_sub1 | 462         | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile24_sub1 | 240         | BsmBI       | 3wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile26_sub1 | 1560        | BsmBI       | 3wt_tile26_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile27_sub1 | 1338        | BsmBI       | 3wt_tile27_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile28_sub1 | 1119        | BsmBI       | 3wt_tile28_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile29_sub1 | 897         | BsmBI       | 3wt_tile29_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile3_sub1  | 1113        | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile30_sub1 | 675         | BsmBI       | 3wt_tile30_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile31_sub1 | 453         | BsmBI       | 3wt_tile31_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile32_sub1 | 234         | BsmBI       | 3wt_tile32_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile34_sub1 | 1701        | BsmBI       | 3wt_tile34_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile35_sub1 | 1551        | BsmBI       | 3wt_tile35_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile36_sub1 | 1329        | BsmBI       | 3wt_tile36_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile37_sub1 | 1107        | BsmBI       | 3wt_tile37_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile38_sub1 | 900         | BsmBI       | 3wt_tile38_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile39_sub1 | 678         | BsmBI       | 3wt_tile39_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile4_sub1  | 903         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile40_sub1 | 456         | BsmBI       | 3wt_tile40_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile41_sub1 | 234         | BsmBI       | 3wt_tile41_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile43      | 1541        | BsmBI       | 3wt_polIII_tile43                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile44      | 1319        | BsmBI       | 3wt_polIII_tile44                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile5_sub1  | 681         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile6_sub1  | 459         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile7_sub1  | 240         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile9_sub1  | 1701        | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_polIII_tile45   | 1112        | BsmBI       | polIII_tile45                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |

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

| Parameter             | Value |
| --------------------- | ----- |
| max_oligo_length      | 300   |
| max_geneblock_length  | 1800  |
| barcode_length        | 20    |
| min_hamming_distance  | 3     |
| barcode_prefix_length | 12    |
| barcodes_per_variant  | 10    |
| boundary_method       | dp    |
| multi_k_search        | TRUE  |
| auto_domesticate      | TRUE  |

