#' Perform a basic enrichment test
#'
#' @param query_set List of experimentally or otherwise derived genes, in which
#'   one wishes to test for enrichment
#' @param enrichment_set Set of genes of interest, such as virulence genes
#' @param total_genes Total number of genes for the organism/species
#'
#' @return Numeric: the raw p-value from `fisher.test()`
#' @export
#'
#' @importFrom stats fisher.test
#'
#' @description Performs Fisher's Exact test to determine enrichment of a set of
#'   genes of interest compared to some list of experimentally derived genes.
#'   Uses `alternative = "greater"` in the call to `fisher.test()`.
#'
#' @references ?stats::fisher.test
#' @seealso <https://www.github.com/travis-m-blimkie/tRavis>
#'
#' @examples
#' all_genes <- paste0("gene", sample(1:10000, 5000))
#' de_genes <- sample(all_genes, 1500)
#' ex_set <- sample(all_genes, 100)
#'
#' tr_test_enrichment(
#'   query_set = de_genes,
#'   enrichment_set = ex_set,
#'   total_genes = 5000
#' )
#'
tr_test_enrichment <- function(query_set, enrichment_set, total_genes) {

  n_overlap <- length(intersect(query_set, enrichment_set))

  enrichment_matrix <- matrix(c(
    n_overlap,
    length(enrichment_set) - n_overlap,
    length(query_set) - n_overlap,
    total_genes - length(enrichment_set) - (length(query_set) - n_overlap)
  ), nrow = 2, ncol = 2)

  raw_p <- fisher.test(enrichment_matrix, alternative = "greater")$p.value

  return(raw_p)
}
