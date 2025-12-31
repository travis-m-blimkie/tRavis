# Clean annotations from pseudomonas.com

Given an input CSV or TSV annotation file from
<https://pseudomonas.com>, separates and cleans the data, returning a
tidy tibble with the following columns: "locus_tag", "gene_name", and
"product_name". Setting the `extra_cols` argument to `TRUE` will add the
columns "start", "end", and "strand". Enabling `fill_names` will
populate missing gene names with the corresponding locus tag.

## Usage

``` r
tr_anno_cleaner(input_file, extra_cols = FALSE, fill_names = FALSE)
```

## Arguments

- input_file:

  Path to the input TSV or CSV file.

- extra_cols:

  Logical to determine if start, end, and strand columns should be
  included. Defaults to `FALSE`.

- fill_names:

  Logical to determine if blank/NA genes names should be filled in with
  corresponding locus tag. Defaults to `FALSE`.

## Value

A data frame (tibble) of the cleaned input file

## References

Download annotation files from <https://pseudomonas.com>

## See also

<https://www.github.com/travis-m-blimkie/tRavis>

## Examples

``` r
link <- system.file(
  "extdata/Pseudomonas_aeruginosa_PAO1_107.csv.gz",
  package = "tRavis"
)

tr_anno_cleaner(input_file = link)
#> # A tibble: 5,713 × 3
#>    locus_tag gene_name product_name                                  
#>    <chr>     <chr>     <chr>                                         
#>  1 PA0001    dnaA      chromosomal replication initiator protein DnaA
#>  2 PA0002    dnaN      DNA polymerase III, beta chain                
#>  3 PA0003    recF      RecF protein                                  
#>  4 PA0004    gyrB      DNA gyrase subunit B                          
#>  5 PA0005    lptA      lysophosphatidic acid acyltransferase, LptA   
#>  6 PA0006    NA        conserved hypothetical protein                
#>  7 PA0007    NA        hypothetical protein                          
#>  8 PA0008    glyS      glycyl-tRNA synthetase beta chain             
#>  9 PA0009    glyQ      glycyl-tRNA synthetase alpha chain            
#> 10 PA0010    tag       DNA-3-methyladenine glycosidase I             
#> # ℹ 5,703 more rows
```
