# DMS-GG Assembly Report: TRIO

Generated: 2026-03-19 12:33:05
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                         |
| -------------------- | ----------------------------------------------------------------------------- |
| Gene name            | TRIO_NM_007118.4_CDS Homo sapiens triple functional domain protein (TRIO) CDS |
| CDS length           | 9294 nt (3098 codons)                                                         |
| Protein length       | 3097 aa                                                                       |
| Number of tiles      | 52                                                                            |
| Total variants       | 64638                                                                         |
| Total oligos         | 646380                                                                        |
| Oligo length range   | 167-298 nt                                                                    |
| Gene blocks to order | 109                                                                           |
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

**Total oligos:** 646380 | **Length range:** 167-298 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-77      | 15330  | 291 nt |
| 2    | 72-148    | 14910  | 287 nt |
| 3    | 143-212   | 13440  | 266 nt |
| 4    | 207-261   | 10290  | 221 nt |
| 5    | 256-300   | 8190   | 191 nt |
| 6    | 295-364   | 13440  | 266 nt |
| 7    | 359-411   | 9870   | 215 nt |
| 8    | 406-463   | 10920  | 230 nt |
| 9    | 458-526   | 13230  | 263 nt |
| 10   | 521-586   | 12810  | 254 nt |
| 11   | 587-632   | 8820   | 194 nt |
| 12   | 627-692   | 12600  | 254 nt |
| 13   | 687-756   | 13440  | 266 nt |
| 14   | 751-819   | 13230  | 263 nt |
| 15   | 814-887   | 14280  | 278 nt |
| 16   | 882-941   | 11340  | 236 nt |
| 17   | 936-999   | 12180  | 248 nt |
| 18   | 994-1067  | 14280  | 278 nt |
| 19   | 1062-1120 | 11340  | 233 nt |
| 20   | 1121-1193 | 14490  | 275 nt |
| 21   | 1188-1237 | 9240   | 206 nt |
| 22   | 1232-1304 | 14070  | 275 nt |
| 23   | 1299-1366 | 13020  | 260 nt |
| 24   | 1361-1436 | 14700  | 284 nt |
| 25   | 1431-1478 | 8820   | 200 nt |
| 26   | 1473-1519 | 8610   | 197 nt |
| 27   | 1514-1565 | 9870   | 212 nt |
| 28   | 1566-1643 | 15540  | 290 nt |
| 29   | 1638-1715 | 15120  | 290 nt |
| 30   | 1710-1787 | 15120  | 290 nt |
| 31   | 1782-1857 | 14700  | 284 nt |
| 32   | 1852-1909 | 10920  | 230 nt |
| 33   | 1904-1977 | 14280  | 278 nt |
| 34   | 1972-2027 | 10500  | 224 nt |
| 35   | 2022-2058 | 6720   | 167 nt |
| 36   | 2059-2127 | 13650  | 263 nt |
| 37   | 2122-2197 | 14700  | 284 nt |
| 38   | 2192-2253 | 11760  | 242 nt |
| 39   | 2248-2284 | 6510   | 167 nt |
| 40   | 2279-2345 | 12810  | 257 nt |
| 41   | 2340-2413 | 14280  | 278 nt |
| 42   | 2408-2473 | 12600  | 254 nt |
| 43   | 2468-2525 | 11130  | 230 nt |
| 44   | 2526-2603 | 15540  | 290 nt |
| 45   | 2598-2654 | 10710  | 227 nt |
| 46   | 2649-2722 | 14280  | 278 nt |
| 47   | 2717-2792 | 14700  | 284 nt |
| 48   | 2787-2848 | 11760  | 242 nt |
| 49   | 2843-2920 | 15120  | 290 nt |
| 50   | 2915-2969 | 10500  | 221 nt |
| 51   | 2970-3039 | 13860  | 266 nt |
| 52   | 3034-3113 | 12810  | 298 nt |

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
| Total barcodes    | 646380                             |
| Unique barcodes   | 646380                             |
| GC content range  | 35% - 65%                          |
| GC content mean   | 48.5%                              |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                   | Description                                                   | Result | Detail                                                                                                                                               |
| ----------------------- | ------------------------------------------------------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths           | All oligos within synthesis length limit                      | PASS   | Range: 167-298 nt (limit: 300)                                                                                                                       |
| block_lengths           | All gene blocks within synthesis length limit                 | PASS   | Range: 150-1792 nt (limit: 1800)                                                                                                                     |
| barcode_junction_sites  | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                              |
| barcode_uniqueness      | All barcodes are unique                                       | PASS   | 646380 unique / 646380 total                                                                                                                         |
| tile_coverage           | Tiles cover entire gene without gaps                          | PASS   | 9294 / 9294 nt covered                                                                                                                               |
| variant_count           | Expected number of variants generated                         | PASS   | 64638 unique variants (expected: 64638 across 3078/3096 mutable positions; 58482 missense + 3078 nonsense + 3078 wt_control; 18 position(s) skipped) |
| single_codon_change     | Each non-control variant differs by exactly one codon from WT | PASS   | 615600 / 615600 variants confirmed (WT controls excluded)                                                                                            |
| oligo_gc_content        | Oligo GC content within reasonable range (25-75%)             | FAIL   | GC range: 39.8-75.9% | 193 oligo(s) with extreme GC                                                                                                  |
| domestication_complete  | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                              |
| overhang_fidelity       | Tile boundary overhangs have adequate fidelity                | FAIL   | 46 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                              |
| tile_manifests          | Per-tile assembly manifests complete                          | PASS   | 52 tile manifest(s) generated                                                                                                                        |
| helper_plasmid          | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                   |
| reaction_fidelity       | Per-reaction set-level overhang fidelity                      | PASS   | Min set fidelity: 0.937 across 104 reactions | 0 reaction(s) below 0.90                                                                              |
| barcode_poliii_term     | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 646380 barcode(s) contain TTTT                                                                                                                   |
| barcode_hairpins        | No barcodes have hairpin stems > 3 bp                         | PASS   | 0 / 646380 barcode(s) have hairpin stems > 3 bp                                                                                                      |
| barcode_dinuc_repeats   | No barcodes have dinucleotide repeats > 4 units               | PASS   | 0 / 646380 barcode(s) exceed 4 dinuc repeat units                                                                                                    |
| barcode_tm_distribution | Barcode Tm distribution (informational)                       | PASS   | Tm: median=53.2, range=[42, 65.5], sd=4 C                                                                                                            |
| block_min_length        | All gene blocks above synthesis minimum length                | FAIL   | 4 block(s) below 300 nt minimum. Range: 150-1792 nt                                                                                                  |
| sb_overhang_collisions  | Superblock boundary overhangs are unique (no collisions)      | PASS   | 12 SB boundary OH(s), all unique                                                                                                                     |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 0.9406            | 8         | 1.0000             |
| 2    | 3        | 0.9406            | 8         | 1.0000             |
| 3    | 3        | 0.9406            | 8         | 1.0000             |
| 4    | 3        | 0.9406            | 8         | 1.0000             |
| 5    | 3        | 0.9406            | 8         | 1.0000             |
| 6    | 3        | 0.9406            | 8         | 1.0000             |
| 7    | 3        | 0.9406            | 8         | 1.0000             |
| 8    | 3        | 0.9406            | 8         | 1.0000             |
| 9    | 3        | 0.9406            | 8         | 1.0000             |
| 10   | 3        | 0.9406            | 7         | 1.0000             |
| 11   | 3        | 0.9406            | 7         | 1.0000             |
| 12   | 4        | 0.9406            | 7         | 1.0000             |
| 13   | 4        | 0.9406            | 7         | 0.9923             |
| 14   | 4        | 0.9406            | 7         | 1.0000             |
| 15   | 4        | 0.9406            | 7         | 1.0000             |
| 16   | 4        | 0.9406            | 7         | 1.0000             |
| 17   | 4        | 0.9406            | 7         | 1.0000             |
| 18   | 4        | 0.9406            | 6         | 1.0000             |
| 19   | 4        | 0.9406            | 6         | 1.0000             |
| 20   | 4        | 0.9406            | 6         | 1.0000             |
| 21   | 5        | 0.9406            | 6         | 1.0000             |
| 22   | 5        | 0.9406            | 6         | 1.0000             |
| 23   | 5        | 0.9406            | 6         | 1.0000             |
| 24   | 5        | 0.9406            | 6         | 1.0000             |
| 25   | 5        | 0.9406            | 6         | 1.0000             |
| 26   | 5        | 0.9406            | 5         | 1.0000             |
| 27   | 5        | 0.9406            | 5         | 1.0000             |
| 28   | 5        | 0.9406            | 5         | 1.0000             |
| 29   | 5        | 0.9406            | 5         | 1.0000             |
| 30   | 6        | 0.9406            | 5         | 1.0000             |
| 31   | 6        | 0.9406            | 5         | 1.0000             |
| 32   | 6        | 0.9406            | 5         | 1.0000             |
| 33   | 6        | 0.9406            | 4         | 1.0000             |
| 34   | 6        | 0.9388            | 4         | 1.0000             |
| 35   | 6        | 0.9406            | 4         | 1.0000             |
| 36   | 6        | 0.9406            | 4         | 1.0000             |
| 37   | 6        | 0.9406            | 4         | 1.0000             |
| 38   | 7        | 0.9406            | 4         | 1.0000             |
| 39   | 7        | 0.9406            | 4         | 1.0000             |
| 40   | 7        | 0.9406            | 4         | 1.0000             |
| 41   | 7        | 0.9406            | 4         | 1.0000             |
| 42   | 7        | 0.9406            | 3         | 0.9984             |
| 43   | 7        | 0.9406            | 3         | 0.9923             |
| 44   | 7        | 0.9406            | 3         | 0.9982             |
| 45   | 7        | 0.9406            | 3         | 1.0000             |
| 46   | 8        | 0.9370            | 3         | 1.0000             |
| 47   | 8        | 0.9406            | 3         | 1.0000             |
| 48   | 8        | 0.9406            | 3         | 1.0000             |
| 49   | 8        | 0.9406            | 2         | 1.0000             |
| 50   | 8        | 0.9389            | 2         | 1.0000             |
| 51   | 8        | 0.9406            | 2         | 1.0000             |
| 52   | 8        | 0.9389            | 2         | 1.0000             |

