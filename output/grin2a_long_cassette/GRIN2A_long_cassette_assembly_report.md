# DMS-GG Assembly Report: GRIN2A_long_cassette

Generated: 2026-03-08 14:30:44
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                          |
| -------------------- | ------------------------------------------------------------------------------ |
| Gene name            | GRIN2A_NM_000833.5 Human GRIN2A native CDS (NM_000833.5, NP_000824.1, 1464 aa) |
| CDS length           | 4395 nt (1465 codons)                                                          |
| Protein length       | 1464 aa                                                                        |
| Number of tiles      | 21                                                                             |
| Total variants       | 30681                                                                          |
| Total oligos         | 306810                                                                         |
| Oligo length range   | 158-290 nt                                                                     |
| Gene blocks to order | 57                                                                             |
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

**Total oligos:** 306810 | **Length range:** 158-290 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-73      | 14490  | 275 nt |
| 2    | 70-146    | 15330  | 287 nt |
| 3    | 143-219   | 15330  | 287 nt |
| 4    | 216-293   | 15540  | 290 nt |
| 5    | 290-366   | 15330  | 287 nt |
| 6    | 363-440   | 15540  | 290 nt |
| 7    | 437-511   | 14910  | 281 nt |
| 8    | 508-541   | 6300   | 158 nt |
| 9    | 538-615   | 15540  | 290 nt |
| 10   | 612-688   | 15330  | 287 nt |
| 11   | 685-762   | 15540  | 290 nt |
| 12   | 759-835   | 15330  | 287 nt |
| 13   | 832-908   | 15330  | 287 nt |
| 14   | 905-981   | 15330  | 287 nt |
| 15   | 978-1055  | 15540  | 290 nt |
| 16   | 1052-1109 | 11340  | 230 nt |
| 17   | 1106-1182 | 15330  | 287 nt |
| 18   | 1179-1254 | 15120  | 284 nt |
| 19   | 1251-1328 | 15540  | 290 nt |
| 20   | 1325-1400 | 15120  | 284 nt |
| 21   | 1397-1465 | 13650  | 263 nt |

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
| Total barcodes    | 306810                             |
| Unique barcodes   | 306810                             |
| GC content range  | 25% - 75%                          |
| GC content mean   | 47.9%                              |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                     | Description                                                   | Result | Detail                                                                                                                                              |
| ------------------------- | ------------------------------------------------------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths             | All oligos within synthesis length limit                      | PASS   | Range: 158-290 nt (limit: 300)                                                                                                                      |
| block_lengths             | All gene blocks within synthesis length limit                 | PASS   | Range: 36-1650 nt (limit: 1800)                                                                                                                     |
| barcode_junction_sites    | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                             |
| barcode_uniqueness        | All barcodes are unique                                       | PASS   | 306810 unique / 306810 total                                                                                                                        |
| tile_coverage             | Tiles cover entire gene without gaps                          | PASS   | 4395 / 4395 nt covered                                                                                                                              |
| variant_count             | Expected number of variants generated                         | PASS   | 30681 unique variants (expected: 30681 across 1461/1463 mutable positions; 27759 missense + 1461 nonsense + 1461 wt_control; 2 position(s) skipped) |
| single_codon_change       | Each non-control variant differs by exactly one codon from WT | PASS   | 292200 / 292200 variants confirmed (WT controls excluded)                                                                                           |
| oligo_gc_content          | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 42.6-67.6% | 0 oligo(s) with extreme GC                                                                                                   |
| domestication_complete    | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                             |
| overhang_fidelity         | Tile boundary overhangs have adequate fidelity                | FAIL   | 21 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                             |
| tile_manifests            | Per-tile assembly manifests complete                          | PASS   | 21 tile manifest(s) generated                                                                                                                       |
| helper_plasmid            | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                  |
| reaction_fidelity         | Per-reaction set-level overhang fidelity                      | PASS   | Min set fidelity: 0.8305 across 42 reactions | 6 reaction(s) below 0.90                                                                             |
| barcode_poliii_term       | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 306810 barcode(s) contain TTTT                                                                                                                  |
| block_min_length          | All gene blocks above synthesis minimum length                | FAIL   | 13 block(s) below 300 nt minimum. Range: 36-1650 nt                                                                                                 |
| cassette_fragment_lengths | Cassette fragments within synthesis limits                    | PASS   | 5 cassette fragment(s). Range: 953-963 nt. 0 over max, 0 under min.                                                                                 |
| sb_overhang_collisions    | Superblock boundary overhangs are unique (no collisions)      | PASS   | 3 SB boundary OH(s), all unique                                                                                                                     |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 6         | 0.9988             |
| 2    | 3        | 1.0000            | 6         | 0.9969             |
| 3    | 3        | 1.0000            | 6         | 0.9988             |
| 4    | 3        | 1.0000            | 6         | 0.9988             |
| 5    | 3        | 1.0000            | 6         | 0.9988             |
| 6    | 3        | 1.0000            | 6         | 0.9988             |
| 7    | 3        | 1.0000            | 5         | 0.9988             |
| 8    | 3        | 1.0000            | 5         | 0.9870             |
| 9    | 3        | 1.0000            | 5         | 0.9944             |
| 10   | 4        | 1.0000            | 5         | 0.9988             |
| 11   | 4        | 1.0000            | 5         | 0.9988             |
| 12   | 4        | 1.0000            | 5         | 0.9972             |
| 13   | 4        | 0.8305            | 5         | 0.9988             |
| 14   | 4        | 1.0000            | 5         | 0.9988             |
| 15   | 4        | 1.0000            | 7         | 0.9597             |
| 16   | 4        | 1.0000            | 6         | 0.9321             |
| 17   | 5        | 0.8941            | 7         | 0.9809             |
| 18   | 5        | 0.8941            | 5         | 1.0000             |
| 19   | 5        | 0.8941            | 6         | 1.0000             |
| 20   | 5        | 0.8941            | 5         | 0.9487             |
| 21   | 5        | 0.8941            | 3         | 0.9974             |

