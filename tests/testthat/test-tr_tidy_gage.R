test_that("gage tidying works", {
  gage_untidy <- readRDS(test_path("fixtures", "ex_gage_results.rds"))

  gage_tidy <- tr_tidy_gage(gage_untidy, qval = 1)

  expect_length(gage_tidy, 7)

  expect_setequal(
    colnames(gage_tidy),
    c("pathway", "p_geomean", "stat_mean", "p_val", "q_val", "set_size", "exp1")
  )
})
