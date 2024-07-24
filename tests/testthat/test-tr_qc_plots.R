test_that("the function is working properly", {

  tr_qc_plots_output <- tr_qc_plots(
    directory = system.file("extdata/tr_qc_plots_data", package = "tRavis")
  )

  expect_type(tr_qc_plots_output, "list")
  expect_length(tr_qc_plots_output, 2)

  expect_equal(
    dim(tr_qc_plots_output$data$phred_scores),
    c(760, 3)
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

test_that("htseq plot is correct, and 'limits' is working", {
  tr_qc_plots_output <- tr_qc_plots(
    directory = system.file("extdata/tr_qc_plots_data", package = "tRavis"),
    limits = 50e6
  )

  vdiffr::expect_doppelganger(
    "htseq_example",
    tr_qc_plots_output$plots$htseq
  )
})

test_that("fastqc box plots are correct", {
  tr_qc_plots_output <- tr_qc_plots(
    directory = system.file("extdata/tr_qc_plots_data", package = "tRavis"),
    type = "box",
    add_points = FALSE
  )

  vdiffr::expect_doppelganger(
    "fastqc_reads_box_example",
    tr_qc_plots_output$plots$fastqc
  )
})

test_that("star box plots are correct", {
  tr_qc_plots_output <- tr_qc_plots(
    directory = system.file("extdata/tr_qc_plots_data", package = "tRavis"),
    type = "box",
    add_points = FALSE
  )

  vdiffr::expect_doppelganger(
    "star_reads_box_example",
    tr_qc_plots_output$plots$star
  )
})

test_that("htseq box plots are correct", {
  tr_qc_plots_output <- tr_qc_plots(
    directory = system.file("extdata/tr_qc_plots_data", package = "tRavis"),
    type = "box",
    add_points = FALSE
  )

  vdiffr::expect_doppelganger(
    "htseq_reads_box_example",
    tr_qc_plots_output$plots$htseq
  )
})

test_that("samples with 'R1' are handled properly", {
  tr_qc_plots_output <- tr_qc_plots(
    directory = system.file("extdata/tr_qc_plots_data_R1", package = "tRavis")
  )

  testthat::expect_false(
    any(grepl(x = tr_qc_plots_output$data$fastqc_reads, pattern = "R1"))
  )
})

test_that("samples with 'R1' and 'R2' are handled properly", {
  tr_qc_plots_output <- tr_qc_plots(
    directory = system.file("extdata/tr_qc_plots_data_R1_R2", package = "tRavis")
  )

  testthat::expect_true(
    any(grepl(x = tr_qc_plots_output$data$fastqc_reads$Samples, pattern = "R1")) &
      any(grepl(x = tr_qc_plots_output$data$fastqc_reads$Samples, pattern = "R2"))
  )
})
