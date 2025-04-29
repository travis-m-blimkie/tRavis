test_that("basic annotation cleaning works", {
  cleaned_basic <- tr_anno_cleaner(
    input_file = system.file(
      "extdata",
      "Pseudomonas_aeruginosa_PAO1_107.csv.gz",
      package = "tRavis"
    )
  )

  expect_length(cleaned_basic, 3)

  expect_setequal(
    colnames(cleaned_basic),
    c("locus_tag", "gene_name", "product_name")
  )
})

test_that("'extra_cols' functions properly", {
  cleaned_extra <- tr_anno_cleaner(
    input_file = system.file(
      "extdata",
      "Pseudomonas_aeruginosa_PAO1_107.csv.gz",
      package = "tRavis"
    ),
    extra_cols = TRUE
  )

  expect_length(cleaned_extra, 6)

  expect_setequal(
    colnames(cleaned_extra),
    c("locus_tag", "gene_name", "product_name", "start", "end", "strand")
  )
})
