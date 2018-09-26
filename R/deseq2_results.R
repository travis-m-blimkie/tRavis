# deseq2_results ----------------------------------------------------------

# Takes a DESeq results object as input (i.e. must have defined contrast)
# Adds two new columns and filters based on padj and ABSLFC

deseq2_results <- function(result, pAdj = 0.05, fc = 1.5) {
    result$ABSLFC <- abs(result$log2FoldChange)
    result$FC <- (sign(result$log2FoldChange)) * (2 ^ (result$ABSLFC))
    result <- subset(result, padj <= pAdj & ABSLFC >= log2(fc))
    result$gene <- rownames(result)
    rownames(result) <- NULL
}
