# DMS-GG Assembly Report: TRIO

Generated: 2026-03-06 18:44:02
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                         |
| -------------------- | ----------------------------------------------------------------------------- |
| Gene name            | TRIO_NM_007118.4_CDS Homo sapiens triple functional domain protein (TRIO) CDS |
| CDS length           | 9294 nt (3098 codons)                                                         |
| Protein length       | 3097 aa                                                                       |
| Number of tiles      | 47                                                                            |
| Total variants       | 64974                                                                         |
| Total oligos         | 649740                                                                        |
| Oligo length range   | 185-290 nt                                                                    |
| Gene blocks to order | 103                                                                           |
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

**Total oligos:** 649740 | **Length range:** 185-290 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-57      | 11130  | 227 nt |
| 2    | 54-111    | 11340  | 230 nt |
| 3    | 108-179   | 14280  | 272 nt |
| 4    | 176-218   | 8190   | 185 nt |
| 5    | 215-268   | 10500  | 218 nt |
| 6    | 265-335   | 14070  | 269 nt |
| 7    | 332-399   | 13440  | 260 nt |
| 8    | 396-458   | 12390  | 245 nt |
| 9    | 455-527   | 14490  | 275 nt |
| 10   | 524-601   | 15540  | 290 nt |
| 11   | 598-670   | 14490  | 275 nt |
| 12   | 667-733   | 13230  | 257 nt |
| 13   | 730-807   | 15540  | 290 nt |
| 14   | 804-870   | 13230  | 257 nt |
| 15   | 867-931   | 12810  | 251 nt |
| 16   | 928-1005  | 15540  | 290 nt |
| 17   | 1002-1074 | 14490  | 275 nt |
| 18   | 1071-1148 | 15540  | 290 nt |
| 19   | 1145-1222 | 15540  | 290 nt |
| 20   | 1219-1296 | 15540  | 290 nt |
| 21   | 1293-1349 | 11130  | 227 nt |
| 22   | 1346-1423 | 15540  | 290 nt |
| 23   | 1420-1481 | 12180  | 242 nt |
| 24   | 1478-1555 | 15540  | 290 nt |
| 25   | 1552-1622 | 14070  | 269 nt |
| 26   | 1619-1687 | 13650  | 263 nt |
| 27   | 1684-1761 | 15540  | 290 nt |
| 28   | 1758-1831 | 14700  | 278 nt |
| 29   | 1828-1905 | 15540  | 290 nt |
| 30   | 1902-1969 | 13440  | 260 nt |
| 31   | 1966-2038 | 14490  | 275 nt |
| 32   | 2035-2106 | 14280  | 272 nt |
| 33   | 2103-2173 | 14070  | 269 nt |
| 34   | 2170-2218 | 9450   | 203 nt |
| 35   | 2215-2284 | 13860  | 266 nt |
| 36   | 2281-2358 | 15540  | 290 nt |
| 37   | 2355-2419 | 12810  | 251 nt |
| 38   | 2416-2488 | 14490  | 275 nt |
| 39   | 2485-2559 | 14910  | 281 nt |
| 40   | 2556-2631 | 15120  | 284 nt |
| 41   | 2628-2703 | 15120  | 284 nt |
| 42   | 2700-2770 | 14070  | 269 nt |
| 43   | 2767-2815 | 9450   | 203 nt |
| 44   | 2812-2888 | 15330  | 287 nt |
| 45   | 2885-2955 | 14070  | 269 nt |
| 46   | 2952-3029 | 15540  | 290 nt |
| 47   | 3026-3098 | 14490  | 275 nt |

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

| Check                     | Description                                                   | Result | Detail                                                                                                                                              |
| ------------------------- | ------------------------------------------------------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths             | All oligos within synthesis length limit                      | PASS   | Range: 185-290 nt (limit: 300)                                                                                                                      |
| block_lengths             | All gene blocks within synthesis length limit                 | PASS   | Range: 177-1796 nt (limit: 1800)                                                                                                                    |
| barcode_junction_sites    | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AATATG')                                                                             |
| barcode_uniqueness        | All barcodes are unique                                       | PASS   | 649740 unique / 649740 total                                                                                                                        |
| tile_coverage             | Tiles cover entire gene without gaps                          | PASS   | 9294 / 9294 nt covered                                                                                                                              |
| variant_count             | Expected number of variants generated                         | PASS   | 64974 unique variants (expected: 64974 across 3094/3096 mutable positions; 58786 missense + 3094 nonsense + 3094 wt_control; 2 position(s) skipped) |
| single_codon_change       | Each non-control variant differs by exactly one codon from WT | PASS   | 618800 / 618800 variants confirmed (WT controls excluded)                                                                                           |
| oligo_gc_content          | Oligo GC content within reasonable range (25-75%)             | FAIL   | GC range: 37.9-75.2% | 6 oligo(s) with extreme GC                                                                                                   |
| domestication_complete    | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                             |
| overhang_fidelity         | Tile boundary overhangs have adequate fidelity                | FAIL   | 44 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                             |
| tile_manifests            | Per-tile assembly manifests complete                          | PASS   | 47 tile manifest(s) generated                                                                                                                       |
| helper_plasmid            | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                  |
| reaction_fidelity         | Per-reaction set-level overhang fidelity                      | FAIL   | Min set fidelity: 0.7829 across 94 reactions | 3 reaction(s) below 0.90                                                                             |
| barcode_poliii_term       | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 649740 barcode(s) contain TTTT                                                                                                                  |
| block_min_length          | All gene blocks above synthesis minimum length                | FAIL   | 2 block(s) below 300 nt minimum. Range: 177-1796 nt                                                                                                 |
| cassette_fragment_lengths | Cassette fragments within synthesis limits                    | PASS   | 1 cassette fragment(s). Range: 982-982 nt. 0 over max, 0 under min.                                                                                 |
| sb_overhang_collisions    | Superblock boundary overhangs are unique (no collisions)      | PASS   | 7 SB boundary OH(s), all unique                                                                                                                     |

## 6. Fixed Overhangs & Helper Plasmid

These overhangs are the same across all tile reactions:

| Overhang    | Sequence | Role                                                    |
| ----------- | -------- | ------------------------------------------------------- |
| oh_L        | ATGA     | Gene start (BsaI, all tiles)                            |
| oh3         | CACC     | Downstream cassette-barcode junction (BsmBI, all tiles) |
| oh4         | AATA     | Barcode-helper junction (BsaI, all tiles)               |
| paqci_star2 | AATG     | PaqCI 5' end of insert (Level 2)                        |
| paqci_star1 | GCTA     | PaqCI 3' end of insert (Level 2)                        |

### Helper Plasmid Insert

The helper plasmid provides the backbone for each BsaI Level 1 reaction.

```
[PaqCI**]--[BsaI>>ATGA]--STUFFER--[AATA<<BsaI]--[PaqCI*]
```

Insert length: 72 nt
oh_L = ATGA (first 4 nt of gene)
oh_R = AATA (= oh4, barcode-helper junction)

## 7. Per-Tile Assembly Guide

