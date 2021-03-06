#' tr_compare_lists
#'
#' @param x First vector to compare.
#' @param y Second vector to compare.
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
#' \dontrun{
#'   tr_compare_lists(
#'     x = c(1, 2, 4, 5, 6),
#'     y = c(2, 3, 6, 7)
#'   )
#' }
#'
tr_compare_lists <- function(x, y) {

  if ((is.vector(x) & is.vector(y)) == FALSE) {
    stop("Wrong input type. Please ensure both 'x' and 'y' are vectors.")
  }

  list(common   = intersect(x, y),
       unique_x = setdiff(x, y),
       unique_y = setdiff(y, x)
  )
}
