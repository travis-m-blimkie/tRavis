#' Coerce Gage output to a tidy data frame
#'
#' @param gage_result A list output from a call to `gage::gage`
#' @param qval Cutoff for q value, defaults to 0.1
#'
#' @return A data frame (tibble)
#' @export
#'
#' @import dplyr
#' @importFrom janitor clean_names
#' @importFrom purrr map
#' @importFrom tibble as_tibble rownames_to_column
#'
#' @description This function will simply convert the output from Gage
#'   enrichment into an easier-to-use tibble format. At the same time it can
#'   also filter the result based on q value, with a default of `0.1`.
#'
#' @references None.
#' @seealso <https://www.github.com/travis-m-blimkie/tRavis>
#'
#' @examples
#' ex_gage_results <-
#'   readRDS(system.file("extdata", "ex_gage_results.rds", package = "tRavis"))
#'
#' tr_tidy_gage(ex_gage_results, qval = 1)
#'
tr_tidy_gage <- function(gage_result, qval = 0.1) {

  gage_list <- list(gage_result[["greater"]], gage_result[["less"]])

  gage_out <- gage_list %>%
    map(~as_tibble(.x, rownames = "pathway")) %>%
    bind_rows() %>%
    clean_names() %>%
    filter(q_val < qval)

  return(gage_out)
}
