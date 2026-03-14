# DMS-GG Assembly Report: AKAP11

Generated: 2026-03-12 23:05:26
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                          |
| -------------------- | ------------------------------------------------------------------------------ |
| Gene name            | AKAP11_NM_016248.4_CDS Homo sapiens A-kinase anchoring protein 11 (AKAP11) CDS |
| CDS length           | 5706 nt (1902 codons)                                                          |
| Protein length       | 1901 aa                                                                        |
| Number of tiles      | 35                                                                             |
| Total variants       | 39522                                                                          |
| Total oligos         | 395220                                                                         |
| Oligo length range   | 134-290 nt                                                                     |
| Gene blocks to order | 72                                                                             |
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

**Total oligos:** 395220 | **Length range:** 134-290 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-44      | 8400   | 188 nt |
| 2    | 41-118    | 15540  | 290 nt |
| 3    | 115-156   | 7980   | 182 nt |
| 4    | 153-217   | 12810  | 251 nt |
| 5    | 214-265   | 10080  | 212 nt |
| 6    | 266-333   | 13440  | 260 nt |
| 7    | 330-397   | 13440  | 260 nt |
| 8    | 394-449   | 10920  | 224 nt |
| 9    | 446-513   | 13440  | 260 nt |
| 10   | 510-586   | 15330  | 287 nt |
| 11   | 583-657   | 14910  | 281 nt |
| 12   | 654-724   | 14070  | 269 nt |
| 13   | 721-778   | 11340  | 230 nt |
| 14   | 775-813   | 7350   | 173 nt |
| 15   | 814-886   | 14490  | 275 nt |
| 16   | 883-950   | 13440  | 260 nt |
| 17   | 947-1016  | 13860  | 266 nt |
| 18   | 1013-1054 | 7980   | 182 nt |
| 19   | 1051-1117 | 13230  | 257 nt |
| 20   | 1114-1179 | 13020  | 254 nt |
| 21   | 1176-1221 | 8820   | 194 nt |
| 22   | 1218-1269 | 10080  | 212 nt |
| 23   | 1266-1313 | 9240   | 200 nt |
| 24   | 1314-1353 | 7560   | 176 nt |
| 25   | 1350-1408 | 11550  | 233 nt |
| 26   | 1405-1470 | 13020  | 254 nt |
| 27   | 1467-1512 | 8820   | 194 nt |
| 28   | 1509-1557 | 9450   | 203 nt |
| 29   | 1554-1630 | 15330  | 287 nt |
| 30   | 1627-1657 | 5670   | 149 nt |
| 31   | 1654-1730 | 15330  | 287 nt |
| 32   | 1727-1782 | 10920  | 224 nt |
| 33   | 1779-1815 | 6930   | 167 nt |
| 34   | 1812-1876 | 12810  | 251 nt |
| 35   | 1877-1902 | 4620   | 134 nt |

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
| Total barcodes    | 395220                             |
| Unique barcodes   | 395220                             |
| GC content range  | 25% - 75%                          |
| GC content mean   | 48.4%                              |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                  | Description                                                   | Result | Detail                                                                                                                                               |
| ---------------------- | ------------------------------------------------------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths          | All oligos within synthesis length limit                      | PASS   | Range: 134-290 nt (limit: 300)                                                                                                                       |
| block_lengths          | All gene blocks within synthesis length limit                 | PASS   | Range: 138-1795 nt (limit: 1800)                                                                                                                     |
| barcode_junction_sites | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                              |
| barcode_uniqueness     | All barcodes are unique                                       | PASS   | 395220 unique / 395220 total                                                                                                                         |
| tile_coverage          | Tiles cover entire gene without gaps                          | PASS   | 5706 / 5706 nt covered                                                                                                                               |
| variant_count          | Expected number of variants generated                         | PASS   | 39522 unique variants (expected: 39522 across 1882/1900 mutable positions; 35758 missense + 1882 nonsense + 1882 wt_control; 18 position(s) skipped) |
| single_codon_change    | Each non-control variant differs by exactly one codon from WT | PASS   | 376400 / 376400 variants confirmed (WT controls excluded)                                                                                            |
| oligo_gc_content       | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 31.4-53.3% | 0 oligo(s) with extreme GC                                                                                                    |
| domestication_complete | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                              |
| overhang_fidelity      | Tile boundary overhangs have adequate fidelity                | FAIL   | 32 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                              |
| tile_manifests         | Per-tile assembly manifests complete                          | PASS   | 35 tile manifest(s) generated                                                                                                                        |
| helper_plasmid         | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                   |
| reaction_fidelity      | Per-reaction set-level overhang fidelity                      | FAIL   | Min set fidelity: 0.7583 across 70 reactions | 7 reaction(s) below 0.90                                                                              |
| barcode_poliii_term    | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 395220 barcode(s) contain TTTT                                                                                                                   |
| block_min_length       | All gene blocks above synthesis minimum length                | FAIL   | 5 block(s) below 300 nt minimum. Range: 138-1795 nt                                                                                                  |
| sb_overhang_collisions | Superblock boundary overhangs are unique (no collisions)      | PASS   | 4 SB boundary OH(s), all unique                                                                                                                      |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 6         | 0.8272             |
| 2    | 3        | 1.0000            | 6         | 0.8259             |
| 3    | 3        | 1.0000            | 6         | 0.8272             |
| 4    | 3        | 1.0000            | 6         | 0.8272             |
| 5    | 3        | 1.0000            | 5         | 0.8272             |
| 6    | 3        | 1.0000            | 5         | 0.9933             |
| 7    | 3        | 1.0000            | 5         | 0.9933             |
| 8    | 4        | 1.0000            | 5         | 0.9878             |
| 9    | 4        | 1.0000            | 5         | 0.9933             |
| 10   | 4        | 1.0000            | 5         | 0.9933             |
| 11   | 4        | 1.0000            | 5         | 0.9933             |
| 12   | 4        | 1.0000            | 4         | 0.7583             |
| 13   | 4        | 1.0000            | 4         | 0.7940             |
| 14   | 4        | 0.9472            | 4         | 0.9933             |
| 15   | 4        | 1.0000            | 4         | 1.0000             |
| 16   | 5        | 0.9376            | 4         | 1.0000             |
| 17   | 5        | 1.0000            | 4         | 1.0000             |
| 18   | 5        | 1.0000            | 4         | 1.0000             |
| 19   | 5        | 1.0000            | 4         | 1.0000             |
| 20   | 5        | 1.0000            | 4         | 0.9986             |
| 21   | 5        | 0.9712            | 4         | 1.0000             |
| 22   | 5        | 1.0000            | 4         | 1.0000             |
| 23   | 5        | 1.0000            | 3         | 1.0000             |
| 24   | 5        | 1.0000            | 3         | 1.0000             |
| 25   | 5        | 1.0000            | 3         | 1.0000             |
| 26   | 5        | 0.9907            | 3         | 1.0000             |
| 27   | 6        | 1.0000            | 3         | 1.0000             |
| 28   | 6        | 1.0000            | 3         | 1.0000             |
| 29   | 6        | 1.0000            | 3         | 1.0000             |
| 30   | 6        | 0.9962            | 3         | 1.0000             |
| 31   | 6        | 0.9376            | 3         | 1.0000             |
| 32   | 6        | 0.9712            | 3         | 1.0000             |
| 33   | 6        | 1.0000            | 2         | 1.0000             |
| 34   | 6        | 1.0000            | 2         | 1.0000             |
| 35   | 6        | 0.9984            | 2         | 1.0000             |

