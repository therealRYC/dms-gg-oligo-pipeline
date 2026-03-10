# DMS-GG Assembly Report: TRIO

Generated: 2026-03-09 18:42:05
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
| Total oligos         | 64974                                                                         |
| Oligo length range   | 149-290 nt                                                                    |
| Gene blocks to order | 103                                                                           |
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

**Total oligos:** 64974 | **Length range:** 149-290 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-57      | 1113   | 227 nt |
| 2    | 54-111    | 1134   | 230 nt |
| 3    | 108-179   | 1428   | 272 nt |
| 4    | 176-218   | 819    | 185 nt |
| 5    | 215-268   | 1050   | 218 nt |
| 6    | 265-335   | 1407   | 269 nt |
| 7    | 332-399   | 1344   | 260 nt |
| 8    | 396-458   | 1239   | 245 nt |
| 9    | 455-527   | 1449   | 275 nt |
| 10   | 524-601   | 1554   | 290 nt |
| 11   | 598-670   | 1449   | 275 nt |
| 12   | 667-733   | 1323   | 257 nt |
| 13   | 730-807   | 1554   | 290 nt |
| 14   | 804-870   | 1323   | 257 nt |
| 15   | 867-931   | 1281   | 251 nt |
| 16   | 928-1005  | 1554   | 290 nt |
| 17   | 1002-1079 | 1554   | 290 nt |
| 18   | 1076-1148 | 1449   | 275 nt |
| 19   | 1145-1222 | 1554   | 290 nt |
| 20   | 1219-1296 | 1554   | 290 nt |
| 21   | 1293-1349 | 1113   | 227 nt |
| 22   | 1346-1423 | 1554   | 290 nt |
| 23   | 1420-1481 | 1218   | 242 nt |
| 24   | 1478-1555 | 1554   | 290 nt |
| 25   | 1552-1622 | 1407   | 269 nt |
| 26   | 1619-1690 | 1428   | 272 nt |
| 27   | 1687-1764 | 1554   | 290 nt |
| 28   | 1761-1831 | 1407   | 269 nt |
| 29   | 1828-1905 | 1554   | 290 nt |
| 30   | 1902-1977 | 1512   | 284 nt |
| 31   | 1974-2045 | 1428   | 272 nt |
| 32   | 2042-2119 | 1554   | 290 nt |
| 33   | 2116-2191 | 1512   | 284 nt |
| 34   | 2188-2218 | 567    | 149 nt |
| 35   | 2215-2284 | 1386   | 266 nt |
| 36   | 2281-2358 | 1554   | 290 nt |
| 37   | 2355-2419 | 1281   | 251 nt |
| 38   | 2416-2487 | 1428   | 272 nt |
| 39   | 2484-2559 | 1512   | 284 nt |
| 40   | 2556-2631 | 1512   | 284 nt |
| 41   | 2628-2703 | 1512   | 284 nt |
| 42   | 2700-2770 | 1407   | 269 nt |
| 43   | 2767-2814 | 924    | 200 nt |
| 44   | 2811-2888 | 1554   | 290 nt |
| 45   | 2885-2955 | 1407   | 269 nt |
| 46   | 2952-3029 | 1554   | 290 nt |
| 47   | 3026-3098 | 1449   | 275 nt |

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
| Total barcodes    | 64974                              |
| Unique barcodes   | 64974                              |
| GC content range  | 25% - 75%                          |
| GC content mean   | 47.9%                              |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                     | Description                                                   | Result | Detail                                                                                                                                              |
| ------------------------- | ------------------------------------------------------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths             | All oligos within synthesis length limit                      | PASS   | Range: 149-290 nt (limit: 300)                                                                                                                      |
| block_lengths             | All gene blocks within synthesis length limit                 | PASS   | Range: 177-1796 nt (limit: 1800)                                                                                                                    |
| barcode_junction_sites    | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                             |
| barcode_uniqueness        | All barcodes are unique                                       | PASS   | 64974 unique / 64974 total                                                                                                                          |
| tile_coverage             | Tiles cover entire gene without gaps                          | PASS   | 9294 / 9294 nt covered                                                                                                                              |
| variant_count             | Expected number of variants generated                         | PASS   | 64974 unique variants (expected: 64974 across 3094/3096 mutable positions; 58786 missense + 3094 nonsense + 3094 wt_control; 2 position(s) skipped) |
| single_codon_change       | Each non-control variant differs by exactly one codon from WT | PASS   | 61880 / 61880 variants confirmed (WT controls excluded)                                                                                             |
| oligo_gc_content          | Oligo GC content within reasonable range (25-75%)             | FAIL   | GC range: 38.6-75.2% | 2 oligo(s) with extreme GC                                                                                                   |
| domestication_complete    | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                             |
| overhang_fidelity         | Tile boundary overhangs have adequate fidelity                | FAIL   | 44 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                             |
| tile_manifests            | Per-tile assembly manifests complete                          | PASS   | 47 tile manifest(s) generated                                                                                                                       |
| helper_plasmid            | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                  |
| reaction_fidelity         | Per-reaction set-level overhang fidelity                      | FAIL   | Min set fidelity: 0.7829 across 94 reactions | 2 reaction(s) below 0.90                                                                             |
| barcode_poliii_term       | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 64974 barcode(s) contain TTTT                                                                                                                   |
| block_min_length          | All gene blocks above synthesis minimum length                | FAIL   | 6 block(s) below 300 nt minimum. Range: 177-1796 nt                                                                                                 |
| cassette_fragment_lengths | Cassette fragments within synthesis limits                    | PASS   | 1 cassette fragment(s). Range: 982-982 nt. 0 over max, 0 under min.                                                                                 |
| sb_overhang_collisions    | Superblock boundary overhangs are unique (no collisions)      | PASS   | 7 SB boundary OH(s), all unique                                                                                                                     |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 9         | 0.9746             |
| 2    | 3        | 1.0000            | 9         | 0.9562             |
| 3    | 3        | 1.0000            | 9         | 0.9746             |
| 4    | 3        | 1.0000            | 9         | 0.9746             |
| 5    | 3        | 1.0000            | 9         | 0.9432             |
| 6    | 3        | 0.9574            | 9         | 0.9746             |
| 7    | 3        | 0.9656            | 8         | 0.9848             |
| 8    | 3        | 1.0000            | 8         | 0.9746             |
| 9    | 3        | 1.0000            | 8         | 0.9794             |
| 10   | 3        | 0.9928            | 8         | 0.9758             |
| 11   | 4        | 1.0000            | 8         | 0.8642             |
| 12   | 4        | 0.9574            | 7         | 0.9848             |
| 13   | 4        | 1.0000            | 7         | 0.9848             |
| 14   | 4        | 1.0000            | 7         | 0.9848             |
| 15   | 4        | 1.0000            | 7         | 0.9848             |
| 16   | 5        | 1.0000            | 7         | 0.9848             |
| 17   | 5        | 0.9574            | 7         | 0.9848             |
| 18   | 5        | 0.9981            | 6         | 1.0000             |
| 19   | 5        | 0.9656            | 6         | 0.9848             |
| 20   | 5        | 1.0000            | 6         | 1.0000             |
| 21   | 5        | 1.0000            | 6         | 1.0000             |
| 22   | 6        | 1.0000            | 5         | 1.0000             |
| 23   | 6        | 0.9790            | 5         | 0.9981             |
| 24   | 6        | 1.0000            | 5         | 1.0000             |
| 25   | 7        | 0.9774            | 5         | 1.0000             |
| 26   | 7        | 0.9438            | 5         | 1.0000             |
| 27   | 7        | 0.9774            | 5         | 1.0000             |
| 28   | 7        | 0.9774            | 5         | 1.0000             |
| 29   | 7        | 0.9774            | 5         | 1.0000             |
| 30   | 7        | 0.9774            | 4         | 1.0000             |
| 31   | 7        | 0.9774            | 4         | 1.0000             |
| 32   | 8        | 0.9774            | 4         | 1.0000             |
| 33   | 8        | 0.9774            | 4         | 1.0000             |
| 34   | 8        | 0.9729            | 4         | 0.9961             |
| 35   | 8        | 0.9358            | 4         | 1.0000             |
| 36   | 8        | 0.9727            | 4         | 1.0000             |
| 37   | 8        | 0.9684            | 4         | 1.0000             |
| 38   | 8        | 0.9774            | 4         | 1.0000             |
| 39   | 8        | 0.9569            | 3         | 1.0000             |
| 40   | 8        | 0.9084            | 3         | 1.0000             |
| 41   | 9        | 0.9774            | 3         | 1.0000             |
| 42   | 9        | 0.9741            | 3         | 1.0000             |
| 43   | 9        | 0.9774            | 3         | 1.0000             |
| 44   | 9        | 0.9358            | 2         | 0.7829             |
| 45   | 9        | 0.9258            | 2         | 1.0000             |
| 46   | 9        | 0.9774            | 2         | 0.9984             |
| 47   | 9        | 0.9759            | 2         | 1.0000             |

