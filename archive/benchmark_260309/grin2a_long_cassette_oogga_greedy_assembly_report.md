# DMS-GG Assembly Report: GRIN2A_long_cassette

Generated: 2026-03-09 18:53:05
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                          |
| -------------------- | ------------------------------------------------------------------------------ |
| Gene name            | GRIN2A_NM_000833.5 Human GRIN2A native CDS (NM_000833.5, NP_000824.1, 1464 aa) |
| CDS length           | 4395 nt (1465 codons)                                                          |
| Protein length       | 1464 aa                                                                        |
| Number of tiles      | 29                                                                             |
| Total variants       | 28329                                                                          |
| Total oligos         | 28329                                                                          |
| Oligo length range   | 137-290 nt                                                                     |
| Gene blocks to order | 116                                                                            |
| Barcodes per variant | 1                                                                              |

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

**Total oligos:** 28329 | **Length range:** 137-290 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-27      | 483    | 137 nt |
| 2    | 28-89     | 1218   | 242 nt |
| 3    | 90-144    | 1071   | 221 nt |
| 4    | 145-179   | 651    | 161 nt |
| 5    | 180-229   | 966    | 206 nt |
| 6    | 230-279   | 966    | 206 nt |
| 7    | 280-308   | 525    | 143 nt |
| 8    | 309-373   | 1281   | 251 nt |
| 9    | 374-441   | 1344   | 260 nt |
| 10   | 442-487   | 882    | 194 nt |
| 11   | 488-537   | 966    | 206 nt |
| 12   | 538-615   | 1554   | 290 nt |
| 13   | 616-675   | 1176   | 236 nt |
| 14   | 676-733   | 1134   | 230 nt |
| 15   | 734-773   | 756    | 176 nt |
| 16   | 774-807   | 630    | 158 nt |
| 17   | 808-866   | 1155   | 233 nt |
| 18   | 867-899   | 609    | 155 nt |
| 19   | 900-958   | 1155   | 233 nt |
| 20   | 959-1005  | 903    | 197 nt |
| 21   | 1006-1036 | 567    | 149 nt |
| 22   | 1037-1093 | 1113   | 227 nt |
| 23   | 1094-1143 | 966    | 206 nt |
| 24   | 1144-1220 | 1533   | 287 nt |
| 25   | 1221-1283 | 1239   | 245 nt |
| 26   | 1284-1333 | 966    | 206 nt |
| 27   | 1334-1389 | 1092   | 224 nt |
| 28   | 1390-1427 | 714    | 170 nt |
| 29   | 1428-1465 | 714    | 170 nt |

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
| Total barcodes    | 28329                              |
| Unique barcodes   | 28329                              |
| GC content range  | 25% - 75%                          |
| GC content mean   | 47.8%                              |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                     | Description                                                   | Result | Detail                                                                                                                                                |
| ------------------------- | ------------------------------------------------------------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths             | All oligos within synthesis length limit                      | PASS   | Range: 137-290 nt (limit: 300)                                                                                                                        |
| block_lengths             | All gene blocks within synthesis length limit                 | PASS   | Range: 22-1684 nt (limit: 1800)                                                                                                                       |
| barcode_junction_sites    | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                               |
| barcode_uniqueness        | All barcodes are unique                                       | PASS   | 28329 unique / 28329 total                                                                                                                            |
| tile_coverage             | Tiles cover entire gene without gaps                          | PASS   | 4395 / 4395 nt covered                                                                                                                                |
| variant_count             | Expected number of variants generated                         | PASS   | 28329 unique variants (expected: 28329 across 1349/1463 mutable positions; 25631 missense + 1349 nonsense + 1349 wt_control; 114 position(s) skipped) |
| single_codon_change       | Each non-control variant differs by exactly one codon from WT | PASS   | 26980 / 26980 variants confirmed (WT controls excluded)                                                                                               |
| oligo_gc_content          | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 39.4-67.9% | 0 oligo(s) with extreme GC                                                                                                     |
| domestication_complete    | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                               |
| overhang_fidelity         | Tile boundary overhangs have adequate fidelity                | FAIL   | 26 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                               |
| tile_manifests            | Per-tile assembly manifests complete                          | PASS   | 29 tile manifest(s) generated                                                                                                                         |
| helper_plasmid            | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                    |
| reaction_fidelity         | Per-reaction set-level overhang fidelity                      | PASS   | Min set fidelity: 0.8502 across 58 reactions | 5 reaction(s) below 0.90                                                                               |
| barcode_poliii_term       | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 28329 barcode(s) contain TTTT                                                                                                                     |
| block_min_length          | All gene blocks above synthesis minimum length                | FAIL   | 10 block(s) below 300 nt minimum. Range: 22-1684 nt                                                                                                   |
| cassette_fragment_lengths | Cassette fragments within synthesis limits                    | PASS   | 2 cassette fragment(s). Range: 409-1507 nt. 0 over max, 0 under min.                                                                                  |
| sb_overhang_collisions    | Superblock boundary overhangs are unique (no collisions)      | PASS   | 3 SB boundary OH(s), all unique                                                                                                                       |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 8         | 0.9304             |
| 2    | 3        | 1.0000            | 8         | 0.9592             |
| 3    | 3        | 0.9150            | 8         | 0.9592             |
| 4    | 3        | 1.0000            | 8         | 0.8778             |
| 5    | 3        | 1.0000            | 8         | 0.8883             |
| 6    | 3        | 1.0000            | 7         | 0.9588             |
| 7    | 3        | 1.0000            | 7         | 0.9588             |
| 8    | 3        | 1.0000            | 7         | 0.9592             |
| 9    | 3        | 0.8741            | 7         | 0.9645             |
| 10   | 3        | 1.0000            | 7         | 0.9588             |
| 11   | 3        | 1.0000            | 6         | 0.9617             |
| 12   | 3        | 1.0000            | 6         | 0.9443             |
| 13   | 4        | 0.9907            | 7         | 0.9512             |
| 14   | 4        | 1.0000            | 7         | 0.9588             |
| 15   | 4        | 1.0000            | 7         | 0.9443             |
| 16   | 4        | 0.9718            | 6         | 0.8502             |
| 17   | 4        | 0.8940            | 7         | 0.9394             |
| 18   | 4        | 1.0000            | 6         | 0.9603             |
| 19   | 4        | 1.0000            | 6         | 0.9443             |
| 20   | 4        | 1.0000            | 5         | 0.9568             |
| 21   | 4        | 1.0000            | 6         | 0.9731             |
| 22   | 4        | 1.0000            | 5         | 0.9920             |
| 23   | 4        | 1.0000            | 5         | 0.9720             |
| 24   | 5        | 0.9986            | 5         | 0.9920             |
| 25   | 5        | 0.9852            | 4         | 1.0000             |
| 26   | 5        | 0.9388            | 5         | 1.0000             |
| 27   | 5        | 0.9706            | 4         | 1.0000             |
| 28   | 5        | 0.9892            | 4         | 1.0000             |
| 29   | 5        | 1.0000            | 3         | 1.0000             |

