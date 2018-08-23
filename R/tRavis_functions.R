### Various functions to make my life a little easier :)


# deseq2_results ----------------------------------------------------------

# Takes a DESeq results object as input (i.e. must have defined contrast)
# Adds two new columns and filters based on padj and ABSLFC

deseq2_results <- function(result, pAdj = 0.05, fc = 1.5) {
    result$ABSLFC <- abs(result$log2FoldChange)
    result$FC <- (sign(result$log2FoldChange)) * (2 ^ (result$ABSLFC))
    result <- subset(result, padj <= pAdj & ABSLFC >= log2(fc))
}



# biomart_table -----------------------------------------------------------

# Function that uses the biomaRt package to generate a list of gene IDs for conversions
# Includes Ensembl, Entrez, and HGNC symbol
# Add other desired ID sets to the "attributes" variable to be included

biomart_table <- function() { 
    require(biomaRt)
    getBM(attributes = c("ensembl_gene_id", "hgnc_symbol", "entrezgene"), 
          mart = useMart("ensembl", dataset = "hsapiens_gene_ensembl"))
}