**Min:** 0.7583 | **Max:** 1.0000 | **Mean:** 0.9769

**Warning:** 7 reaction(s) below 0.90 fidelity — consider alternative split points or overhang reassignment.
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

### Tile 1 of 35 -- Codons 1-44 (132 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGG     | 0.5393   |
| oh2 (3' boundary) | GCAG     | 0.5118   |

**Variants:** 8400 mutations, 8400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (8400 oligos)               | 188 nt | ATGG  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1     | 681 nt  | GCAG  | CACA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1662 nt | CACA  | TGCC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1518 nt | TGCC  | TCCG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | TCCG  | AGTG  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCAG]----3'WT sub1----[CACA]----3'WT sub2----[TGCC]----3'WT sub3----[TCCG]----3'WT sub4----[AGTG]----3'WT+PolIII sub5----[CACC]
   GCAG                   CACA                   TGCC                   TCCG                   AGTG                          CACC 
```

**Set fidelity:** 0.8272 (6 overhangs)

---

### Tile 2 of 35 -- Codons 41-118 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACAG     | 0.5793   |
| oh2 (3' boundary) | TGGA     | 0.7377   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 138 nt | ATGG  | ACAG  |
| 2   | Oligo pool      | Tile 2 (15540 oligos) | 290 nt | ACAG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[ACAG]----oligo+BC----[AGAA]
   ATGG                    ACAG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1     | 459 nt  | TGGA  | CACA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1662 nt | CACA  | TGCC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1518 nt | TGCC  | TCCG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | TCCG  | AGTG  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGGA]----3'WT sub1----[CACA]----3'WT sub2----[TGCC]----3'WT sub3----[TCCG]----3'WT sub4----[AGTG]----3'WT+PolIII sub5----[CACC]
   TGGA                   CACA                   TGCC                   TCCG                   AGTG                          CACC 
```

**Set fidelity:** 0.8259 (6 overhangs)

---

### Tile 3 of 35 -- Codons 115-156 (126 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTAA     | 0.8691   |
| oh2 (3' boundary) | CTTG     | 0.7594   |

**Variants:** 7980 mutations, 7980 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 360 nt | ATGG  | CTAA  |
| 2   | Oligo pool      | Tile 3 (7980 oligos)  | 182 nt | CTAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[CTAA]----oligo+BC----[AGAA]
   ATGG                    CTAA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1     | 345 nt  | CTTG  | CACA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1662 nt | CACA  | TGCC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1518 nt | TGCC  | TCCG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | TCCG  | AGTG  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTTG]----3'WT sub1----[CACA]----3'WT sub2----[TGCC]----3'WT sub3----[TCCG]----3'WT sub4----[AGTG]----3'WT+PolIII sub5----[CACC]
   CTTG                   CACA                   TGCC                   TCCG                   AGTG                          CACC 
```

**Set fidelity:** 0.8272 (6 overhangs)

---

### Tile 4 of 35 -- Codons 153-217 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGGT     | 0.6250   |
| oh2 (3' boundary) | CCAG     | 0.6122   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 474 nt | ATGG  | AGGT  |
| 2   | Oligo pool      | Tile 4 (12810 oligos) | 251 nt | AGGT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[AGGT]----oligo+BC----[AGAA]
   ATGG                    AGGT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1     | 162 nt  | CCAG  | CACA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1662 nt | CACA  | TGCC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1518 nt | TGCC  | TCCG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | TCCG  | AGTG  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCAG]----3'WT sub1----[CACA]----3'WT sub2----[TGCC]----3'WT sub3----[TCCG]----3'WT sub4----[AGTG]----3'WT+PolIII sub5----[CACC]
   CCAG                   CACA                   TGCC                   TCCG                   AGTG                          CACC 
```

**Set fidelity:** 0.8272 (6 overhangs)

---

