# Easily compare two lists

Performs `intersect(x, y)`, `setdiff(x, y)`, and `setdiff(y, x)`.
Returns these elements in a list with names "common", "unique_x", and
"unique_y".

## Usage

``` r
tr_compare_lists(x, y, names = NULL)
```

## Arguments

- x:

  First vector to compare.

- y:

  Second vector to compare.

- names:

  Optional character vector, containing names of `x` and `y` to apply to
  the output. Defaults to NULL for no names.

## Value

A named list of the common and unique elements of x and y.

## References

None.

## See also

<https://www.github.com/travis-m-blimkie/tRavis>

## Examples

``` r
tr_compare_lists(
  x = c(1, 2, 4, 5, 6),
  y = c(2, 3, 6, 7),
  names = c("A", "B")
)
#> $unique_A
#> [1] 1 4 5
#> 
#> $common
#> [1] 2 6
#> 
#> $unique_B
#> [1] 3 7
#> 
```