**Min:** 0.7829 | **Max:** 1.0000 | **Mean:** 0.9810

**Warning:** 2 reaction(s) below 0.90 fidelity — consider alternative split points or overhang reassignment.
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

### Tile 1 of 47 -- Codons 1-57 (171 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGA     | 0.7549   |
| oh2 (3' boundary) | AAAC     | 0.6694   |

**Variants:** 1113 mutations, 1113 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (1113 oligos)               | 227 nt | ATGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert              | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart               | --     | --    | --    |

```
  [ATGA]----oligo+BC----[AGAA]
   ATGA                  AGAA 
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
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 621 nt  | TACT  | TATT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1680 nt | TATT  | ACTA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1764 nt | ACTA  | GACA  |
| 8   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 9   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 10  | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AAAC]----3'WT sub1----[TATG]----3'WT sub2----[TGAT]----3'WT sub3----[TACT]----3'WT sub4----[TATT]----3'WT sub5----[ACTA]----3'WT sub6----[GACA]----3'WT sub7----[TTCA]----3'WT+PolIII sub8----[CACC]
   AAAC                   TATG                   TGAT                   TACT                   TATT                   ACTA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 0.9746 (9 overhangs)

---

### Tile 2 of 47 -- Codons 54-111 (174 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTTC     | 0.8348   |
| oh2 (3' boundary) | TCTA     | 0.8892   |

**Variants:** 1134 mutations, 1134 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 177 nt | ATGA  | TTTC  |
| 2   | Oligo pool      | Tile 2 (1134 oligos)  | 230 nt | TTTC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[TTTC]----oligo+BC----[AGAA]
   ATGA                    TTTC                  AGAA 
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
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 621 nt  | TACT  | TATT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1680 nt | TATT  | ACTA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1764 nt | ACTA  | GACA  |
| 8   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 9   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 10  | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TCTA]----3'WT sub1----[TATG]----3'WT sub2----[TGAT]----3'WT sub3----[TACT]----3'WT sub4----[TATT]----3'WT sub5----[ACTA]----3'WT sub6----[GACA]----3'WT sub7----[TTCA]----3'WT+PolIII sub8----[CACC]
   TCTA                   TATG                   TGAT                   TACT                   TATT                   ACTA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 0.9562 (9 overhangs)

---

### Tile 3 of 47 -- Codons 108-179 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTT     | 0.7664   |
| oh2 (3' boundary) | ATTT     | 0.7664   |

**Variants:** 1428 mutations, 1428 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 339 nt | ATGA  | ATTT  |
| 2   | Oligo pool      | Tile 3 (1428 oligos)  | 272 nt | ATTT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[ATTT]----oligo+BC----[AGAA]
   ATGA                    ATTT                  AGAA 
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
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 621 nt  | TACT  | TATT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1680 nt | TATT  | ACTA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1764 nt | ACTA  | GACA  |
| 8   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 9   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 10  | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [ATTT]----3'WT sub1----[TATG]----3'WT sub2----[TGAT]----3'WT sub3----[TACT]----3'WT sub4----[TATT]----3'WT sub5----[ACTA]----3'WT sub6----[GACA]----3'WT sub7----[TTCA]----3'WT+PolIII sub8----[CACC]
   ATTT                   TATG                   TGAT                   TACT                   TATT                   ACTA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 0.9746 (9 overhangs)

---

### Tile 4 of 47 -- Codons 176-218 (129 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAT     | 0.7737   |
| oh2 (3' boundary) | AGTT     | 0.6748   |

**Variants:** 819 mutations, 819 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 543 nt | ATGA  | AAAT  |
| 2   | Oligo pool      | Tile 4 (819 oligos)   | 185 nt | AAAT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[AAAT]----oligo+BC----[AGAA]
   ATGA                    AAAT                  AGAA 
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
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 621 nt  | TACT  | TATT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1680 nt | TATT  | ACTA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1764 nt | ACTA  | GACA  |
| 8   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 9   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 10  | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AGTT]----3'WT sub1----[TATG]----3'WT sub2----[TGAT]----3'WT sub3----[TACT]----3'WT sub4----[TATT]----3'WT sub5----[ACTA]----3'WT sub6----[GACA]----3'WT sub7----[TTCA]----3'WT+PolIII sub8----[CACC]
   AGTT                   TATG                   TGAT                   TACT                   TATT                   ACTA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 0.9746 (9 overhangs)

---

### Tile 5 of 47 -- Codons 215-268 (162 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | GATT     | 0.6417   |

**Variants:** 1050 mutations, 1050 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 660 nt | ATGA  | GAAA  |
| 2   | Oligo pool      | Tile 5 (1050 oligos)  | 218 nt | GAAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[GAAA]----oligo+BC----[AGAA]
   ATGA                    GAAA                  AGAA 
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
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 621 nt  | TACT  | TATT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1680 nt | TATT  | ACTA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1764 nt | ACTA  | GACA  |
| 8   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 9   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 10  | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GATT]----3'WT sub1----[TATG]----3'WT sub2----[TGAT]----3'WT sub3----[TACT]----3'WT sub4----[TATT]----3'WT sub5----[ACTA]----3'WT sub6----[GACA]----3'WT sub7----[TTCA]----3'WT+PolIII sub8----[CACC]
   GATT                   TATG                   TGAT                   TACT                   TATT                   ACTA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 0.9432 (9 overhangs)

---

### Tile 6 of 47 -- Codons 265-335 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | GAAG     | 0.6752   |

**Variants:** 1407 mutations, 1407 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 810 nt | ATGA  | AAGA  |
| 2   | Oligo pool      | Tile 6 (1407 oligos)  | 269 nt | AAGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[AAGA]----oligo+BC----[AGAA]
   ATGA                    AAGA                  AGAA 
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
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 621 nt  | TACT  | TATT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1680 nt | TATT  | ACTA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1764 nt | ACTA  | GACA  |
| 8   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 9   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 10  | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAAG]----3'WT sub1----[TATG]----3'WT sub2----[TGAT]----3'WT sub3----[TACT]----3'WT sub4----[TATT]----3'WT sub5----[ACTA]----3'WT sub6----[GACA]----3'WT sub7----[TTCA]----3'WT+PolIII sub8----[CACC]
   GAAG                   TATG                   TGAT                   TACT                   TATT                   ACTA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 0.9746 (9 overhangs)

---

### Tile 7 of 47 -- Codons 332-399 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGGA     | 0.7515   |
| oh2 (3' boundary) | AAAC     | 0.6694   |

**Variants:** 1344 mutations, 1344 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 1011 nt | ATGA  | AGGA  |
| 2   | Oligo pool      | Tile 7 (1344 oligos)  | 260 nt  | AGGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT block----[AGGA]----oligo+BC----[AGAA]
   ATGA                    AGGA                  AGAA 
```

**Set fidelity:** 0.9656 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1      | 1242 nt | AAAC  | TGAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1263 nt | TGAT  | TACT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 621 nt  | TACT  | TATT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1680 nt | TATT  | ACTA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1764 nt | ACTA  | GACA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AAAC]----3'WT sub1----[TGAT]----3'WT sub2----[TACT]----3'WT sub3----[TATT]----3'WT sub4----[ACTA]----3'WT sub5----[GACA]----3'WT sub6----[TTCA]----3'WT+PolIII sub7----[CACC]
   AAAC                   TGAT                   TACT                   TATT                   ACTA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 0.9848 (8 overhangs)

