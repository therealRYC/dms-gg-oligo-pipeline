<!-- Created: 2026-03-02 -->
<!-- Last updated: 2026-03-03 — Final decision: WPRE + bGH polyA, add PolIII terminator section -->

# Insulation Design Notes: PolII/PolIII Boundary

> **Decision (2026-03-03):** WPRE + bGH polyA, no additional insulation elements.
> See `docs/cassette_design_rationale.md` for full research and reasoning.

## Context

The DMS-GG construct places a PolIII (hU6 + embedded T7) promoter downstream of a PolII expression cassette:

```
[Gene with mutation] — [WPRE] — [polyA] — [insulator?] — [hU6+T7] — [barcode] — [PolIII terminator] — [PaqCI]
```

The barcode must be actively transcribed by PolIII (U6) inside the cell for RNA-based readout (e.g., LABEL-Seq, PerturbView, single-cell barcode capture). The T7 promoter embedded in U6 enables in-vitro transcription for alternative readouts.

PolII transcription termination is stochastic and occurs **200–2000 nt downstream** of the polyA cleavage site. Read-through PolII can occlude the U6 promoter, displace pre-initiation complexes, and reduce barcode expression — creating variant-correlated noise in pooled DMS experiments.

---

## Final Cassette Design (2026-03-03)

```
[Gene] — [WPRE, 589 bp] — [spacer, 31 bp] — [bGH polyA, 225 bp] — [hU6+T7, ~250 bp] — [barcode, 20 nt] — [PolIII terminator, 6 nt TTTTT+N] — [PaqCI site + overhang, ~15 nt]
                                                                                                              ↑ in destination vector ↑
```

**Decision:** WPRE + bGH polyA only. No alpha-globin pause or cHS4 insulator. This follows the
field standard used by every major functional genomics platform (Perturb-seq, CROP-seq,
lentiCRISPR v2). Alpha-globin pause or cHS4 can be added later as config changes if needed.

### Size Budget

| Element | Size (bp) | Lives on |
|---------|-----------|----------|
| WPRE | 589 | Gene block (intergene element) |
| Spacer | 31 | Gene block (intergene element) |
| bGH polyA | 225 | Gene block (intergene element) |
| hU6 + embedded T7 | ~250 | Gene block (core; last 5 nt become BsmBI oh) |
| Barcode | 20 | Oligo |
| PolIII terminator | 6 | Destination vector backbone |
| PaqCI site + overhang | ~15 | Destination vector backbone |
| **Total** | **~1,136** | Well within 1,800 nt synthesis limit |

---

## Key Design Decisions

### 1. bGH polyA over hGH polyA

| Property | bGH polyA | hGH polyA (trimmed) |
|----------|-----------|---------------------|
| Size | ~225 bp | ~363 bp |
| Termination strength | Strong | Strong (equivalent) |
| iPSC silencing risk | None reported | None reported |
| Enzyme sites | None (BsaI/BsmBI-free) | None in trimmed version |
| Alu repeat content | No | Yes (~190 bp, non-functional) |

- **No evidence** that bGH differentially silences gene expression vs hGH in iPSCs
- Transgene silencing in iPSCs is driven by **promoter CpG methylation**, not polyA signal choice
- bGH is the standard polyA in AAVS1 knock-in vectors, PiggyBac constructs, AAV vectors for iPSCs
- Saves ~138 bp compared to trimmed hGH

The original hGH sequence provided included an Alu repeat (AluSx subfamily) from the GH1 locus 3' flanking region — genomic passenger DNA not required for polyadenylation. The cloning-region BsaI/BsmBI sites at the 3' end were from the source vector, not the polyA signal itself.

### 2. Alpha-2 Globin Pause Element (~90 bp)

**Primary insulator.** From the human alpha-2 globin gene 3' flanking region.

- Eggermont & Proudfoot (1993, EMBO J 12:2539–2548) demonstrated that polyA + pause element together prevent tandem PolII promoter interference more effectively than polyA alone
- Mechanism: slows PolII elongation so the Xrn2 5'→3' exonuclease ("torpedo") catches up and dislodges the polymerase before it reaches the downstream promoter
- Compact (~90 bp) — minimal impact on cassette size
- Well-characterized functional boundaries

**Confidence level:** PolyA + pause preventing PolII→PolII tandem interference is well-established. Extension to PolII→PolIII protection is plausible (same mechanism — preventing read-through) but not directly tested.

### 3. Why Not cHS4 Insulator?

The cHS4 core insulator (~250 bp) provides CTCF-mediated enhancer blocking and chromatin boundary activity. It is more relevant for:
- Preventing position-dependent silencing at chromosomal integration sites
- Blocking enhancer-promoter communication across the insulator

