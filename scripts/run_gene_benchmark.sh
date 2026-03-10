#!/bin/bash
# Run 3 boundary methods for a given gene in a worktree
# Usage: bash scripts/run_gene_benchmark.sh <worktree_dir> <gene_name>
# Example: bash scripts/run_gene_benchmark.sh /path/to/260309-benchmark-grin2a grin2a

set -e

WT_DIR="$1"
GENE="$2"

if [ -z "$WT_DIR" ] || [ -z "$GENE" ]; then
  echo "Usage: $0 <worktree_dir> <gene_name>"
  exit 1
fi

cd "$WT_DIR"
echo "=== Benchmark: $GENE ==="
echo "Working directory: $(pwd)"
echo ""

for METHOD in dp oogga_two_pass oogga_greedy; do
  CONFIG="configs/${GENE}_${METHOD}.yaml"
  echo "--- Running $METHOD ---"
  echo "Config: $CONFIG"
  echo "Start: $(date '+%Y-%m-%d %H:%M:%S')"

  Rscript run_pipeline.R "$CONFIG" 2>&1 | grep -E "Step 6|Phase|OOGGA|Pass [12]|boundary|DP|greedy|SB|collision|beam|Timing|Total|report:|Output dir|QC:" | tail -25

  echo "End: $(date '+%Y-%m-%d %H:%M:%S')"
  echo ""
done

echo "=== Done: $GENE ==="
echo ""

# List output reports
echo "Generated reports:"
find output/ -name "*_assembly_report.md" 2>/dev/null
