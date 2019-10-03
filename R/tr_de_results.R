#' tr_de_results
#'
#' @param dds_obj A DESEq2 dataset object as produced by running
#'   \code{DESeq2::DESeq()}.
#' @param col_name The name of the column/variable being analyzed, e.g.
#'   "Treatment" or "Genotype".
#' @param numerator The first argument used as the "experimental condition" in
#'   the DE comparison, e.g. "Treated", or "Mutant".
#' @param denominator The baseline or control condition used in the DE
#'   comparison, e.g. "Control" or "Untreated".
#' @param pAdj Cutoff for adjusted p-value. Defaults to 0.05.
#' @param fc Cutoff for absolute fold change. Defaults to 1.5.
#'
#' @return A dataframe (tibble) of differentially expressed genes, filtered and
#'   without rownames (first column gene contains gene identifier).
#'
#' @export
#'
#' @import dplyr
#'
#' @description This function runs \code{DESeq2::results()} using the contrast
#'   argument and levels specified by the user. It also adds columns for
#'   absolute log2 fold change and fold change, and filters the result based on
#'   user-provided cutoffs for adjusted p-value and log2 fold change.
#'
#' @references None.
#'
#' @seealso \url{https://www.github.com/travis-m-blimkie/tRavis}
#'
tr_de_results <- function(dds_obj,
                          col_name,
                          numerator,
                          denominator,
                          pAdj = 0.05,
                          fc = 1.5) {

  # Run DESeq2::results() with specified comparison, and "tidy = TRUE"
  deseq2_result <- DESeq2::results(object = dds_obj,
                                   contrast = c(col_name, numerator, denominator),
                                   tidy = TRUE)

  # Add columns and filter the result
  output_result <- deseq2_result %>%
    rename("gene" = "row") %>%
    mutate(ABSLFC = abs(log2FoldChange),
                  FC = sign(log2FoldChange) * (2 ^ ABSLFC)) %>%
    filter(padj <= pAdj & ABSLFC >= log2(fc)) %>%
    arrange(padj)

}