### Tile 5 of 35 -- Codons 214-265 (156 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGCC     | 0.4644   |
| oh2 (3' boundary) | CACA     | 0.6141   |

**Variants:** 10080 mutations, 10080 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 657 nt | ATGG  | AGCC  |
| 2   | Oligo pool      | Tile 5 (10080 oligos) | 212 nt | AGCC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[AGCC]----oligo+BC----[AGAA]
   ATGG                    AGCC                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1662 nt | CACA  | TGCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1518 nt | TGCC  | TCCG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | TCCG  | AGTG  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CACA]----3'WT sub1----[TGCC]----3'WT sub2----[TCCG]----3'WT sub3----[AGTG]----3'WT+PolIII sub4----[CACC]
   CACA                   TGCC                   TCCG                   AGTG                          CACC 
```

**Set fidelity:** 0.8272 (5 overhangs)

---

### Tile 6 of 35 -- Codons 266-333 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACTT     | 0.7315   |
| oh2 (3' boundary) | TAAA     | 0.9392   |

**Variants:** 13440 mutations, 13440 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1   | 813 nt | ATGG  | ACTT  |
| 2   | Oligo pool      | Tile 6 (13440 oligos) | 260 nt | ACTT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[ACTT]----oligo+BC----[AGAA]
   ATGG                    ACTT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1     | 1458 nt | TAAA  | TGCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1518 nt | TGCC  | TCCG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | TCCG  | AGTG  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAAA]----3'WT sub1----[TGCC]----3'WT sub2----[TCCG]----3'WT sub3----[AGTG]----3'WT+PolIII sub4----[CACC]
   TAAA                   TGCC                   TCCG                   AGTG                          CACC 
```

**Set fidelity:** 0.9933 (5 overhangs)

---

### Tile 7 of 35 -- Codons 330-397 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAG     | 0.7511   |
| oh2 (3' boundary) | ATTC     | 0.7084   |

**Variants:** 13440 mutations, 13440 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7_sub1   | 1005 nt | ATGG  | AAAG  |
| 2   | Oligo pool      | Tile 7 (13440 oligos) | 260 nt  | AAAG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[AAAG]----oligo+BC----[AGAA]
   ATGG                    AAAG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1     | 1266 nt | ATTC  | TGCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1518 nt | TGCC  | TCCG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | TCCG  | AGTG  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATTC]----3'WT sub1----[TGCC]----3'WT sub2----[TCCG]----3'WT sub3----[AGTG]----3'WT+PolIII sub4----[CACC]
   ATTC                   TGCC                   TCCG                   AGTG                          CACC 
```

**Set fidelity:** 0.9933 (5 overhangs)

---

### Tile 8 of 35 -- Codons 394-449 (168 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAT     | 0.8102   |
| oh2 (3' boundary) | CTCT     | 0.6347   |

**Variants:** 10920 mutations, 10920 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1   | 809 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile8_sub2   | 406 nt | CACA  | TCAT  |
| 3   | Oligo pool      | Tile 8 (10920 oligos) | 224 nt | TCAT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TCAT]----oligo+BC----[AGAA]
   ATGG                   CACA                   TCAT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1     | 1110 nt | CTCT  | TGCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1518 nt | TGCC  | TCCG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | TCCG  | AGTG  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTCT]----3'WT sub1----[TGCC]----3'WT sub2----[TCCG]----3'WT sub3----[AGTG]----3'WT+PolIII sub4----[CACC]
   CTCT                   TGCC                   TCCG                   AGTG                          CACC 
```

**Set fidelity:** 0.9878 (5 overhangs)

---

### Tile 9 of 35 -- Codons 446-513 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAT     | 0.8673   |
| oh2 (3' boundary) | CAGT     | 0.6512   |

**Variants:** 13440 mutations, 13440 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1   | 809 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile9_sub2   | 562 nt | CACA  | TTAT  |
| 3   | Oligo pool      | Tile 9 (13440 oligos) | 260 nt | TTAT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TTAT]----oligo+BC----[AGAA]
   ATGG                   CACA                   TTAT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1     | 918 nt  | CAGT  | TGCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1518 nt | TGCC  | TCCG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | TCCG  | AGTG  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAGT]----3'WT sub1----[TGCC]----3'WT sub2----[TCCG]----3'WT sub3----[AGTG]----3'WT+PolIII sub4----[CACC]
   CAGT                   TGCC                   TCCG                   AGTG                          CACC 
```

**Set fidelity:** 0.9933 (5 overhangs)

---

### Tile 10 of 35 -- Codons 510-586 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATA     | 0.8816   |
| oh2 (3' boundary) | ATCT     | 0.7151   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 809 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile10_sub2   | 754 nt | CACA  | AATA  |
| 3   | Oligo pool      | Tile 10 (15330 oligos) | 287 nt | AATA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --     | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --     | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[AATA]----oligo+BC----[AGAA]
   ATGG                   CACA                   AATA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1    | 699 nt  | ATCT  | TGCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1518 nt | TGCC  | TCCG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | TCCG  | AGTG  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATCT]----3'WT sub1----[TGCC]----3'WT sub2----[TCCG]----3'WT sub3----[AGTG]----3'WT+PolIII sub4----[CACC]
   ATCT                   TGCC                   TCCG                   AGTG                          CACC 
```

**Set fidelity:** 0.9933 (5 overhangs)

---

