# DMS-GG Assembly Report: AKAP11

Generated: 2026-03-10 10:44:03
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
| Gene blocks to order | 66                                                                             |
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
| 3    | 102-170   | 13650  | 263 nt |
| 4    | 167-232   | 13020  | 254 nt |
| 5    | 229-298   | 13860  | 266 nt |
| 6    | 295-372   | 15540  | 290 nt |
| 7    | 369-443   | 14910  | 281 nt |
| 8    | 440-498   | 11550  | 233 nt |
| 9    | 495-572   | 15540  | 290 nt |
| 10   | 569-638   | 13860  | 266 nt |
| 11   | 635-698   | 12600  | 248 nt |
| 12   | 695-749   | 10710  | 221 nt |
| 13   | 746-813   | 13440  | 260 nt |
| 14   | 810-885   | 15120  | 284 nt |
| 15   | 882-947   | 13020  | 254 nt |
| 16   | 944-1016  | 14490  | 275 nt |
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
| oligo_lengths          | All oligos within synthesis length limit                      | PASS   | Range: 167-290 nt (limit: 300)                                                                                                                      |
| block_lengths          | All gene blocks within synthesis length limit                 | PASS   | Range: 117-1736 nt (limit: 1800)                                                                                                                    |
| barcode_junction_sites | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                             |
| barcode_uniqueness     | All barcodes are unique                                       | PASS   | 398580 unique / 398580 total                                                                                                                        |
| tile_coverage          | Tiles cover entire gene without gaps                          | PASS   | 5706 / 5706 nt covered                                                                                                                              |
| variant_count          | Expected number of variants generated                         | PASS   | 39858 unique variants (expected: 39858 across 1898/1900 mutable positions; 36062 missense + 1898 nonsense + 1898 wt_control; 2 position(s) skipped) |
| single_codon_change    | Each non-control variant differs by exactly one codon from WT | PASS   | 379600 / 379600 variants confirmed (WT controls excluded)                                                                                           |
| oligo_gc_content       | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 32.1-52.4% | 0 oligo(s) with extreme GC                                                                                                   |
| domestication_complete | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                             |
| overhang_fidelity      | Tile boundary overhangs have adequate fidelity                | FAIL   | 23 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                             |
| tile_manifests         | Per-tile assembly manifests complete                          | PASS   | 31 tile manifest(s) generated                                                                                                                       |
| helper_plasmid         | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                  |
| reaction_fidelity      | Per-reaction set-level overhang fidelity                      | PASS   | Min set fidelity: 0.8583 across 62 reactions | 4 reaction(s) below 0.90                                                                             |
| barcode_poliii_term    | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 398580 barcode(s) contain TTTT                                                                                                                  |
| block_min_length       | All gene blocks above synthesis minimum length                | FAIL   | 3 block(s) below 300 nt minimum. Range: 117-1736 nt                                                                                                 |
| sb_overhang_collisions | Superblock boundary overhangs are unique (no collisions)      | PASS   | 5 SB boundary OH(s), all unique                                                                                                                     |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 7         | 0.9756             |
| 2    | 3        | 1.0000            | 7         | 0.9610             |
| 3    | 3        | 1.0000            | 7         | 0.8583             |
| 4    | 3        | 1.0000            | 7         | 0.8583             |
| 5    | 3        | 1.0000            | 7         | 0.9973             |
| 6    | 3        | 1.0000            | 6         | 0.9973             |
| 7    | 3        | 1.0000            | 6         | 0.9973             |
| 8    | 3        | 1.0000            | 6         | 0.9973             |
| 9    | 3        | 1.0000            | 6         | 0.9973             |
| 10   | 4        | 0.9403            | 5         | 0.9973             |
| 11   | 4        | 0.9403            | 5         | 0.9973             |
| 12   | 4        | 0.9389            | 5         | 0.9274             |
| 13   | 4        | 0.9403            | 5         | 0.9973             |
| 14   | 5        | 0.8974            | 5         | 0.9973             |
| 15   | 5        | 0.9403            | 4         | 1.0000             |
| 16   | 5        | 0.8979            | 4         | 0.9973             |
| 17   | 5        | 0.9403            | 4         | 1.0000             |
| 18   | 5        | 0.9403            | 4         | 1.0000             |
| 19   | 6        | 0.9389            | 3         | 1.0000             |
| 20   | 6        | 0.9403            | 3         | 1.0000             |
| 21   | 6        | 0.9403            | 3         | 1.0000             |
| 22   | 7        | 0.9337            | 3         | 1.0000             |
| 23   | 7        | 0.9337            | 3         | 1.0000             |
| 24   | 7        | 0.9337            | 3         | 1.0000             |
| 25   | 7        | 0.9337            | 3         | 1.0000             |
| 26   | 7        | 0.9337            | 3         | 1.0000             |
| 27   | 7        | 0.9337            | 2         | 1.0000             |
| 28   | 7        | 0.9337            | 2         | 1.0000             |
| 29   | 7        | 0.9337            | 2         | 1.0000             |
| 30   | 8        | 0.9337            | 2         | 1.0000             |
| 31   | 8        | 0.9337            | 2         | 1.0000             |

**Min:** 0.8583 | **Max:** 1.0000 | **Mean:** 0.9691

