# DMS-GG Assembly Report: TRIO

Generated: 2026-03-21 08:38:44
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                         |
| -------------------- | ----------------------------------------------------------------------------- |
| Gene name            | TRIO_NM_007118.4_CDS Homo sapiens triple functional domain protein (TRIO) CDS |
| CDS length           | 9294 nt (3098 codons)                                                         |
| Protein length       | 3097 aa                                                                       |
| Number of tiles      | 51                                                                            |
| Total variants       | 65016                                                                         |
| Total oligos         | 650160                                                                        |
| Oligo length range   | 161-290 nt                                                                    |
| Gene blocks to order | 107                                                                           |
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

**Total oligos:** 650160 | **Length range:** 161-290 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-76      | 15120  | 288 nt |
| 2    | 71-141    | 13650  | 269 nt |
| 3    | 136-212   | 14910  | 287 nt |
| 4    | 207-275   | 13230  | 263 nt |
| 5    | 270-343   | 14280  | 278 nt |
| 6    | 338-406   | 13230  | 263 nt |
| 7    | 401-435   | 6090   | 161 nt |
| 8    | 430-496   | 12810  | 257 nt |
| 9    | 491-565   | 14490  | 281 nt |
| 10   | 560-632   | 14070  | 275 nt |
| 11   | 627-700   | 14280  | 278 nt |
| 12   | 695-763   | 13230  | 263 nt |
| 13   | 758-810   | 9870   | 215 nt |
| 14   | 805-881   | 14910  | 287 nt |
| 15   | 876-939   | 12180  | 248 nt |
| 16   | 934-972   | 6930   | 173 nt |
| 17   | 967-1037  | 13650  | 269 nt |
| 18   | 1032-1083 | 9660   | 212 nt |
| 19   | 1078-1132 | 10290  | 221 nt |
| 20   | 1127-1204 | 15120  | 290 nt |
| 21   | 1199-1271 | 14070  | 275 nt |
| 22   | 1266-1337 | 13860  | 272 nt |
| 23   | 1332-1390 | 11130  | 233 nt |
| 24   | 1385-1462 | 15120  | 290 nt |
| 25   | 1457-1519 | 11970  | 245 nt |
| 26   | 1514-1571 | 10920  | 230 nt |
| 27   | 1566-1636 | 13650  | 269 nt |
| 28   | 1631-1708 | 15120  | 290 nt |
| 29   | 1703-1775 | 14070  | 275 nt |
| 30   | 1770-1833 | 12180  | 248 nt |
| 31   | 1828-1895 | 13020  | 260 nt |
| 32   | 1890-1966 | 14910  | 287 nt |
| 33   | 1961-2010 | 9240   | 206 nt |
| 34   | 2005-2063 | 11130  | 233 nt |
| 35   | 2058-2112 | 10290  | 221 nt |
| 36   | 2107-2179 | 14070  | 275 nt |
| 37   | 2174-2232 | 11130  | 233 nt |
| 38   | 2227-2287 | 11550  | 239 nt |
| 39   | 2282-2345 | 12180  | 248 nt |
| 40   | 2340-2405 | 12600  | 254 nt |
| 41   | 2400-2470 | 13650  | 269 nt |
| 42   | 2465-2536 | 13860  | 272 nt |
| 43   | 2531-2594 | 12180  | 248 nt |
| 44   | 2589-2651 | 11970  | 245 nt |
| 45   | 2646-2705 | 11340  | 236 nt |
| 46   | 2700-2777 | 15120  | 290 nt |
| 47   | 2772-2847 | 14700  | 284 nt |
| 48   | 2842-2903 | 11760  | 242 nt |
| 49   | 2898-2967 | 13440  | 266 nt |
| 50   | 2962-3037 | 14700  | 284 nt |
| 51   | 3032-3109 | 13230  | 290 nt |

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
| Total barcodes    | 650160                             |
| Unique barcodes   | 650160                             |
| GC content range  | 35% - 65%                          |
| GC content mean   | 48.5%                              |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                   | Description                                                   | Result | Detail                                                                                                                       |
| ----------------------- | ------------------------------------------------------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths           | All oligos within synthesis length limit                      | PASS   | Range: 161-290 nt (limit: 300)                                                                                               |
| block_lengths           | All gene blocks within synthesis length limit                 | PASS   | Range: 172-1795 nt (limit: 1800)                                                                                             |
| barcode_junction_sites  | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                      |
| barcode_uniqueness      | All barcodes are unique                                       | PASS   | 650160 unique / 650160 total                                                                                                 |
| tile_coverage           | Tiles cover entire gene without gaps                          | PASS   | 9294 / 9294 nt covered                                                                                                       |
| variant_count           | Expected number of variants generated                         | PASS   | 65016 unique variants (expected: 65016 across 3096/3096 mutable positions; 58824 missense + 3096 nonsense + 3096 wt_control) |
| single_codon_change     | Each non-control variant differs by exactly one codon from WT | PASS   | 619200 / 619200 variants confirmed (WT controls excluded)                                                                    |
| oligo_gc_content        | Oligo GC content within reasonable range (25-75%)             | FAIL   | GC range: 37.3-76.2% | 388 oligo(s) with extreme GC                                                                          |
| domestication_complete  | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                      |
| overhang_fidelity       | Tile boundary overhangs have adequate fidelity                | FAIL   | 50 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                      |
| tile_manifests          | Per-tile assembly manifests complete                          | PASS   | 51 tile manifest(s) generated                                                                                                |
| helper_plasmid          | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                           |
| reaction_fidelity       | Per-reaction set-level overhang fidelity                      | PASS   | Min set fidelity: 0.9121 across 102 reactions | 0 reaction(s) below 0.90                                                     |
| barcode_poliii_term     | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 650160 barcode(s) contain TTTT                                                                                           |
| barcode_hairpins        | No barcodes have hairpin stems > 3 bp                         | PASS   | 0 / 650160 barcode(s) have hairpin stems > 3 bp                                                                              |
| barcode_dinuc_repeats   | No barcodes have dinucleotide repeats > 4 units               | PASS   | 0 / 650160 barcode(s) exceed 4 dinuc repeat units                                                                            |
| barcode_tm_distribution | Barcode Tm distribution (informational)                       | PASS   | Tm: median=53.2, range=[41.4, 65.6], sd=4 C                                                                                  |
| block_min_length        | All gene blocks above synthesis minimum length                | FAIL   | 6 block(s) below 300 nt minimum. Range: 172-1795 nt                                                                          |
| sb_overhang_collisions  | Superblock boundary overhangs are unique (no collisions)      | PASS   | 12 SB boundary OH(s), all unique                                                                                             |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 8         | 0.9986             |
| 2    | 3        | 1.0000            | 8         | 0.9986             |
| 3    | 3        | 1.0000            | 8         | 1.0000             |
| 4    | 3        | 1.0000            | 8         | 1.0000             |
| 5    | 3        | 1.0000            | 8         | 1.0000             |
| 6    | 3        | 1.0000            | 7         | 1.0000             |
| 7    | 3        | 1.0000            | 7         | 1.0000             |
| 8    | 3        | 1.0000            | 7         | 1.0000             |
| 9    | 3        | 1.0000            | 7         | 1.0000             |
| 10   | 4        | 1.0000            | 7         | 1.0000             |
| 11   | 4        | 1.0000            | 7         | 0.9933             |
| 12   | 4        | 1.0000            | 7         | 0.9979             |
| 13   | 4        | 1.0000            | 7         | 1.0000             |
| 14   | 4        | 1.0000            | 7         | 1.0000             |
| 15   | 4        | 1.0000            | 6         | 1.0000             |
| 16   | 4        | 1.0000            | 6         | 1.0000             |
| 17   | 4        | 1.0000            | 6         | 1.0000             |
| 18   | 5        | 0.9957            | 6         | 1.0000             |
| 19   | 5        | 1.0000            | 5         | 1.0000             |
| 20   | 5        | 1.0000            | 6         | 1.0000             |
| 21   | 5        | 1.0000            | 6         | 1.0000             |
| 22   | 5        | 1.0000            | 6         | 1.0000             |
| 23   | 5        | 1.0000            | 6         | 1.0000             |
| 24   | 5        | 1.0000            | 6         | 1.0000             |
| 25   | 5        | 1.0000            | 5         | 1.0000             |
| 26   | 5        | 1.0000            | 5         | 1.0000             |
| 27   | 6        | 1.0000            | 5         | 1.0000             |
| 28   | 6        | 1.0000            | 5         | 1.0000             |
| 29   | 6        | 0.9975            | 5         | 1.0000             |
| 30   | 6        | 1.0000            | 5         | 0.9418             |
| 31   | 6        | 1.0000            | 5         | 1.0000             |
| 32   | 6        | 1.0000            | 5         | 0.9945             |
| 33   | 6        | 1.0000            | 4         | 0.9884             |
| 34   | 6        | 0.9978            | 4         | 1.0000             |
| 35   | 6        | 1.0000            | 4         | 1.0000             |
| 36   | 6        | 1.0000            | 4         | 1.0000             |
| 37   | 7        | 1.0000            | 4         | 1.0000             |
| 38   | 7        | 1.0000            | 4         | 1.0000             |
| 39   | 7        | 1.0000            | 4         | 1.0000             |
| 40   | 7        | 1.0000            | 4         | 1.0000             |
| 41   | 7        | 1.0000            | 4         | 1.0000             |
| 42   | 7        | 1.0000            | 3         | 1.0000             |
| 43   | 7        | 1.0000            | 3         | 1.0000             |
| 44   | 7        | 1.0000            | 3         | 0.9121             |
| 45   | 8        | 1.0000            | 3         | 0.9644             |
| 46   | 8        | 1.0000            | 3         | 1.0000             |
| 47   | 8        | 1.0000            | 3         | 0.9923             |
| 48   | 8        | 1.0000            | 3         | 1.0000             |
| 49   | 8        | 1.0000            | 3         | 1.0000             |
| 50   | 8        | 1.0000            | 2         | 1.0000             |
| 51   | 8        | 0.9957            | 2         | 1.0000             |

**Min:** 0.9121 | **Max:** 1.0000 | **Mean:** 0.9977

### 5c. Borderline Overhang Pairs

The following overhang pairs are at exactly the max_identity threshold (2/4). They are compatible but represent the tightest margin before collision:

