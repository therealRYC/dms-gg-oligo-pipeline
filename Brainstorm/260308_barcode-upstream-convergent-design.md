# Brainstorm: Convergent U6T7 Tornado Barcode Design

**Date**: 2026-03-08
**Participants**: Robert Chen, Claude
**Status**: Document & shelve (not implementing yet)

---

## Research Question

Can the DMS construct be redesigned to place the barcode cassette (PolIII) in CONVERGENT orientation relative to the gene (PolII), enabling WPRE/polyA to move to the backbone and reducing gene block overhead from ~1145 nt to <100 nt per tile?

---

## Round 1: Problem Statement & Motivation

### Current Construct
```
[Backbone]—[CAG]→PaqCI**→[gene+mutation]→[WPRE]→[spacer]→[bGH_polyA]→[U6]→[barcode]→PaqCI*—[Backbone]
```

### Current Oligo
```
BsaI_fwd(7)—oh1(4)—[tile]—BsmBI_rev_oh2(11)—BsmBI_fwd_oh3(11)—[barcode(12)]—BsaI_rev_oh4(11)
```
**56 nt overhead, 243 nt max tile (81 codons)**

### Key Constraint
Tile and barcode MUST be on the same contiguous oligo (programmed barcodes = variant-barcode linkage). Whatever sits between oh2 and oh3 must be gene blocks in the insert.

### Current Cassette Overhead (between oh2→oh3)
`[3'WT gene]—[WPRE(589)]—[spacer(31)]—[bGH_polyA(225)]—[U6(~300)]` = **~1145 nt of fixed overhead** per tile's gene blocks

### Motivations for Redesign
1. **Better PolII/PolIII insulation** — convergent orientation eliminates promoter interference
2. **Lower cloning footprint** — WPRE/polyA move to backbone, massively reducing gene block overhead
3. **Fewer superblock splits** — smaller cassette = fewer fragments to synthesize per tile

### Why WPRE/polyA Can't Just Move to Backbone in Current Design
Because the oligo is `tile—barcode`, everything between the gene 3' end and the barcode must be in gene blocks: WPRE, polyA, and PolIII promoter. Moving WPRE/polyA to backbone would require either:
1. Moving barcode upstream of tile (but PolII/PolIII co-directional interference)
2. Rearranging the PolIII/barcode cassette to a convergent orientation

---

## Round 2: Architecture Analysis

### Architecture A: Barcode Upstream, Co-directional
```
[CAG]→PaqCI**→[U6]→[barcode]→[TTTTTT]→[gene+mut]→PaqCI*→[WPRE]→[polyA]
```
- **HIGH RISK** of barcode expression loss
- User's original concern: "CAG would read through U6" — **validated by literature**
- **REJECTED**

### Architecture B: CAG in Insert
```
PaqCI**→[U6]→[barcode]→[insulator]→[CAG ~1.7kb]→[gene+mut]→PaqCI*
```
- Clean transcripts, but CAG is ~1.7 kb of GC-rich repeats
- Synthesis/domestication of CAG = dead end
- **REJECTED**

### Architecture C: Convergent Orientation
```
Top strand (5'→3'):
[CAG in backbone]→PaqCI**→[gene+mut]→[U6_RC]→[barcode_RC]→[AAAAA]→PaqCI*→[WPRE]→[polyA in backbone]

Bottom strand (PolIII reads R→L):
U6 → barcode → TTTTT → STOP
```

**How it works:**
1. PolII (CAG, backbone) transcribes top strand L→R: gene → 3'UTR → WPRE → polyA → STOP
2. PolIII (U6, bottom strand) transcribes R→L: U6 → barcode → TTTTT → STOP
3. Convergent = opposite directions — matches ALL widely-used dual-promoter vectors
4. bGH polyA terminates PolII before reaching U6 (>95% efficiency)
5. TTTTT terminates PolIII before reaching gene

**Gene block overhead: ~300 nt** (just U6_RC) vs. current ~1145 nt → **saves ~845 nt per tile**

---

## Round 3: Literature Review — PolII/PolIII Transcriptional Interference

### User's Assumption
> "If CAG (PolII) is upstream of U6 (PolIII) co-directionally, PolII read-through would cause interference and the barcode would never transcribe."

