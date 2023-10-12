test_that("DESeq2 cleaning works", {
  deseq_result <- readRDS(test_path("fixtures", "ex_deseq_results.rds"))

  cleaned_results <- tr_clean_deseq2_result(deseq_result)

  expect_length(cleaned_results, 7)
  expect_equal(nrow(cleaned_results), 90)

  expect_setequal(
    colnames(cleaned_results),
    c("gene", "baseMean", "log2FoldChange", "lfcSE", "stat", "pvalue", "padj")
  )
})
