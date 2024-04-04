test_that("we get the right p value", {
  set.seed(123)
  all_genes <- paste0("PA_", sample(1:10000, 5000))

  p_value <- tr_test_enrichment(
    query_set = sample(all_genes, 1500),
    enrichment_set = sample(all_genes, 100),
    total_genes = 5000
  )

  expect_equal(
    signif(p_value, digits = 3),
    0.16
  )
})
