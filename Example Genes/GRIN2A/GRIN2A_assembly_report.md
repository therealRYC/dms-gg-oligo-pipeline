# DMS-GG Assembly Report: GRIN2A

Generated: 2026-03-19 11:59:26
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                          |
| -------------------- | ------------------------------------------------------------------------------ |
| Gene name            | GRIN2A_NM_000833.5 Human GRIN2A native CDS (NM_000833.5, NP_000824.1, 1464 aa) |
| CDS length           | 4395 nt (1465 codons)                                                          |
| Protein length       | 1464 aa                                                                        |
| Number of tiles      | 24                                                                             |
| Total variants       | 30534                                                                          |
| Total oligos         | 305340                                                                         |
| Oligo length range   | 176-294 nt                                                                     |
| Gene blocks to order | 50                                                                             |
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

**Total oligos:** 305340 | **Length range:** 176-294 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-78      | 15540  | 294 nt |
| 2    | 73-137    | 12390  | 251 nt |
| 3    | 132-206   | 14490  | 281 nt |
| 4    | 201-278   | 15120  | 290 nt |
| 5    | 273-328   | 10500  | 224 nt |
| 6    | 323-399   | 14910  | 287 nt |
| 7    | 394-455   | 11760  | 242 nt |
| 8    | 450-520   | 13650  | 269 nt |
| 9    | 515-586   | 14070  | 272 nt |
| 10   | 587-633   | 9030   | 197 nt |
| 11   | 628-684   | 10710  | 227 nt |
| 12   | 679-743   | 12390  | 251 nt |
| 13   | 738-813   | 14700  | 284 nt |
| 14   | 808-885   | 15120  | 290 nt |
| 15   | 880-949   | 13440  | 266 nt |
| 16   | 944-1020  | 14910  | 287 nt |
| 17   | 1015-1054 | 7140   | 176 nt |
| 18   | 1049-1121 | 14070  | 275 nt |
| 19   | 1116-1168 | 10080  | 215 nt |
| 20   | 1169-1244 | 15120  | 284 nt |
| 21   | 1239-1280 | 7770   | 182 nt |
| 22   | 1281-1348 | 13440  | 260 nt |
| 23   | 1343-1413 | 13650  | 269 nt |
| 24   | 1408-1480 | 11340  | 277 nt |

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
| Total barcodes    | 305340                             |
| Unique barcodes   | 305340                             |
| GC content range  | 35% - 65%                          |
| GC content mean   | 48.4%                              |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                   | Description                                                   | Result | Detail                                                                                                                                              |
| ----------------------- | ------------------------------------------------------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths           | All oligos within synthesis length limit                      | PASS   | Range: 176-294 nt (limit: 300)                                                                                                                      |
| block_lengths           | All gene blocks within synthesis length limit                 | PASS   | Range: 153-1794 nt (limit: 1800)                                                                                                                    |
| barcode_junction_sites  | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                             |
| barcode_uniqueness      | All barcodes are unique                                       | PASS   | 305340 unique / 305340 total                                                                                                                        |
| tile_coverage           | Tiles cover entire gene without gaps                          | PASS   | 4395 / 4395 nt covered                                                                                                                              |
| variant_count           | Expected number of variants generated                         | PASS   | 30534 unique variants (expected: 30534 across 1454/1463 mutable positions; 27626 missense + 1454 nonsense + 1454 wt_control; 9 position(s) skipped) |
| single_codon_change     | Each non-control variant differs by exactly one codon from WT | PASS   | 290800 / 290800 variants confirmed (WT controls excluded)                                                                                           |
| oligo_gc_content        | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 40.8-66.3% | 0 oligo(s) with extreme GC                                                                                                   |
| domestication_complete  | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                             |
| overhang_fidelity       | Tile boundary overhangs have adequate fidelity                | FAIL   | 22 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                             |
| tile_manifests          | Per-tile assembly manifests complete                          | PASS   | 24 tile manifest(s) generated                                                                                                                       |
| helper_plasmid          | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                  |
| reaction_fidelity       | Per-reaction set-level overhang fidelity                      | PASS   | Min set fidelity: 0.9406 across 48 reactions | 0 reaction(s) below 0.90                                                                             |
| barcode_poliii_term     | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 305340 barcode(s) contain TTTT                                                                                                                  |
| barcode_hairpins        | No barcodes have hairpin stems > 3 bp                         | PASS   | 0 / 305340 barcode(s) have hairpin stems > 3 bp                                                                                                     |
| barcode_dinuc_repeats   | No barcodes have dinucleotide repeats > 4 units               | PASS   | 0 / 305340 barcode(s) exceed 4 dinuc repeat units                                                                                                   |
| barcode_tm_distribution | Barcode Tm distribution (informational)                       | PASS   | Tm: median=53.3, range=[41.7, 65.3], sd=4 C                                                                                                         |
| block_min_length        | All gene blocks above synthesis minimum length                | FAIL   | 4 block(s) below 300 nt minimum. Range: 153-1794 nt                                                                                                 |
| sb_overhang_collisions  | Superblock boundary overhangs are unique (no collisions)      | PASS   | 6 SB boundary OH(s), all unique                                                                                                                     |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 0.9406            | 5         | 1.0000             |
| 2    | 3        | 0.9406            | 5         | 1.0000             |
| 3    | 3        | 0.9406            | 5         | 1.0000             |
| 4    | 3        | 0.9406            | 5         | 1.0000             |
| 5    | 3        | 0.9406            | 5         | 1.0000             |
| 6    | 3        | 0.9406            | 5         | 1.0000             |
| 7    | 3        | 0.9406            | 5         | 1.0000             |
| 8    | 3        | 0.9406            | 5         | 1.0000             |
| 9    | 3        | 0.9406            | 4         | 1.0000             |
| 10   | 3        | 0.9406            | 4         | 1.0000             |
| 11   | 4        | 0.9406            | 4         | 1.0000             |
| 12   | 4        | 0.9406            | 4         | 1.0000             |
| 13   | 4        | 0.9406            | 4         | 1.0000             |
| 14   | 4        | 0.9406            | 4         | 0.9984             |
| 15   | 4        | 0.9406            | 4         | 0.9986             |
| 16   | 4        | 0.9406            | 4         | 0.9988             |
| 17   | 4        | 0.9406            | 4         | 1.0000             |
| 18   | 4        | 0.9406            | 3         | 1.0000             |
| 19   | 4        | 0.9406            | 3         | 1.0000             |
| 20   | 4        | 0.9406            | 2         | 1.0000             |
| 21   | 5        | 0.9406            | 2         | 1.0000             |
| 22   | 5        | 0.9406            | 2         | 1.0000             |
| 23   | 5        | 0.9406            | 2         | 0.9988             |
| 24   | 6        | 0.9406            | 2         | 1.0000             |

