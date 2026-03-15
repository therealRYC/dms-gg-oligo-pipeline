# DMS-GG Assembly Report: GRIN2A_long_cassette

Generated: 2026-03-14 13:50:54
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                          |
| -------------------- | ------------------------------------------------------------------------------ |
| Gene name            | GRIN2A_NM_000833.5 Human GRIN2A native CDS (NM_000833.5, NP_000824.1, 1464 aa) |
| CDS length           | 4395 nt (1465 codons)                                                          |
| Protein length       | 1464 aa                                                                        |
| Number of tiles      | 24                                                                             |
| Total variants       | 30576                                                                          |
| Total oligos         | 305760                                                                         |
| Oligo length range   | 176-290 nt                                                                     |
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
[PaqCI**]--[gene+mutation]--[P2A_EGFP]--[WPRE]--[spacer]--[bGH_polyA]--[PolIII]--[barcode]--[PaqCI*]
```

## 3. Oligo Pool Summary

**Total oligos:** 305760 | **Length range:** 176-290 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-78      | 15540  | 290 nt |
| 2    | 73-137    | 12390  | 251 nt |
| 3    | 132-206   | 14490  | 281 nt |
| 4    | 201-277   | 14910  | 287 nt |
| 5    | 272-342   | 13650  | 269 nt |
| 6    | 337-399   | 11970  | 245 nt |
| 7    | 394-448   | 10290  | 221 nt |
| 8    | 443-520   | 15120  | 290 nt |
| 9    | 515-586   | 14070  | 272 nt |
| 10   | 587-644   | 11340  | 230 nt |
| 11   | 639-711   | 14070  | 275 nt |
| 12   | 706-777   | 13860  | 272 nt |
| 13   | 772-849   | 15120  | 290 nt |
| 14   | 844-905   | 11760  | 242 nt |
| 15   | 900-949   | 9240   | 206 nt |
| 16   | 944-1020  | 14910  | 287 nt |
| 17   | 1015-1054 | 7140   | 176 nt |
| 18   | 1049-1121 | 14070  | 275 nt |
| 19   | 1116-1168 | 10080  | 215 nt |
| 20   | 1169-1244 | 15120  | 284 nt |
| 21   | 1239-1289 | 9450   | 209 nt |
| 22   | 1284-1352 | 13230  | 263 nt |
| 23   | 1347-1412 | 12600  | 254 nt |
| 24   | 1407-1465 | 11340  | 233 nt |

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
| Total barcodes    | 305760                             |
| Unique barcodes   | 305760                             |
| GC content range  | 25% - 75%                          |
| GC content mean   | 47.9%                              |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                     | Description                                                   | Result | Detail                                                                                                                                              |
| ------------------------- | ------------------------------------------------------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths             | All oligos within synthesis length limit                      | PASS   | Range: 176-290 nt (limit: 300)                                                                                                                      |
| block_lengths             | All gene blocks within synthesis length limit                 | PASS   | Range: 22-1782 nt (limit: 1800)                                                                                                                     |
| barcode_junction_sites    | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                             |
| barcode_uniqueness        | All barcodes are unique                                       | PASS   | 305760 unique / 305760 total                                                                                                                        |
| tile_coverage             | Tiles cover entire gene without gaps                          | PASS   | 4395 / 4395 nt covered                                                                                                                              |
| variant_count             | Expected number of variants generated                         | PASS   | 30576 unique variants (expected: 30576 across 1456/1463 mutable positions; 27664 missense + 1456 nonsense + 1456 wt_control; 7 position(s) skipped) |
| single_codon_change       | Each non-control variant differs by exactly one codon from WT | PASS   | 291200 / 291200 variants confirmed (WT controls excluded)                                                                                           |
| oligo_gc_content          | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 42.1-67.2% | 0 oligo(s) with extreme GC                                                                                                   |
| domestication_complete    | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                             |
| overhang_fidelity         | Tile boundary overhangs have adequate fidelity                | FAIL   | 22 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                             |
| tile_manifests            | Per-tile assembly manifests complete                          | PASS   | 24 tile manifest(s) generated                                                                                                                       |
| helper_plasmid            | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                  |
| reaction_fidelity         | Per-reaction set-level overhang fidelity                      | FAIL   | Min set fidelity: 0.7487 across 48 reactions | 1 reaction(s) below 0.90                                                                             |
| barcode_poliii_term       | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 305760 barcode(s) contain TTTT                                                                                                                  |
| block_min_length          | All gene blocks above synthesis minimum length                | FAIL   | 11 block(s) below 300 nt minimum. Range: 22-1782 nt                                                                                                 |
| cassette_fragment_lengths | Cassette fragments within synthesis limits                    | PASS   | 2 cassette fragment(s). Range: 409-1507 nt. 0 over max, 0 under min.                                                                                |
| sb_overhang_collisions    | Superblock boundary overhangs are unique (no collisions)      | PASS   | 5 SB boundary OH(s), all unique                                                                                                                     |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 5         | 0.9298             |
| 2    | 3        | 1.0000            | 5         | 0.7487             |
| 3    | 3        | 1.0000            | 5         | 0.9979             |
| 4    | 3        | 1.0000            | 5         | 1.0000             |
| 5    | 3        | 1.0000            | 5         | 1.0000             |
| 6    | 3        | 1.0000            | 5         | 1.0000             |
| 7    | 3        | 1.0000            | 4         | 1.0000             |
| 8    | 3        | 1.0000            | 5         | 1.0000             |
| 9    | 3        | 1.0000            | 4         | 1.0000             |
| 10   | 3        | 1.0000            | 4         | 1.0000             |
| 11   | 4        | 1.0000            | 4         | 1.0000             |
| 12   | 4        | 1.0000            | 4         | 1.0000             |
| 13   | 4        | 1.0000            | 4         | 1.0000             |
| 14   | 4        | 1.0000            | 4         | 0.9985             |
| 15   | 4        | 1.0000            | 4         | 1.0000             |
| 16   | 4        | 1.0000            | 4         | 1.0000             |
| 17   | 4        | 1.0000            | 4         | 1.0000             |
| 18   | 4        | 1.0000            | 4         | 1.0000             |
| 19   | 4        | 1.0000            | 6         | 0.9864             |
| 20   | 4        | 1.0000            | 6         | 0.9864             |
| 21   | 5        | 1.0000            | 4         | 1.0000             |
| 22   | 5        | 1.0000            | 5         | 0.9644             |
| 23   | 5        | 1.0000            | 4         | 1.0000             |
| 24   | 5        | 1.0000            | 3         | 1.0000             |

**Min:** 0.7487 | **Max:** 1.0000 | **Mean:** 0.9919

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

### Tile 1 of 24 -- Codons 1-78 (234 nt)

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

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1      | 1560 nt | CACG  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1764 nt | GAAA  | TAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1282 nt | TAAT  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CACG]----3'WT sub1----[GAAA]----3'WT sub2----[TAAT]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   CACG                   GAAA                   TAAT                   AAGA                          CACC 
```

