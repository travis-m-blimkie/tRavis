#' Properly sort alphanumeric strings
#'
#' @param input_df Input data frame or tibble
#' @param sort_col Column to be used in sorting. Can be an index, or the name in
#'   quotes.
#'
#' @return Sorted data frame
#' @export
#'
#' @import stringr
#'
#' @description Function to sort a column of alphanumeric strings (e.g. c("a1",
#'   "a11", "a2")) in numeric order (e.g. c("a1", "a2", "a11")). It works with
#'   pipes, and you can provide column name or index as argument `sort_col`.
#'
#' @seealso <https://www.github.com/travis-m-blimkie/tRavis>
#'
#' @examples
#' tr_sort_alphanum(
#'   input_df = data.frame(colA = c(2, 1, 3), colB = c("m2", "m1", "m3")),
#'   sort_col = "colB"
#' )
#'
tr_sort_alphanum <- function(input_df, sort_col) {
  col_contents <- input_df[, sort_col] %>% unlist() %>% as.character()
  input_df[str_order(col_contents, numeric = TRUE), ]
}
