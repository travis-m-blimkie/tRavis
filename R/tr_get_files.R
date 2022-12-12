#' tr_get_files
#'
#' @param folder Directory containing files of interest.
#' @param pattern Optional, case-sensitive pattern to use in file searching. If
#'   no pattern is supplied, all files in the specified directory will be
#'   matched.
#' @param recur Whether file listing should be done recursively. Defaults to
#'   FALSE.
#' @param date Do file names contain a date which should be removed? Must be
#' formatted akin to "YYYYMMDD", i.e. all numeric with no spaces, dashes, etc.
#' Defaults to FALSE.
#' @param removeString Optional string which can be removed from file names when
#'   creating names for the output list.
#'
#' @return Named list of files to be read.
#'
#' @export
#'
#' @import dplyr
#' @import purrr
#' @import stringr
#'
#' @description Function which creates a named list of files in a specified
#'   directory. The list names are trimmed versions of file names, while
#'   contents of the list are the file names themselves. In this way, it can be
#'   easily piped into `purrr::map(~read.csv(.))` to create a named list of
#'   data frames.
#'
#' @references None.
#'
#' @seealso <https://www.github.com/travis-m-blimkie/tRavis>
#'
tr_get_files <- function(folder,
                         pattern = "",
                         recur = FALSE,
                         date = FALSE,
                         removeString = NULL) {

  # List all files in the specified folder, using the provided pattern. If no
  # pattern is supplied, then we will list all files.
  f_files <- list.files(
    path       = folder,
    pattern    = pattern,
    recursive  = recur,
    full.names = TRUE
  )

  # Provide a custom error message if no files are found matching the pattern
  if (length(f_files) == 0) {
    stop(paste0(
      "No files found matching the specified pattern."
    ))
  }

  # Create the names to be assigned to each file in the list, removing the
  # extension from the end. The regex to match any file extension was taken
  # from:
  # https://stackoverflow.com/questions/22235518/regex-for-any-file-extension
  f_names <-
    list.files(folder, pattern = pattern, recursive = recur) %>%
    str_remove(., pattern = "\\.[^\\.]+$")

  # If specified, remove dates from the file names, assuming YYYYMMDD or similar
  # format
  if (date == TRUE) {
    f_names <- f_names %>% str_remove(., pattern = "_?[0-9]{8}")
  }

  # Remove specified string if provided. Needs to be conditional, otherwise
  # `str_remove_all()` returns an error for trying to remove NULL.
  if (!is.null(removeString)) {
    f_names <- f_names %>% str_remove_all(., pattern = removeString)
  }

  # Create and return output object
  f_output <- set_names(f_files, f_names) %>% as.list()
  return(f_output)
}