| Tile | Reaction | OH A | OH B            | Identity | Type   |
| ---- | -------- | ---- | --------------- | -------- | ------ |
| 1    | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 1    | BsmBI    | CACC | CAAT            | 2/4      | direct |
| 1    | BsmBI    | CACC | CTCG            | 2/4      | direct |
| 1    | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 1    | BsmBI    | CCTT | CAAT            | 2/4      | direct |
| 1    | BsmBI    | CCTT | TAGT (RC: ACTA) | 2/4      | RC     |
| 1    | BsmBI    | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 1    | BsmBI    | CAAT | TAGT            | 2/4      | direct |
| 1    | BsmBI    | CTCG | GTCC            | 2/4      | direct |
| 1    | BsmBI    | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 1    | BsmBI    | TAGT | AAGA            | 2/4      | direct |
| 1    | BsmBI    | TAGT | AAGA (RC: TCTT) | 2/4      | RC     |
| 1    | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 2    | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 2    | BsaI     | AAGA | GAAA            | 2/4      | direct |
| 2    | BsaI     | AGAA | GAAA            | 2/4      | direct |
| 2    | BsmBI    | CACC | CAAT            | 2/4      | direct |
| 2    | BsmBI    | CACC | CTCG            | 2/4      | direct |
| 2    | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 2    | BsmBI    | CCTT | CAAT            | 2/4      | direct |
| 2    | BsmBI    | CCTT | TAGT (RC: ACTA) | 2/4      | RC     |
| 2    | BsmBI    | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 2    | BsmBI    | CAAT | TAGT            | 2/4      | direct |
| 2    | BsmBI    | CTCG | GTCC            | 2/4      | direct |
| 2    | BsmBI    | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 2    | BsmBI    | TAGT | AAGA            | 2/4      | direct |
| 2    | BsmBI    | TAGT | AAGA (RC: TCTT) | 2/4      | RC     |
| 2    | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 3    | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 3    | BsaI     | AGAA | GACT (RC: AGTC) | 2/4      | RC     |
| 3    | BsmBI    | CACC | CAAT            | 2/4      | direct |
| 3    | BsmBI    | CACC | CTCG            | 2/4      | direct |
| 3    | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 3    | BsmBI    | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 3    | BsmBI    | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 3    | BsmBI    | AGAA | TCAA            | 2/4      | direct |
| 3    | BsmBI    | AGAA | GTCC (RC: GGAC) | 2/4      | RC     |
| 3    | BsmBI    | AGAA | AAGA            | 2/4      | direct |
| 3    | BsmBI    | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 3    | BsmBI    | CAAT | TAGT            | 2/4      | direct |
| 3    | BsmBI    | CTCG | GTCC            | 2/4      | direct |
| 3    | BsmBI    | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 3    | BsmBI    | TAGT | AAGA            | 2/4      | direct |
| 3    | BsmBI    | TAGT | AAGA (RC: TCTT) | 2/4      | RC     |
| 3    | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 4    | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 4    | BsmBI    | CACC | CCTG (RC: CAGG) | 2/4      | RC     |
| 4    | BsmBI    | CACC | CAAT            | 2/4      | direct |
| 4    | BsmBI    | CACC | CTCG            | 2/4      | direct |
| 4    | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 4    | BsmBI    | CCTG | CAAT (RC: ATTG) | 2/4      | RC     |
| 4    | BsmBI    | CCTG | CTCG            | 2/4      | direct |
| 4    | BsmBI    | CCTG | CTCG (RC: CGAG) | 2/4      | RC     |
| 4    | BsmBI    | CCTG | TAGT (RC: ACTA) | 2/4      | RC     |
| 4    | BsmBI    | CCTG | AAGA (RC: TCTT) | 2/4      | RC     |
| 4    | BsmBI    | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 4    | BsmBI    | CAAT | TAGT            | 2/4      | direct |
| 4    | BsmBI    | CTCG | GTCC            | 2/4      | direct |
| 4    | BsmBI    | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 4    | BsmBI    | TAGT | AAGA            | 2/4      | direct |
| 4    | BsmBI    | TAGT | AAGA (RC: TCTT) | 2/4      | RC     |
| 4    | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 5    | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 5    | BsmBI    | CACC | GAGG (RC: CCTC) | 2/4      | RC     |
| 5    | BsmBI    | CACC | CAAT            | 2/4      | direct |
| 5    | BsmBI    | CACC | CTCG            | 2/4      | direct |
| 5    | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 5    | BsmBI    | GAGG | TAGT            | 2/4      | direct |
| 5    | BsmBI    | GAGG | AAGA            | 2/4      | direct |
| 5    | BsmBI    | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 5    | BsmBI    | CAAT | TAGT            | 2/4      | direct |
| 5    | BsmBI    | CTCG | GTCC            | 2/4      | direct |
| 5    | BsmBI    | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 5    | BsmBI    | TAGT | AAGA            | 2/4      | direct |
| 5    | BsmBI    | TAGT | AAGA (RC: TCTT) | 2/4      | RC     |
| 5    | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 6    | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 6    | BsaI     | AAGA | CAGT            | 2/4      | direct |
| 6    | BsmBI    | CACC | CAAT            | 2/4      | direct |
| 6    | BsmBI    | CACC | CTCG            | 2/4      | direct |
| 6    | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 6    | BsmBI    | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 6    | BsmBI    | CAAT | TAGT            | 2/4      | direct |
| 6    | BsmBI    | CTCG | GTCC            | 2/4      | direct |
| 6    | BsmBI    | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 6    | BsmBI    | TAGT | AAGA            | 2/4      | direct |
| 6    | BsmBI    | TAGT | AAGA (RC: TCTT) | 2/4      | RC     |
| 6    | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 7    | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 7    | BsaI     | AAGA | ATCA            | 2/4      | direct |
| 7    | BsaI     | AGAA | ATCA            | 2/4      | direct |
| 7    | BsaI     | AGAA | ATCA (RC: TGAT) | 2/4      | RC     |
| 7    | BsmBI    | CACC | GGCA (RC: TGCC) | 2/4      | RC     |
| 7    | BsmBI    | CACC | CTCG            | 2/4      | direct |
| 7    | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 7    | BsmBI    | GGCA | GTCC            | 2/4      | direct |
| 7    | BsmBI    | GGCA | GTCC (RC: GGAC) | 2/4      | RC     |
| 7    | BsmBI    | CTCG | GTCC            | 2/4      | direct |
| 7    | BsmBI    | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 7    | BsmBI    | TAGT | AAGA            | 2/4      | direct |
| 7    | BsmBI    | TAGT | AAGA (RC: TCTT) | 2/4      | RC     |
| 7    | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 8    | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 8    | BsaI     | AAGA | TGGA            | 2/4      | direct |
| 8    | BsaI     | AGAA | TGGA            | 2/4      | direct |
| 8    | BsmBI    | CACC | CTCG            | 2/4      | direct |
| 8    | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 8    | BsmBI    | TCTT | TAGT            | 2/4      | direct |
| 8    | BsmBI    | TCTT | TAGT (RC: ACTA) | 2/4      | RC     |
| 8    | BsmBI    | TCTT | TCAA            | 2/4      | direct |
| 8    | BsmBI    | CTCG | GTCC            | 2/4      | direct |
| 8    | BsmBI    | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 8    | BsmBI    | TAGT | AAGA            | 2/4      | direct |
| 8    | BsmBI    | TAGT | AAGA (RC: TCTT) | 2/4      | RC     |
| 8    | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 9    | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 9    | BsaI     | AAGA | TATG (RC: CATA) | 2/4      | RC     |
| 9    | BsmBI    | CACC | GAGG (RC: CCTC) | 2/4      | RC     |
| 9    | BsmBI    | CACC | CTCG            | 2/4      | direct |
| 9    | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 9    | BsmBI    | GAGG | TAGT            | 2/4      | direct |
| 9    | BsmBI    | GAGG | AAGA            | 2/4      | direct |
| 9    | BsmBI    | CTCG | GTCC            | 2/4      | direct |
| 9    | BsmBI    | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 9    | BsmBI    | TAGT | AAGA            | 2/4      | direct |
| 9    | BsmBI    | TAGT | AAGA (RC: TCTT) | 2/4      | RC     |
| 9    | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 10   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 10   | BsaI     | AGAA | GTCC (RC: GGAC) | 2/4      | RC     |
| 10   | BsmBI    | CACC | CTCG            | 2/4      | direct |
| 10   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 10   | BsmBI    | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 10   | BsmBI    | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 10   | BsmBI    | AGAA | TCAA            | 2/4      | direct |
| 10   | BsmBI    | AGAA | GTCC (RC: GGAC) | 2/4      | RC     |
| 10   | BsmBI    | AGAA | AAGA            | 2/4      | direct |
| 10   | BsmBI    | CTCG | GTCC            | 2/4      | direct |
| 10   | BsmBI    | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 10   | BsmBI    | TAGT | AAGA            | 2/4      | direct |
| 10   | BsmBI    | TAGT | AAGA (RC: TCTT) | 2/4      | RC     |
| 10   | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 11   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 11   | BsaI     | AGAA | TTAC (RC: GTAA) | 2/4      | RC     |
| 11   | BsmBI    | CACC | TGCC            | 2/4      | direct |
| 11   | BsmBI    | CACC | CTCG            | 2/4      | direct |
| 11   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 11   | BsmBI    | TGCC | GTCC            | 2/4      | direct |
| 11   | BsmBI    | TGCC | GTCC (RC: GGAC) | 2/4      | RC     |
| 11   | BsmBI    | CTCG | GTCC            | 2/4      | direct |
| 11   | BsmBI    | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 11   | BsmBI    | TAGT | AAGA            | 2/4      | direct |
| 11   | BsmBI    | TAGT | AAGA (RC: TCTT) | 2/4      | RC     |
| 11   | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 12   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 12   | BsaI     | CAAT | CTGG (RC: CCAG) | 2/4      | RC     |
| 12   | BsmBI    | CACC | GCAG (RC: CTGC) | 2/4      | RC     |
| 12   | BsmBI    | CACC | CTCG            | 2/4      | direct |
| 12   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 12   | BsmBI    | GCAG | CTCG (RC: CGAG) | 2/4      | RC     |
| 12   | BsmBI    | GCAG | TCAA            | 2/4      | direct |
| 12   | BsmBI    | GCAG | GTCC (RC: GGAC) | 2/4      | RC     |
| 12   | BsmBI    | CTCG | GTCC            | 2/4      | direct |
| 12   | BsmBI    | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 12   | BsmBI    | TAGT | AAGA            | 2/4      | direct |
| 12   | BsmBI    | TAGT | AAGA (RC: TCTT) | 2/4      | RC     |
| 12   | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 13   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 13   | BsaI     | AAGA | GAAA            | 2/4      | direct |
| 13   | BsaI     | AGAA | GAAA            | 2/4      | direct |
| 13   | BsaI     | CAAT | GAAA            | 2/4      | direct |
| 13   | BsmBI    | CACC | CTCG            | 2/4      | direct |
| 13   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 13   | BsmBI    | TTCT | CTCG            | 2/4      | direct |
| 13   | BsmBI    | TTCT | TAGT            | 2/4      | direct |
| 13   | BsmBI    | TTCT | TCAA (RC: TTGA) | 2/4      | RC     |
| 13   | BsmBI    | TTCT | GTCC            | 2/4      | direct |
| 13   | BsmBI    | TTCT | AAGA (RC: TCTT) | 2/4      | RC     |
| 13   | BsmBI    | CTCG | GTCC            | 2/4      | direct |
| 13   | BsmBI    | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 13   | BsmBI    | TAGT | AAGA            | 2/4      | direct |
| 13   | BsmBI    | TAGT | AAGA (RC: TCTT) | 2/4      | RC     |
| 13   | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 14   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 14   | BsaI     | AAGA | TGGA            | 2/4      | direct |
| 14   | BsaI     | AGAA | TGGA            | 2/4      | direct |
| 14   | BsmBI    | CACC | CCTG (RC: CAGG) | 2/4      | RC     |
| 14   | BsmBI    | CACC | CTCG            | 2/4      | direct |
| 14   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 14   | BsmBI    | CCTG | CTCG            | 2/4      | direct |
| 14   | BsmBI    | CCTG | CTCG (RC: CGAG) | 2/4      | RC     |
| 14   | BsmBI    | CCTG | TAGT (RC: ACTA) | 2/4      | RC     |
| 14   | BsmBI    | CCTG | AAGA (RC: TCTT) | 2/4      | RC     |
| 14   | BsmBI    | CTCG | GTCC            | 2/4      | direct |
| 14   | BsmBI    | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 14   | BsmBI    | TAGT | AAGA            | 2/4      | direct |
| 14   | BsmBI    | TAGT | AAGA (RC: TCTT) | 2/4      | RC     |
| 14   | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 15   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 15   | BsaI     | AAGA | ACTC (RC: GAGT) | 2/4      | RC     |
| 15   | BsaI     | CAAT | ACTC (RC: GAGT) | 2/4      | RC     |
| 15   | BsmBI    | CACC | CTCG            | 2/4      | direct |
| 15   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 15   | BsmBI    | CTCG | GTCC            | 2/4      | direct |
| 15   | BsmBI    | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 15   | BsmBI    | TAGT | AAGA            | 2/4      | direct |
| 15   | BsmBI    | TAGT | AAGA (RC: TCTT) | 2/4      | RC     |
| 15   | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 16   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 16   | BsaI     | CAAT | CTTA (RC: TAAG) | 2/4      | RC     |
| 16   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 16   | BsmBI    | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 16   | BsmBI    | AGAA | TCAA            | 2/4      | direct |
| 16   | BsmBI    | AGAA | GTCC (RC: GGAC) | 2/4      | RC     |
| 16   | BsmBI    | AGAA | AAGA            | 2/4      | direct |
| 16   | BsmBI    | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 16   | BsmBI    | TAGT | AAGA            | 2/4      | direct |
| 16   | BsmBI    | TAGT | AAGA (RC: TCTT) | 2/4      | RC     |
| 16   | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 17   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 17   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 17   | BsmBI    | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 17   | BsmBI    | AGAA | TCAA            | 2/4      | direct |
| 17   | BsmBI    | AGAA | GTCC (RC: GGAC) | 2/4      | RC     |
| 17   | BsmBI    | AGAA | AAGA            | 2/4      | direct |
| 17   | BsmBI    | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 17   | BsmBI    | TAGT | AAGA            | 2/4      | direct |
| 17   | BsmBI    | TAGT | AAGA (RC: TCTT) | 2/4      | RC     |
| 17   | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 18   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 18   | BsaI     | AAGA | CAGG            | 2/4      | direct |
| 18   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 18   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 18   | BsaI     | CAAT | CAGG            | 2/4      | direct |
| 18   | BsaI     | CTCG | CAGG            | 2/4      | direct |
| 18   | BsaI     | CTCG | CAGG (RC: CCTG) | 2/4      | RC     |
| 18   | BsmBI    | CACC | CGTC            | 2/4      | direct |
| 18   | BsmBI    | CACC | CGTC (RC: GACG) | 2/4      | RC     |
| 18   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 18   | BsmBI    | CGTC | GTCC (RC: GGAC) | 2/4      | RC     |
| 18   | BsmBI    | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 18   | BsmBI    | TAGT | AAGA            | 2/4      | direct |
| 18   | BsmBI    | TAGT | AAGA (RC: TCTT) | 2/4      | RC     |
| 18   | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 19   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 19   | BsaI     | AAGA | CGGA            | 2/4      | direct |
| 19   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 19   | BsaI     | AGAA | CGGA            | 2/4      | direct |
| 19   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 19   | BsaI     | CTCG | CGGA (RC: TCCG) | 2/4      | RC     |
| 19   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 19   | BsmBI    | AAGA | TAGT            | 2/4      | direct |
| 19   | BsmBI    | AAGA | TAGT (RC: ACTA) | 2/4      | RC     |
| 19   | BsmBI    | AAGA | TCAA (RC: TTGA) | 2/4      | RC     |
| 19   | BsmBI    | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 20   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 20   | BsaI     | AAGA | TGGA            | 2/4      | direct |
| 20   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 20   | BsaI     | AGAA | TGGA            | 2/4      | direct |
| 20   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 20   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 20   | BsmBI    | TGAT | TAGT            | 2/4      | direct |
| 20   | BsmBI    | TGAT | TCAA            | 2/4      | direct |
| 20   | BsmBI    | TGAT | GTCC (RC: GGAC) | 2/4      | RC     |
| 20   | BsmBI    | TGAT | AAGA (RC: TCTT) | 2/4      | RC     |
| 20   | BsmBI    | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 20   | BsmBI    | TAGT | AAGA            | 2/4      | direct |
| 20   | BsmBI    | TAGT | AAGA (RC: TCTT) | 2/4      | RC     |
| 20   | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 21   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 21   | BsaI     | AAGA | TTGA            | 2/4      | direct |
| 21   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 21   | BsaI     | AGAA | TTGA (RC: TCAA) | 2/4      | RC     |
| 21   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 21   | BsmBI    | CACC | CTCA            | 2/4      | direct |
| 21   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 21   | BsmBI    | CTCA | TCAA (RC: TTGA) | 2/4      | RC     |
| 21   | BsmBI    | CTCA | GTCC            | 2/4      | direct |
| 21   | BsmBI    | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 21   | BsmBI    | TAGT | AAGA            | 2/4      | direct |
| 21   | BsmBI    | TAGT | AAGA (RC: TCTT) | 2/4      | RC     |
| 21   | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 22   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 22   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 22   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 22   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 22   | BsmBI    | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 22   | BsmBI    | AGAA | TCAA            | 2/4      | direct |
| 22   | BsmBI    | AGAA | GTCC (RC: GGAC) | 2/4      | RC     |
| 22   | BsmBI    | AGAA | AAGA            | 2/4      | direct |
| 22   | BsmBI    | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 22   | BsmBI    | TAGT | AAGA            | 2/4      | direct |
| 22   | BsmBI    | TAGT | AAGA (RC: TCTT) | 2/4      | RC     |
| 22   | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 23   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 23   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 23   | BsaI     | AGAA | GGCA            | 2/4      | direct |
| 23   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 23   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 23   | BsmBI    | TAAG | TAGT            | 2/4      | direct |
| 23   | BsmBI    | TAAG | TCAA            | 2/4      | direct |
| 23   | BsmBI    | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 23   | BsmBI    | TAGT | AAGA            | 2/4      | direct |
| 23   | BsmBI    | TAGT | AAGA (RC: TCTT) | 2/4      | RC     |
| 23   | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 24   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 24   | BsaI     | AAGA | ACAT (RC: ATGT) | 2/4      | RC     |
| 24   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 24   | BsaI     | AGAA | ACAT            | 2/4      | direct |
| 24   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 24   | BsaI     | CAAT | ACAT            | 2/4      | direct |
| 24   | BsmBI    | CACC | GAAG (RC: CTTC) | 2/4      | RC     |
| 24   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 24   | BsmBI    | GAAG | GTCC (RC: GGAC) | 2/4      | RC     |
| 24   | BsmBI    | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 24   | BsmBI    | TAGT | AAGA            | 2/4      | direct |
| 24   | BsmBI    | TAGT | AAGA (RC: TCTT) | 2/4      | RC     |
| 24   | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 25   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 25   | BsaI     | AAGA | ATGC            | 2/4      | direct |
| 25   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 25   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 25   | BsaI     | CAAT | ATGC (RC: GCAT) | 2/4      | RC     |
| 25   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 25   | BsmBI    | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 25   | BsmBI    | TAGT | AAGA            | 2/4      | direct |
| 25   | BsmBI    | TAGT | AAGA (RC: TCTT) | 2/4      | RC     |
| 25   | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 26   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 26   | BsaI     | AAGA | ATGT            | 2/4      | direct |
| 26   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 26   | BsaI     | AGAA | ATGT (RC: ACAT) | 2/4      | RC     |
| 26   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 26   | BsaI     | CAAT | ATGT (RC: ACAT) | 2/4      | RC     |
| 26   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 26   | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 27   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 27   | BsaI     | AAGA | TAGT            | 2/4      | direct |
| 27   | BsaI     | AAGA | TAGT (RC: ACTA) | 2/4      | RC     |
| 27   | BsaI     | AAGA | GATA            | 2/4      | direct |
| 27   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 27   | BsaI     | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 27   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 27   | BsaI     | CAAT | TAGT            | 2/4      | direct |
| 27   | BsaI     | TAGT | GATA (RC: TATC) | 2/4      | RC     |
| 27   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 27   | BsmBI    | TGAT | TCAA            | 2/4      | direct |
| 27   | BsmBI    | TGAT | GTCC (RC: GGAC) | 2/4      | RC     |
| 27   | BsmBI    | TGAT | AAGA (RC: TCTT) | 2/4      | RC     |
| 27   | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 28   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 28   | BsaI     | AAGA | TAGT            | 2/4      | direct |
| 28   | BsaI     | AAGA | TAGT (RC: ACTA) | 2/4      | RC     |
| 28   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 28   | BsaI     | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 28   | BsaI     | AGAA | GGCA            | 2/4      | direct |
| 28   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 28   | BsaI     | CAAT | TAGT            | 2/4      | direct |
| 28   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 28   | BsmBI    | AGAA | TCAA            | 2/4      | direct |
| 28   | BsmBI    | AGAA | GTCC (RC: GGAC) | 2/4      | RC     |
| 28   | BsmBI    | AGAA | AAGA            | 2/4      | direct |
| 28   | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 29   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 29   | BsaI     | AAGA | TAGT            | 2/4      | direct |
| 29   | BsaI     | AAGA | TAGT (RC: ACTA) | 2/4      | RC     |
| 29   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 29   | BsaI     | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 29   | BsaI     | AGAA | CGCT (RC: AGCG) | 2/4      | RC     |
| 29   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 29   | BsaI     | CAAT | TAGT            | 2/4      | direct |
| 29   | BsaI     | CAAT | CGCT            | 2/4      | direct |
| 29   | BsaI     | CTCG | CGCT            | 2/4      | direct |
| 29   | BsaI     | CTCG | CGCT (RC: AGCG) | 2/4      | RC     |
| 29   | BsmBI    | CACC | CAAG            | 2/4      | direct |
| 29   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 29   | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 30   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 30   | BsaI     | AAGA | TAGT            | 2/4      | direct |
| 30   | BsaI     | AAGA | TAGT (RC: ACTA) | 2/4      | RC     |
| 30   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 30   | BsaI     | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 30   | BsaI     | AGAA | GGCA            | 2/4      | direct |
| 30   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 30   | BsaI     | CAAT | TAGT            | 2/4      | direct |
| 30   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 30   | BsmBI    | GAGA | TCAA (RC: TTGA) | 2/4      | RC     |
| 30   | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 31   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 31   | BsaI     | AAGA | TAGT            | 2/4      | direct |
| 31   | BsaI     | AAGA | TAGT (RC: ACTA) | 2/4      | RC     |
| 31   | BsaI     | AAGA | GAAA            | 2/4      | direct |
| 31   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 31   | BsaI     | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 31   | BsaI     | AGAA | GAAA            | 2/4      | direct |
| 31   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 31   | BsaI     | CAAT | TAGT            | 2/4      | direct |
| 31   | BsaI     | CAAT | GAAA            | 2/4      | direct |
| 31   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 31   | BsmBI    | ATTA | TCAA (RC: TTGA) | 2/4      | RC     |
| 31   | BsmBI    | ATTA | AAGA            | 2/4      | direct |
| 31   | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 32   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 32   | BsaI     | AAGA | TAGT            | 2/4      | direct |
| 32   | BsaI     | AAGA | TAGT (RC: ACTA) | 2/4      | RC     |
| 32   | BsaI     | AAGA | GCCT (RC: AGGC) | 2/4      | RC     |
| 32   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 32   | BsaI     | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 32   | BsaI     | AGAA | GCCT (RC: AGGC) | 2/4      | RC     |
| 32   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 32   | BsaI     | CAAT | TAGT            | 2/4      | direct |
| 32   | BsmBI    | CACC | CTCT            | 2/4      | direct |
| 32   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 32   | BsmBI    | CTCT | GTCC            | 2/4      | direct |
| 32   | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 33   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 33   | BsaI     | AAGA | TAGT            | 2/4      | direct |
| 33   | BsaI     | AAGA | TAGT (RC: ACTA) | 2/4      | RC     |
| 33   | BsaI     | AAGA | GAAA            | 2/4      | direct |
| 33   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 33   | BsaI     | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 33   | BsaI     | AGAA | GAAA            | 2/4      | direct |
| 33   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 33   | BsaI     | CAAT | TAGT            | 2/4      | direct |
| 33   | BsaI     | CAAT | GAAA            | 2/4      | direct |
| 33   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 34   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 34   | BsaI     | AAGA | TAGT            | 2/4      | direct |
| 34   | BsaI     | AAGA | TAGT (RC: ACTA) | 2/4      | RC     |
| 34   | BsaI     | AAGA | CCTG (RC: CAGG) | 2/4      | RC     |
| 34   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 34   | BsaI     | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 34   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 34   | BsaI     | CAAT | TAGT            | 2/4      | direct |
| 34   | BsaI     | CAAT | CCTG (RC: CAGG) | 2/4      | RC     |
| 34   | BsaI     | CTCG | CCTG            | 2/4      | direct |
| 34   | BsaI     | CTCG | CCTG (RC: CAGG) | 2/4      | RC     |
| 34   | BsaI     | TAGT | CCTG (RC: CAGG) | 2/4      | RC     |
| 34   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 34   | BsmBI    | TCAA | AAGA (RC: TCTT) | 2/4      | RC     |
| 35   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 35   | BsaI     | AAGA | TAGT            | 2/4      | direct |
| 35   | BsaI     | AAGA | TAGT (RC: ACTA) | 2/4      | RC     |
| 35   | BsaI     | AAGA | TACA            | 2/4      | direct |
| 35   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 35   | BsaI     | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 35   | BsaI     | AGAA | TACA (RC: TGTA) | 2/4      | RC     |
| 35   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 35   | BsaI     | CAAT | TAGT            | 2/4      | direct |
| 35   | BsaI     | TAGT | TACA            | 2/4      | direct |
| 35   | BsmBI    | CACC | GAAG (RC: CTTC) | 2/4      | RC     |
| 35   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 35   | BsmBI    | GAAG | GTCC (RC: GGAC) | 2/4      | RC     |
| 36   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 36   | BsaI     | AAGA | TAGT            | 2/4      | direct |
| 36   | BsaI     | AAGA | TAGT (RC: ACTA) | 2/4      | RC     |
| 36   | BsaI     | AAGA | TATC (RC: GATA) | 2/4      | RC     |
| 36   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 36   | BsaI     | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 36   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 36   | BsaI     | CAAT | TAGT            | 2/4      | direct |
| 36   | BsaI     | TAGT | TATC            | 2/4      | direct |
| 36   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 37   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 37   | BsaI     | AAGA | TAGT            | 2/4      | direct |
| 37   | BsaI     | AAGA | TAGT (RC: ACTA) | 2/4      | RC     |
| 37   | BsaI     | AAGA | TCAA (RC: TTGA) | 2/4      | RC     |
| 37   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 37   | BsaI     | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 37   | BsaI     | AGAA | TCAA            | 2/4      | direct |
| 37   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 37   | BsaI     | CAAT | TAGT            | 2/4      | direct |
| 37   | BsaI     | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 37   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 37   | BsmBI    | TGAT | GTCC (RC: GGAC) | 2/4      | RC     |
| 37   | BsmBI    | TGAT | AAGA (RC: TCTT) | 2/4      | RC     |
| 38   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 38   | BsaI     | AAGA | TAGT            | 2/4      | direct |
| 38   | BsaI     | AAGA | TAGT (RC: ACTA) | 2/4      | RC     |
| 38   | BsaI     | AAGA | TCAA (RC: TTGA) | 2/4      | RC     |
| 38   | BsaI     | AAGA | GAAA            | 2/4      | direct |
| 38   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 38   | BsaI     | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 38   | BsaI     | AGAA | TCAA            | 2/4      | direct |
| 38   | BsaI     | AGAA | GAAA            | 2/4      | direct |
| 38   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 38   | BsaI     | CAAT | TAGT            | 2/4      | direct |
| 38   | BsaI     | CAAT | GAAA            | 2/4      | direct |
| 38   | BsaI     | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 38   | BsaI     | TCAA | GAAA            | 2/4      | direct |
| 38   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 39   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 39   | BsaI     | AAGA | TAGT            | 2/4      | direct |
| 39   | BsaI     | AAGA | TAGT (RC: ACTA) | 2/4      | RC     |
| 39   | BsaI     | AAGA | TCAA (RC: TTGA) | 2/4      | RC     |
| 39   | BsaI     | AAGA | TCGC (RC: GCGA) | 2/4      | RC     |
| 39   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 39   | BsaI     | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 39   | BsaI     | AGAA | TCAA            | 2/4      | direct |
| 39   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 39   | BsaI     | CAAT | TAGT            | 2/4      | direct |
| 39   | BsaI     | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 39   | BsaI     | TAGT | TCGC            | 2/4      | direct |
| 39   | BsaI     | TCAA | TCGC            | 2/4      | direct |
| 39   | BsaI     | TCAA | TCGC (RC: GCGA) | 2/4      | RC     |
| 39   | BsmBI    | CACC | TGTC (RC: GACA) | 2/4      | RC     |
| 39   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 39   | BsmBI    | TGTC | GTCC (RC: GGAC) | 2/4      | RC     |
| 39   | BsmBI    | TGTC | AAGA (RC: TCTT) | 2/4      | RC     |
| 40   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 40   | BsaI     | AAGA | TAGT            | 2/4      | direct |
| 40   | BsaI     | AAGA | TAGT (RC: ACTA) | 2/4      | RC     |
| 40   | BsaI     | AAGA | TCAA (RC: TTGA) | 2/4      | RC     |
| 40   | BsaI     | AAGA | CGGA            | 2/4      | direct |
| 40   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 40   | BsaI     | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 40   | BsaI     | AGAA | TCAA            | 2/4      | direct |
| 40   | BsaI     | AGAA | CGGA            | 2/4      | direct |
| 40   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 40   | BsaI     | CAAT | TAGT            | 2/4      | direct |
| 40   | BsaI     | CTCG | CGGA (RC: TCCG) | 2/4      | RC     |
| 40   | BsaI     | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 40   | BsaI     | TCAA | CGGA (RC: TCCG) | 2/4      | RC     |
| 40   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 40   | BsmBI    | AGAA | GTCC (RC: GGAC) | 2/4      | RC     |
| 40   | BsmBI    | AGAA | AAGA            | 2/4      | direct |
| 41   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 41   | BsaI     | AAGA | TAGT            | 2/4      | direct |
| 41   | BsaI     | AAGA | TAGT (RC: ACTA) | 2/4      | RC     |
| 41   | BsaI     | AAGA | TCAA (RC: TTGA) | 2/4      | RC     |
| 41   | BsaI     | AAGA | GAGG            | 2/4      | direct |
| 41   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 41   | BsaI     | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 41   | BsaI     | AGAA | TCAA            | 2/4      | direct |
| 41   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 41   | BsaI     | CAAT | TAGT            | 2/4      | direct |
| 41   | BsaI     | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 41   | BsaI     | TAGT | GAGG            | 2/4      | direct |
| 41   | BsmBI    | CACC | CAAG            | 2/4      | direct |
| 41   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 42   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 42   | BsaI     | AAGA | TAGT            | 2/4      | direct |
| 42   | BsaI     | AAGA | TAGT (RC: ACTA) | 2/4      | RC     |
| 42   | BsaI     | AAGA | TCAA (RC: TTGA) | 2/4      | RC     |
| 42   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 42   | BsaI     | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 42   | BsaI     | AGAA | TCAA            | 2/4      | direct |
| 42   | BsaI     | AGAA | GTCC (RC: GGAC) | 2/4      | RC     |
| 42   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 42   | BsaI     | CAAT | TAGT            | 2/4      | direct |
| 42   | BsaI     | CTCG | GTCC            | 2/4      | direct |
| 42   | BsaI     | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 42   | BsmBI    | CACC | GTCC            | 2/4      | direct |
| 43   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 43   | BsaI     | AAGA | TAGT            | 2/4      | direct |
| 43   | BsaI     | AAGA | TAGT (RC: ACTA) | 2/4      | RC     |
| 43   | BsaI     | AAGA | TCAA (RC: TTGA) | 2/4      | RC     |
| 43   | BsaI     | AAGA | TCGG (RC: CCGA) | 2/4      | RC     |
| 43   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 43   | BsaI     | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 43   | BsaI     | AGAA | TCAA            | 2/4      | direct |
| 43   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 43   | BsaI     | CAAT | TAGT            | 2/4      | direct |
| 43   | BsaI     | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 43   | BsaI     | TAGT | TCGG            | 2/4      | direct |
| 43   | BsaI     | TCAA | TCGG            | 2/4      | direct |
| 43   | BsaI     | TCAA | TCGG (RC: CCGA) | 2/4      | RC     |
| 43   | BsmBI    | CACC | AGCC            | 2/4      | direct |
| 44   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 44   | BsaI     | AAGA | TAGT            | 2/4      | direct |
| 44   | BsaI     | AAGA | TAGT (RC: ACTA) | 2/4      | RC     |
| 44   | BsaI     | AAGA | TCAA (RC: TTGA) | 2/4      | RC     |
| 44   | BsaI     | AAGA | TTTC (RC: GAAA) | 2/4      | RC     |
| 44   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 44   | BsaI     | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 44   | BsaI     | AGAA | TCAA            | 2/4      | direct |
| 44   | BsaI     | AGAA | TTTC (RC: GAAA) | 2/4      | RC     |
| 44   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 44   | BsaI     | CAAT | TAGT            | 2/4      | direct |
| 44   | BsaI     | CAAT | TTTC (RC: GAAA) | 2/4      | RC     |
| 44   | BsaI     | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 44   | BsaI     | TCAA | TTTC (RC: GAAA) | 2/4      | RC     |
| 45   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 45   | BsaI     | AAGA | TAGT            | 2/4      | direct |
| 45   | BsaI     | AAGA | TAGT (RC: ACTA) | 2/4      | RC     |
| 45   | BsaI     | AAGA | TCAA (RC: TTGA) | 2/4      | RC     |
| 45   | BsaI     | AAGA | GATA            | 2/4      | direct |
| 45   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 45   | BsaI     | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 45   | BsaI     | AGAA | TCAA            | 2/4      | direct |
| 45   | BsaI     | AGAA | GTCC (RC: GGAC) | 2/4      | RC     |
| 45   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 45   | BsaI     | CAAT | TAGT            | 2/4      | direct |
| 45   | BsaI     | CTCG | GTCC            | 2/4      | direct |
| 45   | BsaI     | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 45   | BsaI     | TAGT | GATA (RC: TATC) | 2/4      | RC     |
| 46   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 46   | BsaI     | AAGA | TAGT            | 2/4      | direct |
| 46   | BsaI     | AAGA | TAGT (RC: ACTA) | 2/4      | RC     |
| 46   | BsaI     | AAGA | TCAA (RC: TTGA) | 2/4      | RC     |
| 46   | BsaI     | AAGA | GAAA            | 2/4      | direct |
| 46   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 46   | BsaI     | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 46   | BsaI     | AGAA | TCAA            | 2/4      | direct |
| 46   | BsaI     | AGAA | GTCC (RC: GGAC) | 2/4      | RC     |
| 46   | BsaI     | AGAA | GAAA            | 2/4      | direct |
| 46   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 46   | BsaI     | CAAT | TAGT            | 2/4      | direct |
| 46   | BsaI     | CAAT | GAAA            | 2/4      | direct |
| 46   | BsaI     | CTCG | GTCC            | 2/4      | direct |
| 46   | BsaI     | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 46   | BsaI     | TCAA | GAAA            | 2/4      | direct |
| 46   | BsaI     | GTCC | GAAA (RC: TTTC) | 2/4      | RC     |
| 46   | BsmBI    | CCTA | AAGA (RC: TCTT) | 2/4      | RC     |
| 47   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 47   | BsaI     | AAGA | TAGT            | 2/4      | direct |
| 47   | BsaI     | AAGA | TAGT (RC: ACTA) | 2/4      | RC     |
| 47   | BsaI     | AAGA | TCAA (RC: TTGA) | 2/4      | RC     |
| 47   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 47   | BsaI     | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 47   | BsaI     | AGAA | TCAA            | 2/4      | direct |
| 47   | BsaI     | AGAA | GTCC (RC: GGAC) | 2/4      | RC     |
| 47   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 47   | BsaI     | CAAT | TAGT            | 2/4      | direct |
| 47   | BsaI     | CTCG | GTCC            | 2/4      | direct |
| 47   | BsaI     | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 47   | BsaI     | TAGT | GCCA (RC: TGGC) | 2/4      | RC     |
| 47   | BsaI     | TCAA | GCCA            | 2/4      | direct |
| 47   | BsaI     | GTCC | GCCA            | 2/4      | direct |
| 47   | BsmBI    | CACC | CCTC            | 2/4      | direct |
| 47   | BsmBI    | CCTC | AAGA (RC: TCTT) | 2/4      | RC     |
| 48   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 48   | BsaI     | AAGA | TAGT            | 2/4      | direct |
| 48   | BsaI     | AAGA | TAGT (RC: ACTA) | 2/4      | RC     |
| 48   | BsaI     | AAGA | TCAA (RC: TTGA) | 2/4      | RC     |
| 48   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 48   | BsaI     | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 48   | BsaI     | AGAA | TCAA            | 2/4      | direct |
| 48   | BsaI     | AGAA | GTCC (RC: GGAC) | 2/4      | RC     |
| 48   | BsaI     | AGAA | GGCA            | 2/4      | direct |
| 48   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 48   | BsaI     | CAAT | TAGT            | 2/4      | direct |
| 48   | BsaI     | CTCG | GTCC            | 2/4      | direct |
| 48   | BsaI     | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 48   | BsaI     | GTCC | GGCA            | 2/4      | direct |
| 48   | BsaI     | GTCC | GGCA (RC: TGCC) | 2/4      | RC     |
| 48   | BsmBI    | CACC | TGTC (RC: GACA) | 2/4      | RC     |
| 48   | BsmBI    | TGTC | AAGA (RC: TCTT) | 2/4      | RC     |
| 49   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 49   | BsaI     | AAGA | TAGT            | 2/4      | direct |
| 49   | BsaI     | AAGA | TAGT (RC: ACTA) | 2/4      | RC     |
| 49   | BsaI     | AAGA | TCAA (RC: TTGA) | 2/4      | RC     |
| 49   | BsaI     | AAGA | GAGG            | 2/4      | direct |
| 49   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 49   | BsaI     | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 49   | BsaI     | AGAA | TCAA            | 2/4      | direct |
| 49   | BsaI     | AGAA | GTCC (RC: GGAC) | 2/4      | RC     |
| 49   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 49   | BsaI     | CAAT | TAGT            | 2/4      | direct |
| 49   | BsaI     | CTCG | GTCC            | 2/4      | direct |
| 49   | BsaI     | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 49   | BsaI     | TAGT | GAGG            | 2/4      | direct |
| 49   | BsmBI    | CACC | GAAC            | 2/4      | direct |
| 50   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 50   | BsaI     | AAGA | TAGT            | 2/4      | direct |
| 50   | BsaI     | AAGA | TAGT (RC: ACTA) | 2/4      | RC     |
| 50   | BsaI     | AAGA | TCAA (RC: TTGA) | 2/4      | RC     |
| 50   | BsaI     | AAGA | GAAA            | 2/4      | direct |
| 50   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 50   | BsaI     | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 50   | BsaI     | AGAA | TCAA            | 2/4      | direct |
| 50   | BsaI     | AGAA | GTCC (RC: GGAC) | 2/4      | RC     |
| 50   | BsaI     | AGAA | GAAA            | 2/4      | direct |
| 50   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 50   | BsaI     | CAAT | TAGT            | 2/4      | direct |
| 50   | BsaI     | CAAT | GAAA            | 2/4      | direct |
| 50   | BsaI     | CTCG | GTCC            | 2/4      | direct |
| 50   | BsaI     | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 50   | BsaI     | TCAA | GAAA            | 2/4      | direct |
| 50   | BsaI     | GTCC | GAAA (RC: TTTC) | 2/4      | RC     |
| 50   | BsmBI    | CACC | CAAG            | 2/4      | direct |
| 51   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 51   | BsaI     | AAGA | TAGT            | 2/4      | direct |
| 51   | BsaI     | AAGA | TAGT (RC: ACTA) | 2/4      | RC     |
| 51   | BsaI     | AAGA | TCAA (RC: TTGA) | 2/4      | RC     |
| 51   | BsaI     | AAGA | CAGG            | 2/4      | direct |
| 51   | BsaI     | AGAA | CTCG (RC: CGAG) | 2/4      | RC     |
| 51   | BsaI     | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 51   | BsaI     | AGAA | TCAA            | 2/4      | direct |
| 51   | BsaI     | AGAA | GTCC (RC: GGAC) | 2/4      | RC     |
| 51   | BsaI     | CAAT | CTCG (RC: CGAG) | 2/4      | RC     |
| 51   | BsaI     | CAAT | TAGT            | 2/4      | direct |
| 51   | BsaI     | CAAT | CAGG            | 2/4      | direct |
| 51   | BsaI     | CTCG | GTCC            | 2/4      | direct |
| 51   | BsaI     | CTCG | CAGG            | 2/4      | direct |
| 51   | BsaI     | CTCG | CAGG (RC: CCTG) | 2/4      | RC     |
| 51   | BsaI     | TAGT | TCAA (RC: TTGA) | 2/4      | RC     |
| 51   | BsaI     | TAGT | CAGG            | 2/4      | direct |

