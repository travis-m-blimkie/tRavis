# README

### Description
Github repository to hold my custom R package, tRavis. 
Install via `devtools::install_github()` function. 

#### Current functions include:
- **tr_deseq2_results:** Adds two columns to a DESeq results object and filters based on p-value and fold change. The call to `deseq2::results()` which feeds to this function must include the `tidy = T` option. 
- **tr_biomart_table:** Creates a table from Biomart for converting between different human gene ID types. Currently supports Ensembl, Entrez, and HGNC. 
- **tr_test_enrichment:** Tests for enrichment of a signature set of genes in a list of genes of interest, using Fisher's Exact Test.
- **tr_go_enrichment:** Test for enrichment of a set of genes of interest against all GO terms for *P. aeruginosa*. Currently supports PAO1, PA14, and LESB58.
- **tr_pathway_enrichment:** WIP script to test for pathway enrichment for *P. aeruginosa* strains. 
- **tr_tidy_gage:** Coverts output of Gage main function to a tidy dataframe, while also filtering on q-value.

