#' Easily compare two lists
#'
#' @param x First vector to compare.
#' @param y Second vector to compare.
#' @param names Optional character vector, containing names of `x` and `y` to
#'   apply to the output.
#'
#' @return A named list of the common and unique elements of x and y.
#'
#' @export
#'
#' @import dplyr
#'
#' @description Performs `intersect(x, y)`, `setdiff(x, y)`, and
#'   `setdiff(y, x)`. Returns these elements in a list with names "common",
#'   "unique_x", and "unique_y".
#'
#' @references None.
#'
#' @seealso <https://www.github.com/travis-m-blimkie/tRavis>
#'
#' @examples
#' tr_compare_lists(
#'   x = c(1, 2, 4, 5, 6),
#'   y = c(2, 3, 6, 7),
#'   names = c("A", "B")
#' )
#'
tr_compare_lists <- function(x, y, names = NULL) {

  if ((is.vector(x) & is.vector(y)) == FALSE) {
    stop("Wrong input type. Please ensure both 'x' and 'y' are vectors.")
  }

  output_list <- list(
    unique_x = setdiff(x, y),
    common   = intersect(x, y),
    unique_y = setdiff(y, x)
  )

  if (!is.null(names)) {
    names(output_list)[1] <- paste0("unique_", names[1])
    names(output_list)[3] <- paste0("unique_", names[2])
  }

  return(output_list)
}