It is **less** relevant for the immediate read-through termination concern. If iPSC position-effect silencing becomes an issue (e.g., AAVS1 integration), cHS4 could be added as a second layer:

```
[bGH polyA] — [alpha-globin pause] — [cHS4 core, ~250 bp] — [hU6+T7]
Total cassette: ~1,458 bp (still within limits)
```

This is listed as an optional enhancement.

---

## Literature on PolII/PolIII Co-residence in Pooled Screen Constructs

### CROP-seq (Datlinger et al. 2017, Nat Methods)

The closest analogue. Authors explicitly noted:

> *"Efforts to decrease this distance by moving the U6-sgRNA downstream of the pol II promoter and resistance gene have resulted in poor guide activity, potentially due to transcriptional interference."*

Their solution: place U6-sgRNA in the 3'LTR, which is duplicated to the 5'LTR during lentiviral integration — an architectural solution that avoids the tandem arrangement entirely.

### Perturb-seq (Adamson et al. 2016; Replogle et al. 2022)

Place U6 cassette **upstream** of the PolII promoter. Avoids the problem.

### scMPRA (Zhao et al. 2023)

Used PolyA alone between PolII reporter and U6-barcode cassette. Reported functional results without dedicated insulation. This suggests that polyA alone provides *some* protection, but the study did not measure absolute PolIII activity or compare against an insulated design.

### Lalanne et al. 2024 (variant effect mapping)

PolII + polyA + U6 in tandem arrangement. Measured R² > 0.84 concordance between replicates, suggesting functional barcode expression. No dedicated insulator.

### Key References

| Reference | Relevance |
|-----------|-----------|
| Eggermont & Proudfoot 1993 (EMBO J 12:2539) | PolyA + pause prevents tandem promoter occlusion |
| Ashfield et al. 1991 (EMBO J 10:4197) | MAZ/G-rich pause elements in termination |
| Shearwin et al. 2005 (Trends Genet 21:339) | Review: mechanisms of promoter interference |
| Proudfoot 2016 (Genes Dev 30:529) | Torpedo model of PolII termination |
| Datlinger et al. 2017 (Nat Methods 14:297) | CROP-seq: PolII/PolIII interference observed |
| Tian & Bhatt 2009 (Gene Therapy) | LVDP dual-promoter vector with insulation |

---

## Confidence Assessment

| Claim | Confidence |
|-------|------------|
| PolII read-through past polyA is real (200–2000 bp) | **High** — direct measurements |
| WPRE enhances polyadenylation efficiency | **High** — well-characterized |
| Alpha-globin pause + polyA prevents tandem PolII interference | **High** — Eggermont & Proudfoot 1993 |
| U6 downstream of PolII cassette can show reduced activity | **High** — CROP-seq direct observation |
| Alpha-globin pause specifically protects PolIII (U6) | **Moderate** — mechanism-based inference, not directly tested |
| bGH polyA doesn't silence in iPSCs | **High** — widely used, no reports |
| Pooled screens work with polyA-only insulation (no pause) | **High** — scMPRA, Lalanne et al. |

---

## PolIII Terminator Placement

The PolIII terminator (>=4 T's, typically TTTTT) must be **after the barcode** but is
**not part of the pipeline output**. It lives in the destination vector backbone.

After PaqCI Level 2 assembly:

```
...barcode — GCTA — TTTTTX — [rest of backbone]
              ↑        ↑
         PaqCI* oh   PolIII terminator (in backbone)
```

### Destination vector requirements

1. **PolIII terminator** (TTTTT) immediately after PaqCI* site in backbone
2. **PaqCI* overhang must NOT contain TTTT** — would cause premature PolIII termination.
   Current default `GCTA` is safe.
3. ~4 nt of PaqCI* overhang sequence gets transcribed between barcode and terminator.
   These are constant across all constructs and trimmed during demultiplexing.

---

## Optional Enhancements (Future, Config-Only Changes)

These can be added as `intergene_elements` in the config YAML without any code changes:

1. **Alpha-globin pause element** (~90 bp): From HBA2 3' flanking region. Slows PolII
   so Xrn2 torpedo catches up. Eggermont & Proudfoot 1993 showed polyA + pause
   prevents tandem interference. Place between bGH polyA and PolIII promoter.

2. **cHS4 core insulator** (~250 bp): CTCF-mediated enhancer blocking. More relevant
   for chromosomal integration sites (AAVS1, PiggyBac) in iPSCs.

3. **MAZ element** (~50-100 bp): G-rich pause site from human C2 complement gene.
   Works synergistically with polyA signals (Ashfield et al. 1991).

4. **SV40 late polyA** (~240 bp): ~3x faster termination than bGH. Could replace bGH
   if read-through is observed experimentally. Similar size.