**Min:** 0.8305 | **Max:** 1.0000 | **Mean:** 0.9782

**Warning:** 6 reaction(s) below 0.90 fidelity — consider alternative split points or overhang reassignment.
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

### Tile 1 of 21 -- Codons 1-73 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGG     | 0.5393   |
| oh2 (3' boundary) | GCTG     | 0.4520   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (14490 oligos)              | 275 nt | ATGG  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1      | 1332 nt | GCTG  | CTCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1650 nt | CTCG  | AGAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1252 nt | AGAG  | GGAA  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 954 nt  | GGAA  | TAAA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 962 nt  | TAAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GCTG]----3'WT sub1----[CTCG]----3'WT sub2----[AGAG]----3'WT sub3----[GGAA]----3'WT sub4----[TAAA]----3'WT+PolIII sub5----[CACC]
   GCTG                   CTCG                   AGAG                   GGAA                   TAAA                          CACC 
```

**Set fidelity:** 0.9988 (6 overhangs)

---

### Tile 2 of 21 -- Codons 70-146 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTAG     | 0.5615   |
| oh2 (3' boundary) | CCAG     | 0.6122   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 225 nt | ATGG  | GTAG  |
| 2   | Oligo pool      | Tile 2 (15330 oligos) | 287 nt | GTAG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[GTAG]----oligo+BC----[AGAA]
   ATGG                    GTAG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1      | 1113 nt | CCAG  | CTCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1650 nt | CTCG  | AGAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1252 nt | AGAG  | GGAA  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 954 nt  | GGAA  | TAAA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 962 nt  | TAAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CCAG]----3'WT sub1----[CTCG]----3'WT sub2----[AGAG]----3'WT sub3----[GGAA]----3'WT sub4----[TAAA]----3'WT+PolIII sub5----[CACC]
   CCAG                   CTCG                   AGAG                   GGAA                   TAAA                          CACC 
```

**Set fidelity:** 0.9969 (6 overhangs)

---

### Tile 3 of 21 -- Codons 143-219 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACCT     | 0.6222   |
| oh2 (3' boundary) | GCTG     | 0.4520   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 444 nt | ATGG  | ACCT  |
| 2   | Oligo pool      | Tile 3 (15330 oligos) | 287 nt | ACCT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[ACCT]----oligo+BC----[AGAA]
   ATGG                    ACCT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1      | 894 nt  | GCTG  | CTCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1650 nt | CTCG  | AGAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1252 nt | AGAG  | GGAA  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 954 nt  | GGAA  | TAAA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 962 nt  | TAAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GCTG]----3'WT sub1----[CTCG]----3'WT sub2----[AGAG]----3'WT sub3----[GGAA]----3'WT sub4----[TAAA]----3'WT+PolIII sub5----[CACC]
   GCTG                   CTCG                   AGAG                   GGAA                   TAAA                          CACC 
```

**Set fidelity:** 0.9988 (6 overhangs)

---

### Tile 4 of 21 -- Codons 216-293 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAAG     | 0.6640   |
| oh2 (3' boundary) | GAGG     | 0.5599   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 663 nt | ATGG  | CAAG  |
| 2   | Oligo pool      | Tile 4 (15540 oligos) | 290 nt | CAAG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[CAAG]----oligo+BC----[AGAA]
   ATGG                    CAAG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1      | 672 nt  | GAGG  | CTCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1650 nt | CTCG  | AGAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1252 nt | AGAG  | GGAA  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 954 nt  | GGAA  | TAAA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 962 nt  | TAAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAGG]----3'WT sub1----[CTCG]----3'WT sub2----[AGAG]----3'WT sub3----[GGAA]----3'WT sub4----[TAAA]----3'WT+PolIII sub5----[CACC]
   GAGG                   CTCG                   AGAG                   GGAA                   TAAA                          CACC 
```

**Set fidelity:** 0.9988 (6 overhangs)

---

### Tile 5 of 21 -- Codons 290-366 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCGA     | 0.5836   |
| oh2 (3' boundary) | GCTG     | 0.4520   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 885 nt | ATGG  | GCGA  |
| 2   | Oligo pool      | Tile 5 (15330 oligos) | 287 nt | GCGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[GCGA]----oligo+BC----[AGAA]
   ATGG                    GCGA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1      | 453 nt  | GCTG  | CTCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1650 nt | CTCG  | AGAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1252 nt | AGAG  | GGAA  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 954 nt  | GGAA  | TAAA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 962 nt  | TAAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GCTG]----3'WT sub1----[CTCG]----3'WT sub2----[AGAG]----3'WT sub3----[GGAA]----3'WT sub4----[TAAA]----3'WT+PolIII sub5----[CACC]
   GCTG                   CTCG                   AGAG                   GGAA                   TAAA                          CACC 
```

**Set fidelity:** 0.9988 (6 overhangs)

---

### Tile 6 of 21 -- Codons 363-440 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTGA     | 0.5613   |
| oh2 (3' boundary) | CGTC     | 0.5136   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 1104 nt | ATGG  | GTGA  |
| 2   | Oligo pool      | Tile 6 (15540 oligos) | 290 nt  | GTGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[GTGA]----oligo+BC----[AGAA]
   ATGG                    GTGA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1      | 231 nt  | CGTC  | CTCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1650 nt | CTCG  | AGAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1252 nt | AGAG  | GGAA  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 954 nt  | GGAA  | TAAA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 962 nt  | TAAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CGTC]----3'WT sub1----[CTCG]----3'WT sub2----[AGAG]----3'WT sub3----[GGAA]----3'WT sub4----[TAAA]----3'WT+PolIII sub5----[CACC]
   CGTC                   CTCG                   AGAG                   GGAA                   TAAA                          CACC 
```

**Set fidelity:** 0.9988 (6 overhangs)

---

### Tile 7 of 21 -- Codons 437-511 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CGGA     | 0.6609   |
| oh2 (3' boundary) | CTCG     | 0.7252   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 1326 nt | ATGG  | CGGA  |
| 2   | Oligo pool      | Tile 7 (14910 oligos) | 281 nt  | CGGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[CGGA]----oligo+BC----[AGAA]
   ATGG                    CGGA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1650 nt | CTCG  | AGAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1252 nt | AGAG  | GGAA  |
| 4   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 954 nt  | GGAA  | TAAA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 962 nt  | TAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTCG]----3'WT sub1----[AGAG]----3'WT sub2----[GGAA]----3'WT sub3----[TAAA]----3'WT+PolIII sub4----[CACC]
   CTCG                   AGAG                   GGAA                   TAAA                          CACC 
```

**Set fidelity:** 0.9988 (5 overhangs)

---

### Tile 8 of 21 -- Codons 508-541 (102 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCAG     | 0.5118   |
| oh2 (3' boundary) | TAAT     | 0.8165   |

**Variants:** 6300 mutations, 6300 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1539 nt | ATGG  | GCAG  |
| 2   | Oligo pool      | Tile 8 (6300 oligos)  | 158 nt  | GCAG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[GCAG]----oligo+BC----[AGAA]
   ATGG                    GCAG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1      | 1560 nt | TAAT  | AGAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1252 nt | AGAG  | GGAA  |
| 4   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 954 nt  | GGAA  | TAAA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 962 nt  | TAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TAAT]----3'WT sub1----[AGAG]----3'WT sub2----[GGAA]----3'WT sub3----[TAAA]----3'WT+PolIII sub4----[CACC]
   TAAT                   AGAG                   GGAA                   TAAA                          CACC 
```

**Set fidelity:** 0.9870 (5 overhangs)

---

### Tile 9 of 21 -- Codons 538-615 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAA     | 0.9425   |
| oh2 (3' boundary) | TAAC     | 0.7715   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9_sub1   | 1629 nt | ATGG  | TCAA  |
| 2   | Oligo pool      | Tile 9 (15540 oligos) | 290 nt  | TCAA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1      | 1338 nt | TAAC  | AGAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1252 nt | AGAG  | GGAA  |
| 4   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 954 nt  | GGAA  | TAAA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 962 nt  | TAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TAAC]----3'WT sub1----[AGAG]----3'WT sub2----[GGAA]----3'WT sub3----[TAAA]----3'WT+PolIII sub4----[CACC]
   TAAC                   AGAG                   GGAA                   TAAA                          CACC 
```

**Set fidelity:** 0.9944 (5 overhangs)

---

### Tile 10 of 21 -- Codons 612-688 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTGT     | 0.5081   |
| oh2 (3' boundary) | TGGA     | 0.7377   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1547 nt | ATGG  | CTCG  |
| 2   | 5'WT gene block | bsai_5wt_tile10_sub2   | 322 nt  | CTCG  | GTGT  |
| 3   | Oligo pool      | Tile 10 (15330 oligos) | 287 nt  | GTGT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CTCG]----5'WT sub2----[GTGT]----oligo+BC----[AGAA]
   ATGG                   CTCG                   GTGT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1     | 1119 nt | TGGA  | AGAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1252 nt | AGAG  | GGAA  |
| 4   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 954 nt  | GGAA  | TAAA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 962 nt  | TAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGGA]----3'WT sub1----[AGAG]----3'WT sub2----[GGAA]----3'WT sub3----[TAAA]----3'WT+PolIII sub4----[CACC]
   TGGA                   AGAG                   GGAA                   TAAA                          CACC 
```

**Set fidelity:** 0.9988 (5 overhangs)

---

### Tile 11 of 21 -- Codons 685-762 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTGC     | 0.4969   |
| oh2 (3' boundary) | TGGA     | 0.7377   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1547 nt | ATGG  | CTCG  |
| 2   | 5'WT gene block | bsai_5wt_tile11_sub2   | 541 nt  | CTCG  | GTGC  |
| 3   | Oligo pool      | Tile 11 (15540 oligos) | 290 nt  | GTGC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CTCG]----5'WT sub2----[GTGC]----oligo+BC----[AGAA]
   ATGG                   CTCG                   GTGC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1     | 897 nt  | TGGA  | AGAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1252 nt | AGAG  | GGAA  |
| 4   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 954 nt  | GGAA  | TAAA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 962 nt  | TAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGGA]----3'WT sub1----[AGAG]----3'WT sub2----[GGAA]----3'WT sub3----[TAAA]----3'WT+PolIII sub4----[CACC]
   TGGA                   AGAG                   GGAA                   TAAA                          CACC 
