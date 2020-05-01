context("Sort alphanumeric columns")
library(tRavis)

testdf1 <- data.frame(
  colA = c("a11", "a1", "a3", "a2"),
  colB = c(4, 1, 3, 2)
)


test_that("Basic functionality", {
  expect_equal(
    tr_sort_alphanum(testdf1, "colA")$colB,
    c(1:4)
  )
})
