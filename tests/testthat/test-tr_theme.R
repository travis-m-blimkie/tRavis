test_that("the theme is correct", {
  set.seed(1)
  vdiffr::expect_doppelganger(
    "tr_theme_example",
    ggplot(mtcars, aes(cyl, mpg)) + geom_point() + tr_theme(grid = FALSE)
  )
})
