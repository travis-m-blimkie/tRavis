#' Tidy results from DESeq2
#'
#' @param deseq2_result Results object for DE genes, of class `DESeqResults`
#' @param p_adjusted Threshold for adjusted p-value, defaults to 0.05
#' @param fold_change Threshold for fold change, defaults to 1.5
#' @param inform Should a message be printed with the DE comparison and number
#'   of DE genes found? Defaults to `TRUE`.
#'
#' @return A data frame (tibble) of filtered DE genes; see `?DESeq2::results`
#'   for details on the output.
#' @export
#'
#' @import dplyr
#' @importFrom tibble as_tibble rownames_to_column
#'
#' @description Helper function to filter and sort results from DESeq2, to aid
#'   in identifying differentially expressed genes.
#'
#' @references <https://bioconductor.org/packages/DESeq2/>
#' @seealso <https://www.github.com/travis-m-blimkie/tRavis>
#'
#' @examples
#' ex_deseq_result <-
#'   readRDS(system.file("extdata", "ex_deseq_results.rds", package = "tRavis"))
#'
#' tr_clean_deseq2_result(ex_deseq_result)
#'
tr_clean_deseq2_result <- function(
    deseq2_result,
    p_adjusted = 0.05,
    fold_change = 1.5,
    inform = TRUE
) {

  stopifnot(is(deseq2_result, "DESeqResults"))

  comparison <- gsub(
    x = attr(deseq2_result, "elementMetadata")[2, 2],
    pattern = "log2 fold change \\(MLE\\): ",
    replacement = ""
  )

  output_result <- deseq2_result %>%
    as.data.frame() %>%
    rownames_to_column("gene") %>%
    filter(
      padj <= p_adjusted,
      abs(log2FoldChange) >= log2(fold_change)
    ) %>%
    arrange(padj, abs(log2FoldChange)) %>%
    as_tibble()

  num_de_genes <- nrow(output_result)

  if (inform) {
    if (num_de_genes == 0) {
      message("No DE genes found for ", comparison, ".")
    } else {
      message("Found ", num_de_genes, " DE genes for ", comparison, ".")
      return(output_result)
    }
  } else {
    return(output_result)
  }

}