**Min:** 0.8502 | **Max:** 1.0000 | **Mean:** 0.9704

**Warning:** 5 reaction(s) below 0.90 fidelity — consider alternative split points or overhang reassignment.
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

### Tile 1 of 29 -- Codons 1-27 (81 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGG     | 0.5393   |
| oh2 (3' boundary) | TCCC     | 0.7759   |

**Variants:** 483 mutations, 483 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (483 oligos)                | 137 nt | ATGG  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1      | 747 nt  | TCCC  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 717 nt  | AAAA  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 642 nt  | TCAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 834 nt  | GAAA  | ACAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 624 nt  | ACAA  | TAAA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1249 nt | TAAA  | AAGA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TCCC]----3'WT sub1----[AAAA]----3'WT sub2----[TCAA]----3'WT sub3----[GAAA]----3'WT sub4----[ACAA]----3'WT sub5----[TAAA]----3'WT sub6----[AAGA]----3'WT+PolIII sub7----[CACC]
   TCCC                   AAAA                   TCAA                   GAAA                   ACAA                   TAAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9304 (8 overhangs)

---

### Tile 2 of 29 -- Codons 28-89 (186 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAGA     | 0.7444   |
| oh2 (3' boundary) | GGCA     | 0.5273   |

**Variants:** 1218 mutations, 1218 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 99 nt  | ATGG  | GAGA  |
| 2   | Oligo pool      | Tile 2 (1218 oligos)  | 242 nt | GAGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[GAGA]----oligo+BC----[AGAA]
   ATGG                    GAGA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1      | 561 nt  | GGCA  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 717 nt  | AAAA  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile2_sub3      | 810 nt  | TCAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile2_sub4      | 666 nt  | GAAA  | ACAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile2_sub5      | 714 nt  | ACAA  | CAGA  |
| 7   | 3'WT block        | bsmbi_3wt_tile2_sub6      | 1159 nt | CAGA  | AAGA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GGCA]----3'WT sub1----[AAAA]----3'WT sub2----[TCAA]----3'WT sub3----[GAAA]----3'WT sub4----[ACAA]----3'WT sub5----[CAGA]----3'WT sub6----[AAGA]----3'WT+PolIII sub7----[CACC]
   GGCA                   AAAA                   TCAA                   GAAA                   ACAA                   CAGA                   AAGA                          CACC 
```

**Set fidelity:** 0.9592 (8 overhangs)

---

### Tile 3 of 29 -- Codons 90-144 (165 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGT     | 0.6822   |
| oh2 (3' boundary) | TGGA     | 0.7377   |

**Variants:** 1071 mutations, 1071 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 285 nt | ATGG  | ATGT  |
| 2   | Oligo pool      | Tile 3 (1071 oligos)  | 221 nt | ATGT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[ATGT]----oligo+BC----[AGAA]
   ATGG                    ATGT                  AGAA 
```

**Set fidelity:** 0.9150 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1      | 612 nt  | TGGA  | TACA  |
| 3   | 3'WT block        | bsmbi_3wt_tile3_sub2      | 801 nt  | TACA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile3_sub3      | 510 nt  | AAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile2_sub4      | 666 nt  | GAAA  | ACAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile3_sub5      | 903 nt  | ACAA  | TCAA  |
| 7   | 3'WT block        | bsmbi_3wt_tile3_sub6      | 970 nt  | TCAA  | AAGA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGGA]----3'WT sub1----[TACA]----3'WT sub2----[AAAA]----3'WT sub3----[GAAA]----3'WT sub4----[ACAA]----3'WT sub5----[TCAA]----3'WT sub6----[AAGA]----3'WT+PolIII sub7----[CACC]
   TGGA                   TACA                   AAAA                   GAAA                   ACAA                   TCAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9592 (8 overhangs)

---

### Tile 4 of 29 -- Codons 145-179 (105 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCC     | 0.7958   |
| oh2 (3' boundary) | ATTC     | 0.7084   |

**Variants:** 651 mutations, 651 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 450 nt | ATGG  | TTCC  |
| 2   | Oligo pool      | Tile 4 (651 oligos)   | 161 nt | TTCC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[TTCC]----oligo+BC----[AGAA]
   ATGG                    TTCC                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1      | 699 nt  | ATTC  | TCTC  |
| 3   | 3'WT block        | bsmbi_3wt_tile4_sub2      | 609 nt  | TCTC  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile4_sub3      | 756 nt  | AAAA  | TTTC  |
| 5   | 3'WT block        | bsmbi_3wt_tile4_sub4      | 480 nt  | TTTC  | AGAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile4_sub5      | 843 nt  | AGAA  | TCAA  |
| 7   | 3'WT block        | bsmbi_3wt_tile3_sub6      | 970 nt  | TCAA  | AAGA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [ATTC]----3'WT sub1----[TCTC]----3'WT sub2----[AAAA]----3'WT sub3----[TTTC]----3'WT sub4----[AGAA]----3'WT sub5----[TCAA]----3'WT sub6----[AAGA]----3'WT+PolIII sub7----[CACC]
   ATTC                   TCTC                   AAAA                   TTTC                   AGAA                   TCAA                   AAGA                          CACC 
```

**Set fidelity:** 0.8778 (8 overhangs)

---

### Tile 5 of 29 -- Codons 180-229 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACA     | 0.8652   |
| oh2 (3' boundary) | CAAA     | 0.8948   |

**Variants:** 966 mutations, 966 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 555 nt | ATGG  | TACA  |
| 2   | Oligo pool      | Tile 5 (966 oligos)   | 206 nt | TACA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1      | 693 nt  | CAAA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile5_sub2      | 465 nt  | GAAA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile5_sub3      | 843 nt  | AAAA  | AGAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile5_sub4      | 645 nt  | AGAA  | TAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile5_sub5      | 591 nt  | TAAA  | TCAA  |
| 7   | 3'WT block        | bsmbi_3wt_tile3_sub6      | 970 nt  | TCAA  | AAGA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CAAA]----3'WT sub1----[GAAA]----3'WT sub2----[AAAA]----3'WT sub3----[AGAA]----3'WT sub4----[TAAA]----3'WT sub5----[TCAA]----3'WT sub6----[AAGA]----3'WT+PolIII sub7----[CACC]
   CAAA                   GAAA                   AAAA                   AGAA                   TAAA                   TCAA                   AAGA                          CACC 
```

**Set fidelity:** 0.8883 (8 overhangs)

---

### Tile 6 of 29 -- Codons 230-279 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACT     | 0.7445   |
| oh2 (3' boundary) | TGAC     | 0.6485   |

**Variants:** 966 mutations, 966 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 705 nt | ATGG  | TACT  |
| 2   | Oligo pool      | Tile 6 (966 oligos)   | 206 nt | TACT  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1      | 690 nt  | TGAC  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile6_sub2      | 525 nt  | TCAA  | AAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile6_sub3      | 690 nt  | AAGA  | AAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile6_sub4      | 591 nt  | AAAA  | TAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile6_sub5      | 597 nt  | TAAA  | ACAA  |
| 7   | 3'WT block        | bsmbi_3wt_tile6_sub6      | 964 nt  | ACAA  | AAGA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGAC]----3'WT sub1----[TCAA]----3'WT sub2----[AAGA]----3'WT sub3----[AAAA]----3'WT sub4----[TAAA]----3'WT sub5----[ACAA]----3'WT sub6----[AAGA]----3'WT+PolIII sub7----[CACC]
   TGAC                   TCAA                   AAGA                   AAAA                   TAAA                   ACAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9588 (7 overhangs)

---

### Tile 7 of 29 -- Codons 280-308 (87 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCT     | 0.7573   |
| oh2 (3' boundary) | CTAC     | 0.6583   |

**Variants:** 525 mutations, 525 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 855 nt | ATGG  | TCCT  |
| 2   | Oligo pool      | Tile 7 (525 oligos)   | 143 nt | TCCT  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1      | 603 nt  | CTAC  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile6_sub2      | 525 nt  | TCAA  | AAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile6_sub3      | 690 nt  | AAGA  | AAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile6_sub4      | 591 nt  | AAAA  | TAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile6_sub5      | 597 nt  | TAAA  | ACAA  |
| 7   | 3'WT block        | bsmbi_3wt_tile6_sub6      | 964 nt  | ACAA  | AAGA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTAC]----3'WT sub1----[TCAA]----3'WT sub2----[AAGA]----3'WT sub3----[AAAA]----3'WT sub4----[TAAA]----3'WT sub5----[ACAA]----3'WT sub6----[AAGA]----3'WT+PolIII sub7----[CACC]
   CTAC                   TCAA                   AAGA                   AAAA                   TAAA                   ACAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9588 (7 overhangs)

---

### Tile 8 of 29 -- Codons 309-373 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGT     | 0.7629   |
| oh2 (3' boundary) | CAAG     | 0.6640   |

**Variants:** 1281 mutations, 1281 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 942 nt | ATGG  | AAGT  |
| 2   | Oligo pool      | Tile 8 (1281 oligos)  | 251 nt | AAGT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

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
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1      | 708 nt  | CAAG  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile3_sub3      | 510 nt  | AAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile2_sub4      | 666 nt  | GAAA  | ACAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile3_sub5      | 903 nt  | ACAA  | TCAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile3_sub6      | 970 nt  | TCAA  | AAGA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CAAG]----3'WT sub1----[AAAA]----3'WT sub2----[GAAA]----3'WT sub3----[ACAA]----3'WT sub4----[TCAA]----3'WT sub5----[AAGA]----3'WT+PolIII sub6----[CACC]
   CAAG                   AAAA                   GAAA                   ACAA                   TCAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9592 (7 overhangs)

---

### Tile 9 of 29 -- Codons 374-441 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGG     | 0.6552   |
| oh2 (3' boundary) | TTCA     | 0.8824   |

**Variants:** 1344 mutations, 1344 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1137 nt | ATGG  | AAGG  |
| 2   | Oligo pool      | Tile 9 (1344 oligos)  | 260 nt  | AAGG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[AAGG]----oligo+BC----[AGAA]
   ATGG                    AAGG                  AGAA 
```

**Set fidelity:** 0.8741 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1      | 504 nt  | TTCA  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile5_sub3      | 843 nt  | AAAA  | AGAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile5_sub4      | 645 nt  | AGAA  | TAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile5_sub5      | 591 nt  | TAAA  | TCAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile3_sub6      | 970 nt  | TCAA  | AAGA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TTCA]----3'WT sub1----[AAAA]----3'WT sub2----[AGAA]----3'WT sub3----[TAAA]----3'WT sub4----[TCAA]----3'WT sub5----[AAGA]----3'WT+PolIII sub6----[CACC]
   TTCA                   AAAA                   AGAA                   TAAA                   TCAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9645 (7 overhangs)

---

### Tile 10 of 29 -- Codons 442-487 (138 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCA     | 0.7483   |
| oh2 (3' boundary) | CAAT     | 0.7361   |

**Variants:** 882 mutations, 882 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10       | 1341 nt | ATGG  | ATCA  |
| 2   | Oligo pool      | Tile 10 (882 oligos)  | 194 nt  | ATCA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[ATCA]----oligo+BC----[AGAA]
   ATGG                    ATCA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1     | 570 nt  | CAAT  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile10_sub2     | 693 nt  | TCAA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile6_sub4      | 591 nt  | AAAA  | TAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile6_sub5      | 597 nt  | TAAA  | ACAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile6_sub6      | 964 nt  | ACAA  | AAGA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CAAT]----3'WT sub1----[TCAA]----3'WT sub2----[AAAA]----3'WT sub3----[TAAA]----3'WT sub4----[ACAA]----3'WT sub5----[AAGA]----3'WT+PolIII sub6----[CACC]
   CAAT                   TCAA                   AAAA                   TAAA                   ACAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9588 (7 overhangs)

---

### Tile 11 of 29 -- Codons 488-537 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAG     | 0.7511   |
| oh2 (3' boundary) | TAAT     | 0.8165   |

**Variants:** 966 mutations, 966 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11       | 1479 nt | ATGG  | AAAG  |
| 2   | Oligo pool      | Tile 11 (966 oligos)  | 206 nt  | AAAG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[AAAG]----oligo+BC----[AGAA]
   ATGG                    AAAG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1     | 423 nt  | TAAT  | AAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile6_sub3      | 690 nt  | AAGA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile6_sub4      | 591 nt  | AAAA  | TAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile5_sub5      | 591 nt  | TAAA  | TCAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile3_sub6      | 970 nt  | TCAA  | AAGA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TAAT]----3'WT sub1----[AAGA]----3'WT sub2----[AAAA]----3'WT sub3----[TAAA]----3'WT sub4----[TCAA]----3'WT sub5----[AAGA]----3'WT+PolIII sub6----[CACC]
   TAAT                   AAGA                   AAAA                   TAAA                   TCAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9617 (6 overhangs)

---

### Tile 12 of 29 -- Codons 538-615 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAA     | 0.9425   |
| oh2 (3' boundary) | TGTC     | 0.6650   |

**Variants:** 1554 mutations, 1554 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12       | 1629 nt | ATGG  | TCAA  |
| 2   | Oligo pool      | Tile 12 (1554 oligos) | 290 nt  | TCAA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1     | 474 nt  | TGTC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile12_sub2     | 459 nt  | GAAA  | AAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile12_sub3     | 537 nt  | AAGA  | TAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile12_sub4     | 777 nt  | TAAA  | AAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile12_sub5     | 784 nt  | AAAA  | AAGA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGTC]----3'WT sub1----[GAAA]----3'WT sub2----[AAGA]----3'WT sub3----[TAAA]----3'WT sub4----[AAAA]----3'WT sub5----[AAGA]----3'WT+PolIII sub6----[CACC]
   TGTC                   GAAA                   AAGA                   TAAA                   AAAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9443 (6 overhangs)

---

### Tile 13 of 29 -- Codons 616-675 (180 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCG     | 0.7234   |
| oh2 (3' boundary) | ACCT     | 0.6222   |

**Variants:** 1176 mutations, 1176 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 824 nt  | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2  | 1057 nt | AAAA  | TCCG  |
| 3   | Oligo pool      | Tile 13 (1176 oligos) | 236 nt  | TCCG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TCCG]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TCCG                  AGAA 
```

**Set fidelity:** 0.9907 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1     | 627 nt  | ACCT  | AGAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile13_sub2     | 333 nt  | AGAA  | ACAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 624 nt  | ACAA  | TAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile13_sub4     | 483 nt  | TAAA  | AAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile12_sub5     | 784 nt  | AAAA  | AAGA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [ACCT]----3'WT sub1----[AGAA]----3'WT sub2----[ACAA]----3'WT sub3----[TAAA]----3'WT sub4----[AAAA]----3'WT sub5----[AAGA]----3'WT+PolIII sub6----[CACC]
   ACCT                   AGAA                   ACAA                   TAAA                   AAAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9512 (7 overhangs)

---

### Tile 14 of 29 -- Codons 676-733 (174 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TATT     | 0.8134   |
| oh2 (3' boundary) | TTAC     | 0.8333   |

**Variants:** 1134 mutations, 1134 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile14_sub1  | 1052 nt | ATGG  | CAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2  | 1009 nt | CAAA  | TATT  |
| 3   | Oligo pool      | Tile 14 (1134 oligos) | 230 nt  | TATT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAAA]----5'WT sub2----[TATT]----oligo+BC----[AGAA]
   ATGG                   CAAA                   TATT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1     | 507 nt  | TTAC  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile14_sub2     | 279 nt  | AAAA  | ACAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 624 nt  | ACAA  | TAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile14_sub4     | 297 nt  | TAAA  | TCAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile3_sub6      | 970 nt  | TCAA  | AAGA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TTAC]----3'WT sub1----[AAAA]----3'WT sub2----[ACAA]----3'WT sub3----[TAAA]----3'WT sub4----[TCAA]----3'WT sub5----[AAGA]----3'WT+PolIII sub6----[CACC]
   TTAC                   AAAA                   ACAA                   TAAA                   TCAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9588 (7 overhangs)

---

### Tile 15 of 29 -- Codons 734-773 (120 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTCT     | 0.5601   |
| oh2 (3' boundary) | CCTG     | 0.6383   |

**Variants:** 756 mutations, 756 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile14_sub1  | 1052 nt | ATGG  | CAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2  | 1183 nt | CAAA  | GTCT  |
| 3   | Oligo pool      | Tile 15 (756 oligos)  | 176 nt  | GTCT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAAA]----5'WT sub2----[GTCT]----oligo+BC----[AGAA]
   ATGG                   CAAA                   GTCT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1     | 387 nt  | CCTG  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile6_sub4      | 591 nt  | AAAA  | TAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile15_sub3     | 339 nt  | TAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile15_sub4     | 270 nt  | GAAA  | TCAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile3_sub6      | 970 nt  | TCAA  | AAGA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CCTG]----3'WT sub1----[AAAA]----3'WT sub2----[TAAA]----3'WT sub3----[GAAA]----3'WT sub4----[TCAA]----3'WT sub5----[AAGA]----3'WT+PolIII sub6----[CACC]
   CCTG                   AAAA                   TAAA                   GAAA                   TCAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9443 (7 overhangs)

---

### Tile 16 of 29 -- Codons 774-807 (102 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGA     | 0.8175   |
| oh2 (3' boundary) | CCAG     | 0.6122   |

**Variants:** 630 mutations, 630 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile14_sub1  | 1052 nt | ATGG  | CAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1303 nt | CAAA  | CAGA  |
| 3   | Oligo pool      | Tile 16 (630 oligos)  | 158 nt  | CAGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAAA]----5'WT sub2----[CAGA]----oligo+BC----[AGAA]
   ATGG                   CAAA                   CAGA                  AGAA 
```

**Set fidelity:** 0.9718 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1     | 858 nt  | CCAG  | TAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile15_sub3     | 339 nt  | TAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile16_sub3     | 474 nt  | GAAA  | CCAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile16_sub4     | 766 nt  | CCAA  | AAGA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CCAG]----3'WT sub1----[TAAA]----3'WT sub2----[GAAA]----3'WT sub3----[CCAA]----3'WT sub4----[AAGA]----3'WT+PolIII sub5----[CACC]
   CCAG                   TAAA                   GAAA                   CCAA                   AAGA                          CACC 
```

**Set fidelity:** 0.8502 (6 overhangs)

---

### Tile 17 of 29 -- Codons 808-866 (177 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGA     | 0.7549   |
| oh2 (3' boundary) | CTGC     | 0.5642   |

**Variants:** 1155 mutations, 1155 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile17_sub1  | 1118 nt | ATGG  | CAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2  | 1339 nt | CAAA  | ATGA  |
| 3   | Oligo pool      | Tile 17 (1155 oligos) | 233 nt  | ATGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAAA]----5'WT sub2----[ATGA]----oligo+BC----[AGAA]
   ATGG                   CAAA                   ATGA                  AGAA 
```

**Set fidelity:** 0.8940 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1     | 369 nt  | CTGC  | ACAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile17_sub2     | 330 nt  | ACAA  | TAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile15_sub3     | 339 nt  | TAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile17_sub4     | 456 nt  | GAAA  | AAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile12_sub5     | 784 nt  | AAAA  | AAGA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTGC]----3'WT sub1----[ACAA]----3'WT sub2----[TAAA]----3'WT sub3----[GAAA]----3'WT sub4----[AAAA]----3'WT sub5----[AAGA]----3'WT+PolIII sub6----[CACC]
   CTGC                   ACAA                   TAAA                   GAAA                   AAAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9394 (7 overhangs)

---

### Tile 18 of 29 -- Codons 867-899 (99 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCT     | 0.7151   |
| oh2 (3' boundary) | AAAC     | 0.6694   |

**Variants:** 609 mutations, 609 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile18_sub1  | 1337 nt | ATGG  | CAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1297 nt | CAAA  | ATCT  |
| 3   | Oligo pool      | Tile 18 (609 oligos)  | 155 nt  | ATCT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAAA]----5'WT sub2----[ATCT]----oligo+BC----[AGAA]
   ATGG                   CAAA                   ATCT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1     | 582 nt  | AAAC  | TAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile5_sub5      | 591 nt  | TAAA  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile18_sub3     | 204 nt  | TCAA  | AAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile12_sub5     | 784 nt  | AAAA  | AAGA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AAAC]----3'WT sub1----[TAAA]----3'WT sub2----[TCAA]----3'WT sub3----[AAAA]----3'WT sub4----[AAGA]----3'WT+PolIII sub5----[CACC]
   AAAC                   TAAA                   TCAA                   AAAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9603 (6 overhangs)

---

### Tile 19 of 29 -- Codons 900-958 (177 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAG     | 0.7814   |
| oh2 (3' boundary) | CGAA     | 0.7461   |

**Variants:** 1155 mutations, 1155 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile18_sub1  | 1337 nt | ATGG  | CAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1396 nt | CAAA  | TCAG  |
| 3   | Oligo pool      | Tile 19 (1155 oligos) | 233 nt  | TCAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAAA]----5'WT sub2----[TCAG]----oligo+BC----[AGAA]
   ATGG                   CAAA                   TCAG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1     | 405 nt  | CGAA  | TAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile15_sub3     | 339 nt  | TAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile17_sub4     | 456 nt  | GAAA  | AAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile12_sub5     | 784 nt  | AAAA  | AAGA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CGAA]----3'WT sub1----[TAAA]----3'WT sub2----[GAAA]----3'WT sub3----[AAAA]----3'WT sub4----[AAGA]----3'WT+PolIII sub5----[CACC]
   CGAA                   TAAA                   GAAA                   AAAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9443 (6 overhangs)

---

### Tile 20 of 29 -- Codons 959-1005 (141 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AACA     | 0.8032   |
| oh2 (3' boundary) | TAGA     | 0.9115   |

**Variants:** 903 mutations, 903 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile18_sub1  | 1337 nt | ATGG  | CAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2  | 1573 nt | CAAA  | AACA  |
| 3   | Oligo pool      | Tile 20 (903 oligos)  | 197 nt  | AACA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAAA]----5'WT sub2----[AACA]----oligo+BC----[AGAA]
   ATGG                   CAAA                   AACA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1     | 837 nt  | TAGA  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile18_sub3     | 204 nt  | TCAA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile12_sub5     | 784 nt  | AAAA  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TAGA]----3'WT sub1----[TCAA]----3'WT sub2----[AAAA]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   TAGA                   TCAA                   AAAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9568 (5 overhangs)

---

### Tile 21 of 29 -- Codons 1006-1036 (93 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCGA     | 0.5836   |
| oh2 (3' boundary) | AGAG     | 0.6016   |

**Variants:** 567 mutations, 567 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile21_sub1  | 1631 nt | ATGG  | AAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1420 nt | AAGA  | GCGA  |
| 3   | Oligo pool      | Tile 21 (567 oligos)  | 149 nt  | GCGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAGA]----5'WT sub2----[GCGA]----oligo+BC----[AGAA]
   ATGG                   AAGA                   GCGA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1     | 465 nt  | AGAG  | TAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile14_sub4     | 297 nt  | TAAA  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile18_sub3     | 204 nt  | TCAA  | AAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile12_sub5     | 784 nt  | AAAA  | AAGA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AGAG]----3'WT sub1----[TAAA]----3'WT sub2----[TCAA]----3'WT sub3----[AAAA]----3'WT sub4----[AAGA]----3'WT+PolIII sub5----[CACC]
   AGAG                   TAAA                   TCAA                   AAAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9731 (6 overhangs)

---

### Tile 22 of 29 -- Codons 1037-1093 (171 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCAA     | 0.7543   |
| oh2 (3' boundary) | GGAC     | 0.5754   |

**Variants:** 1113 mutations, 1113 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile21_sub1  | 1631 nt | ATGG  | AAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2  | 1513 nt | AAGA  | GCAA  |
| 3   | Oligo pool      | Tile 22 (1113 oligos) | 227 nt  | GCAA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAGA]----5'WT sub2----[GCAA]----oligo+BC----[AGAA]
   ATGG                   AAGA                   GCAA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1     | 573 nt  | GGAC  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile18_sub3     | 204 nt  | TCAA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile12_sub5     | 784 nt  | AAAA  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GGAC]----3'WT sub1----[TCAA]----3'WT sub2----[AAAA]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   GGAC                   TCAA                   AAAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9920 (5 overhangs)

---

### Tile 23 of 29 -- Codons 1094-1143 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACC     | 0.7054   |
| oh2 (3' boundary) | CTTC     | 0.6384   |

**Variants:** 966 mutations, 966 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile21_sub1  | 1631 nt | ATGG  | AAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2  | 1684 nt | AAGA  | TACC  |
| 3   | Oligo pool      | Tile 23 (966 oligos)  | 206 nt  | TACC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAGA]----5'WT sub2----[TACC]----oligo+BC----[AGAA]
   ATGG                   AAGA                   TACC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1     | 609 nt  | CTTC  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile23_sub2     | 22 nt   | AAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile23_sub3     | 787 nt  | GAAA  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTTC]----3'WT sub1----[AAAA]----3'WT sub2----[GAAA]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   CTTC                   AAAA                   GAAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9720 (5 overhangs)

---

### Tile 24 of 29 -- Codons 1144-1220 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AACG     | 0.5566   |
| oh2 (3' boundary) | CTAT     | 0.7299   |

**Variants:** 1533 mutations, 1533 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile14_sub1  | 1052 nt | ATGG  | CAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2  | 1143 nt | CAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3  | 1288 nt | GAAA  | AACG  |
| 4   | Oligo pool      | Tile 24 (1533 oligos) | 287 nt  | AACG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAAA]----5'WT sub2----[GAAA]----5'WT sub3----[AACG]----oligo+BC----[AGAA]
   ATGG                   CAAA                   GAAA                   AACG                  AGAA 
```

**Set fidelity:** 0.9986 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile24_sub1     | 378 nt  | CTAT  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile24_sub2     | 333 nt  | AAAA  | TTTA  |
| 4   | 3'WT block        | bsmbi_3wt_tile24_sub3     | 469 nt  | TTTA  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTAT]----3'WT sub1----[AAAA]----3'WT sub2----[TTTA]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   CTAT                   AAAA                   TTTA                   AAGA                          CACC 
```

**Set fidelity:** 0.9920 (5 overhangs)

---

### Tile 25 of 29 -- Codons 1221-1283 (189 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGC     | 0.6171   |
| oh2 (3' boundary) | TAGC     | 0.7011   |

**Variants:** 1239 mutations, 1239 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile17_sub1  | 1118 nt | ATGG  | CAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile25_sub2  | 1215 nt | CAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3  | 1381 nt | GAAA  | ATGC  |
| 4   | Oligo pool      | Tile 25 (1239 oligos) | 245 nt  | ATGC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAAA]----5'WT sub2----[GAAA]----5'WT sub3----[ATGC]----oligo+BC----[AGAA]
   ATGG                   CAAA                   GAAA                   ATGC                  AGAA 
```

**Set fidelity:** 0.9852 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile25_sub1     | 504 nt  | TAGC  | TTTA  |
| 3   | 3'WT block        | bsmbi_3wt_tile24_sub3     | 469 nt  | TTTA  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TAGC]----3'WT sub1----[TTTA]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   TAGC                   TTTA                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 26 of 29 -- Codons 1284-1333 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTAA     | 0.8691   |
| oh2 (3' boundary) | CTCG     | 0.7252   |

**Variants:** 966 mutations, 966 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile18_sub1  | 1337 nt | ATGG  | CAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile26_sub2  | 1383 nt | CAAA  | AAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3  | 1183 nt | AAAA  | CTAA  |
| 4   | Oligo pool      | Tile 26 (966 oligos)  | 206 nt  | CTAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAAA]----5'WT sub2----[AAAA]----5'WT sub3----[CTAA]----oligo+BC----[AGAA]
   ATGG                   CAAA                   AAAA                   CTAA                  AGAA 
```

**Set fidelity:** 0.9388 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile26_sub1     | 354 nt  | CTCG  | TTTA  |
| 3   | 3'WT block        | bsmbi_3wt_tile26_sub2     | 51 nt   | TTTA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile26_sub3     | 436 nt  | GAAA  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTCG]----3'WT sub1----[TTTA]----3'WT sub2----[GAAA]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   CTCG                   TTTA                   GAAA                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 27 of 29 -- Codons 1334-1389 (168 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGCA     | 0.5690   |
| oh2 (3' boundary) | ATCC     | 0.6015   |

**Variants:** 1092 mutations, 1092 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile18_sub1  | 1337 nt | ATGG  | CAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile26_sub2  | 1383 nt | CAAA  | AAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3  | 1333 nt | AAAA  | AGCA  |
| 4   | Oligo pool      | Tile 27 (1092 oligos) | 224 nt  | AGCA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAAA]----5'WT sub2----[AAAA]----5'WT sub3----[AGCA]----oligo+BC----[AGAA]
   ATGG                   CAAA                   AAAA                   AGCA                  AGAA 
```

**Set fidelity:** 0.9706 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile27_sub1     | 156 nt  | ATCC  | TAAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile27_sub2     | 499 nt  | TAAG  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [ATCC]----3'WT sub1----[TAAG]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   ATCC                   TAAG                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 28 of 29 -- Codons 1390-1427 (114 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCGT     | 0.7335   |
| oh2 (3' boundary) | TTAT     | 0.8673   |

**Variants:** 714 mutations, 714 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile18_sub1  | 1337 nt | ATGG  | CAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile26_sub2  | 1383 nt | CAAA  | AAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3  | 1501 nt | AAAA  | TCGT  |
| 4   | Oligo pool      | Tile 28 (714 oligos)  | 170 nt  | TCGT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAAA]----5'WT sub2----[AAAA]----5'WT sub3----[TCGT]----oligo+BC----[AGAA]
   ATGG                   CAAA                   AAAA                   TCGT                  AGAA 
```

**Set fidelity:** 0.9892 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile28_sub1     | 42 nt   | TTAT  | TAAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile27_sub2     | 499 nt  | TAAG  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TTAT]----3'WT sub1----[TAAG]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   TTAT                   TAAG                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 29 of 29 -- Codons 1428-1465 (114 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTTA     | 0.6139   |
| oh2 (3' boundary) | TTAA     | 0.9448   |

**Variants:** 714 mutations, 714 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile18_sub1  | 1337 nt | ATGG  | CAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile29_sub2  | 1437 nt | CAAA  | AAGA  |
| 3   | 5'WT gene block | bsai_5wt_tile29_sub3  | 1561 nt | AAGA  | GTTA  |
| 4   | Oligo pool      | Tile 29 (714 oligos)  | 170 nt  | GTTA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAAA]----5'WT sub2----[AAGA]----5'WT sub3----[GTTA]----oligo+BC----[AGAA]
   ATGG                   CAAA                   AAGA                   GTTA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                  | Length  | 5' OH | 3' OH |
| --- | ----------------- | -------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)        | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_cassette_tile29_sub1 | 409 nt  | TTAA  | AAGA  |
| 3   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7  | 1507 nt | AAGA  | CACC  |
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

**Total blocks:** 116

| Block name                 | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| -------------------------- | ----------- | ----------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10            | 1341        | BsaI        | 5wt_tile10                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile11            | 1479        | BsaI        | 5wt_tile11                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile12            | 1629        | BsaI        | 5wt_tile12                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile13_sub1       | 824         | BsaI        | 5wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile13_sub2       | 1057        | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile14_sub1       | 1052        | BsaI        | 5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile14_sub2       | 1009        | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile15_sub2       | 1183        | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile16_sub2       | 1303        | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile17_sub1       | 1118        | BsaI        | 5wt_tile17_sub1;5wt_tile25_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile17_sub2       | 1339        | BsaI        | 5wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile18_sub1       | 1337        | BsaI        | 5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile26_sub1;5wt_tile27_sub1;5wt_tile28_sub1;5wt_tile29_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile18_sub2       | 1297        | BsaI        | 5wt_tile18_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile19_sub2       | 1396        | BsaI        | 5wt_tile19_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile2             | 99          | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile20_sub2       | 1573        | BsaI        | 5wt_tile20_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile21_sub1       | 1631        | BsaI        | 5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile21_sub2       | 1420        | BsaI        | 5wt_tile21_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile22_sub2       | 1513        | BsaI        | 5wt_tile22_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile23_sub2       | 1684        | BsaI        | 5wt_tile23_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile24_sub2       | 1143        | BsaI        | 5wt_tile24_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile24_sub3       | 1288        | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile25_sub2       | 1215        | BsaI        | 5wt_tile25_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile25_sub3       | 1381        | BsaI        | 5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile26_sub2       | 1383        | BsaI        | 5wt_tile26_sub2;5wt_tile27_sub2;5wt_tile28_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile26_sub3       | 1183        | BsaI        | 5wt_tile26_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile27_sub3       | 1333        | BsaI        | 5wt_tile27_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile28_sub3       | 1501        | BsaI        | 5wt_tile28_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile29_sub2       | 1437        | BsaI        | 5wt_tile29_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile29_sub3       | 1561        | BsaI        | 5wt_tile29_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile3             | 285         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile4             | 450         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile5             | 555         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile6             | 705         | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile7             | 855         | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile8             | 942         | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile9             | 1137        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile1_sub1       | 747         | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile1_sub2       | 717         | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile1_sub3       | 642         | BsmBI       | 3wt_tile1_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile1_sub4       | 834         | BsmBI       | 3wt_tile1_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile1_sub5       | 624         | BsmBI       | 3wt_tile1_sub5;3wt_tile13_sub3;3wt_tile14_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile1_sub6       | 1249        | BsmBI       | 3wt_tile1_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile10_sub1      | 570         | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile10_sub2      | 693         | BsmBI       | 3wt_tile10_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile11_sub1      | 423         | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile12_sub1      | 474         | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile12_sub2      | 459         | BsmBI       | 3wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile12_sub3      | 537         | BsmBI       | 3wt_tile12_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile12_sub4      | 777         | BsmBI       | 3wt_tile12_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile12_sub5      | 784         | BsmBI       | 3wt_tile12_sub5;3wt_tile13_sub5;3wt_tile17_sub5;3wt_tile18_sub4;3wt_tile19_sub4;3wt_tile20_sub3;3wt_tile21_sub4;3wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile13_sub1      | 627         | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile13_sub2      | 333         | BsmBI       | 3wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile13_sub4      | 483         | BsmBI       | 3wt_tile13_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile14_sub1      | 507         | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile14_sub2      | 279         | BsmBI       | 3wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile14_sub4      | 297         | BsmBI       | 3wt_tile14_sub4;3wt_tile21_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile15_sub1      | 387         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile15_sub3      | 339         | BsmBI       | 3wt_tile15_sub3;3wt_tile16_sub2;3wt_tile17_sub3;3wt_tile19_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile15_sub4      | 270         | BsmBI       | 3wt_tile15_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile16_sub1      | 858         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile16_sub3      | 474         | BsmBI       | 3wt_tile16_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile16_sub4      | 766         | BsmBI       | 3wt_tile16_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile17_sub1      | 369         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile17_sub2      | 330         | BsmBI       | 3wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile17_sub4      | 456         | BsmBI       | 3wt_tile17_sub4;3wt_tile19_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile18_sub1      | 582         | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile18_sub3      | 204         | BsmBI       | 3wt_tile18_sub3;3wt_tile20_sub2;3wt_tile21_sub3;3wt_tile22_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile19_sub1      | 405         | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile2_sub1       | 561         | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile2_sub3       | 810         | BsmBI       | 3wt_tile2_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile2_sub4       | 666         | BsmBI       | 3wt_tile2_sub4;3wt_tile3_sub4;3wt_tile8_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile2_sub5       | 714         | BsmBI       | 3wt_tile2_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile2_sub6       | 1159        | BsmBI       | 3wt_tile2_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile20_sub1      | 837         | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile21_sub1      | 465         | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile22_sub1      | 573         | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile23_sub1      | 609         | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile23_sub2      | 22          | BsmBI       | 3wt_tile23_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile23_sub3      | 787         | BsmBI       | 3wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile24_sub1      | 378         | BsmBI       | 3wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile24_sub2      | 333         | BsmBI       | 3wt_tile24_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile24_sub3      | 469         | BsmBI       | 3wt_tile24_sub3;3wt_tile25_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile25_sub1      | 504         | BsmBI       | 3wt_tile25_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile26_sub1      | 354         | BsmBI       | 3wt_tile26_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile26_sub2      | 51          | BsmBI       | 3wt_tile26_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile26_sub3      | 436         | BsmBI       | 3wt_tile26_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile27_sub1      | 156         | BsmBI       | 3wt_tile27_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile27_sub2      | 499         | BsmBI       | 3wt_tile27_sub2;3wt_tile28_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile28_sub1      | 42          | BsmBI       | 3wt_tile28_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile3_sub1       | 612         | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile3_sub2       | 801         | BsmBI       | 3wt_tile3_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile3_sub3       | 510         | BsmBI       | 3wt_tile3_sub3;3wt_tile8_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile3_sub5       | 903         | BsmBI       | 3wt_tile3_sub5;3wt_tile8_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile3_sub6       | 970         | BsmBI       | 3wt_tile3_sub6;3wt_tile4_sub6;3wt_tile5_sub6;3wt_tile8_sub5;3wt_tile9_sub5;3wt_tile11_sub5;3wt_tile14_sub5;3wt_tile15_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile4_sub1       | 699         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile4_sub2       | 609         | BsmBI       | 3wt_tile4_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile4_sub3       | 756         | BsmBI       | 3wt_tile4_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile4_sub4       | 480         | BsmBI       | 3wt_tile4_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile4_sub5       | 843         | BsmBI       | 3wt_tile4_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile5_sub1       | 693         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile5_sub2       | 465         | BsmBI       | 3wt_tile5_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile5_sub3       | 843         | BsmBI       | 3wt_tile5_sub3;3wt_tile9_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile5_sub4       | 645         | BsmBI       | 3wt_tile5_sub4;3wt_tile9_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile5_sub5       | 591         | BsmBI       | 3wt_tile5_sub5;3wt_tile9_sub4;3wt_tile11_sub4;3wt_tile18_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile6_sub1       | 690         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile6_sub2       | 525         | BsmBI       | 3wt_tile6_sub2;3wt_tile7_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile6_sub3       | 690         | BsmBI       | 3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile11_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile6_sub4       | 591         | BsmBI       | 3wt_tile6_sub4;3wt_tile7_sub4;3wt_tile10_sub3;3wt_tile11_sub3;3wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile6_sub5       | 597         | BsmBI       | 3wt_tile6_sub5;3wt_tile7_sub5;3wt_tile10_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile6_sub6       | 964         | BsmBI       | 3wt_tile6_sub6;3wt_tile7_sub6;3wt_tile10_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile7_sub1       | 603         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile8_sub1       | 708         | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile9_sub1       | 504         | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_cassette_tile1_sub7  | 1507        | BsmBI       | cassette_tile1_frag1;cassette_tile2_frag1;cassette_tile3_frag1;cassette_tile4_frag1;cassette_tile5_frag1;cassette_tile6_frag1;cassette_tile7_frag1;cassette_tile8_frag1;cassette_tile9_frag1;cassette_tile10_frag1;cassette_tile11_frag1;cassette_tile12_frag1;cassette_tile13_frag1;cassette_tile14_frag1;cassette_tile15_frag1;cassette_tile16_frag1;cassette_tile17_frag1;cassette_tile18_frag1;cassette_tile19_frag1;cassette_tile20_frag1;cassette_tile21_frag1;cassette_tile22_frag1;cassette_tile23_frag1;cassette_tile24_frag1;cassette_tile25_frag1;cassette_tile26_frag1;cassette_tile27_frag1;cassette_tile28_frag1;cassette_tile29_frag2 |
| bsmbi_cassette_tile29_sub1 | 409         | BsmBI       | cassette_tile29_frag1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |

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

| Parameter             | Value        |
| --------------------- | ------------ |
| max_oligo_length      | 300          |
| max_geneblock_length  | 1800         |
| barcode_length        | 20           |
| min_hamming_distance  | 3            |
| barcode_prefix_length | 12           |
| barcodes_per_variant  | 1            |
| boundary_method       | oogga_greedy |
| multi_k_search        | TRUE         |
| auto_domesticate      | TRUE         |

