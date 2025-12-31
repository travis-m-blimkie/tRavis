# Cleanly trim long strings

Trims the input string to the desired length, appending an ellipsis to
the end, without splitting in the middle of a word.

## Usage

``` r
tr_trunc_neatly(x, l = 60)
```

## Arguments

- x:

  Input string to trim to desired length, appending an ellipsis to the
  end, and without splitting words

- l:

  Desired length at which to trim strings (defaults to 60)

## Value

Character string

## References

None.

## See also

<https://www.github.com/travis-m-blimkie/tRavis>

## Examples

``` r
tr_trunc_neatly("This is a test string", l = 17)
#> [1] "This is a test..."
```
