#' tr_compare_lists
#'
#' @param x First vector to compare
#' @param y Second vector to compare
#'
#' @return A named list of the common and unique elements of x and y.
#'
#' @export
#'
#' @description
#' Performs \code{intersect(x, y)}, \code{setdiff(x, y)}, and setdiff(y, x).
#' Returns these elements in a named list, with names "common", "unique_x", and
#' "unique_y".
#'
#' @references None.
#'
#' @seealso https://www.github.com/travis-m-blimkie/tRavis
#'
#' @examples
#' comparison <- tr_compare_lists(x = c(1, 2, 3, 4, 5), y = c(4, 5, 6, 7, 8))
#'
tr_compare_lists <- function(x, y) {

  requireNamespace(tidyverse)

  list(common = intersect(x, y),
       unique_x = setdiff(x, y),
       unique_y = setdiff(y, x)
  )

}
