# DMS-GG Assembly Report: GRIN2A_long_cassette

Generated: 2026-03-12 23:03:33
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                          |
| -------------------- | ------------------------------------------------------------------------------ |
| Gene name            | GRIN2A_NM_000833.5 Human GRIN2A native CDS (NM_000833.5, NP_000824.1, 1464 aa) |
| CDS length           | 4395 nt (1465 codons)                                                          |
| Protein length       | 1464 aa                                                                        |
| Number of tiles      | 28                                                                             |
| Total variants       | 30513                                                                          |
| Total oligos         | 305130                                                                         |
| Oligo length range   | 167-290 nt                                                                     |
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

**Total oligos:** 305130 | **Length range:** 167-290 nt

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
| 9    | 438-488   | 9870   | 209 nt |
| 10   | 489-541   | 10290  | 215 nt |
| 11   | 538-582   | 8610   | 191 nt |
| 12   | 579-632   | 10500  | 218 nt |
| 13   | 629-674   | 8820   | 194 nt |
| 14   | 671-713   | 8190   | 185 nt |
| 15   | 710-770   | 11970  | 239 nt |
| 16   | 767-830   | 12600  | 248 nt |
| 17   | 827-885   | 11550  | 233 nt |
| 18   | 882-940   | 11550  | 233 nt |
| 19   | 937-979   | 8190   | 185 nt |
| 20   | 976-1020  | 8610   | 191 nt |
| 21   | 1017-1066 | 9660   | 206 nt |
| 22   | 1067-1143 | 15330  | 287 nt |
| 23   | 1140-1214 | 14910  | 281 nt |
| 24   | 1211-1287 | 15330  | 287 nt |
| 25   | 1284-1328 | 8610   | 191 nt |
| 26   | 1325-1385 | 11970  | 239 nt |
| 27   | 1382-1423 | 7980   | 182 nt |
| 28   | 1420-1465 | 8820   | 194 nt |

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

| Check                     | Description                                                   | Result | Detail                                                                                                                                               |
| ------------------------- | ------------------------------------------------------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths             | All oligos within synthesis length limit                      | PASS   | Range: 167-290 nt (limit: 300)                                                                                                                       |
| block_lengths             | All gene blocks within synthesis length limit                 | PASS   | Range: 22-1756 nt (limit: 1800)                                                                                                                      |
| barcode_junction_sites    | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                              |
| barcode_uniqueness        | All barcodes are unique                                       | PASS   | 305130 unique / 305130 total                                                                                                                         |
| tile_coverage             | Tiles cover entire gene without gaps                          | PASS   | 4395 / 4395 nt covered                                                                                                                               |
| variant_count             | Expected number of variants generated                         | PASS   | 30513 unique variants (expected: 30513 across 1453/1463 mutable positions; 27607 missense + 1453 nonsense + 1453 wt_control; 10 position(s) skipped) |
| single_codon_change       | Each non-control variant differs by exactly one codon from WT | PASS   | 290600 / 290600 variants confirmed (WT controls excluded)                                                                                            |
| oligo_gc_content          | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 38.1-67.4% | 0 oligo(s) with extreme GC                                                                                                    |
| domestication_complete    | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                              |
| overhang_fidelity         | Tile boundary overhangs have adequate fidelity                | FAIL   | 27 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                              |
| tile_manifests            | Per-tile assembly manifests complete                          | PASS   | 28 tile manifest(s) generated                                                                                                                        |
| helper_plasmid            | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                   |
| reaction_fidelity         | Per-reaction set-level overhang fidelity                      | PASS   | Min set fidelity: 0.8298 across 56 reactions | 3 reaction(s) below 0.90                                                                              |
| barcode_poliii_term       | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 305130 barcode(s) contain TTTT                                                                                                                   |
| block_min_length          | All gene blocks above synthesis minimum length                | FAIL   | 12 block(s) below 300 nt minimum. Range: 22-1756 nt                                                                                                  |
| cassette_fragment_lengths | Cassette fragments within synthesis limits                    | PASS   | 2 cassette fragment(s). Range: 409-1507 nt. 0 over max, 0 under min.                                                                                 |
| sb_overhang_collisions    | Superblock boundary overhangs are unique (no collisions)      | PASS   | 3 SB boundary OH(s), all unique                                                                                                                      |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 5         | 0.8702             |
| 2    | 3        | 1.0000            | 5         | 1.0000             |
| 3    | 3        | 1.0000            | 5         | 1.0000             |
| 4    | 3        | 1.0000            | 5         | 1.0000             |
| 5    | 3        | 1.0000            | 5         | 0.9358             |
| 6    | 3        | 1.0000            | 5         | 0.8298             |
| 7    | 3        | 1.0000            | 4         | 1.0000             |
| 8    | 3        | 1.0000            | 5         | 1.0000             |
| 9    | 3        | 1.0000            | 4         | 1.0000             |
| 10   | 3        | 1.0000            | 4         | 1.0000             |
| 11   | 3        | 1.0000            | 4         | 1.0000             |
| 12   | 3        | 1.0000            | 4         | 0.9984             |
| 13   | 4        | 1.0000            | 4         | 1.0000             |
| 14   | 4        | 1.0000            | 4         | 1.0000             |
| 15   | 4        | 1.0000            | 4         | 1.0000             |
| 16   | 4        | 1.0000            | 3         | 1.0000             |
| 17   | 4        | 1.0000            | 4         | 1.0000             |
| 18   | 4        | 1.0000            | 4         | 1.0000             |
| 19   | 4        | 1.0000            | 4         | 1.0000             |
| 20   | 4        | 1.0000            | 4         | 1.0000             |
| 21   | 4        | 1.0000            | 6         | 0.9731             |
| 22   | 4        | 0.9981            | 5         | 0.9849             |
| 23   | 5        | 1.0000            | 5         | 0.9920             |
| 24   | 5        | 1.0000            | 4         | 0.9988             |
| 25   | 5        | 1.0000            | 5         | 0.8392             |
| 26   | 5        | 1.0000            | 4         | 1.0000             |
| 27   | 5        | 1.0000            | 4         | 1.0000             |
| 28   | 5        | 1.0000            | 3         | 1.0000             |

