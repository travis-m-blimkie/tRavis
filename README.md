# README

### Description
Github repository to hold my custom R package, tRavis.
Install via `devtools::install_github()` function.

#### Current functions include:
- **tr_deseq2_results:** Adds two columns to a DESeq results object and filters based on p-value and fold change. The call to `deseq2::results()` which feeds this function must include the `tidy = T` option.
- **tr_genebody_plotly:** Creates a plotly of gene body coverage, based on QoRTs program results.
- **tr_test_enrichment:** Tests for enrichment of a specified set of genes in a list of genes of interest, using Fisher's Exact Test.
- **tr_tidy_gage:** Coverts output of Gage main function to a tidy dataframe, combining `greater` and `less`, while also filtering on q-value.