## 6. Fixed Overhangs & Helper Plasmid

These overhangs are the same across all tile reactions:

| Overhang    | Sequence | Role                                                    |
| ----------- | -------- | ------------------------------------------------------- |
| oh_L        | AAGA     | Gene start (BsaI, user-specified, upstream of ATG)      |
| oh3         | CACC     | Downstream cassette-barcode junction (BsmBI, all tiles) |
| oh4         | AGAA     | Barcode-helper junction (BsaI, all tiles)               |
| paqci_star2 | auto     | PaqCI 5' end of insert (Level 2)                        |
| paqci_star1 | auto     | PaqCI 3' end of insert (Level 2)                        |

### Helper Plasmid Insert

The helper plasmid provides the backbone for each BsaI Level 1 reaction.

```
[PaqCI**]--[BsaI>>AAGA]--STUFFER--[AGAA<<BsaI]--[PaqCI*]
```

Insert length: 72 nt
oh_L = AAGA (user-specified, upstream of ATG)
oh_R = AGAA (= oh4, barcode-helper junction)
upstream_cassette = (none)

## 7. Per-Tile Assembly Guide

### Tile 1 of 51 -- Codons 1-76 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | CCTT     | 0.6891   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (15120 oligos)              | 288 nt | AAGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert              | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart               | --     | --    | --    |