**Min:** 0.8298 | **Max:** 1.0000 | **Mean:** 0.9896

**Warning:** 3 reaction(s) below 0.90 fidelity — consider alternative split points or overhang reassignment.
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

### Tile 1 of 28 -- Codons 1-53 (159 nt)

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
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1      | 1323 nt | CCCC  | TGTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1752 nt | TGTG  | GTGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CCCC]----3'WT sub1----[TGTG]----3'WT sub2----[GTGC]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   CCCC                   TGTG                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 0.8702 (5 overhangs)

---

### Tile 2 of 28 -- Codons 50-127 (234 nt)

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
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1      | 1101 nt | CGCA  | TGTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1752 nt | TGTG  | GTGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CGCA]----3'WT sub1----[TGTG]----3'WT sub2----[GTGC]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   CGCA                   TGTG                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 3 of 28 -- Codons 124-183 (180 nt)

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
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1      | 933 nt  | CGTC  | TGTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1752 nt | TGTG  | GTGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CGTC]----3'WT sub1----[TGTG]----3'WT sub2----[GTGC]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   CGTC                   TGTG                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 4 of 28 -- Codons 180-216 (111 nt)

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
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1      | 834 nt  | GAAG  | TGTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1752 nt | TGTG  | GTGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAAG]----3'WT sub1----[TGTG]----3'WT sub2----[GTGC]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   GAAG                   TGTG                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 5 of 28 -- Codons 213-283 (213 nt)

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
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1      | 633 nt  | CAGC  | TGTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1752 nt | TGTG  | GTGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CAGC]----3'WT sub1----[TGTG]----3'WT sub2----[GTGC]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   CAGC                   TGTG                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 0.9358 (5 overhangs)

---

### Tile 6 of 28 -- Codons 280-353 (222 nt)

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
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1      | 423 nt  | GGTG  | TGTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1752 nt | TGTG  | GTGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GGTG]----3'WT sub1----[TGTG]----3'WT sub2----[GTGC]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   GGTG                   TGTG                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 0.8298 (5 overhangs)

---