**Warning:** 4 reaction(s) below 0.90 fidelity — consider alternative split points or overhang reassignment.
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
| 2   | Oligo pool      | Tile 1 (6930 oligos)               | 167 nt | ATGG  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1     | 1236 nt | ACTA  | AGAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 783 nt  | AGAT  | AATA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 972 nt  | AATA  | TCAT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 561 nt  | TCAT  | TCAG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1692 nt | TCAG  | TCTA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1553 nt | TCTA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACTA]----3'WT sub1----[AGAT]----3'WT sub2----[AATA]----3'WT sub3----[TCAT]----3'WT sub4----[TCAG]----3'WT sub5----[TCTA]----3'WT+PolIII sub6----[CACC]
   ACTA                   AGAT                   AATA                   TCAT                   TCAG                   TCTA                          CACC 
```

**Set fidelity:** 0.9756 (7 overhangs)

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
| 2   | Oligo pool      | Tile 2 (14280 oligos) | 272 nt | CAGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[CAGA]----oligo+BC----[AGAA]
   ATGG                    CAGA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1     | 1032 nt | AAAT  | AGAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 783 nt  | AGAT  | AATA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 972 nt  | AATA  | TCAT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 561 nt  | TCAT  | TCAG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1692 nt | TCAG  | TCTA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1553 nt | TCTA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAT]----3'WT sub1----[AGAT]----3'WT sub2----[AATA]----3'WT sub3----[TCAT]----3'WT sub4----[TCAG]----3'WT sub5----[TCTA]----3'WT+PolIII sub6----[CACC]
   AAAT                   AGAT                   AATA                   TCAT                   TCAG                   TCTA                          CACC 
```

**Set fidelity:** 0.9610 (7 overhangs)

---

### Tile 3 of 31 -- Codons 102-170 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | TGAT     | 0.6933   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 321 nt | ATGG  | AAGA  |
| 2   | Oligo pool      | Tile 3 (13650 oligos) | 263 nt | AAGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[AAGA]----oligo+BC----[AGAA]
   ATGG                    AAGA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1     | 837 nt  | TGAT  | AGAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 783 nt  | AGAT  | AATA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 972 nt  | AATA  | TCAT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 561 nt  | TCAT  | TCAG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1692 nt | TCAG  | TCTA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1553 nt | TCTA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAT]----3'WT sub1----[AGAT]----3'WT sub2----[AATA]----3'WT sub3----[TCAT]----3'WT sub4----[TCAG]----3'WT sub5----[TCTA]----3'WT+PolIII sub6----[CACC]
   TGAT                   AGAT                   AATA                   TCAT                   TCAG                   TCTA                          CACC 
```

**Set fidelity:** 0.8583 (7 overhangs)

---

### Tile 4 of 31 -- Codons 167-232 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | TGAT     | 0.6933   |

**Variants:** 13020 mutations, 13020 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 516 nt | ATGG  | GAAA  |
| 2   | Oligo pool      | Tile 4 (13020 oligos) | 254 nt | GAAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[GAAA]----oligo+BC----[AGAA]
   ATGG                    GAAA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1     | 651 nt  | TGAT  | AGAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 783 nt  | AGAT  | AATA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 972 nt  | AATA  | TCAT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 561 nt  | TCAT  | TCAG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1692 nt | TCAG  | TCTA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1553 nt | TCTA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAT]----3'WT sub1----[AGAT]----3'WT sub2----[AATA]----3'WT sub3----[TCAT]----3'WT sub4----[TCAG]----3'WT sub5----[TCTA]----3'WT+PolIII sub6----[CACC]
   TGAT                   AGAT                   AATA                   TCAT                   TCAG                   TCTA                          CACC 
```

**Set fidelity:** 0.8583 (7 overhangs)

---

### Tile 5 of 31 -- Codons 229-298 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | ATTT     | 0.7664   |

**Variants:** 13860 mutations, 13860 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 702 nt | ATGG  | GAAA  |
| 2   | Oligo pool      | Tile 5 (13860 oligos) | 266 nt | GAAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[GAAA]----oligo+BC----[AGAA]
   ATGG                    GAAA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1     | 453 nt  | ATTT  | AGAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 783 nt  | AGAT  | AATA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 972 nt  | AATA  | TCAT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 561 nt  | TCAT  | TCAG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1692 nt | TCAG  | TCTA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1553 nt | TCTA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATTT]----3'WT sub1----[AGAT]----3'WT sub2----[AATA]----3'WT sub3----[TCAT]----3'WT sub4----[TCAG]----3'WT sub5----[TCTA]----3'WT+PolIII sub6----[CACC]
   ATTT                   AGAT                   AATA                   TCAT                   TCAG                   TCTA                          CACC 
```

**Set fidelity:** 0.9973 (7 overhangs)

---

### Tile 6 of 31 -- Codons 295-372 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGA     | 0.8175   |
| oh2 (3' boundary) | TTGC     | 0.7336   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 900 nt | ATGG  | CAGA  |
| 2   | Oligo pool      | Tile 6 (15540 oligos) | 290 nt | CAGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[CAGA]----oligo+BC----[AGAA]
   ATGG                    CAGA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1     | 996 nt  | TTGC  | AATA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 972 nt  | AATA  | TCAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 561 nt  | TCAT  | TCAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1692 nt | TCAG  | TCTA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1553 nt | TCTA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTGC]----3'WT sub1----[AATA]----3'WT sub2----[TCAT]----3'WT sub3----[TCAG]----3'WT sub4----[TCTA]----3'WT+PolIII sub5----[CACC]
   TTGC                   AATA                   TCAT                   TCAG                   TCTA                          CACC 
```

