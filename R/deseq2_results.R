
# deseq2_results ----------------------------------------------------------

# Takes a DESeq results object as input (i.e. must have defined contrast)
# Adds two new columns and filters based on padj and ABSLFC
# Sorts genes by adjusted p-value

deseq2_results <- function(result, pAdj = 0.05, fc = 1.5) {

  if (is.data.frame(result) != T) stop("Did you call deseq2::results() with the 'tidy = T' option?")

  result$ABSLFC <- abs(result$log2FoldChange)
  result$FC <- (sign(result$log2FoldChange)) * (2 ^ (result$ABSLFC))

  result <- subset(result, padj <= pAdj & ABSLFC >= log2(fc))

  result <- result[order(result$padj), ]

  colnames(result)[colnames(result) == "row"] <- "gene"

  return(result)
}