```

**Set fidelity:** 0.9988 (5 overhangs)

---

### Tile 12 of 21 -- Codons 759-835 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACCG     | 0.5169   |
| oh2 (3' boundary) | CTTC     | 0.6384   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1547 nt | ATGG  | CTCG  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2   | 763 nt  | CTCG  | ACCG  |
| 3   | Oligo pool      | Tile 12 (15330 oligos) | 287 nt  | ACCG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CTCG]----5'WT sub2----[ACCG]----oligo+BC----[AGAA]
   ATGG                   CTCG                   ACCG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1     | 678 nt  | CTTC  | AGAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1252 nt | AGAG  | GGAA  |
| 4   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 954 nt  | GGAA  | TAAA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 962 nt  | TAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTTC]----3'WT sub1----[AGAG]----3'WT sub2----[GGAA]----3'WT sub3----[TAAA]----3'WT+PolIII sub4----[CACC]
   CTTC                   AGAG                   GGAA                   TAAA                          CACC 
```

**Set fidelity:** 0.9972 (5 overhangs)

---

### Tile 13 of 21 -- Codons 832-908 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTCA     | 0.6872   |
| oh2 (3' boundary) | GTCC     | 0.5806   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1547 nt | ATGG  | CTCG  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 982 nt  | CTCG  | CTCA  |
| 3   | Oligo pool      | Tile 13 (15330 oligos) | 287 nt  | CTCA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CTCG]----5'WT sub2----[CTCA]----oligo+BC----[AGAA]
   ATGG                   CTCG                   CTCA                  AGAA 