### Verdict: Directionally correct. The magnitude is debatable but the risk is real.

| Finding | Source | Implication |
|---------|--------|-------------|
| pHAGE-scKO: overlapping PolII/PolIII → sgRNA editing dropped 88% → 29% | Hill et al. 2018, Nat Methods (PMC5882576) | **Strongest evidence FOR concern** |
| α-amanitin (PolII inhibitor) boosted PolIII 2-fold from U6 | Ma et al. 2018, Mol Ther NA (PMC6023835) | PolII/PolIII compete at U6 |
| On **chromatin**, PolII HELPS PolIII (opens chromatin) | Ma et al. 2018 | Partial rescue for integrated constructs |
| **Tandem** UbiC did NOT suppress U6 (divergent did) | Nie et al. 2010, GPB (PMC5054135) | Counter-evidence — but CAG >> UbiC in strength |
| CMV enhancer **worsened** interference | Nie et al. 2010 | CAG contains CMV enhancer → high risk |
| CROP-seq: PolII reads through U6, sgRNA still 90.5% | Datlinger et al. 2017 (PMC5334791) | BUT: LTR duplication provides rescue copy |

### Field Design Consensus
**ALL widely-used dual-promoter vectors use CONVERGENT (opposite-direction) PolII/PolIII:**
- pLKO.1 (TRC): U6 ↔ hPGK convergent
- lentiCRISPRv2 (Zhang): U6 ↔ EFS convergent
- lentiGuide-Puro: U6 ↔ EF1α convergent

**No** widely-used vector places a strong PolII upstream of U6 co-directionally with read-through.

### TK4 Findings (Uenaka & Wernig, Cell Stem Cell 2026)
- **CAG + WPRE** = complete resistance to transgene silencing in iPSCs
- Neither CAG alone nor WPRE alone is sufficient
- Integration site mattered less than regulatory elements

---

## Round 4: Reverse PolIII Precedents & OPS Readout

### Key Question
Is reverse-strand PolIII validated in the field? Can OPS readouts (VIS-Seq, NIS-Seq) work with convergent barcode orientation?

### Validated Reverse PolIII Designs

| System | Design | Validation | Reference |
|--------|--------|------------|-----------|
| **CRISPuRe-seq** | EF1α→gene→polyA \|\| ←U6←sgRNA (convergent) | Functional CRISPR + scRNA-seq | Harris & Jan 2025, Nat Methods |
| **CROPseq-multi** | EF1α→gene→polyA \|\| ←U6←sgRNA (convergent) | Multi-guide CRISPR screens | Datlinger et al. 2024, Nat Biotech |
| **pLKO.1** | hPGK→puro→polyA \|\| ←U6←shRNA | TRC library, thousands of publications | Broad Institute |
| **lentiCRISPRv2** | EFS→puro→polyA \|\| ←U6←sgRNA | Most-cited CRISPR vector | Sanjana et al. 2014 (PMC4486245) |

### OPS Readout Compatibility

**Three readout modes from one construct:**

1. **Amplicon-seq** (standard DMS): PCR amplify barcode region → Illumina sequencing. Works regardless of orientation.

2. **VIS-Seq OPS** (in situ, Fowler Lab 2025): Uses **tornado circRNA** system for ultra-high barcode copy number (>75,000 copies/cell). Requires padlock probe binding sites flanking the barcode.

3. **NIS-Seq OPS** (post-fixation IVT): Uses chimeric **U6T7** promoter — T7 RNAP amplifies barcode transcript post-fixation. Requires T7 promoter sequence embedded in U6.

### Tornado circRNA System (Litke & Jaffrey 2019, Nat Biotech)
- **P3 twister** ribozyme (5') + ligation stems + insert + **P1 twister** ribozyme (3')
- Autocatalytic cleavage → RtcB ligase circularizes → **~200× more RNA than linear**
- Circular RNA is exceptionally stable (no 5'/3' ends for exonuclease attack)
- VIS-Seq uses this for >75,000 barcode copies/cell (enough for in situ detection)
- Source: GenBank MN052909 (Litke & Jaffrey tornado expression vector)

