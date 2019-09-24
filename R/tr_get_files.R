#' tr_get_files
#'
#' @param folder Directory containing files of interest.
#' @param pattern Optional pattern to use in file searching.
#' @param date Do file names contain a date which should be removed?
#'
#' @return Named list of files to be read.
#'
#' @export
#'
#' @description Function which creates a named list of files in a specified
#'   directory. Names are trimmed versions of file names, contents of the list
#'   are the file names themselves. Can be easily piped into
#'   \code{purrr::map(~read.csv(.))} to create named list of data frames.
#'
#' @references None.
#'
#' @seealso https://www.github.com/travis-m-blimkie/tRavis
#'
tr_get_files <- function(folder, pattern = "", date = FALSE) {

  # List all files in the specifed folder, using the provided pattern, else
  # match all files in the specifed folder
  f_Files <- list.files(folder, full.names = TRUE, pattern = pattern)

  # Create names for the list based on file names. Remove file extension and
  # date if specified
  if (date == FALSE) {
    f_Names <- list.files(folder, pattern = pattern) %>%
      purrr::map(~stringr::str_remove(., pattern = "\\.(csv|tsv|txt)"))

  } else if (date == TRUE) {
    f_Names <- list.files(folder, pattern = pattern) %>%
      purrr::map(~stringr::str_remove(., pattern = "_[0-9]{8}\\.(csv|tsv|txt)"))
  }

  # Create and return output object
  f_Output <- purrr::set_names(f_Files, f_Names)
  return(as.list(f_Output))

}
