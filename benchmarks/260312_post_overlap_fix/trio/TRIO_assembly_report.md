# DMS-GG Assembly Report: TRIO

Generated: 2026-03-12 23:15:26
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                         |
| -------------------- | ----------------------------------------------------------------------------- |
| Gene name            | TRIO_NM_007118.4_CDS Homo sapiens triple functional domain protein (TRIO) CDS |
| CDS length           | 9294 nt (3098 codons)                                                         |
| Protein length       | 3097 aa                                                                       |
| Number of tiles      | 57                                                                            |
| Total variants       | 64470                                                                         |
| Total oligos         | 644700                                                                        |
| Oligo length range   | 149-290 nt                                                                    |
| Gene blocks to order | 118                                                                           |
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

**Total oligos:** 644700 | **Length range:** 149-290 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-69      | 13650  | 263 nt |
| 2    | 66-108    | 8190   | 185 nt |
| 3    | 105-141   | 6930   | 167 nt |
| 4    | 138-215   | 15540  | 290 nt |
| 5    | 212-286   | 14910  | 281 nt |
| 6    | 283-354   | 14280  | 272 nt |
| 7    | 351-425   | 14910  | 281 nt |
| 8    | 422-490   | 13650  | 263 nt |
| 9    | 491-524   | 6300   | 158 nt |
| 10   | 521-574   | 10500  | 218 nt |
| 11   | 571-614   | 8400   | 188 nt |
| 12   | 611-676   | 13020  | 254 nt |
| 13   | 673-746   | 14700  | 278 nt |
| 14   | 743-807   | 12810  | 251 nt |
| 15   | 804-844   | 7770   | 179 nt |
| 16   | 841-872   | 5880   | 152 nt |
| 17   | 869-934   | 13020  | 254 nt |
| 18   | 931-997   | 13230  | 257 nt |
| 19   | 994-1046  | 10290  | 215 nt |
| 20   | 1047-1115 | 13650  | 263 nt |
| 21   | 1112-1188 | 15330  | 287 nt |
| 22   | 1185-1259 | 14910  | 281 nt |
| 23   | 1256-1305 | 9660   | 206 nt |
| 24   | 1302-1352 | 9870   | 209 nt |
| 25   | 1349-1422 | 14700  | 278 nt |
| 26   | 1419-1477 | 11550  | 233 nt |
| 27   | 1474-1523 | 9660   | 206 nt |
| 28   | 1524-1588 | 12810  | 251 nt |
| 29   | 1585-1639 | 10710  | 221 nt |
| 30   | 1636-1702 | 13230  | 257 nt |
| 31   | 1699-1734 | 6720   | 164 nt |
| 32   | 1731-1805 | 14910  | 281 nt |
| 33   | 1802-1843 | 7980   | 182 nt |
| 34   | 1840-1895 | 10920  | 224 nt |
| 35   | 1892-1956 | 12810  | 251 nt |
| 36   | 1953-1998 | 8820   | 194 nt |
| 37   | 1995-2064 | 13860  | 266 nt |
| 38   | 2065-2130 | 13020  | 254 nt |
| 39   | 2127-2191 | 12810  | 251 nt |
| 40   | 2188-2218 | 5670   | 149 nt |
| 41   | 2215-2257 | 8190   | 185 nt |
| 42   | 2254-2284 | 5670   | 149 nt |
| 43   | 2281-2343 | 12390  | 245 nt |
| 44   | 2340-2411 | 14280  | 272 nt |
| 45   | 2408-2473 | 13020  | 254 nt |
| 46   | 2470-2546 | 15330  | 287 nt |
| 47   | 2543-2607 | 12810  | 251 nt |
| 48   | 2608-2642 | 6510   | 161 nt |
| 49   | 2639-2689 | 9870   | 209 nt |
| 50   | 2686-2729 | 8400   | 188 nt |
| 51   | 2726-2767 | 7980   | 182 nt |
| 52   | 2764-2814 | 9870   | 209 nt |
| 53   | 2811-2859 | 9450   | 203 nt |
| 54   | 2856-2921 | 13020  | 254 nt |
| 55   | 2918-2995 | 15540  | 290 nt |
| 56   | 2992-3056 | 12810  | 251 nt |
| 57   | 3057-3098 | 7980   | 182 nt |

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
| Total barcodes    | 644700                             |
| Unique barcodes   | 644700                             |
| GC content range  | 25% - 75%                          |
| GC content mean   | 47.9%                              |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                  | Description                                                   | Result | Detail                                                                                                                                               |
| ---------------------- | ------------------------------------------------------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths          | All oligos within synthesis length limit                      | PASS   | Range: 149-290 nt (limit: 300)                                                                                                                       |
| block_lengths          | All gene blocks within synthesis length limit                 | PASS   | Range: 208-1779 nt (limit: 1800)                                                                                                                     |
| barcode_junction_sites | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                              |
| barcode_uniqueness     | All barcodes are unique                                       | PASS   | 644700 unique / 644700 total                                                                                                                         |
| tile_coverage          | Tiles cover entire gene without gaps                          | PASS   | 9294 / 9294 nt covered                                                                                                                               |
| variant_count          | Expected number of variants generated                         | PASS   | 64470 unique variants (expected: 64470 across 3070/3096 mutable positions; 58330 missense + 3070 nonsense + 3070 wt_control; 26 position(s) skipped) |
| single_codon_change    | Each non-control variant differs by exactly one codon from WT | PASS   | 614000 / 614000 variants confirmed (WT controls excluded)                                                                                            |
| oligo_gc_content       | Oligo GC content within reasonable range (25-75%)             | FAIL   | GC range: 38.5-76.3% | 213 oligo(s) with extreme GC                                                                                                  |
| domestication_complete | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                              |
| overhang_fidelity      | Tile boundary overhangs have adequate fidelity                | FAIL   | 57 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                              |
| tile_manifests         | Per-tile assembly manifests complete                          | PASS   | 57 tile manifest(s) generated                                                                                                                        |
| helper_plasmid         | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                   |
| reaction_fidelity      | Per-reaction set-level overhang fidelity                      | PASS   | Min set fidelity: 0.8434 across 114 reactions | 7 reaction(s) below 0.90                                                                             |
| barcode_poliii_term    | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 644700 barcode(s) contain TTTT                                                                                                                   |
| block_min_length       | All gene blocks above synthesis minimum length                | FAIL   | 6 block(s) below 300 nt minimum. Range: 208-1779 nt                                                                                                  |
| sb_overhang_collisions | Superblock boundary overhangs are unique (no collisions)      | PASS   | 6 SB boundary OH(s), all unique                                                                                                                      |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 8         | 0.9933             |
| 2    | 3        | 1.0000            | 8         | 0.9933             |
| 3    | 3        | 0.9656            | 7         | 0.9933             |
| 4    | 3        | 0.9953            | 8         | 0.9933             |
| 5    | 3        | 1.0000            | 8         | 0.9933             |
| 6    | 3        | 1.0000            | 8         | 0.9637             |
| 7    | 3        | 0.9574            | 8         | 0.9933             |
| 8    | 3        | 1.0000            | 7         | 0.9933             |
| 9    | 3        | 1.0000            | 7         | 0.9916             |
| 10   | 3        | 1.0000            | 7         | 1.0000             |
| 11   | 3        | 1.0000            | 7         | 1.0000             |
| 12   | 4        | 1.0000            | 7         | 0.8956             |
| 13   | 4        | 1.0000            | 7         | 0.9923             |
| 14   | 4        | 1.0000            | 7         | 1.0000             |
| 15   | 4        | 1.0000            | 7         | 0.9903             |
| 16   | 4        | 0.9643            | 7         | 0.9960             |
| 17   | 4        | 1.0000            | 7         | 0.9358             |
| 18   | 4        | 1.0000            | 6         | 1.0000             |
| 19   | 4        | 0.9969            | 6         | 1.0000             |
| 20   | 4        | 1.0000            | 6         | 0.9969             |
| 21   | 5        | 1.0000            | 6         | 0.8550             |
| 22   | 5        | 1.0000            | 6         | 0.9933             |
| 23   | 5        | 0.9712            | 6         | 1.0000             |
| 24   | 5        | 1.0000            | 6         | 0.8434             |
| 25   | 5        | 1.0000            | 6         | 1.0000             |
| 26   | 5        | 1.0000            | 5         | 1.0000             |
| 27   | 5        | 1.0000            | 5         | 1.0000             |
| 28   | 5        | 1.0000            | 5         | 1.0000             |
| 29   | 5        | 1.0000            | 5         | 1.0000             |
| 30   | 6        | 1.0000            | 5         | 1.0000             |
| 31   | 6        | 0.9974            | 5         | 0.9638             |
| 32   | 6        | 1.0000            | 5         | 1.0000             |
| 33   | 6        | 0.9574            | 5         | 0.9980             |
| 34   | 6        | 0.9812            | 4         | 1.0000             |
| 35   | 6        | 0.9969            | 5         | 1.0000             |
| 36   | 6        | 1.0000            | 5         | 1.0000             |
| 37   | 6        | 1.0000            | 4         | 1.0000             |
| 38   | 5        | 1.0000            | 4         | 0.8457             |
| 39   | 7        | 1.0000            | 3         | 1.0000             |
| 40   | 7        | 0.8547            | 4         | 1.0000             |
| 41   | 7        | 0.9574            | 4         | 1.0000             |
| 42   | 7        | 1.0000            | 4         | 1.0000             |
| 43   | 7        | 1.0000            | 4         | 1.0000             |
| 44   | 7        | 0.9974            | 4         | 0.9642             |
| 45   | 7        | 1.0000            | 4         | 0.9358             |
| 46   | 7        | 1.0000            | 3         | 1.0000             |
| 47   | 7        | 1.0000            | 3         | 1.0000             |
| 48   | 7        | 0.8807            | 3         | 1.0000             |
| 49   | 7        | 0.9656            | 3         | 1.0000             |
| 50   | 8        | 1.0000            | 3         | 0.9358             |
| 51   | 8        | 0.9643            | 3         | 1.0000             |
| 52   | 8        | 1.0000            | 3         | 0.8550             |
| 53   | 8        | 0.9574            | 2         | 1.0000             |
| 54   | 8        | 0.9978            | 3         | 1.0000             |
| 55   | 7        | 1.0000            | 2         | 1.0000             |
| 56   | 8        | 1.0000            | 2         | 1.0000             |
| 57   | 8        | 0.9812            | 2         | 1.0000             |