```
  [AAGA]----oligo+BC----[AGAA]
   AAGA                  AGAA 
```

**Set fidelity:** 1.0000 (2 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1     | 1020 nt | CCTT  | CAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1629 nt | CAAT  | CTCG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1770 nt | CTCG  | TAGT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1662 nt | TAGT  | TCAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTT]----3'WT sub1----[CAAT]----3'WT sub2----[CTCG]----3'WT sub3----[TAGT]----3'WT sub4----[TCAA]----3'WT sub5----[GTCC]----3'WT sub6----[AAGA]----3'WT+PolIII sub7----[CACC]
   CCTT                   CAAT                   CTCG                   TAGT                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 0.9986 (8 overhangs)

---

### Tile 2 of 51 -- Codons 71-141 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | CCTT     | 0.6891   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 244 nt | AAGA  | GAAA  |
| 2   | Oligo pool      | Tile 2 (13650 oligos) | 269 nt | GAAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [AAGA]----5'WT block----[GAAA]----oligo+BC----[AGAA]
   AAGA                    GAAA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1     | 825 nt  | CCTT  | CAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1629 nt | CAAT  | CTCG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1770 nt | CTCG  | TAGT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1662 nt | TAGT  | TCAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTT]----3'WT sub1----[CAAT]----3'WT sub2----[CTCG]----3'WT sub3----[TAGT]----3'WT sub4----[TCAA]----3'WT sub5----[GTCC]----3'WT sub6----[AAGA]----3'WT+PolIII sub7----[CACC]
   CCTT                   CAAT                   CTCG                   TAGT                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 0.9986 (8 overhangs)