**Min:** 0.9406 | **Max:** 1.0000 | **Mean:** 0.9702

## 6. Fixed Overhangs & Helper Plasmid

These overhangs are the same across all tile reactions:

| Overhang    | Sequence | Role                                                    |
| ----------- | -------- | ------------------------------------------------------- |
| oh_L        | TGAA     | Gene start (BsaI, user-specified, upstream of ATG)      |
| oh3         | CACC     | Downstream cassette-barcode junction (BsmBI, all tiles) |
| oh4         | AGAA     | Barcode-helper junction (BsaI, all tiles)               |
| paqci_star2 | AATG     | PaqCI 5' end of insert (Level 2)                        |
| paqci_star1 | GCTA     | PaqCI 3' end of insert (Level 2)                        |

### Helper Plasmid Insert

The helper plasmid provides the backbone for each BsaI Level 1 reaction.

```
[PaqCI**]--[BsaI>>TGAA]--STUFFER--[AGAA<<BsaI]--[PaqCI*]
```

Insert length: 72 nt
oh_L = TGAA (user-specified, upstream of ATG)
oh_R = AGAA (= oh4, barcode-helper junction)
upstream_cassette = (none)

## 7. Per-Tile Assembly Guide

### Tile 1 of 24 -- Codons 1-78 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TGAA     | 0.8621   |
| oh2 (3' boundary) | CGAC     | 0.4695   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (15540 oligos)              | 294 nt | TGAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert              | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart               | --     | --    | --    |

```
  [TGAA]----oligo+BC----[AGAA]
   TGAA                  AGAA 
```

**Set fidelity:** 0.9406 (2 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1     | 1572 nt | CGAC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1776 nt | GAAA  | TAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 366 nt  | TAAT  | GATT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1661 nt | GATT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CGAC]----3'WT sub1----[GAAA]----3'WT sub2----[TAAT]----3'WT sub3----[GATT]----3'WT+PolIII sub4----[CACC]
   CGAC                   GAAA                   TAAT                   GATT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 2 of 24 -- Codons 73-137 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTGA     | 0.6791   |
| oh2 (3' boundary) | TGAC     | 0.6485   |

**Variants:** 12390 mutations, 12390 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 250 nt | TGAA  | CTGA  |
| 2   | Oligo pool      | Tile 2 (12390 oligos) | 251 nt | CTGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [TGAA]----5'WT block----[CTGA]----oligo+BC----[AGAA]
   TGAA                    CTGA                  AGAA 
```

**Set fidelity:** 0.9406 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1     | 1395 nt | TGAC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1776 nt | GAAA  | TAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 366 nt  | TAAT  | GATT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1661 nt | GATT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAC]----3'WT sub1----[GAAA]----3'WT sub2----[TAAT]----3'WT sub3----[GATT]----3'WT+PolIII sub4----[CACC]
   TGAC                   GAAA                   TAAT                   GATT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 3 of 24 -- Codons 132-206 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTA     | 0.8892   |
| oh2 (3' boundary) | ACTG     | 0.5529   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 427 nt | TGAA  | TCTA  |
| 2   | Oligo pool      | Tile 3 (14490 oligos) | 281 nt | TCTA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [TGAA]----5'WT block----[TCTA]----oligo+BC----[AGAA]
   TGAA                    TCTA                  AGAA 
```

**Set fidelity:** 0.9406 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1     | 1188 nt | ACTG  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1776 nt | GAAA  | TAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 366 nt  | TAAT  | GATT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1661 nt | GATT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACTG]----3'WT sub1----[GAAA]----3'WT sub2----[TAAT]----3'WT sub3----[GATT]----3'WT+PolIII sub4----[CACC]
   ACTG                   GAAA                   TAAT                   GATT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 4 of 24 -- Codons 201-278 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGA     | 0.8175   |
| oh2 (3' boundary) | TTCT     | 0.8181   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 634 nt | TGAA  | CAGA  |
| 2   | Oligo pool      | Tile 4 (15120 oligos) | 290 nt | CAGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [TGAA]----5'WT block----[CAGA]----oligo+BC----[AGAA]
   TGAA                    CAGA                  AGAA 
```

**Set fidelity:** 0.9406 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1     | 972 nt  | TTCT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1776 nt | GAAA  | TAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 366 nt  | TAAT  | GATT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1661 nt | GATT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCT]----3'WT sub1----[GAAA]----3'WT sub2----[TAAT]----3'WT sub3----[GATT]----3'WT+PolIII sub4----[CACC]
   TTCT                   GAAA                   TAAT                   GATT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 5 of 24 -- Codons 273-328 (168 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCAT     | 0.6470   |
| oh2 (3' boundary) | AGAG     | 0.6016   |

**Variants:** 10500 mutations, 10500 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 850 nt | TGAA  | CCAT  |
| 2   | Oligo pool      | Tile 5 (10500 oligos) | 224 nt | CCAT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [TGAA]----5'WT block----[CCAT]----oligo+BC----[AGAA]
   TGAA                    CCAT                  AGAA 
```

**Set fidelity:** 0.9406 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1     | 822 nt  | AGAG  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1776 nt | GAAA  | TAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 366 nt  | TAAT  | GATT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1661 nt | GATT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAG]----3'WT sub1----[GAAA]----3'WT sub2----[TAAT]----3'WT sub3----[GATT]----3'WT+PolIII sub4----[CACC]
   AGAG                   GAAA                   TAAT                   GATT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 6 of 24 -- Codons 323-399 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGA     | 0.8175   |
| oh2 (3' boundary) | CTGT     | 0.6476   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 1000 nt | TGAA  | CAGA  |
| 2   | Oligo pool      | Tile 6 (14910 oligos) | 287 nt  | CAGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [TGAA]----5'WT block----[CAGA]----oligo+BC----[AGAA]
   TGAA                    CAGA                  AGAA 
```

**Set fidelity:** 0.9406 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1     | 609 nt  | CTGT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1776 nt | GAAA  | TAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 366 nt  | TAAT  | GATT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1661 nt | GATT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTGT]----3'WT sub1----[GAAA]----3'WT sub2----[TAAT]----3'WT sub3----[GATT]----3'WT+PolIII sub4----[CACC]
   CTGT                   GAAA                   TAAT                   GATT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 7 of 24 -- Codons 394-455 (186 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGT     | 0.7629   |
| oh2 (3' boundary) | ATGC     | 0.6171   |

**Variants:** 11760 mutations, 11760 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 1213 nt | TGAA  | AAGT  |
| 2   | Oligo pool      | Tile 7 (11760 oligos) | 242 nt  | AAGT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [TGAA]----5'WT block----[AAGT]----oligo+BC----[AGAA]
   TGAA                    AAGT                  AGAA 
```

**Set fidelity:** 0.9406 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1     | 441 nt  | ATGC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1776 nt | GAAA  | TAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 366 nt  | TAAT  | GATT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1661 nt | GATT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATGC]----3'WT sub1----[GAAA]----3'WT sub2----[TAAT]----3'WT sub3----[GATT]----3'WT+PolIII sub4----[CACC]
   ATGC                   GAAA                   TAAT                   GATT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 8 of 24 -- Codons 450-520 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGA     | 0.7549   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1381 nt | TGAA  | ATGA  |
| 2   | Oligo pool      | Tile 8 (13650 oligos) | 269 nt  | ATGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [TGAA]----5'WT block----[ATGA]----oligo+BC----[AGAA]
   TGAA                    ATGA                  AGAA 
```

**Set fidelity:** 0.9406 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1     | 246 nt  | TGAA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1776 nt | GAAA  | TAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 366 nt  | TAAT  | GATT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1661 nt | GATT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[GAAA]----3'WT sub2----[TAAT]----3'WT sub3----[GATT]----3'WT+PolIII sub4----[CACC]
   TGAA                   GAAA                   TAAT                   GATT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 9 of 24 -- Codons 515-586 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATG     | 0.6412   |
| oh2 (3' boundary) | CAGA     | 0.8175   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1576 nt | TGAA  | AATG  |
| 2   | Oligo pool      | Tile 9 (14070 oligos) | 272 nt  | AATG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [TGAA]----5'WT block----[AATG]----oligo+BC----[AGAA]
   TGAA                    AATG                  AGAA 
```

**Set fidelity:** 0.9406 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1     | 1794 nt | CAGA  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 366 nt  | TAAT  | GATT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1661 nt | GATT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAGA]----3'WT sub1----[TAAT]----3'WT sub2----[GATT]----3'WT+PolIII sub3----[CACC]
   CAGA                   TAAT                   GATT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 10 of 24 -- Codons 587-633 (141 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AACT     | 0.6635   |
| oh2 (3' boundary) | TGTA     | 0.7693   |

**Variants:** 9030 mutations, 9030 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10       | 1792 nt | TGAA  | AACT  |
| 2   | Oligo pool      | Tile 10 (9030 oligos) | 197 nt  | AACT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [TGAA]----5'WT block----[AACT]----oligo+BC----[AGAA]
   TGAA                    AACT                  AGAA 
```

**Set fidelity:** 0.9406 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1    | 1653 nt | TGTA  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 366 nt  | TAAT  | GATT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1661 nt | GATT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGTA]----3'WT sub1----[TAAT]----3'WT sub2----[GATT]----3'WT+PolIII sub3----[CACC]
   TGTA                   TAAT                   GATT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 11 of 24 -- Codons 628-684 (171 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | GACA     | 0.6127   |

**Variants:** 10710 mutations, 10710 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1792 nt | TGAA  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile11_sub2   | 153 nt  | AACT  | AAGA  |
| 3   | Oligo pool      | Tile 11 (10710 oligos) | 227 nt  | AAGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AACT]----5'WT sub2----[AAGA]----oligo+BC----[AGAA]
   TGAA                   AACT                   AAGA                  AGAA 
```

**Set fidelity:** 0.9406 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1    | 1500 nt | GACA  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 366 nt  | TAAT  | GATT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1661 nt | GATT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GACA]----3'WT sub1----[TAAT]----3'WT sub2----[GATT]----3'WT+PolIII sub3----[CACC]
   GACA                   TAAT                   GATT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 12 of 24 -- Codons 679-743 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCTT     | 0.6891   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 12390 mutations, 12390 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1792 nt | TGAA  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2   | 306 nt  | AACT  | CCTT  |
| 3   | Oligo pool      | Tile 12 (12390 oligos) | 251 nt  | CCTT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AACT]----5'WT sub2----[CCTT]----oligo+BC----[AGAA]
   TGAA                   AACT                   CCTT                  AGAA 
