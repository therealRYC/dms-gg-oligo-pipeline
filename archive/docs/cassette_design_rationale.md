<!-- Created: 2026-03-03 -->
<!-- Last updated: 2026-03-03 — Initial cassette design rationale -->

# Downstream Cassette Design Rationale

## Overview

This document records the research and reasoning behind the downstream cassette
design in the DMS-GG oligo pipeline. The cassette sits between the gene's 3' end
and the PolIII promoter that drives barcode transcription.

### Final construct architecture

```
[Gene 3' end] -- [WPRE 589bp] -- [spacer 31bp] -- [bGH polyA 225bp] -- [hU6+T7 250bp] -- [barcode 20bp] -- [PolIII term 6bp] -- [PaqCI 15bp]
                  <-------------- gene block(s) -------------->  <-- oligo -->  <----- dest. vector ----->
```

### Size budget

| Element | Size (bp) | Lives on |
|---------|-----------|----------|
| WPRE | 589 | Gene block (intergene element) |
| Spacer | 31 | Gene block (intergene element) |
| bGH polyA | 225 | Gene block (intergene element) |
| hU6 + embedded T7 | 250 | Gene block (core; last 5 nt become BsmBI oh) |
| Barcode | 20 | Oligo |
| PolIII terminator (TTTTT+N) | 6 | Destination vector |
| PaqCI site + overhang | 15 | Destination vector |
| **Total** | **~1,136** | |

Downstream gene block cassette total: 589 + 31 + 225 + ~245 = **~1,090 bp** (well within
1,800 bp synthesis limit; 710 bp headroom).

---

## 1. The PolII/PolIII Interference Problem

### Why this matters

The DMS-GG construct places a PolIII (hU6 + embedded T7) promoter downstream of a
PolII expression cassette. The barcode must be transcribed by PolIII (U6) for
RNA-based readout (LABEL-Seq, PerturbView, single-cell capture). PolII transcription
termination is stochastic: read-through extends **200-2000 nt downstream** of the
polyA cleavage site (Proudfoot 2016). Read-through PolII can occlude the U6
promoter, displace pre-initiation complexes, and reduce barcode expression --
creating variant-correlated noise in pooled DMS experiments.

### Evidence from the field

The strongest direct evidence comes from **CROP-seq** (Datlinger et al. 2017, Nat Methods):

> "Efforts to decrease this distance by moving the U6-sgRNA downstream of the pol II
> promoter and resistance gene have resulted in poor guide activity, potentially due
> to transcriptional interference."

They solved this architecturally (LTR duplication) rather than with insulators.

| System | Architecture | Dedicated insulator? |
|--------|-------------|---------------------|
| CROP-seq (Datlinger 2017) | U6 in 3'LTR (duplicated to 5' during integration) | No -- architectural |
| Perturb-seq (Adamson 2016; Replogle 2022) | U6 **upstream** of PolII cassette | No -- avoids problem |
| lentiCRISPR v2 (Sanjana 2014) | EF1a-puro-WPRE-polyA + U6-sgRNA (tandem) | No |
| scMPRA (Zhao 2023) | PolyA alone between PolII and U6 | No -- but worked |
| Lalanne et al. 2024 | PolII + polyA + U6 (tandem) | No -- R^2 > 0.84 |

**Critical nuance:** Most published systems measure whether PolIII interferes with
*PolII* expression, not the reverse. Our concern -- PolII read-through suppressing
PolIII barcode production -- is less directly tested but is the more relevant failure
mode for barcode-based DMS readouts.

---

## 2. Decision: WPRE + bGH polyA (No Additional Insulation)

### What we chose

**WPRE (589 bp) + spacer (31 bp) + bGH polyA (225 bp).** No alpha-globin pause,
no cHS4 insulator, no other additional elements.

### Why

Every major functional genomics platform operates with WPRE + polyA as the only
termination between PolII and PolIII cassettes:

- **Perturb-seq** (Replogle et al. 2022): WPRE + polyA
- **CROP-seq** (Datlinger et al. 2017): WPRE + polyA (LTR architecture)
- **lentiCRISPR v2** (Sanjana et al. 2014): WPRE + polyA
- **scMPRA** (Zhao et al. 2023): polyA alone

No published failures from PolII readthrough have been attributed to insufficient
insulation in these systems. WPRE itself reduces readthrough transcription
(Higashimoto et al. 2007, Gene Therapy).

### What we considered and deferred

#### Alpha-globin pause element (~90 bp)

