test_that("enrichment with ReactomePA works", {
  test_de_genes <- readRDS(test_path("fixtures", "test_de_genes.rds"))

  rpa_result <- tr_enrichment_wrapper(
    input_genes = as.character(test_de_genes$entrez_gene_id),
    tool = "ReactomePA",
    species = "human",
    gene_ratio = TRUE
  )

  expect_equal(dim(rpa_result), c(357, 10))

  expect_setequal(
    colnames(rpa_result),
    c(
      "pathway_id",
      "description",
      "pvalue",
      "p_adjust",
      "n_cd_genes",
      "n_bg_genes",
      "gene_ratio",
      "level_1",
      "level_2",
      "genes"
    )
  )
})

test_that("directional enrichment with Sigora works", {
  test_de_genes <- readRDS(test_path("fixtures", "test_de_genes.rds"))
  data("reaH", package = "sigora")

  sigora_result <- tr_enrichment_wrapper(
    input_genes = test_de_genes,
    directional = c("gene", "log2FoldChange"),
    tool = "Sigora",
    gps_repo = reaH,
    lvl = 4
  )

  expect_equal(dim(sigora_result), c(55, 7))

  expect_setequal(
    colnames(sigora_result),
    c(
      "pathway_id",
      "description",
      "pvalue",
      "bonferroni",
      "direction",
      "level_1",
      "level_2"
    )
  )
})
