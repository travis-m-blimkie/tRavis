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
#>  1 pae00470 D-Amino acid metab…    0.0630     1.61  0.0630 0.924       10 0.0630
#>  2 pae01232 Nucleotide metabol…    0.111      1.24  0.111  0.924       16 0.111 
#>  3 pae00640 Propanoate metabol…    0.167      0.994 0.167  0.924       11 0.167 
#>  4 pae00330 Arginine and proli…    0.179      0.937 0.179  0.924       14 0.179 
#>  5 pae03010 Ribosome               0.197      0.862 0.197  0.924       19 0.197 
#>  6 pae01210 2-Oxocarboxylic ac…    0.250      0.684 0.250  0.924       12 0.250 
#>  7 pae02040 Flagellar assembly     0.267      0.635 0.267  0.924       11 0.267 
#>  8 pae00620 Pyruvate metabolism    0.302      0.526 0.302  0.924       13 0.302 
#>  9 pae02024 Quorum sensing         0.327      0.452 0.327  0.924       29 0.327 
#> 10 pae00405 Phenazine biosynth…    0.367      0.345 0.367  0.924       10 0.367 
#> # ℹ 60 more rows
```