---

### Tile 3 of 51 -- Codons 136-212 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GACT     | 0.5537   |
| oh2 (3' boundary) | AGAA     | 0.8847   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 439 nt | AAGA  | GACT  |
| 2   | Oligo pool      | Tile 3 (14910 oligos) | 287 nt | GACT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [AAGA]----5'WT block----[GACT]----oligo+BC----[AGAA]
   AAGA                    GACT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1     | 612 nt  | AGAA  | CAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1629 nt | CAAT  | CTCG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1770 nt | CTCG  | TAGT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1662 nt | TAGT  | TCAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAA]----3'WT sub1----[CAAT]----3'WT sub2----[CTCG]----3'WT sub3----[TAGT]----3'WT sub4----[TCAA]----3'WT sub5----[GTCC]----3'WT sub6----[AAGA]----3'WT+PolIII sub7----[CACC]
   AGAA                   CAAT                   CTCG                   TAGT                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (8 overhangs)

---

### Tile 4 of 51 -- Codons 207-275 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAT     | 0.7246   |
| oh2 (3' boundary) | CCTG     | 0.6383   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 652 nt | AAGA  | GAAT  |
| 2   | Oligo pool      | Tile 4 (13230 oligos) | 263 nt | GAAT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [AAGA]----5'WT block----[GAAT]----oligo+BC----[AGAA]
   AAGA                    GAAT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1     | 423 nt  | CCTG  | CAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1629 nt | CAAT  | CTCG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1770 nt | CTCG  | TAGT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1662 nt | TAGT  | TCAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTG]----3'WT sub1----[CAAT]----3'WT sub2----[CTCG]----3'WT sub3----[TAGT]----3'WT sub4----[TCAA]----3'WT sub5----[GTCC]----3'WT sub6----[AAGA]----3'WT+PolIII sub7----[CACC]
   CCTG                   CAAT                   CTCG                   TAGT                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (8 overhangs)

---

### Tile 5 of 51 -- Codons 270-343 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCCC     | 0.5462   |
| oh2 (3' boundary) | GAGG     | 0.5599   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 841 nt | AAGA  | GCCC  |
| 2   | Oligo pool      | Tile 5 (14280 oligos) | 278 nt | GCCC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [AAGA]----5'WT block----[GCCC]----oligo+BC----[AGAA]
   AAGA                    GCCC                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1     | 219 nt  | GAGG  | CAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1629 nt | CAAT  | CTCG  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1770 nt | CTCG  | TAGT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1662 nt | TAGT  | TCAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAGG]----3'WT sub1----[CAAT]----3'WT sub2----[CTCG]----3'WT sub3----[TAGT]----3'WT sub4----[TCAA]----3'WT sub5----[GTCC]----3'WT sub6----[AAGA]----3'WT+PolIII sub7----[CACC]
   GAGG                   CAAT                   CTCG                   TAGT                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (8 overhangs)

---

### Tile 6 of 51 -- Codons 338-406 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGT     | 0.6512   |
| oh2 (3' boundary) | CAAT     | 0.7361   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 1045 nt | AAGA  | CAGT  |
| 2   | Oligo pool      | Tile 6 (13230 oligos) | 263 nt  | CAGT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [AAGA]----5'WT block----[CAGT]----oligo+BC----[AGAA]
   AAGA                    CAGT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1629 nt | CAAT  | CTCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1770 nt | CTCG  | TAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1662 nt | TAGT  | TCAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAT]----3'WT sub1----[CTCG]----3'WT sub2----[TAGT]----3'WT sub3----[TCAA]----3'WT sub4----[GTCC]----3'WT sub5----[AAGA]----3'WT+PolIII sub6----[CACC]
   CAAT                   CTCG                   TAGT                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (7 overhangs)

---

### Tile 7 of 51 -- Codons 401-435 (105 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCA     | 0.7483   |
| oh2 (3' boundary) | GGCA     | 0.5273   |

**Variants:** 6090 mutations, 6090 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 1234 nt | AAGA  | ATCA  |
| 2   | Oligo pool      | Tile 7 (6090 oligos)  | 161 nt  | ATCA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [AAGA]----5'WT block----[ATCA]----oligo+BC----[AGAA]
   AAGA                    ATCA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1     | 1542 nt | GGCA  | CTCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1770 nt | CTCG  | TAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1662 nt | TAGT  | TCAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGCA]----3'WT sub1----[CTCG]----3'WT sub2----[TAGT]----3'WT sub3----[TCAA]----3'WT sub4----[GTCC]----3'WT sub5----[AAGA]----3'WT+PolIII sub6----[CACC]
   GGCA                   CTCG                   TAGT                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (7 overhangs)

---

### Tile 8 of 51 -- Codons 430-496 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TGGA     | 0.7377   |
| oh2 (3' boundary) | TCTT     | 0.7985   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1   | 1321 nt | AAGA  | TGGA  |
| 2   | Oligo pool      | Tile 8 (12810 oligos) | 257 nt  | TGGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [AAGA]----5'WT block----[TGGA]----oligo+BC----[AGAA]
   AAGA                    TGGA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1     | 1359 nt | TCTT  | CTCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1770 nt | CTCG  | TAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1662 nt | TAGT  | TCAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCTT]----3'WT sub1----[CTCG]----3'WT sub2----[TAGT]----3'WT sub3----[TCAA]----3'WT sub4----[GTCC]----3'WT sub5----[AAGA]----3'WT+PolIII sub6----[CACC]
   TCTT                   CTCG                   TAGT                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (7 overhangs)

---

### Tile 9 of 51 -- Codons 491-565 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TATG     | 0.7006   |
| oh2 (3' boundary) | GAGG     | 0.5599   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9_sub1   | 1504 nt | AAGA  | TATG  |
| 2   | Oligo pool      | Tile 9 (14490 oligos) | 281 nt  | TATG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [AAGA]----5'WT block----[TATG]----oligo+BC----[AGAA]
   AAGA                    TATG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1     | 1152 nt | GAGG  | CTCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1770 nt | CTCG  | TAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1662 nt | TAGT  | TCAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAGG]----3'WT sub1----[CTCG]----3'WT sub2----[TAGT]----3'WT sub3----[TCAA]----3'WT sub4----[GTCC]----3'WT sub5----[AAGA]----3'WT+PolIII sub6----[CACC]
   GAGG                   CTCG                   TAGT                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (7 overhangs)

---

### Tile 10 of 51 -- Codons 560-632 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTCC     | 0.5806   |
| oh2 (3' boundary) | AGAA     | 0.8847   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile10_sub2   | 493 nt  | CAAT  | GTCC  |
| 3   | Oligo pool      | Tile 10 (14070 oligos) | 275 nt  | GTCC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[GTCC]----oligo+BC----[AGAA]
   AAGA                   CAAT                   GTCC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1    | 951 nt  | AGAA  | CTCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1770 nt | CTCG  | TAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1662 nt | TAGT  | TCAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAA]----3'WT sub1----[CTCG]----3'WT sub2----[TAGT]----3'WT sub3----[TCAA]----3'WT sub4----[GTCC]----3'WT sub5----[AAGA]----3'WT+PolIII sub6----[CACC]
   AGAA                   CTCG                   TAGT                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (7 overhangs)

---

### Tile 11 of 51 -- Codons 627-700 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAC     | 0.8333   |
| oh2 (3' boundary) | TGCC     | 0.5867   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile11_sub2   | 694 nt  | CAAT  | TTAC  |
| 3   | Oligo pool      | Tile 11 (14280 oligos) | 278 nt  | TTAC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[TTAC]----oligo+BC----[AGAA]
   AAGA                   CAAT                   TTAC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1    | 747 nt  | TGCC  | CTCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1770 nt | CTCG  | TAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1662 nt | TAGT  | TCAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGCC]----3'WT sub1----[CTCG]----3'WT sub2----[TAGT]----3'WT sub3----[TCAA]----3'WT sub4----[GTCC]----3'WT sub5----[AAGA]----3'WT+PolIII sub6----[CACC]
   TGCC                   CTCG                   TAGT                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 0.9933 (7 overhangs)

---

### Tile 12 of 51 -- Codons 695-763 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTGG     | 0.5756   |
| oh2 (3' boundary) | GCAG     | 0.5118   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2   | 898 nt  | CAAT  | CTGG  |
| 3   | Oligo pool      | Tile 12 (13230 oligos) | 263 nt  | CTGG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTGG]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTGG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1    | 558 nt  | GCAG  | CTCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1770 nt | CTCG  | TAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1662 nt | TAGT  | TCAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCAG]----3'WT sub1----[CTCG]----3'WT sub2----[TAGT]----3'WT sub3----[TCAA]----3'WT sub4----[GTCC]----3'WT sub5----[AAGA]----3'WT+PolIII sub6----[CACC]
   GCAG                   CTCG                   TAGT                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 0.9979 (7 overhangs)

---

### Tile 13 of 51 -- Codons 758-810 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | TTCT     | 0.8181   |

**Variants:** 9870 mutations, 9870 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2  | 1087 nt | CAAT  | GAAA  |
| 3   | Oligo pool      | Tile 13 (9870 oligos) | 215 nt  | GAAA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[GAAA]----oligo+BC----[AGAA]
   AAGA                   CAAT                   GAAA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1    | 417 nt  | TTCT  | CTCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1770 nt | CTCG  | TAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1662 nt | TAGT  | TCAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCT]----3'WT sub1----[CTCG]----3'WT sub2----[TAGT]----3'WT sub3----[TCAA]----3'WT sub4----[GTCC]----3'WT sub5----[AAGA]----3'WT+PolIII sub6----[CACC]
   TTCT                   CTCG                   TAGT                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (7 overhangs)

---

### Tile 14 of 51 -- Codons 805-881 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TGGA     | 0.7377   |
| oh2 (3' boundary) | CCTG     | 0.6383   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1228 nt | CAAT  | TGGA  |
| 3   | Oligo pool      | Tile 14 (14910 oligos) | 287 nt  | TGGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[TGGA]----oligo+BC----[AGAA]
   AAGA                   CAAT                   TGGA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1    | 204 nt  | CCTG  | CTCG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1770 nt | CTCG  | TAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1662 nt | TAGT  | TCAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTG]----3'WT sub1----[CTCG]----3'WT sub2----[TAGT]----3'WT sub3----[TCAA]----3'WT sub4----[GTCC]----3'WT sub5----[AAGA]----3'WT+PolIII sub6----[CACC]
   CCTG                   CTCG                   TAGT                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (7 overhangs)

---

### Tile 15 of 51 -- Codons 876-939 (192 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACTC     | 0.5979   |
| oh2 (3' boundary) | CTCG     | 0.7252   |

**Variants:** 12180 mutations, 12180 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1441 nt | CAAT  | ACTC  |
| 3   | Oligo pool      | Tile 15 (12180 oligos) | 248 nt  | ACTC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[ACTC]----oligo+BC----[AGAA]
   AAGA                   CAAT                   ACTC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1770 nt | CTCG  | TAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1662 nt | TAGT  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTCG]----3'WT sub1----[TAGT]----3'WT sub2----[TCAA]----3'WT sub3----[GTCC]----3'WT sub4----[AAGA]----3'WT+PolIII sub5----[CACC]
   CTCG                   TAGT                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 16 of 51 -- Codons 934-972 (117 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTTA     | 0.7183   |
| oh2 (3' boundary) | AGAA     | 0.8847   |

**Variants:** 6930 mutations, 6930 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1615 nt | CAAT  | CTTA  |
| 3   | Oligo pool      | Tile 16 (6930 oligos) | 173 nt  | CTTA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTTA]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTTA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1    | 1671 nt | AGAA  | TAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1662 nt | TAGT  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAA]----3'WT sub1----[TAGT]----3'WT sub2----[TCAA]----3'WT sub3----[GTCC]----3'WT sub4----[AAGA]----3'WT+PolIII sub5----[CACC]
   AGAA                   TAGT                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 17 of 51 -- Codons 967-1037 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTGC     | 0.4969   |
