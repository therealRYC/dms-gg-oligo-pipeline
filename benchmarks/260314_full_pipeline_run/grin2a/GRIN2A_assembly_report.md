# DMS-GG Assembly Report: GRIN2A

Generated: 2026-03-14 13:49:27
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                          |
| -------------------- | ------------------------------------------------------------------------------ |
| Gene name            | GRIN2A_NM_000833.5 Human GRIN2A native CDS (NM_000833.5, NP_000824.1, 1464 aa) |
| CDS length           | 4395 nt (1465 codons)                                                          |
| Protein length       | 1464 aa                                                                        |
| Number of tiles      | 25                                                                             |
| Total variants       | 30513                                                                          |
| Total oligos         | 305130                                                                         |
| Oligo length range   | 152-290 nt                                                                     |
| Gene blocks to order | 52                                                                             |
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

**Total oligos:** 305130 | **Length range:** 152-290 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-78      | 15540  | 290 nt |
| 2    | 73-132    | 11340  | 236 nt |
| 3    | 127-166   | 7140   | 176 nt |
| 4    | 161-225   | 12390  | 251 nt |
| 5    | 220-271   | 9870   | 212 nt |
| 6    | 272-328   | 11130  | 227 nt |
| 7    | 323-399   | 14910  | 287 nt |
| 8    | 394-470   | 14910  | 287 nt |
| 9    | 465-530   | 12600  | 254 nt |
| 10   | 525-592   | 13020  | 260 nt |
| 11   | 587-637   | 9450   | 209 nt |
| 12   | 632-703   | 14070  | 272 nt |
| 13   | 704-779   | 15120  | 284 nt |
| 14   | 774-849   | 14700  | 284 nt |
| 15   | 844-905   | 11760  | 242 nt |
| 16   | 900-952   | 9870   | 215 nt |
| 17   | 947-1020  | 14280  | 278 nt |
| 18   | 1015-1054 | 7140   | 176 nt |
| 19   | 1049-1121 | 14070  | 275 nt |
| 20   | 1116-1174 | 11130  | 233 nt |
| 21   | 1169-1246 | 15120  | 290 nt |
| 22   | 1241-1272 | 5670   | 152 nt |
| 23   | 1273-1343 | 14070  | 269 nt |
| 24   | 1338-1415 | 15120  | 290 nt |
| 25   | 1410-1465 | 10710  | 224 nt |

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
| Total barcodes    | 305130                             |
| Unique barcodes   | 305130                             |
| GC content range  | 25% - 75%                          |
| GC content mean   | 47.9%                              |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                  | Description                                                   | Result | Detail                                                                                                                                               |
| ---------------------- | ------------------------------------------------------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths          | All oligos within synthesis length limit                      | PASS   | Range: 152-290 nt (limit: 300)                                                                                                                       |
| block_lengths          | All gene blocks within synthesis length limit                 | PASS   | Range: 213-1769 nt (limit: 1800)                                                                                                                     |
| barcode_junction_sites | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                              |
| barcode_uniqueness     | All barcodes are unique                                       | PASS   | 305130 unique / 305130 total                                                                                                                         |
| tile_coverage          | Tiles cover entire gene without gaps                          | PASS   | 4395 / 4395 nt covered                                                                                                                               |
| variant_count          | Expected number of variants generated                         | PASS   | 30513 unique variants (expected: 30513 across 1453/1463 mutable positions; 27607 missense + 1453 nonsense + 1453 wt_control; 10 position(s) skipped) |
| single_codon_change    | Each non-control variant differs by exactly one codon from WT | PASS   | 290600 / 290600 variants confirmed (WT controls excluded)                                                                                            |
| oligo_gc_content       | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 41.5-67.2% | 0 oligo(s) with extreme GC                                                                                                    |
| domestication_complete | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                              |
| overhang_fidelity      | Tile boundary overhangs have adequate fidelity                | FAIL   | 25 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                              |
| tile_manifests         | Per-tile assembly manifests complete                          | PASS   | 25 tile manifest(s) generated                                                                                                                        |
| helper_plasmid         | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                   |
| reaction_fidelity      | Per-reaction set-level overhang fidelity                      | PASS   | Min set fidelity: 0.8662 across 50 reactions | 1 reaction(s) below 0.90                                                                              |
| barcode_poliii_term    | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 305130 barcode(s) contain TTTT                                                                                                                   |
| block_min_length       | All gene blocks above synthesis minimum length                | FAIL   | 3 block(s) below 300 nt minimum. Range: 213-1769 nt                                                                                                  |
| sb_overhang_collisions | Superblock boundary overhangs are unique (no collisions)      | PASS   | 6 SB boundary OH(s), all unique                                                                                                                      |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 5         | 0.9298             |
| 2    | 3        | 1.0000            | 5         | 1.0000             |
| 3    | 3        | 1.0000            | 5         | 1.0000             |
| 4    | 3        | 1.0000            | 4         | 1.0000             |
| 5    | 3        | 1.0000            | 4         | 1.0000             |
| 6    | 3        | 1.0000            | 4         | 1.0000             |
| 7    | 3        | 1.0000            | 4         | 0.9978             |
| 8    | 4        | 1.0000            | 4         | 1.0000             |
| 9    | 4        | 1.0000            | 4         | 0.9984             |
| 10   | 4        | 1.0000            | 4         | 1.0000             |
| 11   | 4        | 1.0000            | 4         | 1.0000             |
| 12   | 4        | 1.0000            | 3         | 1.0000             |
| 13   | 4        | 1.0000            | 3         | 1.0000             |
| 14   | 4        | 1.0000            | 3         | 1.0000             |
| 15   | 5        | 1.0000            | 3         | 1.0000             |
| 16   | 5        | 1.0000            | 3         | 1.0000             |
| 17   | 5        | 1.0000            | 3         | 1.0000             |
| 18   | 5        | 1.0000            | 3         | 1.0000             |
| 19   | 5        | 1.0000            | 3         | 1.0000             |
| 20   | 5        | 1.0000            | 3         | 0.8662             |
| 21   | 5        | 1.0000            | 2         | 1.0000             |
| 22   | 5        | 1.0000            | 2         | 1.0000             |
| 23   | 5        | 1.0000            | 2         | 1.0000             |
| 24   | 6        | 1.0000            | 2         | 1.0000             |
| 25   | 6        | 1.0000            | 2         | 1.0000             |