---

### Tile 8 of 47 -- Codons 396-458 (189 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTAA     | 0.8029   |
| oh2 (3' boundary) | TATG     | 0.7006   |

**Variants:** 1239 mutations, 1239 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1203 nt | ATGA  | GTAA  |
| 2   | Oligo pool      | Tile 8 (1239 oligos)  | 245 nt  | GTAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT block----[GTAA]----oligo+BC----[AGAA]
   ATGA                    GTAA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1065 nt | TATG  | TGAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1263 nt | TGAT  | TACT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 621 nt  | TACT  | TATT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1680 nt | TATT  | ACTA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1764 nt | ACTA  | GACA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TATG]----3'WT sub1----[TGAT]----3'WT sub2----[TACT]----3'WT sub3----[TATT]----3'WT sub4----[ACTA]----3'WT sub5----[GACA]----3'WT sub6----[TTCA]----3'WT+PolIII sub7----[CACC]
   TATG                   TGAT                   TACT                   TATT                   ACTA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 0.9746 (8 overhangs)

---

### Tile 9 of 47 -- Codons 455-527 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | CTCT     | 0.6347   |

**Variants:** 1449 mutations, 1449 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1380 nt | ATGA  | GAAA  |
| 2   | Oligo pool      | Tile 9 (1449 oligos)  | 275 nt  | GAAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT block----[GAAA]----oligo+BC----[AGAA]
   ATGA                    GAAA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1      | 858 nt  | CTCT  | TGAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1263 nt | TGAT  | TACT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 621 nt  | TACT  | TATT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1680 nt | TATT  | ACTA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1764 nt | ACTA  | GACA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTCT]----3'WT sub1----[TGAT]----3'WT sub2----[TACT]----3'WT sub3----[TATT]----3'WT sub4----[ACTA]----3'WT sub5----[GACA]----3'WT sub6----[TTCA]----3'WT+PolIII sub7----[CACC]
   CTCT                   TGAT                   TACT                   TATT                   ACTA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 0.9794 (8 overhangs)

---

### Tile 10 of 47 -- Codons 524-601 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTGA     | 0.6791   |
| oh2 (3' boundary) | TCAT     | 0.8102   |

**Variants:** 1554 mutations, 1554 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1587 nt | ATGA  | CTGA  |
| 2   | Oligo pool      | Tile 10 (1554 oligos) | 290 nt  | CTGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT block----[CTGA]----oligo+BC----[AGAA]
   ATGA                    CTGA                  AGAA 
```

**Set fidelity:** 0.9928 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1     | 636 nt  | TCAT  | TGAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1263 nt | TGAT  | TACT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 621 nt  | TACT  | TATT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1680 nt | TATT  | ACTA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1764 nt | ACTA  | GACA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TCAT]----3'WT sub1----[TGAT]----3'WT sub2----[TACT]----3'WT sub3----[TATT]----3'WT sub4----[ACTA]----3'WT sub5----[GACA]----3'WT sub6----[TTCA]----3'WT+PolIII sub7----[CACC]
   TCAT                   TGAT                   TACT                   TATT                   ACTA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 0.9758 (8 overhangs)

---

### Tile 11 of 47 -- Codons 598-670 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAT     | 0.7737   |
| oh2 (3' boundary) | ACTG     | 0.5529   |

**Variants:** 1449 mutations, 1449 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile11_sub2  | 439 nt  | TATG  | AAAT  |
| 3   | Oligo pool      | Tile 11 (1449 oligos) | 275 nt  | AAAT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[AAAT]----oligo+BC----[AGAA]
   ATGA                   TATG                   AAAT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1     | 429 nt  | ACTG  | TGAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1263 nt | TGAT  | TACT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 621 nt  | TACT  | TATT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1680 nt | TATT  | ACTA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1764 nt | ACTA  | GACA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [ACTG]----3'WT sub1----[TGAT]----3'WT sub2----[TACT]----3'WT sub3----[TATT]----3'WT sub4----[ACTA]----3'WT sub5----[GACA]----3'WT sub6----[TTCA]----3'WT+PolIII sub7----[CACC]
   ACTG                   TGAT                   TACT                   TATT                   ACTA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 0.8642 (8 overhangs)

---

### Tile 12 of 47 -- Codons 667-733 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | GGAC     | 0.5754   |

**Variants:** 1323 mutations, 1323 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2  | 646 nt  | TATG  | AAGA  |
| 3   | Oligo pool      | Tile 12 (1323 oligos) | 257 nt  | AAGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[AAGA]----oligo+BC----[AGAA]
   ATGA                   TATG                   AAGA                  AGAA 
```

**Set fidelity:** 0.9574 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1     | 1485 nt | GGAC  | TACT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 621 nt  | TACT  | TATT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1680 nt | TATT  | ACTA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1764 nt | ACTA  | GACA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GGAC]----3'WT sub1----[TACT]----3'WT sub2----[TATT]----3'WT sub3----[ACTA]----3'WT sub4----[GACA]----3'WT sub5----[TTCA]----3'WT+PolIII sub6----[CACC]
   GGAC                   TACT                   TATT                   ACTA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 0.9848 (7 overhangs)

---

### Tile 13 of 47 -- Codons 730-807 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAG     | 0.6752   |
| oh2 (3' boundary) | TGAT     | 0.6933   |

**Variants:** 1554 mutations, 1554 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2  | 835 nt  | TATG  | GAAG  |
| 3   | Oligo pool      | Tile 13 (1554 oligos) | 290 nt  | GAAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[GAAG]----oligo+BC----[AGAA]
   ATGA                   TATG                   GAAG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1263 nt | TGAT  | TACT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 621 nt  | TACT  | TATT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1680 nt | TATT  | ACTA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1764 nt | ACTA  | GACA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGAT]----3'WT sub1----[TACT]----3'WT sub2----[TATT]----3'WT sub3----[ACTA]----3'WT sub4----[GACA]----3'WT sub5----[TTCA]----3'WT+PolIII sub6----[CACC]
   TGAT                   TACT                   TATT                   ACTA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 0.9848 (7 overhangs)

---

### Tile 14 of 47 -- Codons 804-870 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTT     | 0.7985   |
| oh2 (3' boundary) | TAGA     | 0.9115   |

**Variants:** 1323 mutations, 1323 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2  | 1057 nt | TATG  | TCTT  |
| 3   | Oligo pool      | Tile 14 (1323 oligos) | 257 nt  | TCTT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TCTT]----oligo+BC----[AGAA]
   ATGA                   TATG                   TCTT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1     | 1074 nt | TAGA  | TACT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 621 nt  | TACT  | TATT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1680 nt | TATT  | ACTA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1764 nt | ACTA  | GACA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TAGA]----3'WT sub1----[TACT]----3'WT sub2----[TATT]----3'WT sub3----[ACTA]----3'WT sub4----[GACA]----3'WT sub5----[TTCA]----3'WT+PolIII sub6----[CACC]
   TAGA                   TACT                   TATT                   ACTA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 0.9848 (7 overhangs)

---

### Tile 15 of 47 -- Codons 867-931 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTGT     | 0.6476   |
| oh2 (3' boundary) | AAAT     | 0.7737   |

**Variants:** 1281 mutations, 1281 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2  | 1246 nt | TATG  | CTGT  |
| 3   | Oligo pool      | Tile 15 (1281 oligos) | 251 nt  | CTGT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[CTGT]----oligo+BC----[AGAA]
   ATGA                   TATG                   CTGT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1     | 891 nt  | AAAT  | TACT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 621 nt  | TACT  | TATT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1680 nt | TATT  | ACTA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1764 nt | ACTA  | GACA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AAAT]----3'WT sub1----[TACT]----3'WT sub2----[TATT]----3'WT sub3----[ACTA]----3'WT sub4----[GACA]----3'WT sub5----[TTCA]----3'WT+PolIII sub6----[CACC]
   AAAT                   TACT                   TATT                   ACTA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 0.9848 (7 overhangs)