```

**Set fidelity:** 0.9406 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1    | 1323 nt | TGAA  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 366 nt  | TAAT  | GATT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1661 nt | GATT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[TAAT]----3'WT sub2----[GATT]----3'WT+PolIII sub3----[CACC]
   TGAA                   TAAT                   GATT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 13 of 24 -- Codons 738-813 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGG     | 0.6552   |
| oh2 (3' boundary) | GGAC     | 0.5754   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1792 nt | TGAA  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 483 nt  | AACT  | AAGG  |
| 3   | Oligo pool      | Tile 13 (14700 oligos) | 284 nt  | AAGG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AACT]----5'WT sub2----[AAGG]----oligo+BC----[AGAA]
   TGAA                   AACT                   AAGG                  AGAA 
```

**Set fidelity:** 0.9406 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1    | 1113 nt | GGAC  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 366 nt  | TAAT  | GATT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1661 nt | GATT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAC]----3'WT sub1----[TAAT]----3'WT sub2----[GATT]----3'WT+PolIII sub3----[CACC]
   GGAC                   TAAT                   GATT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 14 of 24 -- Codons 808-885 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGA     | 0.7549   |
| oh2 (3' boundary) | CTTC     | 0.6384   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1792 nt | TGAA  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 693 nt  | AACT  | ATGA  |
| 3   | Oligo pool      | Tile 14 (15120 oligos) | 290 nt  | ATGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AACT]----5'WT sub2----[ATGA]----oligo+BC----[AGAA]
   TGAA                   AACT                   ATGA                  AGAA 
