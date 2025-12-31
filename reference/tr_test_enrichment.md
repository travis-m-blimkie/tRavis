# Perform a basic enrichment test

Performs Fisher's Exact test to determine enrichment of a set of genes
of interest compared to some list of experimentally derived genes. Uses
`alternative = "greater"` in the call to
[`fisher.test()`](https://rdrr.io/r/stats/fisher.test.html).

## Usage

``` r
tr_test_enrichment(query_set, enrichment_set, total_genes)
```

## Arguments

- query_set:

  List of experimentally or otherwise derived genes, in which one wishes
  to test for enrichment

- enrichment_set:

  Set of genes of interest, such as virulence genes

- total_genes:

  Total number of genes for the organism/species

## Value

Numeric: the raw p-value from
[`fisher.test()`](https://rdrr.io/r/stats/fisher.test.html)

## References

?stats::fisher.test

## See also

<https://www.github.com/travis-m-blimkie/tRavis>

## Examples

``` r
all_genes <- paste0("gene", sample(1:10000, 5000))
de_genes <- sample(all_genes, 1500)
ex_set <- sample(all_genes, 100)

tr_test_enrichment(
  query_set = de_genes,
  enrichment_set = ex_set,
  total_genes = 5000
)
#> [1] 0.05127792
```