### Tile 1 of 47 -- Codons 1-57 (171 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGA     | 0.7549   |
| oh2 (3' boundary) | AAAC     | 0.6694   |

**Variants:** 11130 mutations, 11130 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (11130 oligos)              | 227 nt | ATGA  | AATA  |
| 3   | Helper plasmid  | helper_plasmid_insert              | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart               | --     | --    | --    |

```
  [ATGA]----oligo+BC----[AATA]
   ATGA                  AATA 
```

**Set fidelity:** 1.0000 (2 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1      | 1221 nt | AAAC  | TATG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1065 nt | TATG  | TGAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1263 nt | TGAT  | TACT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1218 nt | TACT  | TGGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1266 nt | TGGA  | CCTT  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1581 nt | CCTT  | GACA  |
| 8   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 9   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 10  | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AAAC]----3'WT sub1----[TATG]----3'WT sub2----[TGAT]----3'WT sub3----[TACT]----3'WT sub4----[TGGA]----3'WT sub5----[CCTT]----3'WT sub6----[GACA]----3'WT sub7----[CACC]----3'WT+PolIII sub8----
   AAAC                   TATG                   TGAT                   TACT                   TGGA                   CCTT                   GACA                   CACC 
```

**Set fidelity:** 0.9986 (8 overhangs)

---

### Tile 2 of 47 -- Codons 54-111 (174 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTTC     | 0.8348   |
| oh2 (3' boundary) | TCTA     | 0.8892   |

**Variants:** 11340 mutations, 11340 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 177 nt | ATGA  | TTTC  |
| 2   | Oligo pool      | Tile 2 (11340 oligos) | 230 nt | TTTC  | AATA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[TTTC]----oligo+BC----[AATA]
   ATGA                    TTTC                  AATA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1      | 1059 nt | TCTA  | TATG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1065 nt | TATG  | TGAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1263 nt | TGAT  | TACT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1218 nt | TACT  | TGGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1266 nt | TGGA  | CCTT  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1581 nt | CCTT  | GACA  |
| 8   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 9   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 10  | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TCTA]----3'WT sub1----[TATG]----3'WT sub2----[TGAT]----3'WT sub3----[TACT]----3'WT sub4----[TGGA]----3'WT sub5----[CCTT]----3'WT sub6----[GACA]----3'WT sub7----[CACC]----3'WT+PolIII sub8----
   TCTA                   TATG                   TGAT                   TACT                   TGGA                   CCTT                   GACA                   CACC 
```

**Set fidelity:** 0.9986 (8 overhangs)

---

### Tile 3 of 47 -- Codons 108-179 (216 nt)

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
| 2   | Oligo pool      | Tile 3 (14280 oligos) | 272 nt | ATTT  | AATA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[ATTT]----oligo+BC----[AATA]
   ATGA                    ATTT                  AATA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1      | 855 nt  | ATTT  | TATG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1065 nt | TATG  | TGAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1263 nt | TGAT  | TACT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1218 nt | TACT  | TGGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1266 nt | TGGA  | CCTT  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1581 nt | CCTT  | GACA  |
| 8   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 9   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 10  | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [ATTT]----3'WT sub1----[TATG]----3'WT sub2----[TGAT]----3'WT sub3----[TACT]----3'WT sub4----[TGGA]----3'WT sub5----[CCTT]----3'WT sub6----[GACA]----3'WT sub7----[CACC]----3'WT+PolIII sub8----
   ATTT                   TATG                   TGAT                   TACT                   TGGA                   CCTT                   GACA                   CACC 
```

**Set fidelity:** 0.9986 (8 overhangs)

---

### Tile 4 of 47 -- Codons 176-218 (129 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAT     | 0.7737   |
| oh2 (3' boundary) | AGTT     | 0.6748   |

**Variants:** 8190 mutations, 8190 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 543 nt | ATGA  | AAAT  |
| 2   | Oligo pool      | Tile 4 (8190 oligos)  | 185 nt | AAAT  | AATA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[AAAT]----oligo+BC----[AATA]
   ATGA                    AAAT                  AATA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1      | 738 nt  | AGTT  | TATG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1065 nt | TATG  | TGAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1263 nt | TGAT  | TACT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1218 nt | TACT  | TGGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1266 nt | TGGA  | CCTT  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1581 nt | CCTT  | GACA  |
| 8   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 9   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 10  | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AGTT]----3'WT sub1----[TATG]----3'WT sub2----[TGAT]----3'WT sub3----[TACT]----3'WT sub4----[TGGA]----3'WT sub5----[CCTT]----3'WT sub6----[GACA]----3'WT sub7----[CACC]----3'WT+PolIII sub8----
   AGTT                   TATG                   TGAT                   TACT                   TGGA                   CCTT                   GACA                   CACC 
```

**Set fidelity:** 0.9986 (8 overhangs)

---

### Tile 5 of 47 -- Codons 215-268 (162 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | GATT     | 0.6417   |

**Variants:** 10500 mutations, 10500 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 660 nt | ATGA  | GAAA  |
| 2   | Oligo pool      | Tile 5 (10500 oligos) | 218 nt | GAAA  | AATA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[GAAA]----oligo+BC----[AATA]
   ATGA                    GAAA                  AATA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1      | 588 nt  | GATT  | TATG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1065 nt | TATG  | TGAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1263 nt | TGAT  | TACT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1218 nt | TACT  | TGGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1266 nt | TGGA  | CCTT  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1581 nt | CCTT  | GACA  |
| 8   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 9   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 10  | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GATT]----3'WT sub1----[TATG]----3'WT sub2----[TGAT]----3'WT sub3----[TACT]----3'WT sub4----[TGGA]----3'WT sub5----[CCTT]----3'WT sub6----[GACA]----3'WT sub7----[CACC]----3'WT+PolIII sub8----
   GATT                   TATG                   TGAT                   TACT                   TGGA                   CCTT                   GACA                   CACC 
```

**Set fidelity:** 0.9986 (8 overhangs)

---

### Tile 6 of 47 -- Codons 265-335 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | GAAG     | 0.6752   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 810 nt | ATGA  | AAGA  |
| 2   | Oligo pool      | Tile 6 (14070 oligos) | 269 nt | AAGA  | AATA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[AAGA]----oligo+BC----[AATA]
   ATGA                    AAGA                  AATA 
```

**Set fidelity:** 0.9574 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1      | 387 nt  | GAAG  | TATG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1065 nt | TATG  | TGAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1263 nt | TGAT  | TACT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1218 nt | TACT  | TGGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1266 nt | TGGA  | CCTT  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1581 nt | CCTT  | GACA  |
| 8   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 9   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 10  | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAAG]----3'WT sub1----[TATG]----3'WT sub2----[TGAT]----3'WT sub3----[TACT]----3'WT sub4----[TGGA]----3'WT sub5----[CCTT]----3'WT sub6----[GACA]----3'WT sub7----[CACC]----3'WT+PolIII sub8----
   GAAG                   TATG                   TGAT                   TACT                   TGGA                   CCTT                   GACA                   CACC 
```

**Set fidelity:** 0.9986 (8 overhangs)

---

### Tile 7 of 47 -- Codons 332-399 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGGA     | 0.7515   |
| oh2 (3' boundary) | AAAC     | 0.6694   |

**Variants:** 13440 mutations, 13440 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 1011 nt | ATGA  | AGGA  |
| 2   | Oligo pool      | Tile 7 (13440 oligos) | 260 nt  | AGGA  | AATA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT block----[AGGA]----oligo+BC----[AATA]
   ATGA                    AGGA                  AATA 
```

**Set fidelity:** 0.9950 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1      | 1242 nt | AAAC  | TATG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1263 nt | TATG  | TGAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1218 nt | TGAT  | TACT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1266 nt | TACT  | TGGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1581 nt | TGGA  | CCTT  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | CCTT  | GACA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | GACA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AAAC]----3'WT sub1----[TATG]----3'WT sub2----[TGAT]----3'WT sub3----[TACT]----3'WT sub4----[TGGA]----3'WT sub5----[CCTT]----3'WT sub6----[GACA]----3'WT+PolIII sub7----[CACC]
   AAAC                   TATG                   TGAT                   TACT                   TGGA                   CCTT                   GACA                          CACC 
```

**Set fidelity:** 0.9986 (8 overhangs)

---

### Tile 8 of 47 -- Codons 396-458 (189 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTAA     | 0.8029   |
| oh2 (3' boundary) | TATG     | 0.7006   |

**Variants:** 12390 mutations, 12390 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1203 nt | ATGA  | GTAA  |
| 2   | Oligo pool      | Tile 8 (12390 oligos) | 245 nt  | GTAA  | AATA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT block----[GTAA]----oligo+BC----[AATA]
   ATGA                    GTAA                  AATA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1065 nt | TATG  | TGAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1263 nt | TGAT  | TACT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1218 nt | TACT  | TGGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1266 nt | TGGA  | CCTT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1581 nt | CCTT  | GACA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TATG]----3'WT sub1----[TGAT]----3'WT sub2----[TACT]----3'WT sub3----[TGGA]----3'WT sub4----[CCTT]----3'WT sub5----[GACA]----3'WT sub6----[CACC]----3'WT+PolIII sub7----
   TATG                   TGAT                   TACT                   TGGA                   CCTT                   GACA                   CACC 
```

**Set fidelity:** 0.9986 (7 overhangs)

---

### Tile 9 of 47 -- Codons 455-527 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | CTCT     | 0.6347   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1380 nt | ATGA  | GAAA  |
| 2   | Oligo pool      | Tile 9 (14490 oligos) | 275 nt  | GAAA  | AATA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT block----[GAAA]----oligo+BC----[AATA]
   ATGA                    GAAA                  AATA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1      | 858 nt  | CTCT  | TGAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1263 nt | TGAT  | TACT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1218 nt | TACT  | TGGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1266 nt | TGGA  | CCTT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1581 nt | CCTT  | GACA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTCT]----3'WT sub1----[TGAT]----3'WT sub2----[TACT]----3'WT sub3----[TGGA]----3'WT sub4----[CCTT]----3'WT sub5----[GACA]----3'WT sub6----[CACC]----3'WT+PolIII sub7----
   CTCT                   TGAT                   TACT                   TGGA                   CCTT                   GACA                   CACC 
