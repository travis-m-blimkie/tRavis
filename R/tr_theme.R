#' Customized ggplot2 theme
#'
#' @param base_size Base font size applied to all text in the plot (default 18)
#' @param base_family Base font type applies to all text in the plot
#' @param grid Character to determines how grid lines should be drawn. Options
#'   are "all", "x", "y", or "none".
#' @param ticks Logical indicating if axis ticks should be drawn. Defaults to
#'   `FALSE`.
#'
#' @return A ggplot2 theme
#' @export
#'
#' @import ggplot2
#'
#' @description Custom theme that can be applied to ggplot2 plots. Increases
#'   base font size, sets a white background, grey grid, and black border and
#'   text.
#'
#' @references None.
#' @seealso <https://www.github.com/travis-m-blimkie/tRavis>
#'
#' @examples
#' if (FALSE)
#'   ggplot(mtcars, aes(factor(cyl), mpg)) + geom_boxplot() + tr_theme()
#'
tr_theme <- function(base_size = 16, base_family = "", grid = "all", ticks = FALSE) {

  theme_1 <-
    theme_bw(base_size = base_size, base_family = base_family) +
    theme(
      text = element_text(colour = "black"),
      axis.text = element_text(colour = "black"),
      panel.grid.minor = element_blank(),
      strip.background = element_rect(fill = NA, colour = NA),
      strip.text = element_text(
        colour = "black",
        face = "bold",
        size = base_size - 4
      )
    )

  theme_2 <- if (grid == "all") {
    theme_1
  } else if (grid == "none") {
    theme_1 + theme(panel.grid.major = element_blank())
  } else if (grid == "x") {
    theme_1 + theme(panel.grid.major.y = element_blank())
  } else if (grid == "y") {
    theme_1 + theme(panel.grid.major.x = element_blank())
  }

  theme_3 <- if (ticks) {
    theme_2 + theme(axis.ticks = element_line(colour = "black", linewidth = 0.25))
  } else {
    theme_2 + theme(axis.ticks = element_blank())
  }

  return(theme_3)
}
