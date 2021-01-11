
# **tRavis**

Github repository to hold my custom R package, containing a suite of useful
functions.

## Installation
The only recommended installation for using **tRavis** is the [Tidyverse](https://www.tidyverse.org/).
```r
install.packages("tidyverse")
remotes::install_github("travis-m-blimkie/tRavis")
```

## Examples

### tr_anno_cleaner()
Clean annotation files (CSV or TSV) for *Pseudomonas aeruginosa* from
[pseudomonas.com](pseudomonas.com), with some options for customizing output:
```r
> tr_anno_cleaner(
  "Downloads/Pseudomonas_aeruginosa_PAO1_107.tsv",
  extra_cols = FALSE, 
  fill_names = FALSE
)
# A tibble: 5,711 x 3
   locus_tag gene_name product_description                           
   <chr>     <chr>     <chr>                                         
 1 PA0001    dnaA      chromosomal replication initiator protein DnaA
 2 PA0002    dnaN      DNA polymerase III, beta chain                
 3 PA0003    recF      RecF protein                                  
 4 PA0004    gyrB      DNA gyrase subunit B                          
 5 PA0005    lptA      lysophosphatidic acid acyltransferase, LptA   
 6 PA0006    NA        conserved hypothetical protein                
 7 PA0007    NA        hypothetical protein                          
 8 PA0008    glyS      glycyl-tRNA synthetase beta chain             
 9 PA0009    glyQ      glycyl-tRNA synthetase alpha chain            
10 PA0010    tag       DNA-3-methyladenine glycosidase I             
# ... with 5,701 more rows
```


### tr_compare_lists()
Compare two lists to get the common/unique elements:
```r
> tr_compare_lists(c(1, 2, 3, 4), c(3, 4, 5, 6))
$common
[1] 3 4

$unique_x
[1] 1 2

$unique_y
[1] 5 6
```

### tr_get_files()
Create a named list of files, easily piped into `purrr::map(~read.csv(.))` to
generate a named list of data frames. Supports recursive searching, custom
string/pattern removal, and date removal (assuming standard format YYYYMMDD).
```r
> tr_get_files(
  folder = "~/Downloads/new_data",
  pattern = "de_genes", 
  recur = FALSE, 
  date = TRUE, 
  removeString = "de_genes_"
)
                                                      treatment1 
"/home/user/Downloads/new_data/de_genes_treatment1_20200224.csv" 
                                                      treatment2 
"/home/user/Downloads/new_data/de_genes_treatment2_20200224.csv" 
```

### tr_sigora_wrapper()
Run pathway enrichment using [Sigora]() on a set of query genes. Uses the
"saveFile" argument to return results with candidate genes to the user. Can be
run with human or mouse genes/data, with KEGG or Reactome pathways.
```r
> tr_sigora_wrapper(query_list = de_genes, database = "Reactome", species = "mouse")
# Running sigora with parameters 'GPSrepo = reaM, level = 4'...
# Done!

# A tibble: 171 x 9
   pathwy.id  description         pvalues Bonferroni successes PathwaySize      N sample.size genes            
   <chr>      <chr>                 <dbl>      <dbl>     <dbl>       <dbl>  <dbl>       <dbl> <chr>            
 1 R-MMU-216… Integrin cell sur… 3.58e-10    2.84e-7      9.86       587.  5.13e5        342. Jam2;Icam2;Itgax…
 2 R-MMU-329… TRP channels       2.10e- 6    1.66e-3      5.01       299.  5.13e5        342. Trpc4;Trpv4;Mcol…
 3 R-MMU-680… COPI-mediated ant… 7.00e- 6    5.54e-3     10         2424.  5.13e5        342. Cog4;Dctn6;Cope;…
 4 R-MMU-147… Extracellular mat… 2.92e- 5    2.31e-2     14.7       5556.  5.13e5        342. Serpinh1;Adam8;F…
 5 R-MMU-917… Endosomal Sorting… 6.52e- 5    5.15e-2      3.68       113.  5.13e5        342. Vps4a;Vps36;Vps3…
 6 R-MMU-446… Asparagine N-link… 1.56e- 4    1.23e-1     10.5       3522.  5.13e5        342. Amfr;Alg6;St6gal…
 7 R-MMU-140… Formation of Fibr… 1.19e- 3    9.42e-1      2.24        75.4 5.13e5        342. F3;Tfpi;Serpine2 
 8 R-MMU-773… Insulin receptor … 1.34e- 3    1.00e+0      3          318.  5.13e5        342. Atp6v1b2;Atp6v0d…
 9 R-MMU-895… Post-translationa… 1.96e- 3    1.00e+0      8.57      3320.  5.13e5        342. Cyr61;Rcn1;Penk;…
10 R-MMU-948… Transport to the … 2.08e- 3    1.00e+0      5.87      1320.  5.13e5        342. Man1a;B4galt4;Tr…
# … with 161 more rows
```

### tr_sort_alphanum()
Sort a column of alphanumeric strings in (non-binary) numerical order given an
input data frame and desired column. You can use the column name or index, and
it is compatible with pipes.
```r
> my_dataframe
   c1 c2
1  a1  1
2 a11  3
3  a5  2

> tr_sort_alphanum(input_df = my_dataframe, sort_col = "c1")
   c1 c2
1  a1  1
3  a5  2
2 a11  3
```

### tr_test_enrichment()
Fisher's test for gene enrichment, which constructs the matrix for you and
returns the p-value.
```r
> tr_test_enrichment(de_genes, biofilm_genes, total_genes = 5000)
0.00325
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

<br>

## Versioning
This package makes use of [SemVer](https://semver.org/).

## Authors

Travis Blimkie is the originator and principal contributor. You can check the
list of all contributors [here](https://github.com/travis-m-blimkie/tRavis/graphs/contributors).

## License
This project is written under the MIT license, available
[here.](https://github.com/travis-m-blimkie/tRavis/blob/master/LICENSE)

## Acknowledgements
Thanks to everyone in the lab who has used these functions and provided
ideas/feedback!
