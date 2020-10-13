#' tr_get_sigora_genes
#'
#' @param sigora_result Data frame containing filtered results from Sigora. Uses
#'   the default column name for Reactome ID, "pathwy.id".
#' @param de_genes Data frame containing DE genes or other genes used as input
#'   for \code{sigora::sigora()}.
#' @param col Column name corresponding to Ensembl gene IDs.
#' @param reactome_data Table of all Reactome pathways/genes, with one gene per
#'   row. Expected column names are "reactome_id" and "ensembl_gene_id".
#'
#' @return Modified Sigora result table with additional columns with all the
#'   genes belonging to a given pathway, and the genes which are also present in
#'   the input gene list (e.g. DE genes).
#'
#' @export
#'
#' @description Takes \code{sigora::sigora()} result table and corresponding
#'   input genes, along with the full Reactome (human) data and returns the
#'   constituent genes for each pathway. Includes all member genes from a
#'   pathway (all_genes) as well as those which are also present in the user's
#'   input gene list (candi_genes).
#'
#' @references None.
#'
#' @seealso \url{https://www.github.com/travis-m-blimkie/tRavis}
#'
tr_get_sigora_genes <- function(sigora_result, de_genes, col, reactome_data) {

  # Check the input types before continuing
  if (!all(c("reactome_id", "ensembl_gene_id") %in% colnames(human_reactome_data))) {
    stop(paste0(
      "Argument 'reactome_data' must contain the following columns: ",
      "'reactome_id' and 'ensembl_gene_id' (case-sensitive)."
    ))
  }

  if (!is.data.frame(sigora_result)) {
    stop("Argument 'sigora_result' must be a data frame.")
  }

  gene_vector <- de_genes[[col]]
  if (!str_detect(gene_vector[1], "^ENSG")) {
    stop("Specified column must contain Ensembl gene IDs.")
  }

  message("Input OK, mapping...")

  this <- sigora_result %>% mutate(
    temp1 = map(
      pathwy.id,
      ~filter(reactome_data, reactome_id == .) %>%
        group_by(reactome_id) %>%
        summarise(
          all_genes = paste(hgnc_symbol, collapse = ", "), .groups = "drop"
        )
    ),
    temp2 = map(
      pathwy.id,
      ~filter(reactome_data, reactome_id == .) %>%
        filter(ensembl_gene_id %in% gene_vector) %>%
        group_by(reactome_id) %>%
        summarise(
          candi_genes = paste(hgnc_symbol, collapse = ", "), .groups = "drop"
        )
    )
  ) %>%
    unnest(cols = c(temp1, temp2), names_repair = "universal") %>%
    select(-c(contains("reactome_id")))

  message("Done!")

  return(this)
}
