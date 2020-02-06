#' tr_theme
#'
#' @param baseSize Base font size applied to all text in the plot
#' @param baseFamily Base font type applies to all text in the plot
#'
#' @return Theme object
#'
#' @export
#'
#' @import ggplot2
#'
#' @description Custom theme that can be applied to ggplot2 plots. Increases
#'   base font size, sets a white background, grey grid, and black border.
#'
#' @references None.
#'
#' @seealso \url{https://www.github.com/travis-m-blimkie/tRavis}
#'
#' @examples
#' \dontrun{
#'   ggplot(mtcars, aes(cyl, mpg)) + geom_point() + tr_theme()
#' }
#'
tr_theme <- function(baseSize = 16, baseFamily = "") {
  theme_light(base_size = baseSize, base_family = baseFamily) +
    theme(
      text = element_text(colour = "black"),
      panel.grid.major = element_line("grey"),
      panel.border = element_rect(colour = "black", size = 1)
    )
}