**Set fidelity:** 0.9298 (5 overhangs)

---

### Tile 2 of 24 -- Codons 73-137 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTGA     | 0.6791   |
| oh2 (3' boundary) | TACC     | 0.7054   |

**Variants:** 12390 mutations, 12390 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 234 nt | ATGG  | CTGA  |
| 2   | Oligo pool      | Tile 2 (12390 oligos) | 251 nt | CTGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[CTGA]----oligo+BC----[AGAA]
   ATGG                    CTGA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1      | 1383 nt | TACC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1764 nt | GAAA  | TAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1282 nt | TAAT  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TACC]----3'WT sub1----[GAAA]----3'WT sub2----[TAAT]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   TACC                   GAAA                   TAAT                   AAGA                          CACC 
```

**Set fidelity:** 0.7487 (5 overhangs)

---

### Tile 3 of 24 -- Codons 132-206 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTA     | 0.8892   |
| oh2 (3' boundary) | GGAT     | 0.5385   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 411 nt | ATGG  | TCTA  |
| 2   | Oligo pool      | Tile 3 (14490 oligos) | 281 nt | TCTA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[TCTA]----oligo+BC----[AGAA]
   ATGG                    TCTA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1      | 1176 nt | GGAT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1764 nt | GAAA  | TAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1282 nt | TAAT  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GGAT]----3'WT sub1----[GAAA]----3'WT sub2----[TAAT]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   GGAT                   GAAA                   TAAT                   AAGA                          CACC 
```

**Set fidelity:** 0.9979 (5 overhangs)

---

