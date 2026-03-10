# DMS-GG Assembly Report: TRIO

Generated: 2026-03-10 10:49:58
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                         |
| -------------------- | ----------------------------------------------------------------------------- |
| Gene name            | TRIO_NM_007118.4_CDS Homo sapiens triple functional domain protein (TRIO) CDS |
| CDS length           | 9294 nt (3098 codons)                                                         |
| Protein length       | 3097 aa                                                                       |
| Number of tiles      | 56                                                                            |
| Total variants       | 60354                                                                         |
| Total oligos         | 603540                                                                        |
| Oligo length range   | 137-290 nt                                                                    |
| Gene blocks to order | 119                                                                           |
| Barcodes per variant | 10                                                                            |

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

**Total oligos:** 603540 | **Length range:** 137-290 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-76      | 15120  | 284 nt |
| 2    | 77-104    | 5040   | 140 nt |
| 3    | 105-174   | 13860  | 266 nt |
| 4    | 175-207   | 6090   | 155 nt |
| 5    | 208-282   | 14910  | 281 nt |
| 6    | 283-350   | 13440  | 260 nt |
| 7    | 351-395   | 8610   | 191 nt |
| 8    | 396-439   | 8400   | 188 nt |
| 9    | 440-505   | 13020  | 254 nt |
| 10   | 506-552   | 9030   | 197 nt |
| 11   | 553-589   | 6930   | 167 nt |
| 12   | 590-643   | 10500  | 218 nt |
| 13   | 644-709   | 13020  | 254 nt |
| 14   | 710-742   | 6090   | 155 nt |
| 15   | 743-811   | 13650  | 263 nt |
| 16   | 812-866   | 10710  | 221 nt |
| 17   | 867-930   | 12600  | 248 nt |
| 18   | 931-1000  | 13860  | 266 nt |
| 19   | 1001-1066 | 13020  | 254 nt |
| 20   | 1067-1093 | 4830   | 137 nt |
| 21   | 1094-1122 | 5250   | 143 nt |
| 22   | 1123-1180 | 11340  | 230 nt |
| 23   | 1181-1248 | 13440  | 260 nt |
| 24   | 1249-1301 | 10290  | 215 nt |
| 25   | 1302-1348 | 9030   | 197 nt |
| 26   | 1349-1402 | 10500  | 218 nt |
| 27   | 1403-1448 | 8820   | 194 nt |
| 28   | 1449-1515 | 13230  | 257 nt |
| 29   | 1516-1582 | 13230  | 257 nt |
| 30   | 1583-1642 | 11760  | 236 nt |
| 31   | 1643-1711 | 13650  | 263 nt |
| 32   | 1712-1746 | 6510   | 161 nt |
| 33   | 1747-1817 | 14070  | 269 nt |
| 34   | 1818-1846 | 5250   | 143 nt |
| 35   | 1847-1911 | 12810  | 251 nt |
| 36   | 1912-1965 | 10500  | 218 nt |
| 37   | 1966-2035 | 13860  | 266 nt |
| 38   | 2036-2073 | 7140   | 170 nt |
| 39   | 2074-2134 | 11970  | 239 nt |
| 40   | 2135-2187 | 10290  | 215 nt |
| 41   | 2188-2215 | 5040   | 140 nt |
| 42   | 2216-2253 | 7140   | 170 nt |
| 43   | 2254-2280 | 4830   | 137 nt |
| 44   | 2281-2351 | 14070  | 269 nt |
| 45   | 2352-2422 | 14070  | 269 nt |
| 46   | 2423-2498 | 15120  | 284 nt |
| 47   | 2499-2565 | 13230  | 257 nt |
| 48   | 2566-2626 | 11970  | 239 nt |
| 49   | 2627-2655 | 5250   | 143 nt |
| 50   | 2656-2685 | 5460   | 146 nt |
| 51   | 2686-2763 | 15540  | 290 nt |
| 52   | 2764-2806 | 8190   | 185 nt |
| 53   | 2807-2882 | 15120  | 284 nt |
| 54   | 2883-2952 | 13860  | 266 nt |
| 55   | 2953-3024 | 14280  | 272 nt |
| 56   | 3025-3098 | 14700  | 278 nt |

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
| Total barcodes    | 603540                             |
| Unique barcodes   | 603540                             |
| GC content range  | 25% - 75%                          |
| GC content mean   | 48%                                |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                     | Description                                                   | Result | Detail                                                                                                                                                |
| ------------------------- | ------------------------------------------------------------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths             | All oligos within synthesis length limit                      | PASS   | Range: 137-290 nt (limit: 300)                                                                                                                        |
| block_lengths             | All gene blocks within synthesis length limit                 | PASS   | Range: 102-1795 nt (limit: 1800)                                                                                                                      |
| barcode_junction_sites    | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                               |
| barcode_uniqueness        | All barcodes are unique                                       | PASS   | 603540 unique / 603540 total                                                                                                                          |
| tile_coverage             | Tiles cover entire gene without gaps                          | PASS   | 9294 / 9294 nt covered                                                                                                                                |
| variant_count             | Expected number of variants generated                         | PASS   | 60354 unique variants (expected: 60354 across 2874/3096 mutable positions; 54606 missense + 2874 nonsense + 2874 wt_control; 222 position(s) skipped) |
| single_codon_change       | Each non-control variant differs by exactly one codon from WT | PASS   | 574800 / 574800 variants confirmed (WT controls excluded)                                                                                             |
| oligo_gc_content          | Oligo GC content within reasonable range (25-75%)             | FAIL   | GC range: 38.1-76.2% | 1025 oligo(s) with extreme GC                                                                                                  |
| domestication_complete    | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                               |
| overhang_fidelity         | Tile boundary overhangs have adequate fidelity                | FAIL   | 51 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                               |
| tile_manifests            | Per-tile assembly manifests complete                          | PASS   | 56 tile manifest(s) generated                                                                                                                         |
| helper_plasmid            | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                    |
| reaction_fidelity         | Per-reaction set-level overhang fidelity                      | FAIL   | Min set fidelity: 0.7581 across 112 reactions | 12 reaction(s) below 0.90                                                                             |
| barcode_poliii_term       | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 603540 barcode(s) contain TTTT                                                                                                                    |
| block_min_length          | All gene blocks above synthesis minimum length                | FAIL   | 12 block(s) below 300 nt minimum. Range: 102-1795 nt                                                                                                  |
| cassette_fragment_lengths | Cassette fragments within synthesis limits                    | PASS   | 1 cassette fragment(s). Range: 398-398 nt. 0 over max, 0 under min.                                                                                   |
| sb_overhang_collisions    | Superblock boundary overhangs are unique (no collisions)      | PASS   | 6 SB boundary OH(s), all unique                                                                                                                       |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 8         | 0.9025             |
| 2    | 3        | 1.0000            | 8         | 0.8056             |
| 3    | 3        | 0.9656            | 8         | 0.9025             |
| 4    | 3        | 1.0000            | 8         | 0.8955             |
| 5    | 3        | 1.0000            | 8         | 0.8774             |
| 6    | 3        | 1.0000            | 8         | 0.9025             |
| 7    | 3        | 0.9574            | 8         | 0.9025             |
| 8    | 3        | 1.0000            | 8         | 0.8529             |
| 9    | 3        | 1.0000            | 8         | 0.8670             |
| 10   | 3        | 1.0000            | 8         | 0.9025             |
| 11   | 3        | 1.0000            | 7         | 0.9025             |
| 12   | 3        | 0.9928            | 7         | 0.9025             |
| 13   | 4        | 1.0000            | 7         | 0.8605             |
| 14   | 4        | 0.9953            | 7         | 0.9010             |
| 15   | 4        | 1.0000            | 7         | 0.9025             |
| 16   | 4        | 1.0000            | 7         | 0.9025             |
| 17   | 4        | 1.0000            | 7         | 0.9025             |
| 18   | 4        | 1.0000            | 7         | 0.7581             |
| 19   | 4        | 1.0000            | 7         | 0.9025             |
| 20   | 4        | 1.0000            | 7         | 0.9025             |
| 21   | 4        | 1.0000            | 7         | 0.9025             |
| 22   | 4        | 1.0000            | 6         | 0.9025             |
| 23   | 4        | 1.0000            | 6         | 0.9037             |
| 24   | 5        | 0.9925            | 6         | 0.8675             |
| 25   | 5        | 0.9925            | 6         | 0.9048             |
| 26   | 5        | 0.9925            | 6         | 0.9048             |
| 27   | 5        | 0.9925            | 6         | 0.9048             |
| 28   | 5        | 0.9900            | 6         | 0.9048             |
| 29   | 5        | 0.9925            | 6         | 0.9013             |
| 30   | 5        | 0.9705            | 6         | 0.9048             |
| 31   | 5        | 0.9925            | 5         | 1.0000             |
| 32   | 5        | 0.9925            | 5         | 0.9048             |
| 33   | 5        | 0.9925            | 5         | 1.0000             |
| 34   | 6        | 0.9925            | 5         | 0.9963             |
| 35   | 6        | 0.9925            | 5         | 1.0000             |
| 36   | 6        | 0.9925            | 5         | 1.0000             |
| 37   | 6        | 0.9925            | 5         | 1.0000             |
| 38   | 6        | 0.9925            | 5         | 0.9985             |
| 39   | 6        | 0.9925            | 5         | 0.9862             |
| 40   | 6        | 0.9224            | 5         | 0.9530             |
| 41   | 6        | 0.9925            | 4         | 1.0000             |
| 42   | 6        | 0.9925            | 4         | 1.0000             |
| 43   | 6        | 0.9925            | 4         | 0.9686             |
| 44   | 5        | 0.9925            | 4         | 0.9945             |
| 45   | 7        | 0.9467            | 4         | 1.0000             |
| 46   | 7        | 0.9925            | 4         | 0.9984             |
| 47   | 7        | 0.9925            | 4         | 1.0000             |
| 48   | 7        | 0.9925            | 4         | 0.9786             |
| 49   | 7        | 0.9502            | 4         | 1.0000             |
| 50   | 7        | 0.9900            | 4         | 0.8884             |
| 51   | 7        | 0.9925            | 4         | 1.0000             |
| 52   | 7        | 0.9925            | 3         | 1.0000             |
| 53   | 7        | 0.9925            | 2         | 1.0000             |
| 54   | 8        | 0.7603            | 2         | 1.0000             |
| 55   | 8        | 0.8757            | 2         | 1.0000             |
| 56   | 8        | 0.8823            | 2         | 1.0000             |

