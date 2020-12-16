#' tr_sigora_wrapper_H
#'
#' @param query_list List of input genes as a character vector.
#' @param database Database to use, one of "KEGG" or "Reactome". The
#'   `level` argument of `sigora` is automatically set based on chosen
#'   database (2 for KEGG, 4 for Reactome).
#'
#' @return Sigora "summary_results" object.
#'
#' @import purrr
#' @import sigora
#'
#' @description This simple wrapper function allows us to more easily get the
#'   candidate genes from the `sigora` results, as they are automatically included
#'   when using the "saveFile" argument. It writes the results to a temporary
#'   file before loading those same results back in and returning them to the
#'   user.
#'
#' @references None.
#'
#' @seealso <https://www.github.com/travis-m-blimkie/tRavis>
#'
tr_sigora_wrapper_H <- function(query_list, database) {

  # Check and sanitize our inputs
  if (!is.character(query_list)) {
    stop("Argument 'query_list' must be a character vector.")
  }

  db <- tolower(database)
  if (!db %in% c("reactome", "kegg")) {
    stop("Argument 'database' must be one of 'KEGG' or 'Reactome'.")
  }

  # Create the temporary file path
  temp_file <- paste0(
    "./sigora_",
    str_replace_all(
      format(Sys.time(), "%Y-%m-%d_%T"),
      pattern =  ":",
      replacement = "-"
    ),
    ".temp.tsv"
  )

  # Make a quiet version of sigora() that doesn't print to console
  quiet_sigora <- quietly(sigora)

  # Run Sigora using the requested database and appropriate level
  if (db == "kegg") {
    message("Running sigora with parameters 'GPSrepo = kegH, level = 2'...")

    result_part1 <- quiet_sigora(
      GPSrepo   = sigora::kegH,
      level     = 2,
      queryList = query_list,
      saveFile  = temp_file
    )

  } else if (db == "reactome") {
    message("Running sigora with parameters 'GPSrepo = reaH, level = 4'...")

    result_part1 <- quiet_sigora(
      GPSrepo   = sigora::reaH,
      level     = 4,
      queryList = query_list,
      saveFile  = temp_file
    )
  }

  # Read in the saved results and remove the temporary file
  result_part2 <- read_tsv(temp_file, col_types = cols()) %>%
    rename("genes" = Genes)
  file.remove(temp_file)

  message("Done!")
  return(result_part2)
}
