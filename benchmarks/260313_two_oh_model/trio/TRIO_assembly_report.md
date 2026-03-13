# DMS-GG Assembly Report: TRIO

Generated: 2026-03-13 15:12:07
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                         |
| -------------------- | ----------------------------------------------------------------------------- |
| Gene name            | TRIO_NM_007118.4_CDS Homo sapiens triple functional domain protein (TRIO) CDS |
| CDS length           | 9294 nt (3098 codons)                                                         |
| Protein length       | 3097 aa                                                                       |
| Number of tiles      | 58                                                                            |
| Total variants       | 64470                                                                         |
| Total oligos         | 644700                                                                        |
| Oligo length range   | 116-290 nt                                                                    |
| Gene blocks to order | 121                                                                           |
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

**Total oligos:** 644700 | **Length range:** 116-290 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-69      | 13650  | 263 nt |
| 2    | 66-108    | 8190   | 185 nt |
| 3    | 105-181   | 15330  | 287 nt |
| 4    | 178-218   | 7770   | 179 nt |
| 5    | 215-264   | 9660   | 206 nt |
| 6    | 261-298   | 7140   | 170 nt |
| 7    | 295-370   | 15120  | 284 nt |
| 8    | 367-443   | 15330  | 287 nt |
| 9    | 440-492   | 10290  | 215 nt |
| 10   | 489-552   | 12600  | 248 nt |
| 11   | 553-614   | 12180  | 242 nt |
| 12   | 611-659   | 9450   | 203 nt |
| 13   | 656-713   | 11340  | 230 nt |
| 14   | 710-746   | 6930   | 167 nt |
| 15   | 743-813   | 14070  | 269 nt |
| 16   | 810-870   | 11970  | 239 nt |
| 17   | 867-927   | 11970  | 239 nt |
| 18   | 928-1005  | 15540  | 290 nt |
| 19   | 1002-1052 | 9870   | 209 nt |
| 20   | 1049-1126 | 15540  | 290 nt |
| 21   | 1123-1188 | 13020  | 254 nt |
| 22   | 1185-1259 | 14910  | 281 nt |
| 23   | 1256-1307 | 10080  | 212 nt |
| 24   | 1304-1352 | 9450   | 203 nt |
| 25   | 1349-1423 | 14910  | 281 nt |
| 26   | 1420-1454 | 6510   | 161 nt |
| 27   | 1451-1515 | 12810  | 251 nt |
| 28   | 1516-1570 | 10710  | 221 nt |
| 29   | 1567-1612 | 8820   | 194 nt |
| 30   | 1609-1678 | 13860  | 266 nt |
| 31   | 1675-1752 | 15540  | 290 nt |
| 32   | 1749-1788 | 7560   | 176 nt |
| 33   | 1785-1850 | 13020  | 254 nt |
| 34   | 1847-1895 | 9450   | 203 nt |
| 35   | 1892-1963 | 14280  | 272 nt |
| 36   | 1960-1998 | 7350   | 173 nt |
| 37   | 1995-2023 | 5250   | 143 nt |
| 38   | 2024-2061 | 7140   | 170 nt |
| 39   | 2058-2120 | 12390  | 245 nt |
| 40   | 2117-2157 | 7770   | 179 nt |
| 41   | 2154-2215 | 12180  | 242 nt |
| 42   | 2212-2257 | 8820   | 194 nt |
| 43   | 2254-2284 | 5670   | 149 nt |
| 44   | 2281-2343 | 12390  | 245 nt |
| 45   | 2340-2411 | 14280  | 272 nt |
| 46   | 2408-2468 | 11970  | 239 nt |
| 47   | 2465-2520 | 10920  | 224 nt |
| 48   | 2521-2575 | 10710  | 221 nt |
| 49   | 2572-2631 | 11760  | 236 nt |
| 50   | 2628-2700 | 14490  | 275 nt |
| 51   | 2697-2770 | 14700  | 278 nt |
| 52   | 2767-2814 | 9240   | 200 nt |
| 53   | 2811-2860 | 9660   | 206 nt |
| 54   | 2857-2933 | 15330  | 287 nt |
| 55   | 2930-3002 | 14490  | 275 nt |
| 56   | 2999-3029 | 5670   | 149 nt |
| 57   | 3026-3078 | 10290  | 215 nt |
| 58   | 3079-3098 | 3360   | 116 nt |

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
| GC content mean   | 47.8%                              |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                  | Description                                                   | Result | Detail                                                                                                                                               |
| ---------------------- | ------------------------------------------------------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths          | All oligos within synthesis length limit                      | PASS   | Range: 116-290 nt (limit: 300)                                                                                                                       |
| block_lengths          | All gene blocks within synthesis length limit                 | PASS   | Range: 171-1794 nt (limit: 1800)                                                                                                                     |
| barcode_junction_sites | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                              |
| barcode_uniqueness     | All barcodes are unique                                       | PASS   | 644700 unique / 644700 total                                                                                                                         |
| tile_coverage          | Tiles cover entire gene without gaps                          | PASS   | 9294 / 9294 nt covered                                                                                                                               |
| variant_count          | Expected number of variants generated                         | PASS   | 64470 unique variants (expected: 64470 across 3070/3096 mutable positions; 58330 missense + 3070 nonsense + 3070 wt_control; 26 position(s) skipped) |
| single_codon_change    | Each non-control variant differs by exactly one codon from WT | PASS   | 614000 / 614000 variants confirmed (WT controls excluded)                                                                                            |
| oligo_gc_content       | Oligo GC content within reasonable range (25-75%)             | FAIL   | GC range: 39.1-76.3% | 226 oligo(s) with extreme GC                                                                                                  |
| domestication_complete | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                              |
| overhang_fidelity      | Tile boundary overhangs have adequate fidelity                | FAIL   | 56 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                              |
| tile_manifests         | Per-tile assembly manifests complete                          | PASS   | 58 tile manifest(s) generated                                                                                                                        |
| helper_plasmid         | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                   |
| reaction_fidelity      | Per-reaction set-level overhang fidelity                      | FAIL   | Min set fidelity: 0.7351 across 116 reactions | 8 reaction(s) below 0.90                                                                             |
| barcode_poliii_term    | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 644700 barcode(s) contain TTTT                                                                                                                   |
| block_min_length       | All gene blocks above synthesis minimum length                | FAIL   | 7 block(s) below 300 nt minimum. Range: 171-1794 nt                                                                                                  |
| sb_overhang_collisions | Superblock boundary overhangs are unique (no collisions)      | PASS   | 12 SB boundary OH(s), all unique                                                                                                                     |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 8         | 0.9961             |
| 2    | 3        | 1.0000            | 8         | 0.9961             |
| 3    | 3        | 0.9656            | 8         | 0.9961             |
| 4    | 3        | 1.0000            | 8         | 0.7714             |
| 5    | 3        | 1.0000            | 8         | 0.9961             |
| 6    | 3        | 1.0000            | 8         | 0.9961             |
| 7    | 3        | 0.9574            | 8         | 0.9885             |
| 8    | 3        | 1.0000            | 8         | 0.9961             |
| 9    | 3        | 1.0000            | 7         | 0.9961             |
| 10   | 3        | 0.9472            | 7         | 0.9961             |
| 11   | 3        | 1.0000            | 7         | 0.9961             |
| 12   | 4        | 1.0000            | 7         | 0.9961             |
| 13   | 4        | 1.0000            | 7         | 0.9961             |
| 14   | 4        | 0.9670            | 7         | 0.9885             |
| 15   | 4        | 1.0000            | 7         | 0.7351             |
| 16   | 4        | 1.0000            | 7         | 0.9945             |
| 17   | 4        | 1.0000            | 6         | 0.9961             |
| 18   | 4        | 1.0000            | 6         | 0.9961             |
| 19   | 4        | 0.9530            | 6         | 0.9961             |
| 20   | 5        | 1.0000            | 6         | 0.9961             |
| 21   | 5        | 1.0000            | 6         | 0.8520             |
| 22   | 5        | 1.0000            | 5         | 0.9961             |
| 23   | 5        | 0.9712            | 6         | 0.9885             |
| 24   | 5        | 1.0000            | 6         | 0.9961             |
| 25   | 5        | 1.0000            | 6         | 0.9961             |
| 26   | 5        | 0.9308            | 5         | 0.9961             |
| 27   | 5        | 1.0000            | 5         | 0.9961             |
| 28   | 5        | 1.0000            | 5         | 0.9949             |
| 29   | 6        | 0.9781            | 5         | 0.9961             |
| 30   | 6        | 0.9530            | 5         | 0.9403             |
| 31   | 6        | 0.9928            | 5         | 0.9885             |
| 32   | 6        | 0.8916            | 5         | 0.9961             |
| 33   | 6        | 0.9244            | 5         | 0.9961             |
| 34   | 6        | 0.9308            | 4         | 0.9961             |
| 35   | 6        | 1.0000            | 4         | 0.9961             |
| 36   | 6        | 1.0000            | 4         | 0.9961             |
| 37   | 6        | 0.9133            | 4         | 0.9961             |
| 38   | 6        | 1.0000            | 4         | 0.9961             |
| 39   | 6        | 0.9133            | 4         | 0.9919             |
| 40   | 7        | 1.0000            | 4         | 0.9961             |
| 41   | 7        | 0.9881            | 4         | 0.9961             |
| 42   | 7        | 1.0000            | 4         | 0.9961             |
| 43   | 7        | 0.9935            | 4         | 0.9961             |
| 44   | 7        | 1.0000            | 4         | 0.9961             |
| 45   | 7        | 1.0000            | 4         | 0.9961             |
| 46   | 7        | 1.0000            | 4         | 0.9961             |
| 47   | 7        | 0.9984            | 3         | 0.9961             |
| 48   | 7        | 1.0000            | 3         | 0.9961             |
| 49   | 7        | 0.8973            | 3         | 0.9961             |
| 50   | 8        | 0.9728            | 3         | 0.9961             |
| 51   | 8        | 1.0000            | 3         | 0.9961             |
| 52   | 8        | 0.9532            | 3         | 0.8520             |
| 53   | 8        | 0.8630            | 3         | 0.9322             |
| 54   | 8        | 0.7636            | 3         | 0.9961             |
| 55   | 8        | 1.0000            | 2         | 0.9923             |
| 56   | 8        | 1.0000            | 2         | 1.0000             |
| 57   | 8        | 0.9881            | 2         | 0.9961             |
| 58   | 8        | 1.0000            | 2         | 1.0000             |