```

**Set fidelity:** 0.9931 (7 overhangs)

---

### Tile 10 of 47 -- Codons 524-601 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTGA     | 0.6791   |
| oh2 (3' boundary) | TCAT     | 0.8102   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1587 nt | ATGA  | CTGA  |
| 2   | Oligo pool      | Tile 10 (15540 oligos) | 290 nt  | CTGA  | AATA  |
| 3   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----oligo+BC----[CTGA][AATA]
   ATGA                   TATG                  CTGA  AATA 
```

**Set fidelity:** 0.9928 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1     | 636 nt  | TCAT  | TGAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1263 nt | TGAT  | TACT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1218 nt | TACT  | TGGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1266 nt | TGGA  | CCTT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1581 nt | CCTT  | GACA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TCAT]----3'WT sub1----[TGAT]----3'WT sub2----[TACT]----3'WT sub3----[TGGA]----3'WT sub4----[CCTT]----3'WT sub5----[GACA]----3'WT sub6----[CACC]----3'WT+PolIII sub7----
   TCAT                   TGAT                   TACT                   TGGA                   CCTT                   GACA                   CACC 
```

**Set fidelity:** 0.9895 (7 overhangs)

---

### Tile 11 of 47 -- Codons 598-670 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAT     | 0.7737   |
| oh2 (3' boundary) | ACTG     | 0.5529   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile11_sub2   | 439 nt  | TATG  | AAAT  |
| 3   | Oligo pool      | Tile 11 (14490 oligos) | 275 nt  | AAAT  | AATA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[AAAT]----oligo+BC----[AATA]
   ATGA                   TATG                   AAAT                  AATA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1     | 429 nt  | ACTG  | TGAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1263 nt | TGAT  | TACT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1218 nt | TACT  | TGGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1266 nt | TGGA  | CCTT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1581 nt | CCTT  | GACA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [ACTG]----3'WT sub1----[TGAT]----3'WT sub2----[TACT]----3'WT sub3----[TGGA]----3'WT sub4----[CCTT]----3'WT sub5----[GACA]----3'WT sub6----[CACC]----3'WT+PolIII sub7----
   ACTG                   TGAT                   TACT                   TGGA                   CCTT                   GACA                   CACC 
```

**Set fidelity:** 0.9986 (7 overhangs)

---

### Tile 12 of 47 -- Codons 667-733 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | GGAC     | 0.5754   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2   | 646 nt  | TATG  | AAGA  |
| 3   | Oligo pool      | Tile 12 (13230 oligos) | 257 nt  | AAGA  | AATA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[AAGA]----oligo+BC----[AATA]
   ATGA                   TATG                   AAGA                  AATA 
```

**Set fidelity:** 0.9574 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1     | 1485 nt | GGAC  | TGAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1218 nt | TGAT  | TACT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1266 nt | TACT  | TGGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1581 nt | TGGA  | CCTT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | CCTT  | GACA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | GACA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GGAC]----3'WT sub1----[TGAT]----3'WT sub2----[TACT]----3'WT sub3----[TGGA]----3'WT sub4----[CCTT]----3'WT sub5----[GACA]----3'WT+PolIII sub6----[CACC]
   GGAC                   TGAT                   TACT                   TGGA                   CCTT                   GACA                          CACC 
```

**Set fidelity:** 0.9986 (7 overhangs)

---

### Tile 13 of 47 -- Codons 730-807 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAG     | 0.6752   |
| oh2 (3' boundary) | TGAT     | 0.6933   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 835 nt  | TATG  | GAAG  |
| 3   | Oligo pool      | Tile 13 (15540 oligos) | 290 nt  | GAAG  | AATA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[GAAG]----oligo+BC----[AATA]
   ATGA                   TATG                   GAAG                  AATA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1263 nt | TGAT  | TACT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1218 nt | TACT  | TGGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1266 nt | TGGA  | CCTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1581 nt | CCTT  | GACA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGAT]----3'WT sub1----[TACT]----3'WT sub2----[TGGA]----3'WT sub3----[CCTT]----3'WT sub4----[GACA]----3'WT sub5----[CACC]----3'WT+PolIII sub6----
   TGAT                   TACT                   TGGA                   CCTT                   GACA                   CACC 
```

**Set fidelity:** 0.9986 (6 overhangs)

---

### Tile 14 of 47 -- Codons 804-870 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTT     | 0.7985   |
| oh2 (3' boundary) | TAGA     | 0.9115   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1057 nt | TATG  | TCTT  |
| 3   | Oligo pool      | Tile 14 (13230 oligos) | 257 nt  | TCTT  | AATA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TCTT]----oligo+BC----[AATA]
   ATGA                   TATG                   TCTT                  AATA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1     | 1074 nt | TAGA  | TACT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1218 nt | TACT  | TGGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1266 nt | TGGA  | CCTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1581 nt | CCTT  | GACA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TAGA]----3'WT sub1----[TACT]----3'WT sub2----[TGGA]----3'WT sub3----[CCTT]----3'WT sub4----[GACA]----3'WT sub5----[CACC]----3'WT+PolIII sub6----
   TAGA                   TACT                   TGGA                   CCTT                   GACA                   CACC 
```

**Set fidelity:** 0.9817 (6 overhangs)

---

### Tile 15 of 47 -- Codons 867-931 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTGT     | 0.6476   |
| oh2 (3' boundary) | AAAT     | 0.7737   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1246 nt | TATG  | CTGT  |
| 3   | Oligo pool      | Tile 15 (12810 oligos) | 251 nt  | CTGT  | AATA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----oligo+BC----[CTGT][AATA]
   ATGA                   TATG                   TGAT                  CTGT  AATA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1     | 891 nt  | AAAT  | TACT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1218 nt | TACT  | TGGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1266 nt | TGGA  | CCTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1581 nt | CCTT  | GACA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AAAT]----3'WT sub1----[TACT]----3'WT sub2----[TGGA]----3'WT sub3----[CCTT]----3'WT sub4----[GACA]----3'WT sub5----[CACC]----3'WT+PolIII sub6----
   AAAT                   TACT                   TGGA                   CCTT                   GACA                   CACC 
```

**Set fidelity:** 0.9986 (6 overhangs)

---

### Tile 16 of 47 -- Codons 928-1005 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCA     | 0.8519   |
| oh2 (3' boundary) | AGAT     | 0.6825   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile16_sub3   | 382 nt  | TGAT  | TCCA  |
| 4   | Oligo pool      | Tile 16 (15540 oligos) | 290 nt  | TCCA  | AATA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TCCA]----oligo+BC----[AATA]
   ATGA                   TATG                   TGAT                   TCCA                  AATA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1     | 669 nt  | AGAT  | TACT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1218 nt | TACT  | TGGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1266 nt | TGGA  | CCTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1581 nt | CCTT  | GACA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AGAT]----3'WT sub1----[TACT]----3'WT sub2----[TGGA]----3'WT sub3----[CCTT]----3'WT sub4----[GACA]----3'WT sub5----[CACC]----3'WT+PolIII sub6----
   AGAT                   TACT                   TGGA                   CCTT                   GACA                   CACC 
```

**Set fidelity:** 0.9986 (6 overhangs)

---

### Tile 17 of 47 -- Codons 1002-1074 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | TTGC     | 0.7336   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile17_sub3   | 604 nt  | TGAT  | AAGA  |
| 4   | Oligo pool      | Tile 17 (14490 oligos) | 275 nt  | AAGA  | AATA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[AAGA]----oligo+BC----[AATA]
   ATGA                   TATG                   TGAT                   AAGA                  AATA 
```

**Set fidelity:** 0.9574 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1     | 462 nt  | TTGC  | TACT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1218 nt | TACT  | TGGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1266 nt | TGGA  | CCTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1581 nt | CCTT  | GACA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TTGC]----3'WT sub1----[TACT]----3'WT sub2----[TGGA]----3'WT sub3----[CCTT]----3'WT sub4----[GACA]----3'WT sub5----[CACC]----3'WT+PolIII sub6----
   TTGC                   TACT                   TGGA                   CCTT                   GACA                   CACC 
```

**Set fidelity:** 0.9986 (6 overhangs)

---

