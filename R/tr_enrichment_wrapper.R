#' Wrapper for pathway enrichment with ReactomePA or sigora
#'
#' @param tool Package to use for enrichment tests - either "ReactomePA" or
#'   "Sigora"
#' @param input_genes Character vector of input genes. For ReactomePA, these
#'   should be Entrez IDs; for Sigora, Ensembl IDs are recommended.
#' @param species Desired species for ReactomePA, either "human" (default) or
#'   "mouse". Does not apply to `tool = "sigora"`.
#' @param background Specified gene universe for ReactomePA; default is NULL, or
#'   can be a character vector of Entrez gene IDs. Does not apply to `tool =
#'   "sigora"`
#' @param gps_repo Gene pair signature object for Sigora to use. Can be one of
#'   the data objects shipped with this package (`gps_rea_hsa` or `gps_rea_mmu`
#'   for Reactome data for human and mouse, respectively), or one from Sigora
#'   itself - see `?sigora::sigora` for details. Does not apply for `tool =
#'   "ReactomePA"`
#' @param lvl Level to use when running Sigora; recommend 4 for Reactome data,
#'   or 2 for KEGG data. Does not apply for `tool = "ReactomePA"`
#'
#' @return Data frame (tibble) of results
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
tr_enrichment_wrapper <- function(tool, input_genes, species = "human", background = NULL, gps_repo = NULL, lvl = NULL) {

  # Check inputs
  stopifnot(is.character(input_genes))
  input_clean <- na.omit(unique(input_genes))
  tool <- tolower(tool)

  if (tool == "reactomepa") {

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

  } else if (tool == "sigora") {

    if (is.null(gps_repo)) {
      stop("When running Sigora, you must provide a GPS object. ",
           "See '?tr_enrichment_wrapper' for more information")
    }

    if (is.null(lvl)) {
      stop("When running Sigora, you must provide the 'lvl' argument. ",
           "See '?tr_enrichment_wrapper' for more information")
    }

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
    stop("Argument 'tool' must be one of 'ReactomePA' or 'Sigora'")
  }
}
