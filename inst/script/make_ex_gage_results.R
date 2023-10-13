library(gage)

set.seed(1)

kegg_data <- kegg.gsets(species = "pae")[["kg.sets"]]

gene_pool <- kegg_data
names(gene_pool) <- NULL

input_genes <- data.frame(log2FoldChange = rnorm(n = 500, sd = 3))

rownames(input_genes) <- sample(
  unique(unlist(gene_pool)),
  replace = FALSE,
  size = 500
)

ex_gage_results <- gage(exprs = input_genes, gsets = kegg_data)

saveRDS(ex_gage_results, "inst/extdata/ex_gage_results.rds")
