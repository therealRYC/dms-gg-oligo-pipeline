# DMS-GG Assembly Report: TRIO

Generated: 2026-03-05 14:32:44
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                         |
| -------------------- | ----------------------------------------------------------------------------- |
| Gene name            | TRIO_NM_007118.4_CDS Homo sapiens triple functional domain protein (TRIO) CDS |
| CDS length           | 9294 nt (3098 codons)                                                         |
| Protein length       | 3097 aa                                                                       |
| Number of tiles      | 64                                                                            |
| Total variants       | 64932                                                                         |
| Total oligos         | 649320                                                                        |
| Oligo length range   | 152-287 nt                                                                    |
| Gene blocks to order | 142                                                                           |
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

**Total oligos:** 649320 | **Length range:** 152-287 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-59      | 11550  | 233 nt |
| 2    | 56-111    | 10920  | 224 nt |
| 3    | 108-179   | 14280  | 272 nt |
| 4    | 176-215   | 7560   | 176 nt |
| 5    | 212-268   | 11130  | 227 nt |
| 6    | 265-297   | 6090   | 155 nt |
| 7    | 294-354   | 11970  | 239 nt |
| 8    | 351-414   | 12600  | 248 nt |
| 9    | 411-453   | 8190   | 185 nt |
| 10   | 451-492   | 7980   | 182 nt |
| 11   | 489-556   | 13440  | 260 nt |
| 12   | 553-601   | 9450   | 203 nt |
| 13   | 598-629   | 5880   | 152 nt |
| 14   | 626-676   | 9870   | 209 nt |
| 15   | 673-746   | 14700  | 278 nt |
| 16   | 743-807   | 12810  | 251 nt |
| 17   | 804-843   | 7560   | 176 nt |
| 18   | 840-888   | 9450   | 203 nt |
| 19   | 885-931   | 9030   | 197 nt |
| 20   | 928-963   | 6720   | 164 nt |
| 21   | 960-1005  | 8820   | 194 nt |
| 22   | 1002-1070 | 13650  | 263 nt |
| 23   | 1067-1114 | 9240   | 200 nt |
| 24   | 1111-1148 | 7140   | 170 nt |
| 25   | 1145-1209 | 12810  | 251 nt |
| 26   | 1206-1244 | 7350   | 173 nt |
| 27   | 1241-1304 | 12600  | 248 nt |
| 28   | 1301-1355 | 10710  | 221 nt |
| 29   | 1352-1389 | 7140   | 170 nt |
| 30   | 1386-1420 | 6510   | 161 nt |
| 31   | 1417-1493 | 15330  | 287 nt |
| 32   | 1490-1527 | 7140   | 170 nt |
| 33   | 1524-1571 | 9240   | 200 nt |
| 34   | 1568-1639 | 14280  | 272 nt |
| 35   | 1636-1684 | 9450   | 203 nt |
| 36   | 1681-1752 | 14280  | 272 nt |
| 37   | 1749-1805 | 11130  | 227 nt |
| 38   | 1802-1856 | 10710  | 221 nt |
| 39   | 1853-1922 | 13860  | 266 nt |
| 40   | 1919-1969 | 9870   | 209 nt |
| 41   | 1966-2011 | 8820   | 194 nt |
| 42   | 2008-2064 | 11130  | 227 nt |
| 43   | 2061-2130 | 13860  | 266 nt |
| 44   | 2127-2161 | 6510   | 161 nt |
| 45   | 2158-2218 | 11970  | 239 nt |
| 46   | 2215-2253 | 7350   | 173 nt |
| 47   | 2250-2283 | 6300   | 158 nt |
| 48   | 2280-2338 | 11550  | 233 nt |
| 49   | 2335-2368 | 6300   | 158 nt |
| 50   | 2365-2419 | 10710  | 221 nt |
| 51   | 2416-2470 | 10710  | 221 nt |
| 52   | 2467-2502 | 6720   | 164 nt |
| 53   | 2499-2546 | 9240   | 200 nt |
| 54   | 2543-2609 | 13230  | 257 nt |
| 55   | 2606-2643 | 7140   | 170 nt |
| 56   | 2641-2700 | 11760  | 236 nt |
| 57   | 2697-2767 | 14070  | 269 nt |
| 58   | 2764-2814 | 9870   | 209 nt |
| 59   | 2811-2860 | 9660   | 206 nt |
| 60   | 2857-2921 | 12810  | 251 nt |
| 61   | 2918-2985 | 13440  | 260 nt |
| 62   | 2982-3018 | 6930   | 167 nt |
| 63   | 3015-3070 | 10920  | 224 nt |
| 64   | 3067-3098 | 5880   | 152 nt |

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
| Total barcodes    | 649320                             |
| Unique barcodes   | 649320                             |
| GC content range  | 25% - 75%                          |
| GC content mean   | 47.9%                              |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                  | Description                                                   | Result | Detail                                                                                                                                              |
| ---------------------- | ------------------------------------------------------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths          | All oligos within synthesis length limit                      | PASS   | Range: 152-287 nt (limit: 300)                                                                                                                      |
| block_lengths          | All gene blocks within synthesis length limit                 | FAIL   | Range: 111-2486 nt (limit: 1800)                                                                                                                    |
| barcode_junction_sites | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                             |
| barcode_uniqueness     | All barcodes are unique                                       | PASS   | 649320 unique / 649320 total                                                                                                                        |
| tile_coverage          | Tiles cover entire gene without gaps                          | PASS   | 9294 / 9294 nt covered                                                                                                                              |
| variant_count          | Expected number of variants generated                         | PASS   | 64932 unique variants (expected: 64932 across 3092/3096 mutable positions; 58748 missense + 3092 nonsense + 3092 wt_control; 4 position(s) skipped) |
| single_codon_change    | Each non-control variant differs by exactly one codon from WT | PASS   | 618400 / 618400 variants confirmed (WT controls excluded)                                                                                           |
| oligo_gc_content       | Oligo GC content within reasonable range (25-75%)             | FAIL   | GC range: 37.6-76.4% | 233 oligo(s) with extreme GC                                                                                                 |
| domestication_complete | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                             |
| overhang_fidelity      | Tile boundary overhangs have adequate fidelity                | FAIL   | 58 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                             |
| tile_manifests         | Per-tile assembly manifests complete                          | PASS   | 64 tile manifest(s) generated                                                                                                                       |
| helper_plasmid         | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                  |
| reaction_fidelity      | Per-reaction set-level overhang fidelity                      | PASS   | Min set fidelity: 0.9146 across 128 reactions | 0 reaction(s) below 0.90                                                                            |
| barcode_poliii_term    | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 649320 barcode(s) contain TTTT                                                                                                                  |
| block_min_length       | All gene blocks above synthesis minimum length                | FAIL   | 5 block(s) below 300 nt minimum. Range: 111-2486 nt                                                                                                 |

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

