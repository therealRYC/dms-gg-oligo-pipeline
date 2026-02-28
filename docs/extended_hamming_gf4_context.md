# Extended Hamming Codes over GF(4) for DNA Barcode Design

## Context

We have a bioinformatics pipeline that designs DNA barcode sequences for Deep
Mutational Scanning experiments. Barcodes must have a minimum Hamming distance
d between all pairs to tolerate sequencing errors. We currently use GF(4)
Hamming codes (d=3) for barcode prefix generation and want to understand
whether extending to d=4 via an overall parity check is sound.

## Current implementation

We construct shortened quaternary Hamming codes over GF(4) = GF(2^2), where
the four field elements {0, 1, alpha, alpha+1} map bijectively to DNA bases
{A, C, G, T}.

For prefix_length n, we build Ham_4(m) with native parameters
[(4^m - 1)/3, (4^m - 1)/3 - m, 3]_4, then shorten to length n by fixing
some information positions to zero. This gives a [n, n - m, >= 3]_4 code.

Example: prefix_length = 12, m = 3 gives native [21, 18, 3]_4, shortened
to [12, 9, >= 3]_4 with capacity 4^9 = 262,144 codewords.

## Proposed extension to d=4

Append an overall parity check symbol p to each codeword:

    p = c_1 + c_2 + ... + c_n   (arithmetic in GF(4), where addition is XOR
                                  of 2-bit representations)

This is equivalent to adding the all-ones row [1, 1, ..., 1] to the parity
check matrix H, producing an extended code with parameters [n+1, k, d'] where
d' >= 4.

## Questions for verification

1. For a shortened Hamming code over GF(4) with minimum distance exactly 3:
   does adding an overall GF(4) parity check symbol always increase d to
   exactly 4? The argument is that weight-3 codewords (which exist in the
   Hamming code) have nonzero symbol sum due to GF(4) characteristic 2,
   so the extended codeword has weight 4. Is this correct for GF(4)
   specifically, or are there subtleties with the quaternary case vs binary?

2. After shortening: if we start with the extended [22, 18, 4]_4 code and
   shorten to [12, 8, 4]_4 (removing 10 positions), is d >= 4 preserved?
   (Shortening should only preserve or increase d, but want to confirm for
   this specific construction.)

3. Is there a tighter bound? Could the shortened extended Hamming code over
   GF(4) have d > 4 for specific shortening amounts, or is 4 always tight?

4. For the alternative approach of keeping prefix_length = 12 but using
   [12, 8, 4]_4 (shortened extended Hamming) vs [12, 9, 3]_4 (shortened
   Hamming): the capacity drops from 4^9 = 262,144 to 4^8 = 65,536. Is there
   a better GF(4) linear code that achieves d=4 with higher dimension for
   n=12? (i.e., does a [12, 9, 4]_4 code exist, or does the Singleton bound
   k <= n - d + 1 = 9 suggest this is theoretically possible but not
   achievable with known constructions?)

## Field arithmetic reference

GF(4) = GF(2^2) with irreducible polynomial x^2 + x + 1 over GF(2).

Elements: {0, 1, alpha, alpha+1} where alpha^2 = alpha + 1.

Addition (XOR):       Multiplication:
  + | 0 1 a b          * | 0 1 a b
  --+--------          --+--------
  0 | 0 1 a b          0 | 0 0 0 0
  1 | 1 0 b a          1 | 0 1 a b
  a | a b 0 1          a | 0 a b 1
  b | b a 1 0          b | 0 b 1 a

  (where a = alpha, b = alpha+1)

Characteristic 2: every element is its own additive inverse (a + a = 0).
