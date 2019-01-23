# README

### Description
Github repository to hold my custom R package, tRavis.
Install via `devtools::install_github()` function.

#### Current functions include:
- **tr_biomart_table:** Creates a table from Biomart for converting between different human gene ID types. Currently supports Ensembl, Entrez, and HGNC.
- **tr_deseq2_results:** Adds two columns to a DESeq results object and filters based on p-value and fold change. The call to `deseq2::results()` which feeds this function must include the `tidy = T` option.
- **tr_test_enrichment:** Tests for enrichment of a specified set of genes in a list of genes of interest, using Fisher's Exact Test.
- **tr_tidy_gage:** Coverts output of Gage main function to a tidy dataframe, combining `greater` and `less`, while also filtering on q-value.