### Tile 18 of 47 -- Codons 1071-1148 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTGA     | 0.6791   |
| oh2 (3' boundary) | CAAG     | 0.6640   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile18_sub3   | 811 nt  | TGAT  | CTGA  |
| 4   | Oligo pool      | Tile 18 (15540 oligos) | 290 nt  | CTGA  | AATA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[CTGA]----oligo+BC----[AATA]
   ATGA                   TATG                   TGAT                   CTGA                  AATA 
```

**Set fidelity:** 0.9928 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1     | 1440 nt | CAAG  | TACT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1266 nt | TACT  | TGGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1581 nt | TGGA  | CCTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | CCTT  | GACA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | GACA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CAAG]----3'WT sub1----[TACT]----3'WT sub2----[TGGA]----3'WT sub3----[CCTT]----3'WT sub4----[GACA]----3'WT+PolIII sub5----[CACC]
   CAAG                   TACT                   TGGA                   CCTT                   GACA                          CACC 
```

**Set fidelity:** 0.9986 (6 overhangs)

---

### Tile 19 of 47 -- Codons 1145-1222 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGGA     | 0.7515   |
| oh2 (3' boundary) | TACT     | 0.7445   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3   | 1033 nt | TGAT  | AGGA  |
| 4   | Oligo pool      | Tile 19 (15540 oligos) | 290 nt  | AGGA  | AATA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[AGGA]----oligo+BC----[AATA]
   ATGA                   TATG                   TGAT                   AGGA                  AATA 
```

**Set fidelity:** 0.9950 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1218 nt | TACT  | TGGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1266 nt | TGGA  | CCTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1581 nt | CCTT  | GACA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TACT]----3'WT sub1----[TGGA]----3'WT sub2----[CCTT]----3'WT sub3----[GACA]----3'WT sub4----[CACC]----3'WT+PolIII sub5----
   TACT                   TGGA                   CCTT                   GACA                   CACC 
```

**Set fidelity:** 0.9986 (5 overhangs)

---

### Tile 20 of 47 -- Codons 1219-1296 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAT     | 0.7737   |
| oh2 (3' boundary) | CATA     | 0.7540   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile20_sub3   | 1255 nt | TGAT  | AAAT  |
| 4   | Oligo pool      | Tile 20 (15540 oligos) | 290 nt  | AAAT  | AATA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[AAAT]----oligo+BC----[AATA]
   ATGA                   TATG                   TGAT                   AAAT                  AATA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1     | 996 nt  | CATA  | TGGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1266 nt | TGGA  | CCTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1581 nt | CCTT  | GACA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CATA]----3'WT sub1----[TGGA]----3'WT sub2----[CCTT]----3'WT sub3----[GACA]----3'WT sub4----[CACC]----3'WT+PolIII sub5----
   CATA                   TGGA                   CCTT                   GACA                   CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 21 of 47 -- Codons 1293-1349 (171 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAG     | 0.7511   |
| oh2 (3' boundary) | CGAA     | 0.7461   |

**Variants:** 11130 mutations, 11130 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3   | 1477 nt | TGAT  | AAAG  |
| 4   | Oligo pool      | Tile 21 (11130 oligos) | 227 nt  | AAAG  | AATA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----oligo+BC----[AAAG][AATA]
   ATGA                   TATG                   TGAT                   TACT                  AAAG  AATA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1     | 837 nt  | CGAA  | TGGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1266 nt | TGGA  | CCTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1581 nt | CCTT  | GACA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CGAA]----3'WT sub1----[TGGA]----3'WT sub2----[CCTT]----3'WT sub3----[GACA]----3'WT sub4----[CACC]----3'WT+PolIII sub5----
   CGAA                   TGGA                   CCTT                   GACA                   CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 22 of 47 -- Codons 1346-1423 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | TATT     | 0.8134   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile22_sub4   | 391 nt  | TACT  | GAAA  |
| 5   | Oligo pool      | Tile 22 (15540 oligos) | 290 nt  | GAAA  | AATA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[GAAA]----oligo+BC----[AATA]
   ATGA                   TATG                   TGAT                   TACT                   GAAA                  AATA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1     | 615 nt  | TATT  | TGGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1266 nt | TGGA  | CCTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1581 nt | CCTT  | GACA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TATT]----3'WT sub1----[TGGA]----3'WT sub2----[CCTT]----3'WT sub3----[GACA]----3'WT sub4----[CACC]----3'WT+PolIII sub5----
   TATT                   TGGA                   CCTT                   GACA                   CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 23 of 47 -- Codons 1420-1481 (186 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCT     | 0.7573   |
| oh2 (3' boundary) | TGAG     | 0.6546   |

**Variants:** 12180 mutations, 12180 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile23_sub4   | 613 nt  | TACT  | TCCT  |
| 5   | Oligo pool      | Tile 23 (12180 oligos) | 242 nt  | TCCT  | AATA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TCCT]----oligo+BC----[AATA]
   ATGA                   TATG                   TGAT                   TACT                   TCCT                  AATA 
```

**Set fidelity:** 0.9790 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1     | 441 nt  | TGAG  | TGGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1266 nt | TGGA  | CCTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1581 nt | CCTT  | GACA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGAG]----3'WT sub1----[TGGA]----3'WT sub2----[CCTT]----3'WT sub3----[GACA]----3'WT sub4----[CACC]----3'WT+PolIII sub5----
   TGAG                   TGGA                   CCTT                   GACA                   CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 24 of 47 -- Codons 1478-1555 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | ATTT     | 0.7664   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile24_sub4   | 787 nt  | TACT  | GAAA  |
| 5   | Oligo pool      | Tile 24 (15540 oligos) | 290 nt  | GAAA  | AATA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[GAAA]----oligo+BC----[AATA]
   ATGA                   TATG                   TGAT                   TACT                   GAAA                  AATA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile24_sub1     | 1467 nt | ATTT  | TGGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1581 nt | TGGA  | CCTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | CCTT  | GACA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | GACA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [ATTT]----3'WT sub1----[TGGA]----3'WT sub2----[CCTT]----3'WT sub3----[GACA]----3'WT+PolIII sub4----[CACC]
   ATTT                   TGGA                   CCTT                   GACA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 25 of 47 -- Codons 1552-1622 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCTT     | 0.6891   |
| oh2 (3' boundary) | TGGA     | 0.7377   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4   | 1009 nt | TACT  | CCTT  |
| 5   | Oligo pool      | Tile 25 (14070 oligos) | 269 nt  | CCTT  | AATA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[CCTT]----oligo+BC----[AATA]
   ATGA                   TATG                   TGAT                   TACT                   CCTT                  AATA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1266 nt | TGGA  | CCTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1581 nt | CCTT  | GACA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGGA]----3'WT sub1----[CCTT]----3'WT sub2----[GACA]----3'WT sub3----[CACC]----3'WT+PolIII sub4----
   TGGA                   CCTT                   GACA                   CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 26 of 47 -- Codons 1619-1687 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGGA     | 0.7515   |
| oh2 (3' boundary) | GGAG     | 0.5228   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile26_sub4   | 1210 nt | TACT  | AGGA  |
| 5   | Oligo pool      | Tile 26 (13650 oligos) | 263 nt  | AGGA  | AATA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[AGGA]----oligo+BC----[AATA]
   ATGA                   TATG                   TGAT                   TACT                   AGGA                  AATA 
```

**Set fidelity:** 0.9950 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile26_sub1     | 1071 nt | GGAG  | CCTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1581 nt | CCTT  | GACA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GGAG]----3'WT sub1----[CCTT]----3'WT sub2----[GACA]----3'WT sub3----[CACC]----3'WT+PolIII sub4----
   GGAG                   CCTT                   GACA                   CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 27 of 47 -- Codons 1684-1761 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAG     | 0.6752   |
| oh2 (3' boundary) | CCAG     | 0.6122   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile27_sub4   | 1405 nt | TACT  | GAAG  |
| 5   | Oligo pool      | Tile 27 (15540 oligos) | 290 nt  | GAAG  | AATA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TGGA]----oligo+BC----[GAAG][AATA]
   ATGA                   TATG                   TGAT                   TACT                   TGGA                  GAAG  AATA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile27_sub1     | 849 nt  | CCAG  | CCTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1581 nt | CCTT  | GACA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CCAG]----3'WT sub1----[CCTT]----3'WT sub2----[GACA]----3'WT sub3----[CACC]----3'WT+PolIII sub4----
   CCAG                   CCTT                   GACA                   CACC 
```

**Set fidelity:** 0.9986 (4 overhangs)

---

### Tile 28 of 47 -- Codons 1758-1831 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCG     | 0.5700   |
| oh2 (3' boundary) | CGAG     | 0.5351   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4   | 1218 nt | TACT  | TGGA  |
| 5   | 5'WT gene block | bsai_5wt_tile28_sub5   | 427 nt  | TGGA  | ATCG  |
| 6   | Oligo pool      | Tile 28 (14700 oligos) | 278 nt  | ATCG  | AATA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TGGA]----5'WT sub5----[ATCG]----oligo+BC----[AATA]
   ATGA                   TATG                   TGAT                   TACT                   TGGA                   ATCG                  AATA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile28_sub1     | 639 nt  | CGAG  | CCTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1581 nt | CCTT  | GACA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CGAG]----3'WT sub1----[CCTT]----3'WT sub2----[GACA]----3'WT sub3----[CACC]----3'WT+PolIII sub4----
   CGAG                   CCTT                   GACA                   CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 29 of 47 -- Codons 1828-1905 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | GAGT     | 0.6209   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4   | 1218 nt | TACT  | TGGA  |
| 5   | 5'WT gene block | bsai_5wt_tile29_sub5   | 637 nt  | TGGA  | GAAA  |
| 6   | Oligo pool      | Tile 29 (15540 oligos) | 290 nt  | GAAA  | AATA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TGGA]----5'WT sub5----[GAAA]----oligo+BC----[AATA]
   ATGA                   TATG                   TGAT                   TACT                   TGGA                   GAAA                  AATA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile29_sub1     | 417 nt  | GAGT  | CCTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1581 nt | CCTT  | GACA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAGT]----3'WT sub1----[CCTT]----3'WT sub2----[GACA]----3'WT sub3----[CACC]----3'WT+PolIII sub4----
   GAGT                   CCTT                   GACA                   CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 30 of 47 -- Codons 1902-1969 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | GAGA     | 0.7444   |

**Variants:** 13440 mutations, 13440 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4   | 1218 nt | TACT  | TGGA  |
| 5   | 5'WT gene block | bsai_5wt_tile30_sub5   | 859 nt  | TGGA  | GAAA  |
| 6   | Oligo pool      | Tile 30 (13440 oligos) | 260 nt  | GAAA  | AATA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TGGA]----5'WT sub5----[GAAA]----oligo+BC----[AATA]
   ATGA                   TATG                   TGAT                   TACT                   TGGA                   GAAA                  AATA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile30_sub1     | 1788 nt | GAGA  | CCTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | CCTT  | GACA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | GACA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAGA]----3'WT sub1----[CCTT]----3'WT sub2----[GACA]----3'WT+PolIII sub3----[CACC]
   GAGA                   CCTT                   GACA                          CACC 
```

**Set fidelity:** 0.9900 (4 overhangs)

---

### Tile 31 of 47 -- Codons 1966-2038 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTT     | 0.7985   |
| oh2 (3' boundary) | CCTT     | 0.6891   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4   | 1218 nt | TACT  | TGGA  |
| 5   | 5'WT gene block | bsai_5wt_tile31_sub5   | 1051 nt | TGGA  | TCTT  |
| 6   | Oligo pool      | Tile 31 (14490 oligos) | 275 nt  | TCTT  | AATA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TGGA]----5'WT sub5----[TCTT]----oligo+BC----[AATA]
   ATGA                   TATG                   TGAT                   TACT                   TGGA                   TCTT                  AATA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1581 nt | CCTT  | GACA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CCTT]----3'WT sub1----[GACA]----3'WT sub2----[CACC]----3'WT+PolIII sub3----
   CCTT                   GACA                   CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 32 of 47 -- Codons 2035-2106 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAGA     | 0.7444   |
