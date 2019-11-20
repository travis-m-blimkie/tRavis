#' tr_get_files
#'
#' @param folder Directory containing files of interest.
#' @param pattern Optional pattern to use in file searching.
#' @param date Do file names contain a date which should be removed? Should be
#'   of the format "YYYYMMDD"
#' @param removeString Optional string which can be removed from file names when
#'   creating names for the list.
#'
#' @return Named list of files to be read.
#'
#' @export
#'
#' @import purrr
#' @import stringr
#'
#' @description Function which creates a named list of files in a specified
#'   directory. Names are trimmed versions of file names, contents of the list
#'   are the file names themselves. Can be easily piped into
#'   \code{purrr::map(~read.csv(.))} to create named list of data frames.
#'
#' @references None.
#'
#' @seealso \url{https://www.github.com/travis-m-blimkie/tRavis}
#'
tr_get_files <- function(folder, pattern = "", date = FALSE, removeString = "") {

  # List all files in the specifed folder, using the provided pattern, else
  # match all files.
  f_Files <- list.files(folder, pattern = pattern, full.names = TRUE) %>%
    grep("(csv|tsv|txt)$", ., value = TRUE)

  if (length(f_Files) == 0) {
    stop(paste0(
      "No files found matching the specified pattern. Please note ",
      "that this function only supports files with the extension 'csv', 'tsv', ",
      "or 'txt'."
    ))
  }

  # Create the names to be assigned to each file in the list, removing the
  # extension from the end.
  f_Names <- list.files(folder, pattern = pattern) %>%
    grep("(csv|tsv|txt)$", ., value = TRUE) %>%
    map(~str_remove(., pattern = "\\.(csv|tsv|txt)"))

  # If specified, remove dates from the names for files.
  if (date == TRUE) {
    f_Names <- f_Names %>%
      map(~str_remove(., pattern = "_?[0-9]{8}"))
  }

  # Remove specified string if provided. Needs to be in a conditional, otherwise
  # `str_remove()` returns an error for trying to remove nothing/everything/
  # anything.
  if (removeString != "") {
    f_Names <- f_Names %>% map(
      ~str_remove_all(., pattern = removeString)
    )
  }

  # Create and return output object
  f_Output <- set_names(f_Files, f_Names)
  return(as.list(f_Output))
}
