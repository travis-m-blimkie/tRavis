# Find highest number of reads in a long table

Internal helper which takes a long and tidy data frame containing read
or count numbers derived from MultiQC, and finds the largest read or
count value, then round it up to the nearest ten million.

## Usage

``` r
get_rounded_max(x, buffer = 1.1, nearest = 1e+07)
```

## Arguments

- x:

  Data frame of read information

- buffer:

  Multiply the largest value by this factor before rounding. Defaults to
  `1.1`, i.e. adds a 10% buffer to the maximum value.

- nearest:

  Nearest number to round up to. Defaults to `10e6`.

## Value

Numeric; maximum number of total reads or counts

## Details

Input data frame must contain the columns "Samples" and "n_reads".

## References

None.

## See also

<https://www.github.com/travis-m-blimkie/tRavis>
