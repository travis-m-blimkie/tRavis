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
    c(20, 2)
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
  expect_no_error(
    tr_qc_plots(
      directory = system.file("extdata/tr_qc_plots_data", package = "tRavis")
    )
  )
})

test_that("fastqc read plot is correct, and 'font_size' is working", {
  expect_no_error(
    tr_qc_plots(
      directory = system.file("extdata/tr_qc_plots_data", package = "tRavis"),
      font_size = 8
    )
  )
})

test_that("star plot is correct, and 'threshold_line' is working", {
  expect_no_error(
    tr_qc_plots(
      directory = system.file("extdata/tr_qc_plots_data", package = "tRavis"),
      threshold_line = 2e6
    )
  )
})

test_that("htseq plot is correct, and 'limits' is working", {
  expect_no_error(
    tr_qc_plots(
      directory = system.file("extdata/tr_qc_plots_data", package = "tRavis"),
      limits = 50e6
    )
  )
})

test_that("fastqc box plots are correct", {
  expect_no_error(
    tr_qc_plots(
      directory = system.file("extdata/tr_qc_plots_data", package = "tRavis"),
      type = "box",
      add_points = FALSE
    )
  )
})

test_that("star box plots are correct", {
  expect_no_error(
    tr_qc_plots(
      directory = system.file("extdata/tr_qc_plots_data", package = "tRavis"),
      type = "box",
      add_points = FALSE
    )
  )
})

test_that("htseq box plots are correct", {
  expect_no_error(
    tr_qc_plots(
      directory = system.file("extdata/tr_qc_plots_data", package = "tRavis"),
      type = "box",
      add_points = FALSE
    )
  )
})

test_that("samples with 'R1' are handled properly", {
  expect_no_error(
    tr_qc_plots(
      directory = system.file("extdata/tr_qc_plots_data_R1", package = "tRavis")
    )
  )
})

test_that("samples with 'R1' and 'R2' are handled properly", {
  tr_qc_plots_output <- tr_qc_plots(
    directory = system.file(
      "extdata/tr_qc_plots_data_R1_R2",
      package = "tRavis"
    )
  )

  expect_true(
    any(grepl(
      x = tr_qc_plots_output$data$fastqc_reads$Samples,
      pattern = "R1"
    )) &
      any(grepl(
        x = tr_qc_plots_output$data$fastqc_reads$Samples,
        pattern = "R2"
      ))
  )
})
