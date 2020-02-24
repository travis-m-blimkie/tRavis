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
#' @description Performs \code{intersect(x, y)}, \code{setdiff(x, y)}, and
#' \code{setdiff(y, x)}. Returns these elements in a named list, with names
#' "common", "unique_x", and "unique_y".
#'
#' @references None.
#'
#' @seealso \url{https://www.github.com/travis-m-blimkie/tRavis}
#'
tr_compare_lists <- function(x, y) {

  if ( (is.vector(x) & is.vector(y)) == FALSE ) {
    stop("Wrong input type. Please ensure both 'x' and 'y' are vectors.")
  }

  list(common   = intersect(x, y),
       unique_x = setdiff(x, y),
       unique_y = setdiff(y, x)
  )
}
