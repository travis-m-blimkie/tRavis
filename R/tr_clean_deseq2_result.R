#' tr_clean_deseq2_result
#'
#' @param deseq2_result Results object for DE genes, of class
#'   `DESeqResults`.
#' @param p_adjusted Threshold for adjusted p-value, defaults to 0.05
#' @param fold_change Threshold for fold change, defaults to 1.5
#' @param inform Should a message be printed with the number of DE genes found?
#'   Defaults to `TRUE`.
#'
#' @return Tidy dataframe of filtered DE genes.
#'
#' @export
#'
#' @import dplyr
#'
#' @description Helper function to filter and sort results from DESeq2 to aid in
#'   identifying differentially expressed genes.
#'
#' @references None.
#'
#' @seealso <https://www.github.com/travis-m-blimkie/tRavis>
#'
#' @examples
#' \dontrun{
#'   DESeq2::results(dds, name = "treatment_peptide_vs_vehicle") %>%
#'     tr_clean_deseq2_result()
#' }
#'
tr_clean_deseq2_result <- function(deseq2_result,
                                   p_adjusted  = 0.05,
                                   fold_change = 1.5,
                                   inform      = TRUE) {

  comparison <- attr(deseq2_result, "elementMetadata")[2, 2] %>%
    str_remove(., "log2 fold change \\(MLE\\): ")

  output_result <- deseq2_result %>%
    as.data.frame() %>%
    rownames_to_column("gene") %>%
    filter(
      padj < p_adjusted,
      abs(log2FoldChange) > log2(fold_change)
    ) %>%
    arrange(padj, abs(log2FoldChange))

  num_de_genes <- nrow(output_result)

  if (inform) {
    if (num_de_genes == 0) {
      message(paste0("No DE genes found for ", comparison, "."))
    } else {
      message(paste0("Found ", num_de_genes, " DE genes for ", comparison, "."))
      return(output_result)
    }
  } else {
    return(output_result)
  }

}
