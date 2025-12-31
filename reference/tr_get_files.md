# Create a named list of files

Function which creates a named list of files in a specified directory.
The list names are trimmed versions of file names, while contents of the
list are the file names themselves. In this way, it can be easily piped
into `purrr::map(~read.csv(.x))` to create a named list of data frames.

## Usage

``` r
tr_get_files(
  directory,
  pattern = "",
  recur = FALSE,
  date = FALSE,
  remove_string = NULL
)
```

## Arguments

- directory:

  Directory containing files to read

- pattern:

  Optional, case-sensitive pattern to use in file searching. If no
  pattern is supplied, all files in the specified directory will be
  returned.

- recur:

  Whether file searching and listing should be done recursively.
  Defaults to FALSE.

- date:

  Do file names contain a date which should be removed? Must be
  formatted akin to "YYYYMMDD", i.e. all numeric with no spaces, dashes,
  etc. Defaults to FALSE.

- remove_string:

  Optional string which can be removed from file names when creating
  names for the output list. Defaults to NULL for no changes.

## Value

Named list of files

## References

None.

## See also

<https://www.github.com/travis-m-blimkie/tRavis>

## Examples

``` r
tr_get_files(
  directory = system.file("extdata", package = "tRavis"),
  pattern = "test",
  remove_string = "test_",
  date = TRUE
)
#> $file1
#> [1] "/home/runner/work/_temp/Library/tRavis/extdata/test_file1_20191231.csv"
#> 
#> $file2
#> [1] "/home/runner/work/_temp/Library/tRavis/extdata/test_file2_20200101.csv"
#> 
```