---

### Tile 16 of 47 -- Codons 928-1005 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCA     | 0.8519   |
| oh2 (3' boundary) | AGAT     | 0.6825   |

**Variants:** 1554 mutations, 1554 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile16_sub3  | 382 nt  | TGAT  | TCCA  |
| 4   | Oligo pool      | Tile 16 (1554 oligos) | 290 nt  | TCCA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TCCA]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   TCCA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1     | 669 nt  | AGAT  | TACT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 621 nt  | TACT  | TATT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1680 nt | TATT  | ACTA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1764 nt | ACTA  | GACA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AGAT]----3'WT sub1----[TACT]----3'WT sub2----[TATT]----3'WT sub3----[ACTA]----3'WT sub4----[GACA]----3'WT sub5----[TTCA]----3'WT+PolIII sub6----[CACC]
   AGAT                   TACT                   TATT                   ACTA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 0.9848 (7 overhangs)

---

### Tile 17 of 47 -- Codons 1002-1079 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | GAGG     | 0.5599   |

**Variants:** 1554 mutations, 1554 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile17_sub3  | 604 nt  | TGAT  | AAGA  |
| 4   | Oligo pool      | Tile 17 (1554 oligos) | 290 nt  | AAGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[AAGA]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   AAGA                  AGAA 
```

**Set fidelity:** 0.9574 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1     | 447 nt  | GAGG  | TACT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 621 nt  | TACT  | TATT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1680 nt | TATT  | ACTA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1764 nt | ACTA  | GACA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAGG]----3'WT sub1----[TACT]----3'WT sub2----[TATT]----3'WT sub3----[ACTA]----3'WT sub4----[GACA]----3'WT sub5----[TTCA]----3'WT+PolIII sub6----[CACC]
   GAGG                   TACT                   TATT                   ACTA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 0.9848 (7 overhangs)

---

### Tile 18 of 47 -- Codons 1076-1148 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTTG     | 0.7594   |
| oh2 (3' boundary) | CAAG     | 0.6640   |

**Variants:** 1449 mutations, 1449 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile18_sub3  | 826 nt  | TGAT  | CTTG  |
| 4   | Oligo pool      | Tile 18 (1449 oligos) | 275 nt  | CTTG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[CTTG]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   CTTG                  AGAA 
```

**Set fidelity:** 0.9981 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1     | 843 nt  | CAAG  | TATT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1680 nt | TATT  | ACTA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1764 nt | ACTA  | GACA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CAAG]----3'WT sub1----[TATT]----3'WT sub2----[ACTA]----3'WT sub3----[GACA]----3'WT sub4----[TTCA]----3'WT+PolIII sub5----[CACC]
   CAAG                   TATT                   ACTA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 19 of 47 -- Codons 1145-1222 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGGA     | 0.7515   |
| oh2 (3' boundary) | TACT     | 0.7445   |

**Variants:** 1554 mutations, 1554 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3  | 1033 nt | TGAT  | AGGA  |
| 4   | Oligo pool      | Tile 19 (1554 oligos) | 290 nt  | AGGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[AGGA]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   AGGA                  AGAA 
```

**Set fidelity:** 0.9656 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 621 nt  | TACT  | TATT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1680 nt | TATT  | ACTA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1764 nt | ACTA  | GACA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TACT]----3'WT sub1----[TATT]----3'WT sub2----[ACTA]----3'WT sub3----[GACA]----3'WT sub4----[TTCA]----3'WT+PolIII sub5----[CACC]
   TACT                   TATT                   ACTA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 0.9848 (6 overhangs)

---

### Tile 20 of 47 -- Codons 1219-1296 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAT     | 0.7737   |
| oh2 (3' boundary) | CATA     | 0.7540   |

**Variants:** 1554 mutations, 1554 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile20_sub3  | 1255 nt | TGAT  | AAAT  |
| 4   | Oligo pool      | Tile 20 (1554 oligos) | 290 nt  | AAAT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[AAAT]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   AAAT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1     | 399 nt  | CATA  | TATT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1680 nt | TATT  | ACTA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1764 nt | ACTA  | GACA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CATA]----3'WT sub1----[TATT]----3'WT sub2----[ACTA]----3'WT sub3----[GACA]----3'WT sub4----[TTCA]----3'WT+PolIII sub5----[CACC]
   CATA                   TATT                   ACTA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 21 of 47 -- Codons 1293-1349 (171 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAG     | 0.7511   |
| oh2 (3' boundary) | CGAA     | 0.7461   |

**Variants:** 1113 mutations, 1113 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3  | 1477 nt | TGAT  | AAAG  |
| 4   | Oligo pool      | Tile 21 (1113 oligos) | 227 nt  | AAAG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[AAAG]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   AAAG                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1     | 240 nt  | CGAA  | TATT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1680 nt | TATT  | ACTA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1764 nt | ACTA  | GACA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CGAA]----3'WT sub1----[TATT]----3'WT sub2----[ACTA]----3'WT sub3----[GACA]----3'WT sub4----[TTCA]----3'WT+PolIII sub5----[CACC]
   CGAA                   TATT                   ACTA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 22 of 47 -- Codons 1346-1423 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | TATT     | 0.8134   |

**Variants:** 1554 mutations, 1554 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile22_sub4  | 391 nt  | TACT  | GAAA  |
| 5   | Oligo pool      | Tile 22 (1554 oligos) | 290 nt  | GAAA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[GAAA]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   TACT                   GAAA                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1680 nt | TATT  | ACTA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1764 nt | ACTA  | GACA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TATT]----3'WT sub1----[ACTA]----3'WT sub2----[GACA]----3'WT sub3----[TTCA]----3'WT+PolIII sub4----[CACC]
   TATT                   ACTA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 23 of 47 -- Codons 1420-1481 (186 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCT     | 0.7573   |
| oh2 (3' boundary) | TGAG     | 0.6546   |

**Variants:** 1218 mutations, 1218 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile23_sub4  | 613 nt  | TACT  | TCCT  |
| 5   | Oligo pool      | Tile 23 (1218 oligos) | 242 nt  | TCCT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TCCT]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   TACT                   TCCT                  AGAA 
```

**Set fidelity:** 0.9790 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1     | 1506 nt | TGAG  | ACTA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1764 nt | ACTA  | GACA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGAG]----3'WT sub1----[ACTA]----3'WT sub2----[GACA]----3'WT sub3----[TTCA]----3'WT+PolIII sub4----[CACC]
   TGAG                   ACTA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 0.9981 (5 overhangs)

---

### Tile 24 of 47 -- Codons 1478-1555 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | ATTT     | 0.7664   |

**Variants:** 1554 mutations, 1554 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile24_sub4  | 787 nt  | TACT  | GAAA  |
| 5   | Oligo pool      | Tile 24 (1554 oligos) | 290 nt  | GAAA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[GAAA]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   TACT                   GAAA                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile24_sub1     | 1284 nt | ATTT  | ACTA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1764 nt | ACTA  | GACA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [ATTT]----3'WT sub1----[ACTA]----3'WT sub2----[GACA]----3'WT sub3----[TTCA]----3'WT+PolIII sub4----[CACC]
   ATTT                   ACTA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 25 of 47 -- Codons 1552-1622 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCTT     | 0.6891   |
| oh2 (3' boundary) | TGGA     | 0.7377   |

**Variants:** 1407 mutations, 1407 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4  | 621 nt  | TACT  | TATT  |
| 5   | 5'WT gene block | bsai_5wt_tile25_sub5  | 406 nt  | TATT  | CCTT  |
| 6   | Oligo pool      | Tile 25 (1407 oligos) | 269 nt  | CCTT  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TATT]----5'WT sub5----[CCTT]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   TACT                   TATT                   CCTT                  AGAA 
```

**Set fidelity:** 0.9774 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile25_sub1     | 1083 nt | TGGA  | ACTA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1764 nt | ACTA  | GACA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGGA]----3'WT sub1----[ACTA]----3'WT sub2----[GACA]----3'WT sub3----[TTCA]----3'WT+PolIII sub4----[CACC]
   TGGA                   ACTA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 26 of 47 -- Codons 1619-1690 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGGA     | 0.7515   |
| oh2 (3' boundary) | GCAT     | 0.5827   |

**Variants:** 1428 mutations, 1428 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4  | 621 nt  | TACT  | TATT  |
| 5   | 5'WT gene block | bsai_5wt_tile26_sub5  | 607 nt  | TATT  | AGGA  |
| 6   | Oligo pool      | Tile 26 (1428 oligos) | 272 nt  | AGGA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TATT]----5'WT sub5----[AGGA]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   TACT                   TATT                   AGGA                  AGAA 
```

