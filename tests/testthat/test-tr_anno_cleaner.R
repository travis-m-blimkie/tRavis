test_that("basic annotation cleaning works", {
  cleaned_basic <- tr_anno_cleaner(
    input_file = paste0(
      "https://pseudomonas.com/downloads/pseudomonas/pgd_r_22_1/",
      "Pseudomonas_aeruginosa_PAO1_107/Pseudomonas_aeruginosa_PAO1_107.csv.gz"
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
    input_file = paste0(
      "https://pseudomonas.com/downloads/pseudomonas/pgd_r_22_1/",
      "Pseudomonas_aeruginosa_PAO1_107/Pseudomonas_aeruginosa_PAO1_107.csv.gz"
    ),
    extra_cols = TRUE
  )

  expect_length(cleaned_extra, 6)

  expect_setequal(
    colnames(cleaned_extra),
    c("locus_tag", "gene_name", "product_name", "start", "end", "strand")
  )
})