**Min:** 0.8662 | **Max:** 1.0000 | **Mean:** 0.9958

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

### Tile 1 of 25 -- Codons 1-78 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGG     | 0.5393   |
| oh2 (3' boundary) | CACG     | 0.4648   |

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
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1     | 615 nt  | CACG  | CATT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1314 nt | CATT  | TAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1725 nt | TAAT  | TCAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1673 nt | TCAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CACG]----3'WT sub1----[CATT]----3'WT sub2----[TAAT]----3'WT sub3----[TCAA]----3'WT+PolIII sub4----[CACC]
   CACG                   CATT                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 0.9298 (5 overhangs)

---

### Tile 2 of 25 -- Codons 73-132 (180 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTGA     | 0.6791   |
| oh2 (3' boundary) | CAAG     | 0.6640   |

**Variants:** 11340 mutations, 11340 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 234 nt | ATGG  | CTGA  |
| 2   | Oligo pool      | Tile 2 (11340 oligos) | 236 nt | CTGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[CTGA]----oligo+BC----[AGAA]
   ATGG                    CTGA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1     | 453 nt  | CAAG  | CATT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1314 nt | CATT  | TAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1725 nt | TAAT  | TCAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1673 nt | TCAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAG]----3'WT sub1----[CATT]----3'WT sub2----[TAAT]----3'WT sub3----[TCAA]----3'WT+PolIII sub4----[CACC]
   CAAG                   CATT                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 3 of 25 -- Codons 127-166 (120 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTC     | 0.7084   |
| oh2 (3' boundary) | CCTG     | 0.6383   |

**Variants:** 7140 mutations, 7140 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 396 nt | ATGG  | ATTC  |
| 2   | Oligo pool      | Tile 3 (7140 oligos)  | 176 nt | ATTC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[ATTC]----oligo+BC----[AGAA]
   ATGG                    ATTC                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1     | 351 nt  | CCTG  | CATT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1314 nt | CATT  | TAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1725 nt | TAAT  | TCAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1673 nt | TCAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTG]----3'WT sub1----[CATT]----3'WT sub2----[TAAT]----3'WT sub3----[TCAA]----3'WT+PolIII sub4----[CACC]
   CCTG                   CATT                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 4 of 25 -- Codons 161-225 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCA     | 0.7483   |
| oh2 (3' boundary) | CTGT     | 0.6476   |

**Variants:** 12390 mutations, 12390 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 498 nt | ATGG  | ATCA  |
| 2   | Oligo pool      | Tile 4 (12390 oligos) | 251 nt | ATCA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[ATCA]----oligo+BC----[AGAA]
   ATGG                    ATCA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1     | 1470 nt | CTGT  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1725 nt | TAAT  | TCAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1673 nt | TCAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTGT]----3'WT sub1----[TAAT]----3'WT sub2----[TCAA]----3'WT+PolIII sub3----[CACC]
   CTGT                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 5 of 25 -- Codons 220-271 (156 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | CATT     | 0.6770   |

**Variants:** 9870 mutations, 9870 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 675 nt | ATGG  | AAGA  |
| 2   | Oligo pool      | Tile 5 (9870 oligos)  | 212 nt | AAGA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1     | 1332 nt | CATT  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1725 nt | TAAT  | TCAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1673 nt | TCAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CATT]----3'WT sub1----[TAAT]----3'WT sub2----[TCAA]----3'WT+PolIII sub3----[CACC]
   CATT                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 6 of 25 -- Codons 272-328 (171 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTTC     | 0.8348   |
| oh2 (3' boundary) | CTTG     | 0.7594   |

**Variants:** 11130 mutations, 11130 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 831 nt | ATGG  | TTTC  |
| 2   | Oligo pool      | Tile 6 (11130 oligos) | 227 nt | TTTC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[TTTC]----oligo+BC----[AGAA]
   ATGG                    TTTC                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1     | 1161 nt | CTTG  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1725 nt | TAAT  | TCAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1673 nt | TCAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTTG]----3'WT sub1----[TAAT]----3'WT sub2----[TCAA]----3'WT+PolIII sub3----[CACC]
   CTTG                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 7 of 25 -- Codons 323-399 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGA     | 0.8175   |
| oh2 (3' boundary) | CCAT     | 0.6470   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7_sub1   | 984 nt | ATGG  | CAGA  |
| 2   | Oligo pool      | Tile 7 (14910 oligos) | 287 nt | CAGA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1     | 948 nt  | CCAT  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1725 nt | TAAT  | TCAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1673 nt | TCAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCAT]----3'WT sub1----[TAAT]----3'WT sub2----[TCAA]----3'WT+PolIII sub3----[CACC]
   CCAT                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 0.9978 (4 overhangs)

---

### Tile 8 of 25 -- Codons 394-470 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGT     | 0.7629   |
| oh2 (3' boundary) | CGAC     | 0.4695   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 831 nt | ATGG  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile8_sub2   | 384 nt | TTTC  | AAGT  |
| 3   | Oligo pool      | Tile 8 (14910 oligos) | 287 nt | AAGT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT sub1----[TTTC]----5'WT sub2----[AAGT]----oligo+BC----[AGAA]
   ATGG                   TTTC                   AAGT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1     | 735 nt  | CGAC  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1725 nt | TAAT  | TCAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1673 nt | TCAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CGAC]----3'WT sub1----[TAAT]----3'WT sub2----[TCAA]----3'WT+PolIII sub3----[CACC]
   CGAC                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 9 of 25 -- Codons 465-530 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | CATG     | 0.6046   |

**Variants:** 12600 mutations, 12600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 831 nt | ATGG  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile9_sub2   | 597 nt | TTTC  | AAGA  |
| 3   | Oligo pool      | Tile 9 (12600 oligos) | 254 nt | AAGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT sub1----[TTTC]----5'WT sub2----[AAGA]----oligo+BC----[AGAA]
   ATGG                   TTTC                   AAGA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1     | 555 nt  | CATG  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1725 nt | TAAT  | TCAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1673 nt | TCAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CATG]----3'WT sub1----[TAAT]----3'WT sub2----[TCAA]----3'WT+PolIII sub3----[CACC]
   CATG                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 0.9984 (4 overhangs)

---

### Tile 10 of 25 -- Codons 525-592 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTG     | 0.6684   |
| oh2 (3' boundary) | TTCT     | 0.8181   |

**Variants:** 13020 mutations, 13020 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6         | 831 nt | ATGG  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile10_sub2   | 777 nt | TTTC  | TCTG  |
| 3   | Oligo pool      | Tile 10 (13020 oligos) | 260 nt | TCTG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --     | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --     | --    | --    |

```
  [ATGG]----5'WT sub1----[TTTC]----5'WT sub2----[TCTG]----oligo+BC----[AGAA]
   ATGG                   TTTC                   TCTG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1    | 369 nt  | TTCT  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1725 nt | TAAT  | TCAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1673 nt | TCAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCT]----3'WT sub1----[TAAT]----3'WT sub2----[TCAA]----3'WT+PolIII sub3----[CACC]
   TTCT                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 11 of 25 -- Codons 587-637 (153 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AACT     | 0.6635   |
| oh2 (3' boundary) | GGCT     | 0.4697   |

**Variants:** 9450 mutations, 9450 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 831 nt | ATGG  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile11_sub2  | 963 nt | TTTC  | AACT  |
| 3   | Oligo pool      | Tile 11 (9450 oligos) | 209 nt | AACT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT sub1----[TTTC]----5'WT sub2----[AACT]----oligo+BC----[AGAA]
   ATGG                   TTTC                   AACT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1    | 234 nt  | GGCT  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1725 nt | TAAT  | TCAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1673 nt | TCAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGCT]----3'WT sub1----[TAAT]----3'WT sub2----[TCAA]----3'WT+PolIII sub3----[CACC]
   GGCT                   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 12 of 25 -- Codons 632-703 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTG     | 0.6684   |
| oh2 (3' boundary) | TAAT     | 0.8165   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6         | 831 nt  | ATGG  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2   | 1098 nt | TTTC  | TCTG  |
| 3   | Oligo pool      | Tile 12 (14070 oligos) | 272 nt  | TCTG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TTTC]----5'WT sub2----[TCTG]----oligo+BC----[AGAA]
   ATGG                   TTTC                   TCTG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1    | 1743 nt | TAAT  | TCAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1673 nt | TCAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAAT]----3'WT sub1----[TCAA]----3'WT+PolIII sub2----[CACC]
   TAAT                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 13 of 25 -- Codons 704-779 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACA     | 0.8652   |
| oh2 (3' boundary) | TGAT     | 0.6933   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6         | 831 nt  | ATGG  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 1314 nt | TTTC  | TACA  |
| 3   | Oligo pool      | Tile 13 (15120 oligos) | 284 nt  | TACA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TTTC]----5'WT sub2----[TACA]----oligo+BC----[AGAA]
   ATGG                   TTTC                   TACA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1    | 1515 nt | TGAT  | TCAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1673 nt | TCAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAT]----3'WT sub1----[TCAA]----3'WT+PolIII sub2----[CACC]
   TGAT                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 14 of 25 -- Codons 774-849 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGA     | 0.8175   |
| oh2 (3' boundary) | CGAC     | 0.4695   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6         | 831 nt  | ATGG  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1524 nt | TTTC  | CAGA  |
| 3   | Oligo pool      | Tile 14 (14700 oligos) | 284 nt  | CAGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TTTC]----5'WT sub2----[CAGA]----oligo+BC----[AGAA]
   ATGG                   TTTC                   CAGA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1    | 1305 nt | CGAC  | TCAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1673 nt | TCAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CGAC]----3'WT sub1----[TCAA]----3'WT+PolIII sub2----[CACC]
   CGAC                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 15 of 25 -- Codons 844-905 (186 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGC     | 0.5900   |
| oh2 (3' boundary) | GAAC     | 0.6079   |

**Variants:** 11760 mutations, 11760 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6         | 831 nt  | ATGG  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 1314 nt | TTTC  | TACA  |
| 3   | 5'WT gene block | bsai_5wt_tile15_sub3   | 438 nt  | TACA  | AAGC  |
| 4   | Oligo pool      | Tile 15 (11760 oligos) | 242 nt  | AAGC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TTTC]----5'WT sub2----[TACA]----5'WT sub3----[AAGC]----oligo+BC----[AGAA]
   ATGG                   TTTC                   TACA                   AAGC                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1    | 1137 nt | GAAC  | TCAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1673 nt | TCAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAC]----3'WT sub1----[TCAA]----3'WT+PolIII sub2----[CACC]
   GAAC                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 16 of 25 -- Codons 900-952 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAG     | 0.7814   |
| oh2 (3' boundary) | AGAC     | 0.5696   |

**Variants:** 9870 mutations, 9870 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 831 nt  | ATGG  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2  | 1314 nt | TTTC  | TACA  |
| 3   | 5'WT gene block | bsai_5wt_tile16_sub3  | 606 nt  | TACA  | TCAG  |
| 4   | Oligo pool      | Tile 16 (9870 oligos) | 215 nt  | TCAG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TTTC]----5'WT sub2----[TACA]----5'WT sub3----[TCAG]----oligo+BC----[AGAA]
   ATGG                   TTTC                   TACA                   TCAG                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1    | 996 nt  | AGAC  | TCAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1673 nt | TCAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAC]----3'WT sub1----[TCAA]----3'WT+PolIII sub2----[CACC]
   AGAC                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 17 of 25 -- Codons 947-1020 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGGT     | 0.6250   |
| oh2 (3' boundary) | ACTA     | 0.7946   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6         | 831 nt  | ATGG  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 1314 nt | TTTC  | TACA  |
| 3   | 5'WT gene block | bsai_5wt_tile17_sub3   | 747 nt  | TACA  | AGGT  |
| 4   | Oligo pool      | Tile 17 (14280 oligos) | 278 nt  | AGGT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TTTC]----5'WT sub2----[TACA]----5'WT sub3----[AGGT]----oligo+BC----[AGAA]
   ATGG                   TTTC                   TACA                   AGGT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1    | 792 nt  | ACTA  | TCAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1673 nt | TCAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACTA]----3'WT sub1----[TCAA]----3'WT+PolIII sub2----[CACC]
   ACTA                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 18 of 25 -- Codons 1015-1054 (120 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | TGAC     | 0.6485   |

**Variants:** 7140 mutations, 7140 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 831 nt  | ATGG  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2  | 1314 nt | TTTC  | TACA  |
| 3   | 5'WT gene block | bsai_5wt_tile18_sub3  | 951 nt  | TACA  | AAGA  |
| 4   | Oligo pool      | Tile 18 (7140 oligos) | 176 nt  | AAGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TTTC]----5'WT sub2----[TACA]----5'WT sub3----[AAGA]----oligo+BC----[AGAA]
   ATGG                   TTTC                   TACA                   AAGA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1    | 690 nt  | TGAC  | TCAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1673 nt | TCAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAC]----3'WT sub1----[TCAA]----3'WT+PolIII sub2----[CACC]
   TGAC                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 19 of 25 -- Codons 1049-1121 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCTA     | 0.6679   |
| oh2 (3' boundary) | TGGT     | 0.5839   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6         | 831 nt  | ATGG  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 1314 nt | TTTC  | TACA  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3   | 1053 nt | TACA  | CCTA  |
| 4   | Oligo pool      | Tile 19 (14070 oligos) | 275 nt  | CCTA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TTTC]----5'WT sub2----[TACA]----5'WT sub3----[CCTA]----oligo+BC----[AGAA]
   ATGG                   TTTC                   TACA                   CCTA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1    | 489 nt  | TGGT  | TCAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1673 nt | TCAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGGT]----3'WT sub1----[TCAA]----3'WT+PolIII sub2----[CACC]
   TGGT                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 20 of 25 -- Codons 1116-1174 (177 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | CAAC     | 0.5780   |

**Variants:** 11130 mutations, 11130 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6         | 831 nt  | ATGG  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 1314 nt | TTTC  | TACA  |
| 3   | 5'WT gene block | bsai_5wt_tile20_sub3   | 1254 nt | TACA  | AAGA  |
| 4   | Oligo pool      | Tile 20 (11130 oligos) | 233 nt  | AAGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TTTC]----5'WT sub2----[TACA]----5'WT sub3----[AAGA]----oligo+BC----[AGAA]
   ATGG                   TTTC                   TACA                   AAGA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1    | 330 nt  | CAAC  | TCAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1673 nt | TCAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAC]----3'WT sub1----[TCAA]----3'WT+PolIII sub2----[CACC]
   CAAC                   TCAA                          CACC 
```

**Set fidelity:** 0.8662 (3 overhangs)

---

### Tile 21 of 25 -- Codons 1169-1246 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CGGA     | 0.6609   |
| oh2 (3' boundary) | CCAG     | 0.6122   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6         | 831 nt  | ATGG  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 1314 nt | TTTC  | TACA  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3   | 1413 nt | TACA  | CGGA  |
| 4   | Oligo pool      | Tile 21 (15120 oligos) | 290 nt  | CGGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TTTC]----5'WT sub2----[TACA]----5'WT sub3----[CGGA]----oligo+BC----[AGAA]
   ATGG                   TTTC                   TACA                   CGGA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile21_sub1    | 1769 nt | CCAG  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCAG]----3'WT+PolIII----[CACC]
   CCAG                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 22 of 25 -- Codons 1241-1272 (96 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CGGA     | 0.6609   |
| oh2 (3' boundary) | TCAA     | 0.9425   |

**Variants:** 5670 mutations, 5670 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 831 nt  | ATGG  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2  | 1314 nt | TTTC  | TACA  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1629 nt | TACA  | CGGA  |
| 4   | Oligo pool      | Tile 22 (5670 oligos) | 152 nt  | CGGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TTTC]----5'WT sub2----[TACA]----5'WT sub3----[CGGA]----oligo+BC----[AGAA]
   ATGG                   TTTC                   TACA                   CGGA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile22         | 1691 nt | TCAA  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAA]----3'WT+PolIII----[CACC]
   TCAA                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 23 of 25 -- Codons 1273-1343 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGA     | 0.8175   |
| oh2 (3' boundary) | GGAG     | 0.5228   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6         | 831 nt  | ATGG  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 1314 nt | TTTC  | TACA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 1725 nt | TACA  | CAGA  |
| 4   | Oligo pool      | Tile 23 (14070 oligos) | 269 nt  | CAGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TTTC]----5'WT sub2----[TACA]----5'WT sub3----[CAGA]----oligo+BC----[AGAA]
   ATGG                   TTTC                   TACA                   CAGA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile23         | 1478 nt | GGAG  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAG]----3'WT+PolIII----[CACC]
   GGAG                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 24 of 25 -- Codons 1338-1415 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGGA     | 0.6194   |
