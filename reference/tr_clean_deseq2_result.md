# Tidy results from DESeq2

Helper function to filter and sort results from DESeq2, to aid in
identifying differentially expressed genes.

## Usage

``` r
tr_clean_deseq2_result(
  deseq2_result,
  p_adjusted = 0.05,
  fold_change = 1.5,
  inform = TRUE
)
```

## Arguments

- deseq2_result:

  Results object for DE genes, of class `DESeqResults`

- p_adjusted:

  Threshold for adjusted p-value. Defaults to 0.05.

- fold_change:

  Threshold for absolute fold change. Defaults to 1.5.

- inform:

  Should a message be printed with the name of the DE comparison and
  number of DE genes found? Defaults to `TRUE`.

## Value

A data frame (tibble) of filtered DE genes; see
[`?DESeq2::results`](https://rdrr.io/pkg/DESeq2/man/results.html) for
details on the output.

## References

<https://bioconductor.org/packages/DESeq2/>

## See also

<https://www.github.com/travis-m-blimkie/tRavis>

## Examples

``` r
ex_deseq_result <-
  readRDS(system.file("extdata", "ex_deseq_results.rds", package = "tRavis"))
#> Loading required namespace: DESeq2

tr_clean_deseq2_result(ex_deseq_result)
#> Found 100 DE genes for condition B vs A.
#> # A tibble: 100 × 7
#>    gene    baseMean log2FoldChange lfcSE   stat   pvalue     padj
#>    <chr>      <dbl>          <dbl> <dbl>  <dbl>    <dbl>    <dbl>
#>  1 gene95     853.            3.35 0.279  12.0  3.26e-33 6.53e-31
#>  2 gene197    591.            3.29 0.279  11.8  4.53e-32 4.53e-30
#>  3 gene180    420.            3.30 0.298  11.1  1.57e-28 1.05e-26
#>  4 gene70     235.           -2.91 0.276 -10.5  5.23e-26 2.62e-24
#>  5 gene106    886.            3.08 0.303  10.1  3.80e-24 1.52e-22
#>  6 gene187     57.3          -4.28 0.428 -10.0  1.42e-23 4.74e-22
#>  7 gene26      93.9           4.62 0.473   9.77 1.47e-22 4.20e-21
#>  8 gene68      72.7          -3.23 0.345  -9.37 7.58e-21 1.90e-19
#>  9 gene122    462.            2.63 0.307   8.58 9.79e-18 2.18e-16
#> 10 gene39     191.            2.67 0.325   8.20 2.33e-16 4.66e-15
#> # ℹ 90 more rows
```
