#' Customized ggplot2 theme
#'
#' @param base_size Base font size applied to all text in the plot (default 18)
#' @param base_family Base font type applies to all text in the plot
#' @param grid Determines if grid lines should be drawn. Defaults to
#'  `TRUE`for which only "major" grid lines are drawn.
#'
#' @return A ggplot2 theme
#' @export
#'
#' @import ggplot2
#'
#' @description Custom theme that can be applied to ggplot2 plots. Increases
#'   base font size, sets a white background, grey grid, and black border.
#'
#' @references None.
#' @seealso <https://www.github.com/travis-m-blimkie/tRavis>
#'
#' @examples
#' if (FALSE)
#'   ggplot(mtcars, aes(cyl, mpg)) + geom_point() + tr_theme()
#'
tr_theme <- function(base_size = 18, base_family = "", grid = TRUE) {

  theme_basic <-
    theme_light(base_size = base_size, base_family = base_family) +
    theme(
      text = element_text(colour = "black"),
      axis.text = element_text(colour = "black"),
      axis.ticks = element_line(colour = "black", linewidth = 0.5),
      panel.border = element_rect(colour = "black", linewidth = 1),
      strip.background = element_rect(fill = NA),
      strip.text = element_text(
        colour = "black",
        face = "bold",
        size = base_size - 4
      )
    )

  if (grid) {
    theme_basic + theme(
      panel.grid.major = element_line(colour = "grey", linewidth = 0.5),
      panel.grid.minor = element_blank()
    )
  } else {
    theme_basic + theme(panel.grid = element_blank())
  }
}
