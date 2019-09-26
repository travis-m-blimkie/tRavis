#' tr_tidy_gage
#'
#' @param gage_result Output from call to \code{gage} function.
#' @param qval Cutoff for q-value. Defaults to 0.1.
#'
#' @return A dataframe (tibble) of enriched KEGG pathways, filtered and without
#'   rownames (first column contains pathway name/identifier).
#'
#' @export
#'
#' @import dplyr
#' @import tibble
#'
#' @description This function will simply convert the output from Gage
#'   enrichment into a easier-to-use format, namely a data frame. At the same
#'   time it also filters the result based on q-value, with a default of
#'   "0.1".
#'
#' @references None.
#'
#' @seealso https://www.github.com/travis-m-blimkie/tRavis
#'
tr_tidy_gage <- function(gage_result, qval = 0.1) {

  dplyr::bind_rows(list(
    Up = as.data.frame(gage_result[["greater"]]) %>% tibble::rownames_to_column(),
    Down = as.data.frame(gage_result[["less"]]) %>% tibble::rownames_to_column()
  ), .id = "Direction") %>%
    dplyr::filter(., q.val < qval)

}

