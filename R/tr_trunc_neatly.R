#' tr_trunc_neatly
#'
#' @param x Input string to trim to desired length, appending an ellipsis to the
#'   end, and without splitting words
#' @param l Desired length at which to trim strings
#'
#' @return A character string, trimmed to the desired length and with an
#'   ellipsis at the end
#'
#' @export
#'
#' @import stringr
#'
#' @description Trims the input string to the desired length, appending an
#'   ellipsis to the end, without splitting in the middle of a word
#'
#' @references None.
#'
#' @seealso <https://www.github.com/travis-m-blimkie/tRavis>
#'
tr_trunc_neatly <- function(x, l = 60) {

  if (str_length(x) <= l) {
    return(x)
  } else {
    shortened <- x %>%
      as.character() %>%
      str_sub(., start = 1, end = l) %>%
      str_replace(., pattern = "\\s([^\\s]*)$", replacement = "...")
    return(shortened)
  }
}