```

**Set fidelity:** 0.9406 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1    | 897 nt  | CTTC  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 366 nt  | TAAT  | GATT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1661 nt | GATT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTTC]----3'WT sub1----[TAAT]----3'WT sub2----[GATT]----3'WT+PolIII sub3----[CACC]
   CTTC                   TAAT                   GATT                          CACC 
```

**Set fidelity:** 0.9984 (4 overhangs)

---

### Tile 15 of 24 -- Codons 880-949 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | CTTT     | 0.6635   |

**Variants:** 13440 mutations, 13440 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1792 nt | TGAA  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 909 nt  | AACT  | AAGA  |
| 3   | Oligo pool      | Tile 15 (13440 oligos) | 266 nt  | AAGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AACT]----5'WT sub2----[AAGA]----oligo+BC----[AGAA]
   TGAA                   AACT                   AAGA                  AGAA 
```

**Set fidelity:** 0.9406 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1    | 705 nt  | CTTT  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 366 nt  | TAAT  | GATT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1661 nt | GATT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTTT]----3'WT sub1----[TAAT]----3'WT sub2----[GATT]----3'WT+PolIII sub3----[CACC]
   CTTT                   TAAT                   GATT                          CACC 
```

**Set fidelity:** 0.9986 (4 overhangs)

