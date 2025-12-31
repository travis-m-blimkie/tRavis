# Customized ggplot2 theme

Custom theme that can be applied to ggplot2 plots. Increases base font
size, sets a white background, grey grid, and black border and text.

## Usage

``` r
tr_theme(base_size = 16, base_family = "", grid = "all", ticks = FALSE)
```

## Arguments

- base_size:

  Base font size applied to all text in the plot (default 18)

- base_family:

  Base font type applies to all text in the plot

- grid:

  Character to determines how grid lines should be drawn. Options are
  "all", "x", "y", or "none".

- ticks:

  Logical indicating if axis ticks should be drawn. Defaults to `FALSE`.

## Value

A ggplot2 theme

## References

None.

## See also

<https://www.github.com/travis-m-blimkie/tRavis>

## Examples

``` r
if (FALSE)
  ggplot(mtcars, aes(factor(cyl), mpg)) + geom_boxplot() + tr_theme()
```
