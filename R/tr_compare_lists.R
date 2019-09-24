#' tr_compare_lists
#'
#' @param x First vector to compare.
#' @param y Second vector to compare.
#'
#' @return A named list of the common and unique elements of x and y.
#'
#' @export
#'
#' @description Performs \code{intersect(x, y)}, \code{setdiff(x, y)}, and
#' \code{setdiff(y, x)}. Returns these elements in a named list, with names
#' "common", "unique_x", and "unique_y".
#'
#' @references None.
#'
#' @seealso https://www.github.com/travis-m-blimkie/tRavis
#'
tr_compare_lists <- function(x, y) {

  list(common   = dplyr::intersect(x, y),
       unique_x = dplyr::setdiff(x, y),
       unique_y = dplyr::setdiff(y, x)
  )

}
