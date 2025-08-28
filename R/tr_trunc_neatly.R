#' Cleanly trim long strings
#'
#' @param x Input string to trim to desired length, appending an ellipsis to the
#'   end, and without splitting words
#' @param l Desired length at which to trim strings (defaults to 60)
#'
#' @return Character string
#' @export
#'
#' @importFrom purrr map_chr
#'
#' @description Trims the input string to the desired length, appending an
#'   ellipsis to the end, without splitting in the middle of a word.
#'
#' @references None.
#' @seealso <https://www.github.com/travis-m-blimkie/tRavis>
#'
#' @examples
#' tr_trunc_neatly("This is a test string", l = 17)
#'
tr_trunc_neatly <- function(x, l = 60) {
  map_chr(
    x,
    ~ {
      if (is.factor(.x)) {
        warning("Input was a factor and will be coerced to character.")
        .x <- as.character(.x)
      }
      if (is.na(.x)) {
        return(NA_character_)
      } else if (nchar(.x) <= l) {
        return(.x)
      } else {
        shortened <- gsub(
          x = substr(
            x = as.character(.x),
            start = 1,
            stop = l
          ),
          pattern = " ([^ ]*)$",
          replacement = "..."
        )
        return(shortened)
      }
    }
  )
}