**Min:** 0.9370 | **Max:** 1.0000 | **Mean:** 0.9701

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

### Tile 1 of 52 -- Codons 1-77 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TGAA     | 0.8621   |
| oh2 (3' boundary) | TTCA     | 0.8824   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (15330 oligos)              | 291 nt | TGAA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1     | 1575 nt | TTCA  | CAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1632 nt | CAAA  | TTAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1365 nt | TTAC  | CCTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1509 nt | CCTT  | AAAT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCA]----3'WT sub1----[CAAA]----3'WT sub2----[TTAC]----3'WT sub3----[CCTT]----3'WT sub4----[AAAT]----3'WT sub5----[CTCG]----3'WT sub6----[TACG]----3'WT+PolIII sub7----[CACC]
   TTCA                   CAAA                   TTAC                   CCTT                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (8 overhangs)

---

### Tile 2 of 52 -- Codons 72-148 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAG     | 0.7511   |
| oh2 (3' boundary) | GTCC     | 0.5806   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 247 nt | TGAA  | AAAG  |
| 2   | Oligo pool      | Tile 2 (14910 oligos) | 287 nt | AAAG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [TGAA]----5'WT block----[AAAG]----oligo+BC----[AGAA]
   TGAA                    AAAG                  AGAA 
```

**Set fidelity:** 0.9406 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1     | 1362 nt | GTCC  | CAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1632 nt | CAAA  | TTAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1365 nt | TTAC  | CCTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1509 nt | CCTT  | AAAT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GTCC]----3'WT sub1----[CAAA]----3'WT sub2----[TTAC]----3'WT sub3----[CCTT]----3'WT sub4----[AAAT]----3'WT sub5----[CTCG]----3'WT sub6----[TACG]----3'WT+PolIII sub7----[CACC]
   GTCC                   CAAA                   TTAC                   CCTT                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (8 overhangs)

---

### Tile 3 of 52 -- Codons 143-212 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | AGAA     | 0.8847   |

**Variants:** 13440 mutations, 13440 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 460 nt | TGAA  | AAGA  |
| 2   | Oligo pool      | Tile 3 (13440 oligos) | 266 nt | AAGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [TGAA]----5'WT block----[AAGA]----oligo+BC----[AGAA]
   TGAA                    AAGA                  AGAA 
```

**Set fidelity:** 0.9406 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1     | 1170 nt | AGAA  | CAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1632 nt | CAAA  | TTAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1365 nt | TTAC  | CCTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1509 nt | CCTT  | AAAT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAA]----3'WT sub1----[CAAA]----3'WT sub2----[TTAC]----3'WT sub3----[CCTT]----3'WT sub4----[AAAT]----3'WT sub5----[CTCG]----3'WT sub6----[TACG]----3'WT+PolIII sub7----[CACC]
   AGAA                   CAAA                   TTAC                   CCTT                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (8 overhangs)

---

### Tile 4 of 52 -- Codons 207-261 (165 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAT     | 0.7246   |
| oh2 (3' boundary) | TTCT     | 0.8181   |

**Variants:** 10290 mutations, 10290 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 652 nt | TGAA  | GAAT  |
| 2   | Oligo pool      | Tile 4 (10290 oligos) | 221 nt | GAAT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [TGAA]----5'WT block----[GAAT]----oligo+BC----[AGAA]
   TGAA                    GAAT                  AGAA 
```

**Set fidelity:** 0.9406 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1     | 1023 nt | TTCT  | CAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1632 nt | CAAA  | TTAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1365 nt | TTAC  | CCTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1509 nt | CCTT  | AAAT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCT]----3'WT sub1----[CAAA]----3'WT sub2----[TTAC]----3'WT sub3----[CCTT]----3'WT sub4----[AAAT]----3'WT sub5----[CTCG]----3'WT sub6----[TACG]----3'WT+PolIII sub7----[CACC]
   TTCT                   CAAA                   TTAC                   CCTT                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (8 overhangs)

---

### Tile 5 of 52 -- Codons 256-300 (135 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGA     | 0.7549   |
| oh2 (3' boundary) | AGGC     | 0.5710   |

**Variants:** 8190 mutations, 8190 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 799 nt | TGAA  | ATGA  |
| 2   | Oligo pool      | Tile 5 (8190 oligos)  | 191 nt | ATGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

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
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1     | 906 nt  | AGGC  | CAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1632 nt | CAAA  | TTAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1365 nt | TTAC  | CCTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1509 nt | CCTT  | AAAT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGGC]----3'WT sub1----[CAAA]----3'WT sub2----[TTAC]----3'WT sub3----[CCTT]----3'WT sub4----[AAAT]----3'WT sub5----[CTCG]----3'WT sub6----[TACG]----3'WT+PolIII sub7----[CACC]
   AGGC                   CAAA                   TTAC                   CCTT                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (8 overhangs)

---

### Tile 6 of 52 -- Codons 295-364 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | TCTA     | 0.8892   |

**Variants:** 13440 mutations, 13440 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 916 nt | TGAA  | AAGA  |
| 2   | Oligo pool      | Tile 6 (13440 oligos) | 266 nt | AAGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [TGAA]----5'WT block----[AAGA]----oligo+BC----[AGAA]
   TGAA                    AAGA                  AGAA 
```

**Set fidelity:** 0.9406 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1     | 714 nt  | TCTA  | CAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1632 nt | CAAA  | TTAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1365 nt | TTAC  | CCTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1509 nt | CCTT  | AAAT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCTA]----3'WT sub1----[CAAA]----3'WT sub2----[TTAC]----3'WT sub3----[CCTT]----3'WT sub4----[AAAT]----3'WT sub5----[CTCG]----3'WT sub6----[TACG]----3'WT+PolIII sub7----[CACC]
   TCTA                   CAAA                   TTAC                   CCTT                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (8 overhangs)

---

### Tile 7 of 52 -- Codons 359-411 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AACA     | 0.8032   |
| oh2 (3' boundary) | GTCT     | 0.5601   |

**Variants:** 9870 mutations, 9870 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 1108 nt | TGAA  | AACA  |
| 2   | Oligo pool      | Tile 7 (9870 oligos)  | 215 nt  | AACA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [TGAA]----5'WT block----[AACA]----oligo+BC----[AGAA]
   TGAA                    AACA                  AGAA 
```

**Set fidelity:** 0.9406 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1     | 573 nt  | GTCT  | CAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1632 nt | CAAA  | TTAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1365 nt | TTAC  | CCTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1509 nt | CCTT  | AAAT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GTCT]----3'WT sub1----[CAAA]----3'WT sub2----[TTAC]----3'WT sub3----[CCTT]----3'WT sub4----[AAAT]----3'WT sub5----[CTCG]----3'WT sub6----[TACG]----3'WT+PolIII sub7----[CACC]
   GTCT                   CAAA                   TTAC                   CCTT                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (8 overhangs)

---

### Tile 8 of 52 -- Codons 406-463 (174 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATC     | 0.7116   |
| oh2 (3' boundary) | TTCA     | 0.8824   |

**Variants:** 10920 mutations, 10920 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1249 nt | TGAA  | AATC  |
| 2   | Oligo pool      | Tile 8 (10920 oligos) | 230 nt  | AATC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [TGAA]----5'WT block----[AATC]----oligo+BC----[AGAA]
   TGAA                    AATC                  AGAA 
```

**Set fidelity:** 0.9406 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1     | 417 nt  | TTCA  | CAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1632 nt | CAAA  | TTAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1365 nt | TTAC  | CCTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1509 nt | CCTT  | AAAT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCA]----3'WT sub1----[CAAA]----3'WT sub2----[TTAC]----3'WT sub3----[CCTT]----3'WT sub4----[AAAT]----3'WT sub5----[CTCG]----3'WT sub6----[TACG]----3'WT+PolIII sub7----[CACC]
   TTCA                   CAAA                   TTAC                   CCTT                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (8 overhangs)

---

### Tile 9 of 52 -- Codons 458-526 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGA     | 0.7549   |
| oh2 (3' boundary) | AGCC     | 0.4644   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1405 nt | TGAA  | ATGA  |
| 2   | Oligo pool      | Tile 9 (13230 oligos) | 263 nt  | ATGA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1     | 228 nt  | AGCC  | CAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1632 nt | CAAA  | TTAC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1365 nt | TTAC  | CCTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1509 nt | CCTT  | AAAT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGCC]----3'WT sub1----[CAAA]----3'WT sub2----[TTAC]----3'WT sub3----[CCTT]----3'WT sub4----[AAAT]----3'WT sub5----[CTCG]----3'WT sub6----[TACG]----3'WT+PolIII sub7----[CACC]
   AGCC                   CAAA                   TTAC                   CCTT                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (8 overhangs)

---

### Tile 10 of 52 -- Codons 521-586 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCG     | 0.7234   |
| oh2 (3' boundary) | CGGA     | 0.6609   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1594 nt | TGAA  | TCCG  |
| 2   | Oligo pool      | Tile 10 (12810 oligos) | 254 nt  | TCCG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT block----[TCCG]----oligo+BC----[AGAA]
   TGAA                    TCCG                  AGAA 
```

**Set fidelity:** 0.9406 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1    | 1650 nt | CGGA  | TTAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1365 nt | TTAC  | CCTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1509 nt | CCTT  | AAAT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CGGA]----3'WT sub1----[TTAC]----3'WT sub2----[CCTT]----3'WT sub3----[AAAT]----3'WT sub4----[CTCG]----3'WT sub5----[TACG]----3'WT+PolIII sub6----[CACC]
   CGGA                   TTAC                   CCTT                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (7 overhangs)

---

### Tile 11 of 52 -- Codons 587-632 (138 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAG     | 0.6752   |
| oh2 (3' boundary) | AGAA     | 0.8847   |

**Variants:** 8820 mutations, 8820 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11       | 1792 nt | TGAA  | GAAG  |
| 2   | Oligo pool      | Tile 11 (8820 oligos) | 194 nt  | GAAG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [TGAA]----5'WT block----[GAAG]----oligo+BC----[AGAA]
   TGAA                    GAAG                  AGAA 
```

**Set fidelity:** 0.9406 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1    | 1512 nt | AGAA  | TTAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1365 nt | TTAC  | CCTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1509 nt | CCTT  | AAAT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAA]----3'WT sub1----[TTAC]----3'WT sub2----[CCTT]----3'WT sub3----[AAAT]----3'WT sub4----[CTCG]----3'WT sub5----[TACG]----3'WT+PolIII sub6----[CACC]
   AGAA                   TTAC                   CCTT                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (7 overhangs)

---

### Tile 12 of 52 -- Codons 627-692 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAC     | 0.8333   |
| oh2 (3' boundary) | GAAG     | 0.6752   |

**Variants:** 12600 mutations, 12600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2   | 150 nt  | GAAG  | TTAC  |
| 3   | Oligo pool      | Tile 12 (12600 oligos) | 254 nt  | TTAC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[TTAC]----oligo+BC----[AGAA]
   TGAA                   GAAG                   TTAC                  AGAA 
```

**Set fidelity:** 0.9406 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1    | 1332 nt | GAAG  | TTAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1365 nt | TTAC  | CCTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1509 nt | CCTT  | AAAT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAG]----3'WT sub1----[TTAC]----3'WT sub2----[CCTT]----3'WT sub3----[AAAT]----3'WT sub4----[CTCG]----3'WT sub5----[TACG]----3'WT+PolIII sub6----[CACC]
   GAAG                   TTAC                   CCTT                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (7 overhangs)

---

### Tile 13 of 52 -- Codons 687-756 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTGG     | 0.5756   |
| oh2 (3' boundary) | CCAC     | 0.5426   |

**Variants:** 13440 mutations, 13440 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 330 nt  | GAAG  | CTGG  |
| 3   | Oligo pool      | Tile 13 (13440 oligos) | 266 nt  | CTGG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[CTGG]----oligo+BC----[AGAA]
   TGAA                   GAAG                   CTGG                  AGAA 
```

**Set fidelity:** 0.9406 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1    | 1140 nt | CCAC  | TTAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1365 nt | TTAC  | CCTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1509 nt | CCTT  | AAAT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCAC]----3'WT sub1----[TTAC]----3'WT sub2----[CCTT]----3'WT sub3----[AAAT]----3'WT sub4----[CTCG]----3'WT sub5----[TACG]----3'WT+PolIII sub6----[CACC]
   CCAC                   TTAC                   CCTT                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 0.9923 (7 overhangs)

---

### Tile 14 of 52 -- Codons 751-819 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AACA     | 0.8032   |
| oh2 (3' boundary) | AGAA     | 0.8847   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 522 nt  | GAAG  | AACA  |
| 3   | Oligo pool      | Tile 14 (13230 oligos) | 263 nt  | AACA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                  AGAA 
```

**Set fidelity:** 0.9406 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1    | 951 nt  | AGAA  | TTAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1365 nt | TTAC  | CCTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1509 nt | CCTT  | AAAT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAA]----3'WT sub1----[TTAC]----3'WT sub2----[CCTT]----3'WT sub3----[AAAT]----3'WT sub4----[CTCG]----3'WT sub5----[TACG]----3'WT+PolIII sub6----[CACC]
   AGAA                   TTAC                   CCTT                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (7 overhangs)

---

### Tile 15 of 52 -- Codons 814-887 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATG     | 0.6412   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 711 nt  | GAAG  | AATG  |
| 3   | Oligo pool      | Tile 15 (14280 oligos) | 278 nt  | AATG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AATG]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AATG                  AGAA 
```

**Set fidelity:** 0.9406 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1    | 747 nt  | TGAA  | TTAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1365 nt | TTAC  | CCTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1509 nt | CCTT  | AAAT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[TTAC]----3'WT sub2----[CCTT]----3'WT sub3----[AAAT]----3'WT sub4----[CTCG]----3'WT sub5----[TACG]----3'WT+PolIII sub6----[CACC]
   TGAA                   TTAC                   CCTT                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (7 overhangs)

---

### Tile 16 of 52 -- Codons 882-941 (180 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTGG     | 0.5756   |
| oh2 (3' boundary) | ACAA     | 0.8919   |

**Variants:** 11340 mutations, 11340 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 915 nt  | GAAG  | CTGG  |
| 3   | Oligo pool      | Tile 16 (11340 oligos) | 236 nt  | CTGG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[CTGG]----oligo+BC----[AGAA]
   TGAA                   GAAG                   CTGG                  AGAA 
```

**Set fidelity:** 0.9406 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1    | 585 nt  | ACAA  | TTAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1365 nt | TTAC  | CCTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1509 nt | CCTT  | AAAT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACAA]----3'WT sub1----[TTAC]----3'WT sub2----[CCTT]----3'WT sub3----[AAAT]----3'WT sub4----[CTCG]----3'WT sub5----[TACG]----3'WT+PolIII sub6----[CACC]
   ACAA                   TTAC                   CCTT                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (7 overhangs)

---

### Tile 17 of 52 -- Codons 936-999 (192 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACAG     | 0.5793   |
| oh2 (3' boundary) | GCTC     | 0.5230   |

**Variants:** 12180 mutations, 12180 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 1077 nt | GAAG  | ACAG  |
| 3   | Oligo pool      | Tile 17 (12180 oligos) | 248 nt  | ACAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[ACAG]----oligo+BC----[AGAA]
   TGAA                   GAAG                   ACAG                  AGAA 
```

**Set fidelity:** 0.9406 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1    | 411 nt  | GCTC  | TTAC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1365 nt | TTAC  | CCTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1509 nt | CCTT  | AAAT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCTC]----3'WT sub1----[TTAC]----3'WT sub2----[CCTT]----3'WT sub3----[AAAT]----3'WT sub4----[CTCG]----3'WT sub5----[TACG]----3'WT+PolIII sub6----[CACC]
   GCTC                   TTAC                   CCTT                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (7 overhangs)

---

### Tile 18 of 52 -- Codons 994-1067 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTC     | 0.8105   |
| oh2 (3' boundary) | GAAG     | 0.6752   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1251 nt | GAAG  | TCTC  |
| 3   | Oligo pool      | Tile 18 (14280 oligos) | 278 nt  | TCTC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[TCTC]----oligo+BC----[AGAA]
   TGAA                   GAAG                   TCTC                  AGAA 
```

**Set fidelity:** 0.9406 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1    | 1542 nt | GAAG  | CCTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1509 nt | CCTT  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAG]----3'WT sub1----[CCTT]----3'WT sub2----[AAAT]----3'WT sub3----[CTCG]----3'WT sub4----[TACG]----3'WT+PolIII sub5----[CACC]
   GAAG                   CCTT                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 19 of 52 -- Codons 1062-1120 (177 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGC     | 0.5900   |
| oh2 (3' boundary) | GGAG     | 0.5228   |

**Variants:** 11340 mutations, 11340 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1455 nt | GAAG  | AAGC  |
| 3   | Oligo pool      | Tile 19 (11340 oligos) | 233 nt  | AAGC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AAGC]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AAGC                  AGAA 
```

**Set fidelity:** 0.9406 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1    | 1383 nt | GGAG  | CCTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1509 nt | CCTT  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAG]----3'WT sub1----[CCTT]----3'WT sub2----[AAAT]----3'WT sub3----[CTCG]----3'WT sub4----[TACG]----3'WT+PolIII sub5----[CACC]
   GGAG                   CCTT                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 20 of 52 -- Codons 1121-1193 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AACA     | 0.8032   |
| oh2 (3' boundary) | CAAA     | 0.8948   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1632 nt | GAAG  | AACA  |
| 3   | Oligo pool      | Tile 20 (14490 oligos) | 275 nt  | AACA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                  AGAA 
```

**Set fidelity:** 0.9406 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1    | 1164 nt | CAAA  | CCTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1509 nt | CCTT  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAA]----3'WT sub1----[CCTT]----3'WT sub2----[AAAT]----3'WT sub3----[CTCG]----3'WT sub4----[TACG]----3'WT+PolIII sub5----[CACC]
   CAAA                   CCTT                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 21 of 52 -- Codons 1188-1237 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACTG     | 0.5529   |
| oh2 (3' boundary) | GAAG     | 0.6752   |

**Variants:** 9240 mutations, 9240 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11       | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2  | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3  | 231 nt  | AACA  | ACTG  |
| 4   | Oligo pool      | Tile 21 (9240 oligos) | 206 nt  | ACTG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[ACTG]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   ACTG                  AGAA 
```

**Set fidelity:** 0.9406 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1    | 1032 nt | GAAG  | CCTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1509 nt | CCTT  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAG]----3'WT sub1----[CCTT]----3'WT sub2----[AAAT]----3'WT sub3----[CTCG]----3'WT sub4----[TACG]----3'WT+PolIII sub5----[CACC]
   GAAG                   CCTT                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 22 of 52 -- Codons 1232-1304 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTC     | 0.8105   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 363 nt  | AACA  | TCTC  |
| 4   | Oligo pool      | Tile 22 (14070 oligos) | 275 nt  | TCTC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[TCTC]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   TCTC                  AGAA 
```

**Set fidelity:** 0.9406 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1    | 831 nt  | TGAA  | CCTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1509 nt | CCTT  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[CCTT]----3'WT sub2----[AAAT]----3'WT sub3----[CTCG]----3'WT sub4----[TACG]----3'WT+PolIII sub5----[CACC]
   TGAA                   CCTT                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 23 of 52 -- Codons 1299-1366 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAGC     | 0.5446   |
| oh2 (3' boundary) | GCCA     | 0.5727   |

**Variants:** 13020 mutations, 13020 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 564 nt  | AACA  | GAGC  |
| 4   | Oligo pool      | Tile 23 (13020 oligos) | 260 nt  | GAGC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[GAGC]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   GAGC                  AGAA 
```

**Set fidelity:** 0.9406 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1    | 645 nt  | GCCA  | CCTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1509 nt | CCTT  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCCA]----3'WT sub1----[CCTT]----3'WT sub2----[AAAT]----3'WT sub3----[CTCG]----3'WT sub4----[TACG]----3'WT+PolIII sub5----[CACC]
   GCCA                   CCTT                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 24 of 52 -- Codons 1361-1436 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAT     | 0.7737   |
| oh2 (3' boundary) | TTTA     | 0.9147   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3   | 750 nt  | AACA  | AAAT  |
| 4   | Oligo pool      | Tile 24 (14700 oligos) | 284 nt  | AAAT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[AAAT]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   AAAT                  AGAA 
```

**Set fidelity:** 0.9406 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile24_sub1    | 435 nt  | TTTA  | CCTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1509 nt | CCTT  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTTA]----3'WT sub1----[CCTT]----3'WT sub2----[AAAT]----3'WT sub3----[CTCG]----3'WT sub4----[TACG]----3'WT+PolIII sub5----[CACC]
   TTTA                   CCTT                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 25 of 52 -- Codons 1431-1478 (144 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGT     | 0.7629   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 8820 mutations, 8820 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11       | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2  | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3  | 960 nt  | AACA  | AAGT  |
| 4   | Oligo pool      | Tile 25 (8820 oligos) | 200 nt  | AAGT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[AAGT]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   AAGT                  AGAA 
```

**Set fidelity:** 0.9406 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile25_sub1    | 309 nt  | TGAA  | CCTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1509 nt | CCTT  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[CCTT]----3'WT sub2----[AAAT]----3'WT sub3----[CTCG]----3'WT sub4----[TACG]----3'WT+PolIII sub5----[CACC]
   TGAA                   CCTT                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 26 of 52 -- Codons 1473-1519 (141 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTGG     | 0.5756   |
| oh2 (3' boundary) | TAGT     | 0.7437   |

**Variants:** 8610 mutations, 8610 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11       | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2  | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3  | 1086 nt | AACA  | CTGG  |
| 4   | Oligo pool      | Tile 26 (8610 oligos) | 197 nt  | CTGG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[CTGG]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   CTGG                  AGAA 
```

**Set fidelity:** 0.9406 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile26_sub1    | 1665 nt | TAGT  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAGT]----3'WT sub1----[AAAT]----3'WT sub2----[CTCG]----3'WT sub3----[TACG]----3'WT+PolIII sub4----[CACC]
   TAGT                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 27 of 52 -- Codons 1514-1565 (156 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGT     | 0.6822   |
| oh2 (3' boundary) | TTCA     | 0.8824   |

**Variants:** 9870 mutations, 9870 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11       | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2  | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3  | 1209 nt | AACA  | ATGT  |
| 4   | Oligo pool      | Tile 27 (9870 oligos) | 212 nt  | ATGT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[ATGT]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   ATGT                  AGAA 
```

**Set fidelity:** 0.9406 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile27_sub1    | 1527 nt | TTCA  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCA]----3'WT sub1----[AAAT]----3'WT sub2----[CTCG]----3'WT sub3----[TACG]----3'WT+PolIII sub4----[CACC]
   TTCA                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 28 of 52 -- Codons 1566-1643 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GATA     | 0.7029   |
| oh2 (3' boundary) | ACGG     | 0.4986   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1365 nt | AACA  | GATA  |
| 4   | Oligo pool      | Tile 28 (15540 oligos) | 290 nt  | GATA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[GATA]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   GATA                  AGAA 
```

**Set fidelity:** 0.9406 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile28_sub1    | 1293 nt | ACGG  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACGG]----3'WT sub1----[AAAT]----3'WT sub2----[CTCG]----3'WT sub3----[TACG]----3'WT+PolIII sub4----[CACC]
   ACGG                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 29 of 52 -- Codons 1638-1715 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTT     | 0.7664   |
| oh2 (3' boundary) | TTCA     | 0.8824   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile29_sub3   | 1581 nt | AACA  | ATTT  |
| 4   | Oligo pool      | Tile 29 (15120 oligos) | 290 nt  | ATTT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[ATTT]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   ATTT                  AGAA 
```

**Set fidelity:** 0.9406 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile29_sub1    | 1077 nt | TTCA  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCA]----3'WT sub1----[AAAT]----3'WT sub2----[CTCG]----3'WT sub3----[TACG]----3'WT+PolIII sub4----[CACC]
   TTCA                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 30 of 52 -- Codons 1710-1787 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTGG     | 0.5756   |
| oh2 (3' boundary) | CGGC     | 0.4309   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1365 nt | AACA  | GATA  |
| 4   | 5'WT gene block | bsai_5wt_tile30_sub4   | 462 nt  | GATA  | CTGG  |
| 5   | Oligo pool      | Tile 30 (15120 oligos) | 290 nt  | CTGG  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[GATA]----5'WT sub4----[CTGG]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   GATA                   CTGG                  AGAA 
```

**Set fidelity:** 0.9406 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile30_sub1    | 861 nt  | CGGC  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CGGC]----3'WT sub1----[AAAT]----3'WT sub2----[CTCG]----3'WT sub3----[TACG]----3'WT+PolIII sub4----[CACC]
   CGGC                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 31 of 52 -- Codons 1782-1857 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CGGC     | 0.4309   |
| oh2 (3' boundary) | AGAA     | 0.8847   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1365 nt | AACA  | GATA  |
| 4   | 5'WT gene block | bsai_5wt_tile31_sub4   | 678 nt  | GATA  | CGGC  |
| 5   | Oligo pool      | Tile 31 (14700 oligos) | 284 nt  | CGGC  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[GATA]----5'WT sub4----[CGGC]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   GATA                   CGGC                  AGAA 
```

**Set fidelity:** 0.9406 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile31_sub1    | 651 nt  | AGAA  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAA]----3'WT sub1----[AAAT]----3'WT sub2----[CTCG]----3'WT sub3----[TACG]----3'WT+PolIII sub4----[CACC]
   AGAA                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 32 of 52 -- Codons 1852-1909 (174 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGC     | 0.6171   |
| oh2 (3' boundary) | GCTC     | 0.5230   |

**Variants:** 10920 mutations, 10920 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1365 nt | AACA  | GATA  |
| 4   | 5'WT gene block | bsai_5wt_tile32_sub4   | 888 nt  | GATA  | ATGC  |
| 5   | Oligo pool      | Tile 32 (10920 oligos) | 230 nt  | ATGC  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[GATA]----5'WT sub4----[ATGC]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   GATA                   ATGC                  AGAA 
```

**Set fidelity:** 0.9406 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile32_sub1    | 495 nt  | GCTC  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1431 nt | AAAT  | CTCG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCTC]----3'WT sub1----[AAAT]----3'WT sub2----[CTCG]----3'WT sub3----[TACG]----3'WT+PolIII sub4----[CACC]
   GCTC                   AAAT                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 33 of 52 -- Codons 1904-1977 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCGA     | 0.6442   |
| oh2 (3' boundary) | ACTA     | 0.7946   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1365 nt | AACA  | GATA  |
| 4   | 5'WT gene block | bsai_5wt_tile33_sub4   | 1044 nt | GATA  | CCGA  |
| 5   | Oligo pool      | Tile 33 (14280 oligos) | 278 nt  | CCGA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[GATA]----5'WT sub4----[CCGA]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   GATA                   CCGA                  AGAA 
```

**Set fidelity:** 0.9406 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile33_sub1    | 1692 nt | ACTA  | CTCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACTA]----3'WT sub1----[CTCG]----3'WT sub2----[TACG]----3'WT+PolIII sub3----[CACC]
   ACTA                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 34 of 52 -- Codons 1972-2027 (168 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACG     | 0.6478   |
| oh2 (3' boundary) | CAGA     | 0.8175   |

**Variants:** 10500 mutations, 10500 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1365 nt | AACA  | GATA  |
| 4   | 5'WT gene block | bsai_5wt_tile34_sub4   | 1248 nt | GATA  | TACG  |
| 5   | Oligo pool      | Tile 34 (10500 oligos) | 224 nt  | TACG  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[GATA]----5'WT sub4----[TACG]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   GATA                   TACG                  AGAA 
```

**Set fidelity:** 0.9388 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile34_sub1    | 1542 nt | CAGA  | CTCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAGA]----3'WT sub1----[CTCG]----3'WT sub2----[TACG]----3'WT+PolIII sub3----[CACC]
   CAGA                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 35 of 52 -- Codons 2022-2058 (111 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTT     | 0.7664   |
| oh2 (3' boundary) | GTAC     | 0.5840   |

**Variants:** 6720 mutations, 6720 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11       | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2  | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3  | 1365 nt | AACA  | GATA  |
| 4   | 5'WT gene block | bsai_5wt_tile35_sub4  | 1398 nt | GATA  | ATTT  |
| 5   | Oligo pool      | Tile 35 (6720 oligos) | 167 nt  | ATTT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[GATA]----5'WT sub4----[ATTT]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   GATA                   ATTT                  AGAA 
```

**Set fidelity:** 0.9406 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile35_sub1    | 1449 nt | GTAC  | CTCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GTAC]----3'WT sub1----[CTCG]----3'WT sub2----[TACG]----3'WT+PolIII sub3----[CACC]
   GTAC                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 36 of 52 -- Codons 2059-2127 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATAG     | 0.7330   |
| oh2 (3' boundary) | AGAA     | 0.8847   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1365 nt | AACA  | GATA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4   | 1509 nt | GATA  | ATAG  |
| 5   | Oligo pool      | Tile 36 (13650 oligos) | 263 nt  | ATAG  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[GATA]----5'WT sub4----[ATAG]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   GATA                   ATAG                  AGAA 
```

**Set fidelity:** 0.9406 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile36_sub1    | 1242 nt | AGAA  | CTCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAA]----3'WT sub1----[CTCG]----3'WT sub2----[TACG]----3'WT+PolIII sub3----[CACC]
   AGAA                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 37 of 52 -- Codons 2122-2197 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGCC     | 0.4644   |
| oh2 (3' boundary) | ATTC     | 0.7084   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1365 nt | AACA  | GATA  |
| 4   | 5'WT gene block | bsai_5wt_tile37_sub4   | 1698 nt | GATA  | AGCC  |
| 5   | Oligo pool      | Tile 37 (14700 oligos) | 284 nt  | AGCC  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[GATA]----5'WT sub4----[AGCC]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   GATA                   AGCC                  AGAA 
```

**Set fidelity:** 0.9406 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile37_sub1    | 1032 nt | ATTC  | CTCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATTC]----3'WT sub1----[CTCG]----3'WT sub2----[TACG]----3'WT+PolIII sub3----[CACC]
   ATTC                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 38 of 52 -- Codons 2192-2253 (186 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAGC     | 0.5446   |
| oh2 (3' boundary) | TTCA     | 0.8824   |

**Variants:** 11760 mutations, 11760 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1365 nt | AACA  | GATA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4   | 1509 nt | GATA  | ATAG  |
| 5   | 5'WT gene block | bsai_5wt_tile38_sub5   | 429 nt  | ATAG  | GAGC  |
| 6   | Oligo pool      | Tile 38 (11760 oligos) | 242 nt  | GAGC  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[GATA]----5'WT sub4----[ATAG]----5'WT sub5----[GAGC]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   GATA                   ATAG                   GAGC                  AGAA 
```

**Set fidelity:** 0.9406 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile38_sub1    | 864 nt  | TTCA  | CTCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCA]----3'WT sub1----[CTCG]----3'WT sub2----[TACG]----3'WT+PolIII sub3----[CACC]
   TTCA                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 39 of 52 -- Codons 2248-2284 (111 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACCT     | 0.6222   |
| oh2 (3' boundary) | AATC     | 0.7116   |

**Variants:** 6510 mutations, 6510 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11       | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2  | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3  | 1365 nt | AACA  | GATA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4  | 1509 nt | GATA  | ATAG  |
| 5   | 5'WT gene block | bsai_5wt_tile39_sub5  | 597 nt  | ATAG  | ACCT  |
| 6   | Oligo pool      | Tile 39 (6510 oligos) | 167 nt  | ACCT  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[GATA]----5'WT sub4----[ATAG]----5'WT sub5----[ACCT]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   GATA                   ATAG                   ACCT                  AGAA 
```

**Set fidelity:** 0.9406 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile39_sub1    | 771 nt  | AATC  | CTCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AATC]----3'WT sub1----[CTCG]----3'WT sub2----[TACG]----3'WT+PolIII sub3----[CACC]
   AATC                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 40 of 52 -- Codons 2279-2345 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCCT     | 0.5289   |
| oh2 (3' boundary) | TGTC     | 0.6650   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1365 nt | AACA  | GATA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4   | 1509 nt | GATA  | ATAG  |
| 5   | 5'WT gene block | bsai_5wt_tile40_sub5   | 690 nt  | ATAG  | GCCT  |
| 6   | Oligo pool      | Tile 40 (12810 oligos) | 257 nt  | GCCT  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[GATA]----5'WT sub4----[ATAG]----5'WT sub5----[GCCT]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   GATA                   ATAG                   GCCT                  AGAA 
```

**Set fidelity:** 0.9406 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile40_sub1    | 588 nt  | TGTC  | CTCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGTC]----3'WT sub1----[CTCG]----3'WT sub2----[TACG]----3'WT+PolIII sub3----[CACC]
   TGTC                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 41 of 52 -- Codons 2340-2413 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CGGA     | 0.6609   |
| oh2 (3' boundary) | GAAG     | 0.6752   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1365 nt | AACA  | GATA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4   | 1509 nt | GATA  | ATAG  |
| 5   | 5'WT gene block | bsai_5wt_tile41_sub5   | 873 nt  | ATAG  | CGGA  |
| 6   | Oligo pool      | Tile 41 (14280 oligos) | 278 nt  | CGGA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[GATA]----5'WT sub4----[ATAG]----5'WT sub5----[CGGA]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   GATA                   ATAG                   CGGA                  AGAA 
```

**Set fidelity:** 0.9406 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile41_sub1    | 384 nt  | GAAG  | CTCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1362 nt | CTCG  | TACG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAG]----3'WT sub1----[CTCG]----3'WT sub2----[TACG]----3'WT+PolIII sub3----[CACC]
   GAAG                   CTCG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 42 of 52 -- Codons 2408-2473 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCGA     | 0.6442   |
| oh2 (3' boundary) | CTTC     | 0.6384   |

**Variants:** 12600 mutations, 12600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1365 nt | AACA  | GATA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4   | 1509 nt | GATA  | ATAG  |
| 5   | 5'WT gene block | bsai_5wt_tile42_sub5   | 1077 nt | ATAG  | CCGA  |
| 6   | Oligo pool      | Tile 42 (12600 oligos) | 254 nt  | CCGA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[GATA]----5'WT sub4----[ATAG]----5'WT sub5----[CCGA]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   GATA                   ATAG                   CCGA                  AGAA 
```

**Set fidelity:** 0.9406 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile42_sub1    | 1536 nt | CTTC  | TACG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTTC]----3'WT sub1----[TACG]----3'WT+PolIII sub2----[CACC]
   CTTC                   TACG                          CACC 
```

**Set fidelity:** 0.9984 (3 overhangs)

---

### Tile 43 of 52 -- Codons 2468-2525 (174 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTCG     | 0.7252   |
| oh2 (3' boundary) | CCGC     | 0.3775   |

**Variants:** 11130 mutations, 11130 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1365 nt | AACA  | GATA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4   | 1509 nt | GATA  | ATAG  |
| 5   | 5'WT gene block | bsai_5wt_tile43_sub5   | 1257 nt | ATAG  | CTCG  |
| 6   | Oligo pool      | Tile 43 (11130 oligos) | 230 nt  | CTCG  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[GATA]----5'WT sub4----[ATAG]----5'WT sub5----[CTCG]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   GATA                   ATAG                   CTCG                  AGAA 
```

**Set fidelity:** 0.9406 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile43_sub1    | 1380 nt | CCGC  | TACG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCGC]----3'WT sub1----[TACG]----3'WT+PolIII sub2----[CACC]
   CCGC                   TACG                          CACC 
```

**Set fidelity:** 0.9923 (3 overhangs)

---

### Tile 44 of 52 -- Codons 2526-2603 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGA     | 0.7549   |
| oh2 (3' boundary) | TGAG     | 0.6546   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1365 nt | AACA  | GATA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4   | 1509 nt | GATA  | ATAG  |
| 5   | 5'WT gene block | bsai_5wt_tile44_sub5   | 1431 nt | ATAG  | ATGA  |
| 6   | Oligo pool      | Tile 44 (15540 oligos) | 290 nt  | ATGA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[GATA]----5'WT sub4----[ATAG]----5'WT sub5----[ATGA]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   GATA                   ATAG                   ATGA                  AGAA 
```

**Set fidelity:** 0.9406 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile44_sub1    | 1146 nt | TGAG  | TACG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAG]----3'WT sub1----[TACG]----3'WT+PolIII sub2----[CACC]
   TGAG                   TACG                          CACC 
```

**Set fidelity:** 0.9982 (3 overhangs)

---

### Tile 45 of 52 -- Codons 2598-2654 (171 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGT     | 0.6512   |
| oh2 (3' boundary) | CAAG     | 0.6640   |

**Variants:** 10710 mutations, 10710 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1365 nt | AACA  | GATA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4   | 1509 nt | GATA  | ATAG  |
| 5   | 5'WT gene block | bsai_5wt_tile45_sub5   | 1647 nt | ATAG  | CAGT  |
| 6   | Oligo pool      | Tile 45 (10710 oligos) | 227 nt  | CAGT  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[GATA]----5'WT sub4----[ATAG]----5'WT sub5----[CAGT]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   GATA                   ATAG                   CAGT                  AGAA 
```

**Set fidelity:** 0.9406 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile45_sub1    | 993 nt  | CAAG  | TACG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAG]----3'WT sub1----[TACG]----3'WT+PolIII sub2----[CACC]
   CAAG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 46 of 52 -- Codons 2649-2722 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGCA     | 0.5273   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1365 nt | AACA  | GATA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4   | 1509 nt | GATA  | ATAG  |
| 5   | 5'WT gene block | bsai_5wt_tile44_sub5   | 1431 nt | ATAG  | ATGA  |
| 6   | 5'WT gene block | bsai_5wt_tile46_sub6   | 399 nt  | ATGA  | GGCA  |
| 7   | Oligo pool      | Tile 46 (14280 oligos) | 278 nt  | GGCA  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[GATA]----5'WT sub4----[ATAG]----5'WT sub5----[ATGA]----5'WT sub6----[GGCA]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   GATA                   ATAG                   ATGA                   GGCA                  AGAA 
```

**Set fidelity:** 0.9370 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile46_sub1    | 789 nt  | TGAA  | TACG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[TACG]----3'WT+PolIII sub2----[CACC]
   TGAA                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 47 of 52 -- Codons 2717-2792 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACCT     | 0.6222   |
| oh2 (3' boundary) | CTTT     | 0.6635   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1365 nt | AACA  | GATA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4   | 1509 nt | GATA  | ATAG  |
| 5   | 5'WT gene block | bsai_5wt_tile44_sub5   | 1431 nt | ATAG  | ATGA  |
| 6   | 5'WT gene block | bsai_5wt_tile47_sub6   | 603 nt  | ATGA  | ACCT  |
| 7   | Oligo pool      | Tile 47 (14700 oligos) | 284 nt  | ACCT  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[GATA]----5'WT sub4----[ATAG]----5'WT sub5----[ATGA]----5'WT sub6----[ACCT]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   GATA                   ATAG                   ATGA                   ACCT                  AGAA 
```

**Set fidelity:** 0.9406 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile47_sub1    | 579 nt  | CTTT  | TACG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTTT]----3'WT sub1----[TACG]----3'WT+PolIII sub2----[CACC]
   CTTT                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 48 of 52 -- Codons 2787-2848 (186 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACCT     | 0.6222   |
| oh2 (3' boundary) | CCAG     | 0.6122   |

**Variants:** 11760 mutations, 11760 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1365 nt | AACA  | GATA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4   | 1509 nt | GATA  | ATAG  |
| 5   | 5'WT gene block | bsai_5wt_tile44_sub5   | 1431 nt | ATAG  | ATGA  |
| 6   | 5'WT gene block | bsai_5wt_tile48_sub6   | 813 nt  | ATGA  | ACCT  |
| 7   | Oligo pool      | Tile 48 (11760 oligos) | 242 nt  | ACCT  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[GATA]----5'WT sub4----[ATAG]----5'WT sub5----[ATGA]----5'WT sub6----[ACCT]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   GATA                   ATAG                   ATGA                   ACCT                  AGAA 
```

**Set fidelity:** 0.9406 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile48_sub1    | 411 nt  | CCAG  | TACG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1493 nt | TACG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCAG]----3'WT sub1----[TACG]----3'WT+PolIII sub2----[CACC]
   CCAG                   TACG                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 49 of 52 -- Codons 2843-2920 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCC     | 0.6015   |
| oh2 (3' boundary) | GAAT     | 0.7246   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1365 nt | AACA  | GATA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4   | 1509 nt | GATA  | ATAG  |
| 5   | 5'WT gene block | bsai_5wt_tile44_sub5   | 1431 nt | ATAG  | ATGA  |
| 6   | 5'WT gene block | bsai_5wt_tile49_sub6   | 981 nt  | ATGA  | ATCC  |
| 7   | Oligo pool      | Tile 49 (15120 oligos) | 290 nt  | ATCC  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[GATA]----5'WT sub4----[ATAG]----5'WT sub5----[ATGA]----5'WT sub6----[ATCC]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   GATA                   ATAG                   ATGA                   ATCC                  AGAA 
```

**Set fidelity:** 0.9406 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile49_sub1    | 1658 nt | GAAT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAT]----3'WT+PolIII----[CACC]
   GAAT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 50 of 52 -- Codons 2915-2969 (165 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GACC     | 0.5155   |
| oh2 (3' boundary) | TGTC     | 0.6650   |

**Variants:** 10500 mutations, 10500 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1365 nt | AACA  | GATA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4   | 1509 nt | GATA  | ATAG  |
| 5   | 5'WT gene block | bsai_5wt_tile44_sub5   | 1431 nt | ATAG  | ATGA  |
| 6   | 5'WT gene block | bsai_5wt_tile50_sub6   | 1197 nt | ATGA  | GACC  |
| 7   | Oligo pool      | Tile 50 (10500 oligos) | 221 nt  | GACC  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[GATA]----5'WT sub4----[ATAG]----5'WT sub5----[ATGA]----5'WT sub6----[GACC]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   GATA                   ATAG                   ATGA                   GACC                  AGAA 
```

**Set fidelity:** 0.9389 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile50         | 1511 nt | TGTC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGTC]----3'WT+PolIII----[CACC]
   TGTC                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 51 of 52 -- Codons 2970-3039 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCC     | 0.7759   |
| oh2 (3' boundary) | TCCC     | 0.7759   |

**Variants:** 13860 mutations, 13860 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1365 nt | AACA  | GATA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4   | 1509 nt | GATA  | ATAG  |
| 5   | 5'WT gene block | bsai_5wt_tile44_sub5   | 1431 nt | ATAG  | ATGA  |
| 6   | 5'WT gene block | bsai_5wt_tile51_sub6   | 1362 nt | ATGA  | TCCC  |
| 7   | Oligo pool      | Tile 51 (13860 oligos) | 266 nt  | TCCC  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[GATA]----5'WT sub4----[ATAG]----5'WT sub5----[ATGA]----5'WT sub6----[TCCC]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   GATA                   ATAG                   ATGA                   TCCC                  AGAA 
```

**Set fidelity:** 0.9406 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile51         | 1301 nt | TCCC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCCC]----3'WT+PolIII----[CACC]
   TCCC                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 52 of 52 -- Codons 3034-3113 (242 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GACC     | 0.5155   |
| oh2 (3' boundary) | TTCT     | 0.8181   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | TGAA  | GAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1632 nt | GAAG  | AACA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1365 nt | AACA  | GATA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4   | 1509 nt | GATA  | ATAG  |
| 5   | 5'WT gene block | bsai_5wt_tile44_sub5   | 1431 nt | ATAG  | ATGA  |
| 6   | 5'WT gene block | bsai_5wt_tile52_sub6   | 1554 nt | ATGA  | GACC  |
| 7   | Oligo pool      | Tile 52 (12810 oligos) | 298 nt  | GACC  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[GAAG]----5'WT sub2----[AACA]----5'WT sub3----[GATA]----5'WT sub4----[ATAG]----5'WT sub5----[ATGA]----5'WT sub6----[GACC]----oligo+BC----[AGAA]
   TGAA                   GAAG                   AACA                   GATA                   ATAG                   ATGA                   GACC                  AGAA 
```

**Set fidelity:** 0.9389 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component            | Part name                | Length  | 5' OH | 3' OH |
| --- | -------------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product         | (in helper plasmid)      | --      | --    | --    |
| 2   | PolIII-only fragment | bsmbi_polIII_tile52      | 1077 nt | TTCT  | CACC  |
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

**Total blocks:** 109

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| --------------------- | ----------- | ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10       | 1594        | BsaI        | 5wt_tile10                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile11       | 1792        | BsaI        | 5wt_tile11;5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1;5wt_tile26_sub1;5wt_tile27_sub1;5wt_tile28_sub1;5wt_tile29_sub1;5wt_tile30_sub1;5wt_tile31_sub1;5wt_tile32_sub1;5wt_tile33_sub1;5wt_tile34_sub1;5wt_tile35_sub1;5wt_tile36_sub1;5wt_tile37_sub1;5wt_tile38_sub1;5wt_tile39_sub1;5wt_tile40_sub1;5wt_tile41_sub1;5wt_tile42_sub1;5wt_tile43_sub1;5wt_tile44_sub1;5wt_tile45_sub1;5wt_tile46_sub1;5wt_tile47_sub1;5wt_tile48_sub1;5wt_tile49_sub1;5wt_tile50_sub1;5wt_tile51_sub1;5wt_tile52_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile12_sub2  | 150         | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile13_sub2  | 330         | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile14_sub2  | 522         | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile15_sub2  | 711         | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile16_sub2  | 915         | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile17_sub2  | 1077        | BsaI        | 5wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile18_sub2  | 1251        | BsaI        | 5wt_tile18_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile19_sub2  | 1455        | BsaI        | 5wt_tile19_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile2        | 247         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile20_sub2  | 1632        | BsaI        | 5wt_tile20_sub2;5wt_tile21_sub2;5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2;5wt_tile26_sub2;5wt_tile27_sub2;5wt_tile28_sub2;5wt_tile29_sub2;5wt_tile30_sub2;5wt_tile31_sub2;5wt_tile32_sub2;5wt_tile33_sub2;5wt_tile34_sub2;5wt_tile35_sub2;5wt_tile36_sub2;5wt_tile37_sub2;5wt_tile38_sub2;5wt_tile39_sub2;5wt_tile40_sub2;5wt_tile41_sub2;5wt_tile42_sub2;5wt_tile43_sub2;5wt_tile44_sub2;5wt_tile45_sub2;5wt_tile46_sub2;5wt_tile47_sub2;5wt_tile48_sub2;5wt_tile49_sub2;5wt_tile50_sub2;5wt_tile51_sub2;5wt_tile52_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile21_sub3  | 231         | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile22_sub3  | 363         | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile23_sub3  | 564         | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile24_sub3  | 750         | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile25_sub3  | 960         | BsaI        | 5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile26_sub3  | 1086        | BsaI        | 5wt_tile26_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile27_sub3  | 1209        | BsaI        | 5wt_tile27_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile28_sub3  | 1365        | BsaI        | 5wt_tile28_sub3;5wt_tile30_sub3;5wt_tile31_sub3;5wt_tile32_sub3;5wt_tile33_sub3;5wt_tile34_sub3;5wt_tile35_sub3;5wt_tile36_sub3;5wt_tile37_sub3;5wt_tile38_sub3;5wt_tile39_sub3;5wt_tile40_sub3;5wt_tile41_sub3;5wt_tile42_sub3;5wt_tile43_sub3;5wt_tile44_sub3;5wt_tile45_sub3;5wt_tile46_sub3;5wt_tile47_sub3;5wt_tile48_sub3;5wt_tile49_sub3;5wt_tile50_sub3;5wt_tile51_sub3;5wt_tile52_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile29_sub3  | 1581        | BsaI        | 5wt_tile29_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile3        | 460         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile30_sub4  | 462         | BsaI        | 5wt_tile30_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile31_sub4  | 678         | BsaI        | 5wt_tile31_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile32_sub4  | 888         | BsaI        | 5wt_tile32_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile33_sub4  | 1044        | BsaI        | 5wt_tile33_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile34_sub4  | 1248        | BsaI        | 5wt_tile34_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile35_sub4  | 1398        | BsaI        | 5wt_tile35_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile36_sub4  | 1509        | BsaI        | 5wt_tile36_sub4;5wt_tile38_sub4;5wt_tile39_sub4;5wt_tile40_sub4;5wt_tile41_sub4;5wt_tile42_sub4;5wt_tile43_sub4;5wt_tile44_sub4;5wt_tile45_sub4;5wt_tile46_sub4;5wt_tile47_sub4;5wt_tile48_sub4;5wt_tile49_sub4;5wt_tile50_sub4;5wt_tile51_sub4;5wt_tile52_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile37_sub4  | 1698        | BsaI        | 5wt_tile37_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile38_sub5  | 429         | BsaI        | 5wt_tile38_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile39_sub5  | 597         | BsaI        | 5wt_tile39_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile4        | 652         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile40_sub5  | 690         | BsaI        | 5wt_tile40_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile41_sub5  | 873         | BsaI        | 5wt_tile41_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile42_sub5  | 1077        | BsaI        | 5wt_tile42_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile43_sub5  | 1257        | BsaI        | 5wt_tile43_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile44_sub5  | 1431        | BsaI        | 5wt_tile44_sub5;5wt_tile46_sub5;5wt_tile47_sub5;5wt_tile48_sub5;5wt_tile49_sub5;5wt_tile50_sub5;5wt_tile51_sub5;5wt_tile52_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile45_sub5  | 1647        | BsaI        | 5wt_tile45_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile46_sub6  | 399         | BsaI        | 5wt_tile46_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile47_sub6  | 603         | BsaI        | 5wt_tile47_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile48_sub6  | 813         | BsaI        | 5wt_tile48_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile49_sub6  | 981         | BsaI        | 5wt_tile49_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile5        | 799         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile50_sub6  | 1197        | BsaI        | 5wt_tile50_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile51_sub6  | 1362        | BsaI        | 5wt_tile51_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile52_sub6  | 1554        | BsaI        | 5wt_tile52_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile6        | 916         | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile7        | 1108        | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile8        | 1249        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile9        | 1405        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile1_sub1  | 1575        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile1_sub2  | 1632        | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile8_sub2;3wt_tile9_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile1_sub3  | 1365        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub3;3wt_tile9_sub3;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2;3wt_tile16_sub2;3wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile1_sub4  | 1509        | BsmBI       | 3wt_tile1_sub4;3wt_tile2_sub4;3wt_tile3_sub4;3wt_tile4_sub4;3wt_tile5_sub4;3wt_tile6_sub4;3wt_tile7_sub4;3wt_tile8_sub4;3wt_tile9_sub4;3wt_tile10_sub3;3wt_tile11_sub3;3wt_tile12_sub3;3wt_tile13_sub3;3wt_tile14_sub3;3wt_tile15_sub3;3wt_tile16_sub3;3wt_tile17_sub3;3wt_tile18_sub2;3wt_tile19_sub2;3wt_tile20_sub2;3wt_tile21_sub2;3wt_tile22_sub2;3wt_tile23_sub2;3wt_tile24_sub2;3wt_tile25_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile1_sub5  | 1431        | BsmBI       | 3wt_tile1_sub5;3wt_tile2_sub5;3wt_tile3_sub5;3wt_tile4_sub5;3wt_tile5_sub5;3wt_tile6_sub5;3wt_tile7_sub5;3wt_tile8_sub5;3wt_tile9_sub5;3wt_tile10_sub4;3wt_tile11_sub4;3wt_tile12_sub4;3wt_tile13_sub4;3wt_tile14_sub4;3wt_tile15_sub4;3wt_tile16_sub4;3wt_tile17_sub4;3wt_tile18_sub3;3wt_tile19_sub3;3wt_tile20_sub3;3wt_tile21_sub3;3wt_tile22_sub3;3wt_tile23_sub3;3wt_tile24_sub3;3wt_tile25_sub3;3wt_tile26_sub2;3wt_tile27_sub2;3wt_tile28_sub2;3wt_tile29_sub2;3wt_tile30_sub2;3wt_tile31_sub2;3wt_tile32_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile1_sub6  | 1362        | BsmBI       | 3wt_tile1_sub6;3wt_tile2_sub6;3wt_tile3_sub6;3wt_tile4_sub6;3wt_tile5_sub6;3wt_tile6_sub6;3wt_tile7_sub6;3wt_tile8_sub6;3wt_tile9_sub6;3wt_tile10_sub5;3wt_tile11_sub5;3wt_tile12_sub5;3wt_tile13_sub5;3wt_tile14_sub5;3wt_tile15_sub5;3wt_tile16_sub5;3wt_tile17_sub5;3wt_tile18_sub4;3wt_tile19_sub4;3wt_tile20_sub4;3wt_tile21_sub4;3wt_tile22_sub4;3wt_tile23_sub4;3wt_tile24_sub4;3wt_tile25_sub4;3wt_tile26_sub3;3wt_tile27_sub3;3wt_tile28_sub3;3wt_tile29_sub3;3wt_tile30_sub3;3wt_tile31_sub3;3wt_tile32_sub3;3wt_tile33_sub2;3wt_tile34_sub2;3wt_tile35_sub2;3wt_tile36_sub2;3wt_tile37_sub2;3wt_tile38_sub2;3wt_tile39_sub2;3wt_tile40_sub2;3wt_tile41_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile1_sub7  | 1493        | BsmBI       | 3wt_polIII_tile1_sub7;3wt_polIII_tile2_sub7;3wt_polIII_tile3_sub7;3wt_polIII_tile4_sub7;3wt_polIII_tile5_sub7;3wt_polIII_tile6_sub7;3wt_polIII_tile7_sub7;3wt_polIII_tile8_sub7;3wt_polIII_tile9_sub7;3wt_polIII_tile10_sub6;3wt_polIII_tile11_sub6;3wt_polIII_tile12_sub6;3wt_polIII_tile13_sub6;3wt_polIII_tile14_sub6;3wt_polIII_tile15_sub6;3wt_polIII_tile16_sub6;3wt_polIII_tile17_sub6;3wt_polIII_tile18_sub5;3wt_polIII_tile19_sub5;3wt_polIII_tile20_sub5;3wt_polIII_tile21_sub5;3wt_polIII_tile22_sub5;3wt_polIII_tile23_sub5;3wt_polIII_tile24_sub5;3wt_polIII_tile25_sub5;3wt_polIII_tile26_sub4;3wt_polIII_tile27_sub4;3wt_polIII_tile28_sub4;3wt_polIII_tile29_sub4;3wt_polIII_tile30_sub4;3wt_polIII_tile31_sub4;3wt_polIII_tile32_sub4;3wt_polIII_tile33_sub3;3wt_polIII_tile34_sub3;3wt_polIII_tile35_sub3;3wt_polIII_tile36_sub3;3wt_polIII_tile37_sub3;3wt_polIII_tile38_sub3;3wt_polIII_tile39_sub3;3wt_polIII_tile40_sub3;3wt_polIII_tile41_sub3;3wt_polIII_tile42_sub2;3wt_polIII_tile43_sub2;3wt_polIII_tile44_sub2;3wt_polIII_tile45_sub2;3wt_polIII_tile46_sub2;3wt_polIII_tile47_sub2;3wt_polIII_tile48_sub2 |
| bsmbi_3wt_tile10_sub1 | 1650        | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile11_sub1 | 1512        | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile12_sub1 | 1332        | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile13_sub1 | 1140        | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile14_sub1 | 951         | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile15_sub1 | 747         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile16_sub1 | 585         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile17_sub1 | 411         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile18_sub1 | 1542        | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile19_sub1 | 1383        | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile2_sub1  | 1362        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile20_sub1 | 1164        | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile21_sub1 | 1032        | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile22_sub1 | 831         | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile23_sub1 | 645         | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile24_sub1 | 435         | BsmBI       | 3wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile25_sub1 | 309         | BsmBI       | 3wt_tile25_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile26_sub1 | 1665        | BsmBI       | 3wt_tile26_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile27_sub1 | 1527        | BsmBI       | 3wt_tile27_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile28_sub1 | 1293        | BsmBI       | 3wt_tile28_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile29_sub1 | 1077        | BsmBI       | 3wt_tile29_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile3_sub1  | 1170        | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile30_sub1 | 861         | BsmBI       | 3wt_tile30_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile31_sub1 | 651         | BsmBI       | 3wt_tile31_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile32_sub1 | 495         | BsmBI       | 3wt_tile32_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile33_sub1 | 1692        | BsmBI       | 3wt_tile33_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile34_sub1 | 1542        | BsmBI       | 3wt_tile34_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile35_sub1 | 1449        | BsmBI       | 3wt_tile35_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile36_sub1 | 1242        | BsmBI       | 3wt_tile36_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile37_sub1 | 1032        | BsmBI       | 3wt_tile37_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile38_sub1 | 864         | BsmBI       | 3wt_tile38_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile39_sub1 | 771         | BsmBI       | 3wt_tile39_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile4_sub1  | 1023        | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile40_sub1 | 588         | BsmBI       | 3wt_tile40_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile41_sub1 | 384         | BsmBI       | 3wt_tile41_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile42_sub1 | 1536        | BsmBI       | 3wt_tile42_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile43_sub1 | 1380        | BsmBI       | 3wt_tile43_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile44_sub1 | 1146        | BsmBI       | 3wt_tile44_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile45_sub1 | 993         | BsmBI       | 3wt_tile45_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile46_sub1 | 789         | BsmBI       | 3wt_tile46_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile47_sub1 | 579         | BsmBI       | 3wt_tile47_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile48_sub1 | 411         | BsmBI       | 3wt_tile48_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile49_sub1 | 1658        | BsmBI       | 3wt_polIII_tile49_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile5_sub1  | 906         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile50      | 1511        | BsmBI       | 3wt_polIII_tile50                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile51      | 1301        | BsmBI       | 3wt_polIII_tile51                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile6_sub1  | 714         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile7_sub1  | 573         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile8_sub1  | 417         | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile9_sub1  | 228         | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_polIII_tile52   | 1077        | BsmBI       | polIII_tile52                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |

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