**Set fidelity:** 0.9438 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile26_sub1     | 879 nt  | GCAT  | ACTA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1764 nt | ACTA  | GACA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GCAT]----3'WT sub1----[ACTA]----3'WT sub2----[GACA]----3'WT sub3----[TTCA]----3'WT+PolIII sub4----[CACC]
   GCAT                   ACTA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 27 of 47 -- Codons 1687-1764 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAGC     | 0.5446   |
| oh2 (3' boundary) | GCCG     | 0.4517   |

**Variants:** 1554 mutations, 1554 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4  | 621 nt  | TACT  | TATT  |
| 5   | 5'WT gene block | bsai_5wt_tile27_sub5  | 811 nt  | TATT  | GAGC  |
| 6   | Oligo pool      | Tile 27 (1554 oligos) | 290 nt  | GAGC  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TATT]----5'WT sub5----[GAGC]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   TACT                   TATT                   GAGC                  AGAA 
```

**Set fidelity:** 0.9774 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile27_sub1     | 657 nt  | GCCG  | ACTA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1764 nt | ACTA  | GACA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GCCG]----3'WT sub1----[ACTA]----3'WT sub2----[GACA]----3'WT sub3----[TTCA]----3'WT+PolIII sub4----[CACC]
   GCCG                   ACTA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 28 of 47 -- Codons 1761-1831 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGA     | 0.8175   |
| oh2 (3' boundary) | CGAG     | 0.5351   |

**Variants:** 1407 mutations, 1407 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4  | 621 nt  | TACT  | TATT  |
| 5   | 5'WT gene block | bsai_5wt_tile28_sub5  | 1033 nt | TATT  | CAGA  |
| 6   | Oligo pool      | Tile 28 (1407 oligos) | 269 nt  | CAGA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TATT]----5'WT sub5----[CAGA]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   TACT                   TATT                   CAGA                  AGAA 
```

**Set fidelity:** 0.9774 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile28_sub1     | 456 nt  | CGAG  | ACTA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1764 nt | ACTA  | GACA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CGAG]----3'WT sub1----[ACTA]----3'WT sub2----[GACA]----3'WT sub3----[TTCA]----3'WT+PolIII sub4----[CACC]
   CGAG                   ACTA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 29 of 47 -- Codons 1828-1905 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | GAGT     | 0.6209   |

**Variants:** 1554 mutations, 1554 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4  | 621 nt  | TACT  | TATT  |
| 5   | 5'WT gene block | bsai_5wt_tile29_sub5  | 1234 nt | TATT  | GAAA  |
| 6   | Oligo pool      | Tile 29 (1554 oligos) | 290 nt  | GAAA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TATT]----5'WT sub5----[GAAA]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   TACT                   TATT                   GAAA                  AGAA 
```

**Set fidelity:** 0.9774 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile29_sub1     | 234 nt  | GAGT  | ACTA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1764 nt | ACTA  | GACA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAGT]----3'WT sub1----[ACTA]----3'WT sub2----[GACA]----3'WT sub3----[TTCA]----3'WT+PolIII sub4----[CACC]
   GAGT                   ACTA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 30 of 47 -- Codons 1902-1977 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | ACTA     | 0.7946   |

**Variants:** 1512 mutations, 1512 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4  | 621 nt  | TACT  | TATT  |
| 5   | 5'WT gene block | bsai_5wt_tile30_sub5  | 1456 nt | TATT  | GAAA  |
| 6   | Oligo pool      | Tile 30 (1512 oligos) | 284 nt  | GAAA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TATT]----5'WT sub5----[GAAA]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   TACT                   TATT                   GAAA                  AGAA 
```

**Set fidelity:** 0.9774 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1764 nt | ACTA  | GACA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [ACTA]----3'WT sub1----[GACA]----3'WT sub2----[TTCA]----3'WT+PolIII sub3----[CACC]
   ACTA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 31 of 47 -- Codons 1974-2045 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTGC     | 0.7336   |
| oh2 (3' boundary) | AGGA     | 0.7515   |

**Variants:** 1428 mutations, 1428 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4  | 621 nt  | TACT  | TATT  |
| 5   | 5'WT gene block | bsai_5wt_tile31_sub5  | 1672 nt | TATT  | TTGC  |
| 6   | Oligo pool      | Tile 31 (1428 oligos) | 272 nt  | TTGC  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TATT]----5'WT sub5----[TTGC]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   TACT                   TATT                   TTGC                  AGAA 
```

**Set fidelity:** 0.9774 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile31_sub1     | 1560 nt | AGGA  | GACA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AGGA]----3'WT sub1----[GACA]----3'WT sub2----[TTCA]----3'WT+PolIII sub3----[CACC]
   AGGA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 32 of 47 -- Codons 2042-2119 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | CAAA     | 0.8948   |

**Variants:** 1554 mutations, 1554 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4  | 621 nt  | TACT  | TATT  |
| 5   | 5'WT gene block | bsai_5wt_tile32_sub5  | 1680 nt | TATT  | ACTA  |
| 6   | 5'WT gene block | bsai_5wt_tile32_sub6  | 214 nt  | ACTA  | GAAA  |
| 7   | Oligo pool      | Tile 32 (1554 oligos) | 290 nt  | GAAA  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TATT]----5'WT sub5----[ACTA]----5'WT sub6----[GAAA]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   TACT                   TATT                   ACTA                   GAAA                  AGAA 
```

**Set fidelity:** 0.9774 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile32_sub1     | 1338 nt | CAAA  | GACA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CAAA]----3'WT sub1----[GACA]----3'WT sub2----[TTCA]----3'WT+PolIII sub3----[CACC]
   CAAA                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 33 of 47 -- Codons 2116-2191 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGT     | 0.7629   |
| oh2 (3' boundary) | CTTT     | 0.6635   |

**Variants:** 1512 mutations, 1512 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4  | 621 nt  | TACT  | TATT  |
| 5   | 5'WT gene block | bsai_5wt_tile32_sub5  | 1680 nt | TATT  | ACTA  |
| 6   | 5'WT gene block | bsai_5wt_tile33_sub6  | 436 nt  | ACTA  | AAGT  |
| 7   | Oligo pool      | Tile 33 (1512 oligos) | 284 nt  | AAGT  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TATT]----5'WT sub5----[ACTA]----5'WT sub6----[AAGT]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   TACT                   TATT                   ACTA                   AAGT                  AGAA 
```

**Set fidelity:** 0.9774 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile33_sub1     | 1122 nt | CTTT  | GACA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTTT]----3'WT sub1----[GACA]----3'WT sub2----[TTCA]----3'WT+PolIII sub3----[CACC]
   CTTT                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 34 of 47 -- Codons 2188-2218 (93 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCT     | 0.7151   |
| oh2 (3' boundary) | TATC     | 0.8041   |

**Variants:** 567 mutations, 567 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4  | 621 nt  | TACT  | TATT  |
| 5   | 5'WT gene block | bsai_5wt_tile32_sub5  | 1680 nt | TATT  | ACTA  |
| 6   | 5'WT gene block | bsai_5wt_tile34_sub6  | 652 nt  | ACTA  | ATCT  |
| 7   | Oligo pool      | Tile 34 (567 oligos)  | 149 nt  | ATCT  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TATT]----5'WT sub5----[ACTA]----5'WT sub6----[ATCT]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   TACT                   TATT                   ACTA                   ATCT                  AGAA 
```