**Min:** 0.7351 | **Max:** 1.0000 | **Mean:** 0.9781

**Warning:** 8 reaction(s) below 0.90 fidelity — consider alternative split points or overhang reassignment.
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

### Tile 1 of 58 -- Codons 1-69 (207 nt)

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
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1     | 1479 nt | AGTT  | GCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1143 nt | GCAA  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | AAAT  | TAGT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1542 nt | TAGT  | CAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGTT]----3'WT sub1----[GCAA]----3'WT sub2----[AAAT]----3'WT sub3----[TAGT]----3'WT sub4----[CAGA]----3'WT sub5----[TGAC]----3'WT sub6----[TATC]----3'WT+PolIII sub7----[CACC]
   AGTT                   GCAA                   AAAT                   TAGT                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (8 overhangs)

---

### Tile 2 of 58 -- Codons 66-108 (129 nt)

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
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1     | 1362 nt | AGCC  | GCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1143 nt | GCAA  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | AAAT  | TAGT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1542 nt | TAGT  | CAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGCC]----3'WT sub1----[GCAA]----3'WT sub2----[AAAT]----3'WT sub3----[TAGT]----3'WT sub4----[CAGA]----3'WT sub5----[TGAC]----3'WT sub6----[TATC]----3'WT+PolIII sub7----[CACC]
   AGCC                   GCAA                   AAAT                   TAGT                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (8 overhangs)

---

### Tile 3 of 58 -- Codons 105-181 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGGA     | 0.7515   |
| oh2 (3' boundary) | GTCT     | 0.5601   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 330 nt | ATGA  | AGGA  |
| 2   | Oligo pool      | Tile 3 (15330 oligos) | 287 nt | AGGA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1     | 1143 nt | GTCT  | GCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1143 nt | GCAA  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | AAAT  | TAGT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1542 nt | TAGT  | CAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GTCT]----3'WT sub1----[GCAA]----3'WT sub2----[AAAT]----3'WT sub3----[TAGT]----3'WT sub4----[CAGA]----3'WT sub5----[TGAC]----3'WT sub6----[TATC]----3'WT+PolIII sub7----[CACC]
   GTCT                   GCAA                   AAAT                   TAGT                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (8 overhangs)

---

### Tile 4 of 58 -- Codons 178-218 (123 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAT     | 0.7246   |
| oh2 (3' boundary) | AGAC     | 0.5696   |

**Variants:** 7770 mutations, 7770 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 549 nt | ATGA  | GAAT  |
| 2   | Oligo pool      | Tile 4 (7770 oligos)  | 179 nt | GAAT  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1     | 1032 nt | AGAC  | GCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1143 nt | GCAA  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | AAAT  | TAGT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1542 nt | TAGT  | CAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAC]----3'WT sub1----[GCAA]----3'WT sub2----[AAAT]----3'WT sub3----[TAGT]----3'WT sub4----[CAGA]----3'WT sub5----[TGAC]----3'WT sub6----[TATC]----3'WT+PolIII sub7----[CACC]
   AGAC                   GCAA                   AAAT                   TAGT                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.7714 (8 overhangs)

---

### Tile 5 of 58 -- Codons 215-264 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | GATT     | 0.6417   |

**Variants:** 9660 mutations, 9660 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 660 nt | ATGA  | GAAA  |
| 2   | Oligo pool      | Tile 5 (9660 oligos)  | 206 nt | GAAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[GAAA]----oligo+BC----[AGAA]
   ATGA                    GAAA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1     | 894 nt  | GATT  | GCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1143 nt | GCAA  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | AAAT  | TAGT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1542 nt | TAGT  | CAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GATT]----3'WT sub1----[GCAA]----3'WT sub2----[AAAT]----3'WT sub3----[TAGT]----3'WT sub4----[CAGA]----3'WT sub5----[TGAC]----3'WT sub6----[TATC]----3'WT+PolIII sub7----[CACC]
   GATT                   GCAA                   AAAT                   TAGT                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (8 overhangs)

---

### Tile 6 of 58 -- Codons 261-298 (114 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTC     | 0.8105   |
| oh2 (3' boundary) | TGCG     | 0.4943   |

**Variants:** 7140 mutations, 7140 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 798 nt | ATGA  | TCTC  |
| 2   | Oligo pool      | Tile 6 (7140 oligos)  | 170 nt | TCTC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[TCTC]----oligo+BC----[AGAA]
   ATGA                    TCTC                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1     | 792 nt  | TGCG  | GCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1143 nt | GCAA  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | AAAT  | TAGT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1542 nt | TAGT  | CAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGCG]----3'WT sub1----[GCAA]----3'WT sub2----[AAAT]----3'WT sub3----[TAGT]----3'WT sub4----[CAGA]----3'WT sub5----[TGAC]----3'WT sub6----[TATC]----3'WT+PolIII sub7----[CACC]
   TGCG                   GCAA                   AAAT                   TAGT                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (8 overhangs)

---

### Tile 7 of 58 -- Codons 295-370 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | CCAC     | 0.5426   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 900 nt | ATGA  | AAGA  |
| 2   | Oligo pool      | Tile 7 (15120 oligos) | 284 nt | AAGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

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
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1     | 576 nt  | CCAC  | GCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1143 nt | GCAA  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | AAAT  | TAGT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1542 nt | TAGT  | CAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCAC]----3'WT sub1----[GCAA]----3'WT sub2----[AAAT]----3'WT sub3----[TAGT]----3'WT sub4----[CAGA]----3'WT sub5----[TGAC]----3'WT sub6----[TATC]----3'WT+PolIII sub7----[CACC]
   CCAC                   GCAA                   AAAT                   TAGT                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9885 (8 overhangs)

---

### Tile 8 of 58 -- Codons 367-443 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACA     | 0.8652   |
| oh2 (3' boundary) | GTCC     | 0.5806   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1116 nt | ATGA  | TACA  |
| 2   | Oligo pool      | Tile 8 (15330 oligos) | 287 nt  | TACA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT block----[TACA]----oligo+BC----[AGAA]
   ATGA                    TACA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1     | 357 nt  | GTCC  | GCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1143 nt | GCAA  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | AAAT  | TAGT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1542 nt | TAGT  | CAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GTCC]----3'WT sub1----[GCAA]----3'WT sub2----[AAAT]----3'WT sub3----[TAGT]----3'WT sub4----[CAGA]----3'WT sub5----[TGAC]----3'WT sub6----[TATC]----3'WT+PolIII sub7----[CACC]
   GTCC                   GCAA                   AAAT                   TAGT                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (8 overhangs)

---

### Tile 9 of 58 -- Codons 440-492 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CGGA     | 0.6609   |
| oh2 (3' boundary) | TCTT     | 0.7985   |

**Variants:** 10290 mutations, 10290 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1335 nt | ATGA  | CGGA  |
| 2   | Oligo pool      | Tile 9 (10290 oligos) | 215 nt  | CGGA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1     | 1335 nt | TCTT  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | AAAT  | TAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1542 nt | TAGT  | CAGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCTT]----3'WT sub1----[AAAT]----3'WT sub2----[TAGT]----3'WT sub3----[CAGA]----3'WT sub4----[TGAC]----3'WT sub5----[TATC]----3'WT+PolIII sub6----[CACC]
   TCTT                   AAAT                   TAGT                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (7 overhangs)

---

