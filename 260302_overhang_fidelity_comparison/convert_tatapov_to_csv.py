# Created: 2026-03-02
# Last updated: 2026-03-02 — Initial implementation

"""
Convert tatapov library matrices to CSV for R analysis.

Extracts 3 ligation fidelity matrices (256×256 each) from the tatapov Python
library and saves them as CSVs with 4-nt overhang row/column headers.

Datasets:
  - T4 ligase, 25°C/18h  (Potapov et al. 2018)
  - BsaI cycling, 37°C/1h (Pryor et al. 2020, Table S1)
  - BsmBI cycling, 37°C/1h (Pryor et al. 2020, Table S2)

Cross-validates BsaI and BsmBI CSVs against the original Pryor 2020 Excel
supplementary files to confirm tatapov faithfully reproduces the source data.
"""

import sys
from pathlib import Path

import pandas as pd
import tatapov

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------

# tatapov key → output filename
DATASETS = {
    ("25C", "18h"): "t4_25c_18h_matrix.csv",
    ("37C", "2020_01h_BsaI"): "bsai_cycling_matrix.csv",
    ("37C", "2020_01h_BsmBI"): "bsmbi_cycling_matrix.csv",
}

# Pryor Excel files for cross-validation (BsaI = S1, BsmBI = S2)
PRYOR_EXCEL = {
    ("37C", "2020_01h_BsaI"): "pone.0238592.s001.xlsx",
    ("37C", "2020_01h_BsmBI"): "pone.0238592.s002.xlsx",
}

# Paths
SCRIPT_DIR = Path(__file__).resolve().parent
DATA_DIR = SCRIPT_DIR / "data"
PRYOR_DIR = SCRIPT_DIR.parent / "data" / "pryor2020_overhang_fidelity"


def extract_and_save(temp: str, time: str, out_name: str) -> pd.DataFrame:
    """Extract a tatapov matrix and save to CSV.

    Args:
        temp: Temperature key (e.g., '25C', '37C').
        time: Time/condition key (e.g., '18h', '2020_01h_BsmBI').
        out_name: Output CSV filename.

    Returns:
        The extracted DataFrame (256×256).
    """
    df = tatapov.annealing_data[temp][time]
    assert df.shape == (256, 256), f"Unexpected shape {df.shape} for {temp}/{time}"
    out_path = DATA_DIR / out_name
    df.to_csv(out_path)
    print(f"  Saved {out_path.name}: {df.shape[0]} rows × {df.shape[1]} cols")
    return df


def load_pryor_excel(xlsx_path: Path) -> pd.DataFrame:
    """Load a Pryor 2020 supplementary Excel matrix.

    The Excel files have overhang labels in column A and row 1, with the
    256×256 count matrix in the interior cells.

    Args:
        xlsx_path: Path to the .xlsx file.

    Returns:
        DataFrame with overhang index and columns matching tatapov format.
    """
    df = pd.read_excel(xlsx_path, index_col=0, engine="openpyxl")
    # Ensure string index/columns (overhangs)
    df.index = df.index.astype(str)
    df.columns = df.columns.astype(str)
    assert df.shape == (256, 256), f"Excel shape {df.shape}, expected (256, 256)"
    return df


def cross_validate(
    tatapov_df: pd.DataFrame,
    excel_df: pd.DataFrame,
    dataset_name: str,
) -> int:
    """Compare tatapov matrix against Pryor Excel, cell by cell.

    Both DataFrames are aligned by their overhang labels (index/columns),
    so this catches any ordering differences as well as value mismatches.

    Args:
        tatapov_df: Matrix from tatapov library.
        excel_df: Matrix from Pryor 2020 Excel.
        dataset_name: Human-readable name for logging.

    Returns:
        Number of mismatched cells (0 = perfect match).
    """
    # Align on overhang labels
    common_idx = tatapov_df.index.intersection(excel_df.index)
    common_col = tatapov_df.columns.intersection(excel_df.columns)

    if len(common_idx) != 256 or len(common_col) != 256:
        print(
            f"  WARNING: {dataset_name} label overlap: "
            f"{len(common_idx)} rows, {len(common_col)} cols (expected 256)"
        )

    t = tatapov_df.loc[common_idx, common_col]
    e = excel_df.loc[common_idx, common_col]

    mismatches = (t != e).sum().sum()
    total = t.shape[0] * t.shape[1]
    print(f"  {dataset_name}: {total} cells compared, {mismatches} mismatches")
    return mismatches


def main() -> int:
    """Run extraction and cross-validation.

    Returns:
        0 if all validations pass, 1 otherwise.
    """
    DATA_DIR.mkdir(exist_ok=True)

    # --- Step 1: Extract tatapov matrices to CSV ---
    print("Step 1: Extracting tatapov matrices to CSV...")
    extracted = {}
    for (temp, time), out_name in DATASETS.items():
        extracted[(temp, time)] = extract_and_save(temp, time, out_name)

    # --- Step 2: Cross-validate against Pryor Excel ---
    print("\nStep 2: Cross-validating against Pryor 2020 Excel files...")
    total_mismatches = 0
    for (temp, time), xlsx_name in PRYOR_EXCEL.items():
        xlsx_path = PRYOR_DIR / xlsx_name
        if not xlsx_path.exists():
            print(f"  WARNING: {xlsx_path} not found — skipping validation")
            continue
        excel_df = load_pryor_excel(xlsx_path)
        n_mis = cross_validate(extracted[(temp, time)], excel_df, f"{temp}/{time}")
        total_mismatches += n_mis

    # --- Summary ---
    print(f"\nDone. Total mismatches across all validations: {total_mismatches}")
    if total_mismatches == 0:
        print("All cross-validations PASSED.")
        return 0
    else:
        print("VALIDATION FAILED — see mismatches above.")
        return 1


if __name__ == "__main__":
    sys.exit(main())