The alpha-2 globin 3' flanking pause element (Eggermont & Proudfoot 1993, EMBO J)
slows PolII elongation so the Xrn2 exonuclease ("torpedo") catches up and
dislodges the polymerase. Combined with polyA, it prevents tandem PolII promoter
interference more effectively than polyA alone.

**Why deferred:**
- Evidence is for PolII-to-PolII interference, not PolII-to-PolIII
- Niche element -- not widely used outside a few specialized constructs (Addgene
  #224474/#118068, MAGIC toolkit from Gillespie et al. 2025)
- Modest effect size: works synergistically with polyA but may be redundant when
  WPRE is already present
- Can be added later as a config change (`intergene_elements`) without any code
  modifications

**Key references:**
- Eggermont & Proudfoot 1993 (EMBO J 12:2539-2548): polyA + pause prevents tandem
  PolII promoter interference
- Sarrion-Perdigones et al. 2019 (Nat Commun): alpha-globin pause in multiplex reporter
- Gillespie et al. 2025 (Development): MAGIC toolkit uses alpha-globin pause

#### cHS4 insulator (~250 bp core)

The chicken beta-globin hypersensitive site 4 (cHS4) core provides CTCF-mediated
enhancer blocking and chromatin boundary activity.

**Why not included:**
- Designed for chromosomally integrated constructs, not episomal plasmids
- Protects against position-effect variegation at integration sites, which is not
  our primary concern (we're using transient transfection or integrated at defined
  loci like AAVS1)
- The full 1.2 kb cHS4 is too large; the 250 bp core has attenuated activity
- Splice site variant (Charrier et al. 2022, Nat Commun) is lentiviral-specific
- Uenaka et al. 2026 (bioRxiv) showed insulators had minimal impact in hiPSCs

#### Other elements considered

- **MAZ element** (~50-100 bp): G-rich pause from C2 complement gene. Works with
  polyA signals (Ashfield et al. 1991) but less well-characterized than alpha-globin
  pause. Available as future addition.
- **SV40 late polyA** (~240 bp): ~3x faster termination than bGH. Could replace bGH
  if read-through is observed experimentally.
- **supA-LTR / C-U+ elements**: Lentiviral-specific; not applicable to plasmid context.

---

## 3. bGH polyA vs hGH polyA

### Decision: bGH polyA (225 bp)

| Property | bGH polyA | hGH polyA (as used) |
|----------|-----------|---------------------|
| Size | 225 bp | 477 bp |
| Source | pcDNA3.1, GenBank J00008.1 | pTK4-GFP |
| Termination strength | Strong | Strong (equivalent) |
| iPSC silencing risk | None reported | None reported |
| Enzyme sites (BsmBI/PaqCI) | None | None |
| Alu repeat content | No | Yes (~190 bp, non-functional) |
| Standard in field | Yes (pcDNA3.1, pEGFP, pAAV) | Less common |

### Why bGH

1. **Shorter** -- saves 252 bp vs the hGH polyA we were using
2. **Better characterized** -- the canonical pcDNA3.1 polyA with clear functional
   boundaries (Goodwin & Rottman 1992, JBC 267:16330)
3. **Field standard** -- used by every major expression vector platform
4. **No Alu repeat** -- the hGH polyA we had included ~190 bp of AluSx genomic
   passenger DNA from the GH1 locus 3' flanking region, not required for function

### Notes on the "hGH polyA" naming confusion

The "hGH" label in some patents refers to Chinese *hamster* GH polyA (used in CHO
bioproduction), not human growth hormone polyA. There is no head-to-head comparison
of bGH vs actual human GH polyA in the literature for iPSC applications.

### No iPSC silencing concern

Transgene silencing in iPSCs is driven by **promoter CpG methylation**, not polyA
signal choice. bGH polyA is the standard in:
- AAVS1 knock-in vectors (Addgene #22075 derivatives)
- PiggyBac reprogramming vectors
- AAV vectors for iPSC transduction

---

## 4. WPRE Function and Verification

The WPRE (Woodchuck Hepatitis Virus Post-transcriptional Regulatory Element, 589 bp)
serves dual roles:

1. **mRNA processing**: Enhances polyadenylation, splicing, and nuclear export of the
   upstream PolII transcript
2. **Read-through reduction**: Higashimoto et al. (2007, Gene Therapy) demonstrated
   that WPRE reduces read-through transcription past the polyA signal

Our WPRE sequence (589 bp from pTK4-GFP) matches the standard WPRE used across
lentiviral and AAV vectors. No BsmBI or PaqCI sites.

---

## 5. Spacer Retention

The 31 bp spacer between WPRE and polyA is retained. Both pTK4 and XPRESSO vector
systems use spacers between WPRE and polyA. The spacer contains ClaI and SalI
restriction sites that could serve as diagnostic tools.

---

## 6. PolIII Terminator Placement

### The terminator lives in the destination vector

The PolIII terminator (>=4 T's, typically TTTTT) must be **after the barcode**.
In the pipeline architecture:

- The **oligo** ends at `BsaI_rev_oh4` -- no room for a terminator
- The **gene block** carries the PolIII promoter, not the terminator
- After PaqCI Level 2 assembly: `...PolIII + barcode + PaqCI*_oh(4nt) + [backbone]`

The PolIII terminator must be in the destination vector backbone, immediately after
the PaqCI* junction:

```
...barcode -- GCTA -- TTTTTX -- [rest of backbone]
               |        |
          PaqCI* oh   PolIII terminator (in backbone)
```

The 4 nt PaqCI* overhang (e.g., GCTA) sits between barcode and terminator. ~4 nt of
non-barcode sequence gets transcribed before PolIII terminates. For a 20 nt barcode,
this is fine -- the extra 4 nt are constant across all constructs and can be trimmed
during demultiplexing.

### Destination vector requirements

1. **PolIII terminator** (TTTTT) must be immediately after PaqCI* site in backbone
2. **PaqCI* overhang** must NOT contain TTTT (would cause premature PolIII termination)
   -- current default `GCTA` is safe
3. No pipeline code changes needed (the pipeline already doesn't include a terminator)

---

## 7. Future Additions (Config-Only Changes)

If experimental data shows insufficient barcode expression, the following can be
added as `intergene_elements` in the config YAML without any code changes:

1. **Alpha-globin pause** (~90 bp): Place between bGH polyA and PolIII promoter
2. **cHS4 core** (~250 bp): Place between pause and PolIII if chromatin insulation needed
3. **MAZ element** (~50-100 bp): Alternative/supplement to alpha-globin pause

Example config with alpha-globin pause added:
```yaml
intergene_elements:
  - name: "WPRE"
    sequence: "..."          # 589 bp
  - name: "spacer"
    sequence: "..."          # 31 bp
  - name: "bGH_polyA"
    sequence: "..."          # 225 bp
  - name: "alpha_globin_pause"
    sequence: "..."          # ~90 bp
```

Total with pause: ~1,185 bp (still well within 1,800 bp limit).

---

## 8. Key References

| Reference | Relevance |
|-----------|-----------|
| Goodwin & Rottman 1992 (JBC 267:16330) | bGH polyA functional characterization |
| Higashimoto et al. 2007 (Gene Therapy) | WPRE reduces readthrough transcription |
| Datlinger et al. 2017 (Nat Methods 14:297) | CROP-seq: PolII/PolIII interference observed |
| Eggermont & Proudfoot 1993 (EMBO J 12:2539) | polyA + pause prevents tandem interference |
| Proudfoot 2016 (Genes Dev 30:529) | Torpedo model of PolII termination |
| Shearwin et al. 2005 (Trends Genet 21:339) | Review: promoter interference mechanisms |
| Sanjana et al. 2014 (Nat Methods) | lentiCRISPR v2 architecture |
| Replogle et al. 2022 (Cell) | Perturb-seq at scale |
| Zhao et al. 2023 | scMPRA: polyA-only insulation worked |
| Lalanne et al. 2024 | Tandem PolII+polyA+U6 concordance R^2 > 0.84 |
| Charrier et al. 2022 (Nat Commun) | cHS4 splice site (lentiviral-specific) |
| Gillespie et al. 2025 (Development) | MAGIC toolkit with alpha-globin pause |
| Uenaka et al. 2026 (bioRxiv) | Insulators had minimal impact in hiPSCs |
| Ashfield et al. 1991 (EMBO J 10:4197) | MAZ/G-rich pause elements |

---

## 9. Confidence Assessment

| Claim | Confidence |
|-------|------------|
| PolII read-through past polyA is real (200-2000 bp) | **High** -- direct measurements |
| WPRE enhances polyadenylation + reduces readthrough | **High** -- well-characterized |
| bGH polyA is functionally equivalent to hGH polyA | **High** -- both are strong terminators |
| bGH polyA doesn't silence in iPSCs | **High** -- widely used, no reports |
| Pooled screens work with WPRE + polyA only | **High** -- lentiCRISPR v2, scMPRA, Lalanne |
| Alpha-globin pause adds protection for PolII-PolII | **High** -- Eggermont & Proudfoot 1993 |
| Alpha-globin pause specifically protects PolIII (U6) | **Speculative** -- not directly tested |
| cHS4 is unnecessary for episomal plasmids | **High** -- designed for integration sites |