### Tile 10 of 58 -- Codons 489-552 (192 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGAA     | 0.7463   |
| oh2 (3' boundary) | GCAA     | 0.7543   |

**Variants:** 12600 mutations, 12600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1482 nt | ATGA  | GGAA  |
| 2   | Oligo pool      | Tile 10 (12600 oligos) | 248 nt  | GGAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT block----[GGAA]----oligo+BC----[AGAA]
   ATGA                    GGAA                  AGAA 
```

**Set fidelity:** 0.9472 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1    | 1155 nt | GCAA  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | AAAT  | TAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1542 nt | TAGT  | CAGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCAA]----3'WT sub1----[AAAT]----3'WT sub2----[TAGT]----3'WT sub3----[CAGA]----3'WT sub4----[TGAC]----3'WT sub5----[TATC]----3'WT+PolIII sub6----[CACC]
   GCAA                   AAAT                   TAGT                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (7 overhangs)

---

### Tile 11 of 58 -- Codons 553-614 (186 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AACA     | 0.8032   |
| oh2 (3' boundary) | ACAG     | 0.5793   |

**Variants:** 12180 mutations, 12180 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1674 nt | ATGA  | AACA  |
| 2   | Oligo pool      | Tile 11 (12180 oligos) | 242 nt  | AACA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT block----[AACA]----oligo+BC----[AGAA]
   ATGA                    AACA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1    | 969 nt  | ACAG  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | AAAT  | TAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1542 nt | TAGT  | CAGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACAG]----3'WT sub1----[AAAT]----3'WT sub2----[TAGT]----3'WT sub3----[CAGA]----3'WT sub4----[TGAC]----3'WT sub5----[TATC]----3'WT+PolIII sub6----[CACC]
   ACAG                   AAAT                   TAGT                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (7 overhangs)

---

### Tile 12 of 58 -- Codons 611-659 (147 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAG     | 0.6752   |
| oh2 (3' boundary) | TGTT     | 0.6450   |

**Variants:** 9450 mutations, 9450 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11       | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2  | 192 nt  | AACA  | GAAG  |
| 3   | Oligo pool      | Tile 12 (9450 oligos) | 203 nt  | GAAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[GAAG]----oligo+BC----[AGAA]
   ATGA                   AACA                   GAAG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1    | 834 nt  | TGTT  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | AAAT  | TAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1542 nt | TAGT  | CAGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGTT]----3'WT sub1----[AAAT]----3'WT sub2----[TAGT]----3'WT sub3----[CAGA]----3'WT sub4----[TGAC]----3'WT sub5----[TATC]----3'WT+PolIII sub6----[CACC]
   TGTT                   AAAT                   TAGT                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (7 overhangs)

---

### Tile 13 of 58 -- Codons 656-713 (174 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTC     | 0.7084   |
| oh2 (3' boundary) | GCAG     | 0.5118   |

**Variants:** 11340 mutations, 11340 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 327 nt  | AACA  | ATTC  |
| 3   | Oligo pool      | Tile 13 (11340 oligos) | 230 nt  | ATTC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[ATTC]----oligo+BC----[AGAA]
   ATGA                   AACA                   ATTC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1    | 672 nt  | GCAG  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | AAAT  | TAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1542 nt | TAGT  | CAGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCAG]----3'WT sub1----[AAAT]----3'WT sub2----[TAGT]----3'WT sub3----[CAGA]----3'WT sub4----[TGAC]----3'WT sub5----[TATC]----3'WT+PolIII sub6----[CACC]
   GCAG                   AAAT                   TAGT                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (7 overhangs)

---

### Tile 14 of 58 -- Codons 710-746 (111 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCA     | 0.7483   |
| oh2 (3' boundary) | CCAC     | 0.5426   |

**Variants:** 6930 mutations, 6930 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11       | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2  | 489 nt  | AACA  | ATCA  |
| 3   | Oligo pool      | Tile 14 (6930 oligos) | 167 nt  | ATCA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[ATCA]----oligo+BC----[AGAA]
   ATGA                   AACA                   ATCA                  AGAA 
```

**Set fidelity:** 0.9670 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1    | 573 nt  | CCAC  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | AAAT  | TAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1542 nt | TAGT  | CAGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCAC]----3'WT sub1----[AAAT]----3'WT sub2----[TAGT]----3'WT sub3----[CAGA]----3'WT sub4----[TGAC]----3'WT sub5----[TATC]----3'WT+PolIII sub6----[CACC]
   CCAC                   AAAT                   TAGT                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9885 (7 overhangs)

---

### Tile 15 of 58 -- Codons 743-813 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCT     | 0.7151   |
| oh2 (3' boundary) | CGAC     | 0.4695   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 588 nt  | AACA  | ATCT  |
| 3   | Oligo pool      | Tile 15 (14070 oligos) | 269 nt  | ATCT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[ATCT]----oligo+BC----[AGAA]
   ATGA                   AACA                   ATCT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1    | 372 nt  | CGAC  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | AAAT  | TAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1542 nt | TAGT  | CAGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CGAC]----3'WT sub1----[AAAT]----3'WT sub2----[TAGT]----3'WT sub3----[CAGA]----3'WT sub4----[TGAC]----3'WT sub5----[TATC]----3'WT+PolIII sub6----[CACC]
   CGAC                   AAAT                   TAGT                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.7351 (7 overhangs)

---

### Tile 16 of 58 -- Codons 810-870 (183 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTC     | 0.8105   |
| oh2 (3' boundary) | CATG     | 0.6046   |

**Variants:** 11970 mutations, 11970 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 789 nt  | AACA  | TCTC  |
| 3   | Oligo pool      | Tile 16 (11970 oligos) | 239 nt  | TCTC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCTC]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCTC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1    | 201 nt  | CATG  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | AAAT  | TAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1542 nt | TAGT  | CAGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CATG]----3'WT sub1----[AAAT]----3'WT sub2----[TAGT]----3'WT sub3----[CAGA]----3'WT sub4----[TGAC]----3'WT sub5----[TATC]----3'WT+PolIII sub6----[CACC]
   CATG                   AAAT                   TAGT                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9945 (7 overhangs)

---

### Tile 17 of 58 -- Codons 867-927 (183 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTGT     | 0.6476   |
| oh2 (3' boundary) | AAAT     | 0.7737   |

**Variants:** 11970 mutations, 11970 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 960 nt  | AACA  | CTGT  |
| 3   | Oligo pool      | Tile 17 (11970 oligos) | 239 nt  | CTGT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[CTGT]----oligo+BC----[AGAA]
   ATGA                   AACA                   CTGT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1    | 1794 nt | AAAT  | TAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1542 nt | TAGT  | CAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAT]----3'WT sub1----[TAGT]----3'WT sub2----[CAGA]----3'WT sub3----[TGAC]----3'WT sub4----[TATC]----3'WT+PolIII sub5----[CACC]
   AAAT                   TAGT                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (6 overhangs)

---

### Tile 18 of 58 -- Codons 928-1005 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCA     | 0.8519   |
| oh2 (3' boundary) | GCTC     | 0.5230   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1143 nt | AACA  | TCCA  |
| 3   | Oligo pool      | Tile 18 (15540 oligos) | 290 nt  | TCCA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1    | 1560 nt | GCTC  | TAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1542 nt | TAGT  | CAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCTC]----3'WT sub1----[TAGT]----3'WT sub2----[CAGA]----3'WT sub3----[TGAC]----3'WT sub4----[TATC]----3'WT+PolIII sub5----[CACC]
   GCTC                   TAGT                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (6 overhangs)

---

### Tile 19 of 58 -- Codons 1002-1052 (153 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | CGTG     | 0.5892   |

**Variants:** 9870 mutations, 9870 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11       | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1365 nt | AACA  | AAGA  |
| 3   | Oligo pool      | Tile 19 (9870 oligos) | 209 nt  | AAGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[AAGA]----oligo+BC----[AGAA]
   ATGA                   AACA                   AAGA                  AGAA 
```

**Set fidelity:** 0.9530 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1    | 1419 nt | CGTG  | TAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1542 nt | TAGT  | CAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CGTG]----3'WT sub1----[TAGT]----3'WT sub2----[CAGA]----3'WT sub3----[TGAC]----3'WT sub4----[TATC]----3'WT+PolIII sub5----[CACC]
   CGTG                   TAGT                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (6 overhangs)

---

### Tile 20 of 58 -- Codons 1049-1126 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCAA     | 0.8439   |
| oh2 (3' boundary) | GAGG     | 0.5599   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile20_sub3   | 381 nt  | TCCA  | CCAA  |
| 4   | Oligo pool      | Tile 20 (15540 oligos) | 290 nt  | CCAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[CCAA]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   CCAA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1    | 1197 nt | GAGG  | TAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1542 nt | TAGT  | CAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAGG]----3'WT sub1----[TAGT]----3'WT sub2----[CAGA]----3'WT sub3----[TGAC]----3'WT sub4----[TATC]----3'WT+PolIII sub5----[CACC]
   GAGG                   TAGT                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (6 overhangs)

---

### Tile 21 of 58 -- Codons 1123-1188 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTAT     | 0.6602   |
| oh2 (3' boundary) | AACC     | 0.5451   |

**Variants:** 13020 mutations, 13020 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3   | 603 nt  | TCCA  | GTAT  |
| 4   | Oligo pool      | Tile 21 (13020 oligos) | 254 nt  | GTAT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[GTAT]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   GTAT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1    | 1011 nt | AACC  | TAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1542 nt | TAGT  | CAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AACC]----3'WT sub1----[TAGT]----3'WT sub2----[CAGA]----3'WT sub3----[TGAC]----3'WT sub4----[TATC]----3'WT+PolIII sub5----[CACC]
   AACC                   TAGT                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.8520 (6 overhangs)

---

### Tile 22 of 58 -- Codons 1185-1259 (225 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 789 nt  | TCCA  | TTCC  |
| 4   | Oligo pool      | Tile 22 (14910 oligos) | 281 nt  | TTCC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTCC]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTCC                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1    | 798 nt  | TATC  | TAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1542 nt | TAGT  | CAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TATC]----3'WT sub1----[TAGT]----3'WT sub2----[CAGA]----3'WT sub3----[TGAC]----3'WT sub4----[TATC]----3'WT+PolIII sub5----[CACC]
   TATC                   TAGT                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (5 overhangs)

---

### Tile 23 of 58 -- Codons 1256-1307 (156 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGTA     | 0.7286   |
| oh2 (3' boundary) | CCTC     | 0.5668   |

**Variants:** 10080 mutations, 10080 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 1002 nt | TCCA  | AGTA  |
| 4   | Oligo pool      | Tile 23 (10080 oligos) | 212 nt  | AGTA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[AGTA]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   AGTA                  AGAA 
```

**Set fidelity:** 0.9712 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1    | 654 nt  | CCTC  | TAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1542 nt | TAGT  | CAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTC]----3'WT sub1----[TAGT]----3'WT sub2----[CAGA]----3'WT sub3----[TGAC]----3'WT sub4----[TATC]----3'WT+PolIII sub5----[CACC]
   CCTC                   TAGT                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9885 (6 overhangs)

---

### Tile 24 of 58 -- Codons 1304-1352 (147 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | CCTA     | 0.6679   |