**Set fidelity:** 0.9729 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile34_sub1     | 1041 nt | TATC  | GACA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TATC]----3'WT sub1----[GACA]----3'WT sub2----[TTCA]----3'WT+PolIII sub3----[CACC]
   TATC                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 0.9961 (4 overhangs)

---

### Tile 35 of 47 -- Codons 2215-2284 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | AATC     | 0.7116   |

**Variants:** 1386 mutations, 1386 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4  | 621 nt  | TACT  | TATT  |
| 5   | 5'WT gene block | bsai_5wt_tile32_sub5  | 1680 nt | TATT  | ACTA  |
| 6   | 5'WT gene block | bsai_5wt_tile35_sub6  | 733 nt  | ACTA  | AAGA  |
| 7   | Oligo pool      | Tile 35 (1386 oligos) | 266 nt  | AAGA  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TATT]----5'WT sub5----[ACTA]----5'WT sub6----[AAGA]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   TACT                   TATT                   ACTA                   AAGA                  AGAA 
```

**Set fidelity:** 0.9358 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile35_sub1     | 843 nt  | AATC  | GACA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AATC]----3'WT sub1----[GACA]----3'WT sub2----[TTCA]----3'WT+PolIII sub3----[CACC]
   AATC                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 36 of 47 -- Codons 2281-2358 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACAT     | 0.6621   |
| oh2 (3' boundary) | CTCG     | 0.7252   |

**Variants:** 1554 mutations, 1554 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4  | 621 nt  | TACT  | TATT  |
| 5   | 5'WT gene block | bsai_5wt_tile32_sub5  | 1680 nt | TATT  | ACTA  |
| 6   | 5'WT gene block | bsai_5wt_tile36_sub6  | 931 nt  | ACTA  | ACAT  |
| 7   | Oligo pool      | Tile 36 (1554 oligos) | 290 nt  | ACAT  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TATT]----5'WT sub5----[ACTA]----5'WT sub6----[ACAT]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   TACT                   TATT                   ACTA                   ACAT                  AGAA 
```

**Set fidelity:** 0.9727 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile36_sub1     | 621 nt  | CTCG  | GACA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTCG]----3'WT sub1----[GACA]----3'WT sub2----[TTCA]----3'WT+PolIII sub3----[CACC]
   CTCG                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 37 of 47 -- Codons 2355-2419 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTG     | 0.6684   |
| oh2 (3' boundary) | CAGG     | 0.5358   |

**Variants:** 1281 mutations, 1281 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4  | 621 nt  | TACT  | TATT  |
| 5   | 5'WT gene block | bsai_5wt_tile32_sub5  | 1680 nt | TATT  | ACTA  |
| 6   | 5'WT gene block | bsai_5wt_tile37_sub6  | 1153 nt | ACTA  | TCTG  |
| 7   | Oligo pool      | Tile 37 (1281 oligos) | 251 nt  | TCTG  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TATT]----5'WT sub5----[ACTA]----5'WT sub6----[TCTG]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   TACT                   TATT                   ACTA                   TCTG                  AGAA 
```

**Set fidelity:** 0.9684 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile37_sub1     | 438 nt  | CAGG  | GACA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CAGG]----3'WT sub1----[GACA]----3'WT sub2----[TTCA]----3'WT+PolIII sub3----[CACC]
   CAGG                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 38 of 47 -- Codons 2416-2487 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAGA     | 0.7444   |
| oh2 (3' boundary) | GAGC     | 0.5446   |

**Variants:** 1428 mutations, 1428 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4  | 621 nt  | TACT  | TATT  |
| 5   | 5'WT gene block | bsai_5wt_tile32_sub5  | 1680 nt | TATT  | ACTA  |
| 6   | 5'WT gene block | bsai_5wt_tile38_sub6  | 1336 nt | ACTA  | GAGA  |
| 7   | Oligo pool      | Tile 38 (1428 oligos) | 272 nt  | GAGA  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TATT]----5'WT sub5----[ACTA]----5'WT sub6----[GAGA]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   TACT                   TATT                   ACTA                   GAGA                  AGAA 
```

**Set fidelity:** 0.9774 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile38_sub1     | 234 nt  | GAGC  | GACA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub7      | 1765 nt | GACA  | TTCA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub8 | 982 nt  | TTCA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAGC]----3'WT sub1----[GACA]----3'WT sub2----[TTCA]----3'WT+PolIII sub3----[CACC]
   GAGC                   GACA                   TTCA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 39 of 47 -- Codons 2484-2559 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCT     | 0.7573   |
| oh2 (3' boundary) | GACA     | 0.6127   |

**Variants:** 1512 mutations, 1512 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4  | 621 nt  | TACT  | TATT  |
| 5   | 5'WT gene block | bsai_5wt_tile32_sub5  | 1680 nt | TATT  | ACTA  |
| 6   | 5'WT gene block | bsai_5wt_tile39_sub6  | 1540 nt | ACTA  | TCCT  |
| 7   | Oligo pool      | Tile 39 (1512 oligos) | 284 nt  | TCCT  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TATT]----5'WT sub5----[ACTA]----5'WT sub6----[TCCT]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   TACT                   TATT                   ACTA                   TCCT                  AGAA 
```

**Set fidelity:** 0.9569 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile39_sub1    | 951 nt  | GACA  | AGAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile39_sub2    | 1796 nt | AGAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GACA]----3'WT sub1----[AGAA]----3'WT+PolIII sub2----[CACC]
   GACA                   AGAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 40 of 47 -- Codons 2556-2631 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGT     | 0.6822   |
| oh2 (3' boundary) | ATCT     | 0.7151   |

**Variants:** 1512 mutations, 1512 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4  | 621 nt  | TACT  | TATT  |
| 5   | 5'WT gene block | bsai_5wt_tile32_sub5  | 1680 nt | TATT  | ACTA  |
| 6   | 5'WT gene block | bsai_5wt_tile40_sub6  | 1756 nt | ACTA  | ATGT  |
| 7   | Oligo pool      | Tile 40 (1512 oligos) | 284 nt  | ATGT  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TATT]----5'WT sub5----[ACTA]----5'WT sub6----[ATGT]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   TACT                   TATT                   ACTA                   ATGT                  AGAA 
```

**Set fidelity:** 0.9084 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile40_sub1    | 735 nt  | ATCT  | AGAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile39_sub2    | 1796 nt | AGAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATCT]----3'WT sub1----[AGAA]----3'WT+PolIII sub2----[CACC]
   ATCT                   AGAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 41 of 47 -- Codons 2628-2703 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGT     | 0.7629   |
| oh2 (3' boundary) | TGTT     | 0.6450   |

**Variants:** 1512 mutations, 1512 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4  | 621 nt  | TACT  | TATT  |
| 5   | 5'WT gene block | bsai_5wt_tile32_sub5  | 1680 nt | TATT  | ACTA  |
| 6   | 5'WT gene block | bsai_5wt_tile41_sub6  | 1764 nt | ACTA  | GACA  |
| 7   | 5'WT gene block | bsai_5wt_tile41_sub7  | 226 nt  | GACA  | AAGT  |
| 8   | Oligo pool      | Tile 41 (1512 oligos) | 284 nt  | AAGT  | AGAA  |
| 9   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 10  | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TATT]----5'WT sub5----[ACTA]----5'WT sub6----[GACA]----5'WT sub7----[AAGT]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   TACT                   TATT                   ACTA                   GACA                   AAGT                  AGAA 
```

**Set fidelity:** 0.9774 (9 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile41_sub1    | 690 nt  | TGTT  | TTTA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile41_sub2    | 1625 nt | TTTA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGTT]----3'WT sub1----[TTTA]----3'WT+PolIII sub2----[CACC]
   TGTT                   TTTA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 42 of 47 -- Codons 2700-2770 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | ATCG     | 0.5700   |

**Variants:** 1407 mutations, 1407 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4  | 621 nt  | TACT  | TATT  |
| 5   | 5'WT gene block | bsai_5wt_tile32_sub5  | 1680 nt | TATT  | ACTA  |
| 6   | 5'WT gene block | bsai_5wt_tile41_sub6  | 1764 nt | ACTA  | GACA  |
| 7   | 5'WT gene block | bsai_5wt_tile42_sub7  | 442 nt  | GACA  | GAAA  |
| 8   | Oligo pool      | Tile 42 (1407 oligos) | 269 nt  | GAAA  | AGAA  |
| 9   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 10  | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TATT]----5'WT sub5----[ACTA]----5'WT sub6----[GACA]----5'WT sub7----[GAAA]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   TACT                   TATT                   ACTA                   GACA                   GAAA                  AGAA 
```

