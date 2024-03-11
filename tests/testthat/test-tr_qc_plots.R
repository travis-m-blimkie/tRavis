test_that("the function is working properly", {

  suppressMessages(
    tr_qc_plots_output <- tr_qc_plots(
      directory = system.file("extdata/tr_qc_plots_data", package = "tRavis")
    )
  )

  expect_type(tr_qc_plots_output, "list")
  expect_length(tr_qc_plots_output, 2)

  expect_equal(
    dim(tr_qc_plots_output$data$phred_scores),
    c(760, 4)
  )

  expect_equal(
    dim(tr_qc_plots_output$data$fastqc_reads),
    c(40, 3)
  )

  expect_equal(
    dim(tr_qc_plots_output$data$star),
    c(100, 3)
  )

  expect_equal(
    dim(tr_qc_plots_output$data$htseq),
    c(100, 3)
  )
})
