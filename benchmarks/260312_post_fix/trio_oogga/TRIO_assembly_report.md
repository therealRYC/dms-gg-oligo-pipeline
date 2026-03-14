# DMS-GG Assembly Report: TRIO

Generated: 2026-03-12 08:06:46
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                         |
| -------------------- | ----------------------------------------------------------------------------- |
| Gene name            | TRIO_NM_007118.4_CDS Homo sapiens triple functional domain protein (TRIO) CDS |
| CDS length           | 9294 nt (3098 codons)                                                         |
| Protein length       | 3097 aa                                                                       |
| Number of tiles      | 55                                                                            |
| Total variants       | 60858                                                                         |
| Total oligos         | 608580                                                                        |
| Oligo length range   | 137-290 nt                                                                    |
| Gene blocks to order | 117                                                                           |
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

**Total oligos:** 608580 | **Length range:** 137-290 nt

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
| 12   | 586-654   | 13650  | 263 nt |
| 13   | 655-726   | 14280  | 272 nt |
| 14   | 727-803   | 15330  | 287 nt |
| 15   | 804-868   | 12810  | 251 nt |
| 16   | 869-930   | 12180  | 242 nt |
| 17   | 931-993   | 12390  | 245 nt |
| 18   | 994-1066  | 14490  | 275 nt |
| 19   | 1067-1102 | 6720   | 164 nt |
| 20   | 1103-1180 | 15540  | 290 nt |
| 21   | 1177-1248 | 14280  | 272 nt |
| 22   | 1249-1301 | 10290  | 215 nt |
| 23   | 1302-1348 | 9030   | 197 nt |
| 24   | 1349-1402 | 10500  | 218 nt |
| 25   | 1403-1448 | 8820   | 194 nt |
| 26   | 1449-1515 | 13230  | 257 nt |
| 27   | 1516-1582 | 13230  | 257 nt |
| 28   | 1583-1642 | 11760  | 236 nt |
| 29   | 1643-1711 | 13650  | 263 nt |
| 30   | 1712-1746 | 6510   | 161 nt |
| 31   | 1743-1817 | 14910  | 281 nt |
| 32   | 1818-1846 | 5250   | 143 nt |
| 33   | 1847-1911 | 12810  | 251 nt |
| 34   | 1912-1965 | 10500  | 218 nt |
| 35   | 1966-2035 | 13860  | 266 nt |
| 36   | 2036-2073 | 7140   | 170 nt |
| 37   | 2074-2134 | 11970  | 239 nt |
| 38   | 2135-2187 | 10290  | 215 nt |
| 39   | 2188-2215 | 5040   | 140 nt |
| 40   | 2212-2253 | 7980   | 182 nt |
| 41   | 2254-2280 | 4830   | 137 nt |
| 42   | 2281-2351 | 14070  | 269 nt |
| 43   | 2352-2422 | 14070  | 269 nt |
| 44   | 2423-2498 | 15120  | 284 nt |
| 45   | 2499-2565 | 13230  | 257 nt |
| 46   | 2566-2626 | 11970  | 239 nt |
| 47   | 2627-2655 | 5250   | 143 nt |
| 48   | 2656-2685 | 5460   | 146 nt |
| 49   | 2686-2763 | 15540  | 290 nt |
| 50   | 2764-2806 | 8190   | 185 nt |
| 51   | 2803-2879 | 15330  | 287 nt |
| 52   | 2880-2952 | 14490  | 275 nt |
| 53   | 2953-2979 | 4830   | 137 nt |
| 54   | 2980-3053 | 14700  | 278 nt |
| 55   | 3054-3098 | 8610   | 191 nt |

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
| Total barcodes    | 608580                             |
| Unique barcodes   | 608580                             |
| GC content range  | 25% - 75%                          |
| GC content mean   | 48%                                |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                     | Description                                                   | Result | Detail                                                                                                                                                |
| ------------------------- | ------------------------------------------------------------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths             | All oligos within synthesis length limit                      | PASS   | Range: 137-290 nt (limit: 300)                                                                                                                        |
| block_lengths             | All gene blocks within synthesis length limit                 | PASS   | Range: 102-1791 nt (limit: 1800)                                                                                                                      |
| barcode_junction_sites    | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                               |
| barcode_uniqueness        | All barcodes are unique                                       | PASS   | 608580 unique / 608580 total                                                                                                                          |
| tile_coverage             | Tiles cover entire gene without gaps                          | PASS   | 9294 / 9294 nt covered                                                                                                                                |
| variant_count             | Expected number of variants generated                         | PASS   | 60858 unique variants (expected: 60858 across 2898/3096 mutable positions; 55062 missense + 2898 nonsense + 2898 wt_control; 198 position(s) skipped) |
| single_codon_change       | Each non-control variant differs by exactly one codon from WT | PASS   | 579600 / 579600 variants confirmed (WT controls excluded)                                                                                             |
| oligo_gc_content          | Oligo GC content within reasonable range (25-75%)             | FAIL   | GC range: 37.6-76.2% | 647 oligo(s) with extreme GC                                                                                                   |
| domestication_complete    | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                               |
| overhang_fidelity         | Tile boundary overhangs have adequate fidelity                | FAIL   | 52 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                               |
| tile_manifests            | Per-tile assembly manifests complete                          | PASS   | 55 tile manifest(s) generated                                                                                                                         |
| helper_plasmid            | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                    |
| reaction_fidelity         | Per-reaction set-level overhang fidelity                      | PASS   | Min set fidelity: 0.8695 across 110 reactions | 4 reaction(s) below 0.90                                                                              |
| barcode_poliii_term       | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 608580 barcode(s) contain TTTT                                                                                                                    |
| block_min_length          | All gene blocks above synthesis minimum length                | FAIL   | 11 block(s) below 300 nt minimum. Range: 102-1791 nt                                                                                                  |
| cassette_fragment_lengths | Cassette fragments within synthesis limits                    | PASS   | 1 cassette fragment(s). Range: 398-398 nt. 0 over max, 0 under min.                                                                                   |
| sb_overhang_collisions    | Superblock boundary overhangs are unique (no collisions)      | PASS   | 6 SB boundary OH(s), all unique                                                                                                                       |
| gene_reconstruct          | Gene reconstruction from tiles matches original CDS           | PASS   | All 6 SB junction OH(s) match gene sequence; reconstructed gene (9294 nt) matches CDS                                                                 |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 8         | 0.9683             |
| 2    | 3        | 1.0000            | 8         | 1.0000             |
| 3    | 3        | 0.9656            | 8         | 1.0000             |
| 4    | 3        | 1.0000            | 8         | 1.0000             |
| 5    | 3        | 1.0000            | 8         | 0.9416             |
| 6    | 3        | 1.0000            | 8         | 1.0000             |
| 7    | 3        | 0.9574            | 8         | 1.0000             |
| 8    | 3        | 1.0000            | 8         | 1.0000             |
| 9    | 3        | 1.0000            | 8         | 1.0000             |
| 10   | 3        | 1.0000            | 8         | 0.9940             |
| 11   | 3        | 1.0000            | 7         | 1.0000             |
| 12   | 3        | 0.9925            | 7         | 1.0000             |
| 13   | 4        | 1.0000            | 7         | 0.9596             |
| 14   | 4        | 0.8919            | 7         | 1.0000             |
| 15   | 4        | 1.0000            | 7         | 1.0000             |
| 16   | 4        | 1.0000            | 7         | 1.0000             |
| 17   | 4        | 1.0000            | 7         | 0.9940             |
| 18   | 4        | 1.0000            | 7         | 1.0000             |
| 19   | 4        | 1.0000            | 7         | 1.0000             |
| 20   | 4        | 1.0000            | 6         | 1.0000             |
| 21   | 4        | 1.0000            | 6         | 0.9988             |
| 22   | 5        | 1.0000            | 6         | 0.8695             |
| 23   | 5        | 0.9986            | 6         | 0.9985             |
| 24   | 5        | 0.9218            | 6         | 1.0000             |
| 25   | 5        | 1.0000            | 6         | 1.0000             |
| 26   | 5        | 0.9778            | 6         | 1.0000             |
| 27   | 5        | 1.0000            | 6         | 0.9961             |
| 28   | 5        | 0.9763            | 6         | 0.9910             |
| 29   | 5        | 1.0000            | 5         | 1.0000             |
| 30   | 5        | 1.0000            | 5         | 1.0000             |
| 31   | 5        | 1.0000            | 5         | 0.8908             |
| 32   | 6        | 0.8916            | 5         | 1.0000             |
| 33   | 6        | 0.9308            | 5         | 1.0000             |
| 34   | 6        | 0.9935            | 5         | 0.9971             |
| 35   | 6        | 1.0000            | 5         | 1.0000             |
| 36   | 6        | 1.0000            | 5         | 1.0000             |
| 37   | 6        | 0.9218            | 5         | 0.9862             |
| 38   | 6        | 0.9222            | 5         | 1.0000             |
| 39   | 6        | 0.9537            | 4         | 1.0000             |
| 40   | 6        | 1.0000            | 4         | 1.0000             |
| 41   | 6        | 0.9935            | 4         | 0.9686             |
| 42   | 6        | 1.0000            | 4         | 0.9945             |
| 43   | 7        | 1.0000            | 4         | 1.0000             |
| 44   | 7        | 1.0000            | 4         | 0.9984             |
| 45   | 7        | 0.9308            | 4         | 1.0000             |
| 46   | 7        | 1.0000            | 4         | 0.9786             |
| 47   | 7        | 0.9574            | 4         | 1.0000             |
| 48   | 7        | 0.9778            | 4         | 1.0000             |
| 49   | 7        | 0.9218            | 4         | 1.0000             |
| 50   | 7        | 0.9966            | 3         | 1.0000             |
| 51   | 7        | 1.0000            | 2         | 1.0000             |
| 52   | 8        | 1.0000            | 2         | 1.0000             |
| 53   | 8        | 1.0000            | 2         | 1.0000             |
| 54   | 8        | 1.0000            | 2         | 1.0000             |
| 55   | 8        | 1.0000            | 2         | 1.0000             |

