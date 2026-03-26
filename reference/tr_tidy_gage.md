# Coerce Gage output to a tidy data frame

This function will simply convert the output from Gage enrichment into
an easier-to-use tibble format. At the same time it can also filter the
result based on q value, with a default of `0.1`.

## Usage

``` r
tr_tidy_gage(gage_result, qval = 0.1)
```

## Arguments

- gage_result:

  A list output from a call to `gage::gage`

- qval:

  Cutoff for q value, defaults to 0.1

## Value

A data frame (tibble)

## References

None.

## See also

<https://www.github.com/travis-m-blimkie/tRavis>

## Examples

``` r
ex_gage_results <-
  readRDS(system.file("extdata", "ex_gage_results.rds", package = "tRavis"))

tr_tidy_gage(ex_gage_results, qval = 1)
#> # A tibble: 70 × 7
#>    pathway                      p_geomean stat_mean  p_val q_val set_size   exp1
#>    <chr>                            <dbl>     <dbl>  <dbl> <dbl>    <dbl>  <dbl>
#>  1 pae00650 Butanoate metaboli…    0.0499     1.72  0.0499 0.678       12 0.0499
#>  2 pae00280 Valine, leucine an…    0.0533     1.67  0.0533 0.678       14 0.0533
#>  3 pae01212 Fatty acid metabol…    0.0858     1.40  0.0858 0.678       15 0.0858
#>  4 pae02025 Biofilm formation …    0.140      1.09  0.140  0.678       35 0.140 
#>  5 pae00620 Pyruvate metabolism    0.171      0.963 0.171  0.678       18 0.171 
#>  6 pae00061 Fatty acid biosynt…    0.233      0.746 0.233  0.678       11 0.233 
#>  7 pae00640 Propanoate metabol…    0.252      0.679 0.252  0.678       14 0.252 
#>  8 pae01232 Nucleotide metabol…    0.272      0.614 0.272  0.678       14 0.272 
#>  9 pae00970 Aminoacyl-tRNA bio…    0.298      0.535 0.298  0.678       23 0.298 
#> 10 pae01503 Cationic antimicro…    0.346      0.403 0.346  0.678       10 0.346 
#> # ℹ 60 more rows
```
