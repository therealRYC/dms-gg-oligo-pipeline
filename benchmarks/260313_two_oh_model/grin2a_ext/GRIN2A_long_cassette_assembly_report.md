# DMS-GG Assembly Report: GRIN2A_long_cassette

Generated: 2026-03-13 15:01:23
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                          |
| -------------------- | ------------------------------------------------------------------------------ |
| Gene name            | GRIN2A_NM_000833.5 Human GRIN2A native CDS (NM_000833.5, NP_000824.1, 1464 aa) |
| CDS length           | 4395 nt (1465 codons)                                                          |
| Protein length       | 1464 aa                                                                        |
| Number of tiles      | 29                                                                             |
| Total variants       | 30513                                                                          |
| Total oligos         | 305130                                                                         |
| Oligo length range   | 152-290 nt                                                                     |
| Gene blocks to order | 69                                                                             |
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
[PaqCI**]--[gene+mutation]--[P2A_EGFP]--[WPRE]--[spacer]--[bGH_polyA]--[PolIII]--[barcode]--[PaqCI*]
```

## 3. Oligo Pool Summary

**Total oligos:** 305130 | **Length range:** 152-290 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-53      | 10290  | 215 nt |
| 2    | 50-127    | 15540  | 290 nt |
| 3    | 124-183   | 11760  | 236 nt |
| 4    | 180-216   | 6930   | 167 nt |
| 5    | 213-283   | 14070  | 269 nt |
| 6    | 280-353   | 14700  | 278 nt |
| 7    | 350-406   | 11130  | 227 nt |
| 8    | 403-441   | 7350   | 173 nt |
| 9    | 438-486   | 9450   | 203 nt |
| 10   | 487-535   | 9450   | 203 nt |
| 11   | 532-582   | 9870   | 209 nt |
| 12   | 579-632   | 10500  | 218 nt |
| 13   | 629-674   | 8820   | 194 nt |
| 14   | 671-713   | 8190   | 185 nt |
| 15   | 710-770   | 11970  | 239 nt |
| 16   | 767-830   | 12600  | 248 nt |
| 17   | 827-885   | 11550  | 233 nt |
| 18   | 882-940   | 11550  | 233 nt |
| 19   | 937-979   | 8190   | 185 nt |
| 20   | 976-1030  | 10710  | 221 nt |
| 21   | 1027-1062 | 6720   | 164 nt |
| 22   | 1063-1121 | 11550  | 233 nt |
| 23   | 1118-1191 | 14700  | 278 nt |
| 24   | 1188-1255 | 13440  | 260 nt |
| 25   | 1252-1325 | 14700  | 278 nt |
| 26   | 1322-1358 | 6930   | 167 nt |
| 27   | 1355-1407 | 10290  | 215 nt |
| 28   | 1404-1437 | 6300   | 158 nt |
| 29   | 1434-1465 | 5880   | 152 nt |

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
| GC content mean   | 48%                                |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                     | Description                                                   | Result | Detail                                                                                                                                               |
| ------------------------- | ------------------------------------------------------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths             | All oligos within synthesis length limit                      | PASS   | Range: 152-290 nt (limit: 300)                                                                                                                       |
| block_lengths             | All gene blocks within synthesis length limit                 | PASS   | Range: 22-1758 nt (limit: 1800)                                                                                                                      |
| barcode_junction_sites    | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                              |
| barcode_uniqueness        | All barcodes are unique                                       | PASS   | 305130 unique / 305130 total                                                                                                                         |
| tile_coverage             | Tiles cover entire gene without gaps                          | PASS   | 4395 / 4395 nt covered                                                                                                                               |
| variant_count             | Expected number of variants generated                         | PASS   | 30513 unique variants (expected: 30513 across 1453/1463 mutable positions; 27607 missense + 1453 nonsense + 1453 wt_control; 10 position(s) skipped) |
| single_codon_change       | Each non-control variant differs by exactly one codon from WT | PASS   | 290600 / 290600 variants confirmed (WT controls excluded)                                                                                            |
| oligo_gc_content          | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 38.2-67.4% | 0 oligo(s) with extreme GC                                                                                                    |
| domestication_complete    | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                              |
| overhang_fidelity         | Tile boundary overhangs have adequate fidelity                | FAIL   | 27 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                              |
| tile_manifests            | Per-tile assembly manifests complete                          | PASS   | 29 tile manifest(s) generated                                                                                                                        |
| helper_plasmid            | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                   |
| reaction_fidelity         | Per-reaction set-level overhang fidelity                      | FAIL   | Min set fidelity: 0.7487 across 58 reactions | 2 reaction(s) below 0.90                                                                              |
| barcode_poliii_term       | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 305130 barcode(s) contain TTTT                                                                                                                   |
| block_min_length          | All gene blocks above synthesis minimum length                | FAIL   | 16 block(s) below 300 nt minimum. Range: 22-1758 nt                                                                                                  |
| cassette_fragment_lengths | Cassette fragments within synthesis limits                    | FAIL   | 4 cassette fragment(s). Range: 35-1106 nt. 0 over max, 1 under min.                                                                                  |
| sb_overhang_collisions    | Superblock boundary overhangs are unique (no collisions)      | PASS   | 7 SB boundary OH(s), all unique                                                                                                                      |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 7         | 0.8676             |
| 2    | 3        | 1.0000            | 7         | 0.9955             |
| 3    | 3        | 1.0000            | 7         | 0.9970             |
| 4    | 3        | 1.0000            | 7         | 0.9970             |
| 5    | 3        | 1.0000            | 7         | 0.9330             |
| 6    | 3        | 1.0000            | 7         | 0.9970             |
| 7    | 3        | 1.0000            | 6         | 0.9970             |
| 8    | 3        | 1.0000            | 7         | 0.9970             |
| 9    | 3        | 1.0000            | 6         | 0.9970             |
| 10   | 3        | 1.0000            | 6         | 1.0000             |
| 11   | 3        | 0.9472            | 6         | 1.0000             |
| 12   | 3        | 1.0000            | 6         | 0.9984             |
| 13   | 4        | 1.0000            | 6         | 0.9986             |
| 14   | 4        | 1.0000            | 6         | 0.9983             |
| 15   | 4        | 0.9926            | 6         | 0.9979             |
| 16   | 4        | 1.0000            | 5         | 1.0000             |
| 17   | 4        | 1.0000            | 6         | 1.0000             |
| 18   | 4        | 1.0000            | 6         | 0.9917             |
| 19   | 4        | 1.0000            | 6         | 0.9883             |
| 20   | 4        | 1.0000            | 6         | 1.0000             |
| 21   | 4        | 1.0000            | 5         | 1.0000             |
| 22   | 4        | 1.0000            | 7         | 0.9538             |
| 23   | 5        | 1.0000            | 7         | 1.0000             |
| 24   | 5        | 1.0000            | 6         | 0.9983             |
| 25   | 5        | 0.9926            | 7         | 1.0000             |
| 26   | 5        | 0.9175            | 5         | 1.0000             |
| 27   | 5        | 0.9533            | 6         | 1.0000             |
| 28   | 5        | 1.0000            | 6         | 0.7487             |
| 29   | 5        | 1.0000            | 5         | 0.9716             |

**Min:** 0.7487 | **Max:** 1.0000 | **Mean:** 0.9867

**Warning:** 2 reaction(s) below 0.90 fidelity — consider alternative split points or overhang reassignment.
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

### Tile 1 of 29 -- Codons 1-53 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGG     | 0.5393   |
| oh2 (3' boundary) | CCCC     | 0.5515   |

**Variants:** 10290 mutations, 10290 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (10290 oligos)              | 215 nt | ATGG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert              | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart               | --     | --    | --    |

```
  [ATGG]----oligo+BC----[AGAA]
   ATGG                  AGAA 