**Min:** 0.7581 | **Max:** 1.0000 | **Mean:** 0.9584

**Warning:** 12 reaction(s) below 0.90 fidelity — consider alternative split points or overhang reassignment.
## 6. Fixed Overhangs & Helper Plasmid

These overhangs are the same across all tile reactions:

| Overhang    | Sequence | Role                                                    |
| ----------- | -------- | ------------------------------------------------------- |
| oh_L        | ATGA     | Gene start (BsaI, all tiles)                            |
| oh3         | CACC     | Downstream cassette-barcode junction (BsmBI, all tiles) |
| oh4         | AGAA     | Barcode-helper junction (BsaI, all tiles)               |
| paqci_star2 | AATG     | PaqCI 5' end of insert (Level 2)                        |
| paqci_star1 | GCTA     | PaqCI 3' end of insert (Level 2)                        |

### Helper Plasmid Insert

The helper plasmid provides the backbone for each BsaI Level 1 reaction.

```
[PaqCI**]--[BsaI>>ATGA]--STUFFER--[AGAA<<BsaI]--[PaqCI*]
```

Insert length: 72 nt
oh_L = ATGA (first 4 nt of gene)
oh_R = AGAA (= oh4, barcode-helper junction)

## 7. Per-Tile Assembly Guide

### Tile 1 of 56 -- Codons 1-76 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGA     | 0.7549   |
| oh2 (3' boundary) | GAGA     | 0.7444   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (15120 oligos)              | 284 nt | ATGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert              | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart               | --     | --    | --    |

```
  [ATGA]----oligo+BC----[AGAA]
   ATGA                  AGAA 
```

**Set fidelity:** 1.0000 (2 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1      | 1557 nt | GAGA  | ACAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1791 nt | ACAT  | GGAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GGAG  | CGTG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAGA]----3'WT sub1----[ACAT]----3'WT sub2----[GGAG]----3'WT sub3----[CGTG]----3'WT sub4----[CAAG]----3'WT sub5----[CGTT]----3'WT sub6----[AATA]----3'WT+PolIII sub7----[CACC]
   GAGA                   ACAT                   GGAG                   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9025 (8 overhangs)

---

### Tile 2 of 56 -- Codons 77-104 (84 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAG     | 0.7814   |
| oh2 (3' boundary) | CATT     | 0.6770   |

**Variants:** 5040 mutations, 5040 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 246 nt | ATGA  | TCAG  |
| 2   | Oligo pool      | Tile 2 (5040 oligos)  | 140 nt | TCAG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[TCAG]----oligo+BC----[AGAA]
   ATGA                    TCAG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1      | 1473 nt | CATT  | ACAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1791 nt | ACAT  | GGAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GGAG  | CGTG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CATT]----3'WT sub1----[ACAT]----3'WT sub2----[GGAG]----3'WT sub3----[CGTG]----3'WT sub4----[CAAG]----3'WT sub5----[CGTT]----3'WT sub6----[AATA]----3'WT+PolIII sub7----[CACC]
   CATT                   ACAT                   GGAG                   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.8056 (8 overhangs)

---

### Tile 3 of 56 -- Codons 105-174 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGGA     | 0.7515   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 13860 mutations, 13860 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 330 nt | ATGA  | AGGA  |
| 2   | Oligo pool      | Tile 3 (13860 oligos) | 266 nt | AGGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[AGGA]----oligo+BC----[AGAA]
   ATGA                    AGGA                  AGAA 
```

**Set fidelity:** 0.9656 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1      | 1263 nt | TGAA  | ACAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1791 nt | ACAT  | GGAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GGAG  | CGTG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[ACAT]----3'WT sub2----[GGAG]----3'WT sub3----[CGTG]----3'WT sub4----[CAAG]----3'WT sub5----[CGTT]----3'WT sub6----[AATA]----3'WT+PolIII sub7----[CACC]
   TGAA                   ACAT                   GGAG                   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9025 (8 overhangs)

---

### Tile 4 of 56 -- Codons 175-207 (99 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTA     | 0.8892   |
| oh2 (3' boundary) | CGAA     | 0.7461   |

**Variants:** 6090 mutations, 6090 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 540 nt | ATGA  | TCTA  |
| 2   | Oligo pool      | Tile 4 (6090 oligos)  | 155 nt | TCTA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[TCTA]----oligo+BC----[AGAA]
   ATGA                    TCTA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1      | 1164 nt | CGAA  | ACAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1791 nt | ACAT  | GGAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GGAG  | CGTG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CGAA]----3'WT sub1----[ACAT]----3'WT sub2----[GGAG]----3'WT sub3----[CGTG]----3'WT sub4----[CAAG]----3'WT sub5----[CGTT]----3'WT sub6----[AATA]----3'WT+PolIII sub7----[CACC]
   CGAA                   ACAT                   GGAG                   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.8955 (8 overhangs)

---

### Tile 5 of 56 -- Codons 208-282 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACA     | 0.8652   |
| oh2 (3' boundary) | GATA     | 0.7029   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 639 nt | ATGA  | TACA  |
| 2   | Oligo pool      | Tile 5 (14910 oligos) | 281 nt | TACA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[TACA]----oligo+BC----[AGAA]
   ATGA                    TACA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1      | 939 nt  | GATA  | ACAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1791 nt | ACAT  | GGAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GGAG  | CGTG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GATA]----3'WT sub1----[ACAT]----3'WT sub2----[GGAG]----3'WT sub3----[CGTG]----3'WT sub4----[CAAG]----3'WT sub5----[CGTT]----3'WT sub6----[AATA]----3'WT+PolIII sub7----[CACC]
   GATA                   ACAT                   GGAG                   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.8774 (8 overhangs)

---

### Tile 6 of 56 -- Codons 283-350 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTTC     | 0.6384   |
| oh2 (3' boundary) | TGAC     | 0.6485   |

**Variants:** 13440 mutations, 13440 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 864 nt | ATGA  | CTTC  |
| 2   | Oligo pool      | Tile 6 (13440 oligos) | 260 nt | CTTC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[CTTC]----oligo+BC----[AGAA]
   ATGA                    CTTC                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1      | 735 nt  | TGAC  | ACAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1791 nt | ACAT  | GGAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GGAG  | CGTG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGAC]----3'WT sub1----[ACAT]----3'WT sub2----[GGAG]----3'WT sub3----[CGTG]----3'WT sub4----[CAAG]----3'WT sub5----[CGTT]----3'WT sub6----[AATA]----3'WT+PolIII sub7----[CACC]
   TGAC                   ACAT                   GGAG                   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9025 (8 overhangs)

---

### Tile 7 of 56 -- Codons 351-395 (135 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | AAAC     | 0.6694   |

**Variants:** 8610 mutations, 8610 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 1068 nt | ATGA  | AAGA  |
| 2   | Oligo pool      | Tile 7 (8610 oligos)  | 191 nt  | AAGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT block----[AAGA]----oligo+BC----[AGAA]
   ATGA                    AAGA                  AGAA 
```

**Set fidelity:** 0.9574 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1      | 600 nt  | AAAC  | ACAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1791 nt | ACAT  | GGAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GGAG  | CGTG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AAAC]----3'WT sub1----[ACAT]----3'WT sub2----[GGAG]----3'WT sub3----[CGTG]----3'WT sub4----[CAAG]----3'WT sub5----[CGTT]----3'WT sub6----[AATA]----3'WT+PolIII sub7----[CACC]
   AAAC                   ACAT                   GGAG                   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9025 (8 overhangs)

---

### Tile 8 of 56 -- Codons 396-439 (132 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTAA     | 0.8029   |
| oh2 (3' boundary) | CTTG     | 0.7594   |

**Variants:** 8400 mutations, 8400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1203 nt | ATGA  | GTAA  |
| 2   | Oligo pool      | Tile 8 (8400 oligos)  | 188 nt  | GTAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT block----[GTAA]----oligo+BC----[AGAA]
   ATGA                    GTAA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1      | 468 nt  | CTTG  | ACAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1791 nt | ACAT  | GGAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GGAG  | CGTG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTTG]----3'WT sub1----[ACAT]----3'WT sub2----[GGAG]----3'WT sub3----[CGTG]----3'WT sub4----[CAAG]----3'WT sub5----[CGTT]----3'WT sub6----[AATA]----3'WT+PolIII sub7----[CACC]
   CTTG                   ACAT                   GGAG                   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.8529 (8 overhangs)

---

### Tile 9 of 56 -- Codons 440-505 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CGGA     | 0.6609   |
| oh2 (3' boundary) | CCTT     | 0.6891   |

**Variants:** 13020 mutations, 13020 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1335 nt | ATGA  | CGGA  |
| 2   | Oligo pool      | Tile 9 (13020 oligos) | 254 nt  | CGGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT block----[CGGA]----oligo+BC----[AGAA]
   ATGA                    CGGA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1      | 270 nt  | CCTT  | ACAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1791 nt | ACAT  | GGAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GGAG  | CGTG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CCTT]----3'WT sub1----[ACAT]----3'WT sub2----[GGAG]----3'WT sub3----[CGTG]----3'WT sub4----[CAAG]----3'WT sub5----[CGTT]----3'WT sub6----[AATA]----3'WT+PolIII sub7----[CACC]
   CCTT                   ACAT                   GGAG                   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.8670 (8 overhangs)