```

**Set fidelity:** 0.8305 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1     | 459 nt  | GTCC  | AGAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1252 nt | AGAG  | GGAA  |
| 4   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 954 nt  | GGAA  | TAAA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 962 nt  | TAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GTCC]----3'WT sub1----[AGAG]----3'WT sub2----[GGAA]----3'WT sub3----[TAAA]----3'WT+PolIII sub4----[CACC]
   GTCC                   AGAG                   GGAA                   TAAA                          CACC 
```

**Set fidelity:** 0.9988 (5 overhangs)

---

### Tile 14 of 21 -- Codons 905-981 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCA     | 0.8519   |
| oh2 (3' boundary) | CCAG     | 0.6122   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1547 nt | ATGG  | CTCG  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1201 nt | CTCG  | TCCA  |
| 3   | Oligo pool      | Tile 14 (15330 oligos) | 287 nt  | TCCA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CTCG]----5'WT sub2----[TCCA]----oligo+BC----[AGAA]
   ATGG                   CTCG                   TCCA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1     | 240 nt  | CCAG  | AGAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1252 nt | AGAG  | GGAA  |
| 4   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 954 nt  | GGAA  | TAAA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 962 nt  | TAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CCAG]----3'WT sub1----[AGAG]----3'WT sub2----[GGAA]----3'WT sub3----[TAAA]----3'WT+PolIII sub4----[CACC]
   CCAG                   AGAG                   GGAA                   TAAA                          CACC 