**Variants:** 9450 mutations, 9450 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11       | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3  | 1146 nt | TCCA  | GAAA  |
| 4   | Oligo pool      | Tile 24 (9450 oligos) | 203 nt  | GAAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[GAAA]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   GAAA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile24_sub1    | 519 nt  | CCTA  | TAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1542 nt | TAGT  | CAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTA]----3'WT sub1----[TAGT]----3'WT sub2----[CAGA]----3'WT sub3----[TGAC]----3'WT sub4----[TATC]----3'WT+PolIII sub5----[CACC]
   CCTA                   TAGT                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (6 overhangs)

---

### Tile 25 of 58 -- Codons 1349-1423 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAT     | 0.7246   |
| oh2 (3' boundary) | TCAG     | 0.7814   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3   | 1281 nt | TCCA  | GAAT  |
| 4   | Oligo pool      | Tile 25 (14910 oligos) | 281 nt  | GAAT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[GAAT]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   GAAT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile25_sub1    | 306 nt  | TCAG  | TAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1542 nt | TAGT  | CAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAG]----3'WT sub1----[TAGT]----3'WT sub2----[CAGA]----3'WT sub3----[TGAC]----3'WT sub4----[TATC]----3'WT+PolIII sub5----[CACC]
   TCAG                   TAGT                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (6 overhangs)

---

### Tile 26 of 58 -- Codons 1420-1454 (105 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCT     | 0.7573   |
| oh2 (3' boundary) | GCTC     | 0.5230   |

**Variants:** 6510 mutations, 6510 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11       | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3  | 1494 nt | TCCA  | TCCT  |
| 4   | Oligo pool      | Tile 26 (6510 oligos) | 161 nt  | TCCT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TCCT]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TCCT                  AGAA 
```

**Set fidelity:** 0.9308 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile26_sub1    | 1737 nt | GCTC  | CAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCTC]----3'WT sub1----[CAGA]----3'WT sub2----[TGAC]----3'WT sub3----[TATC]----3'WT+PolIII sub4----[CACC]
   GCTC                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (5 overhangs)

---

### Tile 27 of 58 -- Codons 1451-1515 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAG     | 0.7511   |
| oh2 (3' boundary) | TAGT     | 0.7437   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1587 nt | TCCA  | AAAG  |
| 4   | Oligo pool      | Tile 27 (12810 oligos) | 251 nt  | AAAG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[AAAG]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   AAAG                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile27_sub1    | 1554 nt | TAGT  | CAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAGT]----3'WT sub1----[CAGA]----3'WT sub2----[TGAC]----3'WT sub3----[TATC]----3'WT+PolIII sub4----[CACC]
   TAGT                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (5 overhangs)

---

### Tile 28 of 58 -- Codons 1516-1570 (165 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAG     | 0.8480   |
| oh2 (3' boundary) | TTCC     | 0.7958   |

**Variants:** 10710 mutations, 10710 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1782 nt | TCCA  | TTAG  |
| 4   | Oligo pool      | Tile 28 (10710 oligos) | 221 nt  | TTAG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile28_sub1    | 1389 nt | TTCC  | CAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCC]----3'WT sub1----[CAGA]----3'WT sub2----[TGAC]----3'WT sub3----[TATC]----3'WT+PolIII sub4----[CACC]
   TTCC                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9949 (5 overhangs)

---

### Tile 29 of 58 -- Codons 1567-1612 (138 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATA     | 0.8816   |
| oh2 (3' boundary) | ACAG     | 0.5793   |

**Variants:** 8820 mutations, 8820 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11       | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3  | 1782 nt | TCCA  | TTAG  |
| 4   | 5'WT gene block | bsai_5wt_tile29_sub4  | 171 nt  | TTAG  | AATA  |
| 5   | Oligo pool      | Tile 29 (8820 oligos) | 194 nt  | AATA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----5'WT sub4----[AATA]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                   AATA                  AGAA 
```

**Set fidelity:** 0.9781 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile29_sub1    | 1263 nt | ACAG  | CAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACAG]----3'WT sub1----[CAGA]----3'WT sub2----[TGAC]----3'WT sub3----[TATC]----3'WT+PolIII sub4----[CACC]
   ACAG                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (5 overhangs)

---

### Tile 30 of 58 -- Codons 1609-1678 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | GACC     | 0.5155   |

**Variants:** 13860 mutations, 13860 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1782 nt | TCCA  | TTAG  |
| 4   | 5'WT gene block | bsai_5wt_tile30_sub4   | 297 nt  | TTAG  | AAGA  |
| 5   | Oligo pool      | Tile 30 (13860 oligos) | 266 nt  | AAGA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----5'WT sub4----[AAGA]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                   AAGA                  AGAA 
```

**Set fidelity:** 0.9530 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile30_sub1    | 1065 nt | GACC  | CAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GACC]----3'WT sub1----[CAGA]----3'WT sub2----[TGAC]----3'WT sub3----[TATC]----3'WT+PolIII sub4----[CACC]
   GACC                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9403 (5 overhangs)

---

### Tile 31 of 58 -- Codons 1675-1752 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTGA     | 0.6791   |
| oh2 (3' boundary) | CCAC     | 0.5426   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1782 nt | TCCA  | TTAG  |
| 4   | 5'WT gene block | bsai_5wt_tile31_sub4   | 495 nt  | TTAG  | CTGA  |
| 5   | Oligo pool      | Tile 31 (15540 oligos) | 290 nt  | CTGA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----5'WT sub4----[CTGA]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                   CTGA                  AGAA 
```

**Set fidelity:** 0.9928 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile31_sub1    | 843 nt  | CCAC  | CAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCAC]----3'WT sub1----[CAGA]----3'WT sub2----[TGAC]----3'WT sub3----[TATC]----3'WT+PolIII sub4----[CACC]
   CCAC                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9885 (5 overhangs)

---

### Tile 32 of 58 -- Codons 1749-1788 (120 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCG     | 0.7234   |
| oh2 (3' boundary) | GCAC     | 0.5057   |

**Variants:** 7560 mutations, 7560 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11       | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3  | 1782 nt | TCCA  | TTAG  |
| 4   | 5'WT gene block | bsai_5wt_tile32_sub4  | 717 nt  | TTAG  | TCCG  |
| 5   | Oligo pool      | Tile 32 (7560 oligos) | 176 nt  | TCCG  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----5'WT sub4----[TCCG]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                   TCCG                  AGAA 
```

**Set fidelity:** 0.8916 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile32_sub1    | 735 nt  | GCAC  | CAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCAC]----3'WT sub1----[CAGA]----3'WT sub2----[TGAC]----3'WT sub3----[TATC]----3'WT+PolIII sub4----[CACC]
   GCAC                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (5 overhangs)

---

### Tile 33 of 58 -- Codons 1785-1850 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGCA     | 0.5690   |
| oh2 (3' boundary) | GAGC     | 0.5446   |

**Variants:** 13020 mutations, 13020 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1782 nt | TCCA  | TTAG  |
| 4   | 5'WT gene block | bsai_5wt_tile33_sub4   | 825 nt  | TTAG  | AGCA  |
| 5   | Oligo pool      | Tile 33 (13020 oligos) | 254 nt  | AGCA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----5'WT sub4----[AGCA]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                   AGCA                  AGAA 
```

**Set fidelity:** 0.9244 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile33_sub1    | 549 nt  | GAGC  | CAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAGC]----3'WT sub1----[CAGA]----3'WT sub2----[TGAC]----3'WT sub3----[TATC]----3'WT+PolIII sub4----[CACC]
   GAGC                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (5 overhangs)

---

### Tile 34 of 58 -- Codons 1847-1895 (147 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCT     | 0.7573   |
| oh2 (3' boundary) | CACC     | 0.4172   |

**Variants:** 9450 mutations, 9450 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11       | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3  | 1782 nt | TCCA  | TTAG  |
| 4   | 5'WT gene block | bsai_5wt_tile34_sub4  | 1011 nt | TTAG  | TCCT  |
| 5   | Oligo pool      | Tile 34 (9450 oligos) | 203 nt  | TCCT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----5'WT sub4----[TCCT]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                   TCCT                  AGAA 
```

**Set fidelity:** 0.9308 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile34_sub1    | 414 nt  | CACC  | CAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1509 nt | CAGA  | TGAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CACC]----3'WT sub1----[CAGA]----3'WT sub2----[TGAC]----3'WT sub3----[TATC]----3'WT+PolIII sub4----[CACC]
   CACC                   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (4 overhangs)

---

### Tile 35 of 58 -- Codons 1892-1963 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTC     | 0.8105   |
| oh2 (3' boundary) | TTTA     | 0.9147   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1782 nt | TCCA  | TTAG  |
| 4   | 5'WT gene block | bsai_5wt_tile35_sub4   | 1146 nt | TTAG  | TCTC  |
| 5   | Oligo pool      | Tile 35 (14280 oligos) | 272 nt  | TCTC  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----5'WT sub4----[TCTC]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                   TCTC                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile35_sub1    | 1701 nt | TTTA  | TGAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTTA]----3'WT sub1----[TGAC]----3'WT sub2----[TATC]----3'WT+PolIII sub3----[CACC]
   TTTA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (4 overhangs)

---

### Tile 36 of 58 -- Codons 1960-1998 (117 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAG     | 0.6752   |
| oh2 (3' boundary) | AGAT     | 0.6825   |

**Variants:** 7350 mutations, 7350 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11       | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3  | 1782 nt | TCCA  | TTAG  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4  | 1350 nt | TTAG  | GAAG  |
| 5   | Oligo pool      | Tile 36 (7350 oligos) | 173 nt  | GAAG  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----5'WT sub4----[GAAG]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                   GAAG                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile36_sub1    | 1596 nt | AGAT  | TGAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAT]----3'WT sub1----[TGAC]----3'WT sub2----[TATC]----3'WT+PolIII sub3----[CACC]
   AGAT                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (4 overhangs)

---

### Tile 37 of 58 -- Codons 1995-2023 (87 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACA     | 0.8652   |
| oh2 (3' boundary) | CAGA     | 0.8175   |

**Variants:** 5250 mutations, 5250 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11       | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3  | 1782 nt | TCCA  | TTAG  |
| 4   | 5'WT gene block | bsai_5wt_tile37_sub4  | 1455 nt | TTAG  | TACA  |
| 5   | Oligo pool      | Tile 37 (5250 oligos) | 143 nt  | TACA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----5'WT sub4----[TACA]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                   TACA                  AGAA 
```

**Set fidelity:** 0.9133 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile37_sub1    | 1521 nt | CAGA  | TGAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAGA]----3'WT sub1----[TGAC]----3'WT sub2----[TATC]----3'WT+PolIII sub3----[CACC]
   CAGA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (4 overhangs)