---

### Tile 10 of 56 -- Codons 506-552 (141 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGT     | 0.7629   |
| oh2 (3' boundary) | GCAA     | 0.7543   |

**Variants:** 9030 mutations, 9030 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10       | 1533 nt | ATGA  | AAGT  |
| 2   | Oligo pool      | Tile 10 (9030 oligos) | 197 nt  | AAGT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT block----[AAGT]----oligo+BC----[AGAA]
   ATGA                    AAGT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1     | 129 nt  | GCAA  | ACAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1791 nt | ACAT  | GGAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GGAG  | CGTG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GCAA]----3'WT sub1----[ACAT]----3'WT sub2----[GGAG]----3'WT sub3----[CGTG]----3'WT sub4----[CAAG]----3'WT sub5----[CGTT]----3'WT sub6----[AATA]----3'WT+PolIII sub7----[CACC]
   GCAA                   ACAT                   GGAG                   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9025 (8 overhangs)

---

### Tile 11 of 56 -- Codons 553-589 (111 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AACA     | 0.8032   |
| oh2 (3' boundary) | ACAT     | 0.6621   |

**Variants:** 6930 mutations, 6930 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11       | 1674 nt | ATGA  | AACA  |
| 2   | Oligo pool      | Tile 11 (6930 oligos) | 167 nt  | AACA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT block----[AACA]----oligo+BC----[AGAA]
   ATGA                    AACA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1791 nt | ACAT  | GGAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GGAG  | CGTG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [ACAT]----3'WT sub1----[GGAG]----3'WT sub2----[CGTG]----3'WT sub3----[CAAG]----3'WT sub4----[CGTT]----3'WT sub5----[AATA]----3'WT+PolIII sub6----[CACC]
   ACAT                   GGAG                   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9025 (7 overhangs)

---

### Tile 12 of 56 -- Codons 590-643 (162 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTGA     | 0.6791   |
| oh2 (3' boundary) | TCAG     | 0.7814   |

**Variants:** 10500 mutations, 10500 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1785 nt | ATGA  | CTGA  |
| 2   | Oligo pool      | Tile 12 (10500 oligos) | 218 nt  | CTGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT block----[CTGA]----oligo+BC----[AGAA]
   ATGA                    CTGA                  AGAA 
```

**Set fidelity:** 0.9928 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1     | 1629 nt | TCAG  | GGAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GGAG  | CGTG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TCAG]----3'WT sub1----[GGAG]----3'WT sub2----[CGTG]----3'WT sub3----[CAAG]----3'WT sub4----[CGTT]----3'WT sub5----[AATA]----3'WT+PolIII sub6----[CACC]
   TCAG                   GGAG                   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9025 (7 overhangs)

---

### Tile 13 of 56 -- Codons 644-709 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAGA     | 0.7444   |
| oh2 (3' boundary) | CTTT     | 0.6635   |

**Variants:** 13020 mutations, 13020 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 184 nt  | ACAT  | GAGA  |
| 3   | Oligo pool      | Tile 13 (13020 oligos) | 254 nt  | GAGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GAGA]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GAGA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1     | 1431 nt | CTTT  | GGAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GGAG  | CGTG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTTT]----3'WT sub1----[GGAG]----3'WT sub2----[CGTG]----3'WT sub3----[CAAG]----3'WT sub4----[CGTT]----3'WT sub5----[AATA]----3'WT+PolIII sub6----[CACC]
   CTTT                   GGAG                   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.8605 (7 overhangs)

---

### Tile 14 of 56 -- Codons 710-742 (99 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCA     | 0.7483   |
| oh2 (3' boundary) | TAAC     | 0.7715   |

**Variants:** 6090 mutations, 6090 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2  | 382 nt  | ACAT  | ATCA  |
| 3   | Oligo pool      | Tile 14 (6090 oligos) | 155 nt  | ATCA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[ATCA]----oligo+BC----[AGAA]
   ATGA                   ACAT                   ATCA                  AGAA 
```

**Set fidelity:** 0.9953 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1     | 1332 nt | TAAC  | GGAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GGAG  | CGTG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TAAC]----3'WT sub1----[GGAG]----3'WT sub2----[CGTG]----3'WT sub3----[CAAG]----3'WT sub4----[CGTT]----3'WT sub5----[AATA]----3'WT+PolIII sub6----[CACC]
   TAAC                   GGAG                   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9010 (7 overhangs)

---

### Tile 15 of 56 -- Codons 743-811 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCT     | 0.7151   |
| oh2 (3' boundary) | TGAC     | 0.6485   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 481 nt  | ACAT  | ATCT  |
| 3   | Oligo pool      | Tile 15 (13650 oligos) | 263 nt  | ATCT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[ATCT]----oligo+BC----[AGAA]
   ATGA                   ACAT                   ATCT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1     | 1125 nt | TGAC  | GGAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GGAG  | CGTG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGAC]----3'WT sub1----[GGAG]----3'WT sub2----[CGTG]----3'WT sub3----[CAAG]----3'WT sub4----[CGTT]----3'WT sub5----[AATA]----3'WT+PolIII sub6----[CACC]
   TGAC                   GGAG                   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9025 (7 overhangs)

---

### Tile 16 of 56 -- Codons 812-866 (165 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAAA     | 0.8948   |
| oh2 (3' boundary) | TAGA     | 0.9115   |

**Variants:** 10710 mutations, 10710 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 688 nt  | ACAT  | CAAA  |
| 3   | Oligo pool      | Tile 16 (10710 oligos) | 221 nt  | CAAA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[CAAA]----oligo+BC----[AGAA]
   ATGA                   ACAT                   CAAA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1     | 960 nt  | TAGA  | GGAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GGAG  | CGTG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TAGA]----3'WT sub1----[GGAG]----3'WT sub2----[CGTG]----3'WT sub3----[CAAG]----3'WT sub4----[CGTT]----3'WT sub5----[AATA]----3'WT+PolIII sub6----[CACC]
   TAGA                   GGAG                   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9025 (7 overhangs)

---

### Tile 17 of 56 -- Codons 867-930 (192 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTGT     | 0.6476   |
| oh2 (3' boundary) | ACTT     | 0.7315   |

**Variants:** 12600 mutations, 12600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 853 nt  | ACAT  | CTGT  |
| 3   | Oligo pool      | Tile 17 (12600 oligos) | 248 nt  | CTGT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[CTGT]----oligo+BC----[AGAA]
   ATGA                   ACAT                   CTGT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1     | 768 nt  | ACTT  | GGAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GGAG  | CGTG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [ACTT]----3'WT sub1----[GGAG]----3'WT sub2----[CGTG]----3'WT sub3----[CAAG]----3'WT sub4----[CGTT]----3'WT sub5----[AATA]----3'WT+PolIII sub6----[CACC]
   ACTT                   GGAG                   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9025 (7 overhangs)

---

### Tile 18 of 56 -- Codons 931-1000 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATG     | 0.6412   |
| oh2 (3' boundary) | GGAA     | 0.7463   |

**Variants:** 13860 mutations, 13860 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1045 nt | ACAT  | AATG  |
| 3   | Oligo pool      | Tile 18 (13860 oligos) | 266 nt  | AATG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[AATG]----oligo+BC----[AGAA]
   ATGA                   ACAT                   AATG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1     | 558 nt  | GGAA  | GGAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GGAG  | CGTG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GGAA]----3'WT sub1----[GGAG]----3'WT sub2----[CGTG]----3'WT sub3----[CAAG]----3'WT sub4----[CGTT]----3'WT sub5----[AATA]----3'WT+PolIII sub6----[CACC]
   GGAA                   GGAG                   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.7581 (7 overhangs)

---

### Tile 19 of 56 -- Codons 1001-1066 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTCA     | 0.6872   |
| oh2 (3' boundary) | ATTC     | 0.7084   |

**Variants:** 13020 mutations, 13020 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1255 nt | ACAT  | CTCA  |
| 3   | Oligo pool      | Tile 19 (13020 oligos) | 254 nt  | CTCA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[CTCA]----oligo+BC----[AGAA]
   ATGA                   ACAT                   CTCA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1     | 360 nt  | ATTC  | GGAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GGAG  | CGTG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [ATTC]----3'WT sub1----[GGAG]----3'WT sub2----[CGTG]----3'WT sub3----[CAAG]----3'WT sub4----[CGTT]----3'WT sub5----[AATA]----3'WT+PolIII sub6----[CACC]
   ATTC                   GGAG                   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9025 (7 overhangs)

---

### Tile 20 of 56 -- Codons 1067-1093 (81 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGG     | 0.6552   |
| oh2 (3' boundary) | AGGA     | 0.7515   |

**Variants:** 4830 mutations, 4830 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2  | 1453 nt | ACAT  | AAGG  |
| 3   | Oligo pool      | Tile 20 (4830 oligos) | 137 nt  | AAGG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[AAGG]----oligo+BC----[AGAA]
   ATGA                   ACAT                   AAGG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1     | 279 nt  | AGGA  | GGAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GGAG  | CGTG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AGGA]----3'WT sub1----[GGAG]----3'WT sub2----[CGTG]----3'WT sub3----[CAAG]----3'WT sub4----[CGTT]----3'WT sub5----[AATA]----3'WT+PolIII sub6----[CACC]
   AGGA                   GGAG                   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9025 (7 overhangs)

---

### Tile 21 of 56 -- Codons 1094-1122 (87 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AACA     | 0.8032   |
| oh2 (3' boundary) | TTAC     | 0.8333   |

**Variants:** 5250 mutations, 5250 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1534 nt | ACAT  | AACA  |
| 3   | Oligo pool      | Tile 21 (5250 oligos) | 143 nt  | AACA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[AACA]----oligo+BC----[AGAA]
   ATGA                   ACAT                   AACA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1     | 192 nt  | TTAC  | GGAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GGAG  | CGTG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TTAC]----3'WT sub1----[GGAG]----3'WT sub2----[CGTG]----3'WT sub3----[CAAG]----3'WT sub4----[CGTT]----3'WT sub5----[AATA]----3'WT+PolIII sub6----[CACC]
   TTAC                   GGAG                   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9025 (7 overhangs)

---

### Tile 22 of 56 -- Codons 1123-1180 (174 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTAT     | 0.6602   |
| oh2 (3' boundary) | GGAG     | 0.5228   |

**Variants:** 11340 mutations, 11340 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1621 nt | ACAT  | GTAT  |
| 3   | Oligo pool      | Tile 22 (11340 oligos) | 230 nt  | GTAT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GTAT]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GTAT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GGAG  | CGTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GGAG]----3'WT sub1----[CGTG]----3'WT sub2----[CAAG]----3'WT sub3----[CGTT]----3'WT sub4----[AATA]----3'WT+PolIII sub5----[CACC]
   GGAG                   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9025 (6 overhangs)

---

### Tile 23 of 56 -- Codons 1181-1248 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAGC     | 0.5446   |
| oh2 (3' boundary) | TTCC     | 0.7958   |

**Variants:** 13440 mutations, 13440 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2   | 1795 nt | ACAT  | GAGC  |
| 3   | Oligo pool      | Tile 23 (13440 oligos) | 260 nt  | GAGC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GAGC]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GAGC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1     | 1512 nt | TTCC  | CGTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TTCC]----3'WT sub1----[CGTG]----3'WT sub2----[CAAG]----3'WT sub3----[CGTT]----3'WT sub4----[AATA]----3'WT+PolIII sub5----[CACC]
   TTCC                   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9037 (6 overhangs)

---

### Tile 24 of 56 -- Codons 1249-1301 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTT     | 0.7985   |
| oh2 (3' boundary) | AAAG     | 0.7511   |

**Variants:** 10290 mutations, 10290 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2   | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3   | 226 nt  | GGAG  | TCTT  |
| 4   | Oligo pool      | Tile 24 (10290 oligos) | 215 nt  | TCTT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[TCTT]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   TCTT                  AGAA 
```

**Set fidelity:** 0.9925 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile24_sub1     | 1353 nt | AAAG  | CGTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AAAG]----3'WT sub1----[CGTG]----3'WT sub2----[CAAG]----3'WT sub3----[CGTT]----3'WT sub4----[AATA]----3'WT+PolIII sub5----[CACC]
   AAAG                   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.8675 (6 overhangs)

---

### Tile 25 of 56 -- Codons 1302-1348 (141 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAAA     | 0.8948   |
| oh2 (3' boundary) | TAAT     | 0.8165   |

**Variants:** 9030 mutations, 9030 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2  | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3  | 385 nt  | GGAG  | CAAA  |
| 4   | Oligo pool      | Tile 25 (9030 oligos) | 197 nt  | CAAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[CAAA]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   CAAA                  AGAA 
```

**Set fidelity:** 0.9925 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile25_sub1     | 1212 nt | TAAT  | CGTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TAAT]----3'WT sub1----[CGTG]----3'WT sub2----[CAAG]----3'WT sub3----[CGTT]----3'WT sub4----[AATA]----3'WT+PolIII sub5----[CACC]
   TAAT                   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9048 (6 overhangs)

---

### Tile 26 of 56 -- Codons 1349-1402 (162 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAT     | 0.7246   |
| oh2 (3' boundary) | TGAC     | 0.6485   |

**Variants:** 10500 mutations, 10500 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2   | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3   | 526 nt  | GGAG  | GAAT  |
| 4   | Oligo pool      | Tile 26 (10500 oligos) | 218 nt  | GAAT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[GAAT]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   GAAT                  AGAA 
```

**Set fidelity:** 0.9925 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile26_sub1     | 1050 nt | TGAC  | CGTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGAC]----3'WT sub1----[CGTG]----3'WT sub2----[CAAG]----3'WT sub3----[CGTT]----3'WT sub4----[AATA]----3'WT+PolIII sub5----[CACC]
   TGAC                   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9048 (6 overhangs)

---

### Tile 27 of 56 -- Codons 1403-1448 (138 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCT     | 0.7573   |
| oh2 (3' boundary) | AGAT     | 0.6825   |

**Variants:** 8820 mutations, 8820 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2  | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3  | 688 nt  | GGAG  | TCCT  |
| 4   | Oligo pool      | Tile 27 (8820 oligos) | 194 nt  | TCCT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[TCCT]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   TCCT                  AGAA 
```

**Set fidelity:** 0.9925 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile27_sub1     | 912 nt  | AGAT  | CGTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AGAT]----3'WT sub1----[CGTG]----3'WT sub2----[CAAG]----3'WT sub3----[CGTT]----3'WT sub4----[AATA]----3'WT+PolIII sub5----[CACC]
   AGAT                   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9048 (6 overhangs)

---

### Tile 28 of 56 -- Codons 1449-1515 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAGA     | 0.7444   |
| oh2 (3' boundary) | TAGT     | 0.7437   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2   | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 826 nt  | GGAG  | GAGA  |
| 4   | Oligo pool      | Tile 28 (13230 oligos) | 257 nt  | GAGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[GAGA]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   GAGA                  AGAA 
```

**Set fidelity:** 0.9900 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile28_sub1     | 711 nt  | TAGT  | CGTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TAGT]----3'WT sub1----[CGTG]----3'WT sub2----[CAAG]----3'WT sub3----[CGTT]----3'WT sub4----[AATA]----3'WT+PolIII sub5----[CACC]
   TAGT                   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9048 (6 overhangs)

---

### Tile 29 of 56 -- Codons 1516-1582 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAG     | 0.8480   |
| oh2 (3' boundary) | TATC     | 0.8041   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2   | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile29_sub3   | 1027 nt | GGAG  | TTAG  |
| 4   | Oligo pool      | Tile 29 (13230 oligos) | 257 nt  | TTAG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[TTAG]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   TTAG                  AGAA 
```

**Set fidelity:** 0.9925 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile29_sub1     | 510 nt  | TATC  | CGTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TATC]----3'WT sub1----[CGTG]----3'WT sub2----[CAAG]----3'WT sub3----[CGTT]----3'WT sub4----[AATA]----3'WT+PolIII sub5----[CACC]
   TATC                   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9013 (6 overhangs)

---

### Tile 30 of 56 -- Codons 1583-1642 (180 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATAA     | 0.9170   |
| oh2 (3' boundary) | TCAG     | 0.7814   |

**Variants:** 11760 mutations, 11760 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2   | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3   | 1228 nt | GGAG  | ATAA  |
| 4   | Oligo pool      | Tile 30 (11760 oligos) | 236 nt  | ATAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[ATAA]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   ATAA                  AGAA 
```

**Set fidelity:** 0.9705 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile30_sub1     | 330 nt  | TCAG  | CGTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TCAG]----3'WT sub1----[CGTG]----3'WT sub2----[CAAG]----3'WT sub3----[CGTT]----3'WT sub4----[AATA]----3'WT+PolIII sub5----[CACC]
   TCAG                   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9048 (6 overhangs)

---

### Tile 31 of 56 -- Codons 1643-1711 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CGGA     | 0.6609   |
| oh2 (3' boundary) | TTCA     | 0.8824   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2   | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile31_sub3   | 1408 nt | GGAG  | CGGA  |
| 4   | Oligo pool      | Tile 31 (13650 oligos) | 263 nt  | CGGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[CGGA]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   CGGA                  AGAA 
```

**Set fidelity:** 0.9925 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile31_sub1     | 1530 nt | TTCA  | CAAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TTCA]----3'WT sub1----[CAAG]----3'WT sub2----[CGTT]----3'WT sub3----[AATA]----3'WT+PolIII sub4----[CACC]
   TTCA                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 32 of 56 -- Codons 1712-1746 (105 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCCT     | 0.6204   |
| oh2 (3' boundary) | CGTG     | 0.5892   |

**Variants:** 6510 mutations, 6510 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2  | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile32_sub3  | 1615 nt | GGAG  | CCCT  |
| 4   | Oligo pool      | Tile 32 (6510 oligos) | 161 nt  | CCCT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[CCCT]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   CCCT                  AGAA 
```

**Set fidelity:** 0.9925 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | CGTG  | CAAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CGTG]----3'WT sub1----[CAAG]----3'WT sub2----[CGTT]----3'WT sub3----[AATA]----3'WT+PolIII sub4----[CACC]
   CGTG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9048 (5 overhangs)

---

### Tile 33 of 56 -- Codons 1747-1817 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCCG     | 0.5823   |
| oh2 (3' boundary) | CAGT     | 0.6512   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2   | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile33_sub3   | 1720 nt | GGAG  | CCCG  |
| 4   | Oligo pool      | Tile 33 (14070 oligos) | 269 nt  | CCCG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[CCCG]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   CCCG                  AGAA 
```

**Set fidelity:** 0.9925 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile33_sub1     | 1212 nt | CAGT  | CAAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CAGT]----3'WT sub1----[CAAG]----3'WT sub2----[CGTT]----3'WT sub3----[AATA]----3'WT+PolIII sub4----[CACC]
   CAGT                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 34 of 56 -- Codons 1818-1846 (87 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCG     | 0.7234   |
| oh2 (3' boundary) | CTCG     | 0.7252   |

**Variants:** 5250 mutations, 5250 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2  | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3  | 1716 nt | GGAG  | CGTG  |
| 4   | 5'WT gene block | bsai_5wt_tile34_sub4  | 235 nt  | CGTG  | TCCG  |
| 5   | Oligo pool      | Tile 34 (5250 oligos) | 143 nt  | TCCG  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[CGTG]----5'WT sub4----[TCCG]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   CGTG                   TCCG                  AGAA 
```

**Set fidelity:** 0.9925 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile34_sub1     | 1125 nt | CTCG  | CAAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTCG]----3'WT sub1----[CAAG]----3'WT sub2----[CGTT]----3'WT sub3----[AATA]----3'WT+PolIII sub4----[CACC]
   CTCG                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9963 (5 overhangs)

---

### Tile 35 of 56 -- Codons 1847-1911 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCT     | 0.7573   |
| oh2 (3' boundary) | GGAA     | 0.7463   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2   | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1716 nt | GGAG  | CGTG  |
| 4   | 5'WT gene block | bsai_5wt_tile35_sub4   | 322 nt  | CGTG  | TCCT  |
| 5   | Oligo pool      | Tile 35 (12810 oligos) | 251 nt  | TCCT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[CGTG]----5'WT sub4----[TCCT]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   CGTG                   TCCT                  AGAA 
```

**Set fidelity:** 0.9925 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile35_sub1     | 930 nt  | GGAA  | CAAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GGAA]----3'WT sub1----[CAAG]----3'WT sub2----[CGTT]----3'WT sub3----[AATA]----3'WT+PolIII sub4----[CACC]
   GGAA                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 36 of 56 -- Codons 1912-1965 (162 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCAA     | 0.7543   |
| oh2 (3' boundary) | GAGA     | 0.7444   |

**Variants:** 10500 mutations, 10500 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2   | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1716 nt | GGAG  | CGTG  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4   | 517 nt  | CGTG  | GCAA  |
| 5   | Oligo pool      | Tile 36 (10500 oligos) | 218 nt  | GCAA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[CGTG]----5'WT sub4----[GCAA]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   CGTG                   GCAA                  AGAA 
```

**Set fidelity:** 0.9925 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile36_sub1     | 768 nt  | GAGA  | CAAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAGA]----3'WT sub1----[CAAG]----3'WT sub2----[CGTT]----3'WT sub3----[AATA]----3'WT+PolIII sub4----[CACC]
   GAGA                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 37 of 56 -- Codons 1966-2035 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTT     | 0.7985   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 13860 mutations, 13860 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2   | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1716 nt | GGAG  | CGTG  |
| 4   | 5'WT gene block | bsai_5wt_tile37_sub4   | 679 nt  | CGTG  | TCTT  |
| 5   | Oligo pool      | Tile 37 (13860 oligos) | 266 nt  | TCTT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[CGTG]----5'WT sub4----[TCTT]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   CGTG                   TCTT                  AGAA 
```

**Set fidelity:** 0.9925 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile37_sub1     | 558 nt  | TGAA  | CAAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[CAAG]----3'WT sub2----[CGTT]----3'WT sub3----[AATA]----3'WT+PolIII sub4----[CACC]
   TGAA                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 38 of 56 -- Codons 2036-2073 (114 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGT     | 0.7629   |
| oh2 (3' boundary) | TGAT     | 0.6933   |

**Variants:** 7140 mutations, 7140 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2  | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3  | 1716 nt | GGAG  | CGTG  |
| 4   | 5'WT gene block | bsai_5wt_tile38_sub4  | 889 nt  | CGTG  | AAGT  |
| 5   | Oligo pool      | Tile 38 (7140 oligos) | 170 nt  | AAGT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[CGTG]----5'WT sub4----[AAGT]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   CGTG                   AAGT                  AGAA 
```

**Set fidelity:** 0.9925 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile38_sub1     | 444 nt  | TGAT  | CAAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGAT]----3'WT sub1----[CAAG]----3'WT sub2----[CGTT]----3'WT sub3----[AATA]----3'WT+PolIII sub4----[CACC]
   TGAT                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9985 (5 overhangs)

---

### Tile 39 of 56 -- Codons 2074-2134 (183 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAT     | 0.7246   |
| oh2 (3' boundary) | AGTA     | 0.7286   |

**Variants:** 11970 mutations, 11970 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2   | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1716 nt | GGAG  | CGTG  |
| 4   | 5'WT gene block | bsai_5wt_tile39_sub4   | 1003 nt | CGTG  | GAAT  |
| 5   | Oligo pool      | Tile 39 (11970 oligos) | 239 nt  | GAAT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[CGTG]----5'WT sub4----[GAAT]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   CGTG                   GAAT                  AGAA 
```

**Set fidelity:** 0.9925 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile39_sub1     | 261 nt  | AGTA  | CAAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AGTA]----3'WT sub1----[CAAG]----3'WT sub2----[CGTT]----3'WT sub3----[AATA]----3'WT+PolIII sub4----[CACC]
   AGTA                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9862 (5 overhangs)

---

### Tile 40 of 56 -- Codons 2135-2187 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGT     | 0.6822   |
| oh2 (3' boundary) | CTTT     | 0.6635   |

**Variants:** 10290 mutations, 10290 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2   | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1716 nt | GGAG  | CGTG  |
| 4   | 5'WT gene block | bsai_5wt_tile40_sub4   | 1186 nt | CGTG  | ATGT  |
| 5   | Oligo pool      | Tile 40 (10290 oligos) | 215 nt  | ATGT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[CGTG]----5'WT sub4----[ATGT]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   CGTG                   ATGT                  AGAA 
```

**Set fidelity:** 0.9224 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile40_sub1     | 102 nt  | CTTT  | CAAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTTT]----3'WT sub1----[CAAG]----3'WT sub2----[CGTT]----3'WT sub3----[AATA]----3'WT+PolIII sub4----[CACC]
   CTTT                   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9530 (5 overhangs)

---

### Tile 41 of 56 -- Codons 2188-2215 (84 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCT     | 0.7151   |
| oh2 (3' boundary) | CAAG     | 0.6640   |

**Variants:** 5040 mutations, 5040 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2  | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3  | 1716 nt | GGAG  | CGTG  |
| 4   | 5'WT gene block | bsai_5wt_tile41_sub4  | 1345 nt | CGTG  | ATCT  |
| 5   | Oligo pool      | Tile 41 (5040 oligos) | 140 nt  | ATCT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[CGTG]----5'WT sub4----[ATCT]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   CGTG                   ATCT                  AGAA 
```

**Set fidelity:** 0.9925 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | CAAG  | CGTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CAAG]----3'WT sub1----[CGTT]----3'WT sub2----[AATA]----3'WT+PolIII sub3----[CACC]
   CAAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 42 of 56 -- Codons 2216-2253 (114 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AACA     | 0.8032   |
| oh2 (3' boundary) | AAGT     | 0.7629   |

**Variants:** 7140 mutations, 7140 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2  | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3  | 1716 nt | GGAG  | CGTG  |
| 4   | 5'WT gene block | bsai_5wt_tile42_sub4  | 1429 nt | CGTG  | AACA  |
| 5   | Oligo pool      | Tile 42 (7140 oligos) | 170 nt  | AACA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[CGTG]----5'WT sub4----[AACA]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   CGTG                   AACA                  AGAA 
```

**Set fidelity:** 0.9925 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile42_sub1     | 1677 nt | AAGT  | CGTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AAGT]----3'WT sub1----[CGTT]----3'WT sub2----[AATA]----3'WT+PolIII sub3----[CACC]
   AAGT                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 43 of 56 -- Codons 2254-2280 (81 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTA     | 0.8892   |
| oh2 (3' boundary) | AATC     | 0.7116   |

**Variants:** 4830 mutations, 4830 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2  | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3  | 1716 nt | GGAG  | CGTG  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4  | 1543 nt | CGTG  | TCTA  |
| 5   | Oligo pool      | Tile 43 (4830 oligos) | 137 nt  | TCTA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[CGTG]----5'WT sub4----[TCTA]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   CGTG                   TCTA                  AGAA 
```

**Set fidelity:** 0.9925 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile43_sub1     | 1596 nt | AATC  | CGTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AATC]----3'WT sub1----[CGTT]----3'WT sub2----[AATA]----3'WT+PolIII sub3----[CACC]
   AATC                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9686 (4 overhangs)

---

### Tile 44 of 56 -- Codons 2281-2351 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACAT     | 0.6621   |
| oh2 (3' boundary) | CTCT     | 0.6347   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2   | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1716 nt | GGAG  | CGTG  |
| 4   | 5'WT gene block | bsai_5wt_tile44_sub4   | 1624 nt | CGTG  | ACAT  |
| 5   | Oligo pool      | Tile 44 (14070 oligos) | 269 nt  | ACAT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[CGTG]----5'WT sub4----[ACAT]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   CGTG                   ACAT                  AGAA 
```

**Set fidelity:** 0.9925 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile44_sub1     | 1383 nt | CTCT  | CGTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTCT]----3'WT sub1----[CGTT]----3'WT sub2----[AATA]----3'WT+PolIII sub3----[CACC]
   CTCT                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9945 (4 overhangs)

---

### Tile 45 of 56 -- Codons 2352-2422 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTTG     | 0.7594   |
| oh2 (3' boundary) | CTCG     | 0.7252   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2   | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1716 nt | GGAG  | CGTG  |
| 4   | 5'WT gene block | bsai_5wt_tile45_sub4   | 1425 nt | CGTG  | CAAG  |
| 5   | 5'WT gene block | bsai_5wt_tile45_sub5   | 430 nt  | CAAG  | CTTG  |
| 6   | Oligo pool      | Tile 45 (14070 oligos) | 269 nt  | CTTG  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[CGTG]----5'WT sub4----[CAAG]----5'WT sub5----[CTTG]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   CGTG                   CAAG                   CTTG                  AGAA 
```

**Set fidelity:** 0.9467 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile45_sub1     | 1170 nt | CTCG  | CGTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTCG]----3'WT sub1----[CGTT]----3'WT sub2----[AATA]----3'WT+PolIII sub3----[CACC]
   CTCG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 46 of 56 -- Codons 2423-2498 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCGA     | 0.5836   |
| oh2 (3' boundary) | CTTC     | 0.6384   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2   | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1716 nt | GGAG  | CGTG  |
| 4   | 5'WT gene block | bsai_5wt_tile45_sub4   | 1425 nt | CGTG  | CAAG  |
| 5   | 5'WT gene block | bsai_5wt_tile46_sub5   | 643 nt  | CAAG  | GCGA  |
| 6   | Oligo pool      | Tile 46 (15120 oligos) | 284 nt  | GCGA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[CGTG]----5'WT sub4----[CAAG]----5'WT sub5----[GCGA]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   CGTG                   CAAG                   GCGA                  AGAA 
```

**Set fidelity:** 0.9925 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile46_sub1     | 942 nt  | CTTC  | CGTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTTC]----3'WT sub1----[CGTT]----3'WT sub2----[AATA]----3'WT+PolIII sub3----[CACC]
   CTTC                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9984 (4 overhangs)

---

### Tile 47 of 56 -- Codons 2499-2565 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCT     | 0.7573   |
| oh2 (3' boundary) | TGAG     | 0.6546   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2   | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1716 nt | GGAG  | CGTG  |
| 4   | 5'WT gene block | bsai_5wt_tile45_sub4   | 1425 nt | CGTG  | CAAG  |
| 5   | 5'WT gene block | bsai_5wt_tile47_sub5   | 871 nt  | CAAG  | TCCT  |
| 6   | Oligo pool      | Tile 47 (13230 oligos) | 257 nt  | TCCT  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[CGTG]----5'WT sub4----[CAAG]----5'WT sub5----[TCCT]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   CGTG                   CAAG                   TCCT                  AGAA 
```

**Set fidelity:** 0.9925 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile47_sub1     | 741 nt  | TGAG  | CGTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGAG]----3'WT sub1----[CGTT]----3'WT sub2----[AATA]----3'WT+PolIII sub3----[CACC]
   TGAG                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 48 of 56 -- Codons 2566-2626 (183 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGG     | 0.6552   |
| oh2 (3' boundary) | AACA     | 0.8032   |

**Variants:** 11970 mutations, 11970 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2   | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1716 nt | GGAG  | CGTG  |
| 4   | 5'WT gene block | bsai_5wt_tile45_sub4   | 1425 nt | CGTG  | CAAG  |
| 5   | 5'WT gene block | bsai_5wt_tile48_sub5   | 1072 nt | CAAG  | AAGG  |
| 6   | Oligo pool      | Tile 48 (11970 oligos) | 239 nt  | AAGG  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[CGTG]----5'WT sub4----[CAAG]----5'WT sub5----[AAGG]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   CGTG                   CAAG                   AAGG                  AGAA 
```

**Set fidelity:** 0.9925 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile48_sub1     | 558 nt  | AACA  | CGTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AACA]----3'WT sub1----[CGTT]----3'WT sub2----[AATA]----3'WT+PolIII sub3----[CACC]
   AACA                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.9786 (4 overhangs)

---

### Tile 49 of 56 -- Codons 2627-2655 (87 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | TTAT     | 0.8673   |

**Variants:** 5250 mutations, 5250 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2  | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3  | 1716 nt | GGAG  | CGTG  |
| 4   | 5'WT gene block | bsai_5wt_tile45_sub4  | 1425 nt | CGTG  | CAAG  |
| 5   | 5'WT gene block | bsai_5wt_tile49_sub5  | 1255 nt | CAAG  | AAGA  |
| 6   | Oligo pool      | Tile 49 (5250 oligos) | 143 nt  | AAGA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[CGTG]----5'WT sub4----[CAAG]----5'WT sub5----[AAGA]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   CGTG                   CAAG                   AAGA                  AGAA 
```

**Set fidelity:** 0.9502 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile49_sub1     | 471 nt  | TTAT  | CGTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TTAT]----3'WT sub1----[CGTT]----3'WT sub2----[AATA]----3'WT+PolIII sub3----[CACC]
   TTAT                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 50 of 56 -- Codons 2656-2685 (90 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAGA     | 0.7444   |
| oh2 (3' boundary) | CATT     | 0.6770   |

**Variants:** 5460 mutations, 5460 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2  | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3  | 1716 nt | GGAG  | CGTG  |
| 4   | 5'WT gene block | bsai_5wt_tile45_sub4  | 1425 nt | CGTG  | CAAG  |
| 5   | 5'WT gene block | bsai_5wt_tile50_sub5  | 1342 nt | CAAG  | GAGA  |
| 6   | Oligo pool      | Tile 50 (5460 oligos) | 146 nt  | GAGA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[CGTG]----5'WT sub4----[CAAG]----5'WT sub5----[GAGA]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   CGTG                   CAAG                   GAGA                  AGAA 
```

**Set fidelity:** 0.9900 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile50_sub1     | 381 nt  | CATT  | CGTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CATT]----3'WT sub1----[CGTT]----3'WT sub2----[AATA]----3'WT+PolIII sub3----[CACC]
   CATT                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 0.8884 (4 overhangs)

---

### Tile 51 of 56 -- Codons 2686-2763 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAT     | 0.7246   |
| oh2 (3' boundary) | TTCA     | 0.8824   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2   | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1716 nt | GGAG  | CGTG  |
| 4   | 5'WT gene block | bsai_5wt_tile45_sub4   | 1425 nt | CGTG  | CAAG  |
| 5   | 5'WT gene block | bsai_5wt_tile51_sub5   | 1432 nt | CAAG  | GAAT  |
| 6   | Oligo pool      | Tile 51 (15540 oligos) | 290 nt  | GAAT  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[CGTG]----5'WT sub4----[CAAG]----5'WT sub5----[GAAT]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   CGTG                   CAAG                   GAAT                  AGAA 
```

**Set fidelity:** 0.9925 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile51_sub1     | 147 nt  | TTCA  | CGTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CGTT  | AATA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TTCA]----3'WT sub1----[CGTT]----3'WT sub2----[AATA]----3'WT+PolIII sub3----[CACC]
   TTCA                   CGTT                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 52 of 56 -- Codons 2764-2806 (129 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GACA     | 0.6127   |
| oh2 (3' boundary) | CGTT     | 0.5788   |

**Variants:** 8190 mutations, 8190 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2  | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3  | 1716 nt | GGAG  | CGTG  |
| 4   | 5'WT gene block | bsai_5wt_tile45_sub4  | 1425 nt | CGTG  | CAAG  |
| 5   | 5'WT gene block | bsai_5wt_tile52_sub5  | 1666 nt | CAAG  | GACA  |
| 6   | Oligo pool      | Tile 52 (8190 oligos) | 185 nt  | GACA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[CGTG]----5'WT sub4----[CAAG]----5'WT sub5----[GACA]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   CGTG                   CAAG                   GACA                  AGAA 
```

**Set fidelity:** 0.9925 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile52_sub1    | 381 nt  | CGTT  | TTTA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile52_sub2    | 1625 nt | TTTA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CGTT]----3'WT sub1----[TTTA]----3'WT+PolIII sub2----[CACC]
   CGTT                   TTTA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 53 of 56 -- Codons 2807-2882 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCT     | 0.8181   |
| oh2 (3' boundary) | AAGC     | 0.5900   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2   | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1716 nt | GGAG  | CGTG  |
| 4   | 5'WT gene block | bsai_5wt_tile45_sub4   | 1425 nt | CGTG  | CAAG  |
| 5   | 5'WT gene block | bsai_5wt_tile53_sub5   | 1795 nt | CAAG  | TTCT  |
| 6   | Oligo pool      | Tile 53 (15120 oligos) | 284 nt  | TTCT  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[CGTG]----5'WT sub4----[CAAG]----5'WT sub5----[TTCT]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   CGTG                   CAAG                   TTCT                  AGAA 
```

**Set fidelity:** 0.9925 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile53         | 1760 nt | AAGC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAGC]----3'WT+PolIII----[CACC]
   AAGC                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 54 of 56 -- Codons 2883-2952 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CGAT     | 0.6118   |
| oh2 (3' boundary) | CCCT     | 0.6204   |

**Variants:** 13860 mutations, 13860 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2   | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1716 nt | GGAG  | CGTG  |
| 4   | 5'WT gene block | bsai_5wt_tile45_sub4   | 1425 nt | CGTG  | CAAG  |
| 5   | 5'WT gene block | bsai_5wt_tile54_sub5   | 1791 nt | CAAG  | CGTT  |
| 6   | 5'WT gene block | bsai_5wt_tile54_sub6   | 250 nt  | CGTT  | CGAT  |
| 7   | Oligo pool      | Tile 54 (13860 oligos) | 266 nt  | CGAT  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[CGTG]----5'WT sub4----[CAAG]----5'WT sub5----[CGTT]----5'WT sub6----[CGAT]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   CGTG                   CAAG                   CGTT                   CGAT                  AGAA 
```

**Set fidelity:** 0.7603 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile54         | 1550 nt | CCCT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCCT]----3'WT+PolIII----[CACC]
   CCCT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 55 of 56 -- Codons 2953-3024 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTGG     | 0.5756   |
| oh2 (3' boundary) | GTGC     | 0.4969   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2   | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1716 nt | GGAG  | CGTG  |
| 4   | 5'WT gene block | bsai_5wt_tile45_sub4   | 1425 nt | CGTG  | CAAG  |
| 5   | 5'WT gene block | bsai_5wt_tile54_sub5   | 1791 nt | CAAG  | CGTT  |
| 6   | 5'WT gene block | bsai_5wt_tile55_sub6   | 460 nt  | CGTT  | CTGG  |
| 7   | Oligo pool      | Tile 55 (14280 oligos) | 272 nt  | CTGG  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[CGTG]----5'WT sub4----[CAAG]----5'WT sub5----[CGTT]----5'WT sub6----[CTGG]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   CGTG                   CAAG                   CGTT                   CTGG                  AGAA 
```

**Set fidelity:** 0.8757 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile55         | 1334 nt | GTGC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GTGC]----3'WT+PolIII----[CACC]
   GTGC                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 56 of 56 -- Codons 3025-3098 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAGT     | 0.6209   |
| oh2 (3' boundary) | TTGA     | 0.8853   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ACAT  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2   | 1791 nt | ACAT  | GGAG  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3   | 1716 nt | GGAG  | CGTG  |
| 4   | 5'WT gene block | bsai_5wt_tile45_sub4   | 1425 nt | CGTG  | CAAG  |
| 5   | 5'WT gene block | bsai_5wt_tile54_sub5   | 1791 nt | CAAG  | CGTT  |
| 6   | 5'WT gene block | bsai_5wt_tile56_sub6   | 676 nt  | CGTT  | GAGT  |
| 7   | Oligo pool      | Tile 56 (14700 oligos) | 278 nt  | GAGT  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ACAT]----5'WT sub2----[GGAG]----5'WT sub3----[CGTG]----5'WT sub4----[CAAG]----5'WT sub5----[CGTT]----5'WT sub6----[GAGT]----oligo+BC----[AGAA]
   ATGA                   ACAT                   GGAG                   CGTG                   CAAG                   CGTT                   GAGT                  AGAA 
```

**Set fidelity:** 0.8823 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component            | Part name                | Length  | 5' OH | 3' OH |
| --- | -------------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product         | (in helper plasmid)      | --      | --    | --    |
| 2   | PolIII-only fragment | bsmbi_polIII_tile56      | 1112 nt | TTGA  | CACC  |
| 3   | Enzyme + buffer      | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTGA]----PolIII----[CACC]
   TTGA                CACC 
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

**Total blocks:** 119

| Block name                | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| ------------------------- | ----------- | ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10           | 1533        | BsaI        | 5wt_tile10                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile11           | 1674        | BsaI        | 5wt_tile11                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile12_sub1      | 1785        | BsaI        | 5wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile13_sub1      | 1781        | BsaI        | 5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1;5wt_tile26_sub1;5wt_tile27_sub1;5wt_tile28_sub1;5wt_tile29_sub1;5wt_tile30_sub1;5wt_tile31_sub1;5wt_tile32_sub1;5wt_tile33_sub1;5wt_tile34_sub1;5wt_tile35_sub1;5wt_tile36_sub1;5wt_tile37_sub1;5wt_tile38_sub1;5wt_tile39_sub1;5wt_tile40_sub1;5wt_tile41_sub1;5wt_tile42_sub1;5wt_tile43_sub1;5wt_tile44_sub1;5wt_tile45_sub1;5wt_tile46_sub1;5wt_tile47_sub1;5wt_tile48_sub1;5wt_tile49_sub1;5wt_tile50_sub1;5wt_tile51_sub1;5wt_tile52_sub1;5wt_tile53_sub1;5wt_tile54_sub1;5wt_tile55_sub1;5wt_tile56_sub1                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile13_sub2      | 184         | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile14_sub2      | 382         | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile15_sub2      | 481         | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile16_sub2      | 688         | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile17_sub2      | 853         | BsaI        | 5wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile18_sub2      | 1045        | BsaI        | 5wt_tile18_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile19_sub2      | 1255        | BsaI        | 5wt_tile19_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile2            | 246         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile20_sub2      | 1453        | BsaI        | 5wt_tile20_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile21_sub2      | 1534        | BsaI        | 5wt_tile21_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile22_sub2      | 1621        | BsaI        | 5wt_tile22_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile23_sub2      | 1795        | BsaI        | 5wt_tile23_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile24_sub2      | 1791        | BsaI        | 5wt_tile24_sub2;5wt_tile25_sub2;5wt_tile26_sub2;5wt_tile27_sub2;5wt_tile28_sub2;5wt_tile29_sub2;5wt_tile30_sub2;5wt_tile31_sub2;5wt_tile32_sub2;5wt_tile33_sub2;5wt_tile34_sub2;5wt_tile35_sub2;5wt_tile36_sub2;5wt_tile37_sub2;5wt_tile38_sub2;5wt_tile39_sub2;5wt_tile40_sub2;5wt_tile41_sub2;5wt_tile42_sub2;5wt_tile43_sub2;5wt_tile44_sub2;5wt_tile45_sub2;5wt_tile46_sub2;5wt_tile47_sub2;5wt_tile48_sub2;5wt_tile49_sub2;5wt_tile50_sub2;5wt_tile51_sub2;5wt_tile52_sub2;5wt_tile53_sub2;5wt_tile54_sub2;5wt_tile55_sub2;5wt_tile56_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile24_sub3      | 226         | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile25_sub3      | 385         | BsaI        | 5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile26_sub3      | 526         | BsaI        | 5wt_tile26_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile27_sub3      | 688         | BsaI        | 5wt_tile27_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile28_sub3      | 826         | BsaI        | 5wt_tile28_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile29_sub3      | 1027        | BsaI        | 5wt_tile29_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile3            | 330         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile30_sub3      | 1228        | BsaI        | 5wt_tile30_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile31_sub3      | 1408        | BsaI        | 5wt_tile31_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile32_sub3      | 1615        | BsaI        | 5wt_tile32_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile33_sub3      | 1720        | BsaI        | 5wt_tile33_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile34_sub3      | 1716        | BsaI        | 5wt_tile34_sub3;5wt_tile35_sub3;5wt_tile36_sub3;5wt_tile37_sub3;5wt_tile38_sub3;5wt_tile39_sub3;5wt_tile40_sub3;5wt_tile41_sub3;5wt_tile42_sub3;5wt_tile43_sub3;5wt_tile44_sub3;5wt_tile45_sub3;5wt_tile46_sub3;5wt_tile47_sub3;5wt_tile48_sub3;5wt_tile49_sub3;5wt_tile50_sub3;5wt_tile51_sub3;5wt_tile52_sub3;5wt_tile53_sub3;5wt_tile54_sub3;5wt_tile55_sub3;5wt_tile56_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile34_sub4      | 235         | BsaI        | 5wt_tile34_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile35_sub4      | 322         | BsaI        | 5wt_tile35_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile36_sub4      | 517         | BsaI        | 5wt_tile36_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile37_sub4      | 679         | BsaI        | 5wt_tile37_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile38_sub4      | 889         | BsaI        | 5wt_tile38_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile39_sub4      | 1003        | BsaI        | 5wt_tile39_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile4            | 540         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile40_sub4      | 1186        | BsaI        | 5wt_tile40_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile41_sub4      | 1345        | BsaI        | 5wt_tile41_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile42_sub4      | 1429        | BsaI        | 5wt_tile42_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile43_sub4      | 1543        | BsaI        | 5wt_tile43_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile44_sub4      | 1624        | BsaI        | 5wt_tile44_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile45_sub4      | 1425        | BsaI        | 5wt_tile45_sub4;5wt_tile46_sub4;5wt_tile47_sub4;5wt_tile48_sub4;5wt_tile49_sub4;5wt_tile50_sub4;5wt_tile51_sub4;5wt_tile52_sub4;5wt_tile53_sub4;5wt_tile54_sub4;5wt_tile55_sub4;5wt_tile56_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile45_sub5      | 430         | BsaI        | 5wt_tile45_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile46_sub5      | 643         | BsaI        | 5wt_tile46_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile47_sub5      | 871         | BsaI        | 5wt_tile47_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile48_sub5      | 1072        | BsaI        | 5wt_tile48_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile49_sub5      | 1255        | BsaI        | 5wt_tile49_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile5            | 639         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile50_sub5      | 1342        | BsaI        | 5wt_tile50_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile51_sub5      | 1432        | BsaI        | 5wt_tile51_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile52_sub5      | 1666        | BsaI        | 5wt_tile52_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile53_sub5      | 1795        | BsaI        | 5wt_tile53_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile54_sub5      | 1791        | BsaI        | 5wt_tile54_sub5;5wt_tile55_sub5;5wt_tile56_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile54_sub6      | 250         | BsaI        | 5wt_tile54_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile55_sub6      | 460         | BsaI        | 5wt_tile55_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile56_sub6      | 676         | BsaI        | 5wt_tile56_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile6            | 864         | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile7            | 1068        | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile8            | 1203        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile9            | 1335        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile1_sub1      | 1557        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile1_sub2      | 1791        | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile8_sub2;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile1_sub3      | 1716        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub3;3wt_tile9_sub3;3wt_tile10_sub3;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2;3wt_tile16_sub2;3wt_tile17_sub2;3wt_tile18_sub2;3wt_tile19_sub2;3wt_tile20_sub2;3wt_tile21_sub2;3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile1_sub4      | 1425        | BsmBI       | 3wt_tile1_sub4;3wt_tile2_sub4;3wt_tile3_sub4;3wt_tile4_sub4;3wt_tile5_sub4;3wt_tile6_sub4;3wt_tile7_sub4;3wt_tile8_sub4;3wt_tile9_sub4;3wt_tile10_sub4;3wt_tile11_sub3;3wt_tile12_sub3;3wt_tile13_sub3;3wt_tile14_sub3;3wt_tile15_sub3;3wt_tile16_sub3;3wt_tile17_sub3;3wt_tile18_sub3;3wt_tile19_sub3;3wt_tile20_sub3;3wt_tile21_sub3;3wt_tile22_sub2;3wt_tile23_sub2;3wt_tile24_sub2;3wt_tile25_sub2;3wt_tile26_sub2;3wt_tile27_sub2;3wt_tile28_sub2;3wt_tile29_sub2;3wt_tile30_sub2;3wt_tile32_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile1_sub5      | 1791        | BsmBI       | 3wt_tile1_sub5;3wt_tile2_sub5;3wt_tile3_sub5;3wt_tile4_sub5;3wt_tile5_sub5;3wt_tile6_sub5;3wt_tile7_sub5;3wt_tile8_sub5;3wt_tile9_sub5;3wt_tile10_sub5;3wt_tile11_sub4;3wt_tile12_sub4;3wt_tile13_sub4;3wt_tile14_sub4;3wt_tile15_sub4;3wt_tile16_sub4;3wt_tile17_sub4;3wt_tile18_sub4;3wt_tile19_sub4;3wt_tile20_sub4;3wt_tile21_sub4;3wt_tile22_sub3;3wt_tile23_sub3;3wt_tile24_sub3;3wt_tile25_sub3;3wt_tile26_sub3;3wt_tile27_sub3;3wt_tile28_sub3;3wt_tile29_sub3;3wt_tile30_sub3;3wt_tile31_sub2;3wt_tile32_sub2;3wt_tile33_sub2;3wt_tile34_sub2;3wt_tile35_sub2;3wt_tile36_sub2;3wt_tile37_sub2;3wt_tile38_sub2;3wt_tile39_sub2;3wt_tile40_sub2;3wt_tile41_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile1_sub6      | 1608        | BsmBI       | 3wt_tile1_sub6;3wt_tile2_sub6;3wt_tile3_sub6;3wt_tile4_sub6;3wt_tile5_sub6;3wt_tile6_sub6;3wt_tile7_sub6;3wt_tile8_sub6;3wt_tile9_sub6;3wt_tile10_sub6;3wt_tile11_sub5;3wt_tile12_sub5;3wt_tile13_sub5;3wt_tile14_sub5;3wt_tile15_sub5;3wt_tile16_sub5;3wt_tile17_sub5;3wt_tile18_sub5;3wt_tile19_sub5;3wt_tile20_sub5;3wt_tile21_sub5;3wt_tile22_sub4;3wt_tile23_sub4;3wt_tile24_sub4;3wt_tile25_sub4;3wt_tile26_sub4;3wt_tile27_sub4;3wt_tile28_sub4;3wt_tile29_sub4;3wt_tile30_sub4;3wt_tile31_sub3;3wt_tile32_sub3;3wt_tile33_sub3;3wt_tile34_sub3;3wt_tile35_sub3;3wt_tile36_sub3;3wt_tile37_sub3;3wt_tile38_sub3;3wt_tile39_sub3;3wt_tile40_sub3;3wt_tile41_sub2;3wt_tile42_sub2;3wt_tile43_sub2;3wt_tile44_sub2;3wt_tile45_sub2;3wt_tile46_sub2;3wt_tile47_sub2;3wt_tile48_sub2;3wt_tile49_sub2;3wt_tile50_sub2;3wt_tile51_sub2                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile10_sub1     | 129         | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile12_sub1     | 1629        | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile13_sub1     | 1431        | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile14_sub1     | 1332        | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile15_sub1     | 1125        | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile16_sub1     | 960         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile17_sub1     | 768         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile18_sub1     | 558         | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile19_sub1     | 360         | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile2_sub1      | 1473        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile20_sub1     | 279         | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile21_sub1     | 192         | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile23_sub1     | 1512        | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile24_sub1     | 1353        | BsmBI       | 3wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile25_sub1     | 1212        | BsmBI       | 3wt_tile25_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile26_sub1     | 1050        | BsmBI       | 3wt_tile26_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile27_sub1     | 912         | BsmBI       | 3wt_tile27_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile28_sub1     | 711         | BsmBI       | 3wt_tile28_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile29_sub1     | 510         | BsmBI       | 3wt_tile29_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile3_sub1      | 1263        | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile30_sub1     | 330         | BsmBI       | 3wt_tile30_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile31_sub1     | 1530        | BsmBI       | 3wt_tile31_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile33_sub1     | 1212        | BsmBI       | 3wt_tile33_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile34_sub1     | 1125        | BsmBI       | 3wt_tile34_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile35_sub1     | 930         | BsmBI       | 3wt_tile35_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile36_sub1     | 768         | BsmBI       | 3wt_tile36_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile37_sub1     | 558         | BsmBI       | 3wt_tile37_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile38_sub1     | 444         | BsmBI       | 3wt_tile38_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile39_sub1     | 261         | BsmBI       | 3wt_tile39_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile4_sub1      | 1164        | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile40_sub1     | 102         | BsmBI       | 3wt_tile40_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile42_sub1     | 1677        | BsmBI       | 3wt_tile42_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile43_sub1     | 1596        | BsmBI       | 3wt_tile43_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile44_sub1     | 1383        | BsmBI       | 3wt_tile44_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile45_sub1     | 1170        | BsmBI       | 3wt_tile45_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile46_sub1     | 942         | BsmBI       | 3wt_tile46_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile47_sub1     | 741         | BsmBI       | 3wt_tile47_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile48_sub1     | 558         | BsmBI       | 3wt_tile48_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile49_sub1     | 471         | BsmBI       | 3wt_tile49_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile5_sub1      | 939         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile50_sub1     | 381         | BsmBI       | 3wt_tile50_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile51_sub1     | 147         | BsmBI       | 3wt_tile51_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile52_sub1     | 381         | BsmBI       | 3wt_tile52_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile52_sub2     | 1625        | BsmBI       | 3wt_polIII_tile52_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile53          | 1760        | BsmBI       | 3wt_polIII_tile53                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile54          | 1550        | BsmBI       | 3wt_polIII_tile54                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile55          | 1334        | BsmBI       | 3wt_polIII_tile55                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile6_sub1      | 735         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile7_sub1      | 600         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile8_sub1      | 468         | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile9_sub1      | 270         | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_cassette_tile1_sub7 | 398         | BsmBI       | cassette_tile1_frag1;cassette_tile2_frag1;cassette_tile3_frag1;cassette_tile4_frag1;cassette_tile5_frag1;cassette_tile6_frag1;cassette_tile7_frag1;cassette_tile8_frag1;cassette_tile9_frag1;cassette_tile10_frag1;cassette_tile11_frag1;cassette_tile12_frag1;cassette_tile13_frag1;cassette_tile14_frag1;cassette_tile15_frag1;cassette_tile16_frag1;cassette_tile17_frag1;cassette_tile18_frag1;cassette_tile19_frag1;cassette_tile20_frag1;cassette_tile21_frag1;cassette_tile22_frag1;cassette_tile23_frag1;cassette_tile24_frag1;cassette_tile25_frag1;cassette_tile26_frag1;cassette_tile27_frag1;cassette_tile28_frag1;cassette_tile29_frag1;cassette_tile30_frag1;cassette_tile31_frag1;cassette_tile32_frag1;cassette_tile33_frag1;cassette_tile34_frag1;cassette_tile35_frag1;cassette_tile36_frag1;cassette_tile37_frag1;cassette_tile38_frag1;cassette_tile39_frag1;cassette_tile40_frag1;cassette_tile41_frag1;cassette_tile42_frag1;cassette_tile43_frag1;cassette_tile44_frag1;cassette_tile45_frag1;cassette_tile46_frag1;cassette_tile47_frag1;cassette_tile48_frag1;cassette_tile49_frag1;cassette_tile50_frag1;cassette_tile51_frag1 |
| bsmbi_polIII_tile56       | 1112        | BsmBI       | polIII_tile56                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |

## 10. Domestication Log

20 endogenous enzyme site(s) were removed via silent mutations:

| site_start | enzyme | strand | codon_pos | original_codon | new_codon | aa  |
| ---------- | ------ | ------ | --------- | -------------- | --------- | --- |
| 549        | BsaI   | +      | 184       | GTC            | GTG       | V   |
| 3926       | BsaI   | -      | 1309      | AGA            | AGG       | R   |
| 4649       | BsaI   | -      | 1550      | GGA            | GGC       | G   |
| 6739       | BsaI   | -      | 2247      | GAG            | GAA       | E   |
| 7056       | BsaI   | +      | 2352      | CTG            | CTT       | L   |
| 8098       | BsaI   | -      | 2700      | GAG            | GAA       | E   |
| 8578       | BsaI   | -      | 2860      | GAG            | GAA       | E   |
| 8995       | BsaI   | -      | 2999      | GAG            | GAA       | E   |
| 2272       | BsmBI  | -      | 758       | GAG            | GAA       | E   |
| 2978       | BsmBI  | +      | 993       | GCG            | GCC       | A   |
| 3154       | BsmBI  | -      | 1052      | GAG            | GAA       | E   |
| 3393       | BsmBI  | -      | 1131      | AAG            | AAA       | K   |
| 4886       | BsmBI  | -      | 1629      | GGA            | GGC       | G   |
| 4931       | BsmBI  | +      | 1644      | ACG            | ACC       | T   |
| 5214       | BsmBI  | +      | 1738      | TCC            | TCT       | S   |
| 5482       | BsmBI  | -      | 1828      | GAG            | GAA       | E   |
| 1728       | PaqCI  | -      | 576       | CAG            | CAA       | Q   |
| 2163       | PaqCI  | -      | 721       | CTG            | CTC       | L   |
| 2731       | PaqCI  | +      | 911       | CAC            | CAT       | H   |
| 2895       | PaqCI  | -      | 965       | CTG            | CTC       | L   |

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