**Set fidelity:** 0.9741 (9 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile42_sub1    | 489 nt  | ATCG  | TTTA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile41_sub2    | 1625 nt | TTTA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATCG]----3'WT sub1----[TTTA]----3'WT+PolIII sub2----[CACC]
   ATCG                   TTTA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 43 of 47 -- Codons 2767-2814 (144 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAG     | 0.7814   |
| oh2 (3' boundary) | TGAT     | 0.6933   |

**Variants:** 924 mutations, 924 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4  | 621 nt  | TACT  | TATT  |
| 5   | 5'WT gene block | bsai_5wt_tile32_sub5  | 1680 nt | TATT  | ACTA  |
| 6   | 5'WT gene block | bsai_5wt_tile41_sub6  | 1764 nt | ACTA  | GACA  |
| 7   | 5'WT gene block | bsai_5wt_tile43_sub7  | 643 nt  | GACA  | TCAG  |
| 8   | Oligo pool      | Tile 43 (924 oligos)  | 200 nt  | TCAG  | AGAA  |
| 9   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 10  | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TATT]----5'WT sub5----[ACTA]----5'WT sub6----[GACA]----5'WT sub7----[TCAG]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   TACT                   TATT                   ACTA                   GACA                   TCAG                  AGAA 
```

**Set fidelity:** 0.9774 (9 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile43_sub1    | 357 nt  | TGAT  | TTTA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile41_sub2    | 1625 nt | TTTA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAT]----3'WT sub1----[TTTA]----3'WT+PolIII sub2----[CACC]
   TGAT                   TTTA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 44 of 47 -- Codons 2811-2888 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | CACT     | 0.5337   |

**Variants:** 1554 mutations, 1554 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4  | 621 nt  | TACT  | TATT  |
| 5   | 5'WT gene block | bsai_5wt_tile32_sub5  | 1680 nt | TATT  | ACTA  |
| 6   | 5'WT gene block | bsai_5wt_tile41_sub6  | 1764 nt | ACTA  | GACA  |
| 7   | 5'WT gene block | bsai_5wt_tile44_sub7  | 775 nt  | GACA  | AAGA  |
| 8   | Oligo pool      | Tile 44 (1554 oligos) | 290 nt  | AAGA  | AGAA  |
| 9   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 10  | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TATT]----5'WT sub5----[ACTA]----5'WT sub6----[GACA]----5'WT sub7----[AAGA]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   TACT                   TATT                   ACTA                   GACA                   AAGA                  AGAA 
```

**Set fidelity:** 0.9358 (9 overhangs)

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

**Variants:** 1407 mutations, 1407 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4  | 621 nt  | TACT  | TATT  |
| 5   | 5'WT gene block | bsai_5wt_tile32_sub5  | 1680 nt | TATT  | ACTA  |
| 6   | 5'WT gene block | bsai_5wt_tile41_sub6  | 1764 nt | ACTA  | GACA  |
| 7   | 5'WT gene block | bsai_5wt_tile45_sub7  | 997 nt  | GACA  | GGAA  |
| 8   | Oligo pool      | Tile 45 (1407 oligos) | 269 nt  | GGAA  | AGAA  |
| 9   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 10  | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TATT]----5'WT sub5----[ACTA]----5'WT sub6----[GACA]----5'WT sub7----[GGAA]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   TACT                   TATT                   ACTA                   GACA                   GGAA                  AGAA 
```

**Set fidelity:** 0.9258 (9 overhangs)

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

**Variants:** 1554 mutations, 1554 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4  | 621 nt  | TACT  | TATT  |
| 5   | 5'WT gene block | bsai_5wt_tile32_sub5  | 1680 nt | TATT  | ACTA  |
| 6   | 5'WT gene block | bsai_5wt_tile41_sub6  | 1764 nt | ACTA  | GACA  |
| 7   | 5'WT gene block | bsai_5wt_tile46_sub7  | 1198 nt | GACA  | TTAC  |
| 8   | Oligo pool      | Tile 46 (1554 oligos) | 290 nt  | TTAC  | AGAA  |
| 9   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 10  | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TATT]----5'WT sub5----[ACTA]----5'WT sub6----[GACA]----5'WT sub7----[TTAC]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   TACT                   TATT                   ACTA                   GACA                   TTAC                  AGAA 
```

**Set fidelity:** 0.9774 (9 overhangs)

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

**Variants:** 1449 mutations, 1449 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1388 nt | ATGA  | TATG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1065 nt | TATG  | TGAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1263 nt | TGAT  | TACT  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4  | 621 nt  | TACT  | TATT  |
| 5   | 5'WT gene block | bsai_5wt_tile32_sub5  | 1680 nt | TATT  | ACTA  |
| 6   | 5'WT gene block | bsai_5wt_tile41_sub6  | 1764 nt | ACTA  | GACA  |
| 7   | 5'WT gene block | bsai_5wt_tile47_sub7  | 1420 nt | GACA  | TTCG  |
| 8   | Oligo pool      | Tile 47 (1449 oligos) | 275 nt  | TTCG  | AGAA  |
| 9   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 10  | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[TATG]----5'WT sub2----[TGAT]----5'WT sub3----[TACT]----5'WT sub4----[TATT]----5'WT sub5----[ACTA]----5'WT sub6----[GACA]----5'WT sub7----[TTCG]----oligo+BC----[AGAA]
   ATGA                   TATG                   TGAT                   TACT                   TATT                   ACTA                   GACA                   TTCG                  AGAA 