**Min:** 0.8695 | **Max:** 1.0000 | **Mean:** 0.9873

**Warning:** 4 reaction(s) below 0.90 fidelity — consider alternative split points or overhang reassignment.
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

### Tile 1 of 55 -- Codons 1-76 (228 nt)

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
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1      | 1557 nt | GAGA  | ATTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1791 nt | ATTT  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GAAA  | TCCA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | TCCA  | TAAG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAGA]----3'WT sub1----[ATTT]----3'WT sub2----[GAAA]----3'WT sub3----[TCCA]----3'WT sub4----[TAAG]----3'WT sub5----[CAGA]----3'WT sub6----[AATA]----3'WT+PolIII sub7----[CACC]
   GAGA                   ATTT                   GAAA                   TCCA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 0.9683 (8 overhangs)

---

### Tile 2 of 55 -- Codons 77-104 (84 nt)

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
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1      | 1473 nt | CATT  | ATTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1791 nt | ATTT  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GAAA  | TCCA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | TCCA  | TAAG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CATT]----3'WT sub1----[ATTT]----3'WT sub2----[GAAA]----3'WT sub3----[TCCA]----3'WT sub4----[TAAG]----3'WT sub5----[CAGA]----3'WT sub6----[AATA]----3'WT+PolIII sub7----[CACC]
   CATT                   ATTT                   GAAA                   TCCA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (8 overhangs)

---

### Tile 3 of 55 -- Codons 105-174 (210 nt)

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
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1      | 1263 nt | TGAA  | ATTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1791 nt | ATTT  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GAAA  | TCCA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | TCCA  | TAAG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[ATTT]----3'WT sub2----[GAAA]----3'WT sub3----[TCCA]----3'WT sub4----[TAAG]----3'WT sub5----[CAGA]----3'WT sub6----[AATA]----3'WT+PolIII sub7----[CACC]
   TGAA                   ATTT                   GAAA                   TCCA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (8 overhangs)

---

### Tile 4 of 55 -- Codons 175-207 (99 nt)

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
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1      | 1164 nt | CGAA  | ATTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1791 nt | ATTT  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GAAA  | TCCA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | TCCA  | TAAG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CGAA]----3'WT sub1----[ATTT]----3'WT sub2----[GAAA]----3'WT sub3----[TCCA]----3'WT sub4----[TAAG]----3'WT sub5----[CAGA]----3'WT sub6----[AATA]----3'WT+PolIII sub7----[CACC]
   CGAA                   ATTT                   GAAA                   TCCA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (8 overhangs)

---

### Tile 5 of 55 -- Codons 208-282 (225 nt)

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
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1      | 939 nt  | GATA  | ATTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1791 nt | ATTT  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GAAA  | TCCA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | TCCA  | TAAG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GATA]----3'WT sub1----[ATTT]----3'WT sub2----[GAAA]----3'WT sub3----[TCCA]----3'WT sub4----[TAAG]----3'WT sub5----[CAGA]----3'WT sub6----[AATA]----3'WT+PolIII sub7----[CACC]
   GATA                   ATTT                   GAAA                   TCCA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 0.9416 (8 overhangs)

---

### Tile 6 of 55 -- Codons 283-350 (204 nt)

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
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1      | 735 nt  | TGAC  | ATTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1791 nt | ATTT  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GAAA  | TCCA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | TCCA  | TAAG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGAC]----3'WT sub1----[ATTT]----3'WT sub2----[GAAA]----3'WT sub3----[TCCA]----3'WT sub4----[TAAG]----3'WT sub5----[CAGA]----3'WT sub6----[AATA]----3'WT+PolIII sub7----[CACC]
   TGAC                   ATTT                   GAAA                   TCCA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (8 overhangs)

---

### Tile 7 of 55 -- Codons 351-395 (135 nt)

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
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1      | 600 nt  | AAAC  | ATTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1791 nt | ATTT  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GAAA  | TCCA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | TCCA  | TAAG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AAAC]----3'WT sub1----[ATTT]----3'WT sub2----[GAAA]----3'WT sub3----[TCCA]----3'WT sub4----[TAAG]----3'WT sub5----[CAGA]----3'WT sub6----[AATA]----3'WT+PolIII sub7----[CACC]
   AAAC                   ATTT                   GAAA                   TCCA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (8 overhangs)

---

### Tile 8 of 55 -- Codons 396-439 (132 nt)

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
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1      | 468 nt  | CTTG  | ATTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1791 nt | ATTT  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GAAA  | TCCA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | TCCA  | TAAG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTTG]----3'WT sub1----[ATTT]----3'WT sub2----[GAAA]----3'WT sub3----[TCCA]----3'WT sub4----[TAAG]----3'WT sub5----[CAGA]----3'WT sub6----[AATA]----3'WT+PolIII sub7----[CACC]
   CTTG                   ATTT                   GAAA                   TCCA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (8 overhangs)

---

### Tile 9 of 55 -- Codons 440-505 (198 nt)

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
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1      | 270 nt  | CCTT  | ATTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1791 nt | ATTT  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GAAA  | TCCA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | TCCA  | TAAG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CCTT]----3'WT sub1----[ATTT]----3'WT sub2----[GAAA]----3'WT sub3----[TCCA]----3'WT sub4----[TAAG]----3'WT sub5----[CAGA]----3'WT sub6----[AATA]----3'WT+PolIII sub7----[CACC]
   CCTT                   ATTT                   GAAA                   TCCA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (8 overhangs)

---

### Tile 10 of 55 -- Codons 506-552 (141 nt)

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
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1     | 129 nt  | GCAA  | ATTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1791 nt | ATTT  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GAAA  | TCCA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | TCCA  | TAAG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GCAA]----3'WT sub1----[ATTT]----3'WT sub2----[GAAA]----3'WT sub3----[TCCA]----3'WT sub4----[TAAG]----3'WT sub5----[CAGA]----3'WT sub6----[AATA]----3'WT+PolIII sub7----[CACC]
   GCAA                   ATTT                   GAAA                   TCCA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 0.9940 (8 overhangs)

---

