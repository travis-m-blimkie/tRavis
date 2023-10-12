# **tRavis**

![GitHub R package version (branch)](https://img.shields.io/github/r-package/v/travis-m-blimkie/tRavis/master?label=tRavis%40master)

Github repository to hold my custom R package, containing a suite of useful R
functions and data objects.

## Installation
```r
devtools::install_github("travis-m-blimkie/tRavis")
```

## Examples

### tr_anno_cleaner()
Clean annotation files (CSV or TSV) for *Pseudomonas aeruginosa* from
[pseudomonas.com](pseudomonas.com), with some options for customizing output:
```r
> tr_anno_cleaner(
  "Downloads/Pseudomonas_aeruginosa_PAO1_107.csv",
  extra_cols = FALSE, 
  fill_names = FALSE
)
# # A tibble: 5,711 x 3
#    locus_tag gene_name product_name                           
#    <chr>     <chr>     <chr>                                         
#  1 PA0001    dnaA      chromosomal replication initiator protein DnaA
#  2 PA0002    dnaN      DNA polymerase III, beta chain                
#  3 PA0003    recF      RecF protein                                  
#  4 PA0004    gyrB      DNA gyrase subunit B                          
#  5 PA0005    lptA      lysophosphatidic acid acyltransferase, LptA   
#  6 PA0006    NA        conserved hypothetical protein                
#  7 PA0007    NA        hypothetical protein                          
#  8 PA0008    glyS      glycyl-tRNA synthetase beta chain             
#  9 PA0009    glyQ      glycyl-tRNA synthetase alpha chain            
# 10 PA0010    tag       DNA-3-methyladenine glycosidase I             
# # ... with 5,701 more rows
```

### tr_clean_deseq2_result()
Takes a DESeq2 results object, and returns the significant DE genes for the
desired contrast name (from `DESeq2::resultsNames()`), printing a message if
`inform = TRUE`.
```r
> resultsNames(dds)
# [1] "Intercept" "condition_treatment_vs_control"
> tr_clean_deseq2_results(
    deseq2_result = DESeq2::results(dds, name = "condition_treatment_vs_control"), 
    p_adjusted = 0.05,
    fold_change = 1.5,
    inform = TRUE
  )
# Found 2331 DE genes for condition treatment vs. control
```

### tr_compare_lists()
Compare two lists to find the common/unique elements, with an optional `names`
argument to apply to the results:
```r
> tr_compare_lists(c(1, 2, 3, 4), c(3, 4, 5, 6), names = c("A", "B"))
# $unique_A
# [1] 1 2
# 
# $common
# [1] 3 4
# 
# $unique_B
# [1] 5 6
```

### tr_get_files()
Create a named list of files, easily piped into `purrr::map(~read.csv(.))` to
generate a named list of data frames. Supports recursive searching, custom
string/pattern removal, and date removal (assuming standard format YYYYMMDD).
```r
> tr_get_files(
    directory = "~/Downloads/new_data",
    pattern = "de_genes",
    recur = FALSE,
    date = TRUE,
    remove_string = "de_genes"
  )
#                                                       treatment1
# "/home/user/Downloads/new_data/de_genes_treatment1_20200224.csv"
#                                                       treatment2
# "/home/user/Downloads/new_data/de_genes_treatment2_20200224.csv"
```

### tr_qc_plots()
Generate RNA-Seq QC plots from [MultiQC](https://multiqc.info/) outputs.
Currently only supports summary plots for FastQC, STAR, and HTSeq. Plots are
created with [plotly](https://plotly.com/r/), meaning they can be embedded in
RMarkdown documents and retain interactivity.
```r
> tr_qc_plots(directory = "multiqc_data")
```

### tr_sort_alphanum()
Sort a column of alphanumeric strings in (non-binary) numerical order given an
input data frame and desired column. You can use the column name or index, and
it is compatible with pipes.
```r
> my_dataframe
#    c1 c2
# 1  a1  1
# 2 a11  3
# 3  a5  2
> tr_sort_alphanum(input_df = my_dataframe, sort_col = "c1")
#    c1 c2
# 1  a1  1
# 3  a5  2
# 2 a11  3
```

### tr_test_enrichment()
Fisher's test for gene enrichment, which constructs the matrix for you and
returns the p-value.
```r
> tr_test_enrichment(de_genes, biofilm_genes, total_genes = 5000)
# 0.00325
```

### tr_theme()
Easy themes for [ggplot2](https://ggplot2.tidyverse.org/) that improve on
the default in ways such as increasing font size, changing the background to 
white and adding a border. By default, it uses a minimal grid, like so:
```r
> ggplot(mtcars, aes(cyl, mpg)) + geom_point() + tr_theme()
```
![](man/figures/tr_theme_wGrid.png)


...Or you can remove the grid entirely:
```r
> ggplot(mtcars, aes(cyl, mpg)) + geom_point() + tr_theme(grid = FALSE)
```
![](man/figures/tr_theme_noGrid.png)


### tr_tidy_gage()
Tidies the output from [Gage](https://bioconductor.org/packages/gage/) pathway
enrichment.
```r
> gage_gset <- gage::kegg.gsets(species = "pae")[["kg.sets"]]
> gage_result <- gage::gage(input_genes, gsets = gage_gset)
> tr_tidy_gage(gage_result)
# # A tibble: 7 × 1
#   pathway                     p_geomean stat_mean   p_val  q_val set_size    exp1
#   <chr>                           <dbl>     <dbl>   <dbl>  <dbl>    <dbl>   <dbl>
# 1 pae00780 Biotin metabolism    0.00358      3.36 0.00358 0.0967       10 0.00358
# 2 pae02020 Two-component syst…  0.00476     -2.64 0.00476 0.0664       53 0.00476
# 3 pae00220 Arginine biosynthe…  0.00560     -2.73 0.00560 0.0664       14 0.00560
# 4 pae02040 Flagellar assembly   0.00927     -2.55 0.00927 0.0664       21 0.00927
# 5 pae00860 Porphyrin and chlo…  0.00983     -2.56 0.00983 0.0664       11 0.00983
# 6 pae02024 Quorum sensing       0.0173      -2.21 0.0173  0.0933       21 0.0173 
# 7 pae00190 Oxidative phosphor…  0.0207      -2.21 0.0207  0.0933       10 0.0207 
```

### tr_trunc_neatly()
Simple means of truncating long strings without breaking them in the middle of a 
word. Useful for example when trimming long Reactome pathway names in a plot.
```r
> tr_trunc_neatly(x = "This is a long string that we want to break neatly.", l = 40)
# [1] "This is a long string that we want to..."
```

<br>

## Versioning
This package makes use of [SemVer](https://semver.org/).

## Authors

Travis Blimkie is the originator and principal contributor. You can check the
list of all contributors
[here](https://github.com/travis-m-blimkie/tRavis/graphs/contributors).

## License
This project is written under the MIT license, available
[here.](https://github.com/travis-m-blimkie/tRavis/blob/master/LICENSE)

## Acknowledgements
Thanks to everyone in the lab who has used these functions and provided
ideas/feedback!