**Set fidelity:** 0.9973 (6 overhangs)

---

### Tile 7 of 31 -- Codons 369-443 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAG     | 0.8480   |
| oh2 (3' boundary) | AGAT     | 0.6825   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 1122 nt | ATGG  | TTAG  |
| 2   | Oligo pool      | Tile 7 (14910 oligos) | 281 nt  | TTAG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[TTAG]----oligo+BC----[AGAA]
   ATGG                    TTAG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 783 nt  | AGAT  | AATA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 972 nt  | AATA  | TCAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 561 nt  | TCAT  | TCAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1692 nt | TCAG  | TCTA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1553 nt | TCTA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAT]----3'WT sub1----[AATA]----3'WT sub2----[TCAT]----3'WT sub3----[TCAG]----3'WT sub4----[TCTA]----3'WT+PolIII sub5----[CACC]
   AGAT                   AATA                   TCAT                   TCAG                   TCTA                          CACC 
```

**Set fidelity:** 0.9973 (6 overhangs)

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

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1335 nt | ATGG  | TCAA  |
| 2   | Oligo pool      | Tile 8 (11550 oligos) | 233 nt  | TCAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[TCAA]----oligo+BC----[AGAA]
   ATGG                    TCAA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1     | 618 nt  | TGAA  | AATA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 972 nt  | AATA  | TCAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 561 nt  | TCAT  | TCAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1692 nt | TCAG  | TCTA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1553 nt | TCTA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[AATA]----3'WT sub2----[TCAT]----3'WT sub3----[TCAG]----3'WT sub4----[TCTA]----3'WT+PolIII sub5----[CACC]
   TGAA                   AATA                   TCAT                   TCAG                   TCTA                          CACC 
```

**Set fidelity:** 0.9973 (6 overhangs)

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

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9_sub1   | 1500 nt | ATGG  | ATTT  |
| 2   | Oligo pool      | Tile 9 (15540 oligos) | 290 nt  | ATTT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

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
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1     | 396 nt  | AGGA  | AATA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 972 nt  | AATA  | TCAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 561 nt  | TCAT  | TCAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1692 nt | TCAG  | TCTA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1553 nt | TCTA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGGA]----3'WT sub1----[AATA]----3'WT sub2----[TCAT]----3'WT sub3----[TCAG]----3'WT sub4----[TCTA]----3'WT+PolIII sub5----[CACC]
   AGGA                   AATA                   TCAT                   TCAG                   TCTA                          CACC 
```

**Set fidelity:** 0.9973 (6 overhangs)

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

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1343 nt | ATGG  | AGAT  |
| 2   | 5'WT gene block | bsai_5wt_tile10_sub2   | 397 nt  | AGAT  | TTAC  |
| 3   | Oligo pool      | Tile 10 (13860 oligos) | 266 nt  | TTAC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AGAT]----5'WT sub2----[TTAC]----oligo+BC----[AGAA]
   ATGG                   AGAT                   TTAC                  AGAA 
```

**Set fidelity:** 0.9403 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1    | 1152 nt | GATA  | TCAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 561 nt  | TCAT  | TCAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1692 nt | TCAG  | TCTA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1553 nt | TCTA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GATA]----3'WT sub1----[TCAT]----3'WT sub2----[TCAG]----3'WT sub3----[TCTA]----3'WT+PolIII sub4----[CACC]
   GATA                   TCAT                   TCAG                   TCTA                          CACC 
```

**Set fidelity:** 0.9973 (5 overhangs)

---

### Tile 11 of 31 -- Codons 635-698 (192 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | AATA     | 0.8816   |

**Variants:** 12600 mutations, 12600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1343 nt | ATGG  | AGAT  |
| 2   | 5'WT gene block | bsai_5wt_tile11_sub2   | 595 nt  | AGAT  | AAGA  |
| 3   | Oligo pool      | Tile 11 (12600 oligos) | 248 nt  | AAGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AGAT]----5'WT sub2----[AAGA]----oligo+BC----[AGAA]
   ATGG                   AGAT                   AAGA                  AGAA 
```

**Set fidelity:** 0.9403 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 972 nt  | AATA  | TCAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 561 nt  | TCAT  | TCAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1692 nt | TCAG  | TCTA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1553 nt | TCTA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AATA]----3'WT sub1----[TCAT]----3'WT sub2----[TCAG]----3'WT sub3----[TCTA]----3'WT+PolIII sub4----[CACC]
   AATA                   TCAT                   TCAG                   TCTA                          CACC 
```

**Set fidelity:** 0.9973 (5 overhangs)

---

### Tile 12 of 31 -- Codons 695-749 (165 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAT     | 0.7246   |
| oh2 (3' boundary) | TCAA     | 0.9425   |

**Variants:** 10710 mutations, 10710 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1343 nt | ATGG  | AGAT  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2   | 775 nt  | AGAT  | GAAT  |
| 3   | Oligo pool      | Tile 12 (10710 oligos) | 221 nt  | GAAT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AGAT]----5'WT sub2----[GAAT]----oligo+BC----[AGAA]
   ATGG                   AGAT                   GAAT                  AGAA 
```

