# README

### Description
Github repository to hold my custom R package, tRavis. 

#### Current functions contained therein:
- **deseq2_results** Adds two columns to a DESeq results object and filters based on p-value and fold change
- **biomart_table** Creates a table from Biomart for converting between different ID types. Currently supports Ensembl, Entrez, and HGNC. 
- **pao1_enrichment** Tests for enrichment of a signature set of genes in a list of genes of interest, using Fisher's Exact Test.

Also contains a custom GPS object for use with Sigora pathway enrichment, based on the most recent version of Reactome. 
The script used to create this object is included as "make_reaH_allLevels.txt". 