---

### Tile 16 of 24 -- Codons 944-1020 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAG     | 0.7814   |
| oh2 (3' boundary) | TTCC     | 0.7958   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1792 nt | TGAA  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1101 nt | AACT  | TCAG  |
| 3   | Oligo pool      | Tile 16 (14910 oligos) | 287 nt  | TCAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AACT]----5'WT sub2----[TCAG]----oligo+BC----[AGAA]
   TGAA                   AACT                   TCAG                  AGAA 
```

**Set fidelity:** 0.9406 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1    | 492 nt  | TTCC  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 366 nt  | TAAT  | GATT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1661 nt | GATT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCC]----3'WT sub1----[TAAT]----3'WT sub2----[GATT]----3'WT+PolIII sub3----[CACC]
   TTCC                   TAAT                   GATT                          CACC 
```

**Set fidelity:** 0.9988 (4 overhangs)

---

### Tile 17 of 24 -- Codons 1015-1054 (120 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | AGAA     | 0.8847   |

**Variants:** 7140 mutations, 7140 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10       | 1792 nt | TGAA  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2  | 1314 nt | AACT  | AAGA  |
| 3   | Oligo pool      | Tile 17 (7140 oligos) | 176 nt  | AAGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AACT]----5'WT sub2----[AAGA]----oligo+BC----[AGAA]
   TGAA                   AACT                   AAGA                  AGAA 