### Tile 11 of 55 -- Codons 553-589 (111 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AACA     | 0.8032   |
| oh2 (3' boundary) | ATTT     | 0.7664   |

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
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1791 nt | ATTT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GAAA  | TCCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | TCCA  | TAAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [ATTT]----3'WT sub1----[GAAA]----3'WT sub2----[TCCA]----3'WT sub3----[TAAG]----3'WT sub4----[CAGA]----3'WT sub5----[AATA]----3'WT+PolIII sub6----[CACC]
   ATTT                   GAAA                   TCCA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (7 overhangs)

---

### Tile 12 of 55 -- Codons 586-654 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGAG     | 0.5228   |
| oh2 (3' boundary) | AGAT     | 0.6825   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12        | 1773 nt | ATGA  | GGAG  |
| 2   | Oligo pool      | Tile 12 (13650 oligos) | 263 nt  | GGAG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT block----[GGAG]----oligo+BC----[AGAA]
   ATGA                    GGAG                  AGAA 
```

**Set fidelity:** 0.9925 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1     | 1596 nt | AGAT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GAAA  | TCCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | TCCA  | TAAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AGAT]----3'WT sub1----[GAAA]----3'WT sub2----[TCCA]----3'WT sub3----[TAAG]----3'WT sub4----[CAGA]----3'WT sub5----[AATA]----3'WT+PolIII sub6----[CACC]
   AGAT                   GAAA                   TCCA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (7 overhangs)

---

### Tile 13 of 55 -- Codons 655-726 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CGGA     | 0.6609   |
| oh2 (3' boundary) | GGAA     | 0.7463   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 217 nt  | ATTT  | CGGA  |
| 3   | Oligo pool      | Tile 13 (14280 oligos) | 272 nt  | CGGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[CGGA]----oligo+BC----[AGAA]
   ATGA                   ATTT                   CGGA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1     | 1380 nt | GGAA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GAAA  | TCCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | TCCA  | TAAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GGAA]----3'WT sub1----[GAAA]----3'WT sub2----[TCCA]----3'WT sub3----[TAAG]----3'WT sub4----[CAGA]----3'WT sub5----[AATA]----3'WT+PolIII sub6----[CACC]
   GGAA                   GAAA                   TCCA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 0.9596 (7 overhangs)

---

### Tile 14 of 55 -- Codons 727-803 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTGA     | 0.5613   |
| oh2 (3' boundary) | TGAT     | 0.6933   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 433 nt  | ATTT  | GTGA  |
| 3   | Oligo pool      | Tile 14 (15330 oligos) | 287 nt  | GTGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GTGA]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GTGA                  AGAA 
```

**Set fidelity:** 0.8919 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1     | 1149 nt | TGAT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GAAA  | TCCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | TCCA  | TAAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGAT]----3'WT sub1----[GAAA]----3'WT sub2----[TCCA]----3'WT sub3----[TAAG]----3'WT sub4----[CAGA]----3'WT sub5----[AATA]----3'WT+PolIII sub6----[CACC]
   TGAT                   GAAA                   TCCA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (7 overhangs)

---

### Tile 15 of 55 -- Codons 804-868 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTT     | 0.7985   |
| oh2 (3' boundary) | TGTA     | 0.7693   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 664 nt  | ATTT  | TCTT  |
| 3   | Oligo pool      | Tile 15 (12810 oligos) | 251 nt  | TCTT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[TCTT]----oligo+BC----[AGAA]
   ATGA                   ATTT                   TCTT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1     | 954 nt  | TGTA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GAAA  | TCCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | TCCA  | TAAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGTA]----3'WT sub1----[GAAA]----3'WT sub2----[TCCA]----3'WT sub3----[TAAG]----3'WT sub4----[CAGA]----3'WT sub5----[AATA]----3'WT+PolIII sub6----[CACC]
   TGTA                   GAAA                   TCCA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (7 overhangs)

---

### Tile 16 of 55 -- Codons 869-930 (186 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GATA     | 0.7029   |
| oh2 (3' boundary) | ACTT     | 0.7315   |

**Variants:** 12180 mutations, 12180 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 859 nt  | ATTT  | GATA  |
| 3   | Oligo pool      | Tile 16 (12180 oligos) | 242 nt  | GATA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GATA]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GATA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1     | 768 nt  | ACTT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GAAA  | TCCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | TCCA  | TAAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [ACTT]----3'WT sub1----[GAAA]----3'WT sub2----[TCCA]----3'WT sub3----[TAAG]----3'WT sub4----[CAGA]----3'WT sub5----[AATA]----3'WT+PolIII sub6----[CACC]
   ACTT                   GAAA                   TCCA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (7 overhangs)

---

### Tile 17 of 55 -- Codons 931-993 (189 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATG     | 0.6412   |
| oh2 (3' boundary) | GCAA     | 0.7543   |

**Variants:** 12390 mutations, 12390 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 1045 nt | ATTT  | AATG  |
| 3   | Oligo pool      | Tile 17 (12390 oligos) | 245 nt  | AATG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[AATG]----oligo+BC----[AGAA]
   ATGA                   ATTT                   AATG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1     | 579 nt  | GCAA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GAAA  | TCCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | TCCA  | TAAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GCAA]----3'WT sub1----[GAAA]----3'WT sub2----[TCCA]----3'WT sub3----[TAAG]----3'WT sub4----[CAGA]----3'WT sub5----[AATA]----3'WT+PolIII sub6----[CACC]
   GCAA                   GAAA                   TCCA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 0.9940 (7 overhangs)

---

### Tile 18 of 55 -- Codons 994-1066 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTC     | 0.8105   |
| oh2 (3' boundary) | ATTC     | 0.7084   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1234 nt | ATTT  | TCTC  |
| 3   | Oligo pool      | Tile 18 (14490 oligos) | 275 nt  | TCTC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[TCTC]----oligo+BC----[AGAA]
   ATGA                   ATTT                   TCTC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1     | 360 nt  | ATTC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GAAA  | TCCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | TCCA  | TAAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [ATTC]----3'WT sub1----[GAAA]----3'WT sub2----[TCCA]----3'WT sub3----[TAAG]----3'WT sub4----[CAGA]----3'WT sub5----[AATA]----3'WT+PolIII sub6----[CACC]
   ATTC                   GAAA                   TCCA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (7 overhangs)

---

### Tile 19 of 55 -- Codons 1067-1102 (108 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGG     | 0.6552   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 6720 mutations, 6720 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1453 nt | ATTT  | AAGG  |
| 3   | Oligo pool      | Tile 19 (6720 oligos) | 164 nt  | AAGG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[AAGG]----oligo+BC----[AGAA]
   ATGA                   ATTT                   AAGG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1     | 252 nt  | TGAA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GAAA  | TCCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | TCCA  | TAAG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[GAAA]----3'WT sub2----[TCCA]----3'WT sub3----[TAAG]----3'WT sub4----[CAGA]----3'WT sub5----[AATA]----3'WT+PolIII sub6----[CACC]
   TGAA                   GAAA                   TCCA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (7 overhangs)

---

### Tile 20 of 55 -- Codons 1103-1180 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAG     | 0.7511   |
| oh2 (3' boundary) | GAAA     | 0.8745   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1561 nt | ATTT  | AAAG  |
| 3   | Oligo pool      | Tile 20 (15540 oligos) | 290 nt  | AAAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[AAAG]----oligo+BC----[AGAA]
   ATGA                   ATTT                   AAAG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1716 nt | GAAA  | TCCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | TCCA  | TAAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAAA]----3'WT sub1----[TCCA]----3'WT sub2----[TAAG]----3'WT sub3----[CAGA]----3'WT sub4----[AATA]----3'WT+PolIII sub5----[CACC]
   GAAA                   TCCA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 21 of 55 -- Codons 1177-1248 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAGC     | 0.5446   |
| oh2 (3' boundary) | TTCC     | 0.7958   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1783 nt | ATTT  | GAGC  |
| 3   | Oligo pool      | Tile 21 (14280 oligos) | 272 nt  | GAGC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAGC]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAGC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1     | 1512 nt | TTCC  | TCCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | TCCA  | TAAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TTCC]----3'WT sub1----[TCCA]----3'WT sub2----[TAAG]----3'WT sub3----[CAGA]----3'WT sub4----[AATA]----3'WT+PolIII sub5----[CACC]
   TTCC                   TCCA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 0.9988 (6 overhangs)

---

### Tile 22 of 55 -- Codons 1249-1301 (159 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 226 nt  | GAAA  | TCTT  |
| 4   | Oligo pool      | Tile 22 (10290 oligos) | 215 nt  | TCTT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[TCTT]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   TCTT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1     | 1353 nt | AAAG  | TCCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | TCCA  | TAAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AAAG]----3'WT sub1----[TCCA]----3'WT sub2----[TAAG]----3'WT sub3----[CAGA]----3'WT sub4----[AATA]----3'WT+PolIII sub5----[CACC]
   AAAG                   TCCA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 0.8695 (6 overhangs)

