test_that("the function is working", {
  set.seed(1)

  count_table <- tibble(
    sample = rep(paste0("s", seq(1, 5)), each = 2),
    read_type = rep(c("unique", "duplicate"), 5),
    n_reads = rnorm(n = 10, mean = 20e6, sd = 5e6)
  )

  expect_equal(get_rounded_max(count_table), 6e7)
})
