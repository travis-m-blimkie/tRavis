test_that("the theme is correct", {
  expect_no_error(
    ggplot(mtcars, aes(cyl, mpg)) + geom_point() + tr_theme(grid = "none")
  )
})