**Set fidelity:** 0.9389 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1    | 819 nt  | TCAA  | TCAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 561 nt  | TCAT  | TCAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1692 nt | TCAG  | TCTA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1553 nt | TCTA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAA]----3'WT sub1----[TCAT]----3'WT sub2----[TCAG]----3'WT sub3----[TCTA]----3'WT+PolIII sub4----[CACC]
   TCAA                   TCAT                   TCAG                   TCTA                          CACC 
```

**Set fidelity:** 0.9274 (5 overhangs)

---

### Tile 13 of 31 -- Codons 746-813 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTTC     | 0.8348   |
| oh2 (3' boundary) | AAAT     | 0.7737   |

**Variants:** 13440 mutations, 13440 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1343 nt | ATGG  | AGAT  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 928 nt  | AGAT  | TTTC  |
| 3   | Oligo pool      | Tile 13 (13440 oligos) | 260 nt  | TTTC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AGAT]----5'WT sub2----[TTTC]----oligo+BC----[AGAA]
   ATGG                   AGAT                   TTTC                  AGAA 
```

**Set fidelity:** 0.9403 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1    | 627 nt  | AAAT  | TCAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 561 nt  | TCAT  | TCAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1692 nt | TCAG  | TCTA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1553 nt | TCTA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAT]----3'WT sub1----[TCAT]----3'WT sub2----[TCAG]----3'WT sub3----[TCTA]----3'WT+PolIII sub4----[CACC]
   AAAT                   TCAT                   TCAG                   TCTA                          CACC 
```

**Set fidelity:** 0.9973 (5 overhangs)

---

### Tile 14 of 31 -- Codons 810-885 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGTA     | 0.7286   |
| oh2 (3' boundary) | AAAT     | 0.7737   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1343 nt | ATGG  | AGAT  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 783 nt  | AGAT  | AATA  |
| 3   | 5'WT gene block | bsai_5wt_tile14_sub3   | 355 nt  | AATA  | AGTA  |
| 4   | Oligo pool      | Tile 14 (15120 oligos) | 284 nt  | AGTA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AGAT]----5'WT sub2----[AATA]----5'WT sub3----[AGTA]----oligo+BC----[AGAA]
   ATGG                   AGAT                   AATA                   AGTA                  AGAA 
```

**Set fidelity:** 0.8974 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1    | 411 nt  | AAAT  | TCAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 561 nt  | TCAT  | TCAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1692 nt | TCAG  | TCTA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1553 nt | TCTA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAT]----3'WT sub1----[TCAT]----3'WT sub2----[TCAG]----3'WT sub3----[TCTA]----3'WT+PolIII sub4----[CACC]
   AAAT                   TCAT                   TCAG                   TCTA                          CACC 
```

**Set fidelity:** 0.9973 (5 overhangs)

---

### Tile 15 of 31 -- Codons 882-947 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACGA     | 0.7639   |
| oh2 (3' boundary) | TATT     | 0.8134   |

**Variants:** 13020 mutations, 13020 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1343 nt | ATGG  | AGAT  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 783 nt  | AGAT  | AATA  |
| 3   | 5'WT gene block | bsai_5wt_tile15_sub3   | 571 nt  | AATA  | ACGA  |
| 4   | Oligo pool      | Tile 15 (13020 oligos) | 254 nt  | ACGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AGAT]----5'WT sub2----[AATA]----5'WT sub3----[ACGA]----oligo+BC----[AGAA]
   ATGG                   AGAT                   AATA                   ACGA                  AGAA 
```

**Set fidelity:** 0.9403 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1    | 768 nt  | TATT  | TCAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1692 nt | TCAG  | TCTA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1553 nt | TCTA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TATT]----3'WT sub1----[TCAG]----3'WT sub2----[TCTA]----3'WT+PolIII sub3----[CACC]
   TATT                   TCAG                   TCTA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 16 of 31 -- Codons 944-1016 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAT     | 0.7737   |
| oh2 (3' boundary) | TCAT     | 0.8102   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1343 nt | ATGG  | AGAT  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 783 nt  | AGAT  | AATA  |
| 3   | 5'WT gene block | bsai_5wt_tile16_sub3   | 757 nt  | AATA  | AAAT  |
| 4   | Oligo pool      | Tile 16 (14490 oligos) | 275 nt  | AAAT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AGAT]----5'WT sub2----[AATA]----5'WT sub3----[AAAT]----oligo+BC----[AGAA]
   ATGG                   AGAT                   AATA                   AAAT                  AGAA 
```

**Set fidelity:** 0.8979 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 561 nt  | TCAT  | TCAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1692 nt | TCAG  | TCTA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1553 nt | TCTA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAT]----3'WT sub1----[TCAG]----3'WT sub2----[TCTA]----3'WT+PolIII sub3----[CACC]
   TCAT                   TCAG                   TCTA                          CACC 
```

**Set fidelity:** 0.9973 (4 overhangs)

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
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1343 nt | ATGG  | AGAT  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 783 nt  | AGAT  | AATA  |
| 3   | 5'WT gene block | bsai_5wt_tile17_sub3   | 964 nt  | AATA  | TCTA  |
| 4   | Oligo pool      | Tile 17 (11130 oligos) | 227 nt  | TCTA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AGAT]----5'WT sub2----[AATA]----5'WT sub3----[TCTA]----oligo+BC----[AGAA]
   ATGG                   AGAT                   AATA                   TCTA                  AGAA 