### Chimeric U6T7 Promoter (Mefferd et al. 2015)
- 18-bp T7 promoter sequence replaces equivalent region within U6 PSE
- Preserves U6 in-vivo transcription
- Adds T7 promoter for post-fixation IVT amplification
- Used in PerturbView (Yin et al. 2024) and NIS-Seq designs

---

## Round 5: Architecture C++ — Molecular Blueprint

### Critical Finding: NO TILE SIZE PENALTY

All tornado/readout elements go in **gene blocks** and/or the **helper plasmid** — NOT on the oligo. The oligo structure is **IDENTICAL** to the current pipeline design.

### Architecture C++ Construct (top strand, 5'→3')

```
BACKBONE   ← PaqCI** scar (4nt) →   INSERT   ← PaqCI* scar (4nt) →   BACKBONE
[CAG]→[oh_paqci_5']→[gene+mut]→[cassette_RC]→[barcode_RC]→[AAAAA]→[oh_paqci_3']→[WPRE]→[bGH_polyA]
```

**Detailed insert structure (top strand):**
```
oh_paqci_5'(4)—[5'WT]—[tile+mut]—[3'WT]—[cassette_RC]—[barcode_RC(12)]—AAAAA(5)—oh_paqci_3'(4)
                                          └── gene blocks ──┘  └──── oligo ────┘
```

### Oligo Structure (UNCHANGED from current design)
```
5'—BsaI_fwd(7)—oh1(4)—[tile(~243)]—BsmBI_rev_oh2(11)—BsmBI_fwd_oh3(11)—[barcode_RC(12)]—BsaI_rev_oh4(11)—3'
```
- **56 nt overhead** (identical to current)
- **243 nt max tile** = 81 codons (identical to current)
- Barcode is reverse-complemented on the oligo (so PolIII reads the correct barcode on the bottom strand)
- The AAAAA PolIII terminator and tornado elements are in gene blocks, NOT on the oligo

### Gene Block Cassette (between oh2→oh3, on top strand)
```
oh2—[3'WT gene]—[AAAAA(5)]—[3'twister_RC(~55)]—[3'stem_RC(~18)]—[padlock_3'arm_RC(15)]—oh3
```
- Fixed cassette overhead: **~93 nt** vs. current **~1145 nt**
- **Saves ~1052 nt per tile's gene blocks**
- Dramatically fewer superblock splits needed

### Helper Plasmid / Backbone Elements (downstream of PaqCI*)
```
PaqCI*_scar—[padlock_5'arm_RC(20)]—[5'stem_RC(~13)]—[5'twister_RC(~56)]—[U6T7+27_RC(~27)]—[WPRE]—[bGH_polyA]
```
- Fixed in backbone — synthesized once per destination vector
- ~116 nt of additional sequence before WPRE (negligible)
- U6T7 chimeric promoter provides both in-vivo (U6) and post-fixation (T7) transcription

### Dual-Strand Transcription

**PolII transcript (mRNA, top strand L→R):**
```
5'cap—CAG_TSS→[gene]→[3'WT]→[AAAAA]→[cassette_RC]→[barcode_RC]→PaqCI*_scar→[helper_RC]→[WPRE]→bGH_polyA—3'
      └───── CDS ─────┘  └────────── 3'UTR (extra ~210 nt, well-tolerated) ──────────────────────┘
```

**PolIII transcript (bottom strand, R→L):**
```
U6T7_TSS → [27nt_leader] → [5'twister] → [5'stem] → [padlock_5'arm(20)] → PaqCI*_scar_RC →
→ [barcode(12)] → [padlock_3'arm(15)] → [3'stem] → [3'twister] → [TTTTT] → STOP

After tornado processing:
┌──────────────────────────────────────────────────────┐
│ [5'stem(~13)] → [padlock_5'arm(20)] → [junction(~8)] │
│ → [barcode(12)] → [padlock_3'arm(15)] → [3'stem(~18)] │
│ → circularization junction back to 5'stem             │
└──────────────────────────────────────────────────────┘
= ~86 nt circular RNA
```