### Tile 11 of 35 -- Codons 583-657 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAG     | 0.8480   |
| oh2 (3' boundary) | GGAG     | 0.5228   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 809 nt | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile11_sub2   | 973 nt | CACA  | TTAG  |
| 3   | Oligo pool      | Tile 11 (14910 oligos) | 281 nt | TTAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --     | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --     | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TTAG]----oligo+BC----[AGAA]
   ATGG                   CACA                   TTAG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1    | 486 nt  | GGAG  | TGCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1518 nt | TGCC  | TCCG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | TCCG  | AGTG  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAG]----3'WT sub1----[TGCC]----3'WT sub2----[TCCG]----3'WT sub3----[AGTG]----3'WT+PolIII sub4----[CACC]
   GGAG                   TGCC                   TCCG                   AGTG                          CACC 
```

**Set fidelity:** 0.9933 (5 overhangs)

---

### Tile 12 of 35 -- Codons 654-724 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTTG     | 0.7594   |
| oh2 (3' boundary) | TGTG     | 0.5408   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 809 nt  | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2   | 1186 nt | CACA  | CTTG  |
| 3   | Oligo pool      | Tile 12 (14070 oligos) | 269 nt  | CTTG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[CTTG]----oligo+BC----[AGAA]
   ATGG                   CACA                   CTTG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1    | 1785 nt | TGTG  | TCCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | TCCG  | AGTG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGTG]----3'WT sub1----[TCCG]----3'WT sub2----[AGTG]----3'WT+PolIII sub3----[CACC]
   TGTG                   TCCG                   AGTG                          CACC 
```

**Set fidelity:** 0.7583 (4 overhangs)

---

### Tile 13 of 35 -- Codons 721-778 (174 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTA     | 0.8892   |
| oh2 (3' boundary) | GGTG     | 0.4454   |

**Variants:** 11340 mutations, 11340 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 809 nt  | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 1387 nt | CACA  | TCTA  |
| 3   | Oligo pool      | Tile 13 (11340 oligos) | 230 nt  | TCTA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TCTA]----oligo+BC----[AGAA]
   ATGG                   CACA                   TCTA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1    | 1623 nt | GGTG  | TCCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | TCCG  | AGTG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGTG]----3'WT sub1----[TCCG]----3'WT sub2----[AGTG]----3'WT+PolIII sub3----[CACC]
   GGTG                   TCCG                   AGTG                          CACC 
```

**Set fidelity:** 0.7940 (4 overhangs)

---

### Tile 14 of 35 -- Codons 775-813 (117 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGAA     | 0.7463   |
| oh2 (3' boundary) | TGCC     | 0.5867   |

**Variants:** 7350 mutations, 7350 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1   | 809 nt  | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2  | 1549 nt | CACA  | GGAA  |
| 3   | Oligo pool      | Tile 14 (7350 oligos) | 173 nt  | GGAA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[GGAA]----oligo+BC----[AGAA]
   ATGG                   CACA                   GGAA                  AGAA 
```

**Set fidelity:** 0.9472 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1518 nt | TGCC  | TCCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | TCCG  | AGTG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGCC]----3'WT sub1----[TCCG]----3'WT sub2----[AGTG]----3'WT+PolIII sub3----[CACC]
   TGCC                   TCCG                   AGTG                          CACC 
```

**Set fidelity:** 0.9933 (4 overhangs)

---

### Tile 15 of 35 -- Codons 814-886 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGTG     | 0.4454   |
| oh2 (3' boundary) | GTCA     | 0.5915   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 809 nt  | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1666 nt | CACA  | GGTG  |
| 3   | Oligo pool      | Tile 15 (14490 oligos) | 275 nt  | GGTG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[GGTG]----oligo+BC----[AGAA]
   ATGG                   CACA                   GGTG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1    | 1299 nt | GTCA  | TCCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | TCCG  | AGTG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GTCA]----3'WT sub1----[TCCG]----3'WT sub2----[AGTG]----3'WT+PolIII sub3----[CACC]
   GTCA                   TCCG                   AGTG                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 16 of 35 -- Codons 883-950 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATAG     | 0.7330   |
| oh2 (3' boundary) | GAGC     | 0.5446   |

**Variants:** 13440 mutations, 13440 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 809 nt  | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1662 nt | CACA  | TGCC  |
| 3   | 5'WT gene block | bsai_5wt_tile16_sub3   | 229 nt  | TGCC  | ATAG  |
| 4   | Oligo pool      | Tile 16 (13440 oligos) | 260 nt  | ATAG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TGCC]----5'WT sub3----[ATAG]----oligo+BC----[AGAA]
   ATGG                   CACA                   TGCC                   ATAG                  AGAA 
```

**Set fidelity:** 0.9376 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1    | 1107 nt | GAGC  | TCCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | TCCG  | AGTG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAGC]----3'WT sub1----[TCCG]----3'WT sub2----[AGTG]----3'WT+PolIII sub3----[CACC]
   GAGC                   TCCG                   AGTG                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 17 of 35 -- Codons 947-1016 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTA     | 0.7818   |
| oh2 (3' boundary) | CCTA     | 0.6679   |

**Variants:** 13860 mutations, 13860 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 809 nt  | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1662 nt | CACA  | TGCC  |
| 3   | 5'WT gene block | bsai_5wt_tile17_sub3   | 421 nt  | TGCC  | ATTA  |
| 4   | Oligo pool      | Tile 17 (13860 oligos) | 266 nt  | ATTA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TGCC]----5'WT sub3----[ATTA]----oligo+BC----[AGAA]
   ATGG                   CACA                   TGCC                   ATTA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1    | 909 nt  | CCTA  | TCCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | TCCG  | AGTG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTA]----3'WT sub1----[TCCG]----3'WT sub2----[AGTG]----3'WT+PolIII sub3----[CACC]
   CCTA                   TCCG                   AGTG                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 18 of 35 -- Codons 1013-1054 (126 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTA     | 0.8892   |
| oh2 (3' boundary) | CTTG     | 0.7594   |

**Variants:** 7980 mutations, 7980 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1   | 809 nt  | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1662 nt | CACA  | TGCC  |
| 3   | 5'WT gene block | bsai_5wt_tile18_sub3  | 619 nt  | TGCC  | TCTA  |
| 4   | Oligo pool      | Tile 18 (7980 oligos) | 182 nt  | TCTA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TGCC]----5'WT sub3----[TCTA]----oligo+BC----[AGAA]
   ATGG                   CACA                   TGCC                   TCTA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1    | 795 nt  | CTTG  | TCCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | TCCG  | AGTG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTTG]----3'WT sub1----[TCCG]----3'WT sub2----[AGTG]----3'WT+PolIII sub3----[CACC]
   CTTG                   TCCG                   AGTG                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 19 of 35 -- Codons 1051-1117 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATA     | 0.8816   |