---

### Tile 23 of 55 -- Codons 1302-1348 (141 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2  | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3  | 385 nt  | GAAA  | CAAA  |
| 4   | Oligo pool      | Tile 23 (9030 oligos) | 197 nt  | CAAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[CAAA]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   CAAA                  AGAA 
```

**Set fidelity:** 0.9986 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1     | 1212 nt | TAAT  | TCCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | TCCA  | TAAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TAAT]----3'WT sub1----[TCCA]----3'WT sub2----[TAAG]----3'WT sub3----[CAGA]----3'WT sub4----[AATA]----3'WT+PolIII sub5----[CACC]
   TAAT                   TCCA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 0.9985 (6 overhangs)

---

### Tile 24 of 55 -- Codons 1349-1402 (162 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3   | 526 nt  | GAAA  | GAAT  |
| 4   | Oligo pool      | Tile 24 (10500 oligos) | 218 nt  | GAAT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[GAAT]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   GAAT                  AGAA 
```

**Set fidelity:** 0.9218 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile24_sub1     | 1050 nt | TGAC  | TCCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | TCCA  | TAAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGAC]----3'WT sub1----[TCCA]----3'WT sub2----[TAAG]----3'WT sub3----[CAGA]----3'WT sub4----[AATA]----3'WT+PolIII sub5----[CACC]
   TGAC                   TCCA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 25 of 55 -- Codons 1403-1448 (138 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2  | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3  | 688 nt  | GAAA  | TCCT  |
| 4   | Oligo pool      | Tile 25 (8820 oligos) | 194 nt  | TCCT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[TCCT]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   TCCT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile25_sub1     | 912 nt  | AGAT  | TCCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | TCCA  | TAAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AGAT]----3'WT sub1----[TCCA]----3'WT sub2----[TAAG]----3'WT sub3----[CAGA]----3'WT sub4----[AATA]----3'WT+PolIII sub5----[CACC]
   AGAT                   TCCA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 26 of 55 -- Codons 1449-1515 (201 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3   | 826 nt  | GAAA  | GAGA  |
| 4   | Oligo pool      | Tile 26 (13230 oligos) | 257 nt  | GAGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[GAGA]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   GAGA                  AGAA 
```

**Set fidelity:** 0.9778 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile26_sub1     | 711 nt  | TAGT  | TCCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | TCCA  | TAAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TAGT]----3'WT sub1----[TCCA]----3'WT sub2----[TAAG]----3'WT sub3----[CAGA]----3'WT sub4----[AATA]----3'WT+PolIII sub5----[CACC]
   TAGT                   TCCA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 27 of 55 -- Codons 1516-1582 (201 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1027 nt | GAAA  | TTAG  |
| 4   | Oligo pool      | Tile 27 (13230 oligos) | 257 nt  | TTAG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[TTAG]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   TTAG                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile27_sub1     | 510 nt  | TATC  | TCCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | TCCA  | TAAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TATC]----3'WT sub1----[TCCA]----3'WT sub2----[TAAG]----3'WT sub3----[CAGA]----3'WT sub4----[AATA]----3'WT+PolIII sub5----[CACC]
   TATC                   TCCA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 0.9961 (6 overhangs)

---

### Tile 28 of 55 -- Codons 1583-1642 (180 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1228 nt | GAAA  | ATAA  |
| 4   | Oligo pool      | Tile 28 (11760 oligos) | 236 nt  | ATAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[ATAA]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   ATAA                  AGAA 
```

**Set fidelity:** 0.9763 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile28_sub1     | 330 nt  | TCAG  | TCCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | TCCA  | TAAG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TCAG]----3'WT sub1----[TCCA]----3'WT sub2----[TAAG]----3'WT sub3----[CAGA]----3'WT sub4----[AATA]----3'WT+PolIII sub5----[CACC]
   TCAG                   TCCA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 0.9910 (6 overhangs)

---

### Tile 29 of 55 -- Codons 1643-1711 (207 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile29_sub3   | 1408 nt | GAAA  | CGGA  |
| 4   | Oligo pool      | Tile 29 (13650 oligos) | 263 nt  | CGGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[CGGA]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   CGGA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile29_sub1     | 1530 nt | TTCA  | TAAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TTCA]----3'WT sub1----[TAAG]----3'WT sub2----[CAGA]----3'WT sub3----[AATA]----3'WT+PolIII sub4----[CACC]
   TTCA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 30 of 55 -- Codons 1712-1746 (105 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCCT     | 0.6204   |
| oh2 (3' boundary) | TCCA     | 0.8519   |

**Variants:** 6510 mutations, 6510 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2  | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3  | 1615 nt | GAAA  | CCCT  |
| 4   | Oligo pool      | Tile 30 (6510 oligos) | 161 nt  | CCCT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[CCCT]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   CCCT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 1425 nt | TCCA  | TAAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TCCA]----3'WT sub1----[TAAG]----3'WT sub2----[CAGA]----3'WT sub3----[AATA]----3'WT+PolIII sub4----[CACC]
   TCCA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 31 of 55 -- Codons 1743-1817 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GACG     | 0.4599   |
| oh2 (3' boundary) | CAGT     | 0.6512   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile31_sub3   | 1708 nt | GAAA  | GACG  |
| 4   | Oligo pool      | Tile 31 (14910 oligos) | 281 nt  | GACG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[GACG]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   GACG                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile31_sub1     | 1212 nt | CAGT  | TAAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CAGT]----3'WT sub1----[TAAG]----3'WT sub2----[CAGA]----3'WT sub3----[AATA]----3'WT+PolIII sub4----[CACC]
   CAGT                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 0.8908 (5 overhangs)

---

### Tile 32 of 55 -- Codons 1818-1846 (87 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2  | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile32_sub3  | 1716 nt | GAAA  | TCCA  |
| 4   | 5'WT gene block | bsai_5wt_tile32_sub4  | 235 nt  | TCCA  | TCCG  |
| 5   | Oligo pool      | Tile 32 (5250 oligos) | 143 nt  | TCCG  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[TCCA]----5'WT sub4----[TCCG]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   TCCA                   TCCG                  AGAA 
```

**Set fidelity:** 0.8916 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile32_sub1     | 1125 nt | CTCG  | TAAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTCG]----3'WT sub1----[TAAG]----3'WT sub2----[CAGA]----3'WT sub3----[AATA]----3'WT+PolIII sub4----[CACC]
   CTCG                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 33 of 55 -- Codons 1847-1911 (195 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile32_sub3   | 1716 nt | GAAA  | TCCA  |
| 4   | 5'WT gene block | bsai_5wt_tile33_sub4   | 322 nt  | TCCA  | TCCT  |
| 5   | Oligo pool      | Tile 33 (12810 oligos) | 251 nt  | TCCT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[TCCA]----5'WT sub4----[TCCT]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   TCCA                   TCCT                  AGAA 
```

**Set fidelity:** 0.9308 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile33_sub1     | 930 nt  | GGAA  | TAAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GGAA]----3'WT sub1----[TAAG]----3'WT sub2----[CAGA]----3'WT sub3----[AATA]----3'WT+PolIII sub4----[CACC]
   GGAA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 34 of 55 -- Codons 1912-1965 (162 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile32_sub3   | 1716 nt | GAAA  | TCCA  |
| 4   | 5'WT gene block | bsai_5wt_tile34_sub4   | 517 nt  | TCCA  | GCAA  |
| 5   | Oligo pool      | Tile 34 (10500 oligos) | 218 nt  | GCAA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[TCCA]----5'WT sub4----[GCAA]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   TCCA                   GCAA                  AGAA 
```

**Set fidelity:** 0.9935 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile34_sub1     | 768 nt  | GAGA  | TAAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAGA]----3'WT sub1----[TAAG]----3'WT sub2----[CAGA]----3'WT sub3----[AATA]----3'WT+PolIII sub4----[CACC]
   GAGA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 0.9971 (5 overhangs)

---

### Tile 35 of 55 -- Codons 1966-2035 (210 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile32_sub3   | 1716 nt | GAAA  | TCCA  |
| 4   | 5'WT gene block | bsai_5wt_tile35_sub4   | 679 nt  | TCCA  | TCTT  |
| 5   | Oligo pool      | Tile 35 (13860 oligos) | 266 nt  | TCTT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[TCCA]----5'WT sub4----[TCTT]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   TCCA                   TCTT                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile35_sub1     | 558 nt  | TGAA  | TAAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[TAAG]----3'WT sub2----[CAGA]----3'WT sub3----[AATA]----3'WT+PolIII sub4----[CACC]
   TGAA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 36 of 55 -- Codons 2036-2073 (114 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2  | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile32_sub3  | 1716 nt | GAAA  | TCCA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4  | 889 nt  | TCCA  | AAGT  |
| 5   | Oligo pool      | Tile 36 (7140 oligos) | 170 nt  | AAGT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[TCCA]----5'WT sub4----[AAGT]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   TCCA                   AAGT                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile36_sub1     | 444 nt  | TGAT  | TAAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGAT]----3'WT sub1----[TAAG]----3'WT sub2----[CAGA]----3'WT sub3----[AATA]----3'WT+PolIII sub4----[CACC]
   TGAT                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 37 of 55 -- Codons 2074-2134 (183 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile32_sub3   | 1716 nt | GAAA  | TCCA  |
| 4   | 5'WT gene block | bsai_5wt_tile37_sub4   | 1003 nt | TCCA  | GAAT  |
| 5   | Oligo pool      | Tile 37 (11970 oligos) | 239 nt  | GAAT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[TCCA]----5'WT sub4----[GAAT]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   TCCA                   GAAT                  AGAA 
```

**Set fidelity:** 0.9218 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile37_sub1     | 261 nt  | AGTA  | TAAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AGTA]----3'WT sub1----[TAAG]----3'WT sub2----[CAGA]----3'WT sub3----[AATA]----3'WT+PolIII sub4----[CACC]
   AGTA                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 0.9862 (5 overhangs)

