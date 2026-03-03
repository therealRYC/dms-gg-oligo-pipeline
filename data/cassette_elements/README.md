<!-- Created: 2026-03-03 -->
<!-- Last updated: 2026-03-03 — Add pTK4 provenance for all sequences -->

# Canonical Cassette Element Sequences

Reference sequences for downstream cassette elements used in the DMS-GG oligo pipeline.
These are the verified, canonical sequences referenced by pipeline config files.

**Provenance:** All three sequences (WPRE, spacer, bGH polyA) were obtained from the
**pTK4 vector** (Bhatt et al., Addgene) and sequence-confirmed against the pTK4 map.
The WPRE and spacer come from the GFP cassette region (downstream of GFP, upstream of
hGH polyA). The bGH polyA comes from the puromycin resistance cassette elsewhere in pTK4,
which uses bGH polyA rather than hGH polyA. We swapped out the hGH polyA from the GFP
region for the shorter bGH polyA from the puromycin region.

---

## bGH polyA Signal (225 bp)

**Source:** pTK4 vector, puromycin resistance cassette polyA site. This is a separate
region from the WPRE-spacer-hGH polyA downstream of GFP. Sequence-confirmed against pTK4.
Cross-verified against:
- GenBank J00008.1 (bovine GH gene, Woychik et al. 1982)
- GenBank EF550208.1 (pcDNA3.1+PA vector)
- GenBank U55762.1 (pEGFP-N1 vector, Clontech)
- Goodwin & Rottman 1992 (JBC 267:16330-16338)

**Enzyme sites:** None (no BsmBI `CGTCTC`/`GAGACG` or PaqCI `CACCTGC`/`GCAGGTG`).

```
CTGTGCCTTCTAGTTGCCAGCCATCTGTTGTTTGCCCCTCCCCCGTGCCTTCCTTGACCCTGGAAGGTGC
CACTCCCACTGTCCTTTCCTAATAAAATGAGGAAATTGCATCGCATTGTCTGAGTAGGTGTCATTCTATT
CTGGGGGGTGGGGTGGGGCAGGACAGCAAGGGGGAGGATTGGGAAGACAATAGCAGGCATGCTGGGGATG
CGGTGGGCTCTATGG
```

**Key features:**
- Contains AATAAA polyadenylation hexamer (nt 122-127)
- GU-rich downstream element for cleavage site positioning
- Well-characterized in Goodwin & Rottman 1992
- Standard polyA in pcDNA3.1, pEGFP, pAAV, and most Addgene expression vectors

---

## WPRE (Woodchuck Hepatitis Virus Post-transcriptional Regulatory Element, 589 bp)

**Source:** pTK4 vector, GFP cassette region (downstream of GFP, upstream of hGH polyA).
Sequence-confirmed against pTK4. Standard WPRE sequence used across lentiviral and AAV
expression vectors.

**Enzyme sites:** None (no BsmBI or PaqCI sites).

```
AATCAACCTCTGGATTACAAAATTTGTGAAAGATTGACTGGTATTCTTAACTATGTTGCTCCTTTTACGC
TATGTGGATACGCTGCTTTAATGCCTTTGTATCATGCTATTGCTTCCCGTATGGCTTTCATTTTCTCCTC
CTTGTATAAATCCTGGTTGCTGTCTCTTTATGAGGAGTTGTGGCCCGTTGTCAGGCAACGTGGCGTGGTG
TGCACTGTGTTTGCTGACGCAACCCCCACTGGTTGGGGCATTGCCACCACCTGTCAGCTCCTTTCCGGGA
CTTTCGCTTTCCCCCTCCCTATTGCCACGGCGGAACTCATCGCCGCCTGCCTTGCCCGCTGCTGGACAGG
GGCTCGGCTGTTGGGCACTGACAATTCCGTGGTGTTGTCGGGGAAATCATCGTCCTTTCCTTGGCTGCTC
GCCTATGTTGCCACCTGGATTCTGCGCGGGACGTCCTTCTGCTACGTCCCTTCGGCCCTCAATCCAGCGG
ACCTTCCTTCCCGCGGCCTGCTGCCGGCTCTGCGGCCTCTTCCGCGTCTTCGCCTTCGCCCTCAGACGAG
TCGGATCTCCCTTTGGGCCGCCTCCCCGC
```

**Key features:**
- Enhances mRNA processing, stability, and nuclear export
- Reduces PolII read-through transcription (Higashimoto et al. 2007, Gene Therapy)
- Standard element in lentiviral, AAV, and transposon vectors

---

## Spacer (31 bp)

**Source:** pTK4 vector, GFP cassette region (between WPRE and hGH polyA).
Sequence-confirmed against pTK4.

```
ATCGATACCGAGCGCTGGTCGACAGATCTAC
```

Contains ClaI (ATCGAT) and SalI (GTCGAC) sites — useful as diagnostic restriction sites
but not relevant to Golden Gate assembly.

---

## hGH polyA Signal (477 bp) — DEPRECATED

Previously used in the pipeline. Replaced by bGH polyA (225 bp) for:
- Smaller size (saves 252 bp)
- Better characterization in the literature
- Standard across pcDNA3.1/pEGFP/pAAV vectors
- No functional difference in termination strength

The hGH polyA sequence included an Alu repeat (AluSx subfamily) from the GH1 locus
3' flanking region — genomic passenger DNA not required for polyadenylation.