### Tile 4 of 24 -- Codons 201-277 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGA     | 0.8175   |
| oh2 (3' boundary) | TGAC     | 0.6485   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 618 nt | ATGG  | CAGA  |
| 2   | Oligo pool      | Tile 4 (14910 oligos) | 287 nt | CAGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[CAGA]----oligo+BC----[AGAA]
   ATGG                    CAGA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1      | 963 nt  | TGAC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1764 nt | GAAA  | TAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1282 nt | TAAT  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGAC]----3'WT sub1----[GAAA]----3'WT sub2----[TAAT]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   TGAC                   GAAA                   TAAT                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 5 of 24 -- Codons 272-342 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTTC     | 0.8348   |
| oh2 (3' boundary) | CTTA     | 0.7183   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 831 nt | ATGG  | TTTC  |
| 2   | Oligo pool      | Tile 5 (13650 oligos) | 269 nt | TTTC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[TTTC]----oligo+BC----[AGAA]
   ATGG                    TTTC                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1      | 768 nt  | CTTA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1764 nt | GAAA  | TAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1282 nt | TAAT  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTTA]----3'WT sub1----[GAAA]----3'WT sub2----[TAAT]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   CTTA                   GAAA                   TAAT                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 6 of 24 -- Codons 337-399 (189 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTTA     | 0.9147   |
| oh2 (3' boundary) | CCAT     | 0.6470   |

**Variants:** 11970 mutations, 11970 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 1026 nt | ATGG  | TTTA  |
| 2   | Oligo pool      | Tile 6 (11970 oligos) | 245 nt  | TTTA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[TTTA]----oligo+BC----[AGAA]
   ATGG                    TTTA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1      | 597 nt  | CCAT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1764 nt | GAAA  | TAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1282 nt | TAAT  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CCAT]----3'WT sub1----[GAAA]----3'WT sub2----[TAAT]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   CCAT                   GAAA                   TAAT                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 7 of 24 -- Codons 394-448 (165 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGT     | 0.7629   |
| oh2 (3' boundary) | GAAA     | 0.8745   |

**Variants:** 10290 mutations, 10290 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 1197 nt | ATGG  | AAGT  |
| 2   | Oligo pool      | Tile 7 (10290 oligos) | 221 nt  | AAGT  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1      | 450 nt  | GAAA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1764 nt | GAAA  | TAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1282 nt | TAAT  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAAA]----3'WT sub1----[GAAA]----3'WT sub2----[TAAT]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   GAAA                   GAAA                   TAAT                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 8 of 24 -- Codons 443-520 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AACA     | 0.8032   |
| oh2 (3' boundary) | TGTG     | 0.5408   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1344 nt | ATGG  | AACA  |
| 2   | Oligo pool      | Tile 8 (15120 oligos) | 290 nt  | AACA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[AACA]----oligo+BC----[AGAA]
   ATGG                    AACA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1      | 234 nt  | TGTG  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1764 nt | GAAA  | TAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1282 nt | TAAT  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGTG]----3'WT sub1----[GAAA]----3'WT sub2----[TAAT]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   TGTG                   GAAA                   TAAT                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 9 of 24 -- Codons 515-586 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATG     | 0.6412   |
| oh2 (3' boundary) | GAAA     | 0.8745   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1560 nt | ATGG  | AATG  |
| 2   | Oligo pool      | Tile 9 (14070 oligos) | 272 nt  | AATG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[AATG]----oligo+BC----[AGAA]
   ATGG                    AATG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1      | 1782 nt | GAAA  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1282 nt | TAAT  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAAA]----3'WT sub1----[TAAT]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   GAAA                   TAAT                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 10 of 24 -- Codons 587-644 (174 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AACT     | 0.6635   |
| oh2 (3' boundary) | GGCT     | 0.4697   |

**Variants:** 11340 mutations, 11340 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1776 nt | ATGG  | AACT  |
| 2   | Oligo pool      | Tile 10 (11340 oligos) | 230 nt  | AACT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT block----[AACT]----oligo+BC----[AGAA]
   ATGG                    AACT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1     | 1608 nt | GGCT  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1282 nt | TAAT  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GGCT]----3'WT sub1----[TAAT]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   GGCT                   TAAT                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 11 of 24 -- Codons 639-711 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTCA     | 0.5915   |
| oh2 (3' boundary) | CTTG     | 0.7594   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1776 nt | ATGG  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile11_sub2   | 174 nt  | AACT  | GTCA  |
| 3   | Oligo pool      | Tile 11 (14070 oligos) | 275 nt  | GTCA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AACT]----5'WT sub2----[GTCA]----oligo+BC----[AGAA]
   ATGG                   AACT                   GTCA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1     | 1407 nt | CTTG  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1282 nt | TAAT  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTTG]----3'WT sub1----[TAAT]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   CTTG                   TAAT                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 12 of 24 -- Codons 706-777 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACCA     | 0.7200   |
| oh2 (3' boundary) | TGTG     | 0.5408   |

**Variants:** 13860 mutations, 13860 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1776 nt | ATGG  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2   | 375 nt  | AACT  | ACCA  |
| 3   | Oligo pool      | Tile 12 (13860 oligos) | 272 nt  | ACCA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AACT]----5'WT sub2----[ACCA]----oligo+BC----[AGAA]
   ATGG                   AACT                   ACCA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1     | 1209 nt | TGTG  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1282 nt | TAAT  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGTG]----3'WT sub1----[TAAT]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   TGTG                   TAAT                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 13 of 24 -- Codons 772-849 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | CGAC     | 0.4695   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1776 nt | ATGG  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 573 nt  | AACT  | AAGA  |