```

**Set fidelity:** 0.9406 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1    | 390 nt  | AGAA  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 366 nt  | TAAT  | GATT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1661 nt | GATT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAA]----3'WT sub1----[TAAT]----3'WT sub2----[GATT]----3'WT+PolIII sub3----[CACC]
   AGAA                   TAAT                   GATT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 18 of 24 -- Codons 1049-1121 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCTA     | 0.6679   |
| oh2 (3' boundary) | AGAT     | 0.6825   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1792 nt | TGAA  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1416 nt | AACT  | CCTA  |
| 3   | Oligo pool      | Tile 18 (14070 oligos) | 275 nt  | CCTA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AACT]----5'WT sub2----[CCTA]----oligo+BC----[AGAA]
   TGAA                   AACT                   CCTA                  AGAA 
```

**Set fidelity:** 0.9406 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1    | 525 nt  | AGAT  | GATT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1661 nt | GATT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAT]----3'WT sub1----[GATT]----3'WT+PolIII sub2----[CACC]
   AGAT                   GATT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 19 of 24 -- Codons 1116-1168 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | GAAC     | 0.6079   |

**Variants:** 10080 mutations, 10080 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1792 nt | TGAA  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1617 nt | AACT  | AAGA  |
| 3   | Oligo pool      | Tile 19 (10080 oligos) | 215 nt  | AAGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AACT]----5'WT sub2----[AAGA]----oligo+BC----[AGAA]
   TGAA                   AACT                   AAGA                  AGAA 
