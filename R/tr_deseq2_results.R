#' tr_deseq2_results
#'
#' @param result Output from call to DESeq2's results function. Must have been
#'   run with the tidy = TRUE option
#' @param pAdj Cutoff for adjusted p-value. Defaults to 0.05
#' @param fc Cutoff for the fold change value. Defaults to 1.5
#'
#' @return A dataframe (tibble) of differentially expressed genes, filtered and
#'   without rownames (first column contains gene identifier).
#'
#' @export
#'
#' @description This function adds two columns to the results object: ABSLFC is
#'   the absolute value of the log2FoldChange column. FC is the fold change,
#'   calculated from the log2FoldChange. It also filters the results based on
#'   absolute fold change and adjusted p-value, and orders by adjusted p-value.
#'   Requires tidyverse installation.
#'
#' @seealso https://www.github.com/travis-m-blimkie/tRavis
#'
#' @examples
#' initial_result <- results(dds, name = "treatment vs. control", tidy = T)
#' new_result <- tr_deseq2_results(initial_result, pAdj = 0.05, fc = 1.5)
#'
tr_deseq2_results <- function(result, pAdj = 0.05, fc = 1.5) {

  requireNamespace(tidyverse)

  if (is.data.frame(result) != TRUE) {
    stop("Did you call DESeq2::results() with the 'tidy = TRUE' option?")
  }

  result$ABSLFC <- abs(result$log2FoldChange)
  result$FC <- (sign(result$log2FoldChange)) * (2 ^ (result$ABSLFC))

  result <- subset(result, padj <= pAdj & ABSLFC >= log2(fc))

  result <- result[order(result$padj), ]

  colnames(result)[colnames(result) == "row"] <- "gene"

  result <- remove_rownames(result)

  return(result)

}
