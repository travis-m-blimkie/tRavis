#' Cleanly trim truncate long strings
#'
#' @param x Input string to trim to desired length, appending an ellipsis to the
#'   end, and without splitting words
#' @param l Desired length at which to trim strings
#'
#' @return Character
#'
#' @export
#'
#' @import stringr
#' @importFrom purrr map_chr
#'
#' @description Trims the input string to the desired length, appending an
#'   ellipsis to the end, without splitting in the middle of a word.
#'
#' @references None.
#'
#' @seealso <https://www.github.com/travis-m-blimkie/tRavis>
#'
tr_trunc_neatly <- function(x, l = 60) {
  map_chr(
    x,
    ~if (is.na(.x)) {
      return(NA_character_)
    } else if (str_length(.x) <= l) {
      return(.x)
    } else {
      shortened <- .x %>%
        as.character() %>%
        str_sub(., start = 1, end = l) %>%
        str_replace(., pattern = "\\s([^\\s]*)$", replacement = "...")
      return(shortened)
    }
  )
}