```

**Set fidelity:** 0.9406 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1    | 384 nt  | GAAC  | GATT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1661 nt | GATT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAC]----3'WT sub1----[GATT]----3'WT+PolIII sub2----[CACC]
   GAAC                   GATT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 20 of 24 -- Codons 1169-1244 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CGGA     | 0.6609   |
| oh2 (3' boundary) | GAAC     | 0.6079   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1792 nt | TGAA  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1776 nt | AACT  | CGGA  |
| 3   | Oligo pool      | Tile 20 (15120 oligos) | 284 nt  | CGGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AACT]----5'WT sub2----[CGGA]----oligo+BC----[AGAA]
   TGAA                   AACT                   CGGA                  AGAA 
```

**Set fidelity:** 0.9406 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile20_sub1    | 1787 nt | GAAC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAC]----3'WT+PolIII----[CACC]
   GAAC                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 21 of 24 -- Codons 1239-1280 (126 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TGCC     | 0.5867   |
| oh2 (3' boundary) | ACAA     | 0.8919   |

**Variants:** 7770 mutations, 7770 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10       | 1792 nt | TGAA  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2  | 1776 nt | AACT  | CGGA  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3  | 240 nt  | CGGA  | TGCC  |
| 4   | Oligo pool      | Tile 21 (7770 oligos) | 182 nt  | TGCC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AACT]----5'WT sub2----[CGGA]----5'WT sub3----[TGCC]----oligo+BC----[AGAA]
   TGAA                   AACT                   CGGA                   TGCC                  AGAA 
```

**Set fidelity:** 0.9406 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile21         | 1679 nt | ACAA  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACAA]----3'WT+PolIII----[CACC]
   ACAA                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 22 of 24 -- Codons 1281-1348 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | TCTG     | 0.6684   |

**Variants:** 13440 mutations, 13440 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1792 nt | TGAA  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1776 nt | AACT  | CGGA  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 366 nt  | CGGA  | AAGA  |
| 4   | Oligo pool      | Tile 22 (13440 oligos) | 260 nt  | AAGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AACT]----5'WT sub2----[CGGA]----5'WT sub3----[AAGA]----oligo+BC----[AGAA]
   TGAA                   AACT                   CGGA                   AAGA                  AGAA 
```

**Set fidelity:** 0.9406 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile22         | 1475 nt | TCTG  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCTG]----3'WT+PolIII----[CACC]
   TCTG                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 23 of 24 -- Codons 1343-1413 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTTT     | 0.6635   |
| oh2 (3' boundary) | TTCC     | 0.7958   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1792 nt | TGAA  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1776 nt | AACT  | CGGA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 552 nt  | CGGA  | CTTT  |
| 4   | Oligo pool      | Tile 23 (13650 oligos) | 269 nt  | CTTT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AACT]----5'WT sub2----[CGGA]----5'WT sub3----[CTTT]----oligo+BC----[AGAA]
   TGAA                   AACT                   CGGA                   CTTT                  AGAA 
```

**Set fidelity:** 0.9406 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile23         | 1280 nt | TTCC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCC]----3'WT+PolIII----[CACC]
   TTCC                     CACC 
```

**Set fidelity:** 0.9988 (2 overhangs)

---

### Tile 24 of 24 -- Codons 1408-1480 (221 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACGG     | 0.4986   |
| oh2 (3' boundary) | TTCT     | 0.8181   |

**Variants:** 11340 mutations, 11340 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1792 nt | TGAA  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1776 nt | AACT  | CGGA  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 366 nt  | CGGA  | AAGA  |
| 4   | 5'WT gene block | bsai_5wt_tile24_sub4   | 411 nt  | AAGA  | ACGG  |
| 5   | Oligo pool      | Tile 24 (11340 oligos) | 277 nt  | ACGG  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AACT]----5'WT sub2----[CGGA]----5'WT sub3----[AAGA]----5'WT sub4----[ACGG]----oligo+BC----[AGAA]
   TGAA                   AACT                   CGGA                   AAGA                   ACGG                  AGAA 
