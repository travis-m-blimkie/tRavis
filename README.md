# README

### Description
Github repository to hold my custom R package, tRavis. 
Install via `devtools::install_github()` function. 

#### Current functions include:
- **deseq2_results** Adds two columns to a DESeq results object and filters based on p-value and fold change. 
	The call to `results()` which feeds to this function must include the `tidy = T` option. 
- **biomart_table** Creates a table from Biomart for converting between different ID types. Currently supports Ensembl, Entrez, and HGNC. 
- **pao1_enrichment** Tests for enrichment of a signature set of genes in a list of genes of interest, using Fisher's Exact Test.
- **pao1_go_enrichment** Test for enrichment of a set of genes of interest against all GO terms for *P. aeruginosa*. 