```

**Set fidelity:** 0.9988 (5 overhangs)

---

### Tile 15 of 21 -- Codons 978-1055 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TATG     | 0.7006   |
| oh2 (3' boundary) | AGAG     | 0.6016   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1547 nt | ATGG  | CTCG  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1420 nt | CTCG  | TATG  |
| 3   | Oligo pool      | Tile 15 (15540 oligos) | 290 nt  | TATG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CTCG]----5'WT sub2----[TATG]----oligo+BC----[AGAA]
   ATGG                   CTCG                   TATG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                  | Length | 5' OH | 3' OH |
| --- | ----------------- | -------------------------- | ------ | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)        | --     | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1      | 408 nt | AGAG  | TAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile15_sub2      | 297 nt | TAAA  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile15_sub3      | 204 nt | TCAA  | AAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile15_sub4      | 397 nt | AAAA  | GGAA  |
| 6   | 3'WT block        | bsmbi_cassette_tile15_sub5 | 953 nt | GGAA  | ATAA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile15_sub6 | 963 nt | ATAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1   | --     | --    | --    |

```
  [AGAG]----3'WT sub1----[TAAA]----3'WT sub2----[TCAA]----3'WT sub3----[AAAA]----3'WT sub4----[GGAA]----3'WT sub5----[ATAA]----3'WT+PolIII sub6----[CACC]
   AGAG                   TAAA                   TCAA                   AAAA                   GGAA                   ATAA                          CACC 
