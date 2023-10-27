test_that("DESeq2 cleaning works", {
  deseq_result <-
    readRDS(system.file("extdata", "ex_deseq_results.rds", package = "tRavis"))

  cleaned_results <- tr_clean_deseq2_result(deseq_result)

  expect_length(cleaned_results, 7)
  expect_equal(nrow(cleaned_results), 100)

  expect_setequal(
    colnames(cleaned_results),
    c("gene", "baseMean", "log2FoldChange", "lfcSE", "stat", "pvalue", "padj")
  )
})