```

**Set fidelity:** 1.0000 (2 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1      | 1329 nt | CCCC  | TAAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1746 nt | TAAC  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1232 nt | AAAT  | CTAA  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 329 nt  | CTAA  | TCCG  |
| 6   | 3'WT block        | bsmbi_cassette_tile1_sub5 | 482 nt  | TCCG  | TCAA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub6 | 1106 nt | TCAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CCCC]----3'WT sub1----[TAAC]----3'WT sub2----[AAAT]----3'WT sub3----[CTAA]----3'WT sub4----[TCCG]----3'WT sub5----[TCAA]----3'WT+PolIII sub6----[CACC]
   CCCC                   TAAC                   AAAT                   CTAA                   TCCG                   TCAA                          CACC 
```

**Set fidelity:** 0.8676 (7 overhangs)

---

### Tile 2 of 29 -- Codons 50-127 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAC     | 0.6079   |
| oh2 (3' boundary) | CGCA     | 0.4675   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 165 nt | ATGG  | GAAC  |
| 2   | Oligo pool      | Tile 2 (15540 oligos) | 290 nt | GAAC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[GAAC]----oligo+BC----[AGAA]
   ATGG                    GAAC                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1      | 1107 nt | CGCA  | TAAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1746 nt | TAAC  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1232 nt | AAAT  | CTAA  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 329 nt  | CTAA  | TCCG  |
| 6   | 3'WT block        | bsmbi_cassette_tile1_sub5 | 482 nt  | TCCG  | TCAA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub6 | 1106 nt | TCAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CGCA]----3'WT sub1----[TAAC]----3'WT sub2----[AAAT]----3'WT sub3----[CTAA]----3'WT sub4----[TCCG]----3'WT sub5----[TCAA]----3'WT+PolIII sub6----[CACC]
   CGCA                   TAAC                   AAAT                   CTAA                   TCCG                   TCAA                          CACC 
```

**Set fidelity:** 0.9955 (7 overhangs)

---

### Tile 3 of 29 -- Codons 124-183 (180 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCT     | 0.7151   |
| oh2 (3' boundary) | CGTC     | 0.5136   |

**Variants:** 11760 mutations, 11760 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 387 nt | ATGG  | ATCT  |
| 2   | Oligo pool      | Tile 3 (11760 oligos) | 236 nt | ATCT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[ATCT]----oligo+BC----[AGAA]
   ATGG                    ATCT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1      | 939 nt  | CGTC  | TAAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1746 nt | TAAC  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1232 nt | AAAT  | CTAA  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 329 nt  | CTAA  | TCCG  |
| 6   | 3'WT block        | bsmbi_cassette_tile1_sub5 | 482 nt  | TCCG  | TCAA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub6 | 1106 nt | TCAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CGTC]----3'WT sub1----[TAAC]----3'WT sub2----[AAAT]----3'WT sub3----[CTAA]----3'WT sub4----[TCCG]----3'WT sub5----[TCAA]----3'WT+PolIII sub6----[CACC]
   CGTC                   TAAC                   AAAT                   CTAA                   TCCG                   TCAA                          CACC 
```

**Set fidelity:** 0.9970 (7 overhangs)

---

### Tile 4 of 29 -- Codons 180-216 (111 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACA     | 0.8652   |
| oh2 (3' boundary) | GAAG     | 0.6752   |

**Variants:** 6930 mutations, 6930 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 555 nt | ATGG  | TACA  |
| 2   | Oligo pool      | Tile 4 (6930 oligos)  | 167 nt | TACA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[TACA]----oligo+BC----[AGAA]
   ATGG                    TACA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1      | 840 nt  | GAAG  | TAAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1746 nt | TAAC  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1232 nt | AAAT  | CTAA  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 329 nt  | CTAA  | TCCG  |
| 6   | 3'WT block        | bsmbi_cassette_tile1_sub5 | 482 nt  | TCCG  | TCAA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub6 | 1106 nt | TCAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAAG]----3'WT sub1----[TAAC]----3'WT sub2----[AAAT]----3'WT sub3----[CTAA]----3'WT sub4----[TCCG]----3'WT sub5----[TCAA]----3'WT+PolIII sub6----[CACC]
   GAAG                   TAAC                   AAAT                   CTAA                   TCCG                   TCAA                          CACC 
```

**Set fidelity:** 0.9970 (7 overhangs)

---

### Tile 5 of 29 -- Codons 213-283 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCAA     | 0.7543   |
| oh2 (3' boundary) | CAGC     | 0.4815   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 654 nt | ATGG  | GCAA  |
| 2   | Oligo pool      | Tile 5 (14070 oligos) | 269 nt | GCAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[GCAA]----oligo+BC----[AGAA]
   ATGG                    GCAA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1      | 639 nt  | CAGC  | TAAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1746 nt | TAAC  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1232 nt | AAAT  | CTAA  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 329 nt  | CTAA  | TCCG  |
| 6   | 3'WT block        | bsmbi_cassette_tile1_sub5 | 482 nt  | TCCG  | TCAA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub6 | 1106 nt | TCAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CAGC]----3'WT sub1----[TAAC]----3'WT sub2----[AAAT]----3'WT sub3----[CTAA]----3'WT sub4----[TCCG]----3'WT sub5----[TCAA]----3'WT+PolIII sub6----[CACC]
   CAGC                   TAAC                   AAAT                   CTAA                   TCCG                   TCAA                          CACC 
```

**Set fidelity:** 0.9330 (7 overhangs)

---

### Tile 6 of 29 -- Codons 280-353 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCT     | 0.7573   |
| oh2 (3' boundary) | GGTG     | 0.4454   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 855 nt | ATGG  | TCCT  |
| 2   | Oligo pool      | Tile 6 (14700 oligos) | 278 nt | TCCT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[TCCT]----oligo+BC----[AGAA]
   ATGG                    TCCT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1      | 429 nt  | GGTG  | TAAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1746 nt | TAAC  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1232 nt | AAAT  | CTAA  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 329 nt  | CTAA  | TCCG  |
| 6   | 3'WT block        | bsmbi_cassette_tile1_sub5 | 482 nt  | TCCG  | TCAA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub6 | 1106 nt | TCAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GGTG]----3'WT sub1----[TAAC]----3'WT sub2----[AAAT]----3'WT sub3----[CTAA]----3'WT sub4----[TCCG]----3'WT sub5----[TCAA]----3'WT+PolIII sub6----[CACC]
   GGTG                   TAAC                   AAAT                   CTAA                   TCCG                   TCAA                          CACC 
```

**Set fidelity:** 0.9970 (7 overhangs)

---

### Tile 7 of 29 -- Codons 350-406 (171 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCA     | 0.8824   |
| oh2 (3' boundary) | CACC     | 0.4172   |

**Variants:** 11130 mutations, 11130 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 1065 nt | ATGG  | TTCA  |
| 2   | Oligo pool      | Tile 7 (11130 oligos) | 227 nt  | TTCA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[TTCA]----oligo+BC----[AGAA]
   ATGG                    TTCA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1      | 270 nt  | CACC  | TAAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1746 nt | TAAC  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1232 nt | AAAT  | CTAA  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 329 nt  | CTAA  | TCCG  |
| 6   | 3'WT block        | bsmbi_cassette_tile1_sub5 | 482 nt  | TCCG  | TCAA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub6 | 1106 nt | TCAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CACC]----3'WT sub1----[TAAC]----3'WT sub2----[AAAT]----3'WT sub3----[CTAA]----3'WT sub4----[TCCG]----3'WT sub5----[TCAA]----3'WT+PolIII sub6----[CACC]
   CACC                   TAAC                   AAAT                   CTAA                   TCCG                   TCAA                          CACC 
```

**Set fidelity:** 0.9970 (6 overhangs)

---

### Tile 8 of 29 -- Codons 403-441 (117 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GACA     | 0.6127   |
| oh2 (3' boundary) | TTCA     | 0.8824   |

**Variants:** 7350 mutations, 7350 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1224 nt | ATGG  | GACA  |
| 2   | Oligo pool      | Tile 8 (7350 oligos)  | 173 nt  | GACA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[GACA]----oligo+BC----[AGAA]
   ATGG                    GACA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1      | 165 nt  | TTCA  | TAAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1746 nt | TAAC  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1232 nt | AAAT  | CTAA  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 329 nt  | CTAA  | TCCG  |
| 6   | 3'WT block        | bsmbi_cassette_tile1_sub5 | 482 nt  | TCCG  | TCAA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub6 | 1106 nt | TCAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TTCA]----3'WT sub1----[TAAC]----3'WT sub2----[AAAT]----3'WT sub3----[CTAA]----3'WT sub4----[TCCG]----3'WT sub5----[TCAA]----3'WT+PolIII sub6----[CACC]
   TTCA                   TAAC                   AAAT                   CTAA                   TCCG                   TCAA                          CACC 
```

**Set fidelity:** 0.9970 (7 overhangs)

---

### Tile 9 of 29 -- Codons 438-486 (147 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGT     | 0.7629   |
| oh2 (3' boundary) | TAAC     | 0.7715   |

**Variants:** 9450 mutations, 9450 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1329 nt | ATGG  | AAGT  |
| 2   | Oligo pool      | Tile 9 (9450 oligos)  | 203 nt  | AAGT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[AAGT]----oligo+BC----[AGAA]
   ATGG                    AAGT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1      | 1758 nt | TAAC  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1232 nt | AAAT  | CTAA  |
| 4   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 329 nt  | CTAA  | TCCG  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub5 | 482 nt  | TCCG  | TCAA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub6 | 1106 nt | TCAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TAAC]----3'WT sub1----[AAAT]----3'WT sub2----[CTAA]----3'WT sub3----[TCCG]----3'WT sub4----[TCAA]----3'WT+PolIII sub5----[CACC]
   TAAC                   AAAT                   CTAA                   TCCG                   TCAA                          CACC 
```

**Set fidelity:** 0.9970 (6 overhangs)

---

### Tile 10 of 29 -- Codons 487-535 (147 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | AAGA     | 0.9209   |

**Variants:** 9450 mutations, 9450 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10       | 1476 nt | ATGG  | AAGA  |
| 2   | Oligo pool      | Tile 10 (9450 oligos) | 203 nt  | AAGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[AAGA]----oligo+BC----[AGAA]
   ATGG                    AAGA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1     | 1611 nt | AAGA  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1232 nt | AAAT  | CTAA  |
| 4   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 329 nt  | CTAA  | TCCG  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub5 | 482 nt  | TCCG  | TCAA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub6 | 1106 nt | TCAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AAGA]----3'WT sub1----[AAAT]----3'WT sub2----[CTAA]----3'WT sub3----[TCCG]----3'WT sub4----[TCAA]----3'WT+PolIII sub5----[CACC]
   AAGA                   AAAT                   CTAA                   TCCG                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 11 of 29 -- Codons 532-582 (153 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGAA     | 0.7463   |
| oh2 (3' boundary) | CAGA     | 0.8175   |

**Variants:** 9870 mutations, 9870 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1611 nt | ATGG  | GGAA  |
| 2   | Oligo pool      | Tile 11 (9870 oligos) | 209 nt  | GGAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[GGAA]----oligo+BC----[AGAA]
   ATGG                    GGAA                  AGAA 
```

**Set fidelity:** 0.9472 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1     | 1470 nt | CAGA  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1232 nt | AAAT  | CTAA  |
| 4   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 329 nt  | CTAA  | TCCG  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub5 | 482 nt  | TCCG  | TCAA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub6 | 1106 nt | TCAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CAGA]----3'WT sub1----[AAAT]----3'WT sub2----[CTAA]----3'WT sub3----[TCCG]----3'WT sub4----[TCAA]----3'WT+PolIII sub5----[CACC]
   CAGA                   AAAT                   CTAA                   TCCG                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 12 of 29 -- Codons 579-632 (162 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCA     | 0.8824   |
| oh2 (3' boundary) | CTTC     | 0.6384   |

**Variants:** 10500 mutations, 10500 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1752 nt | ATGG  | TTCA  |
| 2   | Oligo pool      | Tile 12 (10500 oligos) | 218 nt  | TTCA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT block----[TTCA]----oligo+BC----[AGAA]
   ATGG                    TTCA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1     | 1320 nt | CTTC  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1232 nt | AAAT  | CTAA  |
| 4   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 329 nt  | CTAA  | TCCG  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub5 | 482 nt  | TCCG  | TCAA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub6 | 1106 nt | TCAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTTC]----3'WT sub1----[AAAT]----3'WT sub2----[CTAA]----3'WT sub3----[TCCG]----3'WT sub4----[TCAA]----3'WT+PolIII sub5----[CACC]
   CTTC                   AAAT                   CTAA                   TCCG                   TCAA                          CACC 
```

**Set fidelity:** 0.9984 (6 overhangs)

---

### Tile 13 of 29 -- Codons 629-674 (138 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCA     | 0.7483   |
| oh2 (3' boundary) | CCCA     | 0.6687   |

**Variants:** 8820 mutations, 8820 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10       | 1476 nt | ATGG  | AAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2  | 444 nt  | AAGA  | ATCA  |
| 3   | Oligo pool      | Tile 13 (8820 oligos) | 194 nt  | ATCA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAGA]----5'WT sub2----[ATCA]----oligo+BC----[AGAA]
   ATGG                   AAGA                   ATCA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1     | 1194 nt | CCCA  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1232 nt | AAAT  | CTAA  |
| 4   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 329 nt  | CTAA  | TCCG  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub5 | 482 nt  | TCCG  | TCAA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub6 | 1106 nt | TCAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CCCA]----3'WT sub1----[AAAT]----3'WT sub2----[CTAA]----3'WT sub3----[TCCG]----3'WT sub4----[TCAA]----3'WT+PolIII sub5----[CACC]
   CCCA                   AAAT                   CTAA                   TCCG                   TCAA                          CACC 
```

**Set fidelity:** 0.9986 (6 overhangs)

---

### Tile 14 of 29 -- Codons 671-713 (129 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAAA     | 0.8948   |
| oh2 (3' boundary) | CTTG     | 0.7594   |

**Variants:** 8190 mutations, 8190 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10       | 1476 nt | ATGG  | AAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2  | 570 nt  | AAGA  | CAAA  |
| 3   | Oligo pool      | Tile 14 (8190 oligos) | 185 nt  | CAAA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAGA]----5'WT sub2----[CAAA]----oligo+BC----[AGAA]
   ATGG                   AAGA                   CAAA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1     | 1077 nt | CTTG  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1232 nt | AAAT  | CTAA  |
| 4   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 329 nt  | CTAA  | TCCG  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub5 | 482 nt  | TCCG  | TCAA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub6 | 1106 nt | TCAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTTG]----3'WT sub1----[AAAT]----3'WT sub2----[CTAA]----3'WT sub3----[TCCG]----3'WT sub4----[TCAA]----3'WT+PolIII sub5----[CACC]
   CTTG                   AAAT                   CTAA                   TCCG                   TCAA                          CACC 
```

**Set fidelity:** 0.9983 (6 overhangs)

---

### Tile 15 of 29 -- Codons 710-770 (183 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGA     | 0.8175   |
| oh2 (3' boundary) | GCAG     | 0.5118   |

**Variants:** 11970 mutations, 11970 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1476 nt | ATGG  | AAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 687 nt  | AAGA  | CAGA  |
| 3   | Oligo pool      | Tile 15 (11970 oligos) | 239 nt  | CAGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAGA]----5'WT sub2----[CAGA]----oligo+BC----[AGAA]
   ATGG                   AAGA                   CAGA                  AGAA 
```

**Set fidelity:** 0.9926 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1     | 906 nt  | GCAG  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1232 nt | AAAT  | CTAA  |
| 4   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 329 nt  | CTAA  | TCCG  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub5 | 482 nt  | TCCG  | TCAA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub6 | 1106 nt | TCAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GCAG]----3'WT sub1----[AAAT]----3'WT sub2----[CTAA]----3'WT sub3----[TCCG]----3'WT sub4----[TCAA]----3'WT+PolIII sub5----[CACC]
   GCAG                   AAAT                   CTAA                   TCCG                   TCAA                          CACC 
```

**Set fidelity:** 0.9979 (6 overhangs)

---

### Tile 16 of 29 -- Codons 767-830 (192 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAG     | 0.7511   |
| oh2 (3' boundary) | CACC     | 0.4172   |

**Variants:** 12600 mutations, 12600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1476 nt | ATGG  | AAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 858 nt  | AAGA  | AAAG  |
| 3   | Oligo pool      | Tile 16 (12600 oligos) | 248 nt  | AAAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAGA]----5'WT sub2----[AAAG]----oligo+BC----[AGAA]
   ATGG                   AAGA                   AAAG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1     | 726 nt  | CACC  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1232 nt | AAAT  | CTAA  |
| 4   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 329 nt  | CTAA  | TCCG  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub5 | 482 nt  | TCCG  | TCAA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub6 | 1106 nt | TCAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CACC]----3'WT sub1----[AAAT]----3'WT sub2----[CTAA]----3'WT sub3----[TCCG]----3'WT sub4----[TCAA]----3'WT+PolIII sub5----[CACC]
   CACC                   AAAT                   CTAA                   TCCG                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 17 of 29 -- Codons 827-885 (177 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCCA     | 0.5727   |
| oh2 (3' boundary) | GGGA     | 0.6194   |

**Variants:** 11550 mutations, 11550 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1476 nt | ATGG  | AAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 1038 nt | AAGA  | GCCA  |
| 3   | Oligo pool      | Tile 17 (11550 oligos) | 233 nt  | GCCA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAGA]----5'WT sub2----[GCCA]----oligo+BC----[AGAA]
   ATGG                   AAGA                   GCCA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1     | 561 nt  | GGGA  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1232 nt | AAAT  | CTAA  |
| 4   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 329 nt  | CTAA  | TCCG  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub5 | 482 nt  | TCCG  | TCAA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub6 | 1106 nt | TCAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GGGA]----3'WT sub1----[AAAT]----3'WT sub2----[CTAA]----3'WT sub3----[TCCG]----3'WT sub4----[TCAA]----3'WT+PolIII sub5----[CACC]
   GGGA                   AAAT                   CTAA                   TCCG                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 18 of 29 -- Codons 882-940 (177 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTC     | 0.8105   |
| oh2 (3' boundary) | CTCA     | 0.6872   |

**Variants:** 11550 mutations, 11550 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1476 nt | ATGG  | AAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1203 nt | AAGA  | TCTC  |
| 3   | Oligo pool      | Tile 18 (11550 oligos) | 233 nt  | TCTC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAGA]----5'WT sub2----[TCTC]----oligo+BC----[AGAA]
   ATGG                   AAGA                   TCTC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1     | 396 nt  | CTCA  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1232 nt | AAAT  | CTAA  |
| 4   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 329 nt  | CTAA  | TCCG  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub5 | 482 nt  | TCCG  | TCAA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub6 | 1106 nt | TCAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTCA]----3'WT sub1----[AAAT]----3'WT sub2----[CTAA]----3'WT sub3----[TCCG]----3'WT sub4----[TCAA]----3'WT+PolIII sub5----[CACC]
   CTCA                   AAAT                   CTAA                   TCCG                   TCAA                          CACC 
```

**Set fidelity:** 0.9917 (6 overhangs)

---

### Tile 19 of 29 -- Codons 937-979 (129 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GATA     | 0.7029   |
| oh2 (3' boundary) | ACAA     | 0.8919   |

**Variants:** 8190 mutations, 8190 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10       | 1476 nt | ATGG  | AAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1368 nt | AAGA  | GATA  |
| 3   | Oligo pool      | Tile 19 (8190 oligos) | 185 nt  | GATA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAGA]----5'WT sub2----[GATA]----oligo+BC----[AGAA]
   ATGG                   AAGA                   GATA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1     | 279 nt  | ACAA  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1232 nt | AAAT  | CTAA  |
| 4   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 329 nt  | CTAA  | TCCG  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub5 | 482 nt  | TCCG  | TCAA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub6 | 1106 nt | TCAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [ACAA]----3'WT sub1----[AAAT]----3'WT sub2----[CTAA]----3'WT sub3----[TCCG]----3'WT sub4----[TCAA]----3'WT+PolIII sub5----[CACC]
   ACAA                   AAAT                   CTAA                   TCCG                   TCAA                          CACC 
```

**Set fidelity:** 0.9883 (6 overhangs)

---

### Tile 20 of 29 -- Codons 976-1030 (165 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATA     | 0.8816   |
| oh2 (3' boundary) | GAGG     | 0.5599   |

**Variants:** 10710 mutations, 10710 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1476 nt | ATGG  | AAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1485 nt | AAGA  | AATA  |
| 3   | Oligo pool      | Tile 20 (10710 oligos) | 221 nt  | AATA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAGA]----5'WT sub2----[AATA]----oligo+BC----[AGAA]
   ATGG                   AAGA                   AATA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1     | 126 nt  | GAGG  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1232 nt | AAAT  | CTAA  |
| 4   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 329 nt  | CTAA  | TCCG  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub5 | 482 nt  | TCCG  | TCAA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub6 | 1106 nt | TCAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAGG]----3'WT sub1----[AAAT]----3'WT sub2----[CTAA]----3'WT sub3----[TCCG]----3'WT sub4----[TCAA]----3'WT+PolIII sub5----[CACC]
   GAGG                   AAAT                   CTAA                   TCCG                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 21 of 29 -- Codons 1027-1062 (108 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCC     | 0.7759   |
| oh2 (3' boundary) | AAAT     | 0.7737   |

**Variants:** 6720 mutations, 6720 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10       | 1476 nt | ATGG  | AAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1638 nt | AAGA  | TCCC  |
| 3   | Oligo pool      | Tile 21 (6720 oligos) | 164 nt  | TCCC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAGA]----5'WT sub2----[TCCC]----oligo+BC----[AGAA]
   ATGG                   AAGA                   TCCC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1     | 30 nt   | AAAT  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1232 nt | AAAT  | CTAA  |
| 4   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 329 nt  | CTAA  | TCCG  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub5 | 482 nt  | TCCG  | TCAA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub6 | 1106 nt | TCAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AAAT]----3'WT sub1----[AAAT]----3'WT sub2----[CTAA]----3'WT sub3----[TCCG]----3'WT sub4----[TCAA]----3'WT+PolIII sub5----[CACC]
   AAAT                   AAAT                   CTAA                   TCCG                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 22 of 29 -- Codons 1063-1121 (177 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | GGAG     | 0.5228   |

**Variants:** 11550 mutations, 11550 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1476 nt | ATGG  | AAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1746 nt | AAGA  | GAAA  |
| 3   | Oligo pool      | Tile 22 (11550 oligos) | 233 nt  | GAAA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAGA]----5'WT sub2----[GAAA]----oligo+BC----[AGAA]
   ATGG                   AAGA                   GAAA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1     | 675 nt  | GGAG  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile22_sub2     | 22 nt   | AAAA  | CAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile22_sub3     | 425 nt  | CAAA  | CTAA  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 329 nt  | CTAA  | TCCG  |
| 6   | 3'WT block        | bsmbi_cassette_tile1_sub5 | 482 nt  | TCCG  | TCAA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub6 | 1106 nt | TCAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GGAG]----3'WT sub1----[AAAA]----3'WT sub2----[CAAA]----3'WT sub3----[CTAA]----3'WT sub4----[TCCG]----3'WT sub5----[TCAA]----3'WT+PolIII sub6----[CACC]
   GGAG                   AAAA                   CAAA                   CTAA                   TCCG                   TCAA                          CACC 
```

**Set fidelity:** 0.9538 (7 overhangs)

---

### Tile 23 of 29 -- Codons 1118-1191 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACA     | 0.8652   |
| oh2 (3' boundary) | AGAC     | 0.5696   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1476 nt | ATGG  | AAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1746 nt | AAGA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 183 nt  | GAAA  | TACA  |
| 4   | Oligo pool      | Tile 23 (14700 oligos) | 278 nt  | TACA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAGA]----5'WT sub2----[GAAA]----5'WT sub3----[TACA]----oligo+BC----[AGAA]
   ATGG                   AAGA                   GAAA                   TACA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1     | 465 nt  | AGAC  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile23_sub2     | 333 nt  | AAAA  | TTTA  |
| 4   | 3'WT block        | bsmbi_3wt_tile23_sub3     | 95 nt   | TTTA  | CTAA  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 329 nt  | CTAA  | TCCG  |
| 6   | 3'WT block        | bsmbi_cassette_tile1_sub5 | 482 nt  | TCCG  | TCAA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub6 | 1106 nt | TCAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AGAC]----3'WT sub1----[AAAA]----3'WT sub2----[TTTA]----3'WT sub3----[CTAA]----3'WT sub4----[TCCG]----3'WT sub5----[TCAA]----3'WT+PolIII sub6----[CACC]
   AGAC                   AAAA                   TTTA                   CTAA                   TCCG                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (7 overhangs)

---

### Tile 24 of 29 -- Codons 1188-1255 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCA     | 0.8519   |
| oh2 (3' boundary) | TAAC     | 0.7715   |

**Variants:** 13440 mutations, 13440 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1476 nt | ATGG  | AAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1746 nt | AAGA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3   | 393 nt  | GAAA  | TCCA  |
| 4   | Oligo pool      | Tile 24 (13440 oligos) | 260 nt  | TCCA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAGA]----5'WT sub2----[GAAA]----5'WT sub3----[TCCA]----oligo+BC----[AGAA]
   ATGG                   AAGA                   GAAA                   TCCA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile24_sub1     | 588 nt  | TAAC  | TTTA  |
| 3   | 3'WT block        | bsmbi_3wt_tile23_sub3     | 95 nt   | TTTA  | CTAA  |
| 4   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 329 nt  | CTAA  | TCCG  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub5 | 482 nt  | TCCG  | TCAA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub6 | 1106 nt | TCAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TAAC]----3'WT sub1----[TTTA]----3'WT sub2----[CTAA]----3'WT sub3----[TCCG]----3'WT sub4----[TCAA]----3'WT+PolIII sub5----[CACC]
   TAAC                   TTTA                   CTAA                   TCCG                   TCAA                          CACC 
```

**Set fidelity:** 0.9983 (6 overhangs)

---

### Tile 25 of 29 -- Codons 1252-1325 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGA     | 0.8175   |
| oh2 (3' boundary) | GTTT     | 0.5873   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1476 nt | ATGG  | AAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1746 nt | AAGA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3   | 585 nt  | GAAA  | CAGA  |
| 4   | Oligo pool      | Tile 25 (14700 oligos) | 278 nt  | CAGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAGA]----5'WT sub2----[GAAA]----5'WT sub3----[CAGA]----oligo+BC----[AGAA]
   ATGG                   AAGA                   GAAA                   CAGA                  AGAA 
```

**Set fidelity:** 0.9926 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile25_sub1     | 378 nt  | GTTT  | TTTA  |
| 3   | 3'WT block        | bsmbi_3wt_tile25_sub2     | 36 nt   | TTTA  | TAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile25_sub3     | 77 nt   | TAGA  | CTAA  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 329 nt  | CTAA  | TCCG  |
| 6   | 3'WT block        | bsmbi_cassette_tile1_sub5 | 482 nt  | TCCG  | TCAA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub6 | 1106 nt | TCAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GTTT]----3'WT sub1----[TTTA]----3'WT sub2----[TAGA]----3'WT sub3----[CTAA]----3'WT sub4----[TCCG]----3'WT sub5----[TCAA]----3'WT+PolIII sub6----[CACC]
   GTTT                   TTTA                   TAGA                   CTAA                   TCCG                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (7 overhangs)

---

### Tile 26 of 29 -- Codons 1322-1358 (111 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGAA     | 0.7463   |
| oh2 (3' boundary) | CACC     | 0.4172   |

**Variants:** 6930 mutations, 6930 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10       | 1476 nt | ATGG  | AAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2  | 1746 nt | AAGA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3  | 795 nt  | GAAA  | GGAA  |
| 4   | Oligo pool      | Tile 26 (6930 oligos) | 167 nt  | GGAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAGA]----5'WT sub2----[GAAA]----5'WT sub3----[GGAA]----oligo+BC----[AGAA]
   ATGG                   AAGA                   GAAA                   GGAA                  AGAA 
```

**Set fidelity:** 0.9175 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile26_sub1     | 297 nt  | CACC  | TAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile25_sub3     | 77 nt   | TAGA  | CTAA  |
| 4   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 329 nt  | CTAA  | TCCG  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub5 | 482 nt  | TCCG  | TCAA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub6 | 1106 nt | TCAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CACC]----3'WT sub1----[TAGA]----3'WT sub2----[CTAA]----3'WT sub3----[TCCG]----3'WT sub4----[TCAA]----3'WT+PolIII sub5----[CACC]
   CACC                   TAGA                   CTAA                   TCCG                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 27 of 29 -- Codons 1355-1407 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGT     | 0.7629   |
| oh2 (3' boundary) | GTAC     | 0.5840   |

**Variants:** 10290 mutations, 10290 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1476 nt | ATGG  | AAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1746 nt | AAGA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 894 nt  | GAAA  | AAGT  |
| 4   | Oligo pool      | Tile 27 (10290 oligos) | 215 nt  | AAGT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAGA]----5'WT sub2----[GAAA]----5'WT sub3----[AAGT]----oligo+BC----[AGAA]
   ATGG                   AAGA                   GAAA                   AAGT                  AGAA 
```

**Set fidelity:** 0.9533 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile27_sub1     | 165 nt  | GTAC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile27_sub2     | 62 nt   | GAAA  | CTAA  |
| 4   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 329 nt  | CTAA  | TCCG  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub5 | 482 nt  | TCCG  | TCAA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub6 | 1106 nt | TCAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GTAC]----3'WT sub1----[GAAA]----3'WT sub2----[CTAA]----3'WT sub3----[TCCG]----3'WT sub4----[TCAA]----3'WT+PolIII sub5----[CACC]
   GTAC                   GAAA                   CTAA                   TCCG                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 28 of 29 -- Codons 1404-1437 (102 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCT     | 0.7573   |
| oh2 (3' boundary) | TACC     | 0.7054   |

**Variants:** 6300 mutations, 6300 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10       | 1476 nt | ATGG  | AAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2  | 1746 nt | AAGA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3  | 1041 nt | GAAA  | TCCT  |
| 4   | Oligo pool      | Tile 28 (6300 oligos) | 158 nt  | TCCT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAGA]----5'WT sub2----[GAAA]----5'WT sub3----[TCCT]----oligo+BC----[AGAA]
   ATGG                   AAGA                   GAAA                   TCCT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile28_sub1     | 75 nt   | TACC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile27_sub2     | 62 nt   | GAAA  | CTAA  |
| 4   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 329 nt  | CTAA  | TCCG  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub5 | 482 nt  | TCCG  | TCAA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub6 | 1106 nt | TCAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TACC]----3'WT sub1----[GAAA]----3'WT sub2----[CTAA]----3'WT sub3----[TCCG]----3'WT sub4----[TCAA]----3'WT+PolIII sub5----[CACC]
   TACC                   GAAA                   CTAA                   TCCG                   TCAA                          CACC 
```

**Set fidelity:** 0.7487 (6 overhangs)

---

### Tile 29 of 29 -- Codons 1434-1465 (96 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATA     | 0.8816   |
| oh2 (3' boundary) | TTAA     | 0.9448   |

**Variants:** 5880 mutations, 5880 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10       | 1476 nt | ATGG  | AAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2  | 1746 nt | AAGA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile29_sub3  | 1131 nt | GAAA  | AATA  |
| 4   | Oligo pool      | Tile 29 (5880 oligos) | 152 nt  | AATA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAGA]----5'WT sub2----[GAAA]----5'WT sub3----[AATA]----oligo+BC----[AGAA]
   ATGG                   AAGA                   GAAA                   AATA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                  | Length  | 5' OH | 3' OH |
| --- | ----------------- | -------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)        | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_cassette_tile29_sub1 | 35 nt   | TTAA  | CTAA  |
| 3   | 3'WT block        | bsmbi_cassette_tile1_sub4  | 329 nt  | CTAA  | TCCG  |
| 4   | 3'WT block        | bsmbi_cassette_tile1_sub5  | 482 nt  | TCCG  | TCAA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub6  | 1106 nt | TCAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1   | --      | --    | --    |

