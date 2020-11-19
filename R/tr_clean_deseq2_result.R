#' tr_clean_deseq2_result
#'
#' @param deseq2_result Results object for DE genes. \code{DESeq2::results()}
#'   must have been called with 'tidy = TRUE'.
#' @param padjusted Threshold for adjusted p-value, defaults to 0.05
#' @param foldchange Threshold for fold change, defaults to 1.5
#'
#' @return Tidy dataframe of filtered DE genes.
#'
#' @export
#'
#' @import dplyr
#'
#' @description Helper function to filter and sort results from DESeq2 to aid in
#'   identifying differentially expressed genes
#'
#' @references None.
#'
#' @seealso \url{https://www.github.com/travis-m-blimkie/tRavis}
#'
#' @examples
#' \dontrun{
#'   DESeq2::results(
#'     dds,
#'     name = "treatment_peptide_vs_vehicle",
#'     tidy = TRUE
#'   ) %>%  tr_clean_deseq2_result(.)
#' }
#'
tr_clean_deseq2_result <- function(deseq2_result, padjusted = 0.05, foldchange = 1.5) {

  # Check for correct input type
  if (!is.data.frame(deseq2_result)) {
    stop("DESeq2::results() must be called with 'tidy = TRUE'.")
  }

  # Rename gene column, filter, and sort
  deseq2_result %>%
    rename("gene" = row) %>%
    filter(padj < padjusted & abs(log2FoldChange) > log2(foldchange)) %>%
    arrange(padj, abs(log2FoldChange))
}
