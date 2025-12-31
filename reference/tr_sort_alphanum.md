# Properly sort alphanumeric strings

Function to sort a column of alphanumeric strings (e.g. c("a1", "a11",
"a2")) in numeric order (e.g. c("a1", "a2", "a11")). It works with
pipes, and you can provide column name or index as argument `sort_col`.

## Usage

``` r
tr_sort_alphanum(input_df, sort_col)
```

## Arguments

- input_df:

  Input data frame or tibble to be sorted

- sort_col:

  Column to be used in sorting as an index or quoted name

## Value

Sorted data frame

## References

None.

## See also

<https://www.github.com/travis-m-blimkie/tRavis>

## Examples

``` r
tr_sort_alphanum(
  input_df = data.frame(
    colA = c("a11", "a1", "b1", "a2"),
    colB = c(3, 1, 4, 2)
  ),
  sort_col = "colA"
)
#>   colA colB
#> 2   a1    1
#> 4   a2    2
#> 1  a11    3
#> 3   b1    4
```