| oh2 (3' boundary) | GAAG     | 0.6752   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4   | 1218 nt | TACT  | TGGA  |
| 5   | 5'WT gene block | bsai_5wt_tile32_sub5   | 1258 nt | TGGA  | GAGA  |
| 6   | Oligo pool      | Tile 32 (14280 oligos) | 272 nt  | GAGA  | AATA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TGGA]----5'WT sub5----[GAGA]----oligo+BC----[AATA]
   ATGA                   TATG                   TGAT                   TACT                   TGGA                   GAGA                  AATA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile32_sub1     | 1377 nt | GAAG  | GACA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAAG]----3'WT sub1----[GACA]----3'WT sub2----[CACC]----3'WT+PolIII sub3----
   GAAG                   GACA                   CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 33 of 47 -- Codons 2103-2173 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGAA     | 0.8847   |
| oh2 (3' boundary) | CACA     | 0.6141   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4   | 1218 nt | TACT  | TGGA  |
| 5   | 5'WT gene block | bsai_5wt_tile33_sub5   | 1462 nt | TGGA  | AGAA  |
| 6   | Oligo pool      | Tile 33 (14070 oligos) | 269 nt  | AGAA  | AATA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TGGA]----5'WT sub5----[CCTT]----oligo+BC----[AGAA][AATA]
   ATGA                   TATG                   TGAT                   TACT                   TGGA                   CCTT                  AGAA  AATA 
```

**Set fidelity:** 1.0000 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile33_sub1     | 1176 nt | CACA  | GACA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CACA]----3'WT sub1----[GACA]----3'WT sub2----[CACC]----3'WT+PolIII sub3----
   CACA                   GACA                   CACC 
```

**Set fidelity:** 0.8126 (3 overhangs)

---

### Tile 34 of 47 -- Codons 2170-2218 (147 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCT     | 0.8181   |
| oh2 (3' boundary) | TATC     | 0.8041   |

**Variants:** 9450 mutations, 9450 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4  | 1218 nt | TACT  | TGGA  |
| 5   | 5'WT gene block | bsai_5wt_tile34_sub5  | 1266 nt | TGGA  | CCTT  |
| 6   | 5'WT gene block | bsai_5wt_tile34_sub6  | 415 nt  | CCTT  | TTCT  |
| 7   | Oligo pool      | Tile 34 (9450 oligos) | 203 nt  | TTCT  | AATA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TGGA]----5'WT sub5----[CCTT]----5'WT sub6----[TTCT]----oligo+BC----[AATA]
   ATGA                   TATG                   TGAT                   TACT                   TGGA                   CCTT                   TTCT                  AATA 
```

**Set fidelity:** 0.9707 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile34_sub1     | 1041 nt | TATC  | GACA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TATC]----3'WT sub1----[GACA]----3'WT sub2----[CACC]----3'WT+PolIII sub3----
   TATC                   GACA                   CACC 
```

**Set fidelity:** 0.9961 (3 overhangs)

---

### Tile 35 of 47 -- Codons 2215-2284 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | AATC     | 0.7116   |

**Variants:** 13860 mutations, 13860 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4   | 1218 nt | TACT  | TGGA  |
| 5   | 5'WT gene block | bsai_5wt_tile34_sub5   | 1266 nt | TGGA  | CCTT  |
| 6   | 5'WT gene block | bsai_5wt_tile35_sub6   | 550 nt  | CCTT  | AAGA  |
| 7   | Oligo pool      | Tile 35 (13860 oligos) | 266 nt  | AAGA  | AATA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TGGA]----5'WT sub5----[CCTT]----5'WT sub6----[AAGA]----oligo+BC----[AATA]
   ATGA                   TATG                   TGAT                   TACT                   TGGA                   CCTT                   AAGA                  AATA 
```

**Set fidelity:** 0.9574 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile35_sub1     | 843 nt  | AATC  | GACA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AATC]----3'WT sub1----[GACA]----3'WT sub2----[CACC]----3'WT+PolIII sub3----
   AATC                   GACA                   CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 36 of 47 -- Codons 2281-2358 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACAT     | 0.6621   |
| oh2 (3' boundary) | CTCG     | 0.7252   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4   | 1218 nt | TACT  | TGGA  |
| 5   | 5'WT gene block | bsai_5wt_tile34_sub5   | 1266 nt | TGGA  | CCTT  |
| 6   | 5'WT gene block | bsai_5wt_tile36_sub6   | 748 nt  | CCTT  | ACAT  |
| 7   | Oligo pool      | Tile 36 (15540 oligos) | 290 nt  | ACAT  | AATA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TGGA]----5'WT sub5----[CCTT]----5'WT sub6----[ACAT]----oligo+BC----[AATA]
   ATGA                   TATG                   TGAT                   TACT                   TGGA                   CCTT                   ACAT                  AATA 
```

**Set fidelity:** 0.9984 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile36_sub1     | 621 nt  | CTCG  | GACA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTCG]----3'WT sub1----[GACA]----3'WT sub2----[CACC]----3'WT+PolIII sub3----
   CTCG                   GACA                   CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 37 of 47 -- Codons 2355-2419 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTG     | 0.6684   |
| oh2 (3' boundary) | CAGG     | 0.5358   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4   | 1218 nt | TACT  | TGGA  |
| 5   | 5'WT gene block | bsai_5wt_tile34_sub5   | 1266 nt | TGGA  | CCTT  |
| 6   | 5'WT gene block | bsai_5wt_tile37_sub6   | 970 nt  | CCTT  | TCTG  |
| 7   | Oligo pool      | Tile 37 (12810 oligos) | 251 nt  | TCTG  | AATA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TGGA]----5'WT sub5----[CCTT]----5'WT sub6----[TCTG]----oligo+BC----[AATA]
   ATGA                   TATG                   TGAT                   TACT                   TGGA                   CCTT                   TCTG                  AATA 