| oh2 (3' boundary) | AGAA     | 0.8847   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 1714 nt | CAAT  | GTGC  |
| 3   | Oligo pool      | Tile 17 (13650 oligos) | 269 nt  | GTGC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[GTGC]----oligo+BC----[AGAA]
   AAGA                   CAAT                   GTGC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1    | 1476 nt | AGAA  | TAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1662 nt | TAGT  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAA]----3'WT sub1----[TAGT]----3'WT sub2----[TCAA]----3'WT sub3----[GTCC]----3'WT sub4----[AAGA]----3'WT+PolIII sub5----[CACC]
   AGAA                   TAGT                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 18 of 51 -- Codons 1032-1083 (156 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGG     | 0.5358   |
| oh2 (3' boundary) | CGTC     | 0.5136   |

**Variants:** 9660 mutations, 9660 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile18_sub3  | 310 nt  | CTCG  | CAGG  |
| 4   | Oligo pool      | Tile 18 (9660 oligos) | 212 nt  | CAGG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[CAGG]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   CAGG                  AGAA 
```

**Set fidelity:** 0.9957 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1    | 1338 nt | CGTC  | TAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1662 nt | TAGT  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CGTC]----3'WT sub1----[TAGT]----3'WT sub2----[TCAA]----3'WT sub3----[GTCC]----3'WT sub4----[AAGA]----3'WT+PolIII sub5----[CACC]
   CGTC                   TAGT                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 19 of 51 -- Codons 1078-1132 (165 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CGGA     | 0.6609   |
| oh2 (3' boundary) | AAGA     | 0.9209   |

**Variants:** 10290 mutations, 10290 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3   | 448 nt  | CTCG  | CGGA  |
| 4   | Oligo pool      | Tile 19 (10290 oligos) | 221 nt  | CGGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[CGGA]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   CGGA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1    | 1191 nt | AAGA  | TAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1662 nt | TAGT  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAGA]----3'WT sub1----[TAGT]----3'WT sub2----[TCAA]----3'WT sub3----[GTCC]----3'WT sub4----[AAGA]----3'WT+PolIII sub5----[CACC]
   AAGA                   TAGT                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 20 of 51 -- Codons 1127-1204 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TGGA     | 0.7377   |
| oh2 (3' boundary) | TGAT     | 0.6933   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile20_sub3   | 595 nt  | CTCG  | TGGA  |
| 4   | Oligo pool      | Tile 20 (15120 oligos) | 290 nt  | TGGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[TGGA]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   TGGA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1    | 975 nt  | TGAT  | TAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1662 nt | TAGT  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAT]----3'WT sub1----[TAGT]----3'WT sub2----[TCAA]----3'WT sub3----[GTCC]----3'WT sub4----[AAGA]----3'WT+PolIII sub5----[CACC]
   TGAT                   TAGT                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 21 of 51 -- Codons 1199-1271 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTGA     | 0.8853   |
| oh2 (3' boundary) | CTCA     | 0.6872   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3   | 811 nt  | CTCG  | TTGA  |
| 4   | Oligo pool      | Tile 21 (14070 oligos) | 275 nt  | TTGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[TTGA]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   TTGA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1    | 774 nt  | CTCA  | TAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1662 nt | TAGT  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTCA]----3'WT sub1----[TAGT]----3'WT sub2----[TCAA]----3'WT sub3----[GTCC]----3'WT sub4----[AAGA]----3'WT+PolIII sub5----[CACC]
   CTCA                   TAGT                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 22 of 51 -- Codons 1266-1337 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCCA     | 0.5727   |
| oh2 (3' boundary) | AGAA     | 0.8847   |

**Variants:** 13860 mutations, 13860 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1012 nt | CTCG  | GCCA  |
| 4   | Oligo pool      | Tile 22 (13860 oligos) | 272 nt  | GCCA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[GCCA]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   GCCA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1    | 576 nt  | AGAA  | TAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1662 nt | TAGT  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAA]----3'WT sub1----[TAGT]----3'WT sub2----[TCAA]----3'WT sub3----[GTCC]----3'WT sub4----[AAGA]----3'WT+PolIII sub5----[CACC]
   AGAA                   TAGT                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 23 of 51 -- Codons 1332-1390 (177 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGCA     | 0.5273   |
| oh2 (3' boundary) | TAAG     | 0.8377   |

**Variants:** 11130 mutations, 11130 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 1210 nt | CTCG  | GGCA  |
| 4   | Oligo pool      | Tile 23 (11130 oligos) | 233 nt  | GGCA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[GGCA]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   GGCA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1    | 417 nt  | TAAG  | TAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1662 nt | TAGT  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAAG]----3'WT sub1----[TAGT]----3'WT sub2----[TCAA]----3'WT sub3----[GTCC]----3'WT sub4----[AAGA]----3'WT+PolIII sub5----[CACC]
   TAAG                   TAGT                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 24 of 51 -- Codons 1385-1462 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACAT     | 0.6621   |
| oh2 (3' boundary) | GAAG     | 0.6752   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3   | 1369 nt | CTCG  | ACAT  |
| 4   | Oligo pool      | Tile 24 (15120 oligos) | 290 nt  | ACAT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[ACAT]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   ACAT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile24_sub1    | 201 nt  | GAAG  | TAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1662 nt | TAGT  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAG]----3'WT sub1----[TAGT]----3'WT sub2----[TCAA]----3'WT sub3----[GTCC]----3'WT sub4----[AAGA]----3'WT+PolIII sub5----[CACC]
   GAAG                   TAGT                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 25 of 51 -- Codons 1457-1519 (189 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGC     | 0.6171   |
| oh2 (3' boundary) | TAGT     | 0.7437   |

**Variants:** 11970 mutations, 11970 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3   | 1585 nt | CTCG  | ATGC  |
| 4   | Oligo pool      | Tile 25 (11970 oligos) | 245 nt  | ATGC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[ATGC]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   ATGC                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1662 nt | TAGT  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAGT]----3'WT sub1----[TCAA]----3'WT sub2----[GTCC]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   TAGT                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 26 of 51 -- Codons 1514-1571 (174 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGT     | 0.6822   |
| oh2 (3' boundary) | CCTT     | 0.6891   |

**Variants:** 10920 mutations, 10920 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3   | 1756 nt | CTCG  | ATGT  |
| 4   | Oligo pool      | Tile 26 (10920 oligos) | 230 nt  | ATGT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[ATGT]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   ATGT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile26_sub1    | 1506 nt | CCTT  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTT]----3'WT sub1----[TCAA]----3'WT sub2----[GTCC]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   CCTT                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 27 of 51 -- Codons 1566-1636 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GATA     | 0.7029   |
| oh2 (3' boundary) | TGAT     | 0.6933   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1770 nt | CTCG  | TAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile27_sub4   | 172 nt  | TAGT  | GATA  |
| 5   | Oligo pool      | Tile 27 (13650 oligos) | 269 nt  | GATA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[TAGT]----5'WT sub4----[GATA]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   TAGT                   GATA                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile27_sub1    | 1311 nt | TGAT  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAT]----3'WT sub1----[TCAA]----3'WT sub2----[GTCC]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   TGAT                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 28 of 51 -- Codons 1631-1708 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGCA     | 0.5273   |
| oh2 (3' boundary) | AGAA     | 0.8847   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1770 nt | CTCG  | TAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4   | 367 nt  | TAGT  | GGCA  |
| 5   | Oligo pool      | Tile 28 (15120 oligos) | 290 nt  | GGCA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[TAGT]----5'WT sub4----[GGCA]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   TAGT                   GGCA                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile28_sub1    | 1095 nt | AGAA  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAA]----3'WT sub1----[TCAA]----3'WT sub2----[GTCC]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   AGAA                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 29 of 51 -- Codons 1703-1775 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CGCT     | 0.4305   |
| oh2 (3' boundary) | CAAG     | 0.6640   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1770 nt | CTCG  | TAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile29_sub4   | 583 nt  | TAGT  | CGCT  |
| 5   | Oligo pool      | Tile 29 (14070 oligos) | 275 nt  | CGCT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[TAGT]----5'WT sub4----[CGCT]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   TAGT                   CGCT                  AGAA 
```

**Set fidelity:** 0.9975 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile29_sub1    | 894 nt  | CAAG  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAG]----3'WT sub1----[TCAA]----3'WT sub2----[GTCC]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   CAAG                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 30 of 51 -- Codons 1770-1833 (192 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGCA     | 0.5273   |
| oh2 (3' boundary) | GAGA     | 0.7444   |

**Variants:** 12180 mutations, 12180 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1770 nt | CTCG  | TAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile30_sub4   | 784 nt  | TAGT  | GGCA  |
| 5   | Oligo pool      | Tile 30 (12180 oligos) | 248 nt  | GGCA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[TAGT]----5'WT sub4----[GGCA]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   TAGT                   GGCA                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile30_sub1    | 720 nt  | GAGA  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAGA]----3'WT sub1----[TCAA]----3'WT sub2----[GTCC]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   GAGA                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 0.9418 (5 overhangs)

---

### Tile 31 of 51 -- Codons 1828-1895 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | ATTA     | 0.7818   |

**Variants:** 13020 mutations, 13020 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1770 nt | CTCG  | TAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile31_sub4   | 958 nt  | TAGT  | GAAA  |
| 5   | Oligo pool      | Tile 31 (13020 oligos) | 260 nt  | GAAA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[TAGT]----5'WT sub4----[GAAA]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   TAGT                   GAAA                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile31_sub1    | 534 nt  | ATTA  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATTA]----3'WT sub1----[TCAA]----3'WT sub2----[GTCC]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   ATTA                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 32 of 51 -- Codons 1890-1966 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCCT     | 0.5289   |
| oh2 (3' boundary) | CTCT     | 0.6347   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1770 nt | CTCG  | TAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile32_sub4   | 1144 nt | TAGT  | GCCT  |
| 5   | Oligo pool      | Tile 32 (14910 oligos) | 287 nt  | GCCT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[TAGT]----5'WT sub4----[GCCT]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   TAGT                   GCCT                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile32_sub1    | 321 nt  | CTCT  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTCT]----3'WT sub1----[TCAA]----3'WT sub2----[GTCC]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   CTCT                   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 0.9945 (5 overhangs)

---

### Tile 33 of 51 -- Codons 1961-2010 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | AGGA     | 0.7515   |

**Variants:** 9240 mutations, 9240 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3  | 1770 nt | CTCG  | TAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile33_sub4  | 1357 nt | TAGT  | GAAA  |
| 5   | Oligo pool      | Tile 33 (9240 oligos) | 206 nt  | GAAA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[TAGT]----5'WT sub4----[GAAA]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   TAGT                   GAAA                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile33_sub1    | 1608 nt | AGGA  | GTCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGGA]----3'WT sub1----[GTCC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   AGGA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 0.9884 (4 overhangs)

---

### Tile 34 of 51 -- Codons 2005-2063 (177 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCTG     | 0.6383   |
| oh2 (3' boundary) | TCAA     | 0.9425   |

**Variants:** 11130 mutations, 11130 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1770 nt | CTCG  | TAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile34_sub4   | 1489 nt | TAGT  | CCTG  |
| 5   | Oligo pool      | Tile 34 (11130 oligos) | 233 nt  | CCTG  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[TAGT]----5'WT sub4----[CCTG]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   TAGT                   CCTG                  AGAA 
```

**Set fidelity:** 0.9978 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1449 nt | TCAA  | GTCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAA]----3'WT sub1----[GTCC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   TCAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 35 of 51 -- Codons 2058-2112 (165 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACA     | 0.8652   |
| oh2 (3' boundary) | GAAG     | 0.6752   |

**Variants:** 10290 mutations, 10290 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1770 nt | CTCG  | TAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile35_sub4   | 1648 nt | TAGT  | TACA  |
| 5   | Oligo pool      | Tile 35 (10290 oligos) | 221 nt  | TACA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[TAGT]----5'WT sub4----[TACA]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   TAGT                   TACA                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile35_sub1    | 1302 nt | GAAG  | GTCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAG]----3'WT sub1----[GTCC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   GAAG                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 36 of 51 -- Codons 2107-2179 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TATC     | 0.8041   |
| oh2 (3' boundary) | ACTT     | 0.7315   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1770 nt | CTCG  | TAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4   | 1795 nt | TAGT  | TATC  |
| 5   | Oligo pool      | Tile 36 (14070 oligos) | 275 nt  | TATC  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[TAGT]----5'WT sub4----[TATC]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   TAGT                   TATC                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile36_sub1    | 1101 nt | ACTT  | GTCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACTT]----3'WT sub1----[GTCC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   ACTT                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 37 of 51 -- Codons 2174-2232 (177 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GACC     | 0.5155   |
| oh2 (3' boundary) | TGAT     | 0.6933   |

**Variants:** 11130 mutations, 11130 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1770 nt | CTCG  | TAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile37_sub4   | 1662 nt | TAGT  | TCAA  |
| 5   | 5'WT gene block | bsai_5wt_tile37_sub5   | 364 nt  | TCAA  | GACC  |
| 6   | Oligo pool      | Tile 37 (11130 oligos) | 233 nt  | GACC  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[TAGT]----5'WT sub4----[TCAA]----5'WT sub5----[GACC]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   TAGT                   TCAA                   GACC                  AGAA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile37_sub1    | 942 nt  | TGAT  | GTCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAT]----3'WT sub1----[GTCC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   TGAT                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 38 of 51 -- Codons 2227-2287 (183 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | CCAG     | 0.6122   |

**Variants:** 11550 mutations, 11550 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1770 nt | CTCG  | TAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile37_sub4   | 1662 nt | TAGT  | TCAA  |
| 5   | 5'WT gene block | bsai_5wt_tile38_sub5   | 523 nt  | TCAA  | GAAA  |
| 6   | Oligo pool      | Tile 38 (11550 oligos) | 239 nt  | GAAA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[TAGT]----5'WT sub4----[TCAA]----5'WT sub5----[GAAA]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   TAGT                   TCAA                   GAAA                  AGAA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile38_sub1    | 777 nt  | CCAG  | GTCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCAG]----3'WT sub1----[GTCC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   CCAG                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 39 of 51 -- Codons 2282-2345 (192 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCGC     | 0.6795   |
| oh2 (3' boundary) | TGTC     | 0.6650   |

**Variants:** 12180 mutations, 12180 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1770 nt | CTCG  | TAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile37_sub4   | 1662 nt | TAGT  | TCAA  |
| 5   | 5'WT gene block | bsai_5wt_tile39_sub5   | 688 nt  | TCAA  | TCGC  |
| 6   | Oligo pool      | Tile 39 (12180 oligos) | 248 nt  | TCGC  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[TAGT]----5'WT sub4----[TCAA]----5'WT sub5----[TCGC]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   TAGT                   TCAA                   TCGC                  AGAA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile39_sub1    | 603 nt  | TGTC  | GTCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGTC]----3'WT sub1----[GTCC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   TGTC                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 40 of 51 -- Codons 2340-2405 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CGGA     | 0.6609   |
| oh2 (3' boundary) | AGAA     | 0.8847   |

**Variants:** 12600 mutations, 12600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1770 nt | CTCG  | TAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile37_sub4   | 1662 nt | TAGT  | TCAA  |
| 5   | 5'WT gene block | bsai_5wt_tile40_sub5   | 862 nt  | TCAA  | CGGA  |
| 6   | Oligo pool      | Tile 40 (12600 oligos) | 254 nt  | CGGA  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[TAGT]----5'WT sub4----[TCAA]----5'WT sub5----[CGGA]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   TAGT                   TCAA                   CGGA                  AGAA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile40_sub1    | 423 nt  | AGAA  | GTCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAA]----3'WT sub1----[GTCC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   AGAA                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 41 of 51 -- Codons 2400-2470 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAGG     | 0.5599   |
| oh2 (3' boundary) | CAAG     | 0.6640   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1770 nt | CTCG  | TAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile37_sub4   | 1662 nt | TAGT  | TCAA  |
| 5   | 5'WT gene block | bsai_5wt_tile41_sub5   | 1042 nt | TCAA  | GAGG  |
| 6   | Oligo pool      | Tile 41 (13650 oligos) | 269 nt  | GAGG  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[TAGT]----5'WT sub4----[TCAA]----5'WT sub5----[GAGG]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   TAGT                   TCAA                   GAGG                  AGAA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile41_sub1    | 228 nt  | CAAG  | GTCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAG]----3'WT sub1----[GTCC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   CAAG                   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 42 of 51 -- Codons 2465-2536 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTCC     | 0.5806   |
| oh2 (3' boundary) | GTCC     | 0.5806   |

**Variants:** 13860 mutations, 13860 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1770 nt | CTCG  | TAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile37_sub4   | 1662 nt | TAGT  | TCAA  |
| 5   | 5'WT gene block | bsai_5wt_tile42_sub5   | 1237 nt | TCAA  | GTCC  |
| 6   | Oligo pool      | Tile 42 (13860 oligos) | 272 nt  | GTCC  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[TAGT]----5'WT sub4----[TCAA]----5'WT sub5----[GTCC]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   TAGT                   TCAA                   GTCC                  AGAA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 1720 nt | GTCC  | AAGA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GTCC]----3'WT sub1----[AAGA]----3'WT+PolIII sub2----[CACC]
   GTCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 43 of 51 -- Codons 2531-2594 (192 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCGG     | 0.6343   |
| oh2 (3' boundary) | AGCC     | 0.4644   |

**Variants:** 12180 mutations, 12180 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1770 nt | CTCG  | TAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile37_sub4   | 1662 nt | TAGT  | TCAA  |
| 5   | 5'WT gene block | bsai_5wt_tile43_sub5   | 1435 nt | TCAA  | TCGG  |
| 6   | Oligo pool      | Tile 43 (12180 oligos) | 248 nt  | TCGG  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[TAGT]----5'WT sub4----[TCAA]----5'WT sub5----[TCGG]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   TAGT                   TCAA                   TCGG                  AGAA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile43_sub1    | 1546 nt | AGCC  | AAGA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGCC]----3'WT sub1----[AAGA]----3'WT+PolIII sub2----[CACC]
   AGCC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 44 of 51 -- Codons 2589-2651 (189 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTTC     | 0.8348   |
| oh2 (3' boundary) | AAGG     | 0.6552   |

**Variants:** 11970 mutations, 11970 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1770 nt | CTCG  | TAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile37_sub4   | 1662 nt | TAGT  | TCAA  |
| 5   | 5'WT gene block | bsai_5wt_tile44_sub5   | 1609 nt | TCAA  | TTTC  |
| 6   | Oligo pool      | Tile 44 (11970 oligos) | 245 nt  | TTTC  | AGAA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[TAGT]----5'WT sub4----[TCAA]----5'WT sub5----[TTTC]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   TAGT                   TCAA                   TTTC                  AGAA 
```

**Set fidelity:** 1.0000 (7 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile44_sub1    | 1375 nt | AAGG  | AAGA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAGG]----3'WT sub1----[AAGA]----3'WT+PolIII sub2----[CACC]
   AAGG                   AAGA                          CACC 
```

**Set fidelity:** 0.9121 (3 overhangs)

---

### Tile 45 of 51 -- Codons 2646-2705 (180 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GATA     | 0.7029   |
| oh2 (3' boundary) | TAGA     | 0.9115   |

**Variants:** 11340 mutations, 11340 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1770 nt | CTCG  | TAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile37_sub4   | 1662 nt | TAGT  | TCAA  |
| 5   | 5'WT gene block | bsai_5wt_tile45_sub5   | 1449 nt | TCAA  | GTCC  |
| 6   | 5'WT gene block | bsai_5wt_tile45_sub6   | 361 nt  | GTCC  | GATA  |
| 7   | Oligo pool      | Tile 45 (11340 oligos) | 236 nt  | GATA  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[TAGT]----5'WT sub4----[TCAA]----5'WT sub5----[GTCC]----5'WT sub6----[GATA]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   TAGT                   TCAA                   GTCC                   GATA                  AGAA 
```

**Set fidelity:** 1.0000 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile45_sub1    | 1213 nt | TAGA  | AAGA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAGA]----3'WT sub1----[AAGA]----3'WT+PolIII sub2----[CACC]
   TAGA                   AAGA                          CACC 
```

**Set fidelity:** 0.9644 (3 overhangs)

---

### Tile 46 of 51 -- Codons 2700-2777 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | CCTA     | 0.6679   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1770 nt | CTCG  | TAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile37_sub4   | 1662 nt | TAGT  | TCAA  |
| 5   | 5'WT gene block | bsai_5wt_tile45_sub5   | 1449 nt | TCAA  | GTCC  |
| 6   | 5'WT gene block | bsai_5wt_tile46_sub6   | 523 nt  | GTCC  | GAAA  |
| 7   | Oligo pool      | Tile 46 (15120 oligos) | 290 nt  | GAAA  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[TAGT]----5'WT sub4----[TCAA]----5'WT sub5----[GTCC]----5'WT sub6----[GAAA]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   TAGT                   TCAA                   GTCC                   GAAA                  AGAA 
```

**Set fidelity:** 1.0000 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile46_sub1    | 997 nt  | CCTA  | AAGA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTA]----3'WT sub1----[AAGA]----3'WT+PolIII sub2----[CACC]
   CCTA                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 47 of 51 -- Codons 2772-2847 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCCA     | 0.5727   |
| oh2 (3' boundary) | CCTC     | 0.5668   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1770 nt | CTCG  | TAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile37_sub4   | 1662 nt | TAGT  | TCAA  |
| 5   | 5'WT gene block | bsai_5wt_tile45_sub5   | 1449 nt | TCAA  | GTCC  |
| 6   | 5'WT gene block | bsai_5wt_tile47_sub6   | 739 nt  | GTCC  | GCCA  |
| 7   | Oligo pool      | Tile 47 (14700 oligos) | 284 nt  | GCCA  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[TAGT]----5'WT sub4----[TCAA]----5'WT sub5----[GTCC]----5'WT sub6----[GCCA]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   TAGT                   TCAA                   GTCC                   GCCA                  AGAA 
```

**Set fidelity:** 1.0000 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile47_sub1    | 787 nt  | CCTC  | AAGA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTC]----3'WT sub1----[AAGA]----3'WT+PolIII sub2----[CACC]
   CCTC                   AAGA                          CACC 
```

**Set fidelity:** 0.9923 (3 overhangs)

---

### Tile 48 of 51 -- Codons 2842-2903 (186 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGCA     | 0.5273   |
| oh2 (3' boundary) | TGTC     | 0.6650   |

**Variants:** 11760 mutations, 11760 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1770 nt | CTCG  | TAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile37_sub4   | 1662 nt | TAGT  | TCAA  |
| 5   | 5'WT gene block | bsai_5wt_tile45_sub5   | 1449 nt | TCAA  | GTCC  |
| 6   | 5'WT gene block | bsai_5wt_tile48_sub6   | 949 nt  | GTCC  | GGCA  |
| 7   | Oligo pool      | Tile 48 (11760 oligos) | 242 nt  | GGCA  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[TAGT]----5'WT sub4----[TCAA]----5'WT sub5----[GTCC]----5'WT sub6----[GGCA]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   TAGT                   TCAA                   GTCC                   GGCA                  AGAA 
```

**Set fidelity:** 1.0000 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile48_sub1    | 619 nt  | TGTC  | AAGA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGTC]----3'WT sub1----[AAGA]----3'WT+PolIII sub2----[CACC]
   TGTC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 49 of 51 -- Codons 2898-2967 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAGG     | 0.5599   |
| oh2 (3' boundary) | GAAC     | 0.6079   |

**Variants:** 13440 mutations, 13440 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1770 nt | CTCG  | TAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile37_sub4   | 1662 nt | TAGT  | TCAA  |
| 5   | 5'WT gene block | bsai_5wt_tile45_sub5   | 1449 nt | TCAA  | GTCC  |
| 6   | 5'WT gene block | bsai_5wt_tile49_sub6   | 1117 nt | GTCC  | GAGG  |
| 7   | Oligo pool      | Tile 49 (13440 oligos) | 266 nt  | GAGG  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[TAGT]----5'WT sub4----[TCAA]----5'WT sub5----[GTCC]----5'WT sub6----[GAGG]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   TAGT                   TCAA                   GTCC                   GAGG                  AGAA 
```

**Set fidelity:** 1.0000 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile49_sub1    | 427 nt  | GAAC  | AAGA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1124 nt | AAGA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAC]----3'WT sub1----[AAGA]----3'WT+PolIII sub2----[CACC]
   GAAC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 50 of 51 -- Codons 2962-3037 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | CAAG     | 0.6640   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1770 nt | CTCG  | TAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile37_sub4   | 1662 nt | TAGT  | TCAA  |
| 5   | 5'WT gene block | bsai_5wt_tile45_sub5   | 1449 nt | TCAA  | GTCC  |
| 6   | 5'WT gene block | bsai_5wt_tile50_sub6   | 1309 nt | GTCC  | GAAA  |
| 7   | Oligo pool      | Tile 50 (14700 oligos) | 284 nt  | GAAA  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[TAGT]----5'WT sub4----[TCAA]----5'WT sub5----[GTCC]----5'WT sub6----[GAAA]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   TAGT                   TCAA                   GTCC                   GAAA                  AGAA 
```

**Set fidelity:** 1.0000 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile50_sub1    | 1307 nt | CAAG  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAG]----3'WT+PolIII----[CACC]
   CAAG                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 51 of 51 -- Codons 3032-3109 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGG     | 0.5358   |
| oh2 (3' boundary) | AAGA     | 0.9209   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1248 nt | AAGA  | CAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1629 nt | CAAT  | CTCG  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1770 nt | CTCG  | TAGT  |
| 4   | 5'WT gene block | bsai_5wt_tile37_sub4   | 1662 nt | TAGT  | TCAA  |
| 5   | 5'WT gene block | bsai_5wt_tile45_sub5   | 1449 nt | TCAA  | GTCC  |
| 6   | 5'WT gene block | bsai_5wt_tile51_sub6   | 1519 nt | GTCC  | CAGG  |
| 7   | Oligo pool      | Tile 51 (13230 oligos) | 290 nt  | CAGG  | AGAA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[CAAT]----5'WT sub2----[CTCG]----5'WT sub3----[TAGT]----5'WT sub4----[TCAA]----5'WT sub5----[GTCC]----5'WT sub6----[CAGG]----oligo+BC----[AGAA]
   AAGA                   CAAT                   CTCG                   TAGT                   TCAA                   GTCC                   CAGG                  AGAA 
```

**Set fidelity:** 0.9957 (8 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component            | Part name                | Length  | 5' OH | 3' OH |
| --- | -------------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product         | (in helper plasmid)      | --      | --    | --    |
| 2   | PolIII-only fragment | bsmbi_polIII_tile51      | 1091 nt | AAGA  | CACC  |
| 3   | Enzyme + buffer      | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAGA]----PolIII----[CACC]
   AAGA                CACC 
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

- paqci_star2 (5'): `auto`
- paqci_star1 (3'): `auto`

```
[PaqCI** auto]--[gene+mutation]--[WPRE]--[spacer]--[bGH_polyA]--[PolIII]--[barcode]--[PaqCI* auto]
```

## 9. Gene Block Order Sheet

Order these gene blocks as synthesized gene fragments (e.g., Twist gene fragments, IDT gBlocks).
Gene blocks are synthesized once and reused across experiments.

**Total blocks:** 107

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| --------------------- | ----------- | ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10_sub1  | 1248        | BsaI        | 5wt_tile10_sub1;5wt_tile11_sub1;5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1;5wt_tile26_sub1;5wt_tile27_sub1;5wt_tile28_sub1;5wt_tile29_sub1;5wt_tile30_sub1;5wt_tile31_sub1;5wt_tile32_sub1;5wt_tile33_sub1;5wt_tile34_sub1;5wt_tile35_sub1;5wt_tile36_sub1;5wt_tile37_sub1;5wt_tile38_sub1;5wt_tile39_sub1;5wt_tile40_sub1;5wt_tile41_sub1;5wt_tile42_sub1;5wt_tile43_sub1;5wt_tile44_sub1;5wt_tile45_sub1;5wt_tile46_sub1;5wt_tile47_sub1;5wt_tile48_sub1;5wt_tile49_sub1;5wt_tile50_sub1;5wt_tile51_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile10_sub2  | 493         | BsaI        | 5wt_tile10_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile11_sub2  | 694         | BsaI        | 5wt_tile11_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile12_sub2  | 898         | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile13_sub2  | 1087        | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile14_sub2  | 1228        | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile15_sub2  | 1441        | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile16_sub2  | 1615        | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile17_sub2  | 1714        | BsaI        | 5wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile18_sub2  | 1629        | BsaI        | 5wt_tile18_sub2;5wt_tile19_sub2;5wt_tile20_sub2;5wt_tile21_sub2;5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2;5wt_tile26_sub2;5wt_tile27_sub2;5wt_tile28_sub2;5wt_tile29_sub2;5wt_tile30_sub2;5wt_tile31_sub2;5wt_tile32_sub2;5wt_tile33_sub2;5wt_tile34_sub2;5wt_tile35_sub2;5wt_tile36_sub2;5wt_tile37_sub2;5wt_tile38_sub2;5wt_tile39_sub2;5wt_tile40_sub2;5wt_tile41_sub2;5wt_tile42_sub2;5wt_tile43_sub2;5wt_tile44_sub2;5wt_tile45_sub2;5wt_tile46_sub2;5wt_tile47_sub2;5wt_tile48_sub2;5wt_tile49_sub2;5wt_tile50_sub2;5wt_tile51_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile18_sub3  | 310         | BsaI        | 5wt_tile18_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile19_sub3  | 448         | BsaI        | 5wt_tile19_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile2        | 244         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile20_sub3  | 595         | BsaI        | 5wt_tile20_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile21_sub3  | 811         | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile22_sub3  | 1012        | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile23_sub3  | 1210        | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile24_sub3  | 1369        | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile25_sub3  | 1585        | BsaI        | 5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile26_sub3  | 1756        | BsaI        | 5wt_tile26_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile27_sub3  | 1770        | BsaI        | 5wt_tile27_sub3;5wt_tile28_sub3;5wt_tile29_sub3;5wt_tile30_sub3;5wt_tile31_sub3;5wt_tile32_sub3;5wt_tile33_sub3;5wt_tile34_sub3;5wt_tile35_sub3;5wt_tile36_sub3;5wt_tile37_sub3;5wt_tile38_sub3;5wt_tile39_sub3;5wt_tile40_sub3;5wt_tile41_sub3;5wt_tile42_sub3;5wt_tile43_sub3;5wt_tile44_sub3;5wt_tile45_sub3;5wt_tile46_sub3;5wt_tile47_sub3;5wt_tile48_sub3;5wt_tile49_sub3;5wt_tile50_sub3;5wt_tile51_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile27_sub4  | 172         | BsaI        | 5wt_tile27_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile28_sub4  | 367         | BsaI        | 5wt_tile28_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile29_sub4  | 583         | BsaI        | 5wt_tile29_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile3        | 439         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile30_sub4  | 784         | BsaI        | 5wt_tile30_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile31_sub4  | 958         | BsaI        | 5wt_tile31_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile32_sub4  | 1144        | BsaI        | 5wt_tile32_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile33_sub4  | 1357        | BsaI        | 5wt_tile33_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile34_sub4  | 1489        | BsaI        | 5wt_tile34_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile35_sub4  | 1648        | BsaI        | 5wt_tile35_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile36_sub4  | 1795        | BsaI        | 5wt_tile36_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile37_sub4  | 1662        | BsaI        | 5wt_tile37_sub4;5wt_tile38_sub4;5wt_tile39_sub4;5wt_tile40_sub4;5wt_tile41_sub4;5wt_tile42_sub4;5wt_tile43_sub4;5wt_tile44_sub4;5wt_tile45_sub4;5wt_tile46_sub4;5wt_tile47_sub4;5wt_tile48_sub4;5wt_tile49_sub4;5wt_tile50_sub4;5wt_tile51_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile37_sub5  | 364         | BsaI        | 5wt_tile37_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile38_sub5  | 523         | BsaI        | 5wt_tile38_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile39_sub5  | 688         | BsaI        | 5wt_tile39_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile4        | 652         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile40_sub5  | 862         | BsaI        | 5wt_tile40_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile41_sub5  | 1042        | BsaI        | 5wt_tile41_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile42_sub5  | 1237        | BsaI        | 5wt_tile42_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile43_sub5  | 1435        | BsaI        | 5wt_tile43_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile44_sub5  | 1609        | BsaI        | 5wt_tile44_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile45_sub5  | 1449        | BsaI        | 5wt_tile45_sub5;5wt_tile46_sub5;5wt_tile47_sub5;5wt_tile48_sub5;5wt_tile49_sub5;5wt_tile50_sub5;5wt_tile51_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile45_sub6  | 361         | BsaI        | 5wt_tile45_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile46_sub6  | 523         | BsaI        | 5wt_tile46_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile47_sub6  | 739         | BsaI        | 5wt_tile47_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile48_sub6  | 949         | BsaI        | 5wt_tile48_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile49_sub6  | 1117        | BsaI        | 5wt_tile49_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile5        | 841         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile50_sub6  | 1309        | BsaI        | 5wt_tile50_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile51_sub6  | 1519        | BsaI        | 5wt_tile51_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile6        | 1045        | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile7        | 1234        | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile8_sub1   | 1321        | BsaI        | 5wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile9_sub1   | 1504        | BsaI        | 5wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile1_sub1  | 1020        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile1_sub2  | 1629        | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile1_sub3  | 1770        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile8_sub2;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile1_sub4  | 1662        | BsmBI       | 3wt_tile1_sub4;3wt_tile2_sub4;3wt_tile3_sub4;3wt_tile4_sub4;3wt_tile5_sub4;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub3;3wt_tile9_sub3;3wt_tile10_sub3;3wt_tile11_sub3;3wt_tile12_sub3;3wt_tile13_sub3;3wt_tile14_sub3;3wt_tile15_sub2;3wt_tile16_sub2;3wt_tile17_sub2;3wt_tile18_sub2;3wt_tile19_sub2;3wt_tile20_sub2;3wt_tile21_sub2;3wt_tile22_sub2;3wt_tile23_sub2;3wt_tile24_sub2;3wt_tile25_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile1_sub5  | 1449        | BsmBI       | 3wt_tile1_sub5;3wt_tile2_sub5;3wt_tile3_sub5;3wt_tile4_sub5;3wt_tile5_sub5;3wt_tile6_sub4;3wt_tile7_sub4;3wt_tile8_sub4;3wt_tile9_sub4;3wt_tile10_sub4;3wt_tile11_sub4;3wt_tile12_sub4;3wt_tile13_sub4;3wt_tile14_sub4;3wt_tile15_sub3;3wt_tile16_sub3;3wt_tile17_sub3;3wt_tile18_sub3;3wt_tile19_sub3;3wt_tile20_sub3;3wt_tile21_sub3;3wt_tile22_sub3;3wt_tile23_sub3;3wt_tile24_sub3;3wt_tile25_sub2;3wt_tile26_sub2;3wt_tile27_sub2;3wt_tile28_sub2;3wt_tile29_sub2;3wt_tile30_sub2;3wt_tile31_sub2;3wt_tile32_sub2;3wt_tile34_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile1_sub6  | 1720        | BsmBI       | 3wt_tile1_sub6;3wt_tile2_sub6;3wt_tile3_sub6;3wt_tile4_sub6;3wt_tile5_sub6;3wt_tile6_sub5;3wt_tile7_sub5;3wt_tile8_sub5;3wt_tile9_sub5;3wt_tile10_sub5;3wt_tile11_sub5;3wt_tile12_sub5;3wt_tile13_sub5;3wt_tile14_sub5;3wt_tile15_sub4;3wt_tile16_sub4;3wt_tile17_sub4;3wt_tile18_sub4;3wt_tile19_sub4;3wt_tile20_sub4;3wt_tile21_sub4;3wt_tile22_sub4;3wt_tile23_sub4;3wt_tile24_sub4;3wt_tile25_sub3;3wt_tile26_sub3;3wt_tile27_sub3;3wt_tile28_sub3;3wt_tile29_sub3;3wt_tile30_sub3;3wt_tile31_sub3;3wt_tile32_sub3;3wt_tile33_sub2;3wt_tile34_sub2;3wt_tile35_sub2;3wt_tile36_sub2;3wt_tile37_sub2;3wt_tile38_sub2;3wt_tile39_sub2;3wt_tile40_sub2;3wt_tile41_sub2;3wt_tile42_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile1_sub7  | 1124        | BsmBI       | 3wt_polIII_tile1_sub7;3wt_polIII_tile2_sub7;3wt_polIII_tile3_sub7;3wt_polIII_tile4_sub7;3wt_polIII_tile5_sub7;3wt_polIII_tile6_sub6;3wt_polIII_tile7_sub6;3wt_polIII_tile8_sub6;3wt_polIII_tile9_sub6;3wt_polIII_tile10_sub6;3wt_polIII_tile11_sub6;3wt_polIII_tile12_sub6;3wt_polIII_tile13_sub6;3wt_polIII_tile14_sub6;3wt_polIII_tile15_sub5;3wt_polIII_tile16_sub5;3wt_polIII_tile17_sub5;3wt_polIII_tile18_sub5;3wt_polIII_tile19_sub5;3wt_polIII_tile20_sub5;3wt_polIII_tile21_sub5;3wt_polIII_tile22_sub5;3wt_polIII_tile23_sub5;3wt_polIII_tile24_sub5;3wt_polIII_tile25_sub4;3wt_polIII_tile26_sub4;3wt_polIII_tile27_sub4;3wt_polIII_tile28_sub4;3wt_polIII_tile29_sub4;3wt_polIII_tile30_sub4;3wt_polIII_tile31_sub4;3wt_polIII_tile32_sub4;3wt_polIII_tile33_sub3;3wt_polIII_tile34_sub3;3wt_polIII_tile35_sub3;3wt_polIII_tile36_sub3;3wt_polIII_tile37_sub3;3wt_polIII_tile38_sub3;3wt_polIII_tile39_sub3;3wt_polIII_tile40_sub3;3wt_polIII_tile41_sub3;3wt_polIII_tile42_sub2;3wt_polIII_tile43_sub2;3wt_polIII_tile44_sub2;3wt_polIII_tile45_sub2;3wt_polIII_tile46_sub2;3wt_polIII_tile47_sub2;3wt_polIII_tile48_sub2;3wt_polIII_tile49_sub2 |
| bsmbi_3wt_tile10_sub1 | 951         | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile11_sub1 | 747         | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile12_sub1 | 558         | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile13_sub1 | 417         | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile14_sub1 | 204         | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile16_sub1 | 1671        | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile17_sub1 | 1476        | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile18_sub1 | 1338        | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile19_sub1 | 1191        | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile2_sub1  | 825         | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile20_sub1 | 975         | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile21_sub1 | 774         | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile22_sub1 | 576         | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile23_sub1 | 417         | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile24_sub1 | 201         | BsmBI       | 3wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile26_sub1 | 1506        | BsmBI       | 3wt_tile26_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile27_sub1 | 1311        | BsmBI       | 3wt_tile27_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile28_sub1 | 1095        | BsmBI       | 3wt_tile28_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile29_sub1 | 894         | BsmBI       | 3wt_tile29_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile3_sub1  | 612         | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile30_sub1 | 720         | BsmBI       | 3wt_tile30_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile31_sub1 | 534         | BsmBI       | 3wt_tile31_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile32_sub1 | 321         | BsmBI       | 3wt_tile32_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile33_sub1 | 1608        | BsmBI       | 3wt_tile33_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile35_sub1 | 1302        | BsmBI       | 3wt_tile35_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile36_sub1 | 1101        | BsmBI       | 3wt_tile36_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile37_sub1 | 942         | BsmBI       | 3wt_tile37_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile38_sub1 | 777         | BsmBI       | 3wt_tile38_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile39_sub1 | 603         | BsmBI       | 3wt_tile39_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile4_sub1  | 423         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile40_sub1 | 423         | BsmBI       | 3wt_tile40_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile41_sub1 | 228         | BsmBI       | 3wt_tile41_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile43_sub1 | 1546        | BsmBI       | 3wt_tile43_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile44_sub1 | 1375        | BsmBI       | 3wt_tile44_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile45_sub1 | 1213        | BsmBI       | 3wt_tile45_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile46_sub1 | 997         | BsmBI       | 3wt_tile46_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile47_sub1 | 787         | BsmBI       | 3wt_tile47_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile48_sub1 | 619         | BsmBI       | 3wt_tile48_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile49_sub1 | 427         | BsmBI       | 3wt_tile49_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile5_sub1  | 219         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile50_sub1 | 1307        | BsmBI       | 3wt_polIII_tile50_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile7_sub1  | 1542        | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile8_sub1  | 1359        | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile9_sub1  | 1152        | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_polIII_tile51   | 1091        | BsmBI       | polIII_tile51                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |

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

