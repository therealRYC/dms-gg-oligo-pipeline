# Overhang Discovery & Tile Boundary Selection: Deep-Dive Analysis

**Date:** 2026-02-28
**Pipeline:** dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)
**Genes analyzed:** GRIN2A (NM_000833.5) and AKAP11 (NM_016248.4)

---

## Table of Contents

1. [DP Tile Boundary Search](#1-dp-tile-boundary-search)
2. [Fixed Overhang Selection](#2-fixed-overhang-selection)
3. [Superblock Partitioning](#3-superblock-partitioning)
4. [Per-Reaction Overhang Sets](#4-per-reaction-overhang-sets)
5. [Gene Block Details](#5-gene-block-details)

---

## 1. DP Tile Boundary Search

The pipeline uses a dynamic programming (DP) optimizer to place tile boundaries at codon positions where the gene-derived overhangs (oh1 at the 5' boundary, oh2 at the 3' boundary) score highest under OOGGA-style scoring (Mukundan & Madhusudhan 2025). The score combines individual fidelity (Potapov 2018), ligation efficiency, and a bonus for membership in the Potapov Table 1 Set 3 high-fidelity (HF) set of 25 overhangs.

### 1.1 Shared Parameters

| Parameter | Value |
| --- | --- |
| Max oligo length | 300 nt |
| Barcode length | 20 nt |
| Fixed overhead per oligo | 64 nt (BsaI_5' 7 + oh1 4 + BsmBI_rev 11 + BsmBI_fwd 11 + barcode 20 + BsaI_rev 11) |
| Max mutable region | 234 nt (78 codons) |
| Overlap codons | 4 |
| Effective max codons per tile | 74 (78 - 4 overlap) |
| Min mutable region | 81 nt (27 codons) |
| Boundary method | DP (globally optimal) |
| Multi-K search | Yes |
| HF set | Potapov Table 1, Set 3 (25 overhangs, 95.8% predicted set fidelity) |

### 1.2 GRIN2A

**Gene:** 4395 nt, 1465 codons (after domestication of 6 enzyme sites)

#### Search Space

| Metric | Value |
| --- | --- |
| Total codon positions | 1465 |
| Candidate boundary positions | 1464 |
| Valid candidate positions | 1444 (20 invalid due to oh_L collision with ATGG/CCAT) |
| K_ideal | 19 |
| K range searched | 19, 20, 21 |

#### DP Results by K

| K | Tiles | Total Score | Avg Score per Boundary | Boundaries (codon positions) |
| --- | --- | --- | --- | --- |
| 19 | 20 | 61.9246 | 3.2592 | 73, 146, 218, 292, 366, 440, 514, 588, 662, 736, 810, 884, 957, 1028, 1098, 1172, 1246, 1319, 1393 |
| 20 | 21 | 69.5535 | 3.4777 | 73, 146, 215, 287, 358, 422, 495, 552, 620, 694, 766, 840, 909, 983, 1045, 1114, 1183, 1257, 1327, 1399 |
| **21** | **22** | **74.2576** | **3.5361** | 73, 132, 191, 259, 332, 402, 471, 533, 603, 665, 737, 810, 877, 909, 983, 1045, 1114, 1183, 1257, 1327, 1399 |

**Best K selected:** 21 (22 tiles), chosen by highest average boundary score (3.5361).

The DP prefers K=21 over K=19 despite using 2 more tiles, because it achieves a 7.8% higher average boundary quality score. More tiles allow the optimizer to "shop" more positions for high-fidelity overhangs.

#### Boundary HF Membership Summary

| Category | Count |
| --- | --- |
| Both oh1+oh2 in HF set | 0 |
| One of oh1/oh2 in HF set | 12 |
| Neither in HF set | 9 |

Note: The "both_HF" count in the DP summary (7) refers to boundaries where both sides are HF; the tile-level summary here counts per-tile oh1/oh2 HF membership, which differs because adjacent tiles share boundary overhangs.

#### GRIN2A Tile Boundary Table

| Tile | Codons | Start nt | End nt | # Codons | oh1 | oh2 | oh1 Fidelity | oh2 Fidelity | oh1 HF | oh2 HF |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | 1-77 | 1 | 231 | 77 | ATGG | CACC | 0.9459 | 0.9686 | -- | -- |
| 2 | 74-136 | 220 | 408 | 63 | ATGA | GGCT | 0.9900 | 0.7527 | HF | -- |
| 3 | 133-195 | 397 | 585 | 63 | ATGA | CTTT | 0.9900 | 0.9128 | HF | -- |
| 4 | 192-263 | 574 | 789 | 72 | GACA | TGGG | 0.9824 | 0.7954 | HF | -- |
| 5 | 260-336 | 778 | 1008 | 77 | CTTG | CCCA | 0.8824 | 0.9806 | -- | -- |
| 6 | 333-406 | 997 | 1218 | 74 | ACCT | TCTC | 0.9505 | 0.8526 | -- | -- |
| 7 | 403-475 | 1207 | 1425 | 73 | GACA | TTAC | 0.9824 | 0.9707 | HF | -- |
| 8 | 472-537 | 1414 | 1611 | 66 | AAGT | GGTT | 0.9761 | 0.8980 | HF | -- |
| 9 | 534-607 | 1600 | 1821 | 74 | AGTG | GCTT | 0.9533 | 0.9206 | HF | -- |
| 10 | 604-669 | 1810 | 2007 | 66 | GCTA | AAAG | 0.9725 | 0.9857 | -- | -- |
| 11 | 666-741 | 1996 | 2223 | 76 | AGTG | GAGG | 0.9533 | 0.8009 | HF | -- |
| 12 | 738-814 | 2212 | 2442 | 77 | AAGG | CATT | 0.9622 | 0.9202 | -- | -- |
| 13 | 811-881 | 2431 | 2643 | 71 | CAGC | GAAG | 0.9741 | 0.9224 | HF | -- |
| 14 | 878-913 | 2632 | 2739 | 36 | GAAA | CTCA | 0.9919 | 0.9674 | -- | -- |
| 15 | 910-987 | 2728 | 2961 | 78 | ATGA | TACT | 0.9900 | 0.9357 | HF | -- |
| 16 | 984-1049 | 2950 | 3147 | 66 | CATC | CCCT | 0.9199 | 0.8654 | -- | -- |
| 17 | 1046-1118 | 3136 | 3354 | 73 | CTAA | CTAC | 0.9837 | 0.9470 | HF | -- |
| 18 | 1115-1187 | 3343 | 3561 | 73 | GACA | CTAC | 0.9824 | 0.9470 | HF | -- |
| 19 | 1184-1261 | 3550 | 3783 | 78 | TATA | AGCC | 0.9433 | 0.9590 | -- | -- |
| 20 | 1258-1331 | 3772 | 3993 | 74 | GGTA | TGTC | 0.9701 | 0.8633 | HF | -- |
| 21 | 1328-1403 | 3982 | 4209 | 76 | CTGT | GTCG | 0.9203 | 0.8312 | -- | -- |
| 22 | 1400-1465 | 4198 | 4395 | 66 | TATC | TTAA | 0.9430 | 0.6923 | -- | -- |

**Notable observations:**
- Tile 14 is unusually small (36 codons, 108 nt mutable region). The DP placed a boundary at codon 909 because the surrounding gene sequence offered exceptionally high-fidelity overhangs that justified the asymmetric split.
- Tile 22's oh2 (TTAA) has the lowest fidelity in the gene at 0.6923. This is the gene's 3' terminus -- fixed by gene sequence, not a boundary choice.
- 12 out of 22 tiles have oh1 in the HF set (55%). No oh2 values are in the HF set.
- The oh1 repeat ATGA (tiles 2, 3, 15) and GACA (tiles 4, 7, 18) appear multiple times. This is safe because each tile's BsaI reaction is independent -- no cross-tile ligation.

### 1.3 AKAP11

**Gene:** 5706 nt, 1902 codons (after domestication of 5 enzyme sites)

#### Search Space

| Metric | Value |
| --- | --- |
| Total codon positions | 1902 |
| Candidate boundary positions | 1901 |
| Valid candidate positions | 1881 (20 invalid due to oh_L collision) |
| K_ideal | 25 |
| K range searched | 25, 26, 27 |

#### DP Results by K

| K | Tiles | Total Score | Avg Score per Boundary | Boundaries (codon positions) |
| --- | --- | --- | --- | --- |
| 25 | 26 | 81.5899 | 3.2636 | 74, 148, 221, 295, 369, 443, 517, 589, 663, 737, 810, 883, 957, 1030, 1104, 1178, 1252, 1326, 1400, 1474, 1546, 1619, 1691, 1756, 1828 |
| 26 | 27 | 90.5033 | 3.4809 | 64, 136, 206, 278, 351, 424, 479, 536, 608, 682, 755, 819, 890, 962, 1030, 1104, 1178, 1252, 1326, 1400, 1474, 1546, 1619, 1691, 1756, 1828 |
| **27** | **28** | **96.5022** | **3.5742** | 64, 136, 206, 278, 351, 424, 479, 536, 608, 682, 755, 819, 890, 962, 1030, 1104, 1178, 1251, 1324, 1386, 1427, 1492, 1565, 1635, 1708, 1772, 1839 |

**Best K selected:** 27 (28 tiles), chosen by highest average boundary score (3.5742).

#### Boundary HF Membership Summary

| Category | Count |
| --- | --- |
| Both oh1+oh2 in HF set | 3 |
| One of oh1/oh2 in HF set | 15 |
| Neither in HF set | 9 |

#### AKAP11 Tile Boundary Table

| Tile | Codons | Start nt | End nt | # Codons | oh1 | oh2 | oh1 Fidelity | oh2 Fidelity | oh1 HF | oh2 HF |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | 1-68 | 1 | 204 | 68 | ATGG | TGCT | 0.9459 | 0.8227 | -- | -- |
| 2 | 65-140 | 193 | 420 | 76 | GAGA | TTTT | 0.9949 | 0.9595 | -- | -- |
| 3 | 137-210 | 409 | 630 | 74 | AGGA | TACT | 0.9917 | 0.9357 | HF | -- |
| 4 | 207-282 | 619 | 846 | 76 | ATGA | CTAT | 0.9900 | 0.9729 | HF | -- |
| 5 | 279-355 | 835 | 1065 | 77 | AGGA | ATTT | 0.9917 | 0.9709 | HF | -- |
| 6 | 352-428 | 1054 | 1284 | 77 | GTAA | GTGT | 0.9872 | 0.9140 | HF | -- |
| 7 | 425-483 | 1273 | 1449 | 59 | GGTA | TTCT | 0.9701 | 0.9653 | HF | -- |
| 8 | 480-540 | 1438 | 1620 | 61 | AATC | TAAA | 0.9896 | 0.9607 | HF | -- |
| 9 | 537-612 | 1609 | 1836 | 76 | AATA | CATT | 0.9914 | 0.9202 | -- | -- |
| 10 | 609-686 | 1825 | 2058 | 78 | GAAC | AGTG | 0.9612 | 0.9533 | -- | HF |
| 11 | 683-759 | 2047 | 2277 | 77 | GACA | GGAA | 0.9824 | 0.9875 | HF | -- |
| 12 | 756-823 | 2266 | 2469 | 68 | CCAG | CACA | 0.9743 | 0.9748 | HF | -- |
| 13 | 820-894 | 2458 | 2682 | 75 | CATA | ATTG | 0.9632 | 0.9648 | HF | -- |
| 14 | 891-966 | 2671 | 2898 | 76 | ATGA | AGTA | 0.9900 | 0.9931 | HF | -- |
| 15 | 963-1034 | 2887 | 3102 | 72 | AAAA | ATCT | 0.9964 | 0.9594 | HF | -- |
| 16 | 1031-1108 | 3091 | 3324 | 78 | GGTC | ACCA | 0.8640 | 0.9920 | -- | HF |
| 17 | 1105-1182 | 3313 | 3546 | 78 | CCTC | GCTC | 0.8917 | 0.8854 | HF | -- |
| 18 | 1179-1255 | 3535 | 3765 | 77 | AGTG | AACA | 0.9533 | 0.9975 | HF | -- |
| 19 | 1252-1328 | 3754 | 3984 | 77 | AATT | TATG | 0.9846 | 0.9006 | -- | -- |
| 20 | 1325-1390 | 3973 | 4170 | 66 | AGTT | GCAG | 0.9682 | 0.8937 | -- | -- |
| 21 | 1387-1431 | 4159 | 4293 | 45 | ACCA | TGAA | 0.9920 | 0.9743 | HF | HF |
| 22 | 1428-1496 | 4282 | 4488 | 69 | AAAA | TGAA | 0.9964 | 0.9743 | HF | HF |
| 23 | 1493-1569 | 4477 | 4707 | 77 | TCTG | ATCA | 0.9313 | 0.9919 | -- | -- |
| 24 | 1566-1639 | 4696 | 4917 | 74 | ACCA | TCAG | 0.9920 | 0.9294 | HF | -- |
| 25 | 1636-1712 | 4906 | 5136 | 77 | AGTG | AGAC | 0.9533 | 0.9562 | HF | -- |
| 26 | 1709-1776 | 5125 | 5328 | 68 | GAAA | TGAG | 0.9919 | 0.8553 | -- | -- |
| 27 | 1773-1843 | 5317 | 5529 | 71 | GATT | ACTT | 0.9430 | 0.9782 | -- | -- |
| 28 | 1840-1902 | 5518 | 5706 | 63 | GTTG | ATAG | 0.8839 | 0.9777 | -- | -- |

**Notable observations:**
- Tiles 7 (59 codons) and 8 (61 codons) are notably smaller than average. The DP places these tighter boundaries to capture high-fidelity oh1 values (GGTA at 0.9701, AATC at 0.9896 -- both HF).
- Tile 21 is very small (45 codons) and has both oh1 (ACCA) and oh2 (TGAA) in the HF set -- one of only three tiles with both overhangs HF.
- Tile 10's oh2 (AGTG, fidelity 0.9533) and tiles 21/22's oh2 (TGAA, fidelity 0.9743) are both in the HF set, making AKAP11 better covered than GRIN2A for oh2 HF membership.
- ACCA appears as both an oh1 (tiles 21, 24) and an oh2 (tile 16). This creates a collision scenario discussed in Section 3.

---

## 2. Fixed Overhang Selection

Fixed overhangs (oh3, oh4) are shared across all tile reactions. They are not gene-derived but selected from the HF set (oh4) or derived from the PolIII promoter 3' end (oh3).

### 2.1 oh3 Derivation

The pipeline first attempts to derive oh3 from the last 5 nt of the PolIII promoter sequence. The promoter ends with `...GAAACACCG`, yielding:

| Component | Sequence | Notes |
| --- | --- | --- |
| Promoter terminal 5 nt | CACCG | Encodes oh3 + spacer |
| oh3 (derived) | CACC | 4-nt BsmBI overhang |
| Spacer | G | Terminal nt, used in BsmBI recognition site |
| Core PolIII | (first 245 nt of promoter) | Used in gene blocks (last 5 nt trimmed) |

**GRIN2A:**
- Promoter-derived oh3 = `CACC` (fidelity 0.9686)
- **Rejected:** CACC collides with tile 1's oh2 (`CACC`). Identical sequence means the BsmBI reaction would have ambiguous ligation.
- Fallback: oh3 selected from HF set. Best non-colliding HF candidate = `ACAA` (fidelity 0.9951).
- Strategy: `hf_set`
- Because oh3 was not promoter-derived, `core_polIII` is NULL -- the full PolIII promoter is used in gene blocks.

**AKAP11:**
- Promoter-derived oh3 = `CACC` (fidelity 0.9686)
- **Accepted:** No collision with any oh2 in the AKAP11 tile set.
- Strategy: `promoter_derived`
- oh3_spacer = `G` (used in BsmBI reverse site construction)
- core_polIII = first 245 nt of promoter (gene blocks use this truncated sequence; the junction is reconstructed seamlessly after BsmBI ligation)

### 2.2 oh4 Selection

oh4 is always selected from the HF set as the highest-fidelity candidate that does not collide with any oh1 value (identity or reverse-complement).

| Gene | oh4 | Fidelity | In HF Set | Collision Check |
| --- | --- | --- | --- | --- |
| GRIN2A | ACAA | 0.9951 | Yes | No collision with any oh1 |
| AKAP11 | ACAA | 0.9951 | Yes | No collision with any oh1 |

Both genes selected the same oh4 (ACAA), which is the highest-fidelity HF-set overhang not colliding with any gene-derived oh1.

### 2.3 Collision Check Summary

| Check | GRIN2A | AKAP11 |
| --- | --- | --- |
| oh3 vs any oh2 | No collision | No collision |
| oh3 vs RC(any oh2) | No collision | No collision |
| oh4 vs any oh1 | No collision | No collision |
| oh4 vs RC(any oh1) | No collision | No collision |
| oh3 vs oh4 | Same sequence (ACAA = ACAA) | Different (CACC vs ACAA) |
| oh3 vs RC(oh4) | ACAA vs TTGT: no | CACC vs TTGT: no |

**GRIN2A special case:** oh3 and oh4 are both `ACAA`. This is safe because oh3 is a BsmBI overhang and oh4 is a BsaI overhang -- they appear in different enzymatic reactions and never compete in the same ligation pot.

### 2.4 Fixed Overhang Summary

| Property | GRIN2A | AKAP11 |
| --- | --- | --- |
| oh_L (gene start) | ATGG | ATGG |
| oh3 | ACAA | CACC |
| oh3 source | HF set (fallback) | Promoter-derived |
| oh3 fidelity | 0.9951 | 0.9686 |
| oh3 in HF set | Yes | No |
| oh4 | ACAA | ACAA |
| oh4 fidelity | 0.9951 | 0.9951 |
| oh4 in HF set | Yes | Yes |
| PaqCI** (paqci_star2) | AGTC | AGTC |
| PaqCI* (paqci_star1) | TCGA | TCGA |

---

## 3. Superblock Partitioning

When 5'WT or 3'WT gene blocks exceed the 1800 nt synthesis limit, the gene is partitioned into superblocks at tile boundaries. Each superblock boundary introduces a BsmBI junction overhang (the oh2 of the boundary tile) into the BsmBI reactions of tiles that span past that boundary.

### 3.1 GRIN2A Superblock Partition

**Result:** 3 superblocks, 2 boundaries, 0 unresolved collisions

| Superblock | Tiles | Gene Content (nt) |
| --- | --- | --- |
| SB1 | 1-8 | 1611 |
| SB2 | 9-17 | 1743 |
| SB3 | 18-22 | 1041 |

#### Boundary Junction Details

| Boundary | Position | Tile | Junction OH | Fidelity | In HF Set |
| --- | --- | --- | --- | --- | --- |
| 1 | nt 1611 | 8 | GGTT | 0.8980 | No |
| 2 | nt 3354 | 17 | CTAC | 0.9470 | No |

#### GRIN2A Collision Detection

| Check | Boundary 1 (GGTT) | Boundary 2 (CTAC) |
| --- | --- | --- |
| vs oh3 (ACAA) | ok | ok |
| vs oh4 (ACAA) | ok | ok |
| vs other boundary | ok (GGTT vs CTAC) | ok (CTAC vs GGTT) |
| vs any later oh1 | ok | ok |

**All collision checks passed.** No shift resolution needed.

### 3.2 AKAP11 Superblock Partition

**Result:** 4 superblocks, 3 boundaries, 1 unresolved collision

| Superblock | Tiles | Gene Content (nt) |
| --- | --- | --- |
| SB1 | 1-8 | 1620 |
| SB2 | 9-16 | 1704 |
| SB3 | 17-24 | 1593 |
| SB4 | 25-28 | 789 |

#### Boundary Junction Details

| Boundary | Position | Tile | Junction OH | Fidelity | In HF Set |
| --- | --- | --- | --- | --- | --- |
| 1 | nt 1620 | 8 | TAAA | 0.9607 | No |
| 2 | nt 3324 | 16 | ACCA | 0.9920 | Yes |
| 3 | nt 4917 | 24 | TCAG | 0.9294 | No |

#### AKAP11 Collision Detection

| Check | Boundary 1 (TAAA) | Boundary 2 (ACCA) | Boundary 3 (TCAG) |
| --- | --- | --- | --- |
| vs oh3 (CACC) | ok | ok | ok |
| vs oh4 (ACAA) | ok | ok | ok |
| vs boundary 1 | -- | ok | ok |
| vs boundary 2 | ok | -- | ok |
| vs boundary 3 | ok | ok | -- |
| vs later oh1 values | ok | **COLLISION** | ok |

#### The ACCA Collision (Boundary 2)

**Root cause:** Boundary 2's junction overhang is `ACCA` (tile 16's oh2_seq). Tiles 21 and 24 have `oh1_seq = ACCA`. These tiles are in superblock 3 (after the boundary), meaning their 5'WT BsaI blocks span past boundary 2. The superblock junction overhang `ACCA` appears as a BsaI-level junction, and tile 21/24's oh1 is also `ACCA` in the same BsaI reaction -- creating ambiguous ligation at that overhang.

**Shift resolution attempted:** The pipeline tried shifting boundary 2 to adjacent tiles (tiles 15, 17, 14, 18, ...) within +/-5 tiles. Each candidate was checked for both (a) synthesis size constraints and (b) collision-free junction overhang. No collision-free shift was found that also satisfied the gene block size limit.

**Result:** 1 unresolved collision. The pipeline proceeds with a warning. In practice, the ACCA collision at the BsaI level means tiles 21 and 24 will have an additional overhang match in their 5'WT BsaI reaction. The set fidelity for these tiles (0.9950 and 0.9950 respectively) remains acceptable because the ACCA overhangs ligate at the correct junction -- the risk is a slight increase in off-target ligation products.

### 3.3 Cassette Splitting

| Gene | Cassette (PolIII) length | Max sub-block content | Cassette needs splitting? |
| --- | --- | --- | --- |
| GRIN2A | 250 nt | 1778 nt | No |
| AKAP11 | 250 nt | 1778 nt | No |

Neither gene requires downstream cassette splitting since the PolIII promoter (250 nt) is well under the synthesis limit.

---

## 4. Per-Reaction Overhang Sets

Each tile has two Golden Gate reactions: a BsaI Level 1 reaction (oligo + 5'WT blocks into helper plasmid) and a BsmBI Level 1b reaction (3'WT + PolIII blocks between tile and barcode). The overhangs in each reaction must be mutually orthogonal with high set-level fidelity.

**Fidelity threshold:** 0.95

### 4.1 GRIN2A Per-Reaction Fidelity

**Overall minimum set fidelity:** 0.9278 (tile 1 BsmBI)
**Reactions below threshold:** 1 of 44

#### BsaI Reactions

| Tile | Overhangs | # OHs | # in HF | Set Fidelity | Flag |
| --- | --- | --- | --- | --- | --- |
| 1 | ATGG, ACAA | 2 | 1 | 0.9964 | |
| 2 | ATGG, ATGA, ACAA | 3 | 2 | 0.9947 | |
| 3 | ATGG, ATGA, ACAA | 3 | 2 | 0.9947 | |
| 4 | ATGG, GACA, ACAA | 3 | 2 | 0.9962 | |
| 5 | ATGG, CTTG, ACAA | 3 | 1 | 0.9955 | |
| 6 | ATGG, ACCT, ACAA | 3 | 1 | 0.9905 | |
| 7 | ATGG, GACA, ACAA | 3 | 2 | 0.9962 | |
| 8 | ATGG, AAGT, ACAA | 3 | 2 | 0.9939 | |
| 9 | ATGG, AGTG, ACAA | 3 | 2 | 0.9962 | |
| 10 | ATGG, GCTA, ACAA, GGTT | 4 | 1 | 0.9940 | |
| 11 | ATGG, AGTG, ACAA, GGTT | 4 | 2 | 0.9937 | |
| 12 | ATGG, AAGG, ACAA, GGTT | 4 | 1 | 0.9886 | |
| 13 | ATGG, CAGC, ACAA, GGTT | 4 | 2 | 0.9851 | |
| 14 | ATGG, GAAA, ACAA, GGTT | 4 | 1 | 0.9938 | |
| 15 | ATGG, ATGA, ACAA, GGTT | 4 | 2 | 0.9925 | |
| 16 | ATGG, CATC, ACAA, GGTT | 4 | 1 | 0.9871 | |
| 17 | ATGG, CTAA, ACAA, GGTT | 4 | 2 | 0.9908 | |
| 18 | ATGG, GACA, ACAA, GGTT | 4 | 2 | 0.9881 | |
| 19 | ATGG, TATA, ACAA, GGTT, CTAC | 5 | 1 | 0.9873 | |
| 20 | ATGG, GGTA, ACAA, GGTT, CTAC | 5 | 2 | 0.9872 | |
| 21 | ATGG, CTGT, ACAA, GGTT, CTAC | 5 | 1 | 0.9603 | |
| 22 | ATGG, TATC, ACAA, GGTT, CTAC | 5 | 1 | 0.9829 | |

Tiles 1-8 (SB1) have 2-3 BsaI overhangs. Tiles 9-17 (SB2) have 4, picking up the SB1 junction overhang GGTT. Tiles 18-22 (SB3) have 5, picking up both GGTT and CTAC.

#### BsmBI Reactions

| Tile | Overhangs | # OHs | # in HF | Set Fidelity | Flag |
| --- | --- | --- | --- | --- | --- |
| 1 | CACC, GGTT, CTAC, ACAA | 4 | 1 | **0.9278** | **BELOW** |
| 2 | GGCT, GGTT, CTAC, ACAA | 4 | 1 | 0.9952 | |
| 3 | CTTT, GGTT, CTAC, ACAA | 4 | 1 | 0.9945 | |
| 4 | TGGG, GGTT, CTAC, ACAA | 4 | 1 | 0.9920 | |
| 5 | CCCA, GGTT, CTAC, ACAA | 4 | 1 | 0.9973 | |
| 6 | TCTC, GGTT, CTAC, ACAA | 4 | 1 | 0.9973 | |
| 7 | TTAC, GGTT, CTAC, ACAA | 4 | 1 | 0.9928 | |
| 8 | GGTT, CTAC, ACAA | 3 | 1 | 0.9982 | |
| 9 | GCTT, CTAC, ACAA | 3 | 1 | 0.9982 | |
| 10 | AAAG, CTAC, ACAA | 3 | 1 | 0.9956 | |
| 11 | GAGG, CTAC, ACAA | 3 | 1 | 0.9929 | |
| 12 | CATT, CTAC, ACAA | 3 | 1 | 0.9991 | |
| 13 | GAAG, CTAC, ACAA | 3 | 1 | 0.9657 | |
| 14 | CTCA, CTAC, ACAA | 3 | 1 | 0.9986 | |
| 15 | TACT, CTAC, ACAA | 3 | 1 | 0.9973 | |
| 16 | CCCT, CTAC, ACAA | 3 | 1 | 0.9990 | |
| 17 | CTAC, ACAA | 2 | 1 | 0.9996 | |
| 18 | CTAC, ACAA | 2 | 1 | 0.9996 | |
| 19 | AGCC, ACAA | 2 | 1 | 0.9999 | |
| 20 | TGTC, ACAA | 2 | 1 | 0.9996 | |
| 21 | GTCG, ACAA | 2 | 1 | 0.9993 | |
| 22 | TTAA, ACAA | 2 | 1 | 0.9991 | |

**Flagged reaction:** Tile 1 BsmBI (set fidelity 0.9278 < 0.95 threshold). This is the lowest-fidelity reaction in the GRIN2A design. It occurs because tile 1 is in SB1 and its 3'WT region spans the entire gene downstream -- all three BsmBI overhangs (GGTT, CTAC from SB boundaries, plus ACAA from oh3) are present. The CACC overhang (tile 1's oh2) has moderate fidelity (0.9686) but the 4-overhang set's combined fidelity is dragged down by cross-reactivity between CACC and CTAC (similar sequences).

### 4.2 AKAP11 Per-Reaction Fidelity

**Overall minimum set fidelity:** 0.9219 (tile 10 BsmBI)
**Reactions below threshold:** 1 of 56

#### BsaI Reactions

| Tile | Overhangs | # OHs | # in HF | Set Fidelity | Flag |
| --- | --- | --- | --- | --- | --- |
| 1 | ATGG, ACAA | 2 | 1 | 0.9964 | |
| 2 | ATGG, GAGA, ACAA | 3 | 1 | 0.9961 | |
| 3 | ATGG, AGGA, ACAA | 3 | 2 | 0.9961 | |
| 4 | ATGG, ATGA, ACAA | 3 | 2 | 0.9947 | |
| 5 | ATGG, AGGA, ACAA | 3 | 2 | 0.9961 | |
| 6 | ATGG, GTAA, ACAA | 3 | 2 | 0.9956 | |
| 7 | ATGG, GGTA, ACAA | 3 | 2 | 0.9963 | |
| 8 | ATGG, AATC, ACAA | 3 | 2 | 0.9963 | |
| 9 | ATGG, AATA, ACAA | 3 | 1 | 0.9963 | |
| 10 | ATGG, GAAC, ACAA, TAAA | 4 | 1 | 0.9950 | |
| 11 | ATGG, GACA, ACAA, TAAA | 4 | 2 | 0.9952 | |
| 12 | ATGG, CCAG, ACAA, TAAA | 4 | 2 | 0.9527 | |
| 13 | ATGG, CATA, ACAA, TAAA | 4 | 2 | 0.9932 | |
| 14 | ATGG, ATGA, ACAA, TAAA | 4 | 2 | 0.9926 | |
| 15 | ATGG, AAAA, ACAA, TAAA | 4 | 2 | 0.9953 | |
| 16 | ATGG, GGTC, ACAA, TAAA | 4 | 1 | 0.9949 | |
| 17 | ATGG, CCTC, ACAA, TAAA | 4 | 2 | 0.9889 | |
| 18 | ATGG, AGTG, ACAA, TAAA, ACCA | 5 | 3 | 0.9934 | |
| 19 | ATGG, AATT, ACAA, TAAA, ACCA | 5 | 2 | 0.9935 | |
| 20 | ATGG, AGTT, ACAA, TAAA, ACCA | 5 | 2 | 0.9897 | |
| 21 | ATGG, ACCA, ACAA, TAAA | 4 | 2 | 0.9950 | |
| 22 | ATGG, AAAA, ACAA, TAAA, ACCA | 5 | 3 | 0.9944 | |
| 23 | ATGG, TCTG, ACAA, TAAA, ACCA | 5 | 2 | 0.9912 | |
| 24 | ATGG, ACCA, ACAA, TAAA | 4 | 2 | 0.9950 | |
| 25 | ATGG, AGTG, ACAA, TAAA, ACCA | 5 | 3 | 0.9934 | |
| 26 | ATGG, GAAA, ACAA, TAAA, ACCA, TCAG | 6 | 2 | 0.9890 | |
| 27 | ATGG, GATT, ACAA, TAAA, ACCA, TCAG | 6 | 2 | 0.9875 | |
| 28 | ATGG, GTTG, ACAA, TAAA, ACCA, TCAG | 6 | 2 | 0.9814 | |

Tiles in SB4 (25-28) have the most BsaI overhangs (5-6), accumulating junction OHs from all three SB boundaries. Tile 28 has 6 BsaI overhangs with set fidelity 0.9814 -- acceptable but the lowest among BsaI reactions.

#### BsmBI Reactions

| Tile | Overhangs | # OHs | # in HF | Set Fidelity | Flag |
| --- | --- | --- | --- | --- | --- |
| 1 | TGCT, TAAA, ACCA, TCAG, CACC | 5 | 1 | 0.9602 | |
| 2 | TTTT, TAAA, ACCA, TCAG, CACC | 5 | 1 | 0.9862 | |
| 3 | TACT, TAAA, ACCA, TCAG, CACC | 5 | 1 | 0.9939 | |
| 4 | CTAT, TAAA, ACCA, TCAG, CACC | 5 | 1 | 0.9938 | |
| 5 | ATTT, TAAA, ACCA, TCAG, CACC | 5 | 1 | 0.9941 | |
| 6 | GTGT, TAAA, ACCA, TCAG, CACC | 5 | 1 | 0.9836 | |
| 7 | TTCT, TAAA, ACCA, TCAG, CACC | 5 | 1 | 0.9931 | |
| 8 | TAAA, ACCA, TCAG, CACC | 4 | 1 | 0.9977 | |
| 9 | CATT, ACCA, TCAG, CACC | 4 | 1 | 0.9961 | |
| 10 | AGTG, ACCA, TCAG, CACC | 4 | 2 | **0.9219** | **BELOW** |
| 11 | GGAA, ACCA, TCAG, CACC | 4 | 1 | 0.9894 | |
| 12 | CACA, ACCA, TCAG, CACC | 4 | 1 | 0.9939 | |
| 13 | ATTG, ACCA, TCAG, CACC | 4 | 1 | 0.9883 | |
| 14 | AGTA, ACCA, TCAG, CACC | 4 | 1 | 0.9893 | |
| 15 | ATCT, ACCA, TCAG, CACC | 4 | 1 | 0.9973 | |
| 16 | ACCA, TCAG, CACC | 3 | 1 | 0.9984 | |
| 17 | GCTC, TCAG, CACC | 3 | 0 | 0.9881 | |
| 18 | AACA, TCAG, CACC | 3 | 0 | 0.9985 | |
| 19 | TATG, TCAG, CACC | 3 | 0 | 0.9904 | |
| 20 | GCAG, TCAG, CACC | 3 | 0 | 0.9879 | |
| 21 | TGAA, TCAG, CACC | 3 | 1 | 0.9977 | |
| 22 | TGAA, TCAG, CACC | 3 | 1 | 0.9977 | |
| 23 | ATCA, TCAG, CACC | 3 | 0 | 0.9959 | |
| 24 | TCAG, CACC | 2 | 0 | 0.9989 | |
| 25 | AGAC, CACC | 2 | 0 | 0.9986 | |
| 26 | TGAG, CACC | 2 | 0 | 0.9910 | |
| 27 | ACTT, CACC | 2 | 0 | 0.9989 | |
| 28 | ATAG, CACC | 2 | 0 | 0.9989 | |

**Flagged reaction:** Tile 10 BsmBI (set fidelity 0.9219 < 0.95 threshold). Tile 10 is in SB2 and its oh2 is AGTG (which is also an HF-set member). The 4-overhang set {AGTG, ACCA, TCAG, CACC} has reduced fidelity because AGTG has moderate cross-reactivity with the other overhangs in the context-dependent pairwise matrix. Despite AGTG being individually high-fidelity (0.9533), its set-level performance with these particular partners is lower.

### 4.3 Fidelity Distribution Comparison

| Statistic | GRIN2A BsaI | GRIN2A BsmBI | AKAP11 BsaI | AKAP11 BsmBI |
| --- | --- | --- | --- | --- |
| Min | 0.9603 | 0.9278 | 0.9527 | 0.9219 |
| Max | 0.9964 | 0.9999 | 0.9964 | 0.9989 |
| Median | 0.9925 | 0.9963 | 0.9934 | 0.9939 |
| # below 0.95 | 0 | 1 | 0 | 1 |

---

## 5. Gene Block Details

Gene blocks are synthesized as double-stranded DNA fragments (e.g., Twist gene fragments). Each block is flanked by enzyme recognition sites for assembly.

### 5.1 GRIN2A Gene Blocks

**Total blocks:** 45 (after deduplication from 82 pre-dedup)
**Length range:** 204-1761 nt
**Short blocks (below 300 nt):** 5

| Block Name | Length | Enzyme | Gene Region | 5' OH | 3' OH |
| --- | --- | --- | --- | --- | --- |
| bsmbi_3wt_tile1_sub1 | 1398 | BsmBI | 3wt_tile1_sub1 | CACC | GGTT |
| bsmbi_3wt_tile1_sub2 | 1761 | BsmBI | 3wt shared (tiles 1-8) | GGTT | CTAC |
| bsmbi_3wt_tile1_sub3 | 1313 | BsmBI | 3wt_polIII shared (16 tiles) | CTAC | ACAA |
| bsai_5wt_tile2 | **237** | BsaI | 5wt_tile2 | ATGG | ATGA |
| bsmbi_3wt_tile2_sub1 | 1221 | BsmBI | 3wt_tile2_sub1 | GGCT | GGTT |
| bsai_5wt_tile3 | 414 | BsaI | 5wt_tile3 | ATGG | ATGA |
| bsmbi_3wt_tile3_sub1 | 1044 | BsmBI | 3wt_tile3_sub1 | CTTT | GGTT |
| bsai_5wt_tile4 | 591 | BsaI | 5wt_tile4 | ATGG | GACA |
| bsmbi_3wt_tile4_sub1 | 840 | BsmBI | 3wt_tile4_sub1 | TGGG | GGTT |
| bsai_5wt_tile5 | 795 | BsaI | 5wt_tile5 | ATGG | CTTG |
| bsmbi_3wt_tile5_sub1 | 621 | BsmBI | 3wt_tile5_sub1 | CCCA | GGTT |
| bsai_5wt_tile6 | 1014 | BsaI | 5wt_tile6 | ATGG | ACCT |
| bsmbi_3wt_tile6_sub1 | 411 | BsmBI | 3wt_tile6_sub1 | TCTC | GGTT |
| bsai_5wt_tile7 | 1224 | BsaI | 5wt_tile7 | ATGG | GACA |
| bsmbi_3wt_tile7_sub1 | **204** | BsmBI | 3wt_tile7_sub1 | TTAC | GGTT |
| bsai_5wt_tile8 | 1431 | BsaI | 5wt_tile8 | ATGG | AAGT |
| bsai_5wt_tile9 | 1617 | BsaI | 5wt_tile9 | ATGG | AGTG |
| bsmbi_3wt_tile9_sub1 | 1551 | BsmBI | 3wt_tile9_sub1 | GCTT | CTAC |
| bsai_5wt_tile10_sub1 | 1625 | BsaI | 5wt shared (13 tiles) | ATGG | GGTT |
| bsai_5wt_tile10_sub2 | **220** | BsaI | 5wt_tile10_sub2 | GGTT | GCTA |
| bsmbi_3wt_tile10_sub1 | 1365 | BsmBI | 3wt_tile10_sub1 | AAAG | CTAC |
| bsai_5wt_tile11_sub2 | 406 | BsaI | 5wt_tile11_sub2 | GGTT | AGTG |
| bsmbi_3wt_tile11_sub1 | 1149 | BsmBI | 3wt_tile11_sub1 | GAGG | CTAC |
| bsai_5wt_tile12_sub2 | 622 | BsaI | 5wt_tile12_sub2 | GGTT | AAGG |
| bsmbi_3wt_tile12_sub1 | 930 | BsmBI | 3wt_tile12_sub1 | CATT | CTAC |
| bsai_5wt_tile13_sub2 | 841 | BsaI | 5wt_tile13_sub2 | GGTT | CAGC |
| bsmbi_3wt_tile13_sub1 | 729 | BsmBI | 3wt_tile13_sub1 | GAAG | CTAC |
| bsai_5wt_tile14_sub2 | 1042 | BsaI | 5wt_tile14_sub2 | GGTT | GAAA |
| bsmbi_3wt_tile14_sub1 | 633 | BsmBI | 3wt_tile14_sub1 | CTCA | CTAC |
| bsai_5wt_tile15_sub2 | 1138 | BsaI | 5wt_tile15_sub2 | GGTT | ATGA |
| bsmbi_3wt_tile15_sub1 | 411 | BsmBI | 3wt_tile15_sub1 | TACT | CTAC |
| bsai_5wt_tile16_sub2 | 1360 | BsaI | 5wt_tile16_sub2 | GGTT | CATC |
| bsmbi_3wt_tile16_sub1 | 1520 | BsmBI | 3wt_polIII_tile16 | CCCT | ACAA |
| bsai_5wt_tile17_sub2 | 1546 | BsaI | 5wt_tile17_sub2 | GGTT | CTAA |
| bsai_5wt_tile18_sub2 | 1753 | BsaI | 5wt_tile18_sub2 | GGTT | GACA |
| bsmbi_3wt_tile18 | 1106 | BsmBI | 3wt_polIII_tile18 | CTAC | ACAA |
| bsai_5wt_tile19_sub2 | 1761 | BsaI | 5wt shared (4 tiles) | GGTT | CTAC |
| bsai_5wt_tile19_sub3 | **217** | BsaI | 5wt_tile19_sub3 | CTAC | TATA |
| bsmbi_3wt_tile19 | 884 | BsmBI | 3wt_polIII_tile19 | AGCC | ACAA |
| bsai_5wt_tile20_sub3 | 439 | BsaI | 5wt_tile20_sub3 | CTAC | GGTA |
| bsmbi_3wt_tile20 | 674 | BsmBI | 3wt_polIII_tile20 | TGTC | ACAA |
| bsai_5wt_tile21_sub3 | 649 | BsaI | 5wt_tile21_sub3 | CTAC | CTGT |
| bsmbi_3wt_tile21 | 458 | BsmBI | 3wt_polIII_tile21 | GTCG | ACAA |
| bsai_5wt_tile22_sub3 | 865 | BsaI | 5wt_tile22_sub3 | CTAC | TATC |
| bsmbi_polIII_tile22 | **272** | BsmBI | polIII_tile22 | TTAA | ACAA |

#### Short Block Explanation (GRIN2A)

| Block | Length | Why Short |
| --- | --- | --- |
| bsai_5wt_tile2 | 237 nt | Tile 2 starts at codon 74 (nt 220). The 5'WT region is only nt 1-219 = 219 nt content + 18 nt enzyme sites = 237 nt total. |
| bsmbi_3wt_tile7_sub1 | 204 nt | Tile 7 ends at nt 1425. Its 3'WT sub-block 1 spans nt 1425-1611 (SB1 boundary) = 186 nt content + 22 nt enzyme sites. Very close to the SB boundary. |
| bsai_5wt_tile10_sub2 | 220 nt | Second sub-block of tile 10's 5'WT. After the SB1 junction (GGTT at nt 1611), only 199 nt remain to tile 10's start (nt 1810). |
| bsai_5wt_tile19_sub3 | 217 nt | Third sub-block of tile 19's 5'WT, after both SB junctions. Only 196 nt of gene content remaining. |
| bsmbi_polIII_tile22 | 272 nt | Last tile's BsmBI block contains only the PolIII promoter (250 nt) + enzyme sites. No gene content needed since tile 22 ends at the gene terminus. |

### 5.2 AKAP11 Gene Blocks

**Total blocks:** 58 (after deduplication from 132 pre-dedup)
**Length range:** 189-1722 nt
**Short blocks (below 300 nt):** 7

| Block Name | Length | Enzyme | Gene Region | 5' OH | 3' OH |
| --- | --- | --- | --- | --- | --- |
| bsmbi_3wt_tile1_sub1 | 1434 | BsmBI | 3wt_tile1_sub1 | TGCT | TAAA |
| bsmbi_3wt_tile1_sub2 | 1722 | BsmBI | 3wt shared (tiles 1-8) | TAAA | ACCA |
| bsmbi_3wt_tile1_sub3 | 1611 | BsmBI | 3wt shared (16 tiles) | ACCA | TCAG |
| bsmbi_3wt_tile1_sub4 | 1056 | BsmBI | 3wt_polIII shared (23 tiles) | TCAG | CACC |
| bsai_5wt_tile2 | **210** | BsaI | 5wt_tile2 | ATGG | GAGA |
| bsmbi_3wt_tile2_sub1 | 1218 | BsmBI | 3wt_tile2_sub1 | TTTT | TAAA |
| bsai_5wt_tile3 | 426 | BsaI | 5wt_tile3 | ATGG | AGGA |
| bsmbi_3wt_tile3_sub1 | 1008 | BsmBI | 3wt_tile3_sub1 | TACT | TAAA |
| bsai_5wt_tile4 | 636 | BsaI | 5wt_tile4 | ATGG | ATGA |
| bsmbi_3wt_tile4_sub1 | 792 | BsmBI | 3wt_tile4_sub1 | CTAT | TAAA |
| bsai_5wt_tile5 | 852 | BsaI | 5wt_tile5 | ATGG | AGGA |
| bsmbi_3wt_tile5_sub1 | 573 | BsmBI | 3wt_tile5_sub1 | ATTT | TAAA |
| bsai_5wt_tile6 | 1071 | BsaI | 5wt_tile6 | ATGG | GTAA |
| bsmbi_3wt_tile6_sub1 | 354 | BsmBI | 3wt_tile6_sub1 | GTGT | TAAA |
| bsai_5wt_tile7 | 1290 | BsaI | 5wt_tile7 | ATGG | GGTA |
| bsmbi_3wt_tile7_sub1 | **189** | BsmBI | 3wt_tile7_sub1 | TTCT | TAAA |
| bsai_5wt_tile8 | 1455 | BsaI | 5wt_tile8 | ATGG | AATC |
| bsai_5wt_tile9 | 1626 | BsaI | 5wt_tile9 | ATGG | AATA |
| bsmbi_3wt_tile9_sub1 | 1506 | BsmBI | 3wt_tile9_sub1 | CATT | ACCA |
| bsai_5wt_tile10_sub1 | 1634 | BsaI | 5wt shared (19 tiles) | ATGG | TAAA |
| bsai_5wt_tile10_sub2 | **226** | BsaI | 5wt_tile10_sub2 | TAAA | GAAC |
| bsmbi_3wt_tile10_sub1 | 1284 | BsmBI | 3wt_tile10_sub1 | AGTG | ACCA |
| bsai_5wt_tile11_sub2 | 448 | BsaI | 5wt_tile11_sub2 | TAAA | GACA |
| bsmbi_3wt_tile11_sub1 | 1065 | BsmBI | 3wt_tile11_sub1 | GGAA | ACCA |
| bsai_5wt_tile12_sub2 | 667 | BsaI | 5wt_tile12_sub2 | TAAA | CCAG |
| bsmbi_3wt_tile12_sub1 | 873 | BsmBI | 3wt_tile12_sub1 | CACA | ACCA |
| bsai_5wt_tile13_sub2 | 859 | BsaI | 5wt_tile13_sub2 | TAAA | CATA |
| bsmbi_3wt_tile13_sub1 | 660 | BsmBI | 3wt_tile13_sub1 | ATTG | ACCA |
| bsai_5wt_tile14_sub2 | 1072 | BsaI | 5wt_tile14_sub2 | TAAA | ATGA |
| bsmbi_3wt_tile14_sub1 | 444 | BsmBI | 3wt_tile14_sub1 | AGTA | ACCA |
| bsai_5wt_tile15_sub2 | 1288 | BsaI | 5wt_tile15_sub2 | TAAA | AAAA |
| bsmbi_3wt_tile15_sub1 | **240** | BsmBI | 3wt_tile15_sub1 | ATCT | ACCA |
| bsai_5wt_tile16_sub2 | 1492 | BsaI | 5wt_tile16_sub2 | TAAA | GGTC |
| bsai_5wt_tile17_sub2 | 1714 | BsaI | 5wt_tile17_sub2 | TAAA | CCTC |
| bsmbi_3wt_tile17_sub1 | 1389 | BsmBI | 3wt_tile17_sub1 | GCTC | TCAG |
| bsai_5wt_tile18_sub2 | 1722 | BsaI | 5wt shared (11 tiles) | TAAA | ACCA |
| bsai_5wt_tile18_sub3 | **232** | BsaI | 5wt_tile18_sub3 | ACCA | AGTG |
| bsmbi_3wt_tile18_sub1 | 1170 | BsmBI | 3wt_tile18_sub1 | AACA | TCAG |
| bsai_5wt_tile19_sub3 | 451 | BsaI | 5wt_tile19_sub3 | ACCA | AATT |
| bsmbi_3wt_tile19_sub1 | 951 | BsmBI | 3wt_tile19_sub1 | TATG | TCAG |
| bsai_5wt_tile20_sub3 | 670 | BsaI | 5wt_tile20_sub3 | ACCA | AGTT |
| bsmbi_3wt_tile20_sub1 | 765 | BsmBI | 3wt_tile20_sub1 | GCAG | TCAG |
| bsai_5wt_tile21_sub3 | 856 | BsaI | 5wt_tile21_sub3 | ACCA | ACCA |
| bsmbi_3wt_tile21_sub1 | 642 | BsmBI | 3wt_tile21_sub1 | TGAA | TCAG |
| bsai_5wt_tile22_sub3 | 979 | BsaI | 5wt_tile22_sub3 | ACCA | AAAA |
| bsmbi_3wt_tile22_sub1 | 447 | BsmBI | 3wt_tile22_sub1 | TGAA | TCAG |
| bsai_5wt_tile23_sub3 | 1174 | BsaI | 5wt_tile23_sub3 | ACCA | TCTG |
| bsmbi_3wt_tile23_sub1 | 1266 | BsmBI | 3wt_polIII_tile23 | ATCA | CACC |
| bsai_5wt_tile24_sub3 | 1393 | BsaI | 5wt_tile24_sub3 | ACCA | ACCA |
| bsai_5wt_tile25_sub3 | 1603 | BsaI | 5wt_tile25_sub3 | ACCA | AGTG |
| bsmbi_3wt_tile25 | 837 | BsmBI | 3wt_polIII_tile25 | AGAC | CACC |
| bsai_5wt_tile26_sub3 | 1611 | BsaI | 5wt shared (3 tiles) | ACCA | TCAG |
| bsai_5wt_tile26_sub4 | **229** | BsaI | 5wt_tile26_sub4 | TCAG | GAAA |
| bsmbi_3wt_tile26 | 645 | BsmBI | 3wt_polIII_tile26 | TGAG | CACC |
| bsai_5wt_tile27_sub4 | 421 | BsaI | 5wt_tile27_sub4 | TCAG | GATT |
| bsmbi_3wt_tile27 | 444 | BsmBI | 3wt_polIII_tile27 | ACTT | CACC |
| bsai_5wt_tile28_sub4 | 622 | BsaI | 5wt_tile28_sub4 | TCAG | GTTG |
| bsmbi_polIII_tile28 | **267** | BsmBI | polIII_tile28 | ATAG | CACC |

#### Short Block Explanation (AKAP11)

| Block | Length | Why Short |
| --- | --- | --- |
| bsai_5wt_tile2 | 210 nt | Tile 2 starts at codon 65 (nt 193). 5'WT content = 192 nt + 18 nt enzyme sites = 210 nt. |
| bsmbi_3wt_tile7_sub1 | 189 nt | Tile 7 ends at nt 1449. Its 3'WT sub-block 1 spans nt 1449-1620 (SB1 boundary) = 171 nt content + 22 nt enzyme sites. This is the shortest block across both genes. |
| bsai_5wt_tile10_sub2 | 226 nt | Second 5'WT sub-block after SB1 junction. Short span from TAAA junction (nt 1620) to tile 10 start (nt 1825). |
| bsmbi_3wt_tile15_sub1 | 240 nt | Tile 15 ends at nt 3102; SB2 boundary at nt 3324. Sub-block 1 spans 222 nt content + enzyme sites. |
| bsai_5wt_tile18_sub3 | 232 nt | Third 5'WT sub-block after SB2 junction (ACCA at nt 3324). Short distance to tile 18 start (nt 3535). |
| bsai_5wt_tile26_sub4 | 229 nt | Fourth 5'WT sub-block after SB3 junction (TCAG at nt 4917). Distance from TCAG to tile 26 start (nt 5125) = 208 nt. |
| bsmbi_polIII_tile28 | 267 nt | Last tile's BsmBI block = PolIII promoter only (245 core nt + enzyme sites). No gene content. |

**Note on short blocks:** Twist Bioscience's minimum gene fragment length is 300 nt. Blocks below this threshold may need to be ordered as synthetic oligos (up to 300 nt as ssDNA) or combined with adjacent fragments. The pipeline flags these for the user's attention.

### 5.3 Block Deduplication Summary

Many tiles share the same WT gene block when they lie within the same superblock. After deduplication:

| Gene | Pre-dedup blocks | Post-dedup blocks | Duplicates removed |
| --- | --- | --- | --- |
| GRIN2A | 82 | 45 | 37 |
| AKAP11 | 132 | 58 | 74 |

The most heavily shared blocks are:
- **GRIN2A:** `bsmbi_3wt_tile1_sub2` (GGTT->CTAC, 1761 nt) shared by tiles 1-8; `bsmbi_3wt_tile1_sub3` (CTAC->ACAA, 1313 nt) shared by 16 tiles; `bsai_5wt_tile10_sub1` (ATGG->GGTT, 1625 nt) shared by 13 tiles.
- **AKAP11:** `bsai_5wt_tile10_sub1` (ATGG->TAAA, 1634 nt) shared by 19 tiles; `bsmbi_3wt_tile1_sub3` (ACCA->TCAG, 1611 nt) shared by 16 tiles; `bsmbi_3wt_tile1_sub4` (TCAG->CACC, 1056 nt) shared by 23 tiles.

---

## Summary Comparison

| Property | GRIN2A | AKAP11 |
| --- | --- | --- |
| CDS length | 4395 nt (1465 codons) | 5706 nt (1902 codons) |
| Domestication changes | 6 | 5 |
| Tiles | 22 | 28 |
| Best K (boundaries) | 21 | 27 |
| DP avg boundary score | 3.5361 | 3.5742 |
| Boundaries both HF | 0 | 3 |
| Boundaries one HF | 12 | 15 |
| Boundaries neither HF | 9 | 9 |
| Superblocks | 3 | 4 |
| SB boundaries | 2 | 3 |
| SB collisions (unresolved) | 0 | 1 (ACCA) |
| oh3 | ACAA (HF, from HF set) | CACC (non-HF, promoter-derived) |
| oh4 | ACAA (HF) | ACAA (HF) |
| Min BsaI set fidelity | 0.9603 | 0.9527 |
| Min BsmBI set fidelity | 0.9278 | 0.9219 |
| Gene blocks (post-dedup) | 45 | 58 |
| Short blocks (<300 nt) | 5 | 7 |
| Reactions below 0.95 threshold | 1 | 1 |