```

**Set fidelity:** 0.9597 (7 overhangs)

---

### Tile 16 of 21 -- Codons 1052-1109 (174 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTTC     | 0.6384   |
| oh2 (3' boundary) | CAAA     | 0.8948   |

**Variants:** 11340 mutations, 11340 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1547 nt | ATGG  | CTCG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1642 nt | CTCG  | CTTC  |
| 3   | Oligo pool      | Tile 16 (11340 oligos) | 230 nt  | CTTC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CTCG]----5'WT sub2----[CTTC]----oligo+BC----[AGAA]
   ATGG                   CTCG                   CTTC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------ | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --     | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1     | 525 nt | CAAA  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile15_sub3     | 204 nt | TCAA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile15_sub4     | 397 nt | AAAA  | GGAA  |
| 5   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 954 nt | GGAA  | TAAA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 962 nt | TAAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --     | --    | --    |

```
  [CAAA]----3'WT sub1----[TCAA]----3'WT sub2----[AAAA]----3'WT sub3----[GGAA]----3'WT sub4----[TAAA]----3'WT+PolIII sub5----[CACC]
   CAAA                   TCAA                   AAAA                   GGAA                   TAAA                          CACC 
```

**Set fidelity:** 0.9321 (6 overhangs)

---

### Tile 17 of 21 -- Codons 1106-1182 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTGA     | 0.6791   |
| oh2 (3' boundary) | CGAC     | 0.4695   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1547 nt | ATGG  | CTCG  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 1650 nt | CTCG  | AGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile17_sub3   | 172 nt  | AGAG  | CTGA  |
| 4   | Oligo pool      | Tile 17 (15330 oligos) | 287 nt  | CTGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CTCG]----5'WT sub2----[AGAG]----5'WT sub3----[CTGA]----oligo+BC----[AGAA]
   ATGG                   CTCG                   AGAG                   CTGA                  AGAA 
```

**Set fidelity:** 0.8941 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------ | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --     | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1     | 306 nt | CGAC  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile15_sub3     | 204 nt | TCAA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile17_sub3     | 291 nt | AAAA  | TTAT  |
| 5   | 3'WT block        | bsmbi_3wt_tile17_sub4     | 124 nt | TTAT  | GGAA  |
| 6   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 954 nt | GGAA  | TAAA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 962 nt | TAAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --     | --    | --    |

```
  [CGAC]----3'WT sub1----[TCAA]----3'WT sub2----[AAAA]----3'WT sub3----[TTAT]----3'WT sub4----[GGAA]----3'WT sub5----[TAAA]----3'WT+PolIII sub6----[CACC]
   CGAC                   TCAA                   AAAA                   TTAT                   GGAA                   TAAA                          CACC 
```

**Set fidelity:** 0.9809 (7 overhangs)

---

### Tile 18 of 21 -- Codons 1179-1254 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCA     | 0.8519   |
| oh2 (3' boundary) | GCTT     | 0.5632   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1547 nt | ATGG  | CTCG  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 1650 nt | CTCG  | AGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile18_sub3   | 391 nt  | AGAG  | TCCA  |
| 4   | Oligo pool      | Tile 18 (15120 oligos) | 284 nt  | TCCA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CTCG]----5'WT sub2----[AGAG]----5'WT sub3----[TCCA]----oligo+BC----[AGAA]
   ATGG                   CTCG                   AGAG                   TCCA                  AGAA 
```

**Set fidelity:** 0.8941 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                  | Length | 5' OH | 3' OH |
| --- | ----------------- | -------------------------- | ------ | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)        | --     | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1      | 591 nt | GCTT  | TTTA  |
| 3   | 3'WT block        | bsmbi_3wt_tile18_sub2      | 82 nt  | TTTA  | GGAA  |
| 4   | 3'WT block        | bsmbi_cassette_tile15_sub5 | 953 nt | GGAA  | ATAA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile15_sub6 | 963 nt | ATAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1   | --     | --    | --    |

```
  [GCTT]----3'WT sub1----[TTTA]----3'WT sub2----[GGAA]----3'WT sub3----[ATAA]----3'WT+PolIII sub4----[CACC]
   GCTT                   TTTA                   GGAA                   ATAA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 19 of 21 -- Codons 1251-1328 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GACC     | 0.5155   |
