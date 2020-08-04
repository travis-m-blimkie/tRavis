#' tr_sort_alphanum
#'
#' @param input_df Input data frame or tibble.
#' @param sort_col Column to be used in sorting. Can be an index or the name
#'   (quoted).
#'
#' @return Column-sorted data frame
#'
#' @export
#'
#' @import stringr
#'
#' @description Function to sort a column of alphanumeric strings (e.g. c("a1",
#'   "a11", "a2")) in numeric order (e.g. c("a1", "a2", "a11")). It works with
#'   pipes, and you can provide column name or index as argument \code{sort_col}.
#'
#' @references None.
#'
#' @seealso \url{https://www.github.com/travis-m-blimkie/tRavis}
#'
#' @examples
#' \dontrun{
#'
#'   # Using the column name
#'   tr_sort_alphanum(input_df = table1, sort_col = "category")
#'
#'   # Using pipes and column index
#'   table1 %>% tr_sort_alphanum(2)
#' }
#'
tr_sort_alphanum <- function(input_df, sort_col) {
  col_contents <- input_df[, sort_col] %>% unlist() %>% as.character()
  input_df[str_order(col_contents, numeric = TRUE), ]
}
