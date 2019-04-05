
# tr_de_results ---------------------------------------------------------

# Runs DESeq2's results function, adds columns and filters the result


tr_de_results <- function(dds_obj, col_name, numerator, denominator, pAdj = 0.05, fc = 1.5) {

  # Require some libraries
  require(DESeq2)
  require(tidyverse)

  # Run DESeq2::results() with specified comparison, and "tidy = T"
  deseq2_result <- results(object = dds, contrast = c(col_name, treatment, baseline), tidy = T)

  # Add columns and filter the result
  output_result <- deseq2_result %>%
    rename("gene" = "row") %>%
    mutate(ABSLFC = abs(log2FoldChange)) %>%
    mutate(FC = sign(log2FoldChange) * (2 ^ ABSLFC)) %>%
    filter(padj <= pAdj & ABSLFC >= log2(fc)) %>%
    arrange(padj)


}
