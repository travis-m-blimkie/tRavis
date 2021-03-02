# News

### 0.71.22

* `tr_get_files()` is no longer specific to csv, tsv, and txt files.

### 0.71.01

* `tr_sigora_wrapper()` now runs quietly and returns NULL instead of an error

### 0.70.2

* Added option to use `tr_sigora_wrapper()` with human or mouse input genes

### 0.70.1

* Added and updated with new function `tr_clean_deseq2_result`

### 0.69.00

* Added function `tr_sigora_wrapper`

### 0.68.00

* Removed function  `tr_get_sigora_genes`

### 0.67.00

* Added new function `tr_get_sigora_genes`

### v0.66.02

* Changed behaviour of `tr_theme` to display grid by default
* Changed title and axis labels of FastQC plot in `tr_qc_plots`
* Added News, and retroactively added info for the last couple versions

### v0.66.01

* Revised STAR code for `tr_qc_plots` 

### v0.66.00

* Added new function `tr_qc_plots` to recreate [MultiQC](https://multiqc.info/)
plots via `plotly`, so interactive plots can be embedded in RMarkdown reports
