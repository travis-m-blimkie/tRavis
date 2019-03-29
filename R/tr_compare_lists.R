
# tr_compare_lists --------------------------------------------------------

#' Function to obtain common and unique elements of two lists.
#' The same as running intersect(x, y), setdiff(x, y), setdiff(y, x), but all in
#' a single command.
#' Returns a named list of the common and unique elements of x and y.


tr_compare_lists <- function(x, y) {


  # Required libraries --------------------------------------------------

  require(dplyr)


  # List of intersect, unique x, unique y -------------------------------

  list(common = intersect(x, y),
       unique_x = setdiff(x, y),
       unique_y = setdiff(y, x)
       )

}