---

### Tile 38 of 58 -- Codons 2024-2061 (114 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GACT     | 0.5537   |
| oh2 (3' boundary) | TAAA     | 0.9392   |

**Variants:** 7140 mutations, 7140 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11       | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3  | 1782 nt | TCCA  | TTAG  |
| 4   | 5'WT gene block | bsai_5wt_tile38_sub4  | 1542 nt | TTAG  | GACT  |
| 5   | Oligo pool      | Tile 38 (7140 oligos) | 170 nt  | GACT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----5'WT sub4----[GACT]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                   GACT                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile38_sub1    | 1407 nt | TAAA  | TGAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAAA]----3'WT sub1----[TGAC]----3'WT sub2----[TATC]----3'WT+PolIII sub3----[CACC]
   TAAA                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (4 overhangs)

---

### Tile 39 of 58 -- Codons 2058-2120 (189 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACA     | 0.8652   |
| oh2 (3' boundary) | GGAT     | 0.5385   |

**Variants:** 12390 mutations, 12390 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1782 nt | TCCA  | TTAG  |
| 4   | 5'WT gene block | bsai_5wt_tile39_sub4   | 1644 nt | TTAG  | TACA  |
| 5   | Oligo pool      | Tile 39 (12390 oligos) | 245 nt  | TACA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----5'WT sub4----[TACA]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                   TACA                  AGAA 
```

**Set fidelity:** 0.9133 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile39_sub1    | 1230 nt | GGAT  | TGAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAT]----3'WT sub1----[TGAC]----3'WT sub2----[TATC]----3'WT+PolIII sub3----[CACC]
   GGAT                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9919 (4 overhangs)

---

### Tile 40 of 58 -- Codons 2117-2157 (123 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TATT     | 0.8134   |
| oh2 (3' boundary) | CCAG     | 0.6122   |

**Variants:** 7770 mutations, 7770 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11       | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3  | 1782 nt | TCCA  | TTAG  |
| 4   | 5'WT gene block | bsai_5wt_tile38_sub4  | 1542 nt | TTAG  | GACT  |
| 5   | 5'WT gene block | bsai_5wt_tile40_sub5  | 297 nt  | GACT  | TATT  |
| 6   | Oligo pool      | Tile 40 (7770 oligos) | 179 nt  | TATT  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----5'WT sub4----[GACT]----5'WT sub5----[TATT]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                   GACT                   TATT                  AGAA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile40_sub1    | 1119 nt | CCAG  | TGAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCAG]----3'WT sub1----[TGAC]----3'WT sub2----[TATC]----3'WT+PolIII sub3----[CACC]
   CCAG                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (4 overhangs)

---

### Tile 41 of 58 -- Codons 2154-2215 (186 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCG     | 0.6891   |
| oh2 (3' boundary) | CAAG     | 0.6640   |

**Variants:** 12180 mutations, 12180 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1782 nt | TCCA  | TTAG  |
| 4   | 5'WT gene block | bsai_5wt_tile38_sub4   | 1542 nt | TTAG  | GACT  |
| 5   | 5'WT gene block | bsai_5wt_tile41_sub5   | 408 nt  | GACT  | TTCG  |
| 6   | Oligo pool      | Tile 41 (12180 oligos) | 242 nt  | TTCG  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----5'WT sub4----[GACT]----5'WT sub5----[TTCG]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                   GACT                   TTCG                  AGAA 
```

**Set fidelity:** 0.9881 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile41_sub1    | 945 nt  | CAAG  | TGAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAG]----3'WT sub1----[TGAC]----3'WT sub2----[TATC]----3'WT+PolIII sub3----[CACC]
   CAAG                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (4 overhangs)

---

### Tile 42 of 58 -- Codons 2212-2257 (138 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCC     | 0.7958   |
| oh2 (3' boundary) | AACT     | 0.6635   |

**Variants:** 8820 mutations, 8820 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11       | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3  | 1782 nt | TCCA  | TTAG  |
| 4   | 5'WT gene block | bsai_5wt_tile38_sub4  | 1542 nt | TTAG  | GACT  |
| 5   | 5'WT gene block | bsai_5wt_tile42_sub5  | 582 nt  | GACT  | TTCC  |
| 6   | Oligo pool      | Tile 42 (8820 oligos) | 194 nt  | TTCC  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----5'WT sub4----[GACT]----5'WT sub5----[TTCC]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                   GACT                   TTCC                  AGAA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile42_sub1    | 819 nt  | AACT  | TGAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AACT]----3'WT sub1----[TGAC]----3'WT sub2----[TATC]----3'WT+PolIII sub3----[CACC]
   AACT                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (4 overhangs)

---

### Tile 43 of 58 -- Codons 2254-2284 (93 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile11       | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3  | 1782 nt | TCCA  | TTAG  |
| 4   | 5'WT gene block | bsai_5wt_tile38_sub4  | 1542 nt | TTAG  | GACT  |
| 5   | 5'WT gene block | bsai_5wt_tile43_sub5  | 708 nt  | GACT  | TCTA  |
| 6   | Oligo pool      | Tile 43 (5670 oligos) | 149 nt  | TCTA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----5'WT sub4----[GACT]----5'WT sub5----[TCTA]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                   GACT                   TCTA                  AGAA 
```

**Set fidelity:** 0.9935 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile43_sub1    | 738 nt  | GAGG  | TGAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAGG]----3'WT sub1----[TGAC]----3'WT sub2----[TATC]----3'WT+PolIII sub3----[CACC]
   GAGG                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (4 overhangs)

---

### Tile 44 of 58 -- Codons 2281-2343 (189 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1782 nt | TCCA  | TTAG  |
| 4   | 5'WT gene block | bsai_5wt_tile38_sub4   | 1542 nt | TTAG  | GACT  |
| 5   | 5'WT gene block | bsai_5wt_tile44_sub5   | 789 nt  | GACT  | ACAT  |
| 6   | Oligo pool      | Tile 44 (12390 oligos) | 245 nt  | ACAT  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----5'WT sub4----[GACT]----5'WT sub5----[ACAT]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                   GACT                   ACAT                  AGAA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile44_sub1    | 561 nt  | ACAC  | TGAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACAC]----3'WT sub1----[TGAC]----3'WT sub2----[TATC]----3'WT+PolIII sub3----[CACC]
   ACAC                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (4 overhangs)

---

### Tile 45 of 58 -- Codons 2340-2411 (216 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1782 nt | TCCA  | TTAG  |
| 4   | 5'WT gene block | bsai_5wt_tile38_sub4   | 1542 nt | TTAG  | GACT  |
| 5   | 5'WT gene block | bsai_5wt_tile45_sub5   | 966 nt  | GACT  | CGGA  |
| 6   | Oligo pool      | Tile 45 (14280 oligos) | 272 nt  | CGGA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----5'WT sub4----[GACT]----5'WT sub5----[CGGA]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                   GACT                   CGGA                  AGAA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile45_sub1    | 357 nt  | GCTG  | TGAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCTG]----3'WT sub1----[TGAC]----3'WT sub2----[TATC]----3'WT+PolIII sub3----[CACC]
   GCTG                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (4 overhangs)

---

### Tile 46 of 58 -- Codons 2408-2468 (183 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCGA     | 0.6442   |
| oh2 (3' boundary) | GCCC     | 0.5462   |

**Variants:** 11970 mutations, 11970 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1782 nt | TCCA  | TTAG  |
| 4   | 5'WT gene block | bsai_5wt_tile38_sub4   | 1542 nt | TTAG  | GACT  |
| 5   | 5'WT gene block | bsai_5wt_tile46_sub5   | 1170 nt | GACT  | CCGA  |
| 6   | Oligo pool      | Tile 46 (11970 oligos) | 239 nt  | CCGA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----5'WT sub4----[GACT]----5'WT sub5----[CCGA]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                   GACT                   CCGA                  AGAA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile46_sub1    | 186 nt  | GCCC  | TGAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1692 nt | TGAC  | TATC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCCC]----3'WT sub1----[TGAC]----3'WT sub2----[TATC]----3'WT+PolIII sub3----[CACC]
   GCCC                   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (4 overhangs)

---

### Tile 47 of 58 -- Codons 2465-2520 (168 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTCC     | 0.5806   |
| oh2 (3' boundary) | TGAC     | 0.6485   |

**Variants:** 10920 mutations, 10920 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1782 nt | TCCA  | TTAG  |
| 4   | 5'WT gene block | bsai_5wt_tile38_sub4   | 1542 nt | TTAG  | GACT  |
| 5   | 5'WT gene block | bsai_5wt_tile47_sub5   | 1341 nt | GACT  | GTCC  |
| 6   | Oligo pool      | Tile 47 (10920 oligos) | 224 nt  | GTCC  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----5'WT sub4----[GACT]----5'WT sub5----[GTCC]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                   GACT                   GTCC                  AGAA 
```

**Set fidelity:** 0.9984 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile47_sub1    | 1704 nt | TGAC  | TATC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAC]----3'WT sub1----[TATC]----3'WT+PolIII sub2----[CACC]
   TGAC                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (3 overhangs)

