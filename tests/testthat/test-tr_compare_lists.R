context("Compare lists")
library(tRavis)

vec1 <- c("a", "b", "c")
vec2 <- c("b", "c", "d")
vec3 <- c("a", NA)

expected_normal <- list(
  common = c("b", "c"),
  unique_x = "a",
  unique_y = "d"
)


test_that("Basic functionality", {
  expect_length(tr_compare_lists(x = vec1, y = vec2), 3)
})

test_that("Returns correct values", {
  expect_equal(tr_compare_lists(x = vec1, y = vec2), expected_normal)
})