```

**Set fidelity:** 0.9403 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1    | 402 nt  | TTCA  | TCAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1692 nt | TCAG  | TCTA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1553 nt | TCTA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCA]----3'WT sub1----[TCAG]----3'WT sub2----[TCTA]----3'WT+PolIII sub3----[CACC]
   TTCA                   TCAG                   TCTA                          CACC 
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
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1343 nt | ATGG  | AGAT  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 783 nt  | AGAT  | AATA  |
| 3   | 5'WT gene block | bsai_5wt_tile18_sub3   | 1123 nt | AATA  | TTTC  |
| 4   | Oligo pool      | Tile 18 (12810 oligos) | 251 nt  | TTTC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AGAT]----5'WT sub2----[AATA]----5'WT sub3----[TTTC]----oligo+BC----[AGAA]
   ATGG                   AGAT                   AATA                   TTTC                  AGAA 
```

**Set fidelity:** 0.9403 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1    | 219 nt  | CAAA  | TCAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1692 nt | TCAG  | TCTA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1553 nt | TCTA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAA]----3'WT sub1----[TCAG]----3'WT sub2----[TCTA]----3'WT+PolIII sub3----[CACC]
   CAAA                   TCAG                   TCTA                          CACC 
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
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1343 nt | ATGG  | AGAT  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 783 nt  | AGAT  | AATA  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3   | 972 nt  | AATA  | TCAT  |
| 4   | 5'WT gene block | bsai_5wt_tile19_sub4   | 352 nt  | TCAT  | GAAT  |
| 5   | Oligo pool      | Tile 19 (14070 oligos) | 269 nt  | GAAT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AGAT]----5'WT sub2----[AATA]----5'WT sub3----[TCAT]----5'WT sub4----[GAAT]----oligo+BC----[AGAA]
   ATGG                   AGAT                   AATA                   TCAT                   GAAT                  AGAA 
```

**Set fidelity:** 0.9389 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1692 nt | TCAG  | TCTA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1553 nt | TCTA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAG]----3'WT sub1----[TCTA]----3'WT+PolIII sub2----[CACC]
   TCAG                   TCTA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

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
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1343 nt | ATGG  | AGAT  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 783 nt  | AGAT  | AATA  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3   | 972 nt  | AATA  | TCAT  |
| 4   | 5'WT gene block | bsai_5wt_tile20_sub4   | 553 nt  | TCAT  | AAGA  |
| 5   | Oligo pool      | Tile 20 (11970 oligos) | 239 nt  | AAGA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AGAT]----5'WT sub2----[AATA]----5'WT sub3----[TCAT]----5'WT sub4----[AAGA]----oligo+BC----[AGAA]
   ATGG                   AGAT                   AATA                   TCAT                   AAGA                  AGAA 
```

**Set fidelity:** 0.9403 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1    | 1521 nt | GAAA  | TCTA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1553 nt | TCTA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAA]----3'WT sub1----[TCTA]----3'WT+PolIII sub2----[CACC]
   GAAA                   TCTA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

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
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1343 nt | ATGG  | AGAT  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 783 nt  | AGAT  | AATA  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3   | 972 nt  | AATA  | TCAT  |
| 4   | 5'WT gene block | bsai_5wt_tile21_sub4   | 724 nt  | TCAT  | GAAA  |
| 5   | Oligo pool      | Tile 21 (14910 oligos) | 281 nt  | GAAA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AGAT]----5'WT sub2----[AATA]----5'WT sub3----[TCAT]----5'WT sub4----[GAAA]----oligo+BC----[AGAA]
   ATGG                   AGAT                   AATA                   TCAT                   GAAA                  AGAA 
```

**Set fidelity:** 0.9403 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1    | 1308 nt | AAGT  | TCTA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1553 nt | TCTA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAGT]----3'WT sub1----[TCTA]----3'WT+PolIII sub2----[CACC]
   AAGT                   TCTA                          CACC 
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
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1343 nt | ATGG  | AGAT  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 783 nt  | AGAT  | AATA  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3   | 972 nt  | AATA  | TCAT  |
| 4   | 5'WT gene block | bsai_5wt_tile22_sub4   | 561 nt  | TCAT  | TCAG  |
| 5   | 5'WT gene block | bsai_5wt_tile22_sub5   | 394 nt  | TCAG  | TTAC  |
| 6   | Oligo pool      | Tile 22 (13230 oligos) | 257 nt  | TTAC  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AGAT]----5'WT sub2----[AATA]----5'WT sub3----[TCAT]----5'WT sub4----[TCAG]----5'WT sub5----[TTAC]----oligo+BC----[AGAA]
   ATGG                   AGAT                   AATA                   TCAT                   TCAG                   TTAC                  AGAA 
```