```

**Set fidelity:** 0.9908 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile37_sub1     | 438 nt  | CAGG  | GACA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CAGG]----3'WT sub1----[GACA]----3'WT sub2----[CACC]----3'WT+PolIII sub3----
   CAGG                   GACA                   CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 38 of 47 -- Codons 2416-2488 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAGA     | 0.7444   |
| oh2 (3' boundary) | CTCC     | 0.5510   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4   | 1218 nt | TACT  | TGGA  |
| 5   | 5'WT gene block | bsai_5wt_tile34_sub5   | 1266 nt | TGGA  | CCTT  |
| 6   | 5'WT gene block | bsai_5wt_tile38_sub6   | 1153 nt | CCTT  | GAGA  |
| 7   | Oligo pool      | Tile 38 (14490 oligos) | 275 nt  | GAGA  | AATA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TGGA]----5'WT sub5----[CCTT]----5'WT sub6----[GAGA]----oligo+BC----[AATA]
   ATGA                   TATG                   TGAT                   TACT                   TGGA                   CCTT                   GAGA                  AATA 
```

**Set fidelity:** 1.0000 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile38_sub1     | 231 nt  | CTCC  | GACA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | --    |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | --    | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTCC]----3'WT sub1----[GACA]----3'WT sub2----[CACC]----3'WT+PolIII sub3----
   CTCC                   GACA                   CACC 
```

**Set fidelity:** 0.7946 (3 overhangs)

---

### Tile 39 of 47 -- Codons 2485-2559 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCT     | 0.8181   |
| oh2 (3' boundary) | GACA     | 0.6127   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4   | 1218 nt | TACT  | TGGA  |
| 5   | 5'WT gene block | bsai_5wt_tile34_sub5   | 1266 nt | TGGA  | CCTT  |
| 6   | 5'WT gene block | bsai_5wt_tile39_sub6   | 1360 nt | CCTT  | TTCT  |
| 7   | Oligo pool      | Tile 39 (14910 oligos) | 281 nt  | TTCT  | AATA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TGGA]----5'WT sub5----[CCTT]----5'WT sub6----[TTCT]----oligo+BC----[AATA]
   ATGA                   TATG                   TGAT                   TACT                   TGGA                   CCTT                   TTCT                  AATA 
```

**Set fidelity:** 0.9707 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile39_sub1    | 951 nt  | GACA  | --    |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile39_sub2    | 1796 nt | --    | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GACA]----3'WT+PolIII----[CACC]
   GACA                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 40 of 47 -- Codons 2556-2631 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGT     | 0.6822   |
| oh2 (3' boundary) | ATCT     | 0.7151   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4   | 1218 nt | TACT  | TGGA  |
| 5   | 5'WT gene block | bsai_5wt_tile34_sub5   | 1266 nt | TGGA  | CCTT  |
| 6   | 5'WT gene block | bsai_5wt_tile40_sub6   | 1573 nt | CCTT  | ATGT  |
| 7   | Oligo pool      | Tile 40 (15120 oligos) | 284 nt  | ATGT  | AATA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TGGA]----5'WT sub5----[CCTT]----5'WT sub6----[ATGT]----oligo+BC----[AATA]
   ATGA                   TATG                   TGAT                   TACT                   TGGA                   CCTT                   ATGT                  AATA 
```

**Set fidelity:** 0.9294 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile40_sub1    | 735 nt  | ATCT  | --    |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile39_sub2    | 1796 nt | --    | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATCT]----3'WT+PolIII----[CACC]
   ATCT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 41 of 47 -- Codons 2628-2703 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGT     | 0.7629   |
| oh2 (3' boundary) | TGTT     | 0.6450   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4   | 1218 nt | TACT  | TGGA  |
| 5   | 5'WT gene block | bsai_5wt_tile34_sub5   | 1266 nt | TGGA  | CCTT  |
| 6   | 5'WT gene block | bsai_5wt_tile41_sub6   | 1789 nt | CCTT  | AAGT  |
| 7   | Oligo pool      | Tile 41 (15120 oligos) | 284 nt  | AAGT  | AATA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TGGA]----5'WT sub5----[CCTT]----5'WT sub6----[GACA]----oligo+BC----[AAGT][AATA]
   ATGA                   TATG                   TGAT                   TACT                   TGGA                   CCTT                   GACA                  AAGT  AATA 
```

**Set fidelity:** 1.0000 (9 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile41_sub1    | 690 nt  | TGTT  | --    |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile41_sub2    | 1625 nt | --    | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGTT]----3'WT+PolIII----[CACC]
   TGTT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 42 of 47 -- Codons 2700-2770 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | ATCG     | 0.5700   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4   | 1218 nt | TACT  | TGGA  |
| 5   | 5'WT gene block | bsai_5wt_tile34_sub5   | 1266 nt | TGGA  | CCTT  |
| 6   | 5'WT gene block | bsai_5wt_tile42_sub6   | 1581 nt | CCTT  | GACA  |
| 7   | 5'WT gene block | bsai_5wt_tile42_sub7   | 442 nt  | GACA  | GAAA  |
| 8   | Oligo pool      | Tile 42 (14070 oligos) | 269 nt  | GAAA  | AATA  |
| 9   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 10  | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TGGA]----5'WT sub5----[CCTT]----5'WT sub6----[GACA]----5'WT sub7----[GAAA]----oligo+BC----[AATA]
   ATGA                   TATG                   TGAT                   TACT                   TGGA                   CCTT                   GACA                   GAAA                  AATA 
```

**Set fidelity:** 0.9966 (9 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile42_sub1    | 489 nt  | ATCG  | --    |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile41_sub2    | 1625 nt | --    | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATCG]----3'WT+PolIII----[CACC]
   ATCG                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 43 of 47 -- Codons 2767-2815 (147 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAG     | 0.7814   |
| oh2 (3' boundary) | TCAG     | 0.7814   |

**Variants:** 9450 mutations, 9450 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4  | 1218 nt | TACT  | TGGA  |
| 5   | 5'WT gene block | bsai_5wt_tile34_sub5  | 1266 nt | TGGA  | CCTT  |
| 6   | 5'WT gene block | bsai_5wt_tile42_sub6  | 1581 nt | CCTT  | GACA  |
| 7   | 5'WT gene block | bsai_5wt_tile43_sub7  | 643 nt  | GACA  | TCAG  |
| 8   | Oligo pool      | Tile 43 (9450 oligos) | 203 nt  | TCAG  | AATA  |
| 9   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 10  | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TGGA]----5'WT sub5----[CCTT]----5'WT sub6----[GACA]----5'WT sub7----[TCAG]----oligo+BC----[AATA]
   ATGA                   TATG                   TGAT                   TACT                   TGGA                   CCTT                   GACA                   TCAG                  AATA 
```

**Set fidelity:** 1.0000 (9 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile43_sub1    | 354 nt  | TCAG  | --    |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile41_sub2    | 1625 nt | --    | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAG]----3'WT+PolIII----[CACC]
   TCAG                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 44 of 47 -- Codons 2812-2888 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAT     | 0.7737   |
| oh2 (3' boundary) | CACT     | 0.5337   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4   | 1218 nt | TACT  | TGGA  |
| 5   | 5'WT gene block | bsai_5wt_tile34_sub5   | 1266 nt | TGGA  | CCTT  |
| 6   | 5'WT gene block | bsai_5wt_tile42_sub6   | 1581 nt | CCTT  | GACA  |
| 7   | 5'WT gene block | bsai_5wt_tile44_sub7   | 778 nt  | GACA  | AAAT  |
| 8   | Oligo pool      | Tile 44 (15330 oligos) | 287 nt  | AAAT  | AATA  |
| 9   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 10  | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TGGA]----5'WT sub5----[CCTT]----5'WT sub6----[GACA]----5'WT sub7----[AAAT]----oligo+BC----[AATA]
   ATGA                   TATG                   TGAT                   TACT                   TGGA                   CCTT                   GACA                   AAAT                  AATA 
```

**Set fidelity:** 1.0000 (9 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile44         | 1742 nt | CACT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CACT]----3'WT+PolIII----[CACC]
   CACT                     CACC 
```

**Set fidelity:** 0.7829 (2 overhangs)

---