---

### Tile 38 of 55 -- Codons 2135-2187 (159 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile32_sub3   | 1716 nt | GAAA  | TCCA  |
| 4   | 5'WT gene block | bsai_5wt_tile38_sub4   | 1186 nt | TCCA  | ATGT  |
| 5   | Oligo pool      | Tile 38 (10290 oligos) | 215 nt  | ATGT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[TCCA]----5'WT sub4----[ATGT]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   TCCA                   ATGT                  AGAA 
```

**Set fidelity:** 0.9222 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile38_sub1     | 102 nt  | CTTT  | TAAG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTTT]----3'WT sub1----[TAAG]----3'WT sub2----[CAGA]----3'WT sub3----[AATA]----3'WT+PolIII sub4----[CACC]
   CTTT                   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 39 of 55 -- Codons 2188-2215 (84 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCT     | 0.7151   |
| oh2 (3' boundary) | TAAG     | 0.8377   |

**Variants:** 5040 mutations, 5040 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2  | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile32_sub3  | 1716 nt | GAAA  | TCCA  |
| 4   | 5'WT gene block | bsai_5wt_tile39_sub4  | 1345 nt | TCCA  | ATCT  |
| 5   | Oligo pool      | Tile 39 (5040 oligos) | 140 nt  | ATCT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[TCCA]----5'WT sub4----[ATCT]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   TCCA                   ATCT                  AGAA 
```