---

### Tile 48 of 58 -- Codons 2521-2575 (165 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGG     | 0.6552   |
| oh2 (3' boundary) | TCAA     | 0.9425   |

**Variants:** 10710 mutations, 10710 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1782 nt | TCCA  | TTAG  |
| 4   | 5'WT gene block | bsai_5wt_tile38_sub4   | 1542 nt | TTAG  | GACT  |
| 5   | 5'WT gene block | bsai_5wt_tile48_sub5   | 1509 nt | GACT  | AAGG  |
| 6   | Oligo pool      | Tile 48 (10710 oligos) | 221 nt  | AAGG  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----5'WT sub4----[GACT]----5'WT sub5----[AAGG]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                   GACT                   AAGG                  AGAA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile48_sub1    | 1539 nt | TCAA  | TATC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAA]----3'WT sub1----[TATC]----3'WT+PolIII sub2----[CACC]
   TCAA                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (3 overhangs)

---

### Tile 49 of 58 -- Codons 2572-2631 (180 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTCT     | 0.5601   |
| oh2 (3' boundary) | AGCA     | 0.5690   |

**Variants:** 11760 mutations, 11760 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1782 nt | TCCA  | TTAG  |
| 4   | 5'WT gene block | bsai_5wt_tile38_sub4   | 1542 nt | TTAG  | GACT  |
| 5   | 5'WT gene block | bsai_5wt_tile49_sub5   | 1662 nt | GACT  | GTCT  |
| 6   | Oligo pool      | Tile 49 (11760 oligos) | 236 nt  | GTCT  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----5'WT sub4----[GACT]----5'WT sub5----[GTCT]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                   GACT                   GTCT                  AGAA 
```

**Set fidelity:** 0.8973 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile49_sub1    | 1371 nt | AGCA  | TATC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGCA]----3'WT sub1----[TATC]----3'WT+PolIII sub2----[CACC]
   AGCA                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (3 overhangs)

---

### Tile 50 of 58 -- Codons 2628-2700 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGT     | 0.7629   |
| oh2 (3' boundary) | TCTT     | 0.7985   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1782 nt | TCCA  | TTAG  |
| 4   | 5'WT gene block | bsai_5wt_tile38_sub4   | 1542 nt | TTAG  | GACT  |
| 5   | 5'WT gene block | bsai_5wt_tile48_sub5   | 1509 nt | GACT  | AAGG  |
| 6   | 5'WT gene block | bsai_5wt_tile50_sub6   | 339 nt  | AAGG  | AAGT  |
| 7   | Oligo pool      | Tile 50 (14490 oligos) | 275 nt  | AAGT  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----5'WT sub4----[GACT]----5'WT sub5----[AAGG]----5'WT sub6----[AAGT]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                   GACT                   AAGG                   AAGT                  AGAA 
```

**Set fidelity:** 0.9728 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile50_sub1    | 1164 nt | TCTT  | TATC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCTT]----3'WT sub1----[TATC]----3'WT+PolIII sub2----[CACC]
   TCTT                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (3 overhangs)

---

### Tile 51 of 58 -- Codons 2697-2770 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAGA     | 0.7444   |
| oh2 (3' boundary) | CCTG     | 0.6383   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1782 nt | TCCA  | TTAG  |
| 4   | 5'WT gene block | bsai_5wt_tile38_sub4   | 1542 nt | TTAG  | GACT  |
| 5   | 5'WT gene block | bsai_5wt_tile48_sub5   | 1509 nt | GACT  | AAGG  |
| 6   | 5'WT gene block | bsai_5wt_tile51_sub6   | 546 nt  | AAGG  | GAGA  |
| 7   | Oligo pool      | Tile 51 (14700 oligos) | 278 nt  | GAGA  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----5'WT sub4----[GACT]----5'WT sub5----[AAGG]----5'WT sub6----[GAGA]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                   GACT                   AAGG                   GAGA                  AGAA 
```

**Set fidelity:** 1.0000 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile51_sub1    | 954 nt  | CCTG  | TATC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTG]----3'WT sub1----[TATC]----3'WT+PolIII sub2----[CACC]
   CCTG                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (3 overhangs)

---

### Tile 52 of 58 -- Codons 2767-2814 (144 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAG     | 0.7814   |
| oh2 (3' boundary) | AACC     | 0.5451   |

**Variants:** 9240 mutations, 9240 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11       | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3  | 1782 nt | TCCA  | TTAG  |
| 4   | 5'WT gene block | bsai_5wt_tile38_sub4  | 1542 nt | TTAG  | GACT  |
| 5   | 5'WT gene block | bsai_5wt_tile48_sub5  | 1509 nt | GACT  | AAGG  |
| 6   | 5'WT gene block | bsai_5wt_tile52_sub6  | 756 nt  | AAGG  | TCAG  |
| 7   | Oligo pool      | Tile 52 (9240 oligos) | 200 nt  | TCAG  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----5'WT sub4----[GACT]----5'WT sub5----[AAGG]----5'WT sub6----[TCAG]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                   GACT                   AAGG                   TCAG                  AGAA 
```

**Set fidelity:** 0.9532 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile52_sub1    | 822 nt  | AACC  | TATC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AACC]----3'WT sub1----[TATC]----3'WT+PolIII sub2----[CACC]
   AACC                   TATC                          CACC 
```

**Set fidelity:** 0.8520 (3 overhangs)

---

### Tile 53 of 58 -- Codons 2811-2860 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | CAGC     | 0.4815   |

**Variants:** 9660 mutations, 9660 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11       | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3  | 1782 nt | TCCA  | TTAG  |
| 4   | 5'WT gene block | bsai_5wt_tile38_sub4  | 1542 nt | TTAG  | GACT  |
| 5   | 5'WT gene block | bsai_5wt_tile48_sub5  | 1509 nt | GACT  | AAGG  |
| 6   | 5'WT gene block | bsai_5wt_tile53_sub6  | 888 nt  | AAGG  | AAGA  |
| 7   | Oligo pool      | Tile 53 (9660 oligos) | 206 nt  | AAGA  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----5'WT sub4----[GACT]----5'WT sub5----[AAGG]----5'WT sub6----[AAGA]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                   GACT                   AAGG                   AAGA                  AGAA 
```

**Set fidelity:** 0.8630 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile53_sub1    | 684 nt  | CAGC  | TATC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAGC]----3'WT sub1----[TATC]----3'WT+PolIII sub2----[CACC]
   CAGC                   TATC                          CACC 
```

**Set fidelity:** 0.9322 (3 overhangs)

---

### Tile 54 of 58 -- Codons 2857-2933 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GACA     | 0.6127   |
| oh2 (3' boundary) | CTTT     | 0.6635   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1782 nt | TCCA  | TTAG  |
| 4   | 5'WT gene block | bsai_5wt_tile38_sub4   | 1542 nt | TTAG  | GACT  |
| 5   | 5'WT gene block | bsai_5wt_tile48_sub5   | 1509 nt | GACT  | AAGG  |
| 6   | 5'WT gene block | bsai_5wt_tile54_sub6   | 1026 nt | AAGG  | GACA  |
| 7   | Oligo pool      | Tile 54 (15330 oligos) | 287 nt  | GACA  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----5'WT sub4----[GACT]----5'WT sub5----[AAGG]----5'WT sub6----[GACA]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                   GACT                   AAGG                   GACA                  AGAA 
```

**Set fidelity:** 0.7636 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile54_sub1    | 465 nt  | CTTT  | TATC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1160 nt | TATC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTTT]----3'WT sub1----[TATC]----3'WT+PolIII sub2----[CACC]
   CTTT                   TATC                          CACC 
```

**Set fidelity:** 0.9961 (3 overhangs)

---

### Tile 55 of 58 -- Codons 2930-3002 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCAA     | 0.8439   |
| oh2 (3' boundary) | CCGC     | 0.3775   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1782 nt | TCCA  | TTAG  |
| 4   | 5'WT gene block | bsai_5wt_tile38_sub4   | 1542 nt | TTAG  | GACT  |
| 5   | 5'WT gene block | bsai_5wt_tile48_sub5   | 1509 nt | GACT  | AAGG  |
| 6   | 5'WT gene block | bsai_5wt_tile55_sub6   | 1245 nt | AAGG  | CCAA  |
| 7   | Oligo pool      | Tile 55 (14490 oligos) | 275 nt  | CCAA  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----5'WT sub4----[GACT]----5'WT sub5----[AAGG]----5'WT sub6----[CCAA]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                   GACT                   AAGG                   CCAA                  AGAA 
```

**Set fidelity:** 1.0000 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile55_sub1    | 1400 nt | CCGC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCGC]----3'WT+PolIII----[CACC]
   CCGC                     CACC 
```

**Set fidelity:** 0.9923 (2 overhangs)

---

### Tile 56 of 58 -- Codons 2999-3029 (93 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | GGAG     | 0.5228   |

**Variants:** 5670 mutations, 5670 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11       | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3  | 1782 nt | TCCA  | TTAG  |
| 4   | 5'WT gene block | bsai_5wt_tile38_sub4  | 1542 nt | TTAG  | GACT  |
| 5   | 5'WT gene block | bsai_5wt_tile48_sub5  | 1509 nt | GACT  | AAGG  |
| 6   | 5'WT gene block | bsai_5wt_tile56_sub6  | 1452 nt | AAGG  | GAAA  |
| 7   | Oligo pool      | Tile 56 (5670 oligos) | 149 nt  | GAAA  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----5'WT sub4----[GACT]----5'WT sub5----[AAGG]----5'WT sub6----[GAAA]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                   GACT                   AAGG                   GAAA                  AGAA 
```

