#!/usr/bin/env python3
"""04_run_python_oogga.py — Run Python OOGGA on GRIN2A+cassette

Imports the Dyna_frag class from the cloned OOGGA repo and runs it with
parameters aligned to our R OOGGA (single-OH, beam_width=1).

OOGGA's DP is inherently single-path (no beam search), so no beam_width
parameter exists — this is already matched.

Output: JSON with boundaries (0-indexed), overhangs, scores, K.
"""

import sys
import os
import json

# --- Locate project root ---
script_dir = os.path.dirname(os.path.abspath(__file__))
comparison_dir = os.path.dirname(script_dir)
project_root = os.path.dirname(comparison_dir)
os.chdir(project_root)
print(f"Project root: {project_root}")

# --- Add OOGGA to path ---
oogga_dir = os.path.join(comparison_dir, "OOGGA")
sys.path.insert(0, oogga_dir)

# We need to import load_csv_table_as_di and Dyna_frag without triggering
# argparse at module level. OOGGA.py has argparse code at module level,
# so we read the file and exec only the class/function definitions.

oogga_path = os.path.join(oogga_dir, "OOGGA.py")
with open(oogga_path) as f:
    oogga_source = f.read()

# Extract just the function and class definitions (before argparse block)
# The argparse block starts with "import argparse"
argparse_idx = oogga_source.index("import argparse")
oogga_defs = oogga_source[:argparse_idx]

# Load the definitions into a namespace
oogga_ns = {}
# Note: exec is used here intentionally to load a trusted local file
# (the cloned OOGGA repository). This is not user input.
exec(oogga_defs, oogga_ns)  # noqa: S102
load_csv_table_as_di = oogga_ns["load_csv_table_as_di"]
Dyna_frag = oogga_ns["Dyna_frag"]
read_fasta = oogga_ns["read_fasta"]

print("OOGGA classes loaded successfully")

# --- Load inputs ---
params_path = os.path.join(comparison_dir, "inputs", "params.json")
with open(params_path) as f:
    params = json.load(f)

fasta_path = os.path.join(comparison_dir, "inputs", "grin2a_full_seq.fasta")
seqs = read_fasta(fasta_path)
seq = list(seqs.values())[0]

csv_path = os.path.join(comparison_dir, "inputs", "bsmbi_for_oogga.csv")

print(f"Sequence length: {len(seq)} nt")
print(f"Gene length: {params['gene_len']} nt")
print(f"Min/Max block: {params['min_len']}/{params['max_len']} nt")
print(f"Alien OHs: {params['alien_ohs']}")
print(f"Exclusion list: {len(params['exclusion_list'])} positions")

# --- Verify CSV data ---
# Quick sanity check: load the CSV and spot-check a few overhangs
score_di = load_csv_table_as_di(csv_path)
print(f"Loaded {len(score_di)} overhangs from CSV")

# Spot check: print a few entries
for oh in ["AACT", "GCTA", "TTAC", "AGCG", "CATG"]:
    if oh in score_di:
        eff, fid = score_di[oh]
        print(f"  {oh}: eff={eff:.4f}%, fid={fid:.4f}%")

# --- Run OOGGA ---
# Parameters aligned with R:
#   - n_frag=False: let OOGGA find optimal K (multi-K search)
#   - n_trace=5: get top 5 traces (we'll use the best one)
#   - start_site=0: standard start
#   - eff_w=1, fid_w=1: equal weighting (matches R's multiplicative scoring)
#   - exclusion_list: non-codon positions in gene region
#   - max_overhang_identity=2: matches R's max_identity
#   - alien_overhangs: empty — OOGGA adds seq[-4:] and seq[0:4] internally
#
# OOGGA automatically adds:
#   - seq[-4:] (terminal overhang) in __overlap_pass
#   - seq[0:4] via trace (start_site overhang = oh_L)
#   - RC of all the above in the identity check
#
# We pass empty alien_overhangs since OOGGA handles these internally.

print("\n--- Running OOGGA DP ---")
df = Dyna_frag(
    seq=seq,
    min_len=params["min_len"],
    max_len=params["max_len"],
    overhang_table=csv_path,
    n_frag=False,        # Let OOGGA find optimal K
    n_trace=5,           # Top 5 traces
    start_site=0,
    eff_w=1,
    fid_w=1,
    exclusion_list=params["exclusion_list"],
    inti_score=1,
    max_overhang_identity=params["max_identity"],
    alien_overhangs=[]   # OOGGA adds seq[-4:] and seq[0:4] internally
)