| oh2 (3' boundary) | TGAT     | 0.6933   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6         | 831 nt  | ATGG  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 1314 nt | TTTC  | TACA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 1725 nt | TACA  | CAGA  |
| 4   | 5'WT gene block | bsai_5wt_tile24_sub4   | 213 nt  | CAGA  | GGGA  |
| 5   | Oligo pool      | Tile 24 (15120 oligos) | 290 nt  | GGGA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TTTC]----5'WT sub2----[TACA]----5'WT sub3----[CAGA]----5'WT sub4----[GGGA]----oligo+BC----[AGAA]
   ATGG                   TTTC                   TACA                   CAGA                   GGGA                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile24         | 1262 nt | TGAT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAT]----3'WT+PolIII----[CACC]
   TGAT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 25 of 25 -- Codons 1410-1465 (168 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCGT     | 0.7335   |
| oh2 (3' boundary) | TTAA     | 0.9448   |

**Variants:** 10710 mutations, 10710 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6         | 831 nt  | ATGG  | TTTC  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 1314 nt | TTTC  | TACA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 1725 nt | TACA  | CAGA  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4   | 429 nt  | CAGA  | TCGT  |
| 5   | Oligo pool      | Tile 25 (10710 oligos) | 224 nt  | TCGT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TTTC]----5'WT sub2----[TACA]----5'WT sub3----[CAGA]----5'WT sub4----[TCGT]----oligo+BC----[AGAA]
   ATGG                   TTTC                   TACA                   CAGA                   TCGT                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component            | Part name                | Length  | 5' OH | 3' OH |
| --- | -------------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product         | (in helper plasmid)      | --      | --    | --    |
| 2   | PolIII-only fragment | bsmbi_polIII_tile25      | 1112 nt | TTAA  | CACC  |
| 3   | Enzyme + buffer      | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTAA]----PolIII----[CACC]
   TTAA                CACC 
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