| oh2 (3' boundary) | AACT     | 0.6635   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 809 nt  | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1662 nt | CACA  | TGCC  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3   | 733 nt  | TGCC  | AATA  |
| 4   | Oligo pool      | Tile 19 (13230 oligos) | 257 nt  | AATA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TGCC]----5'WT sub3----[AATA]----oligo+BC----[AGAA]
   ATGG                   CACA                   TGCC                   AATA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1    | 606 nt  | AACT  | TCCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | TCCG  | AGTG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AACT]----3'WT sub1----[TCCG]----3'WT sub2----[AGTG]----3'WT+PolIII sub3----[CACC]
   AACT                   TCCG                   AGTG                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 20 of 35 -- Codons 1114-1179 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAT     | 0.7246   |
| oh2 (3' boundary) | CCCA     | 0.6687   |

**Variants:** 13020 mutations, 13020 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 809 nt  | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1662 nt | CACA  | TGCC  |
| 3   | 5'WT gene block | bsai_5wt_tile20_sub3   | 922 nt  | TGCC  | GAAT  |
| 4   | Oligo pool      | Tile 20 (13020 oligos) | 254 nt  | GAAT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TGCC]----5'WT sub3----[GAAT]----oligo+BC----[AGAA]
   ATGG                   CACA                   TGCC                   GAAT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1    | 420 nt  | CCCA  | TCCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | TCCG  | AGTG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCCA]----3'WT sub1----[TCCG]----3'WT sub2----[AGTG]----3'WT+PolIII sub3----[CACC]
   CCCA                   TCCG                   AGTG                          CACC 
```

**Set fidelity:** 0.9986 (4 overhangs)

---

### Tile 21 of 35 -- Codons 1176-1221 (138 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGTA     | 0.7286   |
| oh2 (3' boundary) | AGAA     | 0.8847   |

**Variants:** 8820 mutations, 8820 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1   | 809 nt  | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1662 nt | CACA  | TGCC  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3  | 1108 nt | TGCC  | AGTA  |
| 4   | Oligo pool      | Tile 21 (8820 oligos) | 194 nt  | AGTA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TGCC]----5'WT sub3----[AGTA]----oligo+BC----[AGAA]
   ATGG                   CACA                   TGCC                   AGTA                  AGAA 
```

**Set fidelity:** 0.9712 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1    | 294 nt  | AGAA  | TCCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | TCCG  | AGTG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAA]----3'WT sub1----[TCCG]----3'WT sub2----[AGTG]----3'WT+PolIII sub3----[CACC]
   AGAA                   TCCG                   AGTG                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 22 of 35 -- Codons 1218-1269 (156 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAG     | 0.8480   |
| oh2 (3' boundary) | GAAA     | 0.8745   |

**Variants:** 10080 mutations, 10080 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 809 nt  | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1662 nt | CACA  | TGCC  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1234 nt | TGCC  | TTAG  |
| 4   | Oligo pool      | Tile 22 (10080 oligos) | 212 nt  | TTAG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TGCC]----5'WT sub3----[TTAG]----oligo+BC----[AGAA]
   ATGG                   CACA                   TGCC                   TTAG                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1    | 150 nt  | GAAA  | TCCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | TCCG  | AGTG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAA]----3'WT sub1----[TCCG]----3'WT sub2----[AGTG]----3'WT+PolIII sub3----[CACC]
   GAAA                   TCCG                   AGTG                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 23 of 35 -- Codons 1266-1313 (144 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAG     | 0.6752   |
| oh2 (3' boundary) | TCCG     | 0.7234   |

**Variants:** 9240 mutations, 9240 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1   | 809 nt  | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1662 nt | CACA  | TGCC  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3  | 1378 nt | TGCC  | GAAG  |
| 4   | Oligo pool      | Tile 23 (9240 oligos) | 200 nt  | GAAG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TGCC]----5'WT sub3----[GAAG]----oligo+BC----[AGAA]
   ATGG                   CACA                   TGCC                   GAAG                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | TCCG  | AGTG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCCG]----3'WT sub1----[AGTG]----3'WT+PolIII sub2----[CACC]
   TCCG                   AGTG                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 24 of 35 -- Codons 1314-1353 (120 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAG     | 0.6752   |
| oh2 (3' boundary) | AGGT     | 0.6250   |

**Variants:** 7560 mutations, 7560 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1   | 809 nt  | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1662 nt | CACA  | TGCC  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3  | 1522 nt | TGCC  | GAAG  |
| 4   | Oligo pool      | Tile 24 (7560 oligos) | 176 nt  | GAAG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TGCC]----5'WT sub3----[GAAG]----oligo+BC----[AGAA]
   ATGG                   CACA                   TGCC                   GAAG                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile24_sub1    | 1587 nt | AGGT  | AGTG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGGT]----3'WT sub1----[AGTG]----3'WT+PolIII sub2----[CACC]
   AGGT                   AGTG                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 25 of 35 -- Codons 1350-1408 (177 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTC     | 0.7084   |
| oh2 (3' boundary) | GTTT     | 0.5873   |

**Variants:** 11550 mutations, 11550 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 809 nt  | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1662 nt | CACA  | TGCC  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3   | 1630 nt | TGCC  | ATTC  |
| 4   | Oligo pool      | Tile 25 (11550 oligos) | 233 nt  | ATTC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TGCC]----5'WT sub3----[ATTC]----oligo+BC----[AGAA]
   ATGG                   CACA                   TGCC                   ATTC                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile25_sub1    | 1422 nt | GTTT  | AGTG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GTTT]----3'WT sub1----[AGTG]----3'WT+PolIII sub2----[CACC]
   GTTT                   AGTG                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 26 of 35 -- Codons 1405-1470 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACAA     | 0.8919   |
