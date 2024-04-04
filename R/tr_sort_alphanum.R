#' Properly sort alphanumeric strings
#'
#' @param input_df Input data frame or tibble to be sorted
#' @param sort_col Column to be used in sorting as an index or quoted name
#'
#' @return Sorted data frame
#' @export
#'
#' @importFrom stringr str_order
#'
#' @description Function to sort a column of alphanumeric strings (e.g. c("a1",
#'   "a11", "a2")) in numeric order (e.g. c("a1", "a2", "a11")). It works with
#'   pipes, and you can provide column name or index as argument `sort_col`.
#'
#' @references None.
#' @seealso <https://www.github.com/travis-m-blimkie/tRavis>
#'
#' @examples
#' tr_sort_alphanum(
#'   input_df = data.frame(
#'     colA = c("a11", "a1", "b1", "a2"),
#'     colB = c(3, 1, 4, 2)
#'   ),
#'   sort_col = "colA"
#' )
#'
tr_sort_alphanum <- function(input_df, sort_col) {
  stopifnot(is(input_df, "data.frame"))

  col_contents <- input_df[, sort_col] %>% unlist() %>% as.character()
  input_df[str_order(col_contents, numeric = TRUE), ]
}
