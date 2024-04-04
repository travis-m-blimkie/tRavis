test_that("the function is working properly", {

  tr_qc_plots_output <- tr_qc_plots(
    directory = system.file("extdata/tr_qc_plots_data", package = "tRavis")
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

test_that("fastqc phred plot is correct", {
  tr_qc_plots_output <- tr_qc_plots(
    directory = system.file("extdata/tr_qc_plots_data", package = "tRavis")
  )

  vdiffr::expect_doppelganger(
    "fastqc_phred_example",
    tr_qc_plots_output$plots$phred_scores
  )
})

test_that("fastqc read plot is correct, and 'font_size' is working", {
  tr_qc_plots_output <- tr_qc_plots(
    directory = system.file("extdata/tr_qc_plots_data", package = "tRavis"),
    font_size = 8
  )

  vdiffr::expect_doppelganger(
    "fastqc_reads_example",
    tr_qc_plots_output$plots$fastqc_reads
  )
})

test_that("star plot is correct, and 'threshold_line' is working", {
  tr_qc_plots_output <- tr_qc_plots(
    directory = system.file("extdata/tr_qc_plots_data", package = "tRavis"),
    threshold_line = 2e6
  )

  vdiffr::expect_doppelganger(
    "star_example",
    tr_qc_plots_output$plots$star
  )
})

test_that("htseq phred plot is correct, and 'limits' is working", {
  tr_qc_plots_output <- tr_qc_plots(
    directory = system.file("extdata/tr_qc_plots_data", package = "tRavis"),
    limits = 50e6
  )

  vdiffr::expect_doppelganger(
    "htseq_example",
    tr_qc_plots_output$plots$htseq
  )
})