| oh2 (3' boundary) | GACA     | 0.6127   |

**Variants:** 13020 mutations, 13020 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 809 nt  | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1662 nt | CACA  | TGCC  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3   | 1795 nt | TGCC  | ACAA  |
| 4   | Oligo pool      | Tile 26 (13020 oligos) | 254 nt  | ACAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TGCC]----5'WT sub3----[ACAA]----oligo+BC----[AGAA]
   ATGG                   CACA                   TGCC                   ACAA                  AGAA 
```

**Set fidelity:** 0.9907 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile26_sub1    | 1236 nt | GACA  | AGTG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GACA]----3'WT sub1----[AGTG]----3'WT+PolIII sub2----[CACC]
   GACA                   AGTG                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 27 of 35 -- Codons 1467-1512 (138 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAG     | 0.7511   |
| oh2 (3' boundary) | ACAA     | 0.8919   |

**Variants:** 8820 mutations, 8820 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1   | 809 nt  | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1662 nt | CACA  | TGCC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3  | 1518 nt | TGCC  | TCCG  |
| 4   | 5'WT gene block | bsai_5wt_tile27_sub4  | 481 nt  | TCCG  | AAAG  |
| 5   | Oligo pool      | Tile 27 (8820 oligos) | 194 nt  | AAAG  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TGCC]----5'WT sub3----[TCCG]----5'WT sub4----[AAAG]----oligo+BC----[AGAA]
   ATGG                   CACA                   TGCC                   TCCG                   AAAG                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile27_sub1    | 1110 nt | ACAA  | AGTG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACAA]----3'WT sub1----[AGTG]----3'WT+PolIII sub2----[CACC]
   ACAA                   AGTG                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 28 of 35 -- Codons 1509-1557 (147 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGT     | 0.7629   |
| oh2 (3' boundary) | GTTC     | 0.5976   |

**Variants:** 9450 mutations, 9450 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1   | 809 nt  | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1662 nt | CACA  | TGCC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3  | 1518 nt | TGCC  | TCCG  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4  | 607 nt  | TCCG  | AAGT  |
| 5   | Oligo pool      | Tile 28 (9450 oligos) | 203 nt  | AAGT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TGCC]----5'WT sub3----[TCCG]----5'WT sub4----[AAGT]----oligo+BC----[AGAA]
   ATGG                   CACA                   TGCC                   TCCG                   AAGT                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile28_sub1    | 975 nt  | GTTC  | AGTG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GTTC]----3'WT sub1----[AGTG]----3'WT+PolIII sub2----[CACC]
   GTTC                   AGTG                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 29 of 35 -- Codons 1554-1630 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTAA     | 0.8691   |
| oh2 (3' boundary) | TCAT     | 0.8102   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 809 nt  | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1662 nt | CACA  | TGCC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1518 nt | TGCC  | TCCG  |
| 4   | 5'WT gene block | bsai_5wt_tile29_sub4   | 742 nt  | TCCG  | CTAA  |
| 5   | Oligo pool      | Tile 29 (15330 oligos) | 287 nt  | CTAA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TGCC]----5'WT sub3----[TCCG]----5'WT sub4----[CTAA]----oligo+BC----[AGAA]
   ATGG                   CACA                   TGCC                   TCCG                   CTAA                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile29_sub1    | 756 nt  | TCAT  | AGTG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAT]----3'WT sub1----[AGTG]----3'WT+PolIII sub2----[CACC]
   TCAT                   AGTG                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 30 of 35 -- Codons 1627-1657 (93 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TATC     | 0.8041   |
| oh2 (3' boundary) | AAAA     | 0.9502   |

**Variants:** 5670 mutations, 5670 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1   | 809 nt  | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1662 nt | CACA  | TGCC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3  | 1518 nt | TGCC  | TCCG  |
| 4   | 5'WT gene block | bsai_5wt_tile30_sub4  | 961 nt  | TCCG  | TATC  |
| 5   | Oligo pool      | Tile 30 (5670 oligos) | 149 nt  | TATC  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TGCC]----5'WT sub3----[TCCG]----5'WT sub4----[TATC]----oligo+BC----[AGAA]
   ATGG                   CACA                   TGCC                   TCCG                   TATC                  AGAA 
```

**Set fidelity:** 0.9962 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile30_sub1    | 675 nt  | AAAA  | AGTG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAA]----3'WT sub1----[AGTG]----3'WT+PolIII sub2----[CACC]
   AAAA                   AGTG                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 31 of 35 -- Codons 1654-1730 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATAG     | 0.7330   |