```

**Set fidelity:** 0.9406 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component            | Part name                | Length  | 5' OH | 3' OH |
| --- | -------------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product         | (in helper plasmid)      | --      | --    | --    |
| 2   | PolIII-only fragment | bsmbi_polIII_tile24      | 1077 nt | TTCT  | CACC  |
| 3   | Enzyme + buffer      | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCT]----PolIII----[CACC]
   TTCT                CACC 
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

**Total blocks:** 50

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| --------------------- | ----------- | ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10       | 1792        | BsaI        | 5wt_tile10;5wt_tile11_sub1;5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1                                                                                                                                                                                                  |
| bsai_5wt_tile11_sub2  | 153         | BsaI        | 5wt_tile11_sub2                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile12_sub2  | 306         | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile13_sub2  | 483         | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile14_sub2  | 693         | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile15_sub2  | 909         | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile16_sub2  | 1101        | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile17_sub2  | 1314        | BsaI        | 5wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile18_sub2  | 1416        | BsaI        | 5wt_tile18_sub2                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile19_sub2  | 1617        | BsaI        | 5wt_tile19_sub2                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile2        | 250         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsai_5wt_tile20_sub2  | 1776        | BsaI        | 5wt_tile20_sub2;5wt_tile21_sub2;5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile21_sub3  | 240         | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile22_sub3  | 366         | BsaI        | 5wt_tile22_sub3;5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile23_sub3  | 552         | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile24_sub4  | 411         | BsaI        | 5wt_tile24_sub4                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile3        | 427         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsai_5wt_tile4        | 634         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsai_5wt_tile5        | 850         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsai_5wt_tile6        | 1000        | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsai_5wt_tile7        | 1213        | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsai_5wt_tile8        | 1381        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsai_5wt_tile9        | 1576        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile1_sub1  | 1572        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile1_sub2  | 1776        | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile8_sub2                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile1_sub3  | 366         | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub3;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2;3wt_tile16_sub2;3wt_tile17_sub2                                                                                                                                                                      |
| bsmbi_3wt_tile1_sub4  | 1661        | BsmBI       | 3wt_polIII_tile1_sub4;3wt_polIII_tile2_sub4;3wt_polIII_tile3_sub4;3wt_polIII_tile4_sub4;3wt_polIII_tile5_sub4;3wt_polIII_tile6_sub4;3wt_polIII_tile7_sub4;3wt_polIII_tile8_sub4;3wt_polIII_tile9_sub3;3wt_polIII_tile10_sub3;3wt_polIII_tile11_sub3;3wt_polIII_tile12_sub3;3wt_polIII_tile13_sub3;3wt_polIII_tile14_sub3;3wt_polIII_tile15_sub3;3wt_polIII_tile16_sub3;3wt_polIII_tile17_sub3;3wt_polIII_tile18_sub2;3wt_polIII_tile19_sub2 |
| bsmbi_3wt_tile10_sub1 | 1653        | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile11_sub1 | 1500        | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile12_sub1 | 1323        | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile13_sub1 | 1113        | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile14_sub1 | 897         | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile15_sub1 | 705         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile16_sub1 | 492         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile17_sub1 | 390         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile18_sub1 | 525         | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile19_sub1 | 384         | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile2_sub1  | 1395        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile20_sub1 | 1787        | BsmBI       | 3wt_polIII_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile21      | 1679        | BsmBI       | 3wt_polIII_tile21                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile22      | 1475        | BsmBI       | 3wt_polIII_tile22                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile23      | 1280        | BsmBI       | 3wt_polIII_tile23                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile3_sub1  | 1188        | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile4_sub1  | 972         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile5_sub1  | 822         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile6_sub1  | 609         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile7_sub1  | 441         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile8_sub1  | 246         | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile9_sub1  | 1794        | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_polIII_tile24   | 1077        | BsmBI       | polIII_tile24                                                                                                                                                                                                                                                                                                                                                                                                                               |

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