**Set fidelity:** 0.9337 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1    | 1119 nt | CAAA  | TCTA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1553 nt | TCTA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAA]----3'WT sub1----[TCTA]----3'WT+PolIII sub2----[CACC]
   CAAA                   TCTA                          CACC 
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
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1343 nt | ATGG  | AGAT  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2  | 783 nt  | AGAT  | AATA  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3  | 972 nt  | AATA  | TCAT  |
| 4   | 5'WT gene block | bsai_5wt_tile22_sub4  | 561 nt  | TCAT  | TCAG  |
| 5   | 5'WT gene block | bsai_5wt_tile23_sub5  | 583 nt  | TCAG  | AAGA  |
| 6   | Oligo pool      | Tile 23 (8190 oligos) | 185 nt  | AAGA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AGAT]----5'WT sub2----[AATA]----5'WT sub3----[TCAT]----5'WT sub4----[TCAG]----5'WT sub5----[AAGA]----oligo+BC----[AGAA]
   ATGG                   AGAT                   AATA                   TCAT                   TCAG                   AAGA                  AGAA 
```

**Set fidelity:** 0.9337 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1    | 1002 nt | AAGT  | TCTA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1553 nt | TCTA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAGT]----3'WT sub1----[TCTA]----3'WT+PolIII sub2----[CACC]
   AAGT                   TCTA                          CACC 
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
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1343 nt | ATGG  | AGAT  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 783 nt  | AGAT  | AATA  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3   | 972 nt  | AATA  | TCAT  |
| 4   | 5'WT gene block | bsai_5wt_tile22_sub4   | 561 nt  | TCAT  | TCAG  |
| 5   | 5'WT gene block | bsai_5wt_tile24_sub5   | 700 nt  | TCAG  | AAGA  |
| 6   | Oligo pool      | Tile 24 (14070 oligos) | 269 nt  | AAGA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AGAT]----5'WT sub2----[AATA]----5'WT sub3----[TCAT]----5'WT sub4----[TCAG]----5'WT sub5----[AAGA]----oligo+BC----[AGAA]
   ATGG                   AGAT                   AATA                   TCAT                   TCAG                   AAGA                  AGAA 
```

**Set fidelity:** 0.9337 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile24_sub1    | 801 nt  | TGGA  | TCTA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1553 nt | TCTA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGGA]----3'WT sub1----[TCTA]----3'WT+PolIII sub2----[CACC]
   TGGA                   TCTA                          CACC 
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
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1343 nt | ATGG  | AGAT  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 783 nt  | AGAT  | AATA  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3   | 972 nt  | AATA  | TCAT  |
| 4   | 5'WT gene block | bsai_5wt_tile22_sub4   | 561 nt  | TCAT  | TCAG  |
| 5   | 5'WT gene block | bsai_5wt_tile25_sub5   | 901 nt  | TCAG  | GAAA  |
| 6   | Oligo pool      | Tile 25 (13230 oligos) | 257 nt  | GAAA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AGAT]----5'WT sub2----[AATA]----5'WT sub3----[TCAT]----5'WT sub4----[TCAG]----5'WT sub5----[GAAA]----oligo+BC----[AGAA]
   ATGG                   AGAT                   AATA                   TCAT                   TCAG                   GAAA                  AGAA 
```

**Set fidelity:** 0.9337 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile25_sub1    | 612 nt  | AGGA  | TCTA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1553 nt | TCTA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGGA]----3'WT sub1----[TCTA]----3'WT+PolIII sub2----[CACC]
   AGGA                   TCTA                          CACC 
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
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1343 nt | ATGG  | AGAT  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 783 nt  | AGAT  | AATA  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3   | 972 nt  | AATA  | TCAT  |
| 4   | 5'WT gene block | bsai_5wt_tile22_sub4   | 561 nt  | TCAT  | TCAG  |
| 5   | 5'WT gene block | bsai_5wt_tile26_sub5   | 1090 nt | TCAG  | CTAA  |
| 6   | Oligo pool      | Tile 26 (15330 oligos) | 287 nt  | CTAA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AGAT]----5'WT sub2----[AATA]----5'WT sub3----[TCAT]----5'WT sub4----[TCAG]----5'WT sub5----[CTAA]----oligo+BC----[AGAA]
   ATGG                   AGAT                   AATA                   TCAT                   TCAG                   CTAA                  AGAA 
```

**Set fidelity:** 0.9337 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile26_sub1    | 393 nt  | ATCT  | TCTA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1553 nt | TCTA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATCT]----3'WT sub1----[TCTA]----3'WT+PolIII sub2----[CACC]
   ATCT                   TCTA                          CACC 
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
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1343 nt | ATGG  | AGAT  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 783 nt  | AGAT  | AATA  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3   | 972 nt  | AATA  | TCAT  |
| 4   | 5'WT gene block | bsai_5wt_tile22_sub4   | 561 nt  | TCAT  | TCAG  |
| 5   | 5'WT gene block | bsai_5wt_tile27_sub5   | 1309 nt | TCAG  | TATC  |
| 6   | Oligo pool      | Tile 27 (13440 oligos) | 260 nt  | TATC  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AGAT]----5'WT sub2----[AATA]----5'WT sub3----[TCAT]----5'WT sub4----[TCAG]----5'WT sub5----[TATC]----oligo+BC----[AGAA]
   ATGG                   AGAT                   AATA                   TCAT                   TCAG                   TATC                  AGAA 