| oh2 (3' boundary) | TGGT     | 0.5839   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 809 nt  | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1662 nt | CACA  | TGCC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1518 nt | TGCC  | TCCG  |
| 4   | 5'WT gene block | bsai_5wt_tile31_sub4   | 1042 nt | TCCG  | ATAG  |
| 5   | Oligo pool      | Tile 31 (15330 oligos) | 287 nt  | ATAG  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TGCC]----5'WT sub3----[TCCG]----5'WT sub4----[ATAG]----oligo+BC----[AGAA]
   ATGG                   CACA                   TGCC                   TCCG                   ATAG                  AGAA 
```

**Set fidelity:** 0.9376 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile31_sub1    | 456 nt  | TGGT  | AGTG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGGT]----3'WT sub1----[AGTG]----3'WT+PolIII sub2----[CACC]
   TGGT                   AGTG                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 32 of 35 -- Codons 1727-1782 (168 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGTA     | 0.7286   |
| oh2 (3' boundary) | CAGT     | 0.6512   |

**Variants:** 10920 mutations, 10920 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 809 nt  | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1662 nt | CACA  | TGCC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1518 nt | TGCC  | TCCG  |
| 4   | 5'WT gene block | bsai_5wt_tile32_sub4   | 1261 nt | TCCG  | AGTA  |
| 5   | Oligo pool      | Tile 32 (10920 oligos) | 224 nt  | AGTA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TGCC]----5'WT sub3----[TCCG]----5'WT sub4----[AGTA]----oligo+BC----[AGAA]
   ATGG                   CACA                   TGCC                   TCCG                   AGTA                  AGAA 
```

**Set fidelity:** 0.9712 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile32_sub1    | 300 nt  | CAGT  | AGTG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAGT]----3'WT sub1----[AGTG]----3'WT+PolIII sub2----[CACC]
   CAGT                   AGTG                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 33 of 35 -- Codons 1779-1815 (111 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAT     | 0.8673   |
| oh2 (3' boundary) | GCCA     | 0.5727   |

**Variants:** 6930 mutations, 6930 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1   | 809 nt  | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1662 nt | CACA  | TGCC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3  | 1518 nt | TGCC  | TCCG  |
| 4   | 5'WT gene block | bsai_5wt_tile33_sub4  | 1417 nt | TCCG  | TTAT  |
| 5   | Oligo pool      | Tile 33 (6930 oligos) | 167 nt  | TTAT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TGCC]----5'WT sub3----[TCCG]----5'WT sub4----[TTAT]----oligo+BC----[AGAA]
   ATGG                   CACA                   TGCC                   TCCG                   TTAT                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile33_sub1    | 1373 nt | GCCA  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCCA]----3'WT+PolIII----[CACC]
   GCCA                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 34 of 35 -- Codons 1812-1876 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTA     | 0.7818   |
