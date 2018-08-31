# biomart_table -----------------------------------------------------------

# Function that uses the biomaRt package to generate a list of gene IDs for conversions
# Includes Ensembl, Entrez, and HGNC symbol
# Add other desired ID sets to the "attributes" variable to be included

biomart_table <- function() { 
    require(biomaRt)
    getBM(attributes = c("ensembl_gene_id", "hgnc_symbol", "entrezgene"), 
          mart = useMart("ensembl", dataset = "hsapiens_gene_ensembl"))
}
