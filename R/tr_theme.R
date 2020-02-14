#' tr_theme
#'
#' @param baseSize Base font size applied to all text in the plot
#' @param baseFamily Base font type applies to all text in the plot
#' @param grid Determines if grid lines should be drawn. Defaults to FALSE. When
#'   TRUE, only "major" grid lines are included.
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
#'   ggplot(mtcars, aes(cyl, mpg)) + geom_point() + tr_theme(grid = TRUE)
#' }
#'
tr_theme <- function(baseSize = 16, baseFamily = "", grid = FALSE) {
  if (grid) {
    theme_light(base_size = baseSize, base_family = baseFamily) +
      theme(
        text = element_text(colour = "black"),
        axis.text = element_text(colour = "black"),
        axis.ticks = element_line(colour = "black"),
        panel.grid.major = element_line(colour = "grey"),
        panel.grid.minor = element_blank(),
        panel.border = element_rect(colour = "black", size = 1)
      )
  } else {
    theme_light(base_size = baseSize, base_family = baseFamily) +
      theme(
        text = element_text(colour = "black"),
        axis.text = element_text(colour = "black"),
        axis.ticks = element_line(colour = "black"),
        panel.grid = element_blank(),
        panel.border = element_rect(colour = "black", size = 1)
      )
  }
}