```

**Set fidelity:** 0.9337 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile27_sub1    | 1736 nt | GACA  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GACA]----3'WT+PolIII----[CACC]
   GACA                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

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
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1343 nt | ATGG  | AGAT  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 783 nt  | AGAT  | AATA  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3   | 972 nt  | AATA  | TCAT  |
| 4   | 5'WT gene block | bsai_5wt_tile22_sub4   | 561 nt  | TCAT  | TCAG  |
| 5   | 5'WT gene block | bsai_5wt_tile28_sub5   | 1501 nt | TCAG  | GAAA  |
| 6   | Oligo pool      | Tile 28 (12810 oligos) | 251 nt  | GAAA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AGAT]----5'WT sub2----[AATA]----5'WT sub3----[TCAT]----5'WT sub4----[TCAG]----5'WT sub5----[GAAA]----oligo+BC----[AGAA]
   ATGG                   AGAT                   AATA                   TCAT                   TCAG                   GAAA                  AGAA 
```

**Set fidelity:** 0.9337 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 1553 nt | TCTA  | CACC  |
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
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1343 nt | ATGG  | AGAT  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 783 nt  | AGAT  | AATA  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3   | 972 nt  | AATA  | TCAT  |
| 4   | 5'WT gene block | bsai_5wt_tile22_sub4   | 561 nt  | TCAT  | TCAG  |
| 5   | 5'WT gene block | bsai_5wt_tile29_sub5   | 1684 nt | TCAG  | TTTC  |
| 6   | Oligo pool      | Tile 29 (12390 oligos) | 245 nt  | TTTC  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AGAT]----5'WT sub2----[AATA]----5'WT sub3----[TCAT]----5'WT sub4----[TCAG]----5'WT sub5----[TTTC]----oligo+BC----[AGAA]
   ATGG                   AGAT                   AATA                   TCAT                   TCAG                   TTTC                  AGAA 
```

**Set fidelity:** 0.9337 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile29         | 1376 nt | GAAT  | CACC  |
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
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1343 nt | ATGG  | AGAT  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 783 nt  | AGAT  | AATA  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3   | 972 nt  | AATA  | TCAT  |
| 4   | 5'WT gene block | bsai_5wt_tile22_sub4   | 561 nt  | TCAT  | TCAG  |
| 5   | 5'WT gene block | bsai_5wt_tile30_sub5   | 1692 nt | TCAG  | TCTA  |
| 6   | 5'WT gene block | bsai_5wt_tile30_sub6   | 187 nt  | TCTA  | CTAA  |
| 7   | Oligo pool      | Tile 30 (10290 oligos) | 215 nt  | CTAA  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AGAT]----5'WT sub2----[AATA]----5'WT sub3----[TCAT]----5'WT sub4----[TCAG]----5'WT sub5----[TCTA]----5'WT sub6----[CTAA]----oligo+BC----[AGAA]
   ATGG                   AGAT                   AATA                   TCAT                   TCAG                   TCTA                   CTAA                  AGAA 
```

**Set fidelity:** 0.9337 (8 overhangs)

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
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1343 nt | ATGG  | AGAT  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2  | 783 nt  | AGAT  | AATA  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3  | 972 nt  | AATA  | TCAT  |
| 4   | 5'WT gene block | bsai_5wt_tile22_sub4  | 561 nt  | TCAT  | TCAG  |
| 5   | 5'WT gene block | bsai_5wt_tile30_sub5  | 1692 nt | TCAG  | TCTA  |
| 6   | 5'WT gene block | bsai_5wt_tile31_sub6  | 334 nt  | TCTA  | TTAC  |
| 7   | Oligo pool      | Tile 31 (8190 oligos) | 185 nt  | TTAC  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AGAT]----5'WT sub2----[AATA]----5'WT sub3----[TCAT]----5'WT sub4----[TCAG]----5'WT sub5----[TCTA]----5'WT sub6----[TTAC]----oligo+BC----[AGAA]
   ATGG                   AGAT                   AATA                   TCAT                   TCAG                   TCTA                   TTAC                  AGAA 
