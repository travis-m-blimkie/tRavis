#' tr_sigora_wrapper
#'
#' @param query_list List of input genes as a character vector.
#' @param database Database to use, one of "KEGG" or "Reactome". The
#'   `level` argument of `sigora` is automatically set based on the chosen
#'   database (2 for KEGG, 4 for Reactome).
#' @param species Species in which to test for pathways. Can be "human" or
#'   "mouse".
#'
#' @return A tibble corresponding to `sigora`'s "summary_results" object with
#'   the "genes" column.
#'
#' @export
#'
#' @import purrr
#' @import sigora
#'
#' @description This simple wrapper function allows us to more easily get the
#'   candidate genes from the `sigora` results, as they are automatically
#'   included when using the "saveFile" argument. It writes the results to a
#'   temporary file before loading those same results back in and returning them
#'   to the user. The function uses a quiet and safe version of `sigora` (based
#'   on the `quiet()` and `possibly()` `purrr` functions), meaning it will
#'   return NULL instead of an error, such as in the case when there are too few
#'   genes given as input.
#'
#' @references None.
#'
#' @seealso <https://www.github.com/travis-m-blimkie/tRavis>
#'
tr_sigora_wrapper <- function(query_list, database, species) {

  # Check and sanitize our inputs
  if (!is.character(query_list)) {
    stop("Argument 'query_list' must be a character vector.")
  }

  db <- tolower(database)
  if (!db %in% c("reactome", "kegg")) {
    stop("Argument 'database' must be one of 'KEGG' or 'Reactome'.")
  }

  species <- tolower(species)

  if (species == "human") {
    tr_sigora_wrapper_H(query_list = query_list, database = db)
  } else if (species == "mouse") {
    tr_sigora_wrapper_M(query_list = query_list, database = db)
  } else {
    stop("Argument 'species' must be one of 'human' or 'mouse'.")
  }
}
