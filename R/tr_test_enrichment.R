#' tr_test_enrichment
#'
#' @param query_genes List of experimentally or otherwise derived genes, in
#'   which one wishes to test for enrichment.
#' @param enrichment_set Set of genes of interest, such as virulence genes.
#' @param total_genes Total number of genes for the organism/species.
#'
#' @return Produces the raw p-value from `fisher.test()`.
#'
#' @export
#'
#' @description Performs Fisher's Exact test to determine enrichment of a set of
#'   genes of interest compared to some list of experimentally derived genes.
#'   Assumes `alternative = "greater"` in call to `fisher.test()`.
#'
#' @references None.
#'
#' @seealso <https://www.github.com/travis-m-blimkie/tRavis>
#'
tr_test_enrichment <- function(query_genes, enrichment_set, total_genes) {

  # Calculate overlap between the query list and enrichment set
  num_overlap <- length(dplyr::intersect(query_genes, enrichment_set))

  # Construct the matrix to be used for the test
  enrichment_matrix <- matrix(c(
    num_overlap,
    length(enrichment_set) - num_overlap,
    length(query_genes) - num_overlap,
    total_genes - length(enrichment_set) - (length(query_genes) - num_overlap)
  ), nrow = 2, ncol = 2)

  # Run and return Fisher's Exact test on the matrix
  raw_pval <-
    stats::fisher.test(enrichment_matrix, alternative = "greater")$p.value

  return(raw_pval)
}