```

**Set fidelity:** 0.9337 (8 overhangs)

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

**Total blocks:** 66

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| --------------------- | ----------- | ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| bsai_5wt_tile10_sub1  | 1343        | BsaI        | 5wt_tile10_sub1;5wt_tile11_sub1;5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1;5wt_tile26_sub1;5wt_tile27_sub1;5wt_tile28_sub1;5wt_tile29_sub1;5wt_tile30_sub1;5wt_tile31_sub1                                                                                                                                                                                                                                                                |
| bsai_5wt_tile10_sub2  | 397         | BsaI        | 5wt_tile10_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile11_sub2  | 595         | BsaI        | 5wt_tile11_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile12_sub2  | 775         | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile13_sub2  | 928         | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile14_sub2  | 783         | BsaI        | 5wt_tile14_sub2;5wt_tile15_sub2;5wt_tile16_sub2;5wt_tile17_sub2;5wt_tile18_sub2;5wt_tile19_sub2;5wt_tile20_sub2;5wt_tile21_sub2;5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2;5wt_tile26_sub2;5wt_tile27_sub2;5wt_tile28_sub2;5wt_tile29_sub2;5wt_tile30_sub2;5wt_tile31_sub2                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile14_sub3  | 355         | BsaI        | 5wt_tile14_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile15_sub3  | 571         | BsaI        | 5wt_tile15_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile16_sub3  | 757         | BsaI        | 5wt_tile16_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile17_sub3  | 964         | BsaI        | 5wt_tile17_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile18_sub3  | 1123        | BsaI        | 5wt_tile18_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile19_sub3  | 972         | BsaI        | 5wt_tile19_sub3;5wt_tile20_sub3;5wt_tile21_sub3;5wt_tile22_sub3;5wt_tile23_sub3;5wt_tile24_sub3;5wt_tile25_sub3;5wt_tile26_sub3;5wt_tile27_sub3;5wt_tile28_sub3;5wt_tile29_sub3;5wt_tile30_sub3;5wt_tile31_sub3                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile19_sub4  | 352         | BsaI        | 5wt_tile19_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile2        | 117         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile20_sub4  | 553         | BsaI        | 5wt_tile20_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile21_sub4  | 724         | BsaI        | 5wt_tile21_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile22_sub4  | 561         | BsaI        | 5wt_tile22_sub4;5wt_tile23_sub4;5wt_tile24_sub4;5wt_tile25_sub4;5wt_tile26_sub4;5wt_tile27_sub4;5wt_tile28_sub4;5wt_tile29_sub4;5wt_tile30_sub4;5wt_tile31_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile22_sub5  | 394         | BsaI        | 5wt_tile22_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile23_sub5  | 583         | BsaI        | 5wt_tile23_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile24_sub5  | 700         | BsaI        | 5wt_tile24_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile25_sub5  | 901         | BsaI        | 5wt_tile25_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile26_sub5  | 1090        | BsaI        | 5wt_tile26_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile27_sub5  | 1309        | BsaI        | 5wt_tile27_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile28_sub5  | 1501        | BsaI        | 5wt_tile28_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile29_sub5  | 1684        | BsaI        | 5wt_tile29_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile3        | 321         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile30_sub5  | 1692        | BsaI        | 5wt_tile30_sub5;5wt_tile31_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile30_sub6  | 187         | BsaI        | 5wt_tile30_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile31_sub6  | 334         | BsaI        | 5wt_tile31_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile4        | 516         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile5        | 702         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile6        | 900         | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile7        | 1122        | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile8        | 1335        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile9_sub1   | 1500        | BsaI        | 5wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile1_sub1  | 1236        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile1_sub2  | 783         | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile1_sub3  | 972         | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile8_sub2;3wt_tile9_sub2;3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile1_sub4  | 561         | BsmBI       | 3wt_tile1_sub4;3wt_tile2_sub4;3wt_tile3_sub4;3wt_tile4_sub4;3wt_tile5_sub4;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub3;3wt_tile9_sub3;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile1_sub5  | 1692        | BsmBI       | 3wt_tile1_sub5;3wt_tile2_sub5;3wt_tile3_sub5;3wt_tile4_sub5;3wt_tile5_sub5;3wt_tile6_sub4;3wt_tile7_sub4;3wt_tile8_sub4;3wt_tile9_sub4;3wt_tile10_sub3;3wt_tile11_sub3;3wt_tile12_sub3;3wt_tile13_sub3;3wt_tile14_sub3;3wt_tile15_sub2;3wt_tile16_sub2;3wt_tile17_sub2;3wt_tile18_sub2;3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile1_sub6  | 1553        | BsmBI       | 3wt_polIII_tile1_sub6;3wt_polIII_tile2_sub6;3wt_polIII_tile3_sub6;3wt_polIII_tile4_sub6;3wt_polIII_tile5_sub6;3wt_polIII_tile6_sub5;3wt_polIII_tile7_sub5;3wt_polIII_tile8_sub5;3wt_polIII_tile9_sub5;3wt_polIII_tile10_sub4;3wt_polIII_tile11_sub4;3wt_polIII_tile12_sub4;3wt_polIII_tile13_sub4;3wt_polIII_tile14_sub4;3wt_polIII_tile15_sub3;3wt_polIII_tile16_sub3;3wt_polIII_tile17_sub3;3wt_polIII_tile18_sub3;3wt_polIII_tile19_sub2;3wt_polIII_tile20_sub2;3wt_polIII_tile21_sub2;3wt_polIII_tile22_sub2;3wt_polIII_tile23_sub2;3wt_polIII_tile24_sub2;3wt_polIII_tile25_sub2;3wt_polIII_tile26_sub2;3wt_polIII_tile28 |
| bsmbi_3wt_tile10_sub1 | 1152        | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile12_sub1 | 819         | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile13_sub1 | 627         | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile14_sub1 | 411         | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile15_sub1 | 768         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile17_sub1 | 402         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile18_sub1 | 219         | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile2_sub1  | 1032        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile20_sub1 | 1521        | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile21_sub1 | 1308        | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile22_sub1 | 1119        | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile23_sub1 | 1002        | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile24_sub1 | 801         | BsmBI       | 3wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile25_sub1 | 612         | BsmBI       | 3wt_tile25_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile26_sub1 | 393         | BsmBI       | 3wt_tile26_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile27_sub1 | 1736        | BsmBI       | 3wt_polIII_tile27_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile29      | 1376        | BsmBI       | 3wt_polIII_tile29                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile3_sub1  | 837         | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile30      | 1229        | BsmBI       | 3wt_polIII_tile30                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile4_sub1  | 651         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile5_sub1  | 453         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile6_sub1  | 996         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile8_sub1  | 618         | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile9_sub1  | 396         | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_polIII_tile31   | 1112        | BsmBI       | polIII_tile31                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |

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