### Tile 45 of 47 -- Codons 2885-2955 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGAA     | 0.7463   |
| oh2 (3' boundary) | GAAC     | 0.6079   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4   | 1218 nt | TACT  | TGGA  |
| 5   | 5'WT gene block | bsai_5wt_tile34_sub5   | 1266 nt | TGGA  | CCTT  |
| 6   | 5'WT gene block | bsai_5wt_tile42_sub6   | 1581 nt | CCTT  | GACA  |
| 7   | 5'WT gene block | bsai_5wt_tile45_sub7   | 997 nt  | GACA  | GGAA  |
| 8   | Oligo pool      | Tile 45 (14070 oligos) | 269 nt  | GGAA  | AATA  |
| 9   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 10  | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TGGA]----5'WT sub5----[CCTT]----5'WT sub6----[GACA]----5'WT sub7----[GGAA]----oligo+BC----[AATA]
   ATGA                   TATG                   TGAT                   TACT                   TGGA                   CCTT                   GACA                   GGAA                  AATA 
```

**Set fidelity:** 1.0000 (9 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile45         | 1541 nt | GAAC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAC]----3'WT+PolIII----[CACC]
   GAAC                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 46 of 47 -- Codons 2952-3029 (234 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4   | 1218 nt | TACT  | TGGA  |
| 5   | 5'WT gene block | bsai_5wt_tile34_sub5   | 1266 nt | TGGA  | CCTT  |
| 6   | 5'WT gene block | bsai_5wt_tile42_sub6   | 1581 nt | CCTT  | GACA  |
| 7   | 5'WT gene block | bsai_5wt_tile46_sub7   | 1198 nt | GACA  | TTAC  |
| 8   | Oligo pool      | Tile 46 (15540 oligos) | 290 nt  | TTAC  | AATA  |
| 9   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 10  | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TGGA]----5'WT sub5----[CCTT]----5'WT sub6----[GACA]----5'WT sub7----[TTAC]----oligo+BC----[AATA]
   ATGA                   TATG                   TGAT                   TACT                   TGGA                   CCTT                   GACA                   TTAC                  AATA 
```

**Set fidelity:** 1.0000 (9 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile46         | 1319 nt | CTTC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTTC]----3'WT+PolIII----[CACC]
   CTTC                     CACC 
```

**Set fidelity:** 0.9984 (2 overhangs)

---

### Tile 47 of 47 -- Codons 3026-3098 (219 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4   | 1218 nt | TACT  | TGGA  |
| 5   | 5'WT gene block | bsai_5wt_tile34_sub5   | 1266 nt | TGGA  | CCTT  |
| 6   | 5'WT gene block | bsai_5wt_tile42_sub6   | 1581 nt | CCTT  | GACA  |
| 7   | 5'WT gene block | bsai_5wt_tile47_sub7   | 1420 nt | GACA  | TTCG  |
| 8   | Oligo pool      | Tile 47 (14490 oligos) | 275 nt  | TTCG  | AATA  |
| 9   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 10  | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TGGA]----5'WT sub5----[CCTT]----5'WT sub6----[GACA]----5'WT sub7----[TTCG]----oligo+BC----[AATA]
   ATGA                   TATG                   TGAT                   TACT                   TGGA                   CCTT                   GACA                   TTCG                  AATA 
```