**Total blocks:** 52

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| --------------------- | ----------- | ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| bsai_5wt_tile10_sub2  | 777         | BsaI        | 5wt_tile10_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile11_sub2  | 963         | BsaI        | 5wt_tile11_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile12_sub2  | 1098        | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile13_sub2  | 1314        | BsaI        | 5wt_tile13_sub2;5wt_tile15_sub2;5wt_tile16_sub2;5wt_tile17_sub2;5wt_tile18_sub2;5wt_tile19_sub2;5wt_tile20_sub2;5wt_tile21_sub2;5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile14_sub2  | 1524        | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile15_sub3  | 438         | BsaI        | 5wt_tile15_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile16_sub3  | 606         | BsaI        | 5wt_tile16_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile17_sub3  | 747         | BsaI        | 5wt_tile17_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile18_sub3  | 951         | BsaI        | 5wt_tile18_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile19_sub3  | 1053        | BsaI        | 5wt_tile19_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile2        | 234         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile20_sub3  | 1254        | BsaI        | 5wt_tile20_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile21_sub3  | 1413        | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile22_sub3  | 1629        | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile23_sub3  | 1725        | BsaI        | 5wt_tile23_sub3;5wt_tile24_sub3;5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile24_sub4  | 213         | BsaI        | 5wt_tile24_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile25_sub4  | 429         | BsaI        | 5wt_tile25_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile3        | 396         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile4        | 498         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile5        | 675         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile6        | 831         | BsaI        | 5wt_tile6;5wt_tile8_sub1;5wt_tile9_sub1;5wt_tile10_sub1;5wt_tile11_sub1;5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1                                                                                                                                                            |
| bsai_5wt_tile7_sub1   | 984         | BsaI        | 5wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile8_sub2   | 384         | BsaI        | 5wt_tile8_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile9_sub2   | 597         | BsaI        | 5wt_tile9_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile1_sub1  | 615         | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile1_sub2  | 1314        | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile1_sub3  | 1725        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile8_sub2;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile1_sub4  | 1673        | BsmBI       | 3wt_polIII_tile1_sub4;3wt_polIII_tile2_sub4;3wt_polIII_tile3_sub4;3wt_polIII_tile4_sub3;3wt_polIII_tile5_sub3;3wt_polIII_tile6_sub3;3wt_polIII_tile7_sub3;3wt_polIII_tile8_sub3;3wt_polIII_tile9_sub3;3wt_polIII_tile10_sub3;3wt_polIII_tile11_sub3;3wt_polIII_tile12_sub2;3wt_polIII_tile13_sub2;3wt_polIII_tile14_sub2;3wt_polIII_tile15_sub2;3wt_polIII_tile16_sub2;3wt_polIII_tile17_sub2;3wt_polIII_tile18_sub2;3wt_polIII_tile19_sub2;3wt_polIII_tile20_sub2 |
| bsmbi_3wt_tile10_sub1 | 369         | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile11_sub1 | 234         | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile12_sub1 | 1743        | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile13_sub1 | 1515        | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile14_sub1 | 1305        | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile15_sub1 | 1137        | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile16_sub1 | 996         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile17_sub1 | 792         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile18_sub1 | 690         | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile19_sub1 | 489         | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile2_sub1  | 453         | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile20_sub1 | 330         | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile21_sub1 | 1769        | BsmBI       | 3wt_polIII_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile22      | 1691        | BsmBI       | 3wt_polIII_tile22                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile23      | 1478        | BsmBI       | 3wt_polIII_tile23                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile24      | 1262        | BsmBI       | 3wt_polIII_tile24                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile3_sub1  | 351         | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile4_sub1  | 1470        | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile5_sub1  | 1332        | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile6_sub1  | 1161        | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile7_sub1  | 948         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile8_sub1  | 735         | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile9_sub1  | 555         | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_polIII_tile25   | 1112        | BsmBI       | polIII_tile25                                                                                                                                                                                                                                                                                                                                                                                                                                                      |

## 10. Domestication Log

6 endogenous enzyme site(s) were removed via silent mutations:

| site_start | enzyme | strand | codon_pos | original_codon | new_codon | aa  |
| ---------- | ------ | ------ | --------- | -------------- | --------- | --- |
| 780        | BsaI   | +      | 260       | TTG            | CTT       | L   |
| 2013       | BsaI   | -      | 671       | CAG            | CAA       | Q   |
| 2374       | BsaI   | -      | 792       | GAG            | GAA       | E   |
| 3604       | BsaI   | -      | 1202      | GAG            | GAA       | E   |
| 1279       | BsmBI  | -      | 427       | GAG            | GAA       | E   |
| 1629       | BsmBI  | +      | 543       | ACC            | ACA       | T   |

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

