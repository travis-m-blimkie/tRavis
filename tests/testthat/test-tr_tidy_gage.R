test_that("gage tidying works", {
  gage_untidy <-
    readRDS(system.file("extdata", "ex_gage_results.rds", package = "tRavis"))

  gage_tidy <- tr_tidy_gage(gage_untidy, qval = 1)

  expect_length(gage_tidy, 7)

  expect_setequal(
    colnames(gage_tidy),
    c("pathway", "p_geomean", "stat_mean", "p_val", "q_val", "set_size", "exp1")
  )
})
