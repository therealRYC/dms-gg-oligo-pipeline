# DMS-GG Assembly Report: GRIN2A

Generated: 2026-03-12 07:50:41
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                          |
| -------------------- | ------------------------------------------------------------------------------ |
| Gene name            | GRIN2A_NM_000833.5 Human GRIN2A native CDS (NM_000833.5, NP_000824.1, 1464 aa) |
| CDS length           | 4395 nt (1465 codons)                                                          |
| Protein length       | 1464 aa                                                                        |
| Number of tiles      | 27                                                                             |
| Total variants       | 28665                                                                          |
| Total oligos         | 286650                                                                         |
| Oligo length range   | 137-287 nt                                                                     |
| Gene blocks to order | 59                                                                             |
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

**Total oligos:** 286650 | **Length range:** 137-287 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-46      | 8820   | 194 nt |
| 2    | 47-123    | 15330  | 287 nt |
| 3    | 124-179   | 10920  | 224 nt |
| 4    | 180-229   | 9660   | 206 nt |
| 5    | 230-279   | 9660   | 206 nt |
| 6    | 280-349   | 13860  | 266 nt |
| 7    | 350-402   | 10290  | 215 nt |
| 8    | 403-471   | 13650  | 263 nt |
| 9    | 472-537   | 13020  | 254 nt |
| 10   | 538-592   | 10710  | 221 nt |
| 11   | 589-628   | 7560   | 176 nt |
| 12   | 629-699   | 14070  | 269 nt |
| 13   | 700-766   | 13230  | 257 nt |
| 14   | 767-807   | 7770   | 179 nt |
| 15   | 808-881   | 14700  | 278 nt |
| 16   | 882-925   | 8400   | 188 nt |
| 17   | 926-990   | 12810  | 251 nt |
| 18   | 991-1025  | 6510   | 161 nt |
| 19   | 1026-1066 | 7770   | 179 nt |
| 20   | 1063-1127 | 12810  | 251 nt |
| 21   | 1128-1171 | 8400   | 188 nt |
| 22   | 1172-1224 | 10290  | 215 nt |
| 23   | 1225-1277 | 10290  | 215 nt |
| 24   | 1278-1354 | 15330  | 287 nt |
| 25   | 1355-1406 | 10080  | 212 nt |
| 26   | 1407-1433 | 4830   | 137 nt |
| 27   | 1434-1465 | 5880   | 152 nt |

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
| Total barcodes    | 286650                             |
| Unique barcodes   | 286650                             |
| GC content range  | 25% - 75%                          |
| GC content mean   | 47.9%                              |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                     | Description                                                   | Result | Detail                                                                                                                                               |
| ------------------------- | ------------------------------------------------------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths             | All oligos within synthesis length limit                      | PASS   | Range: 137-287 nt (limit: 300)                                                                                                                       |
| block_lengths             | All gene blocks within synthesis length limit                 | PASS   | Range: 130-1790 nt (limit: 1800)                                                                                                                     |
| barcode_junction_sites    | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                              |
| barcode_uniqueness        | All barcodes are unique                                       | PASS   | 286650 unique / 286650 total                                                                                                                         |
| tile_coverage             | Tiles cover entire gene without gaps                          | PASS   | 4395 / 4395 nt covered                                                                                                                               |
| variant_count             | Expected number of variants generated                         | PASS   | 28665 unique variants (expected: 28665 across 1365/1463 mutable positions; 25935 missense + 1365 nonsense + 1365 wt_control; 98 position(s) skipped) |
| single_codon_change       | Each non-control variant differs by exactly one codon from WT | PASS   | 273000 / 273000 variants confirmed (WT controls excluded)                                                                                            |
| oligo_gc_content          | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 38.2-66.5% | 0 oligo(s) with extreme GC                                                                                                    |
| domestication_complete    | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                              |
| overhang_fidelity         | Tile boundary overhangs have adequate fidelity                | FAIL   | 22 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                              |
| tile_manifests            | Per-tile assembly manifests complete                          | PASS   | 27 tile manifest(s) generated                                                                                                                        |
| helper_plasmid            | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                   |
| reaction_fidelity         | Per-reaction set-level overhang fidelity                      | PASS   | Min set fidelity: 0.894 across 54 reactions | 1 reaction(s) below 0.90                                                                               |
| barcode_poliii_term       | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 286650 barcode(s) contain TTTT                                                                                                                   |
| block_min_length          | All gene blocks above synthesis minimum length                | FAIL   | 4 block(s) below 300 nt minimum. Range: 130-1790 nt                                                                                                  |
| cassette_fragment_lengths | Cassette fragments within synthesis limits                    | PASS   | 1 cassette fragment(s). Range: 1079-1079 nt. 0 over max, 0 under min.                                                                                |
| sb_overhang_collisions    | Superblock boundary overhangs are unique (no collisions)      | PASS   | 3 SB boundary OH(s), all unique                                                                                                                      |
| gene_reconstruct          | Gene reconstruction from tiles matches original CDS           | PASS   | All 3 SB junction OH(s) match gene sequence; reconstructed gene (4395 nt) matches CDS                                                                |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 5         | 1.0000             |
| 2    | 3        | 1.0000            | 5         | 1.0000             |
| 3    | 3        | 1.0000            | 5         | 1.0000             |
| 4    | 3        | 1.0000            | 5         | 0.9988             |
| 5    | 3        | 1.0000            | 5         | 1.0000             |
| 6    | 3        | 1.0000            | 5         | 0.9596             |
| 7    | 3        | 1.0000            | 5         | 1.0000             |
| 8    | 3        | 1.0000            | 5         | 1.0000             |
| 9    | 3        | 1.0000            | 4         | 0.9010             |
| 10   | 3        | 1.0000            | 4         | 1.0000             |
| 11   | 3        | 1.0000            | 4         | 1.0000             |
| 12   | 4        | 1.0000            | 4         | 1.0000             |
| 13   | 4        | 1.0000            | 4         | 1.0000             |
| 14   | 4        | 1.0000            | 4         | 1.0000             |
| 15   | 4        | 0.8940            | 4         | 0.9984             |
| 16   | 4        | 1.0000            | 4         | 0.9988             |
| 17   | 4        | 0.9986            | 4         | 0.9970             |
| 18   | 4        | 1.0000            | 4         | 0.9018             |
| 19   | 4        | 1.0000            | 3         | 1.0000             |
| 20   | 3        | 1.0000            | 3         | 1.0000             |
| 21   | 4        | 1.0000            | 3         | 1.0000             |
| 22   | 5        | 1.0000            | 3         | 0.9984             |
| 23   | 5        | 1.0000            | 2         | 1.0000             |
| 24   | 5        | 0.9599            | 2         | 1.0000             |
| 25   | 5        | 0.9837            | 2         | 1.0000             |
| 26   | 5        | 1.0000            | 2         | 1.0000             |
| 27   | 5        | 1.0000            | 2         | 1.0000             |

