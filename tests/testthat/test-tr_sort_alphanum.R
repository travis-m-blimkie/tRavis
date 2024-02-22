test_that("column sorting works as expected", {
  test_df <- data.frame(
    colA = c("a11", "a1", "b1", "a2"),
    colB = c(3, 1, 4, 2)
  )

  expect_equal(
    tr_sort_alphanum(test_df, "colA")$colB,
    seq(1, 4)
  )
})