| 3   | Oligo pool      | Tile 13 (15120 oligos) | 290 nt  | AAGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AACT]----5'WT sub2----[AAGA]----oligo+BC----[AGAA]
   ATGG                   AACT                   AAGA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1     | 993 nt  | CGAC  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1282 nt | TAAT  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CGAC]----3'WT sub1----[TAAT]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   CGAC                   TAAT                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 14 of 24 -- Codons 844-905 (186 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1776 nt | ATGG  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 789 nt  | AACT  | AAGC  |
| 3   | Oligo pool      | Tile 14 (11760 oligos) | 242 nt  | AAGC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AACT]----5'WT sub2----[AAGC]----oligo+BC----[AGAA]
   ATGG                   AACT                   AAGC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1     | 825 nt  | GAAC  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1282 nt | TAAT  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAAC]----3'WT sub1----[TAAT]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   GAAC                   TAAT                   AAGA                          CACC 
```

**Set fidelity:** 0.9985 (4 overhangs)

---

### Tile 15 of 24 -- Codons 900-949 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAG     | 0.7814   |
| oh2 (3' boundary) | CATT     | 0.6770   |

**Variants:** 9240 mutations, 9240 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10       | 1776 nt | ATGG  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2  | 957 nt  | AACT  | TCAG  |
| 3   | Oligo pool      | Tile 15 (9240 oligos) | 206 nt  | TCAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AACT]----5'WT sub2----[TCAG]----oligo+BC----[AGAA]
   ATGG                   AACT                   TCAG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1     | 693 nt  | CATT  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1282 nt | TAAT  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CATT]----3'WT sub1----[TAAT]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   CATT                   TAAT                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 16 of 24 -- Codons 944-1020 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAG     | 0.7814   |
| oh2 (3' boundary) | ACTA     | 0.7946   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1776 nt | ATGG  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1089 nt | AACT  | TCAG  |
| 3   | Oligo pool      | Tile 16 (14910 oligos) | 287 nt  | TCAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AACT]----5'WT sub2----[TCAG]----oligo+BC----[AGAA]
   ATGG                   AACT                   TCAG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1     | 480 nt  | ACTA  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1282 nt | TAAT  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [ACTA]----3'WT sub1----[TAAT]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   ACTA                   TAAT                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 17 of 24 -- Codons 1015-1054 (120 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile10       | 1776 nt | ATGG  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2  | 1302 nt | AACT  | AAGA  |
| 3   | Oligo pool      | Tile 17 (7140 oligos) | 176 nt  | AAGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AACT]----5'WT sub2----[AAGA]----oligo+BC----[AGAA]
   ATGG                   AACT                   AAGA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1     | 378 nt  | TGAC  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1282 nt | TAAT  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGAC]----3'WT sub1----[TAAT]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   TGAC                   TAAT                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 18 of 24 -- Codons 1049-1121 (219 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1776 nt | ATGG  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1404 nt | AACT  | CCTA  |
| 3   | Oligo pool      | Tile 18 (14070 oligos) | 275 nt  | CCTA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AACT]----5'WT sub2----[CCTA]----oligo+BC----[AGAA]
   ATGG                   AACT                   CCTA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1     | 177 nt  | TGGT  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1282 nt | TAAT  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGGT]----3'WT sub1----[TAAT]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   TGGT                   TAAT                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 19 of 24 -- Codons 1116-1168 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | TAAT     | 0.8165   |

**Variants:** 10080 mutations, 10080 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1776 nt | ATGG  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1605 nt | AACT  | AAGA  |
| 3   | Oligo pool      | Tile 19 (10080 oligos) | 215 nt  | AAGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AACT]----5'WT sub2----[AAGA]----oligo+BC----[AGAA]
   ATGG                   AACT                   AAGA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1     | 348 nt  | TAAT  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile19_sub2     | 204 nt  | TCAA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile19_sub3     | 162 nt  | AAAA  | CAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile19_sub4     | 640 nt  | CAAA  | AAGA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TAAT]----3'WT sub1----[TCAA]----3'WT sub2----[AAAA]----3'WT sub3----[CAAA]----3'WT sub4----[AAGA]----3'WT+PolIII sub5----[CACC]
   TAAT                   TCAA                   AAAA                   CAAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9864 (6 overhangs)

---

### Tile 20 of 24 -- Codons 1169-1244 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CGGA     | 0.6609   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1776 nt | ATGG  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1764 nt | AACT  | CGGA  |
| 3   | Oligo pool      | Tile 20 (15120 oligos) | 284 nt  | CGGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AACT]----5'WT sub2----[CGGA]----oligo+BC----[AGAA]
   ATGG                   AACT                   CGGA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1     | 306 nt  | TGAA  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile20_sub2     | 22 nt   | AAAA  | CAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile20_sub3     | 348 nt  | CAAA  | TTTA  |
| 5   | 3'WT block        | bsmbi_3wt_tile20_sub4     | 469 nt  | TTTA  | AAGA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[AAAA]----3'WT sub2----[CAAA]----3'WT sub3----[TTTA]----3'WT sub4----[AAGA]----3'WT+PolIII sub5----[CACC]
   TGAA                   AAAA                   CAAA                   TTTA                   AAGA                          CACC 
```