**Set fidelity:** 0.9985 (9 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component            | Part name                | Length  | 5' OH | 3' OH |
| --- | -------------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product         | (in helper plasmid)      | --      | --    | --    |
| 2   | PolIII-only fragment | bsmbi_polIII_tile47      | 1112 nt | TTGA  | CACC  |
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

**Total blocks:** 103

| Block name                | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| ------------------------- | ----------- | ----------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10_sub1      | 1587        | BsaI        | 5wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile11_sub1      | 1388        | BsaI        | 5wt_tile11_sub1;5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1;5wt_tile26_sub1;5wt_tile27_sub1;5wt_tile28_sub1;5wt_tile29_sub1;5wt_tile30_sub1;5wt_tile31_sub1;5wt_tile32_sub1;5wt_tile33_sub1;5wt_tile34_sub1;5wt_tile35_sub1;5wt_tile36_sub1;5wt_tile37_sub1;5wt_tile38_sub1;5wt_tile39_sub1;5wt_tile40_sub1;5wt_tile41_sub1;5wt_tile42_sub1;5wt_tile43_sub1;5wt_tile44_sub1;5wt_tile45_sub1;5wt_tile46_sub1;5wt_tile47_sub1                                                                                                                                                                                                                                            |
| bsai_5wt_tile11_sub2      | 439         | BsaI        | 5wt_tile11_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile12_sub2      | 646         | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile13_sub2      | 835         | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile14_sub2      | 1057        | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile15_sub2      | 1246        | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile16_sub2      | 1065        | BsaI        | 5wt_tile16_sub2;5wt_tile17_sub2;5wt_tile18_sub2;5wt_tile19_sub2;5wt_tile20_sub2;5wt_tile21_sub2;5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2;5wt_tile26_sub2;5wt_tile27_sub2;5wt_tile28_sub2;5wt_tile29_sub2;5wt_tile30_sub2;5wt_tile31_sub2;5wt_tile32_sub2;5wt_tile33_sub2;5wt_tile34_sub2;5wt_tile35_sub2;5wt_tile36_sub2;5wt_tile37_sub2;5wt_tile38_sub2;5wt_tile39_sub2;5wt_tile40_sub2;5wt_tile41_sub2;5wt_tile42_sub2;5wt_tile43_sub2;5wt_tile44_sub2;5wt_tile45_sub2;5wt_tile46_sub2;5wt_tile47_sub2                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile16_sub3      | 382         | BsaI        | 5wt_tile16_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile17_sub3      | 604         | BsaI        | 5wt_tile17_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile18_sub3      | 811         | BsaI        | 5wt_tile18_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile19_sub3      | 1033        | BsaI        | 5wt_tile19_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile2            | 177         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile20_sub3      | 1255        | BsaI        | 5wt_tile20_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile21_sub3      | 1477        | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile22_sub3      | 1263        | BsaI        | 5wt_tile22_sub3;5wt_tile23_sub3;5wt_tile24_sub3;5wt_tile25_sub3;5wt_tile26_sub3;5wt_tile27_sub3;5wt_tile28_sub3;5wt_tile29_sub3;5wt_tile30_sub3;5wt_tile31_sub3;5wt_tile32_sub3;5wt_tile33_sub3;5wt_tile34_sub3;5wt_tile35_sub3;5wt_tile36_sub3;5wt_tile37_sub3;5wt_tile38_sub3;5wt_tile39_sub3;5wt_tile40_sub3;5wt_tile41_sub3;5wt_tile42_sub3;5wt_tile43_sub3;5wt_tile44_sub3;5wt_tile45_sub3;5wt_tile46_sub3;5wt_tile47_sub3                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile22_sub4      | 391         | BsaI        | 5wt_tile22_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile23_sub4      | 613         | BsaI        | 5wt_tile23_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile24_sub4      | 787         | BsaI        | 5wt_tile24_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile25_sub4      | 1009        | BsaI        | 5wt_tile25_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile26_sub4      | 1210        | BsaI        | 5wt_tile26_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile27_sub4      | 1405        | BsaI        | 5wt_tile27_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile28_sub4      | 1218        | BsaI        | 5wt_tile28_sub4;5wt_tile29_sub4;5wt_tile30_sub4;5wt_tile31_sub4;5wt_tile32_sub4;5wt_tile33_sub4;5wt_tile34_sub4;5wt_tile35_sub4;5wt_tile36_sub4;5wt_tile37_sub4;5wt_tile38_sub4;5wt_tile39_sub4;5wt_tile40_sub4;5wt_tile41_sub4;5wt_tile42_sub4;5wt_tile43_sub4;5wt_tile44_sub4;5wt_tile45_sub4;5wt_tile46_sub4;5wt_tile47_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile28_sub5      | 427         | BsaI        | 5wt_tile28_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile29_sub5      | 637         | BsaI        | 5wt_tile29_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile3            | 339         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile30_sub5      | 859         | BsaI        | 5wt_tile30_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile31_sub5      | 1051        | BsaI        | 5wt_tile31_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile32_sub5      | 1258        | BsaI        | 5wt_tile32_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile33_sub5      | 1462        | BsaI        | 5wt_tile33_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile34_sub5      | 1266        | BsaI        | 5wt_tile34_sub5;5wt_tile35_sub5;5wt_tile36_sub5;5wt_tile37_sub5;5wt_tile38_sub5;5wt_tile39_sub5;5wt_tile40_sub5;5wt_tile41_sub5;5wt_tile42_sub5;5wt_tile43_sub5;5wt_tile44_sub5;5wt_tile45_sub5;5wt_tile46_sub5;5wt_tile47_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile34_sub6      | 415         | BsaI        | 5wt_tile34_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile35_sub6      | 550         | BsaI        | 5wt_tile35_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile36_sub6      | 748         | BsaI        | 5wt_tile36_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile37_sub6      | 970         | BsaI        | 5wt_tile37_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile38_sub6      | 1153        | BsaI        | 5wt_tile38_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile39_sub6      | 1360        | BsaI        | 5wt_tile39_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile4            | 543         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile40_sub6      | 1573        | BsaI        | 5wt_tile40_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile41_sub6      | 1789        | BsaI        | 5wt_tile41_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile42_sub6      | 1581        | BsaI        | 5wt_tile42_sub6;5wt_tile43_sub6;5wt_tile44_sub6;5wt_tile45_sub6;5wt_tile46_sub6;5wt_tile47_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile42_sub7      | 442         | BsaI        | 5wt_tile42_sub7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile43_sub7      | 643         | BsaI        | 5wt_tile43_sub7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile44_sub7      | 778         | BsaI        | 5wt_tile44_sub7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile45_sub7      | 997         | BsaI        | 5wt_tile45_sub7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile46_sub7      | 1198        | BsaI        | 5wt_tile46_sub7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile47_sub7      | 1420        | BsaI        | 5wt_tile47_sub7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile5            | 660         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile6            | 810         | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile7            | 1011        | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile8            | 1203        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile9            | 1380        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile1_sub1      | 1221        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile1_sub2      | 1065        | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile1_sub3      | 1263        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub2;3wt_tile8_sub2;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile1_sub4      | 1218        | BsmBI       | 3wt_tile1_sub4;3wt_tile2_sub4;3wt_tile3_sub4;3wt_tile4_sub4;3wt_tile5_sub4;3wt_tile6_sub4;3wt_tile7_sub3;3wt_tile8_sub3;3wt_tile9_sub3;3wt_tile10_sub3;3wt_tile11_sub3;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2;3wt_tile16_sub2;3wt_tile17_sub2;3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile1_sub5      | 1266        | BsmBI       | 3wt_tile1_sub5;3wt_tile2_sub5;3wt_tile3_sub5;3wt_tile4_sub5;3wt_tile5_sub5;3wt_tile6_sub5;3wt_tile7_sub4;3wt_tile8_sub4;3wt_tile9_sub4;3wt_tile10_sub4;3wt_tile11_sub4;3wt_tile12_sub3;3wt_tile13_sub3;3wt_tile14_sub3;3wt_tile15_sub3;3wt_tile16_sub3;3wt_tile17_sub3;3wt_tile18_sub2;3wt_tile19_sub2;3wt_tile20_sub2;3wt_tile21_sub2;3wt_tile22_sub2;3wt_tile23_sub2;3wt_tile25_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile1_sub6      | 1581        | BsmBI       | 3wt_tile1_sub6;3wt_tile2_sub6;3wt_tile3_sub6;3wt_tile4_sub6;3wt_tile5_sub6;3wt_tile6_sub6;3wt_tile7_sub5;3wt_tile8_sub5;3wt_tile9_sub5;3wt_tile10_sub5;3wt_tile11_sub5;3wt_tile12_sub4;3wt_tile13_sub4;3wt_tile14_sub4;3wt_tile15_sub4;3wt_tile16_sub4;3wt_tile17_sub4;3wt_tile18_sub3;3wt_tile19_sub3;3wt_tile20_sub3;3wt_tile21_sub3;3wt_tile22_sub3;3wt_tile23_sub3;3wt_tile24_sub2;3wt_tile25_sub2;3wt_tile26_sub2;3wt_tile27_sub2;3wt_tile28_sub2;3wt_tile29_sub2;3wt_tile31_sub1                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile1_sub7      | 1765        | BsmBI       | 3wt_tile1_sub7;3wt_tile2_sub7;3wt_tile3_sub7;3wt_tile4_sub7;3wt_tile5_sub7;3wt_tile6_sub7;3wt_tile7_sub6;3wt_tile8_sub6;3wt_tile9_sub6;3wt_tile10_sub6;3wt_tile11_sub6;3wt_tile12_sub5;3wt_tile13_sub5;3wt_tile14_sub5;3wt_tile15_sub5;3wt_tile16_sub5;3wt_tile17_sub5;3wt_tile18_sub4;3wt_tile19_sub4;3wt_tile20_sub4;3wt_tile21_sub4;3wt_tile22_sub4;3wt_tile23_sub4;3wt_tile24_sub3;3wt_tile25_sub3;3wt_tile26_sub3;3wt_tile27_sub3;3wt_tile28_sub3;3wt_tile29_sub3;3wt_tile30_sub2;3wt_tile31_sub2;3wt_tile32_sub2;3wt_tile33_sub2;3wt_tile34_sub2;3wt_tile35_sub2;3wt_tile36_sub2;3wt_tile37_sub2;3wt_tile38_sub2                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile10_sub1     | 636         | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile11_sub1     | 429         | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile12_sub1     | 1485        | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile14_sub1     | 1074        | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile15_sub1     | 891         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile16_sub1     | 669         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile17_sub1     | 462         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile18_sub1     | 1440        | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile2_sub1      | 1059        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile20_sub1     | 996         | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile21_sub1     | 837         | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile22_sub1     | 615         | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile23_sub1     | 441         | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile24_sub1     | 1467        | BsmBI       | 3wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile26_sub1     | 1071        | BsmBI       | 3wt_tile26_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile27_sub1     | 849         | BsmBI       | 3wt_tile27_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile28_sub1     | 639         | BsmBI       | 3wt_tile28_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile29_sub1     | 417         | BsmBI       | 3wt_tile29_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile3_sub1      | 855         | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile30_sub1     | 1788        | BsmBI       | 3wt_tile30_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile32_sub1     | 1377        | BsmBI       | 3wt_tile32_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile33_sub1     | 1176        | BsmBI       | 3wt_tile33_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile34_sub1     | 1041        | BsmBI       | 3wt_tile34_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile35_sub1     | 843         | BsmBI       | 3wt_tile35_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile36_sub1     | 621         | BsmBI       | 3wt_tile36_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile37_sub1     | 438         | BsmBI       | 3wt_tile37_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile38_sub1     | 231         | BsmBI       | 3wt_tile38_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile39_sub1     | 951         | BsmBI       | 3wt_tile39_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile39_sub2     | 1796        | BsmBI       | 3wt_polIII_tile39_sub2;3wt_polIII_tile40_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile4_sub1      | 738         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile40_sub1     | 735         | BsmBI       | 3wt_tile40_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile41_sub1     | 690         | BsmBI       | 3wt_tile41_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile41_sub2     | 1625        | BsmBI       | 3wt_polIII_tile41_sub2;3wt_polIII_tile42_sub2;3wt_polIII_tile43_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile42_sub1     | 489         | BsmBI       | 3wt_tile42_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile43_sub1     | 354         | BsmBI       | 3wt_tile43_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile44          | 1742        | BsmBI       | 3wt_polIII_tile44                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile45          | 1541        | BsmBI       | 3wt_polIII_tile45                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile46          | 1319        | BsmBI       | 3wt_polIII_tile46                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile5_sub1      | 588         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile6_sub1      | 387         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile7_sub1      | 1242        | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile9_sub1      | 858         | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_cassette_tile1_sub8 | 982         | BsmBI       | cassette_tile1_frag1;cassette_tile2_frag1;cassette_tile3_frag1;cassette_tile4_frag1;cassette_tile5_frag1;cassette_tile6_frag1;cassette_tile7_frag1;cassette_tile8_frag1;cassette_tile9_frag1;cassette_tile10_frag1;cassette_tile11_frag1;cassette_tile12_frag1;cassette_tile13_frag1;cassette_tile14_frag1;cassette_tile15_frag1;cassette_tile16_frag1;cassette_tile17_frag1;cassette_tile18_frag1;cassette_tile19_frag1;cassette_tile20_frag1;cassette_tile21_frag1;cassette_tile22_frag1;cassette_tile23_frag1;cassette_tile24_frag1;cassette_tile25_frag1;cassette_tile26_frag1;cassette_tile27_frag1;cassette_tile28_frag1;cassette_tile29_frag1;cassette_tile30_frag1;cassette_tile31_frag1;cassette_tile32_frag1;cassette_tile33_frag1;cassette_tile34_frag1;cassette_tile35_frag1;cassette_tile36_frag1;cassette_tile37_frag1;cassette_tile38_frag1 |
| bsmbi_polIII_tile47       | 1112        | BsmBI       | polIII_tile47                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |

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

