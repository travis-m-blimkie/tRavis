#' Coerce Gage output to a tidy data frame
#'
#' @param gage_result Output from call to `gage` function; should be a list
#' @param qval Cutoff for q-value, defaults to 0.1
#'
#' @return A filtered data frame (tibble) of enriched KEGG pathways
#' @export
#'
#' @import dplyr
#'
#' @description This function will simply convert the output from Gage
#'   enrichment into an easier-to-use tibble format. At the same time it can
#'   also filter the result based on q value, with a default of `0.1`.
#'
#' @references None.
#'
#' @seealso <https://www.github.com/travis-m-blimkie/tRavis>
#'
tr_tidy_gage <- function(gage_result, qval = 0.1) {

  gageList <- list(gage_result[["greater"]], gage_result[["less"]])

  gageOut <- gageList %>%
    purrr::map(~tibble::rownames_to_column(as.data.frame(.x), "pathway")) %>%
    bind_rows() %>%
    janitor::clean_names() %>%
    tibble::as_tibble() %>%
    filter(q_val < qval)

  return(gageOut)
}