| oh2 (3' boundary) | AGTG     | 0.5190   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1    | 809 nt  | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1662 nt | CACA  | TGCC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1518 nt | TGCC  | TCCG  |
| 4   | 5'WT gene block | bsai_5wt_tile34_sub4   | 1516 nt | TCCG  | ATTA  |
| 5   | Oligo pool      | Tile 34 (12810 oligos) | 251 nt  | ATTA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TGCC]----5'WT sub3----[TCCG]----5'WT sub4----[ATTA]----oligo+BC----[AGAA]
   ATGG                   CACA                   TGCC                   TCCG                   ATTA                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | AGTG  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGTG]----3'WT+PolIII----[CACC]
   AGTG                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 35 of 35 -- Codons 1877-1902 (78 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACT     | 0.7445   |
| oh2 (3' boundary) | ATAG     | 0.7330   |

**Variants:** 4620 mutations, 4620 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1   | 809 nt  | ATGG  | CACA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1662 nt | CACA  | TGCC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3  | 1518 nt | TGCC  | TCCG  |
| 4   | 5'WT gene block | bsai_5wt_tile35_sub4  | 1711 nt | TCCG  | TACT  |
| 5   | Oligo pool      | Tile 35 (4620 oligos) | 134 nt  | TACT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CACA]----5'WT sub2----[TGCC]----5'WT sub3----[TCCG]----5'WT sub4----[TACT]----oligo+BC----[AGAA]
   ATGG                   CACA                   TGCC                   TCCG                   TACT                  AGAA 
```

**Set fidelity:** 0.9984 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component            | Part name                | Length  | 5' OH | 3' OH |
| --- | -------------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product         | (in helper plasmid)      | --      | --    | --    |
| 2   | PolIII-only fragment | bsmbi_polIII_tile35      | 1112 nt | ATAG  | CACC  |
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

**Total blocks:** 72

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| --------------------- | ----------- | ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| bsai_5wt_tile10_sub2  | 754         | BsaI        | 5wt_tile10_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile11_sub2  | 973         | BsaI        | 5wt_tile11_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile12_sub2  | 1186        | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile13_sub2  | 1387        | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile14_sub2  | 1549        | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile15_sub2  | 1666        | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile16_sub2  | 1662        | BsaI        | 5wt_tile16_sub2;5wt_tile17_sub2;5wt_tile18_sub2;5wt_tile19_sub2;5wt_tile20_sub2;5wt_tile21_sub2;5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2;5wt_tile26_sub2;5wt_tile27_sub2;5wt_tile28_sub2;5wt_tile29_sub2;5wt_tile30_sub2;5wt_tile31_sub2;5wt_tile32_sub2;5wt_tile33_sub2;5wt_tile34_sub2;5wt_tile35_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile16_sub3  | 229         | BsaI        | 5wt_tile16_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile17_sub3  | 421         | BsaI        | 5wt_tile17_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile18_sub3  | 619         | BsaI        | 5wt_tile18_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile19_sub3  | 733         | BsaI        | 5wt_tile19_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile2        | 138         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile20_sub3  | 922         | BsaI        | 5wt_tile20_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile21_sub3  | 1108        | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile22_sub3  | 1234        | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile23_sub3  | 1378        | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile24_sub3  | 1522        | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile25_sub3  | 1630        | BsaI        | 5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile26_sub3  | 1795        | BsaI        | 5wt_tile26_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile27_sub3  | 1518        | BsaI        | 5wt_tile27_sub3;5wt_tile28_sub3;5wt_tile29_sub3;5wt_tile30_sub3;5wt_tile31_sub3;5wt_tile32_sub3;5wt_tile33_sub3;5wt_tile34_sub3;5wt_tile35_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile27_sub4  | 481         | BsaI        | 5wt_tile27_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile28_sub4  | 607         | BsaI        | 5wt_tile28_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile29_sub4  | 742         | BsaI        | 5wt_tile29_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile3        | 360         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile30_sub4  | 961         | BsaI        | 5wt_tile30_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile31_sub4  | 1042        | BsaI        | 5wt_tile31_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile32_sub4  | 1261        | BsaI        | 5wt_tile32_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile33_sub4  | 1417        | BsaI        | 5wt_tile33_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile34_sub4  | 1516        | BsaI        | 5wt_tile34_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile35_sub4  | 1711        | BsaI        | 5wt_tile35_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile4        | 474         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile5        | 657         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile6_sub1   | 813         | BsaI        | 5wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile7_sub1   | 1005        | BsaI        | 5wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile8_sub1   | 809         | BsaI        | 5wt_tile8_sub1;5wt_tile9_sub1;5wt_tile10_sub1;5wt_tile11_sub1;5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1;5wt_tile26_sub1;5wt_tile27_sub1;5wt_tile28_sub1;5wt_tile29_sub1;5wt_tile30_sub1;5wt_tile31_sub1;5wt_tile32_sub1;5wt_tile33_sub1;5wt_tile34_sub1;5wt_tile35_sub1                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile8_sub2   | 406         | BsaI        | 5wt_tile8_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile9_sub2   | 562         | BsaI        | 5wt_tile9_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile1_sub1  | 681         | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile1_sub2  | 1662        | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile1_sub3  | 1518        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile8_sub2;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile1_sub4  | 1707        | BsmBI       | 3wt_tile1_sub4;3wt_tile2_sub4;3wt_tile3_sub4;3wt_tile4_sub4;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub3;3wt_tile9_sub3;3wt_tile10_sub3;3wt_tile11_sub3;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2;3wt_tile16_sub2;3wt_tile17_sub2;3wt_tile18_sub2;3wt_tile19_sub2;3wt_tile20_sub2;3wt_tile21_sub2;3wt_tile22_sub2;3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile1_sub5  | 1190        | BsmBI       | 3wt_polIII_tile1_sub5;3wt_polIII_tile2_sub5;3wt_polIII_tile3_sub5;3wt_polIII_tile4_sub5;3wt_polIII_tile5_sub4;3wt_polIII_tile6_sub4;3wt_polIII_tile7_sub4;3wt_polIII_tile8_sub4;3wt_polIII_tile9_sub4;3wt_polIII_tile10_sub4;3wt_polIII_tile11_sub4;3wt_polIII_tile12_sub3;3wt_polIII_tile13_sub3;3wt_polIII_tile14_sub3;3wt_polIII_tile15_sub3;3wt_polIII_tile16_sub3;3wt_polIII_tile17_sub3;3wt_polIII_tile18_sub3;3wt_polIII_tile19_sub3;3wt_polIII_tile20_sub3;3wt_polIII_tile21_sub3;3wt_polIII_tile22_sub3;3wt_polIII_tile23_sub2;3wt_polIII_tile24_sub2;3wt_polIII_tile25_sub2;3wt_polIII_tile26_sub2;3wt_polIII_tile27_sub2;3wt_polIII_tile28_sub2;3wt_polIII_tile29_sub2;3wt_polIII_tile30_sub2;3wt_polIII_tile31_sub2;3wt_polIII_tile32_sub2;3wt_polIII_tile34 |
| bsmbi_3wt_tile10_sub1 | 699         | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile11_sub1 | 486         | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile12_sub1 | 1785        | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile13_sub1 | 1623        | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile15_sub1 | 1299        | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile16_sub1 | 1107        | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile17_sub1 | 909         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile18_sub1 | 795         | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile19_sub1 | 606         | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile2_sub1  | 459         | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile20_sub1 | 420         | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile21_sub1 | 294         | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile22_sub1 | 150         | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile24_sub1 | 1587        | BsmBI       | 3wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile25_sub1 | 1422        | BsmBI       | 3wt_tile25_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile26_sub1 | 1236        | BsmBI       | 3wt_tile26_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile27_sub1 | 1110        | BsmBI       | 3wt_tile27_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile28_sub1 | 975         | BsmBI       | 3wt_tile28_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile29_sub1 | 756         | BsmBI       | 3wt_tile29_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile3_sub1  | 345         | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile30_sub1 | 675         | BsmBI       | 3wt_tile30_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile31_sub1 | 456         | BsmBI       | 3wt_tile31_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile32_sub1 | 300         | BsmBI       | 3wt_tile32_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile33_sub1 | 1373        | BsmBI       | 3wt_polIII_tile33_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile4_sub1  | 162         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile6_sub1  | 1458        | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile7_sub1  | 1266        | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile8_sub1  | 1110        | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile9_sub1  | 918         | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_polIII_tile35   | 1112        | BsmBI       | polIII_tile35                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |

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