### Tile 7 of 28 -- Codons 350-406 (171 nt)

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
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1      | 264 nt  | CACC  | TGTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1752 nt | TGTG  | GTGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CACC]----3'WT sub1----[TGTG]----3'WT sub2----[GTGC]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   CACC                   TGTG                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 8 of 28 -- Codons 403-441 (117 nt)

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
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1      | 159 nt  | TTCA  | TGTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1752 nt | TGTG  | GTGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TTCA]----3'WT sub1----[TGTG]----3'WT sub2----[GTGC]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   TTCA                   TGTG                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 9 of 28 -- Codons 438-488 (153 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGT     | 0.7629   |
| oh2 (3' boundary) | TGTG     | 0.5408   |

**Variants:** 9870 mutations, 9870 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1329 nt | ATGG  | AAGT  |
| 2   | Oligo pool      | Tile 9 (9870 oligos)  | 209 nt  | AAGT  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1752 nt | TGTG  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGTG]----3'WT sub1----[GTGC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   TGTG                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 10 of 28 -- Codons 489-541 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTTA     | 0.6139   |
| oh2 (3' boundary) | CTCA     | 0.6872   |

**Variants:** 10290 mutations, 10290 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1482 nt | ATGG  | GTTA  |
| 2   | Oligo pool      | Tile 10 (10290 oligos) | 215 nt  | GTTA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT block----[GTTA]----oligo+BC----[AGAA]
   ATGG                    GTTA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1     | 1593 nt | CTCA  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTCA]----3'WT sub1----[GTGC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   CTCA                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 11 of 28 -- Codons 538-582 (135 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAA     | 0.9425   |
| oh2 (3' boundary) | CAGA     | 0.8175   |

**Variants:** 8610 mutations, 8610 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1629 nt | ATGG  | TCAA  |
| 2   | Oligo pool      | Tile 11 (8610 oligos) | 191 nt  | TCAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

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
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1     | 1470 nt | CAGA  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CAGA]----3'WT sub1----[GTGC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   CAGA                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 12 of 28 -- Codons 579-632 (162 nt)

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
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1     | 1320 nt | CTTC  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTTC]----3'WT sub1----[GTGC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   CTTC                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 0.9984 (4 overhangs)

---

### Tile 13 of 28 -- Codons 629-674 (138 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2  | 442 nt  | TGTG  | ATCA  |
| 3   | Oligo pool      | Tile 13 (8820 oligos) | 194 nt  | ATCA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[ATCA]----oligo+BC----[AGAA]
   ATGG                   TGTG                   ATCA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1     | 1194 nt | CCCA  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CCCA]----3'WT sub1----[GTGC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   CCCA                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 14 of 28 -- Codons 671-713 (129 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2  | 568 nt  | TGTG  | CAAA  |
| 3   | Oligo pool      | Tile 14 (8190 oligos) | 185 nt  | CAAA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[CAAA]----oligo+BC----[AGAA]
   ATGG                   TGTG                   CAAA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1     | 1077 nt | CTTG  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTTG]----3'WT sub1----[GTGC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   CTTG                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 15 of 28 -- Codons 710-770 (183 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 685 nt  | TGTG  | CAGA  |
| 3   | Oligo pool      | Tile 15 (11970 oligos) | 239 nt  | CAGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[CAGA]----oligo+BC----[AGAA]
   ATGG                   TGTG                   CAGA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1     | 906 nt  | GCAG  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GCAG]----3'WT sub1----[GTGC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   GCAG                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 16 of 28 -- Codons 767-830 (192 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 856 nt  | TGTG  | AAAG  |
| 3   | Oligo pool      | Tile 16 (12600 oligos) | 248 nt  | AAAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[AAAG]----oligo+BC----[AGAA]
   ATGG                   TGTG                   AAAG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1     | 726 nt  | CACC  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CACC]----3'WT sub1----[GTGC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   CACC                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 17 of 28 -- Codons 827-885 (177 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 1036 nt | TGTG  | GCCA  |
| 3   | Oligo pool      | Tile 17 (11550 oligos) | 233 nt  | GCCA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[GCCA]----oligo+BC----[AGAA]
   ATGG                   TGTG                   GCCA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1     | 561 nt  | GGGA  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GGGA]----3'WT sub1----[GTGC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   GGGA                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 18 of 28 -- Codons 882-940 (177 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1201 nt | TGTG  | TCTC  |
| 3   | Oligo pool      | Tile 18 (11550 oligos) | 233 nt  | TCTC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[TCTC]----oligo+BC----[AGAA]
   ATGG                   TGTG                   TCTC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1     | 396 nt  | CTCA  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTCA]----3'WT sub1----[GTGC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   CTCA                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 19 of 28 -- Codons 937-979 (129 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1366 nt | TGTG  | GATA  |
