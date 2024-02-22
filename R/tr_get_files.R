#' Create a named list of files
#'
#' @param directory Directory containing files to read
#' @param pattern Optional, case-sensitive pattern to use in file searching. If
#'   no pattern is supplied, all files in the specified directory will be
#'   returned.
#' @param recur Whether file searching and listing should be done recursively.
#'   Defaults to FALSE.
#' @param date Do file names contain a date which should be removed? Must be
#'   formatted akin to "YYYYMMDD", i.e. all numeric with no spaces, dashes, etc.
#'   Defaults to FALSE.
#' @param remove_string Optional string which can be removed from file names when
#'   creating names for the output list
#'
#' @return Named list of files
#' @export
#'
#' @import dplyr
#' @importFrom stats setNames
#'
#' @description Function which creates a named list of files in a specified
#'   directory. The list names are trimmed versions of file names, while
#'   contents of the list are the file names themselves. In this way, it can be
#'   easily piped into `purrr::map(~read.csv(.x))` to create a named list of
#'   data frames.
#'
#' @references None.
#' @seealso <https://www.github.com/travis-m-blimkie/tRavis>
#'
#' @examples
#' tr_get_files(
#'   directory = system.file("extdata", package = "tRavis"),
#'   pattern = "test",
#'   remove_string = "test_",
#'   date = TRUE
#' )
#'
tr_get_files <- function(
    directory,
    pattern = "",
    recur = FALSE,
    date = FALSE,
    remove_string = NULL
) {
  f_files <- list.files(
    path = directory,
    pattern = pattern,
    recursive = recur,
    full.names = TRUE
  )

  stopifnot(
    "No files found matching the specified pattern" = length(f_files) != 0
  )

  # Create the names to be assigned to each file in the list, removing the
  # extension from the end. The regex to match file extensions comes from:
  # https://stackoverflow.com/questions/22235518/regex-for-any-file-extension
  f_names <- list.files(directory, pattern = pattern, recursive = recur) %>%
    gsub(pattern = "\\.[^\\.]+$", replacement = "") %>%
    gsub(pattern = "^_|_$", replacement = "")

  # Remove dates from the file names if specified, assuming "YYYYMMDD" or
  # similar format
  if (date == TRUE) {
    f_names <- gsub(x = f_names, pattern = "_?[0-9]{8}", replacement = "")
  }

  # Remove specified string if provided. Needs to be conditional, otherwise
  # `gsub()` returns an error for trying to remove NULL.
  if (!is.null(remove_string)) {
    f_names <- gsub(x = f_names, pattern = remove_string, replacement = "")
  }

  f_output <- as.list(setNames(f_files, f_names))
  return(f_output)
}