**Set fidelity:** 0.9864 (6 overhangs)

---

### Tile 21 of 24 -- Codons 1239-1289 (153 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TGCC     | 0.5867   |
| oh2 (3' boundary) | CATT     | 0.6770   |

**Variants:** 9450 mutations, 9450 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10       | 1776 nt | ATGG  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2  | 1764 nt | AACT  | CGGA  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3  | 228 nt  | CGGA  | TGCC  |
| 4   | Oligo pool      | Tile 21 (9450 oligos) | 209 nt  | TGCC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AACT]----5'WT sub2----[CGGA]----5'WT sub3----[TGCC]----oligo+BC----[AGAA]
   ATGG                   AACT                   CGGA                   TGCC                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1     | 486 nt  | CATT  | TTTA  |
| 3   | 3'WT block        | bsmbi_3wt_tile20_sub4     | 469 nt  | TTTA  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CATT]----3'WT sub1----[TTTA]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   CATT                   TTTA                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 22 of 24 -- Codons 1284-1352 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTAA     | 0.8691   |
| oh2 (3' boundary) | CTTG     | 0.7594   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1776 nt | ATGG  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1764 nt | AACT  | CGGA  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 363 nt  | CGGA  | CTAA  |
| 4   | Oligo pool      | Tile 22 (13230 oligos) | 263 nt  | CTAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AACT]----5'WT sub2----[CGGA]----5'WT sub3----[CTAA]----oligo+BC----[AGAA]
   ATGG                   AACT                   CGGA                   CTAA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1     | 297 nt  | CTTG  | TTTA  |
