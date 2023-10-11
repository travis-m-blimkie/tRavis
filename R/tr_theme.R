#' Customized ggplot2 theme
#'
#' @param baseSize Base font size applied to all text in the plot
#' @param baseFamily Base font type applies to all text in the plot
#' @param grid Determines if grid lines should be drawn. Defaults to TRUE. When
#'   TRUE, only "major" grid lines are included.
#'
#' @return Theme object
#' @export
#'
#' @import ggplot2
#'
#' @description Custom theme that can be applied to ggplot2 plots. Increases
#'   base font size, sets a white background, grey grid, and black border.
#'
#' @references None.
#'
#' @seealso <https://www.github.com/travis-m-blimkie/tRavis>
#'
#' @examples
#' \dontrun{
#'   ggplot(mtcars, aes(cyl, mpg)) + geom_point() + tr_theme(grid = TRUE)
#' }
#'
tr_theme <- function(baseSize = 18, baseFamily = "", grid = TRUE) {
  if (grid) {
    theme_light(base_size = baseSize, base_family = baseFamily) +
      theme(
        text             = element_text(colour = "black"),
        axis.text        = element_text(colour = "black"),
        axis.ticks       = element_line(colour = "black", linewidth = 0.5),
        panel.grid.major = element_line(colour = "grey", linewidth = 0.5),
        panel.grid.minor = element_blank(),
        panel.border     = element_rect(colour = "black", linewidth = 1),
        strip.background = element_rect(fill = NA),
        strip.text       = element_text(colour = "black", face = "bold", size = 14)
      )
  } else {
    theme_light(base_size = baseSize, base_family = baseFamily) +
      theme(
        text             = element_text(colour = "black"),
        axis.text        = element_text(colour = "black"),
        axis.ticks       = element_line(colour = "black", linewidth = 0.5),
        panel.grid       = element_blank(),
        panel.border     = element_rect(colour = "black", linewidth = 1),
        strip.background = element_rect(fill = NA),
        strip.text       = element_text(colour = "black", face = "bold", size = 14)
      )
  }
}

