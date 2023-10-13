library(DESeq2)

set.seed(1)

ex_deseq_dataset <- makeExampleDESeqDataSet(n = 200, betaSD = 2)
ex_deseq_dds <- DESeq(ex_deseq_dataset)
ex_deseq_results <- results(ex_deseq_dds)

saveRDS(ex_deseq_results, "inst/extdata/ex_deseq_results.rds")
