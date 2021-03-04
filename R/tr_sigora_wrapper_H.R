#' tr_sigora_wrapper_H
#'
#' @param query_list List of input genes as a character vector.
#' @param database Database to use, one of "KEGG" or "Reactome". The
#'   `level` argument of `sigora` is automatically set based on chosen
#'   database (2 for KEGG, 4 for Reactome).
#'
#' @return A tibble corresponding to `sigora`'s "summary_results" object, with
#'   the addition of the "genes" column.
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
tr_sigora_wrapper_H <- function(query_list, database) {

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

  # Make a safe and quiet version of sigora() that doesn't print to console and
  # returns NULL instead of giving an error.
  safe_sigora <- possibly(.f = quietly(sigora), otherwise = NULL)

  result_part1 <- NULL

  # Run Sigora using the requested database and appropriate level
  if (database == "kegg") {
    message("Running sigora with parameters 'GPSrepo = kegH, level = 2'...")

    result_part1 <- safe_sigora(
      GPSrepo   = sigora::kegH,
      level     = 2,
      queryList = query_list,
      saveFile  = temp_file
    )

  } else if (database == "reactome") {
    message("Running sigora with parameters 'GPSrepo = reaH, level = 4'...")

    result_part1 <- safe_sigora(
      GPSrepo   = sigora::reaH,
      level     = 4,
      queryList = query_list,
      saveFile  = temp_file
    )
  }

  # Read in the saved results and remove the temporary file
  if (!is.null(result_part1)) {
    result_part2 <- read_tsv(temp_file, col_types = cols()) %>%
      rename("genes" = Genes)

    file.remove(temp_file)

    message("Done!")
    return(result_part2)
  } else {
    message("WARNING: No results, likely too few genes. Returning NULL")
    return(result_part1)
  }
}