### Tile 1 of 64 -- Codons 1-59 (177 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGA     | 0.7549   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 11550 mutations, 11550 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (11550 oligos)              | 233 nt | ATGA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1     | 1191 nt | TGAA  | TTTC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1545 nt | TTTC  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1710 nt | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1203 nt | GAAA  | GAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[TTTC]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT sub5----[GAAA]----3'WT sub6----[GAAA]----3'WT+PolIII sub7----[CACC]
   TGAA                   TTTC                   GAAA                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 2 of 64 -- Codons 56-111 (168 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAA     | 0.9502   |
| oh2 (3' boundary) | TCTA     | 0.8892   |

**Variants:** 10920 mutations, 10920 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 183 nt | ATGA  | AAAA  |
| 2   | Oligo pool      | Tile 2 (10920 oligos) | 224 nt | AAAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[AAAA]----oligo+BC----[AGAA]
   ATGA                    AAAA                  AGAA 
```

**Set fidelity:** 0.9907 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1     | 1035 nt | TCTA  | TTTC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1545 nt | TTTC  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1710 nt | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1203 nt | GAAA  | GAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCTA]----3'WT sub1----[TTTC]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT sub5----[GAAA]----3'WT sub6----[GAAA]----3'WT+PolIII sub7----[CACC]
   TCTA                   TTTC                   GAAA                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 3 of 64 -- Codons 108-179 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTT     | 0.7664   |
| oh2 (3' boundary) | ATTT     | 0.7664   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 339 nt | ATGA  | ATTT  |
| 2   | Oligo pool      | Tile 3 (14280 oligos) | 272 nt | ATTT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[ATTT]----oligo+BC----[AGAA]
   ATGA                    ATTT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1     | 831 nt  | ATTT  | TTTC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1545 nt | TTTC  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1710 nt | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1203 nt | GAAA  | GAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATTT]----3'WT sub1----[TTTC]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT sub5----[GAAA]----3'WT sub6----[GAAA]----3'WT+PolIII sub7----[CACC]
   ATTT                   TTTC                   GAAA                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 4 of 64 -- Codons 176-215 (120 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAT     | 0.7737   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 7560 mutations, 7560 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 543 nt | ATGA  | AAAT  |
| 2   | Oligo pool      | Tile 4 (7560 oligos)  | 176 nt | AAAT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[AAAT]----oligo+BC----[AGAA]
   ATGA                    AAAT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1     | 723 nt  | TGAA  | TTTC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1545 nt | TTTC  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1710 nt | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1203 nt | GAAA  | GAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[TTTC]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT sub5----[GAAA]----3'WT sub6----[GAAA]----3'WT+PolIII sub7----[CACC]
   TGAA                   TTTC                   GAAA                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 5 of 64 -- Codons 212-268 (171 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAT     | 0.7246   |
| oh2 (3' boundary) | GATT     | 0.6417   |

**Variants:** 11130 mutations, 11130 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 651 nt | ATGA  | GAAT  |
| 2   | Oligo pool      | Tile 5 (11130 oligos) | 227 nt | GAAT  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1     | 564 nt  | GATT  | TTTC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1545 nt | TTTC  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1710 nt | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1203 nt | GAAA  | GAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GATT]----3'WT sub1----[TTTC]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT sub5----[GAAA]----3'WT sub6----[GAAA]----3'WT+PolIII sub7----[CACC]
   GATT                   TTTC                   GAAA                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 6 of 64 -- Codons 265-297 (99 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | CTCA     | 0.6872   |

**Variants:** 6090 mutations, 6090 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 810 nt | ATGA  | AAGA  |
| 2   | Oligo pool      | Tile 6 (6090 oligos)  | 155 nt | AAGA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1     | 477 nt  | CTCA  | TTTC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1545 nt | TTTC  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1710 nt | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1203 nt | GAAA  | GAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTCA]----3'WT sub1----[TTTC]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT sub5----[GAAA]----3'WT sub6----[GAAA]----3'WT+PolIII sub7----[CACC]
   CTCA                   TTTC                   GAAA                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 7 of 64 -- Codons 294-354 (183 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAA     | 0.9502   |
| oh2 (3' boundary) | TGAC     | 0.6485   |

**Variants:** 11970 mutations, 11970 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 897 nt | ATGA  | AAAA  |
| 2   | Oligo pool      | Tile 7 (11970 oligos) | 239 nt | AAAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[AAAA]----oligo+BC----[AGAA]
   ATGA                    AAAA                  AGAA 
```

**Set fidelity:** 0.9907 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1     | 306 nt  | TGAC  | TTTC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1545 nt | TTTC  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1710 nt | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1203 nt | GAAA  | GAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAC]----3'WT sub1----[TTTC]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT sub5----[GAAA]----3'WT sub6----[GAAA]----3'WT+PolIII sub7----[CACC]
   TGAC                   TTTC                   GAAA                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 8 of 64 -- Codons 351-414 (192 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | CTAT     | 0.7299   |

**Variants:** 12600 mutations, 12600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1068 nt | ATGA  | AAGA  |
| 2   | Oligo pool      | Tile 8 (12600 oligos) | 248 nt  | AAGA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1     | 1653 nt | CTAT  | TTTC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1710 nt | TTTC  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1203 nt | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTAT]----3'WT sub1----[TTTC]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT sub5----[GAAA]----3'WT+PolIII sub6----[GAAA][CACC]
   CTAT                   TTTC                   GAAA                   GAAA                   GAAA                   GAAA                          GAAA  CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 9 of 64 -- Codons 411-453 (129 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTG     | 0.6684   |
| oh2 (3' boundary) | GAAG     | 0.6752   |

**Variants:** 8190 mutations, 8190 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1248 nt | ATGA  | TCTG  |
| 2   | Oligo pool      | Tile 9 (8190 oligos)  | 185 nt  | TCTG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT block----[TCTG]----oligo+BC----[AGAA]
   ATGA                    TCTG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1     | 1536 nt | GAAG  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1710 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1203 nt | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAG]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT sub5----[GAAA]----3'WT+PolIII sub6----[CACC]
   GAAG                   GAAA                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9260 (3 overhangs)

---

### Tile 10 of 64 -- Codons 451-492 (126 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CACC     | 0.4172   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 7980 mutations, 7980 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1368 nt | ATGA  | CACC  |
| 2   | Oligo pool      | Tile 10 (7980 oligos) | 182 nt  | CACC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----oligo+BC----[CACC][AGAA]
   ATGA                   TTTC                  CACC  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1    | 1419 nt | TGAA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1710 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1203 nt | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT sub5----[GAAA]----3'WT+PolIII sub6----[CACC]
   TGAA                   GAAA                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 11 of 64 -- Codons 489-556 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGAA     | 0.7463   |
| oh2 (3' boundary) | GCAA     | 0.7543   |

**Variants:** 13440 mutations, 13440 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1482 nt | ATGA  | GGAA  |
| 2   | Oligo pool      | Tile 11 (13440 oligos) | 260 nt  | GGAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----oligo+BC----[GGAA][AGAA]
   ATGA                   TTTC                  GGAA  AGAA 
```

**Set fidelity:** 0.9472 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1    | 1227 nt | GCAA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1710 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1203 nt | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCAA]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT sub5----[GAAA]----3'WT+PolIII sub6----[CACC]
   GCAA                   GAAA                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9940 (3 overhangs)

---

### Tile 12 of 64 -- Codons 553-601 (147 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AACA     | 0.8032   |
| oh2 (3' boundary) | TCAT     | 0.8102   |

**Variants:** 9450 mutations, 9450 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2  | 328 nt  | TTTC  | AACA  |
| 3   | Oligo pool      | Tile 12 (9450 oligos) | 203 nt  | AACA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[AACA]----oligo+BC----[AGAA]
   ATGA                   TTTC                   AACA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1    | 1092 nt | TCAT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1710 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1203 nt | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAT]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT sub5----[GAAA]----3'WT+PolIII sub6----[CACC]
   TCAT                   GAAA                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 13 of 64 -- Codons 598-629 (96 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAT     | 0.7737   |
| oh2 (3' boundary) | GGAA     | 0.7463   |

**Variants:** 5880 mutations, 5880 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2  | 463 nt  | TTTC  | AAAT  |
| 3   | Oligo pool      | Tile 13 (5880 oligos) | 152 nt  | AAAT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[AAAT]----oligo+BC----[AGAA]
   ATGA                   TTTC                   AAAT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1    | 1008 nt | GGAA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1710 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1203 nt | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAA]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT sub5----[GAAA]----3'WT+PolIII sub6----[CACC]
   GGAA                   GAAA                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9596 (3 overhangs)

---

### Tile 14 of 64 -- Codons 626-676 (153 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAT     | 0.7737   |
| oh2 (3' boundary) | CTTT     | 0.6635   |

**Variants:** 9870 mutations, 9870 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2  | 547 nt  | TTTC  | AAAT  |
| 3   | Oligo pool      | Tile 14 (9870 oligos) | 209 nt  | AAAT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[AAAT]----oligo+BC----[AGAA]
   ATGA                   TTTC                   AAAT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1    | 867 nt  | CTTT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1710 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1203 nt | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTTT]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT sub5----[GAAA]----3'WT+PolIII sub6----[CACC]
   CTTT                   GAAA                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 15 of 64 -- Codons 673-746 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAG     | 0.7814   |
| oh2 (3' boundary) | TAAC     | 0.7715   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 688 nt  | TTTC  | TCAG  |
| 3   | Oligo pool      | Tile 15 (14700 oligos) | 278 nt  | TCAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[TCAG]----oligo+BC----[AGAA]
   ATGA                   TTTC                   TCAG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1    | 657 nt  | TAAC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1710 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1203 nt | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAAC]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT sub5----[GAAA]----3'WT+PolIII sub6----[CACC]
   TAAC                   GAAA                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9983 (3 overhangs)

---

### Tile 16 of 64 -- Codons 743-807 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCT     | 0.7151   |
| oh2 (3' boundary) | TGAT     | 0.6933   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 898 nt  | TTTC  | ATCT  |
| 3   | Oligo pool      | Tile 16 (12810 oligos) | 251 nt  | ATCT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[ATCT]----oligo+BC----[AGAA]
   ATGA                   TTTC                   ATCT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1    | 474 nt  | TGAT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1710 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1203 nt | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAT]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT sub5----[GAAA]----3'WT+PolIII sub6----[CACC]
   TGAT                   GAAA                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 17 of 64 -- Codons 804-843 (120 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTT     | 0.7985   |
| oh2 (3' boundary) | TTTT     | 0.8623   |

**Variants:** 7560 mutations, 7560 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2  | 1081 nt | TTTC  | TCTT  |
| 3   | Oligo pool      | Tile 17 (7560 oligos) | 176 nt  | TCTT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[TCTT]----oligo+BC----[AGAA]
   ATGA                   TTTC                   TCTT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1    | 366 nt  | TTTT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1710 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1203 nt | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTTT]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT sub5----[GAAA]----3'WT+PolIII sub6----[CACC]
   TTTT                   GAAA                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 18 of 64 -- Codons 840-888 (147 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AACT     | 0.6635   |
| oh2 (3' boundary) | AAAA     | 0.9502   |

**Variants:** 9450 mutations, 9450 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1189 nt | TTTC  | AACT  |
| 3   | Oligo pool      | Tile 18 (9450 oligos) | 203 nt  | AACT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[AACT]----oligo+BC----[AGAA]
   ATGA                   TTTC                   AACT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1    | 231 nt  | AAAA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1710 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1203 nt | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAA]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT sub5----[GAAA]----3'WT+PolIII sub6----[CACC]
   AAAA                   GAAA                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9814 (3 overhangs)

---

### Tile 19 of 64 -- Codons 885-931 (141 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTTC     | 0.6384   |
| oh2 (3' boundary) | AAAT     | 0.7737   |

**Variants:** 9030 mutations, 9030 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1324 nt | TTTC  | CTTC  |
| 3   | Oligo pool      | Tile 19 (9030 oligos) | 197 nt  | CTTC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[CTTC]----oligo+BC----[AGAA]
   ATGA                   TTTC                   CTTC                  AGAA 
```

**Set fidelity:** 0.9280 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1    | 1794 nt | AAAT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1203 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAT]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT+PolIII sub5----[GAAA][CACC]
   AAAT                   GAAA                   GAAA                   GAAA                   GAAA                          GAAA  CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 20 of 64 -- Codons 928-963 (108 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCA     | 0.8519   |
| oh2 (3' boundary) | GAGC     | 0.5446   |

**Variants:** 6720 mutations, 6720 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2  | 1453 nt | TTTC  | TCCA  |
| 3   | Oligo pool      | Tile 20 (6720 oligos) | 164 nt  | TCCA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[TCCA]----oligo+BC----[AGAA]
   ATGA                   TTTC                   TCCA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1    | 1698 nt | GAGC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1203 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAGC]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT+PolIII sub5----[CACC]
   GAGC                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 21 of 64 -- Codons 960-1005 (138 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACAC     | 0.5629   |
| oh2 (3' boundary) | AGAT     | 0.6825   |

**Variants:** 8820 mutations, 8820 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1549 nt | TTTC  | ACAC  |
| 3   | Oligo pool      | Tile 21 (8820 oligos) | 194 nt  | ACAC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----oligo+BC----[ACAC][AGAA]
   ATGA                   TTTC                   GAAA                  ACAC  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1    | 1572 nt | AGAT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1203 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAT]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT+PolIII sub5----[CACC]
   AGAT                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 22 of 64 -- Codons 1002-1070 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | ATTC     | 0.7084   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1675 nt | TTTC  | AAGA  |
| 3   | Oligo pool      | Tile 22 (13650 oligos) | 263 nt  | AAGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----oligo+BC----[AAGA][AGAA]
   ATGA                   TTTC                   GAAA                  AAGA  AGAA 
```

**Set fidelity:** 0.9574 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1    | 1377 nt | ATTC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1203 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATTC]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT+PolIII sub5----[CACC]
   ATTC                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 23 of 64 -- Codons 1067-1114 (144 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGG     | 0.6552   |
| oh2 (3' boundary) | GAAT     | 0.7246   |

**Variants:** 9240 mutations, 9240 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2  | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3  | 343 nt  | GAAA  | AAGG  |
| 4   | Oligo pool      | Tile 23 (9240 oligos) | 200 nt  | AAGG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[AAGG]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   AAGG                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1    | 1245 nt | GAAT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1203 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAT]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT+PolIII sub5----[CACC]
   GAAT                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9146 (3 overhangs)

---

### Tile 24 of 64 -- Codons 1111-1148 (114 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATA     | 0.8816   |
| oh2 (3' boundary) | CAAG     | 0.6640   |

**Variants:** 7140 mutations, 7140 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2  | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3  | 475 nt  | GAAA  | AATA  |
| 4   | Oligo pool      | Tile 24 (7140 oligos) | 170 nt  | AATA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[AATA]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   AATA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile24_sub1    | 1143 nt | CAAG  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1203 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAG]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT+PolIII sub5----[CACC]
   CAAG                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 25 of 64 -- Codons 1145-1209 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGGA     | 0.7515   |
| oh2 (3' boundary) | AAAA     | 0.9502   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2   | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3   | 577 nt  | GAAA  | AGGA  |
| 4   | Oligo pool      | Tile 25 (12810 oligos) | 251 nt  | AGGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[AGGA]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   AGGA                  AGAA 
```

**Set fidelity:** 0.9656 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile25_sub1    | 960 nt  | AAAA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1203 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAA]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT+PolIII sub5----[CACC]
   AAAA                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9814 (3 overhangs)

---

### Tile 26 of 64 -- Codons 1206-1244 (117 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTTT     | 0.8623   |
| oh2 (3' boundary) | AAAA     | 0.9502   |

**Variants:** 7350 mutations, 7350 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2  | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3  | 760 nt  | GAAA  | TTTT  |
| 4   | Oligo pool      | Tile 26 (7350 oligos) | 173 nt  | TTTT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[TTTT]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   TTTT                  AGAA 
```

**Set fidelity:** 0.9669 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile26_sub1    | 855 nt  | AAAA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1203 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAA]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT+PolIII sub5----[CACC]
   AAAA                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9814 (3 overhangs)

---

### Tile 27 of 64 -- Codons 1241-1304 (192 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTT     | 0.7985   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 12600 mutations, 12600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2   | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 865 nt  | GAAA  | TCTT  |
| 4   | Oligo pool      | Tile 27 (12600 oligos) | 248 nt  | TCTT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[TCTT]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   TCTT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile27_sub1    | 675 nt  | TGAA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1203 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT+PolIII sub5----[CACC]
   TGAA                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 28 of 64 -- Codons 1301-1355 (165 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTC     | 0.7084   |
| oh2 (3' boundary) | ATTC     | 0.7084   |

**Variants:** 10710 mutations, 10710 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2   | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1045 nt | GAAA  | ATTC  |
| 4   | Oligo pool      | Tile 28 (10710 oligos) | 221 nt  | ATTC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[ATTC]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   ATTC                  AGAA 
```

**Set fidelity:** 0.9209 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile28_sub1    | 522 nt  | ATTC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1203 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATTC]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT+PolIII sub5----[CACC]
   ATTC                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 29 of 64 -- Codons 1352-1389 (114 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATA     | 0.8816   |
| oh2 (3' boundary) | AAAT     | 0.7737   |

**Variants:** 7140 mutations, 7140 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2  | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile29_sub3  | 1198 nt | GAAA  | AATA  |
| 4   | Oligo pool      | Tile 29 (7140 oligos) | 170 nt  | AATA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[AATA]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   AATA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile29_sub1    | 420 nt  | AAAT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1203 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAT]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT+PolIII sub5----[CACC]
   AAAT                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 30 of 64 -- Codons 1386-1420 (105 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TATT     | 0.8134   |
| oh2 (3' boundary) | TTCC     | 0.7958   |

**Variants:** 6510 mutations, 6510 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2  | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3  | 1300 nt | GAAA  | TATT  |
| 4   | Oligo pool      | Tile 30 (6510 oligos) | 161 nt  | TATT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[TATT]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   TATT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile30_sub1    | 327 nt  | TTCC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1203 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCC]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT+PolIII sub5----[CACC]
   TTCC                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9988 (3 overhangs)

---

### Tile 31 of 64 -- Codons 1417-1493 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCA     | 0.8519   |
| oh2 (3' boundary) | CCAA     | 0.8439   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2   | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile31_sub3   | 1393 nt | GAAA  | TCCA  |
| 4   | Oligo pool      | Tile 31 (15330 oligos) | 287 nt  | TCCA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[TCCA]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   TCCA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile31_sub1    | 1293 nt | CCAA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCAA]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT+PolIII sub4----[GAAA][CACC]
   CCAA                   GAAA                   GAAA                   GAAA                          GAAA  CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 32 of 64 -- Codons 1490-1527 (114 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAT     | 0.7246   |
| oh2 (3' boundary) | TGGG     | 0.5031   |

**Variants:** 7140 mutations, 7140 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2  | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile32_sub3  | 1612 nt | GAAA  | GAAT  |
| 4   | Oligo pool      | Tile 32 (7140 oligos) | 170 nt  | GAAT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAT]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   GAAT                  AGAA 
```

**Set fidelity:** 0.9218 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile32_sub1    | 1191 nt | TGGG  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGGG]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT+PolIII sub4----[CACC]
   TGGG                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 33 of 64 -- Codons 1524-1571 (144 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GATT     | 0.6417   |
| oh2 (3' boundary) | CCTT     | 0.6891   |

**Variants:** 9240 mutations, 9240 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2  | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile33_sub3  | 1714 nt | GAAA  | GATT  |
| 4   | Oligo pool      | Tile 33 (9240 oligos) | 200 nt  | GATT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----oligo+BC----[GATT][AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                  GATT  AGAA 
```

**Set fidelity:** 0.9979 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile33_sub1    | 1059 nt | CCTT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTT]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT+PolIII sub4----[CACC]
   CCTT                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 34 of 64 -- Codons 1568-1639 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAA     | 0.9502   |
| oh2 (3' boundary) | TTCC     | 0.7958   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2   | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile34_sub4   | 154 nt  | GAAA  | AAAA  |
| 5   | Oligo pool      | Tile 34 (14280 oligos) | 272 nt  | AAAA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[AAAA]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   AAAA                  AGAA 
```

**Set fidelity:** 0.9605 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile34_sub1    | 855 nt  | TTCC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCC]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT+PolIII sub4----[CACC]
   TTCC                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9988 (3 overhangs)

---

### Tile 35 of 64 -- Codons 1636-1684 (147 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GATA     | 0.7029   |
| oh2 (3' boundary) | GGAA     | 0.7463   |

**Variants:** 9450 mutations, 9450 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2  | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3  | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile35_sub4  | 358 nt  | GAAA  | GATA  |
| 5   | Oligo pool      | Tile 35 (9450 oligos) | 203 nt  | GATA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[GATA]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   GATA                  AGAA 
```

**Set fidelity:** 0.9611 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile35_sub1    | 720 nt  | GGAA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAA]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT+PolIII sub4----[CACC]
   GGAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9596 (3 overhangs)

---

### Tile 36 of 64 -- Codons 1681-1752 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGA     | 0.8175   |
| oh2 (3' boundary) | TTCC     | 0.7958   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2   | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4   | 493 nt  | GAAA  | CAGA  |
| 5   | Oligo pool      | Tile 36 (14280 oligos) | 272 nt  | CAGA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[CAGA]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   CAGA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile36_sub1    | 516 nt  | TTCC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCC]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT+PolIII sub4----[CACC]
   TTCC                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9988 (3 overhangs)

---

### Tile 37 of 64 -- Codons 1749-1805 (171 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCG     | 0.7234   |
| oh2 (3' boundary) | CGAG     | 0.5351   |

**Variants:** 11130 mutations, 11130 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2   | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile37_sub4   | 697 nt  | GAAA  | TCCG  |
| 5   | Oligo pool      | Tile 37 (11130 oligos) | 227 nt  | TCCG  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[TCCG]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   TCCG                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile37_sub1    | 357 nt  | CGAG  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CGAG]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT+PolIII sub4----[CACC]
   CGAG                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 38 of 64 -- Codons 1802-1856 (165 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | TGGA     | 0.7377   |

**Variants:** 10710 mutations, 10710 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2   | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile38_sub4   | 856 nt  | GAAA  | AAGA  |
| 5   | Oligo pool      | Tile 38 (10710 oligos) | 221 nt  | AAGA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[AAGA]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   AAGA                  AGAA 
```

**Set fidelity:** 0.9574 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile38_sub1    | 921 nt  | TGGA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGGA]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT+PolIII sub3----[GAAA][CACC]
   TGGA                   GAAA                   GAAA                          GAAA  CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 39 of 64 -- Codons 1853-1922 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGA     | 0.8175   |
| oh2 (3' boundary) | GGCA     | 0.5273   |

**Variants:** 13860 mutations, 13860 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2   | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile39_sub4   | 1009 nt | GAAA  | CAGA  |
| 5   | Oligo pool      | Tile 39 (13860 oligos) | 266 nt  | CAGA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[CAGA]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   CAGA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile39_sub1    | 723 nt  | GGCA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGCA]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT+PolIII sub3----[CACC]
   GGCA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 40 of 64 -- Codons 1919-1969 (153 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGCA     | 0.5690   |
| oh2 (3' boundary) | GAGA     | 0.7444   |

**Variants:** 9870 mutations, 9870 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2  | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3  | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile40_sub4  | 1207 nt | GAAA  | AGCA  |
| 5   | Oligo pool      | Tile 40 (9870 oligos) | 209 nt  | AGCA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[GAAA]----oligo+BC----[AGCA][AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   GAAA                  AGCA  AGAA 
```

**Set fidelity:** 0.9812 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile40_sub1    | 582 nt  | GAGA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAGA]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT+PolIII sub3----[CACC]
   GAGA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9711 (3 overhangs)

---

### Tile 41 of 64 -- Codons 1966-2011 (138 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTT     | 0.7985   |
| oh2 (3' boundary) | AAAA     | 0.9502   |

**Variants:** 8820 mutations, 8820 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2  | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3  | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile41_sub4  | 1348 nt | GAAA  | TCTT  |
| 5   | Oligo pool      | Tile 41 (8820 oligos) | 194 nt  | TCTT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[GAAA]----oligo+BC----[TCTT][AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   GAAA                  TCTT  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile41_sub1    | 456 nt  | AAAA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAA]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT+PolIII sub3----[CACC]
   AAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9814 (3 overhangs)

---

### Tile 42 of 64 -- Codons 2008-2064 (171 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGA     | 0.7549   |
| oh2 (3' boundary) | AAAT     | 0.7737   |

**Variants:** 11130 mutations, 11130 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2   | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile42_sub4   | 1474 nt | GAAA  | ATGA  |
| 5   | Oligo pool      | Tile 42 (11130 oligos) | 227 nt  | ATGA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[GAAA]----oligo+BC----[ATGA][AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   GAAA                  ATGA  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile42_sub1    | 297 nt  | AAAT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1467 nt | GAAA  | GAAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAT]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT+PolIII sub3----[CACC]
   AAAT                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 43 of 64 -- Codons 2061-2130 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TATT     | 0.8134   |
| oh2 (3' boundary) | GAGA     | 0.7444   |

**Variants:** 13860 mutations, 13860 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2   | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4   | 1203 nt | GAAA  | GAAA  |
| 5   | 5'WT gene block | bsai_5wt_tile43_sub5   | 448 nt  | GAAA  | TATT  |
| 6   | Oligo pool      | Tile 43 (13860 oligos) | 266 nt  | TATT  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[GAAA]----5'WT sub5----[TATT]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   GAAA                   TATT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile43_sub1    | 1548 nt | GAGA  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAGA]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[GAAA][CACC]
   GAGA                   GAAA                          GAAA  CACC 
```

**Set fidelity:** 0.9711 (3 overhangs)

---

### Tile 44 of 64 -- Codons 2127-2161 (105 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAT     | 0.7246   |
| oh2 (3' boundary) | CCAG     | 0.6122   |

**Variants:** 6510 mutations, 6510 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2  | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3  | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4  | 1203 nt | GAAA  | GAAA  |
| 5   | 5'WT gene block | bsai_5wt_tile44_sub5  | 646 nt  | GAAA  | GAAT  |
| 6   | Oligo pool      | Tile 44 (6510 oligos) | 161 nt  | GAAT  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[GAAA]----5'WT sub5----[GAAT]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   GAAA                   GAAT                  AGAA 
```

**Set fidelity:** 0.9218 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile44_sub1    | 1455 nt | CCAG  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCAG]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   CCAG                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 45 of 64 -- Codons 2158-2218 (183 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCG     | 0.5700   |
| oh2 (3' boundary) | TATC     | 0.8041   |

**Variants:** 11970 mutations, 11970 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2   | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4   | 1203 nt | GAAA  | GAAA  |
| 5   | 5'WT gene block | bsai_5wt_tile45_sub5   | 739 nt  | GAAA  | ATCG  |
| 6   | Oligo pool      | Tile 45 (11970 oligos) | 239 nt  | ATCG  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[GAAA]----5'WT sub5----[GAAA]----oligo+BC----[ATCG][AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   GAAA                   GAAA                  ATCG  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile45_sub1    | 1284 nt | TATC  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TATC]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   TATC                   GAAA                          CACC 
```

**Set fidelity:** 0.9961 (3 overhangs)

---

### Tile 46 of 64 -- Codons 2215-2253 (117 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | TTCA     | 0.8824   |

**Variants:** 7350 mutations, 7350 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2  | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3  | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4  | 1203 nt | GAAA  | GAAA  |
| 5   | 5'WT gene block | bsai_5wt_tile46_sub5  | 910 nt  | GAAA  | AAGA  |
| 6   | Oligo pool      | Tile 46 (7350 oligos) | 173 nt  | AAGA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[GAAA]----5'WT sub5----[GAAA]----oligo+BC----[AAGA][AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   GAAA                   GAAA                  AAGA  AGAA 
```

**Set fidelity:** 0.9574 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile46_sub1    | 1179 nt | TTCA  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCA]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   TTCA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 47 of 64 -- Codons 2250-2283 (102 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTT     | 0.7664   |
| oh2 (3' boundary) | GCCA     | 0.5727   |

**Variants:** 6300 mutations, 6300 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2  | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3  | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4  | 1203 nt | GAAA  | GAAA  |
| 5   | 5'WT gene block | bsai_5wt_tile47_sub5  | 1015 nt | GAAA  | ATTT  |
| 6   | Oligo pool      | Tile 47 (6300 oligos) | 158 nt  | ATTT  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[GAAA]----5'WT sub5----[GAAA]----oligo+BC----[ATTT][AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   GAAA                   GAAA                  ATTT  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile47_sub1    | 1089 nt | GCCA  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCCA]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   GCCA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 48 of 64 -- Codons 2280-2338 (177 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTGA     | 0.8853   |
| oh2 (3' boundary) | GCCC     | 0.5462   |

**Variants:** 11550 mutations, 11550 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2   | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4   | 1203 nt | GAAA  | GAAA  |
| 5   | 5'WT gene block | bsai_5wt_tile48_sub5   | 735 nt  | GAAA  | GAAA  |
| 6   | 5'WT gene block | bsai_5wt_tile48_sub6   | 388 nt  | GAAA  | TTGA  |
| 7   | Oligo pool      | Tile 48 (11550 oligos) | 233 nt  | TTGA  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[GAAA]----5'WT sub5----[GAAA]----5'WT sub6----[TTGA]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   GAAA                   GAAA                   TTGA                  AGAA 
```

**Set fidelity:** 0.9643 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile48_sub1    | 924 nt  | GCCC  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCCC]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   GCCC                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 49 of 64 -- Codons 2335-2368 (102 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGGA     | 0.7515   |
| oh2 (3' boundary) | AGGT     | 0.6250   |

**Variants:** 6300 mutations, 6300 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2  | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3  | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4  | 1203 nt | GAAA  | GAAA  |
| 5   | 5'WT gene block | bsai_5wt_tile48_sub5  | 735 nt  | GAAA  | GAAA  |
| 6   | 5'WT gene block | bsai_5wt_tile49_sub6  | 553 nt  | GAAA  | AGGA  |
| 7   | Oligo pool      | Tile 49 (6300 oligos) | 158 nt  | AGGA  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[GAAA]----5'WT sub5----[GAAA]----5'WT sub6----[AGGA]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   GAAA                   GAAA                   AGGA                  AGAA 
```

**Set fidelity:** 0.9656 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile49_sub1    | 834 nt  | AGGT  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGGT]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   AGGT                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 50 of 64 -- Codons 2365-2419 (165 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | CAGG     | 0.5358   |

**Variants:** 10710 mutations, 10710 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2   | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4   | 1203 nt | GAAA  | GAAA  |
| 5   | 5'WT gene block | bsai_5wt_tile48_sub5   | 735 nt  | GAAA  | GAAA  |
| 6   | 5'WT gene block | bsai_5wt_tile50_sub6   | 643 nt  | GAAA  | AAGA  |
| 7   | Oligo pool      | Tile 50 (10710 oligos) | 221 nt  | AAGA  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[GAAA]----5'WT sub5----[GAAA]----5'WT sub6----[AAGA]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   GAAA                   GAAA                   AAGA                  AGAA 
```

**Set fidelity:** 0.9574 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile50_sub1    | 681 nt  | CAGG  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAGG]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   CAGG                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 51 of 64 -- Codons 2416-2470 (165 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAGA     | 0.7444   |
| oh2 (3' boundary) | CAAG     | 0.6640   |

**Variants:** 10710 mutations, 10710 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2   | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4   | 1203 nt | GAAA  | GAAA  |
| 5   | 5'WT gene block | bsai_5wt_tile48_sub5   | 735 nt  | GAAA  | GAAA  |
| 6   | 5'WT gene block | bsai_5wt_tile51_sub6   | 796 nt  | GAAA  | GAGA  |
| 7   | Oligo pool      | Tile 51 (10710 oligos) | 221 nt  | GAGA  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[GAAA]----5'WT sub5----[GAAA]----5'WT sub6----[GAGA]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   GAAA                   GAAA                   GAGA                  AGAA 
```

**Set fidelity:** 0.9778 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile51_sub1    | 528 nt  | CAAG  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAG]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   CAAG                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 52 of 64 -- Codons 2467-2502 (108 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTC     | 0.8105   |
| oh2 (3' boundary) | CTTC     | 0.6384   |

**Variants:** 6720 mutations, 6720 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2  | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3  | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4  | 1203 nt | GAAA  | GAAA  |
| 5   | 5'WT gene block | bsai_5wt_tile48_sub5  | 735 nt  | GAAA  | GAAA  |
| 6   | 5'WT gene block | bsai_5wt_tile52_sub6  | 949 nt  | GAAA  | TCTC  |
| 7   | Oligo pool      | Tile 52 (6720 oligos) | 164 nt  | TCTC  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[GAAA]----5'WT sub5----[GAAA]----5'WT sub6----[TCTC]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   GAAA                   GAAA                   TCTC                  AGAA 
```

**Set fidelity:** 0.9790 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile52_sub1    | 432 nt  | CTTC  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTTC]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   CTTC                   GAAA                          CACC 
```

**Set fidelity:** 0.9984 (3 overhangs)

---

### Tile 53 of 64 -- Codons 2499-2546 (144 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCT     | 0.7573   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 9240 mutations, 9240 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2  | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3  | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4  | 1203 nt | GAAA  | GAAA  |
| 5   | 5'WT gene block | bsai_5wt_tile48_sub5  | 735 nt  | GAAA  | GAAA  |
| 6   | 5'WT gene block | bsai_5wt_tile53_sub6  | 1045 nt | GAAA  | TCCT  |
| 7   | Oligo pool      | Tile 53 (9240 oligos) | 200 nt  | TCCT  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[GAAA]----5'WT sub5----[GAAA]----5'WT sub6----[TCCT]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   GAAA                   GAAA                   TCCT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile53_sub1    | 300 nt  | TGAA  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   TGAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 54 of 64 -- Codons 2543-2609 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AACG     | 0.5566   |
| oh2 (3' boundary) | CTTT     | 0.6635   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2   | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4   | 1203 nt | GAAA  | GAAA  |
| 5   | 5'WT gene block | bsai_5wt_tile48_sub5   | 735 nt  | GAAA  | GAAA  |
| 6   | 5'WT gene block | bsai_5wt_tile54_sub6   | 1177 nt | GAAA  | AACG  |
| 7   | Oligo pool      | Tile 54 (13230 oligos) | 257 nt  | AACG  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[GAAA]----5'WT sub5----[GAAA]----5'WT sub6----[AACG]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   GAAA                   GAAA                   AACG                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile54_sub1    | 111 nt  | CTTT  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 2486 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTTT]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   CTTT                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 55 of 64 -- Codons 2606-2643 (114 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTC     | 0.7084   |
| oh2 (3' boundary) | TGAG     | 0.6546   |

**Variants:** 7140 mutations, 7140 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2  | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3  | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4  | 1203 nt | GAAA  | GAAA  |
| 5   | 5'WT gene block | bsai_5wt_tile48_sub5  | 735 nt  | GAAA  | GAAA  |
| 6   | 5'WT gene block | bsai_5wt_tile55_sub6  | 1366 nt | GAAA  | ATTC  |
| 7   | Oligo pool      | Tile 55 (7140 oligos) | 170 nt  | ATTC  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[GAAA]----5'WT sub5----[GAAA]----5'WT sub6----[ATTC]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   GAAA                   GAAA                   ATTC                  AGAA 
```

**Set fidelity:** 0.9209 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile55_sub1    | 699 nt  | TGAG  | --    |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile55_sub2    | 1796 nt | --    | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAG]----3'WT+PolIII----[CACC]
   TGAG                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 56 of 64 -- Codons 2641-2700 (180 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAT     | 0.7737   |
| oh2 (3' boundary) | GGAA     | 0.7463   |

**Variants:** 11760 mutations, 11760 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2   | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4   | 1203 nt | GAAA  | GAAA  |
| 5   | 5'WT gene block | bsai_5wt_tile48_sub5   | 735 nt  | GAAA  | GAAA  |
| 6   | 5'WT gene block | bsai_5wt_tile56_sub6   | 1471 nt | GAAA  | AAAT  |
| 7   | Oligo pool      | Tile 56 (11760 oligos) | 236 nt  | AAAT  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[GAAA]----5'WT sub5----[GAAA]----5'WT sub6----[GAAA]----oligo+BC----[AAAT][AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   GAAA                   GAAA                   GAAA                  AAAT  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile56_sub1    | 699 nt  | GGAA  | --    |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile56_sub2    | 1625 nt | --    | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAA]----3'WT+PolIII----[CACC]
   GGAA                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 57 of 64 -- Codons 2697-2767 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAGA     | 0.7444   |
| oh2 (3' boundary) | TTCA     | 0.8824   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2   | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4   | 1203 nt | GAAA  | GAAA  |
| 5   | 5'WT gene block | bsai_5wt_tile48_sub5   | 735 nt  | GAAA  | GAAA  |
| 6   | 5'WT gene block | bsai_5wt_tile57_sub6   | 1639 nt | GAAA  | GAGA  |
| 7   | Oligo pool      | Tile 57 (14070 oligos) | 269 nt  | GAGA  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[GAAA]----5'WT sub5----[GAAA]----5'WT sub6----[GAAA]----oligo+BC----[GAGA][AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   GAAA                   GAAA                   GAAA                  GAGA  AGAA 
```

**Set fidelity:** 0.9778 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile57_sub1    | 498 nt  | TTCA  | --    |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile56_sub2    | 1625 nt | --    | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCA]----3'WT+PolIII----[CACC]
   TTCA                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 58 of 64 -- Codons 2764-2814 (153 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GACA     | 0.6127   |
| oh2 (3' boundary) | TGAT     | 0.6933   |

**Variants:** 9870 mutations, 9870 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2  | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3  | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4  | 1203 nt | GAAA  | GAAA  |
| 5   | 5'WT gene block | bsai_5wt_tile48_sub5  | 735 nt  | GAAA  | GAAA  |
| 6   | 5'WT gene block | bsai_5wt_tile58_sub6  | 1467 nt | GAAA  | GAAA  |
| 7   | 5'WT gene block | bsai_5wt_tile58_sub7  | 391 nt  | GAAA  | GACA  |
| 8   | Oligo pool      | Tile 58 (9870 oligos) | 209 nt  | GACA  | AGAA  |
| 9   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 10  | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[GAAA]----5'WT sub5----[GAAA]----5'WT sub6----[GAAA]----5'WT sub7----[GACA]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   GAAA                   GAAA                   GAAA                   GACA                  AGAA 
```

**Set fidelity:** 0.9966 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile58_sub1    | 357 nt  | TGAT  | --    |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile56_sub2    | 1625 nt | --    | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAT]----3'WT+PolIII----[CACC]
   TGAT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 59 of 64 -- Codons 2811-2860 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 9660 mutations, 9660 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2  | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3  | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4  | 1203 nt | GAAA  | GAAA  |
| 5   | 5'WT gene block | bsai_5wt_tile48_sub5  | 735 nt  | GAAA  | GAAA  |
| 6   | 5'WT gene block | bsai_5wt_tile58_sub6  | 1467 nt | GAAA  | GAAA  |
| 7   | 5'WT gene block | bsai_5wt_tile59_sub7  | 532 nt  | GAAA  | AAGA  |
| 8   | Oligo pool      | Tile 59 (9660 oligos) | 206 nt  | AAGA  | AGAA  |
| 9   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 10  | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[GAAA]----5'WT sub5----[GAAA]----5'WT sub6----[GAAA]----5'WT sub7----[AAGA]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   GAAA                   GAAA                   GAAA                   AAGA                  AGAA 
```

**Set fidelity:** 0.9574 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile59_sub1    | 489 nt  | TGAA  | --    |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile59_sub2    | 1355 nt | --    | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT+PolIII----[CACC]
   TGAA                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 60 of 64 -- Codons 2857-2921 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GACA     | 0.6127   |
| oh2 (3' boundary) | TATC     | 0.8041   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2   | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4   | 1203 nt | GAAA  | GAAA  |
| 5   | 5'WT gene block | bsai_5wt_tile48_sub5   | 735 nt  | GAAA  | GAAA  |
| 6   | 5'WT gene block | bsai_5wt_tile58_sub6   | 1467 nt | GAAA  | GAAA  |
| 7   | 5'WT gene block | bsai_5wt_tile60_sub7   | 670 nt  | GAAA  | GACA  |
| 8   | Oligo pool      | Tile 60 (12810 oligos) | 251 nt  | GACA  | AGAA  |
| 9   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 10  | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[GAAA]----5'WT sub5----[GAAA]----5'WT sub6----[GAAA]----5'WT sub7----[GACA]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   GAAA                   GAAA                   GAAA                   GACA                  AGAA 
```

**Set fidelity:** 0.9966 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile60         | 1643 nt | TATC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TATC]----3'WT+PolIII----[CACC]
   TATC                     CACC 
```

**Set fidelity:** 0.9961 (2 overhangs)

---

### Tile 61 of 64 -- Codons 2918-2985 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCTG     | 0.6383   |
| oh2 (3' boundary) | ACTT     | 0.7315   |

**Variants:** 13440 mutations, 13440 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2   | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4   | 1203 nt | GAAA  | GAAA  |
| 5   | 5'WT gene block | bsai_5wt_tile48_sub5   | 735 nt  | GAAA  | GAAA  |
| 6   | 5'WT gene block | bsai_5wt_tile58_sub6   | 1467 nt | GAAA  | GAAA  |
| 7   | 5'WT gene block | bsai_5wt_tile61_sub7   | 853 nt  | GAAA  | CCTG  |
| 8   | Oligo pool      | Tile 61 (13440 oligos) | 260 nt  | CCTG  | AGAA  |
| 9   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 10  | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[GAAA]----5'WT sub5----[GAAA]----5'WT sub6----[GAAA]----5'WT sub7----[CCTG]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   GAAA                   GAAA                   GAAA                   CCTG                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile61         | 1451 nt | ACTT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACTT]----3'WT+PolIII----[CACC]
   ACTT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 62 of 64 -- Codons 2982-3018 (111 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACAT     | 0.6621   |
| oh2 (3' boundary) | AGGA     | 0.7515   |

**Variants:** 6930 mutations, 6930 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2  | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3  | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4  | 1203 nt | GAAA  | GAAA  |
| 5   | 5'WT gene block | bsai_5wt_tile48_sub5  | 735 nt  | GAAA  | GAAA  |
| 6   | 5'WT gene block | bsai_5wt_tile58_sub6  | 1467 nt | GAAA  | GAAA  |
| 7   | 5'WT gene block | bsai_5wt_tile62_sub7  | 1045 nt | GAAA  | ACAT  |
| 8   | Oligo pool      | Tile 62 (6930 oligos) | 167 nt  | ACAT  | AGAA  |
| 9   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 10  | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[GAAA]----5'WT sub5----[GAAA]----5'WT sub6----[GAAA]----5'WT sub7----[ACAT]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   GAAA                   GAAA                   GAAA                   ACAT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile62         | 1352 nt | AGGA  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGGA]----3'WT+PolIII----[CACC]
   AGGA                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 63 of 64 -- Codons 3015-3070 (168 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACT     | 0.7445   |
| oh2 (3' boundary) | CATT     | 0.6770   |

**Variants:** 10920 mutations, 10920 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2   | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4   | 1203 nt | GAAA  | GAAA  |
| 5   | 5'WT gene block | bsai_5wt_tile48_sub5   | 735 nt  | GAAA  | GAAA  |
| 6   | 5'WT gene block | bsai_5wt_tile58_sub6   | 1467 nt | GAAA  | GAAA  |
| 7   | 5'WT gene block | bsai_5wt_tile63_sub7   | 1144 nt | GAAA  | TACT  |
| 8   | Oligo pool      | Tile 63 (10920 oligos) | 224 nt  | TACT  | AGAA  |
| 9   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 10  | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[GAAA]----5'WT sub5----[GAAA]----5'WT sub6----[GAAA]----5'WT sub7----[TACT]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   GAAA                   GAAA                   GAAA                   TACT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile63         | 1196 nt | CATT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CATT]----3'WT+PolIII----[CACC]
   CATT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 64 of 64 -- Codons 3067-3098 (96 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACTT     | 0.7315   |
| oh2 (3' boundary) | TTGA     | 0.8853   |

**Variants:** 5880 mutations, 5880 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1364 nt | ATGA  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2  | 1545 nt | TTTC  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3  | 1710 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4  | 1203 nt | GAAA  | GAAA  |
| 5   | 5'WT gene block | bsai_5wt_tile48_sub5  | 735 nt  | GAAA  | GAAA  |
| 6   | 5'WT gene block | bsai_5wt_tile58_sub6  | 1467 nt | GAAA  | GAAA  |
| 7   | 5'WT gene block | bsai_5wt_tile64_sub7  | 1300 nt | GAAA  | ACTT  |
| 8   | Oligo pool      | Tile 64 (5880 oligos) | 152 nt  | ACTT  | AGAA  |
| 9   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 10  | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TTTC]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[GAAA]----5'WT sub5----[GAAA]----5'WT sub6----[GAAA]----5'WT sub7----[ACTT]----oligo+BC----[AGAA]
   ATGA                   TTTC                   GAAA                   GAAA                   GAAA                   GAAA                   GAAA                   ACTT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component            | Part name                | Length  | 5' OH | 3' OH |
| --- | -------------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product         | (in helper plasmid)      | --      | --    | --    |
| 2   | PolIII-only fragment | bsmbi_polIII_tile64      | 1112 nt | TTGA  | CACC  |
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

**Total blocks:** 142

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| --------------------- | ----------- | ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10_sub1  | 1368        | BsaI        | 5wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile11_sub1  | 1482        | BsaI        | 5wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile12_sub1  | 1364        | BsaI        | 5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1;5wt_tile26_sub1;5wt_tile27_sub1;5wt_tile28_sub1;5wt_tile29_sub1;5wt_tile30_sub1;5wt_tile31_sub1;5wt_tile32_sub1;5wt_tile33_sub1;5wt_tile34_sub1;5wt_tile35_sub1;5wt_tile36_sub1;5wt_tile37_sub1;5wt_tile38_sub1;5wt_tile39_sub1;5wt_tile40_sub1;5wt_tile41_sub1;5wt_tile42_sub1;5wt_tile43_sub1;5wt_tile44_sub1;5wt_tile45_sub1;5wt_tile46_sub1;5wt_tile47_sub1;5wt_tile48_sub1;5wt_tile49_sub1;5wt_tile50_sub1;5wt_tile51_sub1;5wt_tile52_sub1;5wt_tile53_sub1;5wt_tile54_sub1;5wt_tile55_sub1;5wt_tile56_sub1;5wt_tile57_sub1;5wt_tile58_sub1;5wt_tile59_sub1;5wt_tile60_sub1;5wt_tile61_sub1;5wt_tile62_sub1;5wt_tile63_sub1;5wt_tile64_sub1                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile12_sub2  | 328         | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile13_sub2  | 463         | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile14_sub2  | 547         | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile15_sub2  | 688         | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile16_sub2  | 898         | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile17_sub2  | 1081        | BsaI        | 5wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile18_sub2  | 1189        | BsaI        | 5wt_tile18_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile19_sub2  | 1324        | BsaI        | 5wt_tile19_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile2        | 183         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile20_sub2  | 1453        | BsaI        | 5wt_tile20_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile21_sub2  | 1549        | BsaI        | 5wt_tile21_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile22_sub2  | 1675        | BsaI        | 5wt_tile22_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile23_sub2  | 1545        | BsaI        | 5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2;5wt_tile26_sub2;5wt_tile27_sub2;5wt_tile28_sub2;5wt_tile29_sub2;5wt_tile30_sub2;5wt_tile31_sub2;5wt_tile32_sub2;5wt_tile33_sub2;5wt_tile34_sub2;5wt_tile35_sub2;5wt_tile36_sub2;5wt_tile37_sub2;5wt_tile38_sub2;5wt_tile39_sub2;5wt_tile40_sub2;5wt_tile41_sub2;5wt_tile42_sub2;5wt_tile43_sub2;5wt_tile44_sub2;5wt_tile45_sub2;5wt_tile46_sub2;5wt_tile47_sub2;5wt_tile48_sub2;5wt_tile49_sub2;5wt_tile50_sub2;5wt_tile51_sub2;5wt_tile52_sub2;5wt_tile53_sub2;5wt_tile54_sub2;5wt_tile55_sub2;5wt_tile56_sub2;5wt_tile57_sub2;5wt_tile58_sub2;5wt_tile59_sub2;5wt_tile60_sub2;5wt_tile61_sub2;5wt_tile62_sub2;5wt_tile63_sub2;5wt_tile64_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile23_sub3  | 343         | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile24_sub3  | 475         | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile25_sub3  | 577         | BsaI        | 5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile26_sub3  | 760         | BsaI        | 5wt_tile26_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile27_sub3  | 865         | BsaI        | 5wt_tile27_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile28_sub3  | 1045        | BsaI        | 5wt_tile28_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile29_sub3  | 1198        | BsaI        | 5wt_tile29_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile3        | 339         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile30_sub3  | 1300        | BsaI        | 5wt_tile30_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile31_sub3  | 1393        | BsaI        | 5wt_tile31_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile32_sub3  | 1612        | BsaI        | 5wt_tile32_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile33_sub3  | 1714        | BsaI        | 5wt_tile33_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile34_sub3  | 1710        | BsaI        | 5wt_tile34_sub3;5wt_tile35_sub3;5wt_tile36_sub3;5wt_tile37_sub3;5wt_tile38_sub3;5wt_tile39_sub3;5wt_tile40_sub3;5wt_tile41_sub3;5wt_tile42_sub3;5wt_tile43_sub3;5wt_tile44_sub3;5wt_tile45_sub3;5wt_tile46_sub3;5wt_tile47_sub3;5wt_tile48_sub3;5wt_tile49_sub3;5wt_tile50_sub3;5wt_tile51_sub3;5wt_tile52_sub3;5wt_tile53_sub3;5wt_tile54_sub3;5wt_tile55_sub3;5wt_tile56_sub3;5wt_tile57_sub3;5wt_tile58_sub3;5wt_tile59_sub3;5wt_tile60_sub3;5wt_tile61_sub3;5wt_tile62_sub3;5wt_tile63_sub3;5wt_tile64_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile34_sub4  | 154         | BsaI        | 5wt_tile34_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile35_sub4  | 358         | BsaI        | 5wt_tile35_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile36_sub4  | 493         | BsaI        | 5wt_tile36_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile37_sub4  | 697         | BsaI        | 5wt_tile37_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile38_sub4  | 856         | BsaI        | 5wt_tile38_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile39_sub4  | 1009        | BsaI        | 5wt_tile39_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile4        | 543         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile40_sub4  | 1207        | BsaI        | 5wt_tile40_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile41_sub4  | 1348        | BsaI        | 5wt_tile41_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile42_sub4  | 1474        | BsaI        | 5wt_tile42_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile43_sub4  | 1203        | BsaI        | 5wt_tile43_sub4;5wt_tile44_sub4;5wt_tile45_sub4;5wt_tile46_sub4;5wt_tile47_sub4;5wt_tile48_sub4;5wt_tile49_sub4;5wt_tile50_sub4;5wt_tile51_sub4;5wt_tile52_sub4;5wt_tile53_sub4;5wt_tile54_sub4;5wt_tile55_sub4;5wt_tile56_sub4;5wt_tile57_sub4;5wt_tile58_sub4;5wt_tile59_sub4;5wt_tile60_sub4;5wt_tile61_sub4;5wt_tile62_sub4;5wt_tile63_sub4;5wt_tile64_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile43_sub5  | 448         | BsaI        | 5wt_tile43_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile44_sub5  | 646         | BsaI        | 5wt_tile44_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile45_sub5  | 739         | BsaI        | 5wt_tile45_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile46_sub5  | 910         | BsaI        | 5wt_tile46_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile47_sub5  | 1015        | BsaI        | 5wt_tile47_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile48_sub5  | 735         | BsaI        | 5wt_tile48_sub5;5wt_tile49_sub5;5wt_tile50_sub5;5wt_tile51_sub5;5wt_tile52_sub5;5wt_tile53_sub5;5wt_tile54_sub5;5wt_tile55_sub5;5wt_tile56_sub5;5wt_tile57_sub5;5wt_tile58_sub5;5wt_tile59_sub5;5wt_tile60_sub5;5wt_tile61_sub5;5wt_tile62_sub5;5wt_tile63_sub5;5wt_tile64_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile48_sub6  | 388         | BsaI        | 5wt_tile48_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile49_sub6  | 553         | BsaI        | 5wt_tile49_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile5        | 651         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile50_sub6  | 643         | BsaI        | 5wt_tile50_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile51_sub6  | 796         | BsaI        | 5wt_tile51_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile52_sub6  | 949         | BsaI        | 5wt_tile52_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile53_sub6  | 1045        | BsaI        | 5wt_tile53_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile54_sub6  | 1177        | BsaI        | 5wt_tile54_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile55_sub6  | 1366        | BsaI        | 5wt_tile55_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile56_sub6  | 1471        | BsaI        | 5wt_tile56_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile57_sub6  | 1639        | BsaI        | 5wt_tile57_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile58_sub6  | 1467        | BsaI        | 5wt_tile58_sub6;5wt_tile59_sub6;5wt_tile60_sub6;5wt_tile61_sub6;5wt_tile62_sub6;5wt_tile63_sub6;5wt_tile64_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile58_sub7  | 391         | BsaI        | 5wt_tile58_sub7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile59_sub7  | 532         | BsaI        | 5wt_tile59_sub7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile6        | 810         | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile60_sub7  | 670         | BsaI        | 5wt_tile60_sub7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile61_sub7  | 853         | BsaI        | 5wt_tile61_sub7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile62_sub7  | 1045        | BsaI        | 5wt_tile62_sub7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile63_sub7  | 1144        | BsaI        | 5wt_tile63_sub7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile64_sub7  | 1300        | BsaI        | 5wt_tile64_sub7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile7        | 897         | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile8        | 1068        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile9        | 1248        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile1_sub1  | 1191        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile1_sub2  | 1545        | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile1_sub3  | 1710        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub2;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2;3wt_tile16_sub2;3wt_tile17_sub2;3wt_tile18_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile1_sub4  | 1203        | BsmBI       | 3wt_tile1_sub4;3wt_tile2_sub4;3wt_tile3_sub4;3wt_tile4_sub4;3wt_tile5_sub4;3wt_tile6_sub4;3wt_tile7_sub4;3wt_tile8_sub3;3wt_tile9_sub3;3wt_tile10_sub3;3wt_tile11_sub3;3wt_tile12_sub3;3wt_tile13_sub3;3wt_tile14_sub3;3wt_tile15_sub3;3wt_tile16_sub3;3wt_tile17_sub3;3wt_tile18_sub3;3wt_tile19_sub2;3wt_tile20_sub2;3wt_tile21_sub2;3wt_tile22_sub2;3wt_tile23_sub2;3wt_tile24_sub2;3wt_tile25_sub2;3wt_tile26_sub2;3wt_tile27_sub2;3wt_tile28_sub2;3wt_tile29_sub2;3wt_tile30_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile1_sub5  | 735         | BsmBI       | 3wt_tile1_sub5;3wt_tile2_sub5;3wt_tile3_sub5;3wt_tile4_sub5;3wt_tile5_sub5;3wt_tile6_sub5;3wt_tile7_sub5;3wt_tile8_sub4;3wt_tile9_sub4;3wt_tile10_sub4;3wt_tile11_sub4;3wt_tile12_sub4;3wt_tile13_sub4;3wt_tile14_sub4;3wt_tile15_sub4;3wt_tile16_sub4;3wt_tile17_sub4;3wt_tile18_sub4;3wt_tile19_sub3;3wt_tile20_sub3;3wt_tile21_sub3;3wt_tile22_sub3;3wt_tile23_sub3;3wt_tile24_sub3;3wt_tile25_sub3;3wt_tile26_sub3;3wt_tile27_sub3;3wt_tile28_sub3;3wt_tile29_sub3;3wt_tile30_sub3;3wt_tile31_sub2;3wt_tile32_sub2;3wt_tile33_sub2;3wt_tile34_sub2;3wt_tile35_sub2;3wt_tile36_sub2;3wt_tile37_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile1_sub6  | 1467        | BsmBI       | 3wt_tile1_sub6;3wt_tile2_sub6;3wt_tile3_sub6;3wt_tile4_sub6;3wt_tile5_sub6;3wt_tile6_sub6;3wt_tile7_sub6;3wt_tile8_sub5;3wt_tile9_sub5;3wt_tile10_sub5;3wt_tile11_sub5;3wt_tile12_sub5;3wt_tile13_sub5;3wt_tile14_sub5;3wt_tile15_sub5;3wt_tile16_sub5;3wt_tile17_sub5;3wt_tile18_sub5;3wt_tile19_sub4;3wt_tile20_sub4;3wt_tile21_sub4;3wt_tile22_sub4;3wt_tile23_sub4;3wt_tile24_sub4;3wt_tile25_sub4;3wt_tile26_sub4;3wt_tile27_sub4;3wt_tile28_sub4;3wt_tile29_sub4;3wt_tile30_sub4;3wt_tile31_sub3;3wt_tile32_sub3;3wt_tile33_sub3;3wt_tile34_sub3;3wt_tile35_sub3;3wt_tile36_sub3;3wt_tile37_sub3;3wt_tile38_sub2;3wt_tile39_sub2;3wt_tile40_sub2;3wt_tile41_sub2;3wt_tile42_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile1_sub7  | 2486        | BsmBI       | 3wt_polIII_tile1_sub7;3wt_polIII_tile2_sub7;3wt_polIII_tile3_sub7;3wt_polIII_tile4_sub7;3wt_polIII_tile5_sub7;3wt_polIII_tile6_sub7;3wt_polIII_tile7_sub7;3wt_polIII_tile8_sub6;3wt_polIII_tile9_sub6;3wt_polIII_tile10_sub6;3wt_polIII_tile11_sub6;3wt_polIII_tile12_sub6;3wt_polIII_tile13_sub6;3wt_polIII_tile14_sub6;3wt_polIII_tile15_sub6;3wt_polIII_tile16_sub6;3wt_polIII_tile17_sub6;3wt_polIII_tile18_sub6;3wt_polIII_tile19_sub5;3wt_polIII_tile20_sub5;3wt_polIII_tile21_sub5;3wt_polIII_tile22_sub5;3wt_polIII_tile23_sub5;3wt_polIII_tile24_sub5;3wt_polIII_tile25_sub5;3wt_polIII_tile26_sub5;3wt_polIII_tile27_sub5;3wt_polIII_tile28_sub5;3wt_polIII_tile29_sub5;3wt_polIII_tile30_sub5;3wt_polIII_tile31_sub4;3wt_polIII_tile32_sub4;3wt_polIII_tile33_sub4;3wt_polIII_tile34_sub4;3wt_polIII_tile35_sub4;3wt_polIII_tile36_sub4;3wt_polIII_tile37_sub4;3wt_polIII_tile38_sub3;3wt_polIII_tile39_sub3;3wt_polIII_tile40_sub3;3wt_polIII_tile41_sub3;3wt_polIII_tile42_sub3;3wt_polIII_tile43_sub2;3wt_polIII_tile44_sub2;3wt_polIII_tile45_sub2;3wt_polIII_tile46_sub2;3wt_polIII_tile47_sub2;3wt_polIII_tile48_sub2;3wt_polIII_tile49_sub2;3wt_polIII_tile50_sub2;3wt_polIII_tile51_sub2;3wt_polIII_tile52_sub2;3wt_polIII_tile53_sub2;3wt_polIII_tile54_sub2 |
| bsmbi_3wt_tile10_sub1 | 1419        | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile11_sub1 | 1227        | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile12_sub1 | 1092        | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile13_sub1 | 1008        | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile14_sub1 | 867         | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile15_sub1 | 657         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile16_sub1 | 474         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile17_sub1 | 366         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile18_sub1 | 231         | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile19_sub1 | 1794        | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile2_sub1  | 1035        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile20_sub1 | 1698        | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile21_sub1 | 1572        | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile22_sub1 | 1377        | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile23_sub1 | 1245        | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile24_sub1 | 1143        | BsmBI       | 3wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile25_sub1 | 960         | BsmBI       | 3wt_tile25_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile26_sub1 | 855         | BsmBI       | 3wt_tile26_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile27_sub1 | 675         | BsmBI       | 3wt_tile27_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile28_sub1 | 522         | BsmBI       | 3wt_tile28_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile29_sub1 | 420         | BsmBI       | 3wt_tile29_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile3_sub1  | 831         | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile30_sub1 | 327         | BsmBI       | 3wt_tile30_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile31_sub1 | 1293        | BsmBI       | 3wt_tile31_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile32_sub1 | 1191        | BsmBI       | 3wt_tile32_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile33_sub1 | 1059        | BsmBI       | 3wt_tile33_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile34_sub1 | 855         | BsmBI       | 3wt_tile34_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile35_sub1 | 720         | BsmBI       | 3wt_tile35_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile36_sub1 | 516         | BsmBI       | 3wt_tile36_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile37_sub1 | 357         | BsmBI       | 3wt_tile37_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile38_sub1 | 921         | BsmBI       | 3wt_tile38_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile39_sub1 | 723         | BsmBI       | 3wt_tile39_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile4_sub1  | 723         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile40_sub1 | 582         | BsmBI       | 3wt_tile40_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile41_sub1 | 456         | BsmBI       | 3wt_tile41_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile42_sub1 | 297         | BsmBI       | 3wt_tile42_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile43_sub1 | 1548        | BsmBI       | 3wt_tile43_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile44_sub1 | 1455        | BsmBI       | 3wt_tile44_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile45_sub1 | 1284        | BsmBI       | 3wt_tile45_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile46_sub1 | 1179        | BsmBI       | 3wt_tile46_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile47_sub1 | 1089        | BsmBI       | 3wt_tile47_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile48_sub1 | 924         | BsmBI       | 3wt_tile48_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile49_sub1 | 834         | BsmBI       | 3wt_tile49_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile5_sub1  | 564         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile50_sub1 | 681         | BsmBI       | 3wt_tile50_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile51_sub1 | 528         | BsmBI       | 3wt_tile51_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile52_sub1 | 432         | BsmBI       | 3wt_tile52_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile53_sub1 | 300         | BsmBI       | 3wt_tile53_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile54_sub1 | 111         | BsmBI       | 3wt_tile54_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile55_sub1 | 699         | BsmBI       | 3wt_tile55_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile55_sub2 | 1796        | BsmBI       | 3wt_polIII_tile55_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile56_sub1 | 699         | BsmBI       | 3wt_tile56_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile56_sub2 | 1625        | BsmBI       | 3wt_polIII_tile56_sub2;3wt_polIII_tile57_sub2;3wt_polIII_tile58_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile57_sub1 | 498         | BsmBI       | 3wt_tile57_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile58_sub1 | 357         | BsmBI       | 3wt_tile58_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile59_sub1 | 489         | BsmBI       | 3wt_tile59_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile59_sub2 | 1355        | BsmBI       | 3wt_polIII_tile59_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile6_sub1  | 477         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile60      | 1643        | BsmBI       | 3wt_polIII_tile60                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile61      | 1451        | BsmBI       | 3wt_polIII_tile61                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile62      | 1352        | BsmBI       | 3wt_polIII_tile62                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile63      | 1196        | BsmBI       | 3wt_polIII_tile63                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile7_sub1  | 306         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile8_sub1  | 1653        | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile9_sub1  | 1536        | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_polIII_tile64   | 1112        | BsmBI       | polIII_tile64                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |

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