| 3   | Oligo pool      | Tile 19 (8190 oligos) | 185 nt  | GATA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[GATA]----oligo+BC----[AGAA]
   ATGG                   TGTG                   GATA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1     | 279 nt  | ACAA  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [ACAA]----3'WT sub1----[GTGC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   ACAA                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 20 of 28 -- Codons 976-1020 (135 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATA     | 0.8816   |
| oh2 (3' boundary) | GGAT     | 0.5385   |

**Variants:** 8610 mutations, 8610 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2  | 1483 nt | TGTG  | AATA  |
| 3   | Oligo pool      | Tile 20 (8610 oligos) | 191 nt  | AATA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[AATA]----oligo+BC----[AGAA]
   ATGG                   TGTG                   AATA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1     | 156 nt  | GGAT  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GGAT]----3'WT sub1----[GTGC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   GGAT                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 21 of 28 -- Codons 1017-1066 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCG     | 0.7234   |
| oh2 (3' boundary) | GTGC     | 0.4969   |

**Variants:** 9660 mutations, 9660 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1606 nt | TGTG  | TCCG  |
| 3   | Oligo pool      | Tile 21 (9660 oligos) | 206 nt  | TCCG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[TCCG]----oligo+BC----[AGAA]
   ATGG                   TGTG                   TCCG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1     | 375 nt  | GTGC  | TAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile21_sub2     | 297 nt  | TAAA  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile21_sub3     | 204 nt  | TCAA  | AAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile21_sub4     | 784 nt  | AAAA  | AAGA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GTGC]----3'WT sub1----[TAAA]----3'WT sub2----[TCAA]----3'WT sub3----[AAAA]----3'WT sub4----[AAGA]----3'WT+PolIII sub5----[CACC]
   GTGC                   TAAA                   TCAA                   AAAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9731 (6 overhangs)

---