| 3   | 3'WT block        | bsmbi_3wt_tile22_sub2     | 36 nt   | TTTA  | TAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile22_sub3     | 451 nt  | TAGA  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTTG]----3'WT sub1----[TTTA]----3'WT sub2----[TAGA]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   CTTG                   TTTA                   TAGA                   AAGA                          CACC 
```

**Set fidelity:** 0.9644 (5 overhangs)

---

### Tile 23 of 24 -- Codons 1347-1412 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGTC     | 0.5144   |
| oh2 (3' boundary) | GGGC     | 0.4951   |

**Variants:** 12600 mutations, 12600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1776 nt | ATGG  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1764 nt | AACT  | CGGA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 552 nt  | CGGA  | GGTC  |
| 4   | Oligo pool      | Tile 23 (12600 oligos) | 254 nt  | GGTC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AACT]----5'WT sub2----[CGGA]----5'WT sub3----[GGTC]----oligo+BC----[AGAA]
   ATGG                   AACT                   CGGA                   GGTC                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1     | 75 nt   | GGGC  | TTAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile23_sub2     | 511 nt  | TTAT  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GGGC]----3'WT sub1----[TTAT]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   GGGC                   TTAT                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 24 of 24 -- Codons 1407-1465 (177 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAA     | 0.9425   |
| oh2 (3' boundary) | TTAA     | 0.9448   |

**Variants:** 11340 mutations, 11340 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1776 nt | ATGG  | AACT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1764 nt | AACT  | CGGA  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3   | 732 nt  | CGGA  | TCAA  |
| 4   | Oligo pool      | Tile 24 (11340 oligos) | 233 nt  | TCAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AACT]----5'WT sub2----[CGGA]----5'WT sub3----[TCAA]----oligo+BC----[AGAA]
   ATGG                   AACT                   CGGA                   TCAA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                  | Length  | 5' OH | 3' OH |
| --- | ----------------- | -------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)        | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_cassette_tile24_sub1 | 409 nt  | TTAA  | AAGA  |
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

**Total blocks:** 59

| Block name                 | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| -------------------------- | ----------- | ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10            | 1776        | BsaI        | 5wt_tile10;5wt_tile11_sub1;5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile11_sub2       | 174         | BsaI        | 5wt_tile11_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile12_sub2       | 375         | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile13_sub2       | 573         | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile14_sub2       | 789         | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile15_sub2       | 957         | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile16_sub2       | 1089        | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile17_sub2       | 1302        | BsaI        | 5wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile18_sub2       | 1404        | BsaI        | 5wt_tile18_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile19_sub2       | 1605        | BsaI        | 5wt_tile19_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile2             | 234         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile20_sub2       | 1764        | BsaI        | 5wt_tile20_sub2;5wt_tile21_sub2;5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile21_sub3       | 228         | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile22_sub3       | 363         | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile23_sub3       | 552         | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile24_sub3       | 732         | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile3             | 411         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile4             | 618         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile5             | 831         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile6             | 1026        | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile7             | 1197        | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile8             | 1344        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile9             | 1560        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile1_sub1       | 1560        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile1_sub2       | 1764        | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile8_sub2                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile1_sub3       | 1282        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub3;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2;3wt_tile16_sub2;3wt_tile17_sub2;3wt_tile18_sub2                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile10_sub1      | 1608        | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile11_sub1      | 1407        | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile12_sub1      | 1209        | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile13_sub1      | 993         | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile14_sub1      | 825         | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile15_sub1      | 693         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile16_sub1      | 480         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile17_sub1      | 378         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile18_sub1      | 177         | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile19_sub1      | 348         | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile19_sub2      | 204         | BsmBI       | 3wt_tile19_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile19_sub3      | 162         | BsmBI       | 3wt_tile19_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile19_sub4      | 640         | BsmBI       | 3wt_tile19_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile2_sub1       | 1383        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile20_sub1      | 306         | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile20_sub2      | 22          | BsmBI       | 3wt_tile20_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile20_sub3      | 348         | BsmBI       | 3wt_tile20_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile20_sub4      | 469         | BsmBI       | 3wt_tile20_sub4;3wt_tile21_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile21_sub1      | 486         | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile22_sub1      | 297         | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile22_sub2      | 36          | BsmBI       | 3wt_tile22_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile22_sub3      | 451         | BsmBI       | 3wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile23_sub1      | 75          | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile23_sub2      | 511         | BsmBI       | 3wt_tile23_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile3_sub1       | 1176        | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile4_sub1       | 963         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile5_sub1       | 768         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile6_sub1       | 597         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile7_sub1       | 450         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile8_sub1       | 234         | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile9_sub1       | 1782        | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_cassette_tile1_sub4  | 1507        | BsmBI       | cassette_tile1_frag1;cassette_tile2_frag1;cassette_tile3_frag1;cassette_tile4_frag1;cassette_tile5_frag1;cassette_tile6_frag1;cassette_tile7_frag1;cassette_tile8_frag1;cassette_tile9_frag1;cassette_tile10_frag1;cassette_tile11_frag1;cassette_tile12_frag1;cassette_tile13_frag1;cassette_tile14_frag1;cassette_tile15_frag1;cassette_tile16_frag1;cassette_tile17_frag1;cassette_tile18_frag1;cassette_tile19_frag1;cassette_tile20_frag1;cassette_tile21_frag1;cassette_tile22_frag1;cassette_tile23_frag1;cassette_tile24_frag2 |
| bsmbi_cassette_tile24_sub1 | 409         | BsmBI       | cassette_tile24_frag1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |

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

