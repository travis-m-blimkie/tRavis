#' Wrapper for pathway enrichment with ReactomePA or sigora
#'
#' @param tool Package to use for enrichment tests - either "ReactomePA" or
#'   "Sigora"
#' @param input_genes Character vector of input genes. For ReactomePA, these
#'   should be Entrez IDs; for Sigora, Ensembl IDs are recommended.
#' @param species Desired species for ReactomePA, either "human" (default) or
#'   "mouse"
#' @param background Specified gene universe for ReactomePA; default is NULL, or
#'   can be a character vector of Entrez gene IDs.
#' @param gps_repo Pathway data to run Sigora with. Should be either one of the
#'   provided options (e.g. `data("reaH")`) or one created by
#'   `sigora::makeGPS()`
#' @param lvl Level to use for Sigora enrichment; should be 4 for Reactome, or 2
#'   for KEGG
#'
#' @return Data frame of results
#' @export
#'
#' @import ReactomePA
#' @import sigora
#' @import tibble
#' @import purrr
#'
#' @references None.
#'
#' @seealso <https://www.github.com/travis-m-blimkie/tRavis>
#'
tr_enrichment_wrapper <- function(tool, input_genes, species = "human", background = NULL, gps_repo, lvl) {

  stopifnot(is.character(input_genes))

  input_clean <- na.omit(unique(input_genes))

  if (tool == "ReactomePA") {

    message(glue::glue(
      "Testing {length(input_clean)} genes..."
    ), appendLF = FALSE)

    output <- enrichPathway(
      gene     = input_clean,
      organism = species,
      universe = background
    ) %>%
      pluck("result") %>%
      remove_rownames() %>%
      janitor::clean_names() %>%
      as_tibble()

    message("Done")
    return(output)

  } else if (tool == "Sigora") {

    message(glue::glue(
      "Testing {length(input_clean)} genes..."
    ), appendLF = FALSE)

    quiet <- function(...) {
      sink(tempfile())
      on.exit(sink())
      eval(...)
    }

    output <- quiet(sigora(
      queryList = input_clean,
      GPSrepo   = gps_repo,
      level     = lvl
    )) %>%
      pluck("summary_results") %>%
      remove_rownames() %>%
      janitor::clean_names() %>%
      as_tibble()

    message("Done")
    return(output)

  } else {
    stop("Argument 'tool' must be one of 'ReactomePA' or 'Sigora' (case-sensitive)")
  }

}
