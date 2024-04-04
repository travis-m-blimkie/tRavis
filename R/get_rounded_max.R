#' Find highest number of reads in a long table
#'
#' @param x Data frame of read information
#' @param buffer Multiply the largest value by this factor before rounding.
#'   Defaults to `1.1`, i.e. adds a 10% buffer to the maximum value.
#' @param nearest Nearest number to round up to. Defaults to `10e6`.
#'
#' @return Numeric; maximum number of total reads or counts
#'
#' @import dplyr
#' @importFrom plyr round_any
#'
#' @description Internal helper which takes a long and tidy data frame
#'   containing read or count numbers derived from MultiQC, and finds the
#'   largest read or count value, then round it up to the nearest ten million.
#'
#' @details Input data frame must contain the columns "sample" and "n_reads".
#'
#' @references None.
#' @seealso <https://www.github.com/travis-m-blimkie/tRavis>
#'
get_rounded_max <- function(x, buffer = 1.1, nearest = 10e6) {
  stopifnot(is.data.frame(x))
  stopifnot(c("sample", "n_reads") %in% colnames(x))

  max_value <- x %>%
    group_by(sample) %>%
    summarise(sum_n_reads = sum(n_reads)) %>%
    pull(sum_n_reads) %>%
    max()

  round_any(
    x = max_value * buffer,
    f = ceiling,
    accuracy = nearest
  )
}