**Set fidelity:** 1.0000 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile56_sub1    | 1319 nt | GGAG  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAG]----3'WT+PolIII----[CACC]
   GGAG                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 57 of 58 -- Codons 3026-3078 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCG     | 0.6891   |
| oh2 (3' boundary) | TATC     | 0.8041   |

**Variants:** 10290 mutations, 10290 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1782 nt | TCCA  | TTAG  |
| 4   | 5'WT gene block | bsai_5wt_tile38_sub4   | 1542 nt | TTAG  | GACT  |
| 5   | 5'WT gene block | bsai_5wt_tile48_sub5   | 1509 nt | GACT  | AAGG  |
| 6   | 5'WT gene block | bsai_5wt_tile57_sub6   | 1533 nt | AAGG  | TTCG  |
| 7   | Oligo pool      | Tile 57 (10290 oligos) | 215 nt  | TTCG  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----5'WT sub4----[GACT]----5'WT sub5----[AAGG]----5'WT sub6----[TTCG]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                   GACT                   AAGG                   TTCG                  AGAA 
```

**Set fidelity:** 0.9881 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile57_sub1    | 1172 nt | TATC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TATC]----3'WT+PolIII----[CACC]
   TATC                     CACC 
```

**Set fidelity:** 0.9961 (2 overhangs)

---

### Tile 58 of 58 -- Codons 3079-3098 (60 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTTC     | 0.5976   |
| oh2 (3' boundary) | TTGA     | 0.8853   |

**Variants:** 3360 mutations, 3360 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11       | 1674 nt | ATGA  | AACA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1143 nt | AACA  | TCCA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3  | 1782 nt | TCCA  | TTAG  |
| 4   | 5'WT gene block | bsai_5wt_tile38_sub4  | 1542 nt | TTAG  | GACT  |
| 5   | 5'WT gene block | bsai_5wt_tile48_sub5  | 1509 nt | GACT  | AAGG  |
| 6   | 5'WT gene block | bsai_5wt_tile58_sub6  | 1692 nt | AAGG  | GTTC  |
| 7   | Oligo pool      | Tile 58 (3360 oligos) | 116 nt  | GTTC  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[AACA]----5'WT sub2----[TCCA]----5'WT sub3----[TTAG]----5'WT sub4----[GACT]----5'WT sub5----[AAGG]----5'WT sub6----[GTTC]----oligo+BC----[AGAA]
   ATGA                   AACA                   TCCA                   TTAG                   GACT                   AAGG                   GTTC                  AGAA 
```

**Set fidelity:** 1.0000 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component            | Part name                | Length  | 5' OH | 3' OH |
| --- | -------------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product         | (in helper plasmid)      | --      | --    | --    |
| 2   | PolIII-only fragment | bsmbi_polIII_tile58      | 1112 nt | TTGA  | CACC  |
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

**Total blocks:** 121

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| --------------------- | ----------- | ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10       | 1482        | BsaI        | 5wt_tile10                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile11       | 1674        | BsaI        | 5wt_tile11;5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1;5wt_tile26_sub1;5wt_tile27_sub1;5wt_tile28_sub1;5wt_tile29_sub1;5wt_tile30_sub1;5wt_tile31_sub1;5wt_tile32_sub1;5wt_tile33_sub1;5wt_tile34_sub1;5wt_tile35_sub1;5wt_tile36_sub1;5wt_tile37_sub1;5wt_tile38_sub1;5wt_tile39_sub1;5wt_tile40_sub1;5wt_tile41_sub1;5wt_tile42_sub1;5wt_tile43_sub1;5wt_tile44_sub1;5wt_tile45_sub1;5wt_tile46_sub1;5wt_tile47_sub1;5wt_tile48_sub1;5wt_tile49_sub1;5wt_tile50_sub1;5wt_tile51_sub1;5wt_tile52_sub1;5wt_tile53_sub1;5wt_tile54_sub1;5wt_tile55_sub1;5wt_tile56_sub1;5wt_tile57_sub1;5wt_tile58_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile12_sub2  | 192         | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile13_sub2  | 327         | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile14_sub2  | 489         | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile15_sub2  | 588         | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile16_sub2  | 789         | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile17_sub2  | 960         | BsaI        | 5wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile18_sub2  | 1143        | BsaI        | 5wt_tile18_sub2;5wt_tile20_sub2;5wt_tile21_sub2;5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2;5wt_tile26_sub2;5wt_tile27_sub2;5wt_tile28_sub2;5wt_tile29_sub2;5wt_tile30_sub2;5wt_tile31_sub2;5wt_tile32_sub2;5wt_tile33_sub2;5wt_tile34_sub2;5wt_tile35_sub2;5wt_tile36_sub2;5wt_tile37_sub2;5wt_tile38_sub2;5wt_tile39_sub2;5wt_tile40_sub2;5wt_tile41_sub2;5wt_tile42_sub2;5wt_tile43_sub2;5wt_tile44_sub2;5wt_tile45_sub2;5wt_tile46_sub2;5wt_tile47_sub2;5wt_tile48_sub2;5wt_tile49_sub2;5wt_tile50_sub2;5wt_tile51_sub2;5wt_tile52_sub2;5wt_tile53_sub2;5wt_tile54_sub2;5wt_tile55_sub2;5wt_tile56_sub2;5wt_tile57_sub2;5wt_tile58_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile19_sub2  | 1365        | BsaI        | 5wt_tile19_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile2        | 213         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile20_sub3  | 381         | BsaI        | 5wt_tile20_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile21_sub3  | 603         | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile22_sub3  | 789         | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile23_sub3  | 1002        | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile24_sub3  | 1146        | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile25_sub3  | 1281        | BsaI        | 5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile26_sub3  | 1494        | BsaI        | 5wt_tile26_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile27_sub3  | 1587        | BsaI        | 5wt_tile27_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile28_sub3  | 1782        | BsaI        | 5wt_tile28_sub3;5wt_tile29_sub3;5wt_tile30_sub3;5wt_tile31_sub3;5wt_tile32_sub3;5wt_tile33_sub3;5wt_tile34_sub3;5wt_tile35_sub3;5wt_tile36_sub3;5wt_tile37_sub3;5wt_tile38_sub3;5wt_tile39_sub3;5wt_tile40_sub3;5wt_tile41_sub3;5wt_tile42_sub3;5wt_tile43_sub3;5wt_tile44_sub3;5wt_tile45_sub3;5wt_tile46_sub3;5wt_tile47_sub3;5wt_tile48_sub3;5wt_tile49_sub3;5wt_tile50_sub3;5wt_tile51_sub3;5wt_tile52_sub3;5wt_tile53_sub3;5wt_tile54_sub3;5wt_tile55_sub3;5wt_tile56_sub3;5wt_tile57_sub3;5wt_tile58_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile29_sub4  | 171         | BsaI        | 5wt_tile29_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile3        | 330         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile30_sub4  | 297         | BsaI        | 5wt_tile30_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile31_sub4  | 495         | BsaI        | 5wt_tile31_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile32_sub4  | 717         | BsaI        | 5wt_tile32_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile33_sub4  | 825         | BsaI        | 5wt_tile33_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile34_sub4  | 1011        | BsaI        | 5wt_tile34_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile35_sub4  | 1146        | BsaI        | 5wt_tile35_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile36_sub4  | 1350        | BsaI        | 5wt_tile36_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile37_sub4  | 1455        | BsaI        | 5wt_tile37_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile38_sub4  | 1542        | BsaI        | 5wt_tile38_sub4;5wt_tile40_sub4;5wt_tile41_sub4;5wt_tile42_sub4;5wt_tile43_sub4;5wt_tile44_sub4;5wt_tile45_sub4;5wt_tile46_sub4;5wt_tile47_sub4;5wt_tile48_sub4;5wt_tile49_sub4;5wt_tile50_sub4;5wt_tile51_sub4;5wt_tile52_sub4;5wt_tile53_sub4;5wt_tile54_sub4;5wt_tile55_sub4;5wt_tile56_sub4;5wt_tile57_sub4;5wt_tile58_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile39_sub4  | 1644        | BsaI        | 5wt_tile39_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile4        | 549         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile40_sub5  | 297         | BsaI        | 5wt_tile40_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile41_sub5  | 408         | BsaI        | 5wt_tile41_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile42_sub5  | 582         | BsaI        | 5wt_tile42_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile43_sub5  | 708         | BsaI        | 5wt_tile43_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile44_sub5  | 789         | BsaI        | 5wt_tile44_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile45_sub5  | 966         | BsaI        | 5wt_tile45_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile46_sub5  | 1170        | BsaI        | 5wt_tile46_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile47_sub5  | 1341        | BsaI        | 5wt_tile47_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile48_sub5  | 1509        | BsaI        | 5wt_tile48_sub5;5wt_tile50_sub5;5wt_tile51_sub5;5wt_tile52_sub5;5wt_tile53_sub5;5wt_tile54_sub5;5wt_tile55_sub5;5wt_tile56_sub5;5wt_tile57_sub5;5wt_tile58_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile49_sub5  | 1662        | BsaI        | 5wt_tile49_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile5        | 660         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile50_sub6  | 339         | BsaI        | 5wt_tile50_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile51_sub6  | 546         | BsaI        | 5wt_tile51_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile52_sub6  | 756         | BsaI        | 5wt_tile52_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile53_sub6  | 888         | BsaI        | 5wt_tile53_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile54_sub6  | 1026        | BsaI        | 5wt_tile54_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile55_sub6  | 1245        | BsaI        | 5wt_tile55_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile56_sub6  | 1452        | BsaI        | 5wt_tile56_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile57_sub6  | 1533        | BsaI        | 5wt_tile57_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile58_sub6  | 1692        | BsaI        | 5wt_tile58_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile6        | 798         | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile7        | 900         | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile8        | 1116        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile9        | 1335        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile1_sub1  | 1479        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile1_sub2  | 1143        | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile8_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile1_sub3  | 1782        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub3;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2;3wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile1_sub4  | 1542        | BsmBI       | 3wt_tile1_sub4;3wt_tile2_sub4;3wt_tile3_sub4;3wt_tile4_sub4;3wt_tile5_sub4;3wt_tile6_sub4;3wt_tile7_sub4;3wt_tile8_sub4;3wt_tile9_sub3;3wt_tile10_sub3;3wt_tile11_sub3;3wt_tile12_sub3;3wt_tile13_sub3;3wt_tile14_sub3;3wt_tile15_sub3;3wt_tile16_sub3;3wt_tile17_sub2;3wt_tile18_sub2;3wt_tile19_sub2;3wt_tile20_sub2;3wt_tile21_sub2;3wt_tile22_sub2;3wt_tile23_sub2;3wt_tile24_sub2;3wt_tile25_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile1_sub5  | 1509        | BsmBI       | 3wt_tile1_sub5;3wt_tile2_sub5;3wt_tile3_sub5;3wt_tile4_sub5;3wt_tile5_sub5;3wt_tile6_sub5;3wt_tile7_sub5;3wt_tile8_sub5;3wt_tile9_sub4;3wt_tile10_sub4;3wt_tile11_sub4;3wt_tile12_sub4;3wt_tile13_sub4;3wt_tile14_sub4;3wt_tile15_sub4;3wt_tile16_sub4;3wt_tile17_sub3;3wt_tile18_sub3;3wt_tile19_sub3;3wt_tile20_sub3;3wt_tile21_sub3;3wt_tile22_sub3;3wt_tile23_sub3;3wt_tile24_sub3;3wt_tile25_sub3;3wt_tile26_sub2;3wt_tile27_sub2;3wt_tile28_sub2;3wt_tile29_sub2;3wt_tile30_sub2;3wt_tile31_sub2;3wt_tile32_sub2;3wt_tile33_sub2;3wt_tile34_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile1_sub6  | 1692        | BsmBI       | 3wt_tile1_sub6;3wt_tile2_sub6;3wt_tile3_sub6;3wt_tile4_sub6;3wt_tile5_sub6;3wt_tile6_sub6;3wt_tile7_sub6;3wt_tile8_sub6;3wt_tile9_sub5;3wt_tile10_sub5;3wt_tile11_sub5;3wt_tile12_sub5;3wt_tile13_sub5;3wt_tile14_sub5;3wt_tile15_sub5;3wt_tile16_sub5;3wt_tile17_sub4;3wt_tile18_sub4;3wt_tile19_sub4;3wt_tile20_sub4;3wt_tile21_sub4;3wt_tile22_sub4;3wt_tile23_sub4;3wt_tile24_sub4;3wt_tile25_sub4;3wt_tile26_sub3;3wt_tile27_sub3;3wt_tile28_sub3;3wt_tile29_sub3;3wt_tile30_sub3;3wt_tile31_sub3;3wt_tile32_sub3;3wt_tile33_sub3;3wt_tile34_sub3;3wt_tile35_sub2;3wt_tile36_sub2;3wt_tile37_sub2;3wt_tile38_sub2;3wt_tile39_sub2;3wt_tile40_sub2;3wt_tile41_sub2;3wt_tile42_sub2;3wt_tile43_sub2;3wt_tile44_sub2;3wt_tile45_sub2;3wt_tile46_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile1_sub7  | 1160        | BsmBI       | 3wt_polIII_tile1_sub7;3wt_polIII_tile2_sub7;3wt_polIII_tile3_sub7;3wt_polIII_tile4_sub7;3wt_polIII_tile5_sub7;3wt_polIII_tile6_sub7;3wt_polIII_tile7_sub7;3wt_polIII_tile8_sub7;3wt_polIII_tile9_sub6;3wt_polIII_tile10_sub6;3wt_polIII_tile11_sub6;3wt_polIII_tile12_sub6;3wt_polIII_tile13_sub6;3wt_polIII_tile14_sub6;3wt_polIII_tile15_sub6;3wt_polIII_tile16_sub6;3wt_polIII_tile17_sub5;3wt_polIII_tile18_sub5;3wt_polIII_tile19_sub5;3wt_polIII_tile20_sub5;3wt_polIII_tile21_sub5;3wt_polIII_tile22_sub5;3wt_polIII_tile23_sub5;3wt_polIII_tile24_sub5;3wt_polIII_tile25_sub5;3wt_polIII_tile26_sub4;3wt_polIII_tile27_sub4;3wt_polIII_tile28_sub4;3wt_polIII_tile29_sub4;3wt_polIII_tile30_sub4;3wt_polIII_tile31_sub4;3wt_polIII_tile32_sub4;3wt_polIII_tile33_sub4;3wt_polIII_tile34_sub4;3wt_polIII_tile35_sub3;3wt_polIII_tile36_sub3;3wt_polIII_tile37_sub3;3wt_polIII_tile38_sub3;3wt_polIII_tile39_sub3;3wt_polIII_tile40_sub3;3wt_polIII_tile41_sub3;3wt_polIII_tile42_sub3;3wt_polIII_tile43_sub3;3wt_polIII_tile44_sub3;3wt_polIII_tile45_sub3;3wt_polIII_tile46_sub3;3wt_polIII_tile47_sub2;3wt_polIII_tile48_sub2;3wt_polIII_tile49_sub2;3wt_polIII_tile50_sub2;3wt_polIII_tile51_sub2;3wt_polIII_tile52_sub2;3wt_polIII_tile53_sub2;3wt_polIII_tile54_sub2 |
| bsmbi_3wt_tile10_sub1 | 1155        | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile11_sub1 | 969         | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile12_sub1 | 834         | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile13_sub1 | 672         | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile14_sub1 | 573         | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile15_sub1 | 372         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile16_sub1 | 201         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile17_sub1 | 1794        | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile18_sub1 | 1560        | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile19_sub1 | 1419        | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile2_sub1  | 1362        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile20_sub1 | 1197        | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile21_sub1 | 1011        | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile22_sub1 | 798         | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile23_sub1 | 654         | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile24_sub1 | 519         | BsmBI       | 3wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile25_sub1 | 306         | BsmBI       | 3wt_tile25_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile26_sub1 | 1737        | BsmBI       | 3wt_tile26_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile27_sub1 | 1554        | BsmBI       | 3wt_tile27_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile28_sub1 | 1389        | BsmBI       | 3wt_tile28_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile29_sub1 | 1263        | BsmBI       | 3wt_tile29_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile3_sub1  | 1143        | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile30_sub1 | 1065        | BsmBI       | 3wt_tile30_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile31_sub1 | 843         | BsmBI       | 3wt_tile31_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile32_sub1 | 735         | BsmBI       | 3wt_tile32_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile33_sub1 | 549         | BsmBI       | 3wt_tile33_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile34_sub1 | 414         | BsmBI       | 3wt_tile34_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile35_sub1 | 1701        | BsmBI       | 3wt_tile35_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile36_sub1 | 1596        | BsmBI       | 3wt_tile36_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile37_sub1 | 1521        | BsmBI       | 3wt_tile37_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile38_sub1 | 1407        | BsmBI       | 3wt_tile38_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile39_sub1 | 1230        | BsmBI       | 3wt_tile39_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile4_sub1  | 1032        | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile40_sub1 | 1119        | BsmBI       | 3wt_tile40_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile41_sub1 | 945         | BsmBI       | 3wt_tile41_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile42_sub1 | 819         | BsmBI       | 3wt_tile42_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile43_sub1 | 738         | BsmBI       | 3wt_tile43_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile44_sub1 | 561         | BsmBI       | 3wt_tile44_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile45_sub1 | 357         | BsmBI       | 3wt_tile45_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile46_sub1 | 186         | BsmBI       | 3wt_tile46_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile47_sub1 | 1704        | BsmBI       | 3wt_tile47_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile48_sub1 | 1539        | BsmBI       | 3wt_tile48_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile49_sub1 | 1371        | BsmBI       | 3wt_tile49_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile5_sub1  | 894         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile50_sub1 | 1164        | BsmBI       | 3wt_tile50_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile51_sub1 | 954         | BsmBI       | 3wt_tile51_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile52_sub1 | 822         | BsmBI       | 3wt_tile52_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile53_sub1 | 684         | BsmBI       | 3wt_tile53_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile54_sub1 | 465         | BsmBI       | 3wt_tile54_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile55_sub1 | 1400        | BsmBI       | 3wt_polIII_tile55_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile56_sub1 | 1319        | BsmBI       | 3wt_polIII_tile56_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile57_sub1 | 1172        | BsmBI       | 3wt_polIII_tile57_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile6_sub1  | 792         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile7_sub1  | 576         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile8_sub1  | 357         | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile9_sub1  | 1335        | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_polIII_tile58   | 1112        | BsmBI       | polIII_tile58                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |

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