| oh2 (3' boundary) | CCTG     | 0.6383   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1547 nt | ATGG  | CTCG  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 1650 nt | CTCG  | AGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3   | 607 nt  | AGAG  | GACC  |
| 4   | Oligo pool      | Tile 19 (15540 oligos) | 290 nt  | GACC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CTCG]----5'WT sub2----[AGAG]----5'WT sub3----[GACC]----oligo+BC----[AGAA]
   ATGG                   CTCG                   AGAG                   GACC                  AGAA 
```

**Set fidelity:** 0.8941 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                  | Length | 5' OH | 3' OH |
| --- | ----------------- | -------------------------- | ------ | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)        | --     | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1      | 369 nt | CCTG  | TTTA  |
| 3   | 3'WT block        | bsmbi_3wt_tile19_sub2      | 36 nt  | TTTA  | TAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile19_sub3      | 64 nt  | TAGA  | GGAA  |
| 5   | 3'WT block        | bsmbi_cassette_tile15_sub5 | 953 nt | GGAA  | ATAA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile15_sub6 | 963 nt | ATAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1   | --     | --    | --    |

```
  [CCTG]----3'WT sub1----[TTTA]----3'WT sub2----[TAGA]----3'WT sub3----[GGAA]----3'WT sub4----[ATAA]----3'WT+PolIII sub5----[CACC]
   CCTG                   TTTA                   TAGA                   GGAA                   ATAA                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 20 of 21 -- Codons 1325-1400 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACG     | 0.6478   |
| oh2 (3' boundary) | CTAT     | 0.7299   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1547 nt | ATGG  | CTCG  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 1650 nt | CTCG  | AGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile20_sub3   | 829 nt  | AGAG  | TACG  |
| 4   | Oligo pool      | Tile 20 (15120 oligos) | 284 nt  | TACG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CTCG]----5'WT sub2----[AGAG]----5'WT sub3----[TACG]----oligo+BC----[AGAA]
   ATGG                   CTCG                   AGAG                   TACG                  AGAA 
```

**Set fidelity:** 0.8941 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------ | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --     | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1     | 186 nt | CTAT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile20_sub2     | 49 nt  | GAAA  | GGAA  |
| 4   | 3'WT block        | bsmbi_cassette_tile1_sub4 | 954 nt | GGAA  | TAAA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 962 nt | TAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --     | --    | --    |

```
  [CTAT]----3'WT sub1----[GAAA]----3'WT sub2----[GGAA]----3'WT sub3----[TAAA]----3'WT+PolIII sub4----[CACC]
   CTAT                   GAAA                   GGAA                   TAAA                          CACC 
```

**Set fidelity:** 0.9487 (5 overhangs)

---

### Tile 21 of 21 -- Codons 1397-1465 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATG     | 0.6412   |
| oh2 (3' boundary) | TTAA     | 0.9448   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1547 nt | ATGG  | CTCG  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 1650 nt | CTCG  | AGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3   | 1045 nt | AGAG  | AATG  |
| 4   | Oligo pool      | Tile 21 (13650 oligos) | 263 nt  | AATG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CTCG]----5'WT sub2----[AGAG]----5'WT sub3----[AATG]----oligo+BC----[AGAA]
   ATGG                   CTCG                   AGAG                   AATG                  AGAA 
```

**Set fidelity:** 0.8941 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                  | Length | 5' OH | 3' OH |
| --- | ----------------- | -------------------------- | ------ | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)        | --     | --    | --    |
| 2   | 3'WT block        | bsmbi_cassette_tile21_sub1 | 954 nt | TTAA  | TAAA  |
| 3   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5  | 962 nt | TAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1   | --     | --    | --    |

```
  [TTAA]----3'WT sub1----[TAAA]----3'WT+PolIII sub2----[CACC]
   TTAA                   TAAA                          CACC 
```

**Set fidelity:** 0.9974 (3 overhangs)

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

**Total blocks:** 57

