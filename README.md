# tRavis

### Description
Github repository to hold my custom R package.
Install via `devtools::install_github()` function.

#### Current functions include:
- **tr_compare_lists:** Returns common and unique elements for two vectors `x` and `y`.
- **tr_de_results:** Runs `DESeq2::results()` with provided contrasts, adds columns, and filters the result.
- **tr_deseq2_results:** Adds columns, and filters the result of `DESeq2::results()` call. Maintained for legacy support. 
- **tr_genebody_plotly:** Creates a plotly of gene body coverage, based on QoRTs program results.
- **tr_heatmap:** Wrapper function to make a heatmap from DESeq2 results object (transformed).
- **tr_test_enrichment:** Tests for enrichment of a specified set of genes in a list of genes of interest, using Fisher's Exact Test.
- **tr_tidy_gage:** Coverts output of Gage main function to a tidy dataframe, combining `greater` and `less`, while also filtering on q-value.
