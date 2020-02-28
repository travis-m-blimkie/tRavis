context("Test enrichment function")
library(tRavis)

set.seed(123)
all_genes <- paste0("PA_", sample(1:10000, 5000))
de_genes <- sample(all_genes, 1500)
test_set <- sample(all_genes, 100)

test_that("Basic functionality", {
  expect_equal(
    0.16,
    signif(tr_test_enrichment(de_genes, test_set, total_genes = 5000), digits = 3)
  )
})