**Set fidelity:** 0.9537 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 1791 nt | TAAG  | CAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TAAG]----3'WT sub1----[CAGA]----3'WT sub2----[AATA]----3'WT+PolIII sub3----[CACC]
   TAAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 40 of 55 -- Codons 2212-2253 (126 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCC     | 0.7958   |
| oh2 (3' boundary) | AAGT     | 0.7629   |

**Variants:** 7980 mutations, 7980 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2  | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile32_sub3  | 1716 nt | GAAA  | TCCA  |
| 4   | 5'WT gene block | bsai_5wt_tile40_sub4  | 1417 nt | TCCA  | TTCC  |
| 5   | Oligo pool      | Tile 40 (7980 oligos) | 182 nt  | TTCC  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[TCCA]----5'WT sub4----[TTCC]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   TCCA                   TTCC                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile40_sub1     | 1677 nt | AAGT  | CAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AAGT]----3'WT sub1----[CAGA]----3'WT sub2----[AATA]----3'WT+PolIII sub3----[CACC]
   AAGT                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 41 of 55 -- Codons 2254-2280 (81 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2  | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile32_sub3  | 1716 nt | GAAA  | TCCA  |
| 4   | 5'WT gene block | bsai_5wt_tile41_sub4  | 1543 nt | TCCA  | TCTA  |
| 5   | Oligo pool      | Tile 41 (4830 oligos) | 137 nt  | TCTA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[TCCA]----5'WT sub4----[TCTA]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   TCCA                   TCTA                  AGAA 
```

**Set fidelity:** 0.9935 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile41_sub1     | 1596 nt | AATC  | CAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AATC]----3'WT sub1----[CAGA]----3'WT sub2----[AATA]----3'WT+PolIII sub3----[CACC]
   AATC                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 0.9686 (4 overhangs)

---

### Tile 42 of 55 -- Codons 2281-2351 (213 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile32_sub3   | 1716 nt | GAAA  | TCCA  |
| 4   | 5'WT gene block | bsai_5wt_tile42_sub4   | 1624 nt | TCCA  | ACAT  |
| 5   | Oligo pool      | Tile 42 (14070 oligos) | 269 nt  | ACAT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[TCCA]----5'WT sub4----[ACAT]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   TCCA                   ACAT                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile42_sub1     | 1383 nt | CTCT  | CAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTCT]----3'WT sub1----[CAGA]----3'WT sub2----[AATA]----3'WT+PolIII sub3----[CACC]
   CTCT                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 0.9945 (4 overhangs)

---

### Tile 43 of 55 -- Codons 2352-2422 (213 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile32_sub3   | 1716 nt | GAAA  | TCCA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4   | 1425 nt | TCCA  | TAAG  |
| 5   | 5'WT gene block | bsai_5wt_tile43_sub5   | 430 nt  | TAAG  | CTTG  |
| 6   | Oligo pool      | Tile 43 (14070 oligos) | 269 nt  | CTTG  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[TCCA]----5'WT sub4----[TAAG]----5'WT sub5----[CTTG]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   TCCA                   TAAG                   CTTG                  AGAA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile43_sub1     | 1170 nt | CTCG  | CAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTCG]----3'WT sub1----[CAGA]----3'WT sub2----[AATA]----3'WT+PolIII sub3----[CACC]
   CTCG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 44 of 55 -- Codons 2423-2498 (228 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile32_sub3   | 1716 nt | GAAA  | TCCA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4   | 1425 nt | TCCA  | TAAG  |
| 5   | 5'WT gene block | bsai_5wt_tile44_sub5   | 643 nt  | TAAG  | GCGA  |
| 6   | Oligo pool      | Tile 44 (15120 oligos) | 284 nt  | GCGA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[TCCA]----5'WT sub4----[TAAG]----5'WT sub5----[GCGA]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   TCCA                   TAAG                   GCGA                  AGAA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile44_sub1     | 942 nt  | CTTC  | CAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTTC]----3'WT sub1----[CAGA]----3'WT sub2----[AATA]----3'WT+PolIII sub3----[CACC]
   CTTC                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 0.9984 (4 overhangs)

---

### Tile 45 of 55 -- Codons 2499-2565 (201 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile32_sub3   | 1716 nt | GAAA  | TCCA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4   | 1425 nt | TCCA  | TAAG  |
| 5   | 5'WT gene block | bsai_5wt_tile45_sub5   | 871 nt  | TAAG  | TCCT  |
| 6   | Oligo pool      | Tile 45 (13230 oligos) | 257 nt  | TCCT  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[TCCA]----5'WT sub4----[TAAG]----5'WT sub5----[TCCT]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   TCCA                   TAAG                   TCCT                  AGAA 
```

**Set fidelity:** 0.9308 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile45_sub1     | 741 nt  | TGAG  | CAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGAG]----3'WT sub1----[CAGA]----3'WT sub2----[AATA]----3'WT+PolIII sub3----[CACC]
   TGAG                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 46 of 55 -- Codons 2566-2626 (183 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile32_sub3   | 1716 nt | GAAA  | TCCA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4   | 1425 nt | TCCA  | TAAG  |
| 5   | 5'WT gene block | bsai_5wt_tile46_sub5   | 1072 nt | TAAG  | AAGG  |
| 6   | Oligo pool      | Tile 46 (11970 oligos) | 239 nt  | AAGG  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[TCCA]----5'WT sub4----[TAAG]----5'WT sub5----[AAGG]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   TCCA                   TAAG                   AAGG                  AGAA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile46_sub1     | 558 nt  | AACA  | CAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AACA]----3'WT sub1----[CAGA]----3'WT sub2----[AATA]----3'WT+PolIII sub3----[CACC]
   AACA                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 0.9786 (4 overhangs)

---

### Tile 47 of 55 -- Codons 2627-2655 (87 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2  | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile32_sub3  | 1716 nt | GAAA  | TCCA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4  | 1425 nt | TCCA  | TAAG  |
| 5   | 5'WT gene block | bsai_5wt_tile47_sub5  | 1255 nt | TAAG  | AAGA  |
| 6   | Oligo pool      | Tile 47 (5250 oligos) | 143 nt  | AAGA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[TCCA]----5'WT sub4----[TAAG]----5'WT sub5----[AAGA]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   TCCA                   TAAG                   AAGA                  AGAA 
```

**Set fidelity:** 0.9574 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile47_sub1     | 471 nt  | TTAT  | CAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TTAT]----3'WT sub1----[CAGA]----3'WT sub2----[AATA]----3'WT+PolIII sub3----[CACC]
   TTAT                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 48 of 55 -- Codons 2656-2685 (90 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2  | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile32_sub3  | 1716 nt | GAAA  | TCCA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4  | 1425 nt | TCCA  | TAAG  |
| 5   | 5'WT gene block | bsai_5wt_tile48_sub5  | 1342 nt | TAAG  | GAGA  |
| 6   | Oligo pool      | Tile 48 (5460 oligos) | 146 nt  | GAGA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[TCCA]----5'WT sub4----[TAAG]----5'WT sub5----[GAGA]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   TCCA                   TAAG                   GAGA                  AGAA 
```

**Set fidelity:** 0.9778 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile48_sub1     | 381 nt  | CATT  | CAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CATT]----3'WT sub1----[CAGA]----3'WT sub2----[AATA]----3'WT+PolIII sub3----[CACC]
   CATT                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 49 of 55 -- Codons 2686-2763 (234 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile32_sub3   | 1716 nt | GAAA  | TCCA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4   | 1425 nt | TCCA  | TAAG  |
| 5   | 5'WT gene block | bsai_5wt_tile49_sub5   | 1432 nt | TAAG  | GAAT  |
| 6   | Oligo pool      | Tile 49 (15540 oligos) | 290 nt  | GAAT  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[TCCA]----5'WT sub4----[TAAG]----5'WT sub5----[GAAT]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   TCCA                   TAAG                   GAAT                  AGAA 
```

**Set fidelity:** 0.9218 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile49_sub1     | 147 nt  | TTCA  | CAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1608 nt | CAGA  | AATA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 398 nt  | AATA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TTCA]----3'WT sub1----[CAGA]----3'WT sub2----[AATA]----3'WT+PolIII sub3----[CACC]
   TTCA                   CAGA                   AATA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 50 of 55 -- Codons 2764-2806 (129 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GACA     | 0.6127   |
| oh2 (3' boundary) | CAGA     | 0.8175   |

**Variants:** 8190 mutations, 8190 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2  | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile32_sub3  | 1716 nt | GAAA  | TCCA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4  | 1425 nt | TCCA  | TAAG  |
| 5   | 5'WT gene block | bsai_5wt_tile50_sub5  | 1666 nt | TAAG  | GACA  |
| 6   | Oligo pool      | Tile 50 (8190 oligos) | 185 nt  | GACA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[TCCA]----5'WT sub4----[TAAG]----5'WT sub5----[GACA]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   TCCA                   TAAG                   GACA                  AGAA 
```

**Set fidelity:** 0.9966 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile50_sub1    | 381 nt  | CAGA  | TTTA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile50_sub2    | 1625 nt | TTTA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAGA]----3'WT sub1----[TTTA]----3'WT+PolIII sub2----[CACC]
   CAGA                   TTTA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 51 of 55 -- Codons 2803-2879 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGCA     | 0.5273   |
| oh2 (3' boundary) | GCGA     | 0.5836   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile32_sub3   | 1716 nt | GAAA  | TCCA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4   | 1425 nt | TCCA  | TAAG  |
| 5   | 5'WT gene block | bsai_5wt_tile51_sub5   | 1783 nt | TAAG  | GGCA  |
| 6   | Oligo pool      | Tile 51 (15330 oligos) | 287 nt  | GGCA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[TCCA]----5'WT sub4----[TAAG]----5'WT sub5----[GGCA]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   TCCA                   TAAG                   GGCA                  AGAA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile51         | 1769 nt | GCGA  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCGA]----3'WT+PolIII----[CACC]
   GCGA                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 52 of 55 -- Codons 2880-2952 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TGCG     | 0.4943   |
| oh2 (3' boundary) | CCCT     | 0.6204   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile32_sub3   | 1716 nt | GAAA  | TCCA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4   | 1425 nt | TCCA  | TAAG  |
| 5   | 5'WT gene block | bsai_5wt_tile52_sub5   | 1791 nt | TAAG  | CAGA  |
| 6   | 5'WT gene block | bsai_5wt_tile52_sub6   | 241 nt  | CAGA  | TGCG  |
| 7   | Oligo pool      | Tile 52 (14490 oligos) | 275 nt  | TGCG  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[TCCA]----5'WT sub4----[TAAG]----5'WT sub5----[CAGA]----5'WT sub6----[TGCG]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   TCCA                   TAAG                   CAGA                   TGCG                  AGAA 
```

**Set fidelity:** 1.0000 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile52         | 1550 nt | CCCT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCCT]----3'WT+PolIII----[CACC]
   CCCT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 53 of 55 -- Codons 2953-2979 (81 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTGG     | 0.5756   |
| oh2 (3' boundary) | ATAC     | 0.6804   |

**Variants:** 4830 mutations, 4830 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2  | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile32_sub3  | 1716 nt | GAAA  | TCCA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4  | 1425 nt | TCCA  | TAAG  |
| 5   | 5'WT gene block | bsai_5wt_tile52_sub5  | 1791 nt | TAAG  | CAGA  |
| 6   | 5'WT gene block | bsai_5wt_tile53_sub6  | 460 nt  | CAGA  | CTGG  |
| 7   | Oligo pool      | Tile 53 (4830 oligos) | 137 nt  | CTGG  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[TCCA]----5'WT sub4----[TAAG]----5'WT sub5----[CAGA]----5'WT sub6----[CTGG]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   TCCA                   TAAG                   CAGA                   CTGG                  AGAA 
```

**Set fidelity:** 1.0000 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile53         | 1469 nt | ATAC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATAC]----3'WT+PolIII----[CACC]
   ATAC                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 54 of 55 -- Codons 2980-3053 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTGC     | 0.4969   |
| oh2 (3' boundary) | AAGC     | 0.5900   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2   | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile32_sub3   | 1716 nt | GAAA  | TCCA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4   | 1425 nt | TCCA  | TAAG  |
| 5   | 5'WT gene block | bsai_5wt_tile52_sub5   | 1791 nt | TAAG  | CAGA  |
| 6   | 5'WT gene block | bsai_5wt_tile54_sub6   | 541 nt  | CAGA  | GTGC  |
| 7   | Oligo pool      | Tile 54 (14700 oligos) | 278 nt  | GTGC  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[TCCA]----5'WT sub4----[TAAG]----5'WT sub5----[CAGA]----5'WT sub6----[GTGC]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   TCCA                   TAAG                   CAGA                   GTGC                  AGAA 
```

**Set fidelity:** 1.0000 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile54         | 1247 nt | AAGC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAGC]----3'WT+PolIII----[CACC]
   AAGC                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 55 of 55 -- Codons 3054-3098 (135 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AACG     | 0.5566   |
| oh2 (3' boundary) | TTGA     | 0.8853   |

**Variants:** 8610 mutations, 8610 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1  | 1781 nt | ATGA  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2  | 1791 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile32_sub3  | 1716 nt | GAAA  | TCCA  |
| 4   | 5'WT gene block | bsai_5wt_tile43_sub4  | 1425 nt | TCCA  | TAAG  |
| 5   | 5'WT gene block | bsai_5wt_tile52_sub5  | 1791 nt | TAAG  | CAGA  |
| 6   | 5'WT gene block | bsai_5wt_tile55_sub6  | 763 nt  | CAGA  | AACG  |
| 7   | Oligo pool      | Tile 55 (8610 oligos) | 191 nt  | AACG  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[TCCA]----5'WT sub4----[TAAG]----5'WT sub5----[CAGA]----5'WT sub6----[AACG]----oligo+BC----[AGAA]
   ATGA                   ATTT                   GAAA                   TCCA                   TAAG                   CAGA                   AACG                  AGAA 
```

**Set fidelity:** 1.0000 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component            | Part name                | Length  | 5' OH | 3' OH |
| --- | -------------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product         | (in helper plasmid)      | --      | --    | --    |
| 2   | PolIII-only fragment | bsmbi_polIII_tile55      | 1112 nt | TTGA  | CACC  |
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

**Total blocks:** 117

| Block name                | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| ------------------------- | ----------- | ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| bsai_5wt_tile10           | 1533        | BsaI        | 5wt_tile10                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsai_5wt_tile11           | 1674        | BsaI        | 5wt_tile11                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsai_5wt_tile12           | 1773        | BsaI        | 5wt_tile12                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsai_5wt_tile13_sub1      | 1781        | BsaI        | 5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1;5wt_tile26_sub1;5wt_tile27_sub1;5wt_tile28_sub1;5wt_tile29_sub1;5wt_tile30_sub1;5wt_tile31_sub1;5wt_tile32_sub1;5wt_tile33_sub1;5wt_tile34_sub1;5wt_tile35_sub1;5wt_tile36_sub1;5wt_tile37_sub1;5wt_tile38_sub1;5wt_tile39_sub1;5wt_tile40_sub1;5wt_tile41_sub1;5wt_tile42_sub1;5wt_tile43_sub1;5wt_tile44_sub1;5wt_tile45_sub1;5wt_tile46_sub1;5wt_tile47_sub1;5wt_tile48_sub1;5wt_tile49_sub1;5wt_tile50_sub1;5wt_tile51_sub1;5wt_tile52_sub1;5wt_tile53_sub1;5wt_tile54_sub1;5wt_tile55_sub1                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile13_sub2      | 217         | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile14_sub2      | 433         | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile15_sub2      | 664         | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile16_sub2      | 859         | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile17_sub2      | 1045        | BsaI        | 5wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile18_sub2      | 1234        | BsaI        | 5wt_tile18_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile19_sub2      | 1453        | BsaI        | 5wt_tile19_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile2            | 246         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile20_sub2      | 1561        | BsaI        | 5wt_tile20_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile21_sub2      | 1783        | BsaI        | 5wt_tile21_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile22_sub2      | 1791        | BsaI        | 5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2;5wt_tile26_sub2;5wt_tile27_sub2;5wt_tile28_sub2;5wt_tile29_sub2;5wt_tile30_sub2;5wt_tile31_sub2;5wt_tile32_sub2;5wt_tile33_sub2;5wt_tile34_sub2;5wt_tile35_sub2;5wt_tile36_sub2;5wt_tile37_sub2;5wt_tile38_sub2;5wt_tile39_sub2;5wt_tile40_sub2;5wt_tile41_sub2;5wt_tile42_sub2;5wt_tile43_sub2;5wt_tile44_sub2;5wt_tile45_sub2;5wt_tile46_sub2;5wt_tile47_sub2;5wt_tile48_sub2;5wt_tile49_sub2;5wt_tile50_sub2;5wt_tile51_sub2;5wt_tile52_sub2;5wt_tile53_sub2;5wt_tile54_sub2;5wt_tile55_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile22_sub3      | 226         | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile23_sub3      | 385         | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile24_sub3      | 526         | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile25_sub3      | 688         | BsaI        | 5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile26_sub3      | 826         | BsaI        | 5wt_tile26_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile27_sub3      | 1027        | BsaI        | 5wt_tile27_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile28_sub3      | 1228        | BsaI        | 5wt_tile28_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile29_sub3      | 1408        | BsaI        | 5wt_tile29_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile3            | 330         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile30_sub3      | 1615        | BsaI        | 5wt_tile30_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile31_sub3      | 1708        | BsaI        | 5wt_tile31_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile32_sub3      | 1716        | BsaI        | 5wt_tile32_sub3;5wt_tile33_sub3;5wt_tile34_sub3;5wt_tile35_sub3;5wt_tile36_sub3;5wt_tile37_sub3;5wt_tile38_sub3;5wt_tile39_sub3;5wt_tile40_sub3;5wt_tile41_sub3;5wt_tile42_sub3;5wt_tile43_sub3;5wt_tile44_sub3;5wt_tile45_sub3;5wt_tile46_sub3;5wt_tile47_sub3;5wt_tile48_sub3;5wt_tile49_sub3;5wt_tile50_sub3;5wt_tile51_sub3;5wt_tile52_sub3;5wt_tile53_sub3;5wt_tile54_sub3;5wt_tile55_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile32_sub4      | 235         | BsaI        | 5wt_tile32_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile33_sub4      | 322         | BsaI        | 5wt_tile33_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile34_sub4      | 517         | BsaI        | 5wt_tile34_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile35_sub4      | 679         | BsaI        | 5wt_tile35_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile36_sub4      | 889         | BsaI        | 5wt_tile36_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile37_sub4      | 1003        | BsaI        | 5wt_tile37_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile38_sub4      | 1186        | BsaI        | 5wt_tile38_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile39_sub4      | 1345        | BsaI        | 5wt_tile39_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile4            | 540         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile40_sub4      | 1417        | BsaI        | 5wt_tile40_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile41_sub4      | 1543        | BsaI        | 5wt_tile41_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile42_sub4      | 1624        | BsaI        | 5wt_tile42_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile43_sub4      | 1425        | BsaI        | 5wt_tile43_sub4;5wt_tile44_sub4;5wt_tile45_sub4;5wt_tile46_sub4;5wt_tile47_sub4;5wt_tile48_sub4;5wt_tile49_sub4;5wt_tile50_sub4;5wt_tile51_sub4;5wt_tile52_sub4;5wt_tile53_sub4;5wt_tile54_sub4;5wt_tile55_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile43_sub5      | 430         | BsaI        | 5wt_tile43_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile44_sub5      | 643         | BsaI        | 5wt_tile44_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile45_sub5      | 871         | BsaI        | 5wt_tile45_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile46_sub5      | 1072        | BsaI        | 5wt_tile46_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile47_sub5      | 1255        | BsaI        | 5wt_tile47_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile48_sub5      | 1342        | BsaI        | 5wt_tile48_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile49_sub5      | 1432        | BsaI        | 5wt_tile49_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile5            | 639         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile50_sub5      | 1666        | BsaI        | 5wt_tile50_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile51_sub5      | 1783        | BsaI        | 5wt_tile51_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile52_sub5      | 1791        | BsaI        | 5wt_tile52_sub5;5wt_tile53_sub5;5wt_tile54_sub5;5wt_tile55_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile52_sub6      | 241         | BsaI        | 5wt_tile52_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile53_sub6      | 460         | BsaI        | 5wt_tile53_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile54_sub6      | 541         | BsaI        | 5wt_tile54_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile55_sub6      | 763         | BsaI        | 5wt_tile55_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile6            | 864         | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile7            | 1068        | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile8            | 1203        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile9            | 1335        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile1_sub1      | 1557        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile1_sub2      | 1791        | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile8_sub2;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile1_sub3      | 1716        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub3;3wt_tile9_sub3;3wt_tile10_sub3;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2;3wt_tile16_sub2;3wt_tile17_sub2;3wt_tile18_sub2;3wt_tile19_sub2;3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile1_sub4      | 1425        | BsmBI       | 3wt_tile1_sub4;3wt_tile2_sub4;3wt_tile3_sub4;3wt_tile4_sub4;3wt_tile5_sub4;3wt_tile6_sub4;3wt_tile7_sub4;3wt_tile8_sub4;3wt_tile9_sub4;3wt_tile10_sub4;3wt_tile11_sub3;3wt_tile12_sub3;3wt_tile13_sub3;3wt_tile14_sub3;3wt_tile15_sub3;3wt_tile16_sub3;3wt_tile17_sub3;3wt_tile18_sub3;3wt_tile19_sub3;3wt_tile20_sub2;3wt_tile21_sub2;3wt_tile22_sub2;3wt_tile23_sub2;3wt_tile24_sub2;3wt_tile25_sub2;3wt_tile26_sub2;3wt_tile27_sub2;3wt_tile28_sub2;3wt_tile30_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile1_sub5      | 1791        | BsmBI       | 3wt_tile1_sub5;3wt_tile2_sub5;3wt_tile3_sub5;3wt_tile4_sub5;3wt_tile5_sub5;3wt_tile6_sub5;3wt_tile7_sub5;3wt_tile8_sub5;3wt_tile9_sub5;3wt_tile10_sub5;3wt_tile11_sub4;3wt_tile12_sub4;3wt_tile13_sub4;3wt_tile14_sub4;3wt_tile15_sub4;3wt_tile16_sub4;3wt_tile17_sub4;3wt_tile18_sub4;3wt_tile19_sub4;3wt_tile20_sub3;3wt_tile21_sub3;3wt_tile22_sub3;3wt_tile23_sub3;3wt_tile24_sub3;3wt_tile25_sub3;3wt_tile26_sub3;3wt_tile27_sub3;3wt_tile28_sub3;3wt_tile29_sub2;3wt_tile30_sub2;3wt_tile31_sub2;3wt_tile32_sub2;3wt_tile33_sub2;3wt_tile34_sub2;3wt_tile35_sub2;3wt_tile36_sub2;3wt_tile37_sub2;3wt_tile38_sub2;3wt_tile39_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile1_sub6      | 1608        | BsmBI       | 3wt_tile1_sub6;3wt_tile2_sub6;3wt_tile3_sub6;3wt_tile4_sub6;3wt_tile5_sub6;3wt_tile6_sub6;3wt_tile7_sub6;3wt_tile8_sub6;3wt_tile9_sub6;3wt_tile10_sub6;3wt_tile11_sub5;3wt_tile12_sub5;3wt_tile13_sub5;3wt_tile14_sub5;3wt_tile15_sub5;3wt_tile16_sub5;3wt_tile17_sub5;3wt_tile18_sub5;3wt_tile19_sub5;3wt_tile20_sub4;3wt_tile21_sub4;3wt_tile22_sub4;3wt_tile23_sub4;3wt_tile24_sub4;3wt_tile25_sub4;3wt_tile26_sub4;3wt_tile27_sub4;3wt_tile28_sub4;3wt_tile29_sub3;3wt_tile30_sub3;3wt_tile31_sub3;3wt_tile32_sub3;3wt_tile33_sub3;3wt_tile34_sub3;3wt_tile35_sub3;3wt_tile36_sub3;3wt_tile37_sub3;3wt_tile38_sub3;3wt_tile39_sub2;3wt_tile40_sub2;3wt_tile41_sub2;3wt_tile42_sub2;3wt_tile43_sub2;3wt_tile44_sub2;3wt_tile45_sub2;3wt_tile46_sub2;3wt_tile47_sub2;3wt_tile48_sub2;3wt_tile49_sub2                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile10_sub1     | 129         | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile12_sub1     | 1596        | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile13_sub1     | 1380        | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile14_sub1     | 1149        | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile15_sub1     | 954         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile16_sub1     | 768         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile17_sub1     | 579         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile18_sub1     | 360         | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile19_sub1     | 252         | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile2_sub1      | 1473        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile21_sub1     | 1512        | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile22_sub1     | 1353        | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile23_sub1     | 1212        | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile24_sub1     | 1050        | BsmBI       | 3wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile25_sub1     | 912         | BsmBI       | 3wt_tile25_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile26_sub1     | 711         | BsmBI       | 3wt_tile26_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile27_sub1     | 510         | BsmBI       | 3wt_tile27_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile28_sub1     | 330         | BsmBI       | 3wt_tile28_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile29_sub1     | 1530        | BsmBI       | 3wt_tile29_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile3_sub1      | 1263        | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile31_sub1     | 1212        | BsmBI       | 3wt_tile31_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile32_sub1     | 1125        | BsmBI       | 3wt_tile32_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile33_sub1     | 930         | BsmBI       | 3wt_tile33_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile34_sub1     | 768         | BsmBI       | 3wt_tile34_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile35_sub1     | 558         | BsmBI       | 3wt_tile35_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile36_sub1     | 444         | BsmBI       | 3wt_tile36_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile37_sub1     | 261         | BsmBI       | 3wt_tile37_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile38_sub1     | 102         | BsmBI       | 3wt_tile38_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile4_sub1      | 1164        | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile40_sub1     | 1677        | BsmBI       | 3wt_tile40_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile41_sub1     | 1596        | BsmBI       | 3wt_tile41_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile42_sub1     | 1383        | BsmBI       | 3wt_tile42_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile43_sub1     | 1170        | BsmBI       | 3wt_tile43_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile44_sub1     | 942         | BsmBI       | 3wt_tile44_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile45_sub1     | 741         | BsmBI       | 3wt_tile45_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile46_sub1     | 558         | BsmBI       | 3wt_tile46_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile47_sub1     | 471         | BsmBI       | 3wt_tile47_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile48_sub1     | 381         | BsmBI       | 3wt_tile48_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile49_sub1     | 147         | BsmBI       | 3wt_tile49_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile5_sub1      | 939         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile50_sub1     | 381         | BsmBI       | 3wt_tile50_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile50_sub2     | 1625        | BsmBI       | 3wt_polIII_tile50_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile51          | 1769        | BsmBI       | 3wt_polIII_tile51                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile52          | 1550        | BsmBI       | 3wt_polIII_tile52                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile53          | 1469        | BsmBI       | 3wt_polIII_tile53                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile54          | 1247        | BsmBI       | 3wt_polIII_tile54                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile6_sub1      | 735         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile7_sub1      | 600         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile8_sub1      | 468         | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile9_sub1      | 270         | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_cassette_tile1_sub7 | 398         | BsmBI       | cassette_tile1_frag1;cassette_tile2_frag1;cassette_tile3_frag1;cassette_tile4_frag1;cassette_tile5_frag1;cassette_tile6_frag1;cassette_tile7_frag1;cassette_tile8_frag1;cassette_tile9_frag1;cassette_tile10_frag1;cassette_tile11_frag1;cassette_tile12_frag1;cassette_tile13_frag1;cassette_tile14_frag1;cassette_tile15_frag1;cassette_tile16_frag1;cassette_tile17_frag1;cassette_tile18_frag1;cassette_tile19_frag1;cassette_tile20_frag1;cassette_tile21_frag1;cassette_tile22_frag1;cassette_tile23_frag1;cassette_tile24_frag1;cassette_tile25_frag1;cassette_tile26_frag1;cassette_tile27_frag1;cassette_tile28_frag1;cassette_tile29_frag1;cassette_tile30_frag1;cassette_tile31_frag1;cassette_tile32_frag1;cassette_tile33_frag1;cassette_tile34_frag1;cassette_tile35_frag1;cassette_tile36_frag1;cassette_tile37_frag1;cassette_tile38_frag1;cassette_tile39_frag1;cassette_tile40_frag1;cassette_tile41_frag1;cassette_tile42_frag1;cassette_tile43_frag1;cassette_tile44_frag1;cassette_tile45_frag1;cassette_tile46_frag1;cassette_tile47_frag1;cassette_tile48_frag1;cassette_tile49_frag1 |
| bsmbi_polIII_tile55       | 1112        | BsmBI       | polIII_tile55                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |

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