**Min:** 0.8940 | **Max:** 1.0000 | **Mean:** 0.9924

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

### Tile 1 of 27 -- Codons 1-46 (138 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGG     | 0.5393   |
| oh2 (3' boundary) | CGAA     | 0.7461   |

**Variants:** 8820 mutations, 8820 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (8820 oligos)               | 194 nt | ATGG  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1      | 1656 nt | CGAA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1440 nt | GAAA  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1248 nt | AAAT  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1079 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CGAA]----3'WT sub1----[GAAA]----3'WT sub2----[AAAT]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   CGAA                   GAAA                   AAAT                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 2 of 27 -- Codons 47-123 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACAG     | 0.5793   |
| oh2 (3' boundary) | CATT     | 0.6770   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 156 nt | ATGG  | ACAG  |
| 2   | Oligo pool      | Tile 2 (15330 oligos) | 287 nt | ACAG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[ACAG]----oligo+BC----[AGAA]
   ATGG                    ACAG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1      | 1425 nt | CATT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1440 nt | GAAA  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1248 nt | AAAT  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1079 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CATT]----3'WT sub1----[GAAA]----3'WT sub2----[AAAT]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   CATT                   GAAA                   AAAT                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 3 of 27 -- Codons 124-179 (168 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCT     | 0.7151   |
| oh2 (3' boundary) | ATTC     | 0.7084   |

**Variants:** 10920 mutations, 10920 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 387 nt | ATGG  | ATCT  |
| 2   | Oligo pool      | Tile 3 (10920 oligos) | 224 nt | ATCT  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1      | 1257 nt | ATTC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1440 nt | GAAA  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1248 nt | AAAT  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1079 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [ATTC]----3'WT sub1----[GAAA]----3'WT sub2----[AAAT]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   ATTC                   GAAA                   AAAT                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 4 of 27 -- Codons 180-229 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACA     | 0.8652   |
| oh2 (3' boundary) | CAAA     | 0.8948   |

**Variants:** 9660 mutations, 9660 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 555 nt | ATGG  | TACA  |
| 2   | Oligo pool      | Tile 4 (9660 oligos)  | 206 nt | TACA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1      | 1107 nt | CAAA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1440 nt | GAAA  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1248 nt | AAAT  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1079 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CAAA]----3'WT sub1----[GAAA]----3'WT sub2----[AAAT]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   CAAA                   GAAA                   AAAT                   AAGA                          CACC 
```

**Set fidelity:** 0.9988 (5 overhangs)

---

### Tile 5 of 27 -- Codons 230-279 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACT     | 0.7445   |
| oh2 (3' boundary) | TGAC     | 0.6485   |

**Variants:** 9660 mutations, 9660 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 705 nt | ATGG  | TACT  |
| 2   | Oligo pool      | Tile 5 (9660 oligos)  | 206 nt | TACT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[TACT]----oligo+BC----[AGAA]
   ATGG                    TACT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1      | 957 nt  | TGAC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1440 nt | GAAA  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1248 nt | AAAT  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1079 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGAC]----3'WT sub1----[GAAA]----3'WT sub2----[AAAT]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   TGAC                   GAAA                   AAAT                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 6 of 27 -- Codons 280-349 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCT     | 0.7573   |
| oh2 (3' boundary) | GGAA     | 0.7463   |

**Variants:** 13860 mutations, 13860 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 855 nt | ATGG  | TCCT  |
| 2   | Oligo pool      | Tile 6 (13860 oligos) | 266 nt | TCCT  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1      | 747 nt  | GGAA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1440 nt | GAAA  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1248 nt | AAAT  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1079 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GGAA]----3'WT sub1----[GAAA]----3'WT sub2----[AAAT]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   GGAA                   GAAA                   AAAT                   AAGA                          CACC 
```

**Set fidelity:** 0.9596 (5 overhangs)

---

### Tile 7 of 27 -- Codons 350-402 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCA     | 0.8824   |
| oh2 (3' boundary) | TCTC     | 0.8105   |

**Variants:** 10290 mutations, 10290 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 1065 nt | ATGG  | TTCA  |
| 2   | Oligo pool      | Tile 7 (10290 oligos) | 215 nt  | TTCA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1      | 588 nt  | TCTC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1440 nt | GAAA  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1248 nt | AAAT  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1079 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TCTC]----3'WT sub1----[GAAA]----3'WT sub2----[AAAT]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   TCTC                   GAAA                   AAAT                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 8 of 27 -- Codons 403-471 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GACA     | 0.6127   |
| oh2 (3' boundary) | TTAC     | 0.8333   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1224 nt | ATGG  | GACA  |
| 2   | Oligo pool      | Tile 8 (13650 oligos) | 263 nt  | GACA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1      | 381 nt  | TTAC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1440 nt | GAAA  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1248 nt | AAAT  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1079 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TTAC]----3'WT sub1----[GAAA]----3'WT sub2----[AAAT]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   TTAC                   GAAA                   AAAT                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 9 of 27 -- Codons 472-537 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGT     | 0.7629   |
| oh2 (3' boundary) | TAAT     | 0.8165   |

**Variants:** 13020 mutations, 13020 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1431 nt | ATGG  | AAGT  |
| 2   | Oligo pool      | Tile 9 (13020 oligos) | 254 nt  | AAGT  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1      | 1605 nt | TAAT  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1248 nt | AAAT  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1079 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TAAT]----3'WT sub1----[AAAT]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   TAAT                   AAAT                   AAGA                          CACC 
```

**Set fidelity:** 0.9010 (4 overhangs)

---

### Tile 10 of 27 -- Codons 538-592 (165 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAA     | 0.9425   |
| oh2 (3' boundary) | GAAA     | 0.8745   |

**Variants:** 10710 mutations, 10710 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1629 nt | ATGG  | TCAA  |
| 2   | Oligo pool      | Tile 10 (10710 oligos) | 221 nt  | TCAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT block----[TCAA]----oligo+BC----[AGAA]
   ATGG                    TCAA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1440 nt | GAAA  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1248 nt | AAAT  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1079 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAAA]----3'WT sub1----[AAAT]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   GAAA                   AAAT                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 11 of 27 -- Codons 589-628 (120 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCCA     | 0.5727   |
| oh2 (3' boundary) | ATCT     | 0.7151   |

**Variants:** 7560 mutations, 7560 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11       | 1782 nt | ATGG  | GCCA  |
| 2   | Oligo pool      | Tile 11 (7560 oligos) | 176 nt  | GCCA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[GCCA]----oligo+BC----[AGAA]
   ATGG                    GCCA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1     | 1332 nt | ATCT  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1248 nt | AAAT  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1079 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [ATCT]----3'WT sub1----[AAAT]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   ATCT                   AAAT                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 12 of 27 -- Codons 629-699 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCA     | 0.7483   |
| oh2 (3' boundary) | TCAG     | 0.7814   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1790 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2   | 130 nt  | GAAA  | ATCA  |
| 3   | Oligo pool      | Tile 12 (14070 oligos) | 269 nt  | ATCA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[ATCA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   ATCA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1     | 1119 nt | TCAG  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1248 nt | AAAT  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1079 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TCAG]----3'WT sub1----[AAAT]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   TCAG                   AAAT                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 13 of 27 -- Codons 700-766 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACA     | 0.8652   |
| oh2 (3' boundary) | TCCT     | 0.7573   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1790 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 343 nt  | GAAA  | TACA  |
| 3   | Oligo pool      | Tile 13 (13230 oligos) | 257 nt  | TACA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[TACA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   TACA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1     | 918 nt  | TCCT  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1248 nt | AAAT  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1079 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TCCT]----3'WT sub1----[AAAT]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   TCCT                   AAAT                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 14 of 27 -- Codons 767-807 (123 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAG     | 0.7511   |
| oh2 (3' boundary) | CCAG     | 0.6122   |

**Variants:** 7770 mutations, 7770 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1790 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2  | 544 nt  | GAAA  | AAAG  |
| 3   | Oligo pool      | Tile 14 (7770 oligos) | 179 nt  | AAAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAG]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1     | 795 nt  | CCAG  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1248 nt | AAAT  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1079 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CCAG]----3'WT sub1----[AAAT]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   CCAG                   AAAT                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 15 of 27 -- Codons 808-881 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGA     | 0.7549   |
| oh2 (3' boundary) | CTTC     | 0.6384   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1790 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 667 nt  | GAAA  | ATGA  |
| 3   | Oligo pool      | Tile 15 (14700 oligos) | 278 nt  | ATGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[ATGA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   ATGA                  AGAA 
```

**Set fidelity:** 0.8940 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1     | 573 nt  | CTTC  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1248 nt | AAAT  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1079 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTTC]----3'WT sub1----[AAAT]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   CTTC                   AAAT                   AAGA                          CACC 
```

**Set fidelity:** 0.9984 (4 overhangs)

---

### Tile 16 of 27 -- Codons 882-925 (132 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTC     | 0.8105   |
| oh2 (3' boundary) | TTCC     | 0.7958   |

**Variants:** 8400 mutations, 8400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1790 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 889 nt  | GAAA  | TCTC  |
| 3   | Oligo pool      | Tile 16 (8400 oligos) | 188 nt  | TCTC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[TCTC]----oligo+BC----[AGAA]
   ATGG                   GAAA                   TCTC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1     | 441 nt  | TTCC  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1248 nt | AAAT  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1079 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TTCC]----3'WT sub1----[AAAT]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   TTCC                   AAAT                   AAGA                          CACC 
```

**Set fidelity:** 0.9988 (4 overhangs)

---

### Tile 17 of 27 -- Codons 926-990 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAAA     | 0.8948   |
| oh2 (3' boundary) | TAAC     | 0.7715   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1790 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 1021 nt | GAAA  | CAAA  |
| 3   | Oligo pool      | Tile 17 (12810 oligos) | 251 nt  | CAAA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[CAAA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   CAAA                  AGAA 
```

**Set fidelity:** 0.9986 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1     | 246 nt  | TAAC  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1248 nt | AAAT  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1079 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TAAC]----3'WT sub1----[AAAT]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   TAAC                   AAAT                   AAGA                          CACC 
```

**Set fidelity:** 0.9970 (4 overhangs)

---

### Tile 18 of 27 -- Codons 991-1025 (105 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCA     | 0.8519   |
| oh2 (3' boundary) | GAAT     | 0.7246   |

**Variants:** 6510 mutations, 6510 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1790 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1216 nt | GAAA  | TCCA  |
| 3   | Oligo pool      | Tile 18 (6510 oligos) | 161 nt  | TCCA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[TCCA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   TCCA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1     | 141 nt  | GAAT  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1248 nt | AAAT  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1079 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAAT]----3'WT sub1----[AAAT]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   GAAT                   AAAT                   AAGA                          CACC 
```

**Set fidelity:** 0.9018 (4 overhangs)

---

### Tile 19 of 27 -- Codons 1026-1066 (123 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTAT     | 0.7299   |
| oh2 (3' boundary) | AAAT     | 0.7737   |

**Variants:** 7770 mutations, 7770 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1790 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1321 nt | GAAA  | CTAT  |
| 3   | Oligo pool      | Tile 19 (7770 oligos) | 179 nt  | CTAT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[CTAT]----oligo+BC----[AGAA]
   ATGG                   GAAA                   CTAT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1    | 654 nt  | AAAT  | TCAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile19_sub2    | 1673 nt | TCAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAT]----3'WT sub1----[TCAA]----3'WT+PolIII sub2----[CACC]
   AAAT                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 20 of 27 -- Codons 1063-1127 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | AGAT     | 0.6825   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1790 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1432 nt | GAAA  | GAAA  |
| 3   | Oligo pool      | Tile 20 (12810 oligos) | 251 nt  | GAAA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   GAAA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1    | 657 nt  | AGAT  | AAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile20_sub2    | 1487 nt | AAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAT]----3'WT sub1----[AAAA]----3'WT+PolIII sub2----[CACC]
   AGAT                   AAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 21 of 27 -- Codons 1128-1171 (132 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCC     | 0.7958   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 8400 mutations, 8400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1790 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1627 nt | GAAA  | TTCC  |
| 3   | Oligo pool      | Tile 21 (8400 oligos) | 188 nt  | TTCC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[TTCC]----oligo+BC----[AGAA]
   ATGG                   GAAA                   TTCC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1    | 525 nt  | TGAA  | AAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile20_sub2    | 1487 nt | AAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[AAAA]----3'WT+PolIII sub2----[CACC]
   TGAA                   AAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 22 of 27 -- Codons 1172-1224 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTGC     | 0.7336   |
| oh2 (3' boundary) | CTTC     | 0.6384   |

**Variants:** 10290 mutations, 10290 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1790 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1440 nt | GAAA  | AAAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 337 nt  | AAAT  | TTGC  |
| 4   | Oligo pool      | Tile 22 (10290 oligos) | 215 nt  | TTGC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAT]----5'WT sub3----[TTGC]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAT                   TTGC                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1    | 366 nt  | CTTC  | AAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile20_sub2    | 1487 nt | AAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTTC]----3'WT sub1----[AAAA]----3'WT+PolIII sub2----[CACC]
   CTTC                   AAAA                          CACC 
```

**Set fidelity:** 0.9984 (3 overhangs)

---

### Tile 23 of 27 -- Codons 1225-1277 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAG     | 0.7814   |
| oh2 (3' boundary) | AAAG     | 0.7511   |

**Variants:** 10290 mutations, 10290 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1790 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1440 nt | GAAA  | AAAT  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 496 nt  | AAAT  | TCAG  |
| 4   | Oligo pool      | Tile 23 (10290 oligos) | 215 nt  | TCAG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAT]----5'WT sub3----[TCAG]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAT                   TCAG                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile23         | 1676 nt | AAAG  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAG]----3'WT+PolIII----[CACC]
   AAAG                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 24 of 27 -- Codons 1278-1354 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAAT     | 0.7361   |
| oh2 (3' boundary) | CTTG     | 0.7594   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1790 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1440 nt | GAAA  | AAAT  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3   | 655 nt  | AAAT  | CAAT  |
| 4   | Oligo pool      | Tile 24 (15330 oligos) | 287 nt  | CAAT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAT]----5'WT sub3----[CAAT]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAT                   CAAT                  AGAA 
```

**Set fidelity:** 0.9599 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile24         | 1445 nt | CTTG  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTTG]----3'WT+PolIII----[CACC]
   CTTG                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 25 of 27 -- Codons 1355-1406 (156 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGT     | 0.7629   |
| oh2 (3' boundary) | ATCG     | 0.5700   |

**Variants:** 10080 mutations, 10080 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1790 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1440 nt | GAAA  | AAAT  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3   | 886 nt  | AAAT  | AAGT  |
| 4   | Oligo pool      | Tile 25 (10080 oligos) | 212 nt  | AAGT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAT]----5'WT sub3----[AAGT]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAT                   AAGT                  AGAA 
```

**Set fidelity:** 0.9837 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile25         | 1289 nt | ATCG  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATCG]----3'WT+PolIII----[CACC]
   ATCG                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 26 of 27 -- Codons 1407-1433 (81 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAA     | 0.9425   |
| oh2 (3' boundary) | TAAT     | 0.8165   |

**Variants:** 4830 mutations, 4830 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1790 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2  | 1440 nt | GAAA  | AAAT  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3  | 1042 nt | AAAT  | TCAA  |
| 4   | Oligo pool      | Tile 26 (4830 oligos) | 137 nt  | TCAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAT]----5'WT sub3----[TCAA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAT                   TCAA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile26         | 1208 nt | TAAT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAAT]----3'WT+PolIII----[CACC]
   TAAT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 27 of 27 -- Codons 1434-1465 (96 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1790 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2  | 1440 nt | GAAA  | AAAT  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3  | 1123 nt | AAAT  | AATA  |
| 4   | Oligo pool      | Tile 27 (5880 oligos) | 152 nt  | AATA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAT]----5'WT sub3----[AATA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAT                   AATA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component            | Part name                | Length  | 5' OH | 3' OH |
| --- | -------------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product         | (in helper plasmid)      | --      | --    | --    |
| 2   | PolIII-only fragment | bsmbi_polIII_tile27      | 1112 nt | TTAA  | CACC  |
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

**Total blocks:** 59

| Block name                | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                        |
| ------------------------- | ----------- | ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10           | 1629        | BsaI        | 5wt_tile10                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile11           | 1782        | BsaI        | 5wt_tile11                                                                                                                                                                                                                                                                                                                                                                                         |
| bsai_5wt_tile12_sub1      | 1790        | BsaI        | 5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1;5wt_tile26_sub1;5wt_tile27_sub1                                                                                                                                    |
| bsai_5wt_tile12_sub2      | 130         | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile13_sub2      | 343         | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile14_sub2      | 544         | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile15_sub2      | 667         | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile16_sub2      | 889         | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile17_sub2      | 1021        | BsaI        | 5wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile18_sub2      | 1216        | BsaI        | 5wt_tile18_sub2                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile19_sub2      | 1321        | BsaI        | 5wt_tile19_sub2                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile2            | 156         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile20_sub2      | 1432        | BsaI        | 5wt_tile20_sub2                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile21_sub2      | 1627        | BsaI        | 5wt_tile21_sub2                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile22_sub2      | 1440        | BsaI        | 5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2;5wt_tile26_sub2;5wt_tile27_sub2                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile22_sub3      | 337         | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile23_sub3      | 496         | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile24_sub3      | 655         | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile25_sub3      | 886         | BsaI        | 5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile26_sub3      | 1042        | BsaI        | 5wt_tile26_sub3                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile27_sub3      | 1123        | BsaI        | 5wt_tile27_sub3                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile3            | 387         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile4            | 555         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile5            | 705         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile6            | 855         | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile7            | 1065        | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile8            | 1224        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile9            | 1431        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile1_sub1      | 1656        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile1_sub2      | 1440        | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile8_sub2;3wt_tile10_sub1                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile1_sub3      | 1248        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub3;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2;3wt_tile16_sub2;3wt_tile17_sub2;3wt_tile18_sub2                                                                                                             |
| bsmbi_3wt_tile11_sub1     | 1332        | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile12_sub1     | 1119        | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile13_sub1     | 918         | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile14_sub1     | 795         | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile15_sub1     | 573         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile16_sub1     | 441         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile17_sub1     | 246         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile18_sub1     | 141         | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile19_sub1     | 654         | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile19_sub2     | 1673        | BsmBI       | 3wt_polIII_tile19_sub2                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile2_sub1      | 1425        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile20_sub1     | 657         | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile20_sub2     | 1487        | BsmBI       | 3wt_polIII_tile20_sub2;3wt_polIII_tile21_sub2;3wt_polIII_tile22_sub2                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile21_sub1     | 525         | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile22_sub1     | 366         | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile23          | 1676        | BsmBI       | 3wt_polIII_tile23                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile24          | 1445        | BsmBI       | 3wt_polIII_tile24                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile25          | 1289        | BsmBI       | 3wt_polIII_tile25                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile26          | 1208        | BsmBI       | 3wt_polIII_tile26                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile3_sub1      | 1257        | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile4_sub1      | 1107        | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile5_sub1      | 957         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile6_sub1      | 747         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile7_sub1      | 588         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile8_sub1      | 381         | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile9_sub1      | 1605        | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_cassette_tile1_sub4 | 1079        | BsmBI       | cassette_tile1_frag1;cassette_tile2_frag1;cassette_tile3_frag1;cassette_tile4_frag1;cassette_tile5_frag1;cassette_tile6_frag1;cassette_tile7_frag1;cassette_tile8_frag1;cassette_tile9_frag1;cassette_tile10_frag1;cassette_tile11_frag1;cassette_tile12_frag1;cassette_tile13_frag1;cassette_tile14_frag1;cassette_tile15_frag1;cassette_tile16_frag1;cassette_tile17_frag1;cassette_tile18_frag1 |
| bsmbi_polIII_tile27       | 1112        | BsmBI       | polIII_tile27                                                                                                                                                                                                                                                                                                                                                                                      |

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

