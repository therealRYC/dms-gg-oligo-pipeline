# Gene Block Flanking Overhangs for Golden Gate Assembly

**Date**: 2026-03-17
**Context**: DMS GG Oligo Pipeline — designing WT gene blocks for BsmBI/BsaI Golden Gate Assembly

## Research Question

Do synthesized gene blocks need extra flanking DNA beyond the Type IIs restriction enzyme recognition sites at their ends? If so, how much, and what sequence?

## Key Findings

### 1. Yes, flanking DNA improves digestion efficiency

Type IIs enzymes need some flanking DNA to "grip onto" when the recognition site is near the terminus of a linear fragment. NEB's empirical cleavage-near-ends data:

| Enzyme | Min. bases for 50-100% activity | Min. for 20-50% activity |
|--------|--------------------------------|--------------------------|
| **BsmBI** (CGTCTC) | **1 bp** from terminus | 0 bp |
| **PaqCI** (CACCTGC) | **2 bp** from terminus | **1 bp** |
| **BsaI** (GGTCTC) | **1 bp** from terminus | 0 bp |

Despite these relaxed empirical minima, NEB recommends **at least 6 bp** of flanking sequence in their Golden Gate Assembly kits. This conservative margin accounts for:
- Batch-to-batch enzyme variability
- End-fraying of linear dsDNA fragments
- Non-optimal conditions during Golden Gate thermal cycling
- The negligible cost of adding a few extra bases to synthesized fragments

### 2. Manufacturer recommendations

| Source | Recommendation | Notes |
|--------|---------------|-------|
| **NEB (BsmBI-v2 kit E1602)** | **6 bp** flanking | "5' flanking bases (6 recommended)" — no specific sequence |
| **NEB (general)** | **6 bp** | For all Type IIS enzymes in Golden Gate |
| **IDT (gBlocks)** | **6-8 bp** | "Many restriction sites need a short DNA stretch upstream to grab onto" |
| **Twist Bioscience** | No specific recommendation | Gene fragments delivered as exact ordered sequence — no adapters |

**Key point**: Twist gene fragments contain exactly what you order. No default adapters or flanking sequences are added. We must include pads ourselves in the ordered sequence.

### 3. What existing DMS/GG tools use

| Tool | Flanking pad | Notes |
|------|-------------|-------|
| **DIMPLE** (Coyote-Maestas et al. 2023) | `ATA` (3 bp) | Comment in code: "added ATA for cleavage close to end of DNA fragment" |
| **GGAssembler** (Fleishman Lab) | `CGTGC` (5 bp) or `GACATT` (6 bp) | Different sequences in test vs notebook configs |
| **SnapGene** | `tt` (2 bp) | Shown in primer design examples |
| **jbloomlab gga_codon_muts** | User-defined | Framework accounts for flanking but doesn't auto-generate it |

**DIMPLE's biological validation**: DIMPLE includes 4 non-mutated WT residues (12 nt) flanking each cut site on oligos. Without this, they observed "lower variant generation success at the beginnings and ends of sublibraries." With the padding, "no systematic positional biases within sublibraries" and "median mutational frequencies across sublibraries are within 2-fold."

### 4. Sequence identity doesn't matter

No vendor or published study specifies what the flanking nucleotides should be. The evidence consistently shows:
- **Length matters** (≥1 bp minimum, 6 bp recommended)
- **Identity does not** — any sequence works as long as constraints are met

**Constraints to avoid**:
- Enzyme recognition sites (BsmBI, BsaI, PaqCI) in the pad or at the pad-recognition junction
- Homopolymer runs (synthesis issues, slippage)
- Palindromic sequences near the recognition site (hairpin interference)
- Extreme GC content (secondary structure or instability)

### 5. PaqCI special considerations

PaqCI is a tetrameric enzyme that requires multiple recognition sites for efficient cleavage. The **PaqCI Activator** (a short hairpin DNA) provides the missing binding sites. For Level 2 assembly, the Activator ensures efficient cleavage regardless of flanking context, which somewhat relaxes the flanking requirement for PaqCI sites.

## Points of Confusion

- **Inward vs outward-facing sites**: The minimum flanking requirement differs depending on whether the enzyme cuts toward or away from the fragment terminus. For our gene blocks, recognition sites face outward (toward the end) and cut inward — this is the standard Golden Gate geometry where the recognition site is near the terminus.
- **DIMPLE's 4-codon flanking**: This serves a dual purpose — enzyme binding AND biological buffer between the cut site and mutated region. These two effects are conflated in the DIMPLE data.

## Answers & Decisions

1. **Use 6 bp flanking pads** on all gene blocks — matches NEB's recommendation and exceeds the empirical minimum by a comfortable margin.
2. **Default sequence: `TGCATG`** — 6 bp, 50% GC, no homopolymers, no enzyme sites at any junction. Arbitrary choice; no evidence any specific sequence is better.
3. **Make it configurable** — `geneblock_flanking_pad` parameter in config, so users can override if needed.
4. **Oligos are NOT affected** — they're constrained to 300 nt max, and their enzyme sites are flanked by gene sequence internally (never at the fragment terminus).
5. **Gene block length calculations** must account for the extra 12 bp (6 per end) when checking against synthesis limits.

## Open Questions

- No systematic study has compared flanking pad lengths (0/2/4/6 bp) under Golden Gate cycling conditions for synthesized gene fragments. Our 6 bp choice is empirically safe but not optimized.
- The interaction between flanking pad sequence and overhang sequence on cleavage efficiency has not been studied.
- Whether the same pad should be used on both ends or different pads — likely doesn't matter, but untested.

## Key Citations

1. **Coyote-Maestas et al. (2023)** "DIMPLE: deep insertion, deletion, and missense mutation libraries..." *Genome Biology*, 24:36. PMID: 36823596. — 4-codon WT flanking eliminates positional bias.
2. **Potapov et al. (2018)** "Comprehensive Profiling of Four Base Overhang Ligation Fidelity by T4 DNA Ligase..." *ACS Synth Biol*, 7:2665-2674. — Foundational overhang fidelity work.
3. **Potapov et al. (2023)** "Structures, activity and mechanism of PaqCI." *NAR*, 51(9):4467-4478. — PaqCI Activator mechanism.
4. **Sikkema et al. (2023)** "High-Complexity One-Pot Golden Gate Assembly." *Current Protocols*, 3:e882. — 52-fragment assembly, standard 6 bp flanking.
5. **NEB #E1602 Instruction Manual v1.0 (2020)** — "5' flanking bases (6 recommended)."
6. **NEB "Cleavage Close to the End of DNA Fragments"** — Enzyme-specific minimum flanking data.
7. **IDT gBlocks FAQ** — "6-8 nt at the ends beyond the restriction recognition sequence."
