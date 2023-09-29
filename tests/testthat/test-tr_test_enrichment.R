test_that("we get the right p value", {
  set.seed(123)
  all_genes <- paste0("PA_", sample(1:10000, 5000))

  expect_equal(
    signif(
      tr_test_enrichment(
        sample(all_genes, 1500),
        sample(all_genes, 100),
        total_genes = 5000
      ),
      digits = 3
    ),
    0.16
  )
})