```
  [TTAA]----3'WT sub1----[CTAA]----3'WT sub2----[TCCG]----3'WT sub3----[TCAA]----3'WT+PolIII sub4----[CACC]
   TTAA                   CTAA                   TCCG                   TCAA                          CACC 
```

**Set fidelity:** 0.9716 (5 overhangs)

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
[PaqCI** AATG]--[gene+mutation]--[P2A_EGFP]--[WPRE]--[spacer]--[bGH_polyA]--[PolIII]--[barcode]--[PaqCI* GCTA]
```

## 9. Gene Block Order Sheet

Order these gene blocks as synthesized gene fragments (e.g., Twist gene fragments, IDT gBlocks).
Gene blocks are synthesized once and reused across experiments.

**Total blocks:** 69

| Block name                 | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| -------------------------- | ----------- | ----------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10            | 1476        | BsaI        | 5wt_tile10;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1;5wt_tile26_sub1;5wt_tile27_sub1;5wt_tile28_sub1;5wt_tile29_sub1                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile11_sub1       | 1611        | BsaI        | 5wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile12_sub1       | 1752        | BsaI        | 5wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile13_sub2       | 444         | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile14_sub2       | 570         | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile15_sub2       | 687         | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile16_sub2       | 858         | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile17_sub2       | 1038        | BsaI        | 5wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile18_sub2       | 1203        | BsaI        | 5wt_tile18_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile19_sub2       | 1368        | BsaI        | 5wt_tile19_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile2             | 165         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile20_sub2       | 1485        | BsaI        | 5wt_tile20_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile21_sub2       | 1638        | BsaI        | 5wt_tile21_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile22_sub2       | 1746        | BsaI        | 5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2;5wt_tile26_sub2;5wt_tile27_sub2;5wt_tile28_sub2;5wt_tile29_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile23_sub3       | 183         | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile24_sub3       | 393         | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile25_sub3       | 585         | BsaI        | 5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile26_sub3       | 795         | BsaI        | 5wt_tile26_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile27_sub3       | 894         | BsaI        | 5wt_tile27_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile28_sub3       | 1041        | BsaI        | 5wt_tile28_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile29_sub3       | 1131        | BsaI        | 5wt_tile29_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile3             | 387         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile4             | 555         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile5             | 654         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile6             | 855         | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile7             | 1065        | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile8             | 1224        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile9             | 1329        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile1_sub1       | 1329        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile1_sub2       | 1746        | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile8_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile1_sub3       | 1232        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub3;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2;3wt_tile16_sub2;3wt_tile17_sub2;3wt_tile18_sub2;3wt_tile19_sub2;3wt_tile20_sub2;3wt_tile21_sub2                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile10_sub1      | 1611        | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile11_sub1      | 1470        | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile12_sub1      | 1320        | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile13_sub1      | 1194        | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile14_sub1      | 1077        | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile15_sub1      | 906         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile16_sub1      | 726         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile17_sub1      | 561         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile18_sub1      | 396         | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile19_sub1      | 279         | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile2_sub1       | 1107        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile20_sub1      | 126         | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile21_sub1      | 30          | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile22_sub1      | 675         | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile22_sub2      | 22          | BsmBI       | 3wt_tile22_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile22_sub3      | 425         | BsmBI       | 3wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile23_sub1      | 465         | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile23_sub2      | 333         | BsmBI       | 3wt_tile23_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile23_sub3      | 95          | BsmBI       | 3wt_tile23_sub3;3wt_tile24_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile24_sub1      | 588         | BsmBI       | 3wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile25_sub1      | 378         | BsmBI       | 3wt_tile25_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile25_sub2      | 36          | BsmBI       | 3wt_tile25_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile25_sub3      | 77          | BsmBI       | 3wt_tile25_sub3;3wt_tile26_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile26_sub1      | 297         | BsmBI       | 3wt_tile26_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile27_sub1      | 165         | BsmBI       | 3wt_tile27_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile27_sub2      | 62          | BsmBI       | 3wt_tile27_sub2;3wt_tile28_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile28_sub1      | 75          | BsmBI       | 3wt_tile28_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile3_sub1       | 939         | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile4_sub1       | 840         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile5_sub1       | 639         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile6_sub1       | 429         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile7_sub1       | 270         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile8_sub1       | 165         | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile9_sub1       | 1758        | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_cassette_tile1_sub4  | 329         | BsmBI       | cassette_tile1_frag1;cassette_tile2_frag1;cassette_tile3_frag1;cassette_tile4_frag1;cassette_tile5_frag1;cassette_tile6_frag1;cassette_tile7_frag1;cassette_tile8_frag1;cassette_tile9_frag1;cassette_tile10_frag1;cassette_tile11_frag1;cassette_tile12_frag1;cassette_tile13_frag1;cassette_tile14_frag1;cassette_tile15_frag1;cassette_tile16_frag1;cassette_tile17_frag1;cassette_tile18_frag1;cassette_tile19_frag1;cassette_tile20_frag1;cassette_tile21_frag1;cassette_tile22_frag1;cassette_tile23_frag1;cassette_tile24_frag1;cassette_tile25_frag1;cassette_tile26_frag1;cassette_tile27_frag1;cassette_tile28_frag1;cassette_tile29_frag2 |
| bsmbi_cassette_tile1_sub5  | 482         | BsmBI       | cassette_tile1_frag2;cassette_tile2_frag2;cassette_tile3_frag2;cassette_tile4_frag2;cassette_tile5_frag2;cassette_tile6_frag2;cassette_tile7_frag2;cassette_tile8_frag2;cassette_tile9_frag2;cassette_tile10_frag2;cassette_tile11_frag2;cassette_tile12_frag2;cassette_tile13_frag2;cassette_tile14_frag2;cassette_tile15_frag2;cassette_tile16_frag2;cassette_tile17_frag2;cassette_tile18_frag2;cassette_tile19_frag2;cassette_tile20_frag2;cassette_tile21_frag2;cassette_tile22_frag2;cassette_tile23_frag2;cassette_tile24_frag2;cassette_tile25_frag2;cassette_tile26_frag2;cassette_tile27_frag2;cassette_tile28_frag2;cassette_tile29_frag3 |
| bsmbi_cassette_tile1_sub6  | 1106        | BsmBI       | cassette_tile1_frag3;cassette_tile2_frag3;cassette_tile3_frag3;cassette_tile4_frag3;cassette_tile5_frag3;cassette_tile6_frag3;cassette_tile7_frag3;cassette_tile8_frag3;cassette_tile9_frag3;cassette_tile10_frag3;cassette_tile11_frag3;cassette_tile12_frag3;cassette_tile13_frag3;cassette_tile14_frag3;cassette_tile15_frag3;cassette_tile16_frag3;cassette_tile17_frag3;cassette_tile18_frag3;cassette_tile19_frag3;cassette_tile20_frag3;cassette_tile21_frag3;cassette_tile22_frag3;cassette_tile23_frag3;cassette_tile24_frag3;cassette_tile25_frag3;cassette_tile26_frag3;cassette_tile27_frag3;cassette_tile28_frag3;cassette_tile29_frag4 |
| bsmbi_cassette_tile29_sub1 | 35          | BsmBI       | cassette_tile29_frag1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |

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