| Block name                 | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                        |
| -------------------------- | ----------- | ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10_sub1       | 1547        | BsaI        | 5wt_tile10_sub1;5wt_tile11_sub1;5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1                                                                                                                                                                                                    |
| bsai_5wt_tile10_sub2       | 322         | BsaI        | 5wt_tile10_sub2                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile11_sub2       | 541         | BsaI        | 5wt_tile11_sub2                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile12_sub2       | 763         | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile13_sub2       | 982         | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile14_sub2       | 1201        | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile15_sub2       | 1420        | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile16_sub2       | 1642        | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile17_sub2       | 1650        | BsaI        | 5wt_tile17_sub2;5wt_tile18_sub2;5wt_tile19_sub2;5wt_tile20_sub2;5wt_tile21_sub2                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile17_sub3       | 172         | BsaI        | 5wt_tile17_sub3                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile18_sub3       | 391         | BsaI        | 5wt_tile18_sub3                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile19_sub3       | 607         | BsaI        | 5wt_tile19_sub3                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile2             | 225         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile20_sub3       | 829         | BsaI        | 5wt_tile20_sub3                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile21_sub3       | 1045        | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile3             | 444         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile4             | 663         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile5             | 885         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile6             | 1104        | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile7             | 1326        | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile8             | 1539        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile9_sub1        | 1629        | BsaI        | 5wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile1_sub1       | 1332        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile1_sub2       | 1650        | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub1                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile1_sub3       | 1252        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub2;3wt_tile8_sub2;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2                                                                                                                                                                             |
| bsmbi_3wt_tile10_sub1      | 1119        | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile11_sub1      | 897         | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile12_sub1      | 678         | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile13_sub1      | 459         | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile14_sub1      | 240         | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile15_sub1      | 408         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile15_sub2      | 297         | BsmBI       | 3wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile15_sub3      | 204         | BsmBI       | 3wt_tile15_sub3;3wt_tile16_sub2;3wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile15_sub4      | 397         | BsmBI       | 3wt_tile15_sub4;3wt_tile16_sub3                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile16_sub1      | 525         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile17_sub1      | 306         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile17_sub3      | 291         | BsmBI       | 3wt_tile17_sub3                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile17_sub4      | 124         | BsmBI       | 3wt_tile17_sub4                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile18_sub1      | 591         | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile18_sub2      | 82          | BsmBI       | 3wt_tile18_sub2                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile19_sub1      | 369         | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile19_sub2      | 36          | BsmBI       | 3wt_tile19_sub2                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile19_sub3      | 64          | BsmBI       | 3wt_tile19_sub3                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile2_sub1       | 1113        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile20_sub1      | 186         | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile20_sub2      | 49          | BsmBI       | 3wt_tile20_sub2                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile3_sub1       | 894         | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile4_sub1       | 672         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile5_sub1       | 453         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile6_sub1       | 231         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile8_sub1       | 1560        | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile9_sub1       | 1338        | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_cassette_tile1_sub4  | 954         | BsmBI       | cassette_tile1_frag1;cassette_tile2_frag1;cassette_tile3_frag1;cassette_tile4_frag1;cassette_tile5_frag1;cassette_tile6_frag1;cassette_tile7_frag1;cassette_tile8_frag1;cassette_tile9_frag1;cassette_tile10_frag1;cassette_tile11_frag1;cassette_tile12_frag1;cassette_tile13_frag1;cassette_tile14_frag1;cassette_tile16_frag1;cassette_tile17_frag1;cassette_tile20_frag1                       |
| bsmbi_cassette_tile1_sub5  | 962         | BsmBI       | cassette_tile1_frag2;cassette_tile2_frag2;cassette_tile3_frag2;cassette_tile4_frag2;cassette_tile5_frag2;cassette_tile6_frag2;cassette_tile7_frag2;cassette_tile8_frag2;cassette_tile9_frag2;cassette_tile10_frag2;cassette_tile11_frag2;cassette_tile12_frag2;cassette_tile13_frag2;cassette_tile14_frag2;cassette_tile16_frag2;cassette_tile17_frag2;cassette_tile20_frag2;cassette_tile21_frag2 |
| bsmbi_cassette_tile15_sub5 | 953         | BsmBI       | cassette_tile15_frag1;cassette_tile18_frag1;cassette_tile19_frag1                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_cassette_tile15_sub6 | 963         | BsmBI       | cassette_tile15_frag2;cassette_tile18_frag2;cassette_tile19_frag2                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_cassette_tile21_sub1 | 954         | BsmBI       | cassette_tile21_frag1                                                                                                                                                                                                                                                                                                                                                                              |

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