### How Tornado Processing Works
1. PolIII transcribes from U6T7 on bottom strand (R→L in top-strand coordinates)
2. 5' P3 twister ribozyme self-cleaves, releasing the 5' end
3. 3' P1 twister ribozyme self-cleaves, releasing the 3' end
4. Endogenous **RtcB ligase** joins the 5'-OH and 2',3'-cyclic phosphate termini
5. Result: **circular RNA** (~86 nt) containing the barcode flanked by padlock probe binding sites
6. circRNA is exceptionally stable — >75,000 copies/cell (VIS-Seq)

### Three Readout Modes

| Readout | Mechanism | What's Needed |
|---------|-----------|---------------|
| **Amplicon-seq** | PCR barcode region, Illumina sequencing | Flanking primer sites (inherent in construct) |
| **VIS-Seq OPS** | Padlock probes bind circRNA → RCA → in situ detection | circRNA with padlock binding sites ✓ |
| **NIS-Seq OPS** | Post-fixation T7 IVT → linear barcode RNA for in situ | U6T7 chimeric promoter ✓ |

### Exact Sequences (from GenBank MN052909, Litke & Jaffrey 2019)

**P3 twister ribozyme (5'):** ~56 nt
```
GCCATCAGTCGCACTGTTACTCGCTGATTTTAAATCAGAACCTGATCTCCCTAAGGG
```

**P1 twister ribozyme (3'):** ~55 nt
```
AACCAATCAGCAATCGGCAGGCTGGATGGAAAACCACCCTAAGATCTCGTCTAACCC
```

**Ligation stems:**
- 5' stem: ~13 nt
- 3' stem: ~18 nt
(Exact stem sequences from MN052909 form complementary duplex for RtcB recognition)

**VIS-Seq padlock probe binding sites** (from Fowler Lab 2025):
- 5' arm (upstream of barcode): `CGATACTTGTTCGATCCTTC` (20 nt)
- 3' arm (downstream of barcode): `ACTGTACGAAGACTG` (15 nt)

**U6T7 chimeric promoter** (Mefferd et al. 2015):
- Standard hU6 with 18-bp PSE replacement: `TAATACGACTCACTATA` (T7 promoter core)
- Preserves TATA box, PSE spacing, and +1 transcription start

### Strand Independence of All Components

| Component | Strand-dependent? | Why it works on antisense strand |
|-----------|-------------------|----------------------------------|
| U6 promoter | No — just needs DNA sequence in correct orientation | Placed as RC on top strand → correct on bottom strand |
| T7 promoter | No — same reasoning | Embedded in U6 as RC |
| Twister ribozymes | **No** — fold from RNA sequence alone | Transcribed from bottom strand → correct RNA fold |
| RtcB ligation | No — recognizes 5'-OH / 2',3'-cP termini | Chemical termini are strand-independent |
| Padlock probes | Must match barcode strand | Design probes to match bottom-strand barcode ✓ |

### Minor Concerns & Mitigations

1. **3'UTR additions to mRNA**: ~210 nt of cassette_RC + barcode_RC in 3'UTR. Well-tolerated — 3'UTR is far more permissive than 5'UTR.

2. **Antisense barcode in mRNA**: 12-nt barcode_RC in mRNA is complementary to PolIII-transcribed barcode. 12-nt ssRNA:mRNA duplexes are NOT efficient knockdown substrates (too short for RISC loading). **Risk: negligible.**

3. **AAAAA in mRNA 3'UTR**: Not a canonical polyadenylation signal (AAUAAA). Without downstream GU-rich elements, does not trigger premature polyadenylation. **Risk: negligible.**

4. **PaqCI scar in circRNA**: The 4-nt PaqCI* junction scar is included in the circRNA. This is a fixed sequence and does not affect barcode uniqueness.

---

## Comparison Table (All Architectures)

| Feature | Current | Arch A (co-dir) | Arch C (convergent) | Arch C++ (tornado) |
|---------|---------|-----------------|---------------------|---------------------|
| PolII/PolIII interference | Low-moderate | **HIGH** | **None** | **None** |
| CAG synthesis needed | No | No | No | No |
| WPRE/polyA location | Insert | Backbone ✓ | Backbone ✓ | Backbone ✓ |
| Gene block cassette overhead | ~1145 nt | ~300 nt | ~300 nt | **~93 nt** |
| Oligo tile size | 81 codons | 81 codons | ~78 codons | **81 codons** |
| Superblock splits | More | Fewer | Fewer | **Fewest** |
| Barcode on oligo | Forward | Forward | RC | **RC** |
| VIS-Seq OPS | Requires tornado in insert | N/A | Requires additions | **Built-in** ✓ |
| NIS-Seq OPS | Requires U6T7 | N/A | Requires U6T7 | **Built-in** ✓ |
| Amplicon-seq | ✓ | ✓ | ✓ | ✓ |
| Field precedent | Common | **None** | All major vectors | CROPseq-multi, CRISPuRe-seq |
| Insulator needed | Maybe | Yes | Probably not | Probably not |

---

## Pipeline Code Impact (if implemented)

### What changes:
1. **Oligo assembly** (`08_oligo_assembly.R`): Barcode reverse-complemented before placement. +0 nt overhead change (tornado elements NOT on oligo).
2. **Gene block design** (`09_wt_geneblock_design.R`): Downstream cassette = `[AAAAA]—[3'twister_RC]—[3'stem_RC]—[padlock_3'arm_RC]` (~93 nt). Massive simplification from current ~1145 nt.
3. **Barcode design** (`07_barcode_design.R`): Same algorithm; output both barcode and barcode_RC.
4. **Config** (`00_config.R`): New `barcode_orientation: "convergent"` toggle.
5. **QC** (`10_qc_checks.R`): Check tornado elements for enzyme sites; verify TTTTT terminator.

### What stays the same:
- Tiling (`05_tiling.R`)
- Overhang selection (`06_overhang_selection.R`)
- Mutation design (`04_mutation_design.R`)
- Enzyme site scan (`02_enzyme_site_scan.R`)

### Estimated effort: Moderate (config toggle to support both orientations)

---

## Decision

**Document and shelve.** The convergent U6T7 tornado design (Architecture C++) is promising but:
- Current pipeline is working and functional
- Need wet-lab validation before committing code changes
- The design is fully documented here for future implementation
- Can be added as a config toggle without disrupting existing functionality

---

## Open Questions (for future implementation)

1. Exact PerturbView U6T7 13-bp variant sequence (need Addgene GenBank file)
2. VIS-Seq full supplementary methods for exact tornado cassette details
3. Whether to filter barcodes that create ATG codons when reverse-complemented (marginal concern)
4. Empirical validation: does the convergent design maintain gene expression levels?
5. cHS4 insulator between gene and U6_RC — probably unnecessary, but testable fallback

---

## Key References

1. Hill et al. 2018, Nat Methods — pHAGE-scKO 70% sgRNA reduction (PMC5882576)
2. Ma et al. 2018, Mol Ther NA — PolII/PolIII competition at U6 (PMC6023835)
3. Nie et al. 2010, GPB — Arrangement-dependent interference (PMC5054135)
4. Datlinger et al. 2017, Nat Methods — CROP-seq: PolII read-through w/ LTR rescue (PMC5334791)
5. Uenaka & Wernig 2026, Cell Stem Cell — TK4: CAG+WPRE prevents iPSC silencing (PMID: 41690310)
6. Chinnasamy et al. 2009, Gene Therapy — cHS4 insulator for dual-promoter (PMC2714872)
7. Sanjana et al. 2014, Nat Methods — lentiCRISPRv2 convergent design (PMC4486245)
8. Hanna et al. 2024, Nat Methods — LABEL-seq dual PolII/PolIII cassette (PMC11785348)
9. Fowler Lab 2025, bioRxiv — VIS-seq with UCOE+cHS4 (PMID: 40631108)
10. Litke & Jaffrey 2019, Nat Biotech — Tornado circRNA expression system (GenBank MN052909)
11. Mefferd et al. 2015, RNA — Chimeric U6T7 promoter design
12. Harris & Jan 2025, Nat Methods — CRISPuRe-seq convergent PolII/PolIII
13. Datlinger et al. 2024, Nat Biotech — CROPseq-multi convergent design
14. Yin et al. 2024, Cell — PerturbView with U6T7 chimeric promoter
