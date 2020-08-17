# **tRavis**
Github repository to hold my custom R package, containing a suite of useful
functions.

## Installation
Some of the dependencies for tRavis require building from source. If you are
on Windows, you will need to install [Rtools](https://cran.r-project.org/bin/windows/Rtools/) 
before running the code below, which installs all dependencies and then **tRavis** itself.
```r
# tidyverse, devtools, and BiocManager
install.packages(c("tidyverse", "devtools", "BiocManager"))

# DESeq2 using BiocManager
BiocManager::install("DESeq2")

# QoRTs from Github
install.packages("http://hartleys.github.io/QoRTs/QoRTs_STABLE.tar.gz",
                 repos = NULL, 
                 type = "source")

# Finally, you can install tRavis
devtools::install_github("travis-m-blimkie/tRavis")
```

## Examples

### tr_compare_lists()
Compare two lists to get the common/unique elements:
```r
> tr_compare_lists(c(1, 2, 3, 4), c(3, 4, 5, 6))
# > $common
# > [1] 3 4
# > 
# > $unique_x
# > [1] 1 2
# > 
# > $unique_y
# > [1] 5 6
```

### tr_get_files()
Create a named list of files, easily piped into `purrr::map(~read.csv(.))` to
generate a named list of data frames. Supports recursive searching, custom
string/pattern removal, and date removal (assuming standard format YYYYMMDD).
```r
> tr_get_files(
  "~/Downloads/new_data", 
  pattern = "de_genes", 
  recur = FALSE, 
  date = TRUE, 
  removeString = "de_genes_"
)
# >                                                       treatment1 
# > "/home/user/Downloads/new_data/de_genes_treatment1_20200224.csv" 
# >                                                       treatment2 
# > "/home/user/Downloads/new_data/de_genes_treatment2_20200224.csv" 
```

### tr_sort_alphanum()
Sort a column of alphanumeric strings in (non-binary) numerical order given an
input data frame and desired column. You can use the column name or index, and
it is compatible with pipes.
```r
> my_dataframe
# >    c1 c2
# > 1  a1  1
# > 2 a11  3
# > 3  a5  2

> tr_sort_alphanum(input_df = my_dataframe, sort_col = "c1")
# >    c1 c2
# > 1  a1  1
# > 3  a5  2
# > 2 a11  3
```

### tr_test_enrichment()
Fisher's test for gene enrichment, which constructs the matrix for you and
returns the p-value.
```r
> tr_test_enrichment(de_genes, biofilm_genes, total_genes = 5000)
# > 0.00325
```

### tr_theme()
Easy themes for [ggplot2](https://ggplot2.tidyverse.org/) that improve on
the default in ways such as increasing font size, changing the background to 
white and adding a border. You also have the option to remove all grid elements...
```r
> ggplot(mtcars, aes(cyl, mpg)) + geom_point() + tr_theme(grid = FALSE)
```
![](man/figures/tr_theme_noGrid.png)


...Or create a nice minimal grid:
```r
> ggplot(mtcars, aes(cyl, mpg)) + geom_point() + tr_theme(grid = TRUE)
```
![](man/figures/tr_theme_wGrid.png)

<br>

## Versioning
This package makes use of [SemVer](https://semver.org/) for versioning.

## Authors

Travis Blimkie is the originator and principal contributor. You can check the
list of all contributors [here](https://github.com/travis-m-blimkie/tRavis/graphs/contributors).

## License
This project is written under the MIT license, available
[here.](https://github.com/travis-m-blimkie/tRavis/blob/master/LICENSE)

## Acknowledgements
Thanks to everyone in the lab who has used these functions and provided
ideas/feedback!

<br>