```

**Set fidelity:** 0.9759 (9 overhangs)

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
| bsai_5wt_tile18_sub3      | 826         | BsaI        | 5wt_tile18_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile19_sub3      | 1033        | BsaI        | 5wt_tile19_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile2            | 177         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile20_sub3      | 1255        | BsaI        | 5wt_tile20_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile21_sub3      | 1477        | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile22_sub3      | 1263        | BsaI        | 5wt_tile22_sub3;5wt_tile23_sub3;5wt_tile24_sub3;5wt_tile25_sub3;5wt_tile26_sub3;5wt_tile27_sub3;5wt_tile28_sub3;5wt_tile29_sub3;5wt_tile30_sub3;5wt_tile31_sub3;5wt_tile32_sub3;5wt_tile33_sub3;5wt_tile34_sub3;5wt_tile35_sub3;5wt_tile36_sub3;5wt_tile37_sub3;5wt_tile38_sub3;5wt_tile39_sub3;5wt_tile40_sub3;5wt_tile41_sub3;5wt_tile42_sub3;5wt_tile43_sub3;5wt_tile44_sub3;5wt_tile45_sub3;5wt_tile46_sub3;5wt_tile47_sub3                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile22_sub4      | 391         | BsaI        | 5wt_tile22_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile23_sub4      | 613         | BsaI        | 5wt_tile23_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile24_sub4      | 787         | BsaI        | 5wt_tile24_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile25_sub4      | 621         | BsaI        | 5wt_tile25_sub4;5wt_tile26_sub4;5wt_tile27_sub4;5wt_tile28_sub4;5wt_tile29_sub4;5wt_tile30_sub4;5wt_tile31_sub4;5wt_tile32_sub4;5wt_tile33_sub4;5wt_tile34_sub4;5wt_tile35_sub4;5wt_tile36_sub4;5wt_tile37_sub4;5wt_tile38_sub4;5wt_tile39_sub4;5wt_tile40_sub4;5wt_tile41_sub4;5wt_tile42_sub4;5wt_tile43_sub4;5wt_tile44_sub4;5wt_tile45_sub4;5wt_tile46_sub4;5wt_tile47_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile25_sub5      | 406         | BsaI        | 5wt_tile25_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile26_sub5      | 607         | BsaI        | 5wt_tile26_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile27_sub5      | 811         | BsaI        | 5wt_tile27_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile28_sub5      | 1033        | BsaI        | 5wt_tile28_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile29_sub5      | 1234        | BsaI        | 5wt_tile29_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile3            | 339         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile30_sub5      | 1456        | BsaI        | 5wt_tile30_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile31_sub5      | 1672        | BsaI        | 5wt_tile31_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile32_sub5      | 1680        | BsaI        | 5wt_tile32_sub5;5wt_tile33_sub5;5wt_tile34_sub5;5wt_tile35_sub5;5wt_tile36_sub5;5wt_tile37_sub5;5wt_tile38_sub5;5wt_tile39_sub5;5wt_tile40_sub5;5wt_tile41_sub5;5wt_tile42_sub5;5wt_tile43_sub5;5wt_tile44_sub5;5wt_tile45_sub5;5wt_tile46_sub5;5wt_tile47_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile32_sub6      | 214         | BsaI        | 5wt_tile32_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile33_sub6      | 436         | BsaI        | 5wt_tile33_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile34_sub6      | 652         | BsaI        | 5wt_tile34_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile35_sub6      | 733         | BsaI        | 5wt_tile35_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile36_sub6      | 931         | BsaI        | 5wt_tile36_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile37_sub6      | 1153        | BsaI        | 5wt_tile37_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile38_sub6      | 1336        | BsaI        | 5wt_tile38_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile39_sub6      | 1540        | BsaI        | 5wt_tile39_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile4            | 543         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile40_sub6      | 1756        | BsaI        | 5wt_tile40_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile41_sub6      | 1764        | BsaI        | 5wt_tile41_sub6;5wt_tile42_sub6;5wt_tile43_sub6;5wt_tile44_sub6;5wt_tile45_sub6;5wt_tile46_sub6;5wt_tile47_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile41_sub7      | 226         | BsaI        | 5wt_tile41_sub7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile42_sub7      | 442         | BsaI        | 5wt_tile42_sub7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile43_sub7      | 643         | BsaI        | 5wt_tile43_sub7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile44_sub7      | 775         | BsaI        | 5wt_tile44_sub7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
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
| bsmbi_3wt_tile1_sub4      | 621         | BsmBI       | 3wt_tile1_sub4;3wt_tile2_sub4;3wt_tile3_sub4;3wt_tile4_sub4;3wt_tile5_sub4;3wt_tile6_sub4;3wt_tile7_sub3;3wt_tile8_sub3;3wt_tile9_sub3;3wt_tile10_sub3;3wt_tile11_sub3;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2;3wt_tile16_sub2;3wt_tile17_sub2;3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile1_sub5      | 1680        | BsmBI       | 3wt_tile1_sub5;3wt_tile2_sub5;3wt_tile3_sub5;3wt_tile4_sub5;3wt_tile5_sub5;3wt_tile6_sub5;3wt_tile7_sub4;3wt_tile8_sub4;3wt_tile9_sub4;3wt_tile10_sub4;3wt_tile11_sub4;3wt_tile12_sub3;3wt_tile13_sub3;3wt_tile14_sub3;3wt_tile15_sub3;3wt_tile16_sub3;3wt_tile17_sub3;3wt_tile18_sub2;3wt_tile19_sub2;3wt_tile20_sub2;3wt_tile21_sub2;3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile1_sub6      | 1764        | BsmBI       | 3wt_tile1_sub6;3wt_tile2_sub6;3wt_tile3_sub6;3wt_tile4_sub6;3wt_tile5_sub6;3wt_tile6_sub6;3wt_tile7_sub5;3wt_tile8_sub5;3wt_tile9_sub5;3wt_tile10_sub5;3wt_tile11_sub5;3wt_tile12_sub4;3wt_tile13_sub4;3wt_tile14_sub4;3wt_tile15_sub4;3wt_tile16_sub4;3wt_tile17_sub4;3wt_tile18_sub3;3wt_tile19_sub3;3wt_tile20_sub3;3wt_tile21_sub3;3wt_tile22_sub2;3wt_tile23_sub2;3wt_tile24_sub2;3wt_tile25_sub2;3wt_tile26_sub2;3wt_tile27_sub2;3wt_tile28_sub2;3wt_tile29_sub2;3wt_tile30_sub1                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile1_sub7      | 1765        | BsmBI       | 3wt_tile1_sub7;3wt_tile2_sub7;3wt_tile3_sub7;3wt_tile4_sub7;3wt_tile5_sub7;3wt_tile6_sub7;3wt_tile7_sub6;3wt_tile8_sub6;3wt_tile9_sub6;3wt_tile10_sub6;3wt_tile11_sub6;3wt_tile12_sub5;3wt_tile13_sub5;3wt_tile14_sub5;3wt_tile15_sub5;3wt_tile16_sub5;3wt_tile17_sub5;3wt_tile18_sub4;3wt_tile19_sub4;3wt_tile20_sub4;3wt_tile21_sub4;3wt_tile22_sub3;3wt_tile23_sub3;3wt_tile24_sub3;3wt_tile25_sub3;3wt_tile26_sub3;3wt_tile27_sub3;3wt_tile28_sub3;3wt_tile29_sub3;3wt_tile30_sub2;3wt_tile31_sub2;3wt_tile32_sub2;3wt_tile33_sub2;3wt_tile34_sub2;3wt_tile35_sub2;3wt_tile36_sub2;3wt_tile37_sub2;3wt_tile38_sub2                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile10_sub1     | 636         | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile11_sub1     | 429         | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile12_sub1     | 1485        | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile14_sub1     | 1074        | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile15_sub1     | 891         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile16_sub1     | 669         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile17_sub1     | 447         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile18_sub1     | 843         | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile2_sub1      | 1059        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile20_sub1     | 399         | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile21_sub1     | 240         | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile23_sub1     | 1506        | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile24_sub1     | 1284        | BsmBI       | 3wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile25_sub1     | 1083        | BsmBI       | 3wt_tile25_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile26_sub1     | 879         | BsmBI       | 3wt_tile26_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile27_sub1     | 657         | BsmBI       | 3wt_tile27_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile28_sub1     | 456         | BsmBI       | 3wt_tile28_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile29_sub1     | 234         | BsmBI       | 3wt_tile29_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile3_sub1      | 855         | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile31_sub1     | 1560        | BsmBI       | 3wt_tile31_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile32_sub1     | 1338        | BsmBI       | 3wt_tile32_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile33_sub1     | 1122        | BsmBI       | 3wt_tile33_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile34_sub1     | 1041        | BsmBI       | 3wt_tile34_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile35_sub1     | 843         | BsmBI       | 3wt_tile35_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile36_sub1     | 621         | BsmBI       | 3wt_tile36_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile37_sub1     | 438         | BsmBI       | 3wt_tile37_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile38_sub1     | 234         | BsmBI       | 3wt_tile38_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile39_sub1     | 951         | BsmBI       | 3wt_tile39_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile39_sub2     | 1796        | BsmBI       | 3wt_polIII_tile39_sub2;3wt_polIII_tile40_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile4_sub1      | 738         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile40_sub1     | 735         | BsmBI       | 3wt_tile40_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile41_sub1     | 690         | BsmBI       | 3wt_tile41_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile41_sub2     | 1625        | BsmBI       | 3wt_polIII_tile41_sub2;3wt_polIII_tile42_sub2;3wt_polIII_tile43_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile42_sub1     | 489         | BsmBI       | 3wt_tile42_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile43_sub1     | 357         | BsmBI       | 3wt_tile43_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
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

| Parameter             | Value |
| --------------------- | ----- |
| max_oligo_length      | 300   |
| max_geneblock_length  | 1800  |
| barcode_length        | 20    |
| min_hamming_distance  | 3     |
| barcode_prefix_length | 12    |
| barcodes_per_variant  | 1     |
| boundary_method       | dp    |
| multi_k_search        | TRUE  |
| auto_domesticate      | TRUE  |

