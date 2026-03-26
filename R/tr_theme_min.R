#' Customized ggplot2 minimal theme
#'
#' @param base_size Base font size applied to all text in the plot (default 18)
#' @param base_family Base font type applies to all text in the plot
#' @param grid Character to determines how grid lines should be drawn. Options
#'   are "all", "x", "y", or "none".
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
#'   ggplot(mtcars, aes(factor(cyl), mpg)) + geom_boxplot() + tr_theme_min()
#'
tr_theme_min <- function(base_size = 16, base_family = "", grid = "all") {

  theme_1 <-
    theme_minimal(base_size = base_size, base_family = base_family) +
    theme(
      text = element_text(colour = "black"),
      axis.text = element_text(colour = "black"),
      panel.grid.minor = element_blank(),
      strip.background = element_rect(fill = NA, colour = NA),
      strip.text = element_text(
        colour = "black",
        face = "bold",
        size = base_size - 2
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

  return(theme_2)
}
