test_that("we have basic functionality", {

  vec1 <- c("a", "b", "c")
  vec2 <- c("b", "c", "d")
  vec3 <- c("a", NA)

  expect_length(tr_compare_lists(x = vec1, y = vec2), 3)

  expected_normal <- list(
    unique_x = "a",
    common = c("b", "c"),
    unique_y = "d"
  )

  expect_equal(
    tr_compare_lists(x = vec1, y = vec2),
    expected_normal
  )
})
