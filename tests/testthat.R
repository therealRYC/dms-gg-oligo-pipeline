# Run all tests
library(testthat)

# Source all pipeline modules
pipeline_dir <- file.path(dirname(dirname(sys.frame(1)$ofile %||% ".")))
if (pipeline_dir == ".") pipeline_dir <- getwd()

source(file.path(pipeline_dir, "R", "constants.R"))
source(file.path(pipeline_dir, "R", "utils.R"))
source(file.path(pipeline_dir, "R", "00_config.R"))
source(file.path(pipeline_dir, "R", "01_gene_input.R"))
source(file.path(pipeline_dir, "R", "02_enzyme_site_scan.R"))
source(file.path(pipeline_dir, "R", "03_codon_table.R"))
source(file.path(pipeline_dir, "R", "04_mutation_design.R"))
source(file.path(pipeline_dir, "R", "05_tiling.R"))
source(file.path(pipeline_dir, "R", "06_overhang_selection.R"))
source(file.path(pipeline_dir, "R", "07_barcode_design.R"))
source(file.path(pipeline_dir, "R", "08_oligo_assembly.R"))
source(file.path(pipeline_dir, "R", "09_wt_geneblock_design.R"))
source(file.path(pipeline_dir, "R", "10_qc_checks.R"))
source(file.path(pipeline_dir, "R", "11_output.R"))

test_dir(file.path(pipeline_dir, "tests", "testthat"))
