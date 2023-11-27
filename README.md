
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tRavis

<!-- badges: start -->

![GitHub R package version
(branch)](https://img.shields.io/github/r-package/v/travis-m-blimkie/tRavis/master?label=tRavis%40master)
<!-- badges: end -->

tRavis is a small R package, comprised of a number of useful R
functions, and some commonly used data objects. Most of the included
functions relate to the analysis, testing, and visualization of RNA-Seq
results, but some are designed to be more general in their application.

## Installation

You can install the development version of tRavis from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("travis-m-blimkie/tRavis")
```

## Example

``` r
library(tRavis)
#> Thanks for using tRavis v0.73.22! If you encounter any bugs
#> or problems, please submit an issue at the Github page:
#> https://github.com/travis-m-blimkie/tRavis/issues

# Compare two lists:
tr_compare_lists(c(1, 2, 3, 4), c(3, 4, 5, 6), names = c("A", "B"))
#> $unique_A
#> [1] 1 2
#> 
#> $common
#> [1] 3 4
#> 
#> $unique_B
#> [1] 5 6

# Create a named list of files:
tr_get_files(
  directory = system.file("extdata", package = "tRavis"),
  pattern = "test",
  date = TRUE,
  remove_string = "test_"
)
#> $file1
#> [1] "/tmp/RtmpKTvW5j/temp_libpath18f6858bbff42/tRavis/extdata/test_file1_20191231.csv"
#> 
#> $file2
#> [1] "/tmp/RtmpKTvW5j/temp_libpath18f6858bbff42/tRavis/extdata/test_file2_20200101.csv"

# Neatly truncate strings:
tr_trunc_neatly(
  x = "This is a long string that we want to break neatly",
  l = 40
)
#> [1] "This is a long string that we want to..."
```

## Versioning

This package makes use of [SemVer](https://semver.org/).

## Authors

Travis Blimkie is the originator and principal contributor. You can
check the list of all contributors
[here](https://github.com/travis-m-blimkie/tRavis/graphs/contributors).

## License

This project is written under the MIT license, available
[here.](https://github.com/travis-m-blimkie/tRavis/blob/master/LICENSE)

## Acknowledgements

Thanks to everyone in the lab who has used these functions and provided
ideas/feedback!