**Min:** 0.8434 | **Max:** 1.0000 | **Mean:** 0.9846

**Warning:** 7 reaction(s) below 0.90 fidelity — consider alternative split points or overhang reassignment.
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

### Tile 1 of 57 -- Codons 1-69 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGA     | 0.7549   |
| oh2 (3' boundary) | AGTT     | 0.6748   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (13650 oligos)              | 263 nt | ATGA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1     | 1281 nt | AGTT  | TATC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1686 nt | TATC  | AAAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1449 nt | AAAC  | TGGG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1641 nt | TGGG  | GTCT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGTT]----3'WT sub1----[TATC]----3'WT sub2----[AAAC]----3'WT sub3----[TGGG]----3'WT sub4----[GTCT]----3'WT sub5----[CCTG]----3'WT sub6----[CGTC]----3'WT+PolIII sub7----[CACC]
   AGTT                   TATC                   AAAC                   TGGG                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 0.9933 (8 overhangs)

---

### Tile 2 of 57 -- Codons 66-108 (129 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAC     | 0.8333   |
| oh2 (3' boundary) | AGCC     | 0.4644   |

**Variants:** 8190 mutations, 8190 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 213 nt | ATGA  | TTAC  |
| 2   | Oligo pool      | Tile 2 (8190 oligos)  | 185 nt | TTAC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[TTAC]----oligo+BC----[AGAA]
   ATGA                    TTAC                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1     | 1164 nt | AGCC  | TATC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1686 nt | TATC  | AAAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1449 nt | AAAC  | TGGG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1641 nt | TGGG  | GTCT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGCC]----3'WT sub1----[TATC]----3'WT sub2----[AAAC]----3'WT sub3----[TGGG]----3'WT sub4----[GTCT]----3'WT sub5----[CCTG]----3'WT sub6----[CGTC]----3'WT+PolIII sub7----[CACC]
   AGCC                   TATC                   AAAC                   TGGG                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 0.9933 (8 overhangs)

---

### Tile 3 of 57 -- Codons 105-141 (111 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGGA     | 0.7515   |
| oh2 (3' boundary) | CCTG     | 0.6383   |

**Variants:** 6930 mutations, 6930 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 330 nt | ATGA  | AGGA  |
| 2   | Oligo pool      | Tile 3 (6930 oligos)  | 167 nt | AGGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[AGGA]----oligo+BC----[AGAA]
   ATGA                    AGGA                  AGAA 
```

**Set fidelity:** 0.9656 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1     | 1065 nt | CCTG  | TATC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1686 nt | TATC  | AAAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1449 nt | AAAC  | TGGG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1641 nt | TGGG  | GTCT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTG]----3'WT sub1----[TATC]----3'WT sub2----[AAAC]----3'WT sub3----[TGGG]----3'WT sub4----[GTCT]----3'WT sub5----[CCTG]----3'WT sub6----[CGTC]----3'WT+PolIII sub7----[CACC]
   CCTG                   TATC                   AAAC                   TGGG                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 0.9933 (7 overhangs)

---

### Tile 4 of 57 -- Codons 138-215 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCA     | 0.7483   |
| oh2 (3' boundary) | TGCT     | 0.5975   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 429 nt | ATGA  | ATCA  |
| 2   | Oligo pool      | Tile 4 (15540 oligos) | 290 nt | ATCA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1     | 843 nt  | TGCT  | TATC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1686 nt | TATC  | AAAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1449 nt | AAAC  | TGGG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1641 nt | TGGG  | GTCT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGCT]----3'WT sub1----[TATC]----3'WT sub2----[AAAC]----3'WT sub3----[TGGG]----3'WT sub4----[GTCT]----3'WT sub5----[CCTG]----3'WT sub6----[CGTC]----3'WT+PolIII sub7----[CACC]
   TGCT                   TATC                   AAAC                   TGGG                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 0.9933 (8 overhangs)

---

### Tile 5 of 57 -- Codons 212-286 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAT     | 0.7246   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 651 nt | ATGA  | GAAT  |
| 2   | Oligo pool      | Tile 5 (14910 oligos) | 281 nt | GAAT  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1     | 630 nt  | TGAA  | TATC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1686 nt | TATC  | AAAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1449 nt | AAAC  | TGGG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1641 nt | TGGG  | GTCT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[TATC]----3'WT sub2----[AAAC]----3'WT sub3----[TGGG]----3'WT sub4----[GTCT]----3'WT sub5----[CCTG]----3'WT sub6----[CGTC]----3'WT+PolIII sub7----[CACC]
   TGAA                   TATC                   AAAC                   TGGG                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 0.9933 (8 overhangs)

---

### Tile 6 of 57 -- Codons 283-354 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTTC     | 0.6384   |
| oh2 (3' boundary) | ACAC     | 0.5629   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 864 nt | ATGA  | CTTC  |
| 2   | Oligo pool      | Tile 6 (14280 oligos) | 272 nt | CTTC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[CTTC]----oligo+BC----[AGAA]
   ATGA                    CTTC                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1     | 426 nt  | ACAC  | TATC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1686 nt | TATC  | AAAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1449 nt | AAAC  | TGGG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1641 nt | TGGG  | GTCT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACAC]----3'WT sub1----[TATC]----3'WT sub2----[AAAC]----3'WT sub3----[TGGG]----3'WT sub4----[GTCT]----3'WT sub5----[CCTG]----3'WT sub6----[CGTC]----3'WT+PolIII sub7----[CACC]
   ACAC                   TATC                   AAAC                   TGGG                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 0.9637 (8 overhangs)

---

### Tile 7 of 57 -- Codons 351-425 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | GGAG     | 0.5228   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 1068 nt | ATGA  | AAGA  |
| 2   | Oligo pool      | Tile 7 (14910 oligos) | 281 nt  | AAGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT block----[AAGA]----oligo+BC----[AGAA]
   ATGA                    AAGA                  AGAA 
```

**Set fidelity:** 0.9574 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1     | 213 nt  | GGAG  | TATC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1686 nt | TATC  | AAAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1449 nt | AAAC  | TGGG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1641 nt | TGGG  | GTCT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAG]----3'WT sub1----[TATC]----3'WT sub2----[AAAC]----3'WT sub3----[TGGG]----3'WT sub4----[GTCT]----3'WT sub5----[CCTG]----3'WT sub6----[CGTC]----3'WT+PolIII sub7----[CACC]
   GGAG                   TATC                   AAAC                   TGGG                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 0.9933 (8 overhangs)

---

### Tile 8 of 57 -- Codons 422-490 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCG     | 0.5700   |
| oh2 (3' boundary) | TATC     | 0.8041   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1281 nt | ATGA  | ATCG  |
| 2   | Oligo pool      | Tile 8 (13650 oligos) | 263 nt  | ATCG  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1686 nt | TATC  | AAAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1449 nt | AAAC  | TGGG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1641 nt | TGGG  | GTCT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TATC]----3'WT sub1----[AAAC]----3'WT sub2----[TGGG]----3'WT sub3----[GTCT]----3'WT sub4----[CCTG]----3'WT sub5----[CGTC]----3'WT+PolIII sub6----[CACC]
   TATC                   AAAC                   TGGG                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 0.9933 (7 overhangs)

---

### Tile 9 of 57 -- Codons 491-524 (102 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TATG     | 0.7006   |
| oh2 (3' boundary) | TGCC     | 0.5867   |

**Variants:** 6300 mutations, 6300 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9_sub1   | 1488 nt | ATGA  | TATG  |
| 2   | Oligo pool      | Tile 9 (6300 oligos)  | 158 nt  | TATG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT block----[TATG]----oligo+BC----[AGAA]
   ATGA                    TATG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1     | 1584 nt | TGCC  | AAAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1449 nt | AAAC  | TGGG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1641 nt | TGGG  | GTCT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGCC]----3'WT sub1----[AAAC]----3'WT sub2----[TGGG]----3'WT sub3----[GTCT]----3'WT sub4----[CCTG]----3'WT sub5----[CGTC]----3'WT+PolIII sub6----[CACC]
   TGCC                   AAAC                   TGGG                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 0.9916 (7 overhangs)

---

### Tile 10 of 57 -- Codons 521-574 (162 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCG     | 0.7234   |
| oh2 (3' boundary) | GGTG     | 0.4454   |

**Variants:** 10500 mutations, 10500 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1578 nt | ATGA  | TCCG  |
| 2   | Oligo pool      | Tile 10 (10500 oligos) | 218 nt  | TCCG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT block----[TCCG]----oligo+BC----[AGAA]
   ATGA                    TCCG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1    | 1434 nt | GGTG  | AAAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1449 nt | AAAC  | TGGG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1641 nt | TGGG  | GTCT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGTG]----3'WT sub1----[AAAC]----3'WT sub2----[TGGG]----3'WT sub3----[GTCT]----3'WT sub4----[CCTG]----3'WT sub5----[CGTC]----3'WT+PolIII sub6----[CACC]
   GGTG                   AAAC                   TGGG                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 1.0000 (7 overhangs)

---

### Tile 11 of 57 -- Codons 571-614 (132 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCC     | 0.7958   |
| oh2 (3' boundary) | ACAG     | 0.5793   |

**Variants:** 8400 mutations, 8400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1728 nt | ATGA  | TTCC  |
| 2   | Oligo pool      | Tile 11 (8400 oligos) | 188 nt  | TTCC  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1    | 1314 nt | ACAG  | AAAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1449 nt | AAAC  | TGGG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1641 nt | TGGG  | GTCT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACAG]----3'WT sub1----[AAAC]----3'WT sub2----[TGGG]----3'WT sub3----[GTCT]----3'WT sub4----[CCTG]----3'WT sub5----[CGTC]----3'WT+PolIII sub6----[CACC]
   ACAG                   AAAC                   TGGG                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 1.0000 (7 overhangs)

---

### Tile 12 of 57 -- Codons 611-676 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAG     | 0.6752   |
| oh2 (3' boundary) | TGTG     | 0.5408   |

**Variants:** 13020 mutations, 13020 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2   | 382 nt  | TATC  | GAAG  |
| 3   | Oligo pool      | Tile 12 (13020 oligos) | 254 nt  | GAAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[GAAG]----oligo+BC----[AGAA]
   ATGA                   TATC                   GAAG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1    | 1128 nt | TGTG  | AAAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1449 nt | AAAC  | TGGG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1641 nt | TGGG  | GTCT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGTG]----3'WT sub1----[AAAC]----3'WT sub2----[TGGG]----3'WT sub3----[GTCT]----3'WT sub4----[CCTG]----3'WT sub5----[CGTC]----3'WT+PolIII sub6----[CACC]
   TGTG                   AAAC                   TGGG                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 0.8956 (7 overhangs)

---

### Tile 13 of 57 -- Codons 673-746 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAG     | 0.7814   |
| oh2 (3' boundary) | CCAC     | 0.5426   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 568 nt  | TATC  | TCAG  |
| 3   | Oligo pool      | Tile 13 (14700 oligos) | 278 nt  | TCAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[TCAG]----oligo+BC----[AGAA]
   ATGA                   TATC                   TCAG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1    | 918 nt  | CCAC  | AAAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1449 nt | AAAC  | TGGG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1641 nt | TGGG  | GTCT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCAC]----3'WT sub1----[AAAC]----3'WT sub2----[TGGG]----3'WT sub3----[GTCT]----3'WT sub4----[CCTG]----3'WT sub5----[CGTC]----3'WT+PolIII sub6----[CACC]
   CCAC                   AAAC                   TGGG                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 0.9923 (7 overhangs)

---

### Tile 14 of 57 -- Codons 743-807 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCT     | 0.7151   |
| oh2 (3' boundary) | TCAG     | 0.7814   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 778 nt  | TATC  | ATCT  |
| 3   | Oligo pool      | Tile 14 (12810 oligos) | 251 nt  | ATCT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[ATCT]----oligo+BC----[AGAA]
   ATGA                   TATC                   ATCT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1    | 735 nt  | TCAG  | AAAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1449 nt | AAAC  | TGGG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1641 nt | TGGG  | GTCT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAG]----3'WT sub1----[AAAC]----3'WT sub2----[TGGG]----3'WT sub3----[GTCT]----3'WT sub4----[CCTG]----3'WT sub5----[CGTC]----3'WT+PolIII sub6----[CACC]
   TCAG                   AAAC                   TGGG                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 1.0000 (7 overhangs)

---

### Tile 15 of 57 -- Codons 804-844 (123 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTT     | 0.7985   |
| oh2 (3' boundary) | CCAA     | 0.8439   |

**Variants:** 7770 mutations, 7770 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2  | 961 nt  | TATC  | TCTT  |
| 3   | Oligo pool      | Tile 15 (7770 oligos) | 179 nt  | TCTT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[TCTT]----oligo+BC----[AGAA]
   ATGA                   TATC                   TCTT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1    | 624 nt  | CCAA  | AAAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1449 nt | AAAC  | TGGG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1641 nt | TGGG  | GTCT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCAA]----3'WT sub1----[AAAC]----3'WT sub2----[TGGG]----3'WT sub3----[GTCT]----3'WT sub4----[CCTG]----3'WT sub5----[CGTC]----3'WT+PolIII sub6----[CACC]
   CCAA                   AAAC                   TGGG                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 0.9903 (7 overhangs)

---

### Tile 16 of 57 -- Codons 841-872 (96 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTGA     | 0.8853   |
| oh2 (3' boundary) | AACT     | 0.6635   |

**Variants:** 5880 mutations, 5880 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1072 nt | TATC  | TTGA  |
| 3   | Oligo pool      | Tile 16 (5880 oligos) | 152 nt  | TTGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[TTGA]----oligo+BC----[AGAA]
   ATGA                   TATC                   TTGA                  AGAA 
```

**Set fidelity:** 0.9643 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1    | 540 nt  | AACT  | AAAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1449 nt | AAAC  | TGGG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1641 nt | TGGG  | GTCT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AACT]----3'WT sub1----[AAAC]----3'WT sub2----[TGGG]----3'WT sub3----[GTCT]----3'WT sub4----[CCTG]----3'WT sub5----[CGTC]----3'WT+PolIII sub6----[CACC]
   AACT                   AAAC                   TGGG                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 0.9960 (7 overhangs)

---

### Tile 17 of 57 -- Codons 869-934 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GATA     | 0.7029   |
| oh2 (3' boundary) | CAGC     | 0.4815   |

**Variants:** 13020 mutations, 13020 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 1156 nt | TATC  | GATA  |
| 3   | Oligo pool      | Tile 17 (13020 oligos) | 254 nt  | GATA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[GATA]----oligo+BC----[AGAA]
   ATGA                   TATC                   GATA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1    | 354 nt  | CAGC  | AAAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1449 nt | AAAC  | TGGG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1641 nt | TGGG  | GTCT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAGC]----3'WT sub1----[AAAC]----3'WT sub2----[TGGG]----3'WT sub3----[GTCT]----3'WT sub4----[CCTG]----3'WT sub5----[CGTC]----3'WT+PolIII sub6----[CACC]
   CAGC                   AAAC                   TGGG                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 0.9358 (7 overhangs)

---

### Tile 18 of 57 -- Codons 931-997 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATG     | 0.6412   |
| oh2 (3' boundary) | GCTC     | 0.5230   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1342 nt | TATC  | AATG  |
| 3   | Oligo pool      | Tile 18 (13230 oligos) | 257 nt  | AATG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AATG]----oligo+BC----[AGAA]
   ATGA                   TATC                   AATG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1    | 1596 nt | GCTC  | TGGG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1641 nt | TGGG  | GTCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCTC]----3'WT sub1----[TGGG]----3'WT sub2----[GTCT]----3'WT sub3----[CCTG]----3'WT sub4----[CGTC]----3'WT+PolIII sub5----[CACC]
   GCTC                   TGGG                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 19 of 57 -- Codons 994-1046 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTC     | 0.8105   |
| oh2 (3' boundary) | AAAC     | 0.6694   |

**Variants:** 10290 mutations, 10290 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1531 nt | TATC  | TCTC  |
| 3   | Oligo pool      | Tile 19 (10290 oligos) | 215 nt  | TCTC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[TCTC]----oligo+BC----[AGAA]
   ATGA                   TATC                   TCTC                  AGAA 
```

**Set fidelity:** 0.9969 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1449 nt | AAAC  | TGGG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1641 nt | TGGG  | GTCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAC]----3'WT sub1----[TGGG]----3'WT sub2----[GTCT]----3'WT sub3----[CCTG]----3'WT sub4----[CGTC]----3'WT+PolIII sub5----[CACC]
   AAAC                   TGGG                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 20 of 57 -- Codons 1047-1115 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTGG     | 0.5756   |
| oh2 (3' boundary) | ACGG     | 0.4986   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1690 nt | TATC  | CTGG  |
| 3   | Oligo pool      | Tile 20 (13650 oligos) | 263 nt  | CTGG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[CTGG]----oligo+BC----[AGAA]
   ATGA                   TATC                   CTGG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1    | 1242 nt | ACGG  | TGGG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1641 nt | TGGG  | GTCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACGG]----3'WT sub1----[TGGG]----3'WT sub2----[GTCT]----3'WT sub3----[CCTG]----3'WT sub4----[CGTC]----3'WT+PolIII sub5----[CACC]
   ACGG                   TGGG                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 0.9969 (6 overhangs)

---

### Tile 21 of 57 -- Codons 1112-1188 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCT     | 0.7151   |
| oh2 (3' boundary) | AACC     | 0.5451   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3   | 217 nt  | AAAC  | ATCT  |
| 4   | Oligo pool      | Tile 21 (15330 oligos) | 287 nt  | ATCT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[ATCT]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   ATCT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1    | 1023 nt | AACC  | TGGG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1641 nt | TGGG  | GTCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AACC]----3'WT sub1----[TGGG]----3'WT sub2----[GTCT]----3'WT sub3----[CCTG]----3'WT sub4----[CGTC]----3'WT+PolIII sub5----[CACC]
   AACC                   TGGG                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 0.8550 (6 overhangs)

---

### Tile 22 of 57 -- Codons 1185-1259 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCC     | 0.7958   |
| oh2 (3' boundary) | TATC     | 0.8041   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 436 nt  | AAAC  | TTCC  |
| 4   | Oligo pool      | Tile 22 (14910 oligos) | 281 nt  | TTCC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[TTCC]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   TTCC                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1    | 810 nt  | TATC  | TGGG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1641 nt | TGGG  | GTCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TATC]----3'WT sub1----[TGGG]----3'WT sub2----[GTCT]----3'WT sub3----[CCTG]----3'WT sub4----[CGTC]----3'WT+PolIII sub5----[CACC]
   TATC                   TGGG                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 0.9933 (6 overhangs)

---

### Tile 23 of 57 -- Codons 1256-1305 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGTA     | 0.7286   |
| oh2 (3' boundary) | AAGG     | 0.6552   |

**Variants:** 9660 mutations, 9660 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3  | 649 nt  | AAAC  | AGTA  |
| 4   | Oligo pool      | Tile 23 (9660 oligos) | 206 nt  | AGTA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[AGTA]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   AGTA                  AGAA 
```

**Set fidelity:** 0.9712 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1    | 672 nt  | AAGG  | TGGG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1641 nt | TGGG  | GTCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAGG]----3'WT sub1----[TGGG]----3'WT sub2----[GTCT]----3'WT sub3----[CCTG]----3'WT sub4----[CGTC]----3'WT+PolIII sub5----[CACC]
   AAGG                   TGGG                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 24 of 57 -- Codons 1302-1352 (153 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAAA     | 0.8948   |
| oh2 (3' boundary) | CCTA     | 0.6679   |

**Variants:** 9870 mutations, 9870 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3  | 787 nt  | AAAC  | CAAA  |
| 4   | Oligo pool      | Tile 24 (9870 oligos) | 209 nt  | CAAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[CAAA]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   CAAA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile24_sub1    | 531 nt  | CCTA  | TGGG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1641 nt | TGGG  | GTCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTA]----3'WT sub1----[TGGG]----3'WT sub2----[GTCT]----3'WT sub3----[CCTG]----3'WT sub4----[CGTC]----3'WT+PolIII sub5----[CACC]
   CCTA                   TGGG                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 0.8434 (6 overhangs)

---

### Tile 25 of 57 -- Codons 1349-1422 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAT     | 0.7246   |
| oh2 (3' boundary) | AGTT     | 0.6748   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3   | 928 nt  | AAAC  | GAAT  |
| 4   | Oligo pool      | Tile 25 (14700 oligos) | 278 nt  | GAAT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[GAAT]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   GAAT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile25_sub1    | 321 nt  | AGTT  | TGGG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1641 nt | TGGG  | GTCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGTT]----3'WT sub1----[TGGG]----3'WT sub2----[GTCT]----3'WT sub3----[CCTG]----3'WT sub4----[CGTC]----3'WT+PolIII sub5----[CACC]
   AGTT                   TGGG                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 26 of 57 -- Codons 1419-1477 (177 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTT     | 0.7985   |
| oh2 (3' boundary) | TGAG     | 0.6546   |

**Variants:** 11550 mutations, 11550 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3   | 1138 nt | AAAC  | TCTT  |
| 4   | Oligo pool      | Tile 26 (11550 oligos) | 233 nt  | TCTT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[TCTT]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   TCTT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile26_sub1    | 1779 nt | TGAG  | GTCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAG]----3'WT sub1----[GTCT]----3'WT sub2----[CCTG]----3'WT sub3----[CGTC]----3'WT+PolIII sub4----[CACC]
   TGAG                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 27 of 57 -- Codons 1474-1523 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAG     | 0.6752   |
| oh2 (3' boundary) | TGGG     | 0.5031   |

**Variants:** 9660 mutations, 9660 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3  | 1303 nt | AAAC  | GAAG  |
| 4   | Oligo pool      | Tile 27 (9660 oligos) | 206 nt  | GAAG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[GAAG]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   GAAG                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1641 nt | TGGG  | GTCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGGG]----3'WT sub1----[GTCT]----3'WT sub2----[CCTG]----3'WT sub3----[CGTC]----3'WT+PolIII sub4----[CACC]
   TGGG                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 28 of 57 -- Codons 1524-1588 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GATT     | 0.6417   |
| oh2 (3' boundary) | GGAG     | 0.5228   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1453 nt | AAAC  | GATT  |
| 4   | Oligo pool      | Tile 28 (12810 oligos) | 251 nt  | GATT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[GATT]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   GATT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile28_sub1    | 1446 nt | GGAG  | GTCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAG]----3'WT sub1----[GTCT]----3'WT sub2----[CCTG]----3'WT sub3----[CGTC]----3'WT+PolIII sub4----[CACC]
   GGAG                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 29 of 57 -- Codons 1585-1639 (165 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CATA     | 0.7540   |
| oh2 (3' boundary) | ACGG     | 0.4986   |

**Variants:** 10710 mutations, 10710 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile29_sub3   | 1636 nt | AAAC  | CATA  |
| 4   | Oligo pool      | Tile 29 (10710 oligos) | 221 nt  | CATA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[CATA]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   CATA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile29_sub1    | 1293 nt | ACGG  | GTCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACGG]----3'WT sub1----[GTCT]----3'WT sub2----[CCTG]----3'WT sub3----[CGTC]----3'WT+PolIII sub4----[CACC]
   ACGG                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 30 of 57 -- Codons 1636-1702 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GATA     | 0.7029   |
| oh2 (3' boundary) | AGCG     | 0.4197   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3   | 1449 nt | AAAC  | TGGG  |
| 4   | 5'WT gene block | bsai_5wt_tile30_sub4   | 358 nt  | TGGG  | GATA  |
| 5   | Oligo pool      | Tile 30 (13230 oligos) | 257 nt  | GATA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[TGGG]----5'WT sub4----[GATA]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   TGGG                   GATA                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile30_sub1    | 1104 nt | AGCG  | GTCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGCG]----3'WT sub1----[GTCT]----3'WT sub2----[CCTG]----3'WT sub3----[CGTC]----3'WT+PolIII sub4----[CACC]
   AGCG                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 31 of 57 -- Codons 1699-1734 (108 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CGGA     | 0.6609   |
| oh2 (3' boundary) | CTCT     | 0.6347   |

**Variants:** 6720 mutations, 6720 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3  | 1449 nt | AAAC  | TGGG  |
| 4   | 5'WT gene block | bsai_5wt_tile31_sub4  | 547 nt  | TGGG  | CGGA  |
| 5   | Oligo pool      | Tile 31 (6720 oligos) | 164 nt  | CGGA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[TGGG]----5'WT sub4----[CGGA]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   TGGG                   CGGA                  AGAA 
```

**Set fidelity:** 0.9974 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile31_sub1    | 1008 nt | CTCT  | GTCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTCT]----3'WT sub1----[GTCT]----3'WT sub2----[CCTG]----3'WT sub3----[CGTC]----3'WT+PolIII sub4----[CACC]
   CTCT                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 0.9638 (5 overhangs)

---

### Tile 32 of 57 -- Codons 1731-1805 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCA     | 0.8824   |
| oh2 (3' boundary) | GAGC     | 0.5446   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3   | 1449 nt | AAAC  | TGGG  |
| 4   | 5'WT gene block | bsai_5wt_tile32_sub4   | 643 nt  | TGGG  | TTCA  |
| 5   | Oligo pool      | Tile 32 (14910 oligos) | 281 nt  | TTCA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[TGGG]----5'WT sub4----[TTCA]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   TGGG                   TTCA                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile32_sub1    | 795 nt  | GAGC  | GTCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAGC]----3'WT sub1----[GTCT]----3'WT sub2----[CCTG]----3'WT sub3----[CGTC]----3'WT+PolIII sub4----[CACC]
   GAGC                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 33 of 57 -- Codons 1802-1843 (126 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | ATCC     | 0.6015   |

**Variants:** 7980 mutations, 7980 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3  | 1449 nt | AAAC  | TGGG  |
| 4   | 5'WT gene block | bsai_5wt_tile33_sub4  | 856 nt  | TGGG  | AAGA  |
| 5   | Oligo pool      | Tile 33 (7980 oligos) | 182 nt  | AAGA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[TGGG]----5'WT sub4----[AAGA]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   TGGG                   AAGA                  AGAA 
```

**Set fidelity:** 0.9574 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile33_sub1    | 681 nt  | ATCC  | GTCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATCC]----3'WT sub1----[GTCT]----3'WT sub2----[CCTG]----3'WT sub3----[CGTC]----3'WT+PolIII sub4----[CACC]
   ATCC                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 0.9980 (5 overhangs)

---

### Tile 34 of 57 -- Codons 1840-1895 (168 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGCA     | 0.5690   |
| oh2 (3' boundary) | CACC     | 0.4172   |

**Variants:** 10920 mutations, 10920 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3   | 1449 nt | AAAC  | TGGG  |
| 4   | 5'WT gene block | bsai_5wt_tile34_sub4   | 970 nt  | TGGG  | AGCA  |
| 5   | Oligo pool      | Tile 34 (10920 oligos) | 224 nt  | AGCA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[TGGG]----5'WT sub4----[AGCA]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   TGGG                   AGCA                  AGAA 
```

**Set fidelity:** 0.9812 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile34_sub1    | 525 nt  | CACC  | GTCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CACC]----3'WT sub1----[GTCT]----3'WT sub2----[CCTG]----3'WT sub3----[CGTC]----3'WT+PolIII sub4----[CACC]
   CACC                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 35 of 57 -- Codons 1892-1956 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTC     | 0.8105   |
| oh2 (3' boundary) | GGAA     | 0.7463   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3   | 1449 nt | AAAC  | TGGG  |
| 4   | 5'WT gene block | bsai_5wt_tile35_sub4   | 1126 nt | TGGG  | TCTC  |
| 5   | Oligo pool      | Tile 35 (12810 oligos) | 251 nt  | TCTC  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[TGGG]----5'WT sub4----[TCTC]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   TGGG                   TCTC                  AGAA 
```

**Set fidelity:** 0.9969 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile35_sub1    | 342 nt  | GGAA  | GTCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAA]----3'WT sub1----[GTCT]----3'WT sub2----[CCTG]----3'WT sub3----[CGTC]----3'WT+PolIII sub4----[CACC]
   GGAA                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 36 of 57 -- Codons 1953-1998 (138 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCT     | 0.7573   |
| oh2 (3' boundary) | AGAT     | 0.6825   |

**Variants:** 8820 mutations, 8820 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3  | 1449 nt | AAAC  | TGGG  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4  | 1309 nt | TGGG  | TCCT  |
| 5   | Oligo pool      | Tile 36 (8820 oligos) | 194 nt  | TCCT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[TGGG]----5'WT sub4----[TCCT]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   TGGG                   TCCT                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile36_sub1    | 216 nt  | AGAT  | GTCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAT]----3'WT sub1----[GTCT]----3'WT sub2----[CCTG]----3'WT sub3----[CGTC]----3'WT+PolIII sub4----[CACC]
   AGAT                   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 37 of 57 -- Codons 1995-2064 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACA     | 0.8652   |
| oh2 (3' boundary) | GTCT     | 0.5601   |

**Variants:** 13860 mutations, 13860 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3   | 1449 nt | AAAC  | TGGG  |
| 4   | 5'WT gene block | bsai_5wt_tile37_sub4   | 1435 nt | TGGG  | TACA  |
| 5   | Oligo pool      | Tile 37 (13860 oligos) | 266 nt  | TACA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[TGGG]----5'WT sub4----[TACA]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   TGGG                   TACA                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | GTCT  | CCTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GTCT]----3'WT sub1----[CCTG]----3'WT sub2----[CGTC]----3'WT+PolIII sub3----[CACC]
   GTCT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 38 of 57 -- Codons 2065-2130 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAC     | 0.6694   |
| oh2 (3' boundary) | AGTC     | 0.5938   |

**Variants:** 13020 mutations, 13020 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3   | 1449 nt | AAAC  | TGGG  |
| 4   | 5'WT gene block | bsai_5wt_tile38_sub4   | 1645 nt | TGGG  | AAAC  |
| 5   | Oligo pool      | Tile 38 (13020 oligos) | 254 nt  | AAAC  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[TGGG]----5'WT sub4----[AAAC]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   TGGG                   AAAC                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile38_sub1    | 1449 nt | AGTC  | CCTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGTC]----3'WT sub1----[CCTG]----3'WT sub2----[CGTC]----3'WT+PolIII sub3----[CACC]
   AGTC                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 0.8457 (4 overhangs)

---

### Tile 39 of 57 -- Codons 2127-2191 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAT     | 0.7246   |
| oh2 (3' boundary) | CGTC     | 0.5136   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3   | 1449 nt | AAAC  | TGGG  |
| 4   | 5'WT gene block | bsai_5wt_tile39_sub4   | 1641 nt | TGGG  | GTCT  |
| 5   | 5'WT gene block | bsai_5wt_tile39_sub5   | 208 nt  | GTCT  | GAAT  |
| 6   | Oligo pool      | Tile 39 (12810 oligos) | 251 nt  | GAAT  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[TGGG]----5'WT sub4----[GTCT]----5'WT sub5----[GAAT]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   TGGG                   GTCT                   GAAT                  AGAA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile39_sub1    | 1266 nt | CGTC  | CCTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CGTC]----3'WT sub1----[CCTG]----3'WT sub2----[CGTC]----3'WT+PolIII sub3----[CACC]
   CGTC                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 40 of 57 -- Codons 2188-2218 (93 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCT     | 0.7151   |
| oh2 (3' boundary) | TTGC     | 0.7336   |

**Variants:** 5670 mutations, 5670 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3  | 1449 nt | AAAC  | TGGG  |
| 4   | 5'WT gene block | bsai_5wt_tile39_sub4  | 1641 nt | TGGG  | GTCT  |
| 5   | 5'WT gene block | bsai_5wt_tile40_sub5  | 391 nt  | GTCT  | ATCT  |
| 6   | Oligo pool      | Tile 40 (5670 oligos) | 149 nt  | ATCT  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[TGGG]----5'WT sub4----[GTCT]----5'WT sub5----[ATCT]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   TGGG                   GTCT                   ATCT                  AGAA 
```

**Set fidelity:** 0.8547 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile40_sub1    | 1185 nt | TTGC  | CCTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTGC]----3'WT sub1----[CCTG]----3'WT sub2----[CGTC]----3'WT+PolIII sub3----[CACC]
   TTGC                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 41 of 57 -- Codons 2215-2257 (129 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | AACT     | 0.6635   |

**Variants:** 8190 mutations, 8190 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3  | 1449 nt | AAAC  | TGGG  |
| 4   | 5'WT gene block | bsai_5wt_tile39_sub4  | 1641 nt | TGGG  | GTCT  |
| 5   | 5'WT gene block | bsai_5wt_tile41_sub5  | 472 nt  | GTCT  | AAGA  |
| 6   | Oligo pool      | Tile 41 (8190 oligos) | 185 nt  | AAGA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[TGGG]----5'WT sub4----[GTCT]----5'WT sub5----[AAGA]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   TGGG                   GTCT                   AAGA                  AGAA 
```

**Set fidelity:** 0.9574 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile41_sub1    | 1068 nt | AACT  | CCTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AACT]----3'WT sub1----[CCTG]----3'WT sub2----[CGTC]----3'WT+PolIII sub3----[CACC]
   AACT                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 42 of 57 -- Codons 2254-2284 (93 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTA     | 0.8892   |
| oh2 (3' boundary) | GAGG     | 0.5599   |

**Variants:** 5670 mutations, 5670 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3  | 1449 nt | AAAC  | TGGG  |
| 4   | 5'WT gene block | bsai_5wt_tile39_sub4  | 1641 nt | TGGG  | GTCT  |
| 5   | 5'WT gene block | bsai_5wt_tile42_sub5  | 589 nt  | GTCT  | TCTA  |
| 6   | Oligo pool      | Tile 42 (5670 oligos) | 149 nt  | TCTA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[TGGG]----5'WT sub4----[GTCT]----5'WT sub5----[TCTA]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   TGGG                   GTCT                   TCTA                  AGAA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile42_sub1    | 987 nt  | GAGG  | CCTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAGG]----3'WT sub1----[CCTG]----3'WT sub2----[CGTC]----3'WT+PolIII sub3----[CACC]
   GAGG                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 43 of 57 -- Codons 2281-2343 (189 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACAT     | 0.6621   |
| oh2 (3' boundary) | ACAC     | 0.5629   |

**Variants:** 12390 mutations, 12390 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3   | 1449 nt | AAAC  | TGGG  |
| 4   | 5'WT gene block | bsai_5wt_tile39_sub4   | 1641 nt | TGGG  | GTCT  |
| 5   | 5'WT gene block | bsai_5wt_tile43_sub5   | 670 nt  | GTCT  | ACAT  |
| 6   | Oligo pool      | Tile 43 (12390 oligos) | 245 nt  | ACAT  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[TGGG]----5'WT sub4----[GTCT]----5'WT sub5----[ACAT]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   TGGG                   GTCT                   ACAT                  AGAA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile43_sub1    | 810 nt  | ACAC  | CCTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACAC]----3'WT sub1----[CCTG]----3'WT sub2----[CGTC]----3'WT+PolIII sub3----[CACC]
   ACAC                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 44 of 57 -- Codons 2340-2411 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CGGA     | 0.6609   |
| oh2 (3' boundary) | GCTG     | 0.4520   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3   | 1449 nt | AAAC  | TGGG  |
| 4   | 5'WT gene block | bsai_5wt_tile39_sub4   | 1641 nt | TGGG  | GTCT  |
| 5   | 5'WT gene block | bsai_5wt_tile44_sub5   | 847 nt  | GTCT  | CGGA  |
| 6   | Oligo pool      | Tile 44 (14280 oligos) | 272 nt  | CGGA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[TGGG]----5'WT sub4----[GTCT]----5'WT sub5----[CGGA]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   TGGG                   GTCT                   CGGA                  AGAA 
```

**Set fidelity:** 0.9974 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile44_sub1    | 606 nt  | GCTG  | CCTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCTG]----3'WT sub1----[CCTG]----3'WT sub2----[CGTC]----3'WT+PolIII sub3----[CACC]
   GCTG                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 0.9642 (4 overhangs)

---

### Tile 45 of 57 -- Codons 2408-2473 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCGA     | 0.6442   |
| oh2 (3' boundary) | CAGC     | 0.4815   |

**Variants:** 13020 mutations, 13020 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3   | 1449 nt | AAAC  | TGGG  |
| 4   | 5'WT gene block | bsai_5wt_tile39_sub4   | 1641 nt | TGGG  | GTCT  |
| 5   | 5'WT gene block | bsai_5wt_tile45_sub5   | 1051 nt | GTCT  | CCGA  |
| 6   | Oligo pool      | Tile 45 (13020 oligos) | 254 nt  | CCGA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[TGGG]----5'WT sub4----[GTCT]----5'WT sub5----[CCGA]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   TGGG                   GTCT                   CCGA                  AGAA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile45_sub1    | 420 nt  | CAGC  | CCTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAGC]----3'WT sub1----[CCTG]----3'WT sub2----[CGTC]----3'WT+PolIII sub3----[CACC]
   CAGC                   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 0.9358 (4 overhangs)

---

### Tile 46 of 57 -- Codons 2470-2546 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGG     | 0.6552   |
| oh2 (3' boundary) | CAGT     | 0.6512   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3   | 1449 nt | AAAC  | TGGG  |
| 4   | 5'WT gene block | bsai_5wt_tile39_sub4   | 1641 nt | TGGG  | GTCT  |
| 5   | 5'WT gene block | bsai_5wt_tile46_sub5   | 1237 nt | GTCT  | AAGG  |
| 6   | Oligo pool      | Tile 46 (15330 oligos) | 287 nt  | AAGG  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[TGGG]----5'WT sub4----[GTCT]----5'WT sub5----[AAGG]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   TGGG                   GTCT                   AAGG                  AGAA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile46_sub1    | 1548 nt | CAGT  | CGTC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAGT]----3'WT sub1----[CGTC]----3'WT+PolIII sub2----[CACC]
   CAGT                   CGTC                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 47 of 57 -- Codons 2543-2607 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AACG     | 0.5566   |
| oh2 (3' boundary) | CCTG     | 0.6383   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3   | 1449 nt | AAAC  | TGGG  |
| 4   | 5'WT gene block | bsai_5wt_tile39_sub4   | 1641 nt | TGGG  | GTCT  |
| 5   | 5'WT gene block | bsai_5wt_tile47_sub5   | 1456 nt | GTCT  | AACG  |
| 6   | Oligo pool      | Tile 47 (12810 oligos) | 251 nt  | AACG  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[TGGG]----5'WT sub4----[GTCT]----5'WT sub5----[AACG]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   TGGG                   GTCT                   AACG                  AGAA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1365 nt | CCTG  | CGTC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTG]----3'WT sub1----[CGTC]----3'WT+PolIII sub2----[CACC]
   CCTG                   CGTC                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 48 of 57 -- Codons 2608-2642 (105 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGCT     | 0.4697   |
| oh2 (3' boundary) | AGAT     | 0.6825   |

**Variants:** 6510 mutations, 6510 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3  | 1449 nt | AAAC  | TGGG  |
| 4   | 5'WT gene block | bsai_5wt_tile39_sub4  | 1641 nt | TGGG  | GTCT  |
| 5   | 5'WT gene block | bsai_5wt_tile48_sub5  | 1651 nt | GTCT  | GGCT  |
| 6   | Oligo pool      | Tile 48 (6510 oligos) | 161 nt  | GGCT  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[TGGG]----5'WT sub4----[GTCT]----5'WT sub5----[GGCT]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   TGGG                   GTCT                   GGCT                  AGAA 
```

**Set fidelity:** 0.8807 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile48_sub1    | 1260 nt | AGAT  | CGTC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAT]----3'WT sub1----[CGTC]----3'WT+PolIII sub2----[CACC]
   AGAT                   CGTC                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 49 of 57 -- Codons 2639-2689 (153 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGGA     | 0.7515   |
| oh2 (3' boundary) | TGAG     | 0.6546   |

**Variants:** 9870 mutations, 9870 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3  | 1449 nt | AAAC  | TGGG  |
| 4   | 5'WT gene block | bsai_5wt_tile39_sub4  | 1641 nt | TGGG  | GTCT  |
| 5   | 5'WT gene block | bsai_5wt_tile49_sub5  | 1744 nt | GTCT  | AGGA  |
| 6   | Oligo pool      | Tile 49 (9870 oligos) | 209 nt  | AGGA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[TGGG]----5'WT sub4----[GTCT]----5'WT sub5----[AGGA]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   TGGG                   GTCT                   AGGA                  AGAA 
```

**Set fidelity:** 0.9656 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile49_sub1    | 1119 nt | TGAG  | CGTC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAG]----3'WT sub1----[CGTC]----3'WT+PolIII sub2----[CACC]
   TGAG                   CGTC                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 50 of 57 -- Codons 2686-2729 (132 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAT     | 0.7246   |
| oh2 (3' boundary) | CAGC     | 0.4815   |

**Variants:** 8400 mutations, 8400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3  | 1449 nt | AAAC  | TGGG  |
| 4   | 5'WT gene block | bsai_5wt_tile39_sub4  | 1641 nt | TGGG  | GTCT  |
| 5   | 5'WT gene block | bsai_5wt_tile50_sub5  | 1647 nt | GTCT  | CCTG  |
| 6   | 5'WT gene block | bsai_5wt_tile50_sub6  | 256 nt  | CCTG  | GAAT  |
| 7   | Oligo pool      | Tile 50 (8400 oligos) | 188 nt  | GAAT  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[TGGG]----5'WT sub4----[GTCT]----5'WT sub5----[CCTG]----5'WT sub6----[GAAT]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   TGGG                   GTCT                   CCTG                   GAAT                  AGAA 
```

**Set fidelity:** 1.0000 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile50_sub1    | 999 nt  | CAGC  | CGTC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAGC]----3'WT sub1----[CGTC]----3'WT+PolIII sub2----[CACC]
   CAGC                   CGTC                          CACC 
```

**Set fidelity:** 0.9358 (3 overhangs)

---

### Tile 51 of 57 -- Codons 2726-2767 (126 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTGA     | 0.8853   |
| oh2 (3' boundary) | GTCG     | 0.4866   |

**Variants:** 7980 mutations, 7980 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3  | 1449 nt | AAAC  | TGGG  |
| 4   | 5'WT gene block | bsai_5wt_tile39_sub4  | 1641 nt | TGGG  | GTCT  |
| 5   | 5'WT gene block | bsai_5wt_tile50_sub5  | 1647 nt | GTCT  | CCTG  |
| 6   | 5'WT gene block | bsai_5wt_tile51_sub6  | 376 nt  | CCTG  | TTGA  |
| 7   | Oligo pool      | Tile 51 (7980 oligos) | 182 nt  | TTGA  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[TGGG]----5'WT sub4----[GTCT]----5'WT sub5----[CCTG]----5'WT sub6----[TTGA]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   TGGG                   GTCT                   CCTG                   TTGA                  AGAA 
```

**Set fidelity:** 0.9643 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile51_sub1    | 885 nt  | GTCG  | CGTC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GTCG]----3'WT sub1----[CGTC]----3'WT+PolIII sub2----[CACC]
   GTCG                   CGTC                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 52 of 57 -- Codons 2764-2814 (153 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GACA     | 0.6127   |
| oh2 (3' boundary) | AACC     | 0.5451   |

**Variants:** 9870 mutations, 9870 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3  | 1449 nt | AAAC  | TGGG  |
| 4   | 5'WT gene block | bsai_5wt_tile39_sub4  | 1641 nt | TGGG  | GTCT  |
| 5   | 5'WT gene block | bsai_5wt_tile50_sub5  | 1647 nt | GTCT  | CCTG  |
| 6   | 5'WT gene block | bsai_5wt_tile52_sub6  | 490 nt  | CCTG  | GACA  |
| 7   | Oligo pool      | Tile 52 (9870 oligos) | 209 nt  | GACA  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[TGGG]----5'WT sub4----[GTCT]----5'WT sub5----[CCTG]----5'WT sub6----[GACA]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   TGGG                   GTCT                   CCTG                   GACA                  AGAA 
```

**Set fidelity:** 1.0000 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile52_sub1    | 744 nt  | AACC  | CGTC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AACC]----3'WT sub1----[CGTC]----3'WT+PolIII sub2----[CACC]
   AACC                   CGTC                          CACC 
```

**Set fidelity:** 0.8550 (3 overhangs)

---

### Tile 53 of 57 -- Codons 2811-2859 (147 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | CACC     | 0.4172   |

**Variants:** 9450 mutations, 9450 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3  | 1449 nt | AAAC  | TGGG  |
| 4   | 5'WT gene block | bsai_5wt_tile39_sub4  | 1641 nt | TGGG  | GTCT  |
| 5   | 5'WT gene block | bsai_5wt_tile50_sub5  | 1647 nt | GTCT  | CCTG  |
| 6   | 5'WT gene block | bsai_5wt_tile53_sub6  | 631 nt  | CCTG  | AAGA  |
| 7   | Oligo pool      | Tile 53 (9450 oligos) | 203 nt  | AAGA  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[TGGG]----5'WT sub4----[GTCT]----5'WT sub5----[CCTG]----5'WT sub6----[AAGA]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   TGGG                   GTCT                   CCTG                   AAGA                  AGAA 
```

**Set fidelity:** 0.9574 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile53_sub1    | 609 nt  | CACC  | CGTC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CACC]----3'WT sub1----[CGTC]----3'WT+PolIII sub2----[CACC]
   CACC                   CGTC                          CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 54 of 57 -- Codons 2856-2921 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTCG     | 0.7252   |
| oh2 (3' boundary) | TGAG     | 0.6546   |

**Variants:** 13020 mutations, 13020 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3   | 1449 nt | AAAC  | TGGG  |
| 4   | 5'WT gene block | bsai_5wt_tile39_sub4   | 1641 nt | TGGG  | GTCT  |
| 5   | 5'WT gene block | bsai_5wt_tile50_sub5   | 1647 nt | GTCT  | CCTG  |
| 6   | 5'WT gene block | bsai_5wt_tile54_sub6   | 766 nt  | CCTG  | CTCG  |
| 7   | Oligo pool      | Tile 54 (13020 oligos) | 254 nt  | CTCG  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[TGGG]----5'WT sub4----[GTCT]----5'WT sub5----[CCTG]----5'WT sub6----[CTCG]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   TGGG                   GTCT                   CCTG                   CTCG                  AGAA 
```

**Set fidelity:** 0.9978 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile54_sub1    | 423 nt  | TGAG  | CGTC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAG]----3'WT sub1----[CGTC]----3'WT+PolIII sub2----[CACC]
   TGAG                   CGTC                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 55 of 57 -- Codons 2918-2995 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCTG     | 0.6383   |
| oh2 (3' boundary) | AGAA     | 0.8847   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3   | 1449 nt | AAAC  | TGGG  |
| 4   | 5'WT gene block | bsai_5wt_tile39_sub4   | 1641 nt | TGGG  | GTCT  |
| 5   | 5'WT gene block | bsai_5wt_tile50_sub5   | 1647 nt | GTCT  | CCTG  |
| 6   | 5'WT gene block | bsai_5wt_tile55_sub6   | 952 nt  | CCTG  | CCTG  |
| 7   | Oligo pool      | Tile 55 (15540 oligos) | 290 nt  | CCTG  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[TGGG]----5'WT sub4----[GTCT]----5'WT sub5----[CCTG]----5'WT sub6----[CCTG]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   TGGG                   GTCT                   CCTG                   CCTG                  AGAA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile55_sub1    | 1421 nt | AGAA  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAA]----3'WT+PolIII----[CACC]
   AGAA                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 56 of 57 -- Codons 2992-3056 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCC     | 0.7958   |
| oh2 (3' boundary) | CGTC     | 0.5136   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3   | 1449 nt | AAAC  | TGGG  |
| 4   | 5'WT gene block | bsai_5wt_tile39_sub4   | 1641 nt | TGGG  | GTCT  |
| 5   | 5'WT gene block | bsai_5wt_tile50_sub5   | 1647 nt | GTCT  | CCTG  |
| 6   | 5'WT gene block | bsai_5wt_tile56_sub6   | 1174 nt | CCTG  | TTCC  |
| 7   | Oligo pool      | Tile 56 (12810 oligos) | 251 nt  | TTCC  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[TGGG]----5'WT sub4----[GTCT]----5'WT sub5----[CCTG]----5'WT sub6----[TTCC]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   TGGG                   GTCT                   CCTG                   TTCC                  AGAA 
```

**Set fidelity:** 1.0000 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1238 nt | CGTC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CGTC]----3'WT+PolIII----[CACC]
   CGTC                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 57 of 57 -- Codons 3057-3098 (126 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGCA     | 0.5690   |
| oh2 (3' boundary) | TTGA     | 0.8853   |

**Variants:** 7980 mutations, 7980 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1484 nt | ATGA  | TATC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1686 nt | TATC  | AAAC  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3  | 1449 nt | AAAC  | TGGG  |
| 4   | 5'WT gene block | bsai_5wt_tile39_sub4  | 1641 nt | TGGG  | GTCT  |
| 5   | 5'WT gene block | bsai_5wt_tile50_sub5  | 1647 nt | GTCT  | CCTG  |
| 6   | 5'WT gene block | bsai_5wt_tile57_sub6  | 1369 nt | CCTG  | AGCA  |
| 7   | Oligo pool      | Tile 57 (7980 oligos) | 182 nt  | AGCA  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATC]----5'WT sub2----[AAAC]----5'WT sub3----[TGGG]----5'WT sub4----[GTCT]----5'WT sub5----[CCTG]----5'WT sub6----[AGCA]----oligo+BC----[AGAA]
   ATGA                   TATC                   AAAC                   TGGG                   GTCT                   CCTG                   AGCA                  AGAA 
```

**Set fidelity:** 0.9812 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component            | Part name                | Length  | 5' OH | 3' OH |
| --- | -------------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product         | (in helper plasmid)      | --      | --    | --    |
| 2   | PolIII-only fragment | bsmbi_polIII_tile57      | 1112 nt | TTGA  | CACC  |
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

**Total blocks:** 118

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| --------------------- | ----------- | ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10_sub1  | 1578        | BsaI        | 5wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile11_sub1  | 1728        | BsaI        | 5wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile12_sub1  | 1484        | BsaI        | 5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1;5wt_tile26_sub1;5wt_tile27_sub1;5wt_tile28_sub1;5wt_tile29_sub1;5wt_tile30_sub1;5wt_tile31_sub1;5wt_tile32_sub1;5wt_tile33_sub1;5wt_tile34_sub1;5wt_tile35_sub1;5wt_tile36_sub1;5wt_tile37_sub1;5wt_tile38_sub1;5wt_tile39_sub1;5wt_tile40_sub1;5wt_tile41_sub1;5wt_tile42_sub1;5wt_tile43_sub1;5wt_tile44_sub1;5wt_tile45_sub1;5wt_tile46_sub1;5wt_tile47_sub1;5wt_tile48_sub1;5wt_tile49_sub1;5wt_tile50_sub1;5wt_tile51_sub1;5wt_tile52_sub1;5wt_tile53_sub1;5wt_tile54_sub1;5wt_tile55_sub1;5wt_tile56_sub1;5wt_tile57_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile12_sub2  | 382         | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile13_sub2  | 568         | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile14_sub2  | 778         | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile15_sub2  | 961         | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile16_sub2  | 1072        | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile17_sub2  | 1156        | BsaI        | 5wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile18_sub2  | 1342        | BsaI        | 5wt_tile18_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile19_sub2  | 1531        | BsaI        | 5wt_tile19_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile2        | 213         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile20_sub2  | 1690        | BsaI        | 5wt_tile20_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile21_sub2  | 1686        | BsaI        | 5wt_tile21_sub2;5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2;5wt_tile26_sub2;5wt_tile27_sub2;5wt_tile28_sub2;5wt_tile29_sub2;5wt_tile30_sub2;5wt_tile31_sub2;5wt_tile32_sub2;5wt_tile33_sub2;5wt_tile34_sub2;5wt_tile35_sub2;5wt_tile36_sub2;5wt_tile37_sub2;5wt_tile38_sub2;5wt_tile39_sub2;5wt_tile40_sub2;5wt_tile41_sub2;5wt_tile42_sub2;5wt_tile43_sub2;5wt_tile44_sub2;5wt_tile45_sub2;5wt_tile46_sub2;5wt_tile47_sub2;5wt_tile48_sub2;5wt_tile49_sub2;5wt_tile50_sub2;5wt_tile51_sub2;5wt_tile52_sub2;5wt_tile53_sub2;5wt_tile54_sub2;5wt_tile55_sub2;5wt_tile56_sub2;5wt_tile57_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile21_sub3  | 217         | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile22_sub3  | 436         | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile23_sub3  | 649         | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile24_sub3  | 787         | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile25_sub3  | 928         | BsaI        | 5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile26_sub3  | 1138        | BsaI        | 5wt_tile26_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile27_sub3  | 1303        | BsaI        | 5wt_tile27_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile28_sub3  | 1453        | BsaI        | 5wt_tile28_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile29_sub3  | 1636        | BsaI        | 5wt_tile29_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile3        | 330         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile30_sub3  | 1449        | BsaI        | 5wt_tile30_sub3;5wt_tile31_sub3;5wt_tile32_sub3;5wt_tile33_sub3;5wt_tile34_sub3;5wt_tile35_sub3;5wt_tile36_sub3;5wt_tile37_sub3;5wt_tile38_sub3;5wt_tile39_sub3;5wt_tile40_sub3;5wt_tile41_sub3;5wt_tile42_sub3;5wt_tile43_sub3;5wt_tile44_sub3;5wt_tile45_sub3;5wt_tile46_sub3;5wt_tile47_sub3;5wt_tile48_sub3;5wt_tile49_sub3;5wt_tile50_sub3;5wt_tile51_sub3;5wt_tile52_sub3;5wt_tile53_sub3;5wt_tile54_sub3;5wt_tile55_sub3;5wt_tile56_sub3;5wt_tile57_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile30_sub4  | 358         | BsaI        | 5wt_tile30_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile31_sub4  | 547         | BsaI        | 5wt_tile31_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile32_sub4  | 643         | BsaI        | 5wt_tile32_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile33_sub4  | 856         | BsaI        | 5wt_tile33_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile34_sub4  | 970         | BsaI        | 5wt_tile34_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile35_sub4  | 1126        | BsaI        | 5wt_tile35_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile36_sub4  | 1309        | BsaI        | 5wt_tile36_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile37_sub4  | 1435        | BsaI        | 5wt_tile37_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile38_sub4  | 1645        | BsaI        | 5wt_tile38_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile39_sub4  | 1641        | BsaI        | 5wt_tile39_sub4;5wt_tile40_sub4;5wt_tile41_sub4;5wt_tile42_sub4;5wt_tile43_sub4;5wt_tile44_sub4;5wt_tile45_sub4;5wt_tile46_sub4;5wt_tile47_sub4;5wt_tile48_sub4;5wt_tile49_sub4;5wt_tile50_sub4;5wt_tile51_sub4;5wt_tile52_sub4;5wt_tile53_sub4;5wt_tile54_sub4;5wt_tile55_sub4;5wt_tile56_sub4;5wt_tile57_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile39_sub5  | 208         | BsaI        | 5wt_tile39_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile4        | 429         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile40_sub5  | 391         | BsaI        | 5wt_tile40_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile41_sub5  | 472         | BsaI        | 5wt_tile41_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile42_sub5  | 589         | BsaI        | 5wt_tile42_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile43_sub5  | 670         | BsaI        | 5wt_tile43_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile44_sub5  | 847         | BsaI        | 5wt_tile44_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile45_sub5  | 1051        | BsaI        | 5wt_tile45_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile46_sub5  | 1237        | BsaI        | 5wt_tile46_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile47_sub5  | 1456        | BsaI        | 5wt_tile47_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile48_sub5  | 1651        | BsaI        | 5wt_tile48_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile49_sub5  | 1744        | BsaI        | 5wt_tile49_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile5        | 651         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile50_sub5  | 1647        | BsaI        | 5wt_tile50_sub5;5wt_tile51_sub5;5wt_tile52_sub5;5wt_tile53_sub5;5wt_tile54_sub5;5wt_tile55_sub5;5wt_tile56_sub5;5wt_tile57_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile50_sub6  | 256         | BsaI        | 5wt_tile50_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile51_sub6  | 376         | BsaI        | 5wt_tile51_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile52_sub6  | 490         | BsaI        | 5wt_tile52_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile53_sub6  | 631         | BsaI        | 5wt_tile53_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile54_sub6  | 766         | BsaI        | 5wt_tile54_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile55_sub6  | 952         | BsaI        | 5wt_tile55_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile56_sub6  | 1174        | BsaI        | 5wt_tile56_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile57_sub6  | 1369        | BsaI        | 5wt_tile57_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile6        | 864         | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile7        | 1068        | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile8        | 1281        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile9_sub1   | 1488        | BsaI        | 5wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile1_sub1  | 1281        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile1_sub2  | 1686        | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile1_sub3  | 1449        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub2;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2;3wt_tile16_sub2;3wt_tile17_sub2;3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile1_sub4  | 1641        | BsmBI       | 3wt_tile1_sub4;3wt_tile2_sub4;3wt_tile3_sub4;3wt_tile4_sub4;3wt_tile5_sub4;3wt_tile6_sub4;3wt_tile7_sub4;3wt_tile8_sub3;3wt_tile9_sub3;3wt_tile10_sub3;3wt_tile11_sub3;3wt_tile12_sub3;3wt_tile13_sub3;3wt_tile14_sub3;3wt_tile15_sub3;3wt_tile16_sub3;3wt_tile17_sub3;3wt_tile18_sub2;3wt_tile19_sub2;3wt_tile20_sub2;3wt_tile21_sub2;3wt_tile22_sub2;3wt_tile23_sub2;3wt_tile24_sub2;3wt_tile25_sub2;3wt_tile27_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile1_sub5  | 1647        | BsmBI       | 3wt_tile1_sub5;3wt_tile2_sub5;3wt_tile3_sub5;3wt_tile4_sub5;3wt_tile5_sub5;3wt_tile6_sub5;3wt_tile7_sub5;3wt_tile8_sub4;3wt_tile9_sub4;3wt_tile10_sub4;3wt_tile11_sub4;3wt_tile12_sub4;3wt_tile13_sub4;3wt_tile14_sub4;3wt_tile15_sub4;3wt_tile16_sub4;3wt_tile17_sub4;3wt_tile18_sub3;3wt_tile19_sub3;3wt_tile20_sub3;3wt_tile21_sub3;3wt_tile22_sub3;3wt_tile23_sub3;3wt_tile24_sub3;3wt_tile25_sub3;3wt_tile26_sub2;3wt_tile27_sub2;3wt_tile28_sub2;3wt_tile29_sub2;3wt_tile30_sub2;3wt_tile31_sub2;3wt_tile32_sub2;3wt_tile33_sub2;3wt_tile34_sub2;3wt_tile35_sub2;3wt_tile36_sub2;3wt_tile37_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile1_sub6  | 1365        | BsmBI       | 3wt_tile1_sub6;3wt_tile2_sub6;3wt_tile3_sub6;3wt_tile4_sub6;3wt_tile5_sub6;3wt_tile6_sub6;3wt_tile7_sub6;3wt_tile8_sub5;3wt_tile9_sub5;3wt_tile10_sub5;3wt_tile11_sub5;3wt_tile12_sub5;3wt_tile13_sub5;3wt_tile14_sub5;3wt_tile15_sub5;3wt_tile16_sub5;3wt_tile17_sub5;3wt_tile18_sub4;3wt_tile19_sub4;3wt_tile20_sub4;3wt_tile21_sub4;3wt_tile22_sub4;3wt_tile23_sub4;3wt_tile24_sub4;3wt_tile25_sub4;3wt_tile26_sub3;3wt_tile27_sub3;3wt_tile28_sub3;3wt_tile29_sub3;3wt_tile30_sub3;3wt_tile31_sub3;3wt_tile32_sub3;3wt_tile33_sub3;3wt_tile34_sub3;3wt_tile35_sub3;3wt_tile36_sub3;3wt_tile37_sub2;3wt_tile38_sub2;3wt_tile39_sub2;3wt_tile40_sub2;3wt_tile41_sub2;3wt_tile42_sub2;3wt_tile43_sub2;3wt_tile44_sub2;3wt_tile45_sub2;3wt_tile47_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile1_sub7  | 1238        | BsmBI       | 3wt_polIII_tile1_sub7;3wt_polIII_tile2_sub7;3wt_polIII_tile3_sub7;3wt_polIII_tile4_sub7;3wt_polIII_tile5_sub7;3wt_polIII_tile6_sub7;3wt_polIII_tile7_sub7;3wt_polIII_tile8_sub6;3wt_polIII_tile9_sub6;3wt_polIII_tile10_sub6;3wt_polIII_tile11_sub6;3wt_polIII_tile12_sub6;3wt_polIII_tile13_sub6;3wt_polIII_tile14_sub6;3wt_polIII_tile15_sub6;3wt_polIII_tile16_sub6;3wt_polIII_tile17_sub6;3wt_polIII_tile18_sub5;3wt_polIII_tile19_sub5;3wt_polIII_tile20_sub5;3wt_polIII_tile21_sub5;3wt_polIII_tile22_sub5;3wt_polIII_tile23_sub5;3wt_polIII_tile24_sub5;3wt_polIII_tile25_sub5;3wt_polIII_tile26_sub4;3wt_polIII_tile27_sub4;3wt_polIII_tile28_sub4;3wt_polIII_tile29_sub4;3wt_polIII_tile30_sub4;3wt_polIII_tile31_sub4;3wt_polIII_tile32_sub4;3wt_polIII_tile33_sub4;3wt_polIII_tile34_sub4;3wt_polIII_tile35_sub4;3wt_polIII_tile36_sub4;3wt_polIII_tile37_sub3;3wt_polIII_tile38_sub3;3wt_polIII_tile39_sub3;3wt_polIII_tile40_sub3;3wt_polIII_tile41_sub3;3wt_polIII_tile42_sub3;3wt_polIII_tile43_sub3;3wt_polIII_tile44_sub3;3wt_polIII_tile45_sub3;3wt_polIII_tile46_sub2;3wt_polIII_tile47_sub2;3wt_polIII_tile48_sub2;3wt_polIII_tile49_sub2;3wt_polIII_tile50_sub2;3wt_polIII_tile51_sub2;3wt_polIII_tile52_sub2;3wt_polIII_tile53_sub2;3wt_polIII_tile54_sub2;3wt_polIII_tile56 |
| bsmbi_3wt_tile10_sub1 | 1434        | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile11_sub1 | 1314        | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile12_sub1 | 1128        | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile13_sub1 | 918         | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile14_sub1 | 735         | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile15_sub1 | 624         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile16_sub1 | 540         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile17_sub1 | 354         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile18_sub1 | 1596        | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile2_sub1  | 1164        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile20_sub1 | 1242        | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile21_sub1 | 1023        | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile22_sub1 | 810         | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile23_sub1 | 672         | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile24_sub1 | 531         | BsmBI       | 3wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile25_sub1 | 321         | BsmBI       | 3wt_tile25_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile26_sub1 | 1779        | BsmBI       | 3wt_tile26_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile28_sub1 | 1446        | BsmBI       | 3wt_tile28_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile29_sub1 | 1293        | BsmBI       | 3wt_tile29_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile3_sub1  | 1065        | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile30_sub1 | 1104        | BsmBI       | 3wt_tile30_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile31_sub1 | 1008        | BsmBI       | 3wt_tile31_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile32_sub1 | 795         | BsmBI       | 3wt_tile32_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile33_sub1 | 681         | BsmBI       | 3wt_tile33_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile34_sub1 | 525         | BsmBI       | 3wt_tile34_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile35_sub1 | 342         | BsmBI       | 3wt_tile35_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile36_sub1 | 216         | BsmBI       | 3wt_tile36_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile38_sub1 | 1449        | BsmBI       | 3wt_tile38_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile39_sub1 | 1266        | BsmBI       | 3wt_tile39_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile4_sub1  | 843         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile40_sub1 | 1185        | BsmBI       | 3wt_tile40_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile41_sub1 | 1068        | BsmBI       | 3wt_tile41_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile42_sub1 | 987         | BsmBI       | 3wt_tile42_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile43_sub1 | 810         | BsmBI       | 3wt_tile43_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile44_sub1 | 606         | BsmBI       | 3wt_tile44_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile45_sub1 | 420         | BsmBI       | 3wt_tile45_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile46_sub1 | 1548        | BsmBI       | 3wt_tile46_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile48_sub1 | 1260        | BsmBI       | 3wt_tile48_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile49_sub1 | 1119        | BsmBI       | 3wt_tile49_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile5_sub1  | 630         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile50_sub1 | 999         | BsmBI       | 3wt_tile50_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile51_sub1 | 885         | BsmBI       | 3wt_tile51_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile52_sub1 | 744         | BsmBI       | 3wt_tile52_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile53_sub1 | 609         | BsmBI       | 3wt_tile53_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile54_sub1 | 423         | BsmBI       | 3wt_tile54_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile55_sub1 | 1421        | BsmBI       | 3wt_polIII_tile55_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile6_sub1  | 426         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile7_sub1  | 213         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile9_sub1  | 1584        | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_polIII_tile57   | 1112        | BsmBI       | polIII_tile57                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |

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
| barcodes_per_variant  | 10             |
| boundary_method       | oogga_two_pass |
| multi_k_search        | TRUE           |
| auto_domesticate      | TRUE           |