# --- Extract best result ---
# OOGGA stores traces as lists of boundary positions (0-indexed), sorted
# by score (highest first). traces[0] is the best.
best_trace = df.traces[0]
best_score = df.trace_scores[0]
best_split_scores = df.trace_split_scores[0]  # (eff_product, fid_product)

# OOGGA traces are stored in REVERSE order:
# [last_boundary, ..., first_boundary, start_site]
# Remove start_site (0) from the trace — it's not a real boundary
boundaries = sorted([j for j in best_trace if j != df.start_site])
K = len(boundaries)

print(f"\nBest result: K = {K}")
print(f"Boundaries (0-indexed): {boundaries}")
print(f"Total score: {best_score:.15e}")
print(f"Eff product: {best_split_scores[0]:.15e}")
print(f"Fid product: {best_split_scores[1]:.15e}")

# --- Extract per-boundary overhangs and scores ---
boundary_ohs = []
per_boundary_eff = []
per_boundary_fid = []
per_boundary_scores = []

for j in boundaries:
    oh = seq[j:j+4]
    boundary_ohs.append(oh)
    eff, fid = score_di[oh]
    per_boundary_eff.append(eff)
    per_boundary_fid.append(fid)
    per_boundary_scores.append((eff/100) * (fid/100))

print(f"Boundary OHs: {boundary_ohs}")

# --- Compute segment lengths ---
sorted_bounds = sorted(boundaries)
starts = [0] + sorted_bounds
ends = sorted_bounds + [len(seq)]
segment_lengths = [e - s for s, e in zip(starts, ends)]
print(f"Segments: {segment_lengths}")

# --- Verify scoring ---
# Total score should equal eff_product * fid_product (with eff_w=fid_w=1)
eff_prod_check = 1.0
fid_prod_check = 1.0
for j in boundaries:
    eff, fid = score_di[seq[j:j+4]]
    eff_prod_check *= (eff / 100)
    fid_prod_check *= (fid / 100)

print(f"\nVerification:")
print(f"  Eff product (computed): {eff_prod_check:.15e}")
print(f"  Eff product (OOGGA):   {best_split_scores[0]:.15e}")
print(f"  Fid product (computed): {fid_prod_check:.15e}")
print(f"  Fid product (OOGGA):   {best_split_scores[1]:.15e}")
print(f"  Total score (computed): {eff_prod_check * fid_prod_check:.15e}")
print(f"  Total score (OOGGA):   {best_score:.15e}")

# --- Also dump all traces for reference ---
all_traces = []
for i in range(len(df.traces)):
    trace_bounds = sorted([j for j in df.traces[i] if j != df.start_site])
    trace_ohs = [seq[j:j+4] for j in trace_bounds]
    all_traces.append({
        "rank": i + 1,
        "K": len(trace_bounds),
        "boundaries_0indexed": trace_bounds,
        "overhangs": trace_ohs,
        "total_score": df.trace_scores[i],
        "eff_product": df.trace_split_scores[i][0],
        "fid_product": df.trace_split_scores[i][1]
    })

# --- Write JSON output ---
output = {
    "source": "Python_OOGGA",
    "K": K,
    "n_segments": K + 1,
    "boundaries_0indexed": boundaries,
    "boundary_ohs": boundary_ohs,
    "per_boundary_eff_pct": per_boundary_eff,
    "per_boundary_fid_pct": per_boundary_fid,
    "per_boundary_scores": per_boundary_scores,
    "total_score": best_score,
    "eff_product": best_split_scores[0],
    "fid_product": best_split_scores[1],
    "segment_lengths": segment_lengths,
    "alien_ohs_passed": [],
    "max_identity": params["max_identity"],
    "min_len": params["min_len"],
    "max_len": params["max_len"],
    "gene_len": params["gene_len"],
    "total_len": len(seq),
    "all_traces": all_traces
}

output_path = os.path.join(comparison_dir, "outputs", "python_results.json")
with open(output_path, "w") as f:
    json.dump(output, f, indent=2)
print(f"\nResults written to: {output_path}")
