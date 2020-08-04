#' tr_write_linux
#'
#' @param x Object to be saved, typically a character vector.
#' @param file Name of file to save object to.
#'
#' @return No explicit return, just writes to file.
#'
#' @export
#'
#' @description Custom function to make it easy to write to files with linux
#'   line endings, to avoid issues caused by running bash script files with
#'   Windows line endings on a linux system.
#'
#' @references None.
#'
#' @seealso \url{https://www.github.com/travis-m-blimkie/tRavis}
#'
tr_write_linux <- function(x, file) {
  f_con <- file(file, "wb")
  write(x, f_con)
  close(f_con)
}