### Tile 22 of 28 -- Codons 1067-1143 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CGGG     | 0.5212   |
| oh2 (3' boundary) | CTTC     | 0.6384   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1756 nt | TGTG  | CGGG  |
| 3   | Oligo pool      | Tile 22 (15330 oligos) | 287 nt  | CGGG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[CGGG]----oligo+BC----[AGAA]
   ATGG                   TGTG                   CGGG                  AGAA 
```

**Set fidelity:** 0.9981 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1     | 609 nt  | CTTC  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile22_sub2     | 22 nt   | AAAA  | CAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile22_sub3     | 799 nt  | CAAA  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTTC]----3'WT sub1----[AAAA]----3'WT sub2----[CAAA]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   CTTC                   AAAA                   CAAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9849 (5 overhangs)

---

### Tile 23 of 28 -- Codons 1140-1214 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACCC     | 0.5528   |
| oh2 (3' boundary) | CCTT     | 0.6891   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2   | 1752 nt | TGTG  | GTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 241 nt  | GTGC  | ACCC  |
| 4   | Oligo pool      | Tile 23 (14910 oligos) | 281 nt  | ACCC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[GTGC]----5'WT sub3----[ACCC]----oligo+BC----[AGAA]
   ATGG                   TGTG                   GTGC                   ACCC                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1     | 396 nt  | CCTT  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile23_sub2     | 333 nt  | AAAA  | TTTA  |
| 4   | 3'WT block        | bsmbi_3wt_tile23_sub3     | 469 nt  | TTTA  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CCTT]----3'WT sub1----[AAAA]----3'WT sub2----[TTTA]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   CCTT                   AAAA                   TTTA                   AAGA                          CACC 
```

**Set fidelity:** 0.9920 (5 overhangs)

---

### Tile 24 of 28 -- Codons 1211-1287 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCA     | 0.8519   |
| oh2 (3' boundary) | TTCC     | 0.7958   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2   | 1752 nt | TGTG  | GTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3   | 454 nt  | GTGC  | TCCA  |
| 4   | Oligo pool      | Tile 24 (15330 oligos) | 287 nt  | TCCA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[GTGC]----5'WT sub3----[TCCA]----oligo+BC----[AGAA]
   ATGG                   TGTG                   GTGC                   TCCA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile24_sub1     | 492 nt  | TTCC  | TTTA  |
| 3   | 3'WT block        | bsmbi_3wt_tile23_sub3     | 469 nt  | TTTA  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TTCC]----3'WT sub1----[TTTA]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   TTCC                   TTTA                   AAGA                          CACC 
```

**Set fidelity:** 0.9988 (4 overhangs)

---

### Tile 25 of 28 -- Codons 1284-1328 (135 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTAA     | 0.8691   |
| oh2 (3' boundary) | CCCC     | 0.5515   |

**Variants:** 8610 mutations, 8610 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2  | 1752 nt | TGTG  | GTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3  | 673 nt  | GTGC  | CTAA  |
| 4   | Oligo pool      | Tile 25 (8610 oligos) | 191 nt  | CTAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[GTGC]----5'WT sub3----[CTAA]----oligo+BC----[AGAA]
   ATGG                   TGTG                   GTGC                   CTAA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile25_sub1     | 369 nt  | CCCC  | TTTA  |
| 3   | 3'WT block        | bsmbi_3wt_tile25_sub2     | 36 nt   | TTTA  | TAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile25_sub3     | 451 nt  | TAGA  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CCCC]----3'WT sub1----[TTTA]----3'WT sub2----[TAGA]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   CCCC                   TTTA                   TAGA                   AAGA                          CACC 
```

**Set fidelity:** 0.8392 (5 overhangs)

---

### Tile 26 of 28 -- Codons 1325-1385 (183 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACG     | 0.6478   |
| oh2 (3' boundary) | ACAC     | 0.5629   |

**Variants:** 11970 mutations, 11970 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2   | 1752 nt | TGTG  | GTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3   | 796 nt  | GTGC  | TACG  |
| 4   | Oligo pool      | Tile 26 (11970 oligos) | 239 nt  | TACG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[GTGC]----5'WT sub3----[TACG]----oligo+BC----[AGAA]
   ATGG                   TGTG                   GTGC                   TACG                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile26_sub1     | 231 nt  | ACAC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile26_sub2     | 436 nt  | GAAA  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [ACAC]----3'WT sub1----[GAAA]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   ACAC                   GAAA                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 27 of 28 -- Codons 1382-1423 (126 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TGCC     | 0.5867   |
| oh2 (3' boundary) | GCAT     | 0.5827   |

**Variants:** 7980 mutations, 7980 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2  | 1752 nt | TGTG  | GTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3  | 967 nt  | GTGC  | TGCC  |
| 4   | Oligo pool      | Tile 27 (7980 oligos) | 182 nt  | TGCC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[GTGC]----5'WT sub3----[TGCC]----oligo+BC----[AGAA]
   ATGG                   TGTG                   GTGC                   TGCC                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile27_sub1     | 117 nt  | GCAT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile26_sub2     | 436 nt  | GAAA  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GCAT]----3'WT sub1----[GAAA]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   GCAT                   GAAA                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 28 of 28 -- Codons 1420-1465 (138 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATG     | 0.6412   |
| oh2 (3' boundary) | TTAA     | 0.9448   |

**Variants:** 8820 mutations, 8820 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2  | 1752 nt | TGTG  | GTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3  | 1081 nt | GTGC  | AATG  |
| 4   | Oligo pool      | Tile 28 (8820 oligos) | 194 nt  | AATG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[GTGC]----5'WT sub3----[AATG]----oligo+BC----[AGAA]
   ATGG                   TGTG                   GTGC                   AATG                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                  | Length  | 5' OH | 3' OH |
| --- | ----------------- | -------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)        | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_cassette_tile28_sub1 | 409 nt  | TTAA  | AAGA  |
| 3   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4  | 1507 nt | AAGA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1   | --      | --    | --    |

```
  [TTAA]----3'WT sub1----[AAGA]----3'WT+PolIII sub2----[CACC]
   TTAA                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

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

| Block name                 | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| -------------------------- | ----------- | ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| bsai_5wt_tile10_sub1       | 1482        | BsaI        | 5wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile11_sub1       | 1629        | BsaI        | 5wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile12_sub1       | 1752        | BsaI        | 5wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile13_sub1       | 1478        | BsaI        | 5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1;5wt_tile26_sub1;5wt_tile27_sub1;5wt_tile28_sub1                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile13_sub2       | 442         | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile14_sub2       | 568         | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile15_sub2       | 685         | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile16_sub2       | 856         | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile17_sub2       | 1036        | BsaI        | 5wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile18_sub2       | 1201        | BsaI        | 5wt_tile18_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile19_sub2       | 1366        | BsaI        | 5wt_tile19_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile2             | 165         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile20_sub2       | 1483        | BsaI        | 5wt_tile20_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile21_sub2       | 1606        | BsaI        | 5wt_tile21_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile22_sub2       | 1756        | BsaI        | 5wt_tile22_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile23_sub2       | 1752        | BsaI        | 5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2;5wt_tile26_sub2;5wt_tile27_sub2;5wt_tile28_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile23_sub3       | 241         | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile24_sub3       | 454         | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile25_sub3       | 673         | BsaI        | 5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile26_sub3       | 796         | BsaI        | 5wt_tile26_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile27_sub3       | 967         | BsaI        | 5wt_tile27_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile28_sub3       | 1081        | BsaI        | 5wt_tile28_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile3             | 387         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile4             | 555         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile5             | 654         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile6             | 855         | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile7             | 1065        | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile8             | 1224        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile9             | 1329        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile1_sub1       | 1323        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile1_sub2       | 1752        | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile8_sub2;3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile1_sub3       | 1606        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub3;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2;3wt_tile16_sub2;3wt_tile17_sub2;3wt_tile18_sub2;3wt_tile19_sub2;3wt_tile20_sub2                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile10_sub1      | 1593        | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile11_sub1      | 1470        | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile12_sub1      | 1320        | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile13_sub1      | 1194        | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile14_sub1      | 1077        | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile15_sub1      | 906         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile16_sub1      | 726         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile17_sub1      | 561         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile18_sub1      | 396         | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile19_sub1      | 279         | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile2_sub1       | 1101        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile20_sub1      | 156         | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile21_sub1      | 375         | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile21_sub2      | 297         | BsmBI       | 3wt_tile21_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile21_sub3      | 204         | BsmBI       | 3wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile21_sub4      | 784         | BsmBI       | 3wt_tile21_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile22_sub1      | 609         | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile22_sub2      | 22          | BsmBI       | 3wt_tile22_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile22_sub3      | 799         | BsmBI       | 3wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile23_sub1      | 396         | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile23_sub2      | 333         | BsmBI       | 3wt_tile23_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile23_sub3      | 469         | BsmBI       | 3wt_tile23_sub3;3wt_tile24_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile24_sub1      | 492         | BsmBI       | 3wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile25_sub1      | 369         | BsmBI       | 3wt_tile25_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile25_sub2      | 36          | BsmBI       | 3wt_tile25_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile25_sub3      | 451         | BsmBI       | 3wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile26_sub1      | 231         | BsmBI       | 3wt_tile26_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile26_sub2      | 436         | BsmBI       | 3wt_tile26_sub2;3wt_tile27_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile27_sub1      | 117         | BsmBI       | 3wt_tile27_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile3_sub1       | 933         | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile4_sub1       | 834         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile5_sub1       | 633         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile6_sub1       | 423         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile7_sub1       | 264         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile8_sub1       | 159         | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_cassette_tile1_sub4  | 1507        | BsmBI       | cassette_tile1_frag1;cassette_tile2_frag1;cassette_tile3_frag1;cassette_tile4_frag1;cassette_tile5_frag1;cassette_tile6_frag1;cassette_tile7_frag1;cassette_tile8_frag1;cassette_tile9_frag1;cassette_tile10_frag1;cassette_tile11_frag1;cassette_tile12_frag1;cassette_tile13_frag1;cassette_tile14_frag1;cassette_tile15_frag1;cassette_tile16_frag1;cassette_tile17_frag1;cassette_tile18_frag1;cassette_tile19_frag1;cassette_tile20_frag1;cassette_tile21_frag1;cassette_tile22_frag1;cassette_tile23_frag1;cassette_tile24_frag1;cassette_tile25_frag1;cassette_tile26_frag1;cassette_tile27_frag1;cassette_tile28_frag2 |
| bsmbi_cassette_tile28_sub1 | 409         | BsmBI       | cassette_tile28_frag1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |

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

