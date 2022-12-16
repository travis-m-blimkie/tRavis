# **tRavis**

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
  "Downloads/Pseudomonas_aeruginosa_PAO1_107.tsv",
  extra_cols = FALSE, 
  fill_names = FALSE
)
# # A tibble: 5,711 x 3
#    locus_tag gene_name product_description                           
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
    p_adjusted    = 0.05,
    fold_change   = 1.5,
    inform        = TRUE
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

### tr_enrichment_wrapper()
Perform pathway enrichment using ReactomePA or Sigora. The package also includes
up-to-date gene-pair signature (GPS) objects for both human and mouse Reactome
data to use with Sigora.
```r 
# For ReactomePA
> tr_enrichment_wrapper(
  tool        = "ReactomePA",
  input_genes = entrez_gene_ids,
  species     = "human",
  background  = gene_universe_entrez
)
# Testing 1172 genes...Done
# # A tibble: 981 × 9
#    id            description                gene_ratio bg_ratio   pvalue p_adjust   qvalue gene_id count
#    <chr>         <chr>                      <chr>      <chr>       <dbl>    <dbl>    <dbl> <chr>   <int>
#  1 R-HSA-1474244 Extracellular matrix orga… 59/715     213/7696 3.67e-15 3.61e-12 3.20e-12 1294/3…    59
#  2 R-HSA-909733  Interferon alpha/beta sig… 28/715     57/7696  8.54e-15 4.19e-12 3.72e-12 91543/…    28
#  3 R-HSA-913531  Interferon Signaling       46/715     169/7696 8.87e-12 2.69e- 9 2.39e- 9 91543/…    46
#  4 R-HSA-500792  GPCR ligand binding        47/715     176/7696 1.10e-11 2.69e- 9 2.39e- 9 4161/7…    47
#  5 R-HSA-1474228 Degradation of the extrac… 31/715     92/7696  6.70e-11 1.32e- 8 1.17e- 8 1294/4…    31
#  6 R-HSA-198933  Immunoregulatory interact… 32/715     106/7696 8.16e-10 1.33e- 7 1.18e- 7 1278/3…    32
#  7 R-HSA-1442490 Collagen degradation       20/715     46/7696  9.71e-10 1.36e- 7 1.21e- 7 1294/4…    20
#  8 R-HSA-375276  Peptide ligand-binding re… 25/715     76/7696  8.43e- 9 8.64e- 7 7.67e- 7 4161/5…    25
#  9 R-HSA-877300  Interferon gamma signaling 25/715     76/7696  8.43e- 9 8.64e- 7 7.67e- 7 3665/6…    25
# 10 R-HSA-6783783 Interleukin-10 signaling   18/715     42/7696  8.97e- 9 8.64e- 7 7.67e- 7 3557/3…    18
# # … with 971 more rows

# Or Sigora
> tr_enrichment_wrapper(
  tool        = "Sigora",
  input_genes = ensembl_gene_ids,
  species     = "human",
  gps_repo    = gps_rea_hsa,
  lvl         = 4
)
# Testing 1284 genes...Done
# # A tibble: 467 × 8
#    pathwy_id     description                pvalues bonferroni successes pathway_size      n sample_size
#    <chr>         <chr>                        <dbl>      <dbl>     <dbl>        <dbl>  <dbl>       <dbl>
#  1 R-HSA-909733  Interferon alpha/beta s… 2.57e-166  3.11e-163     172.         1437. 6.37e5       3533.
#  2 R-HSA-380108  Chemokine receptors bin… 3.87e- 69  4.68e- 66     109.         1964. 6.37e5       3533.
#  3 R-HSA-1474244 Extracellular matrix or… 8.67e- 66  1.05e- 62     181.         6731. 6.37e5       3533.
#  4 R-HSA-1442490 Collagen degradation     5.84e- 43  7.06e- 40      48.6         495. 6.37e5       3533.
#  5 R-HSA-216083  Integrin cell surface i… 3.28e- 42  3.96e- 39      57.4         836. 6.37e5       3533.
#  6 R-HSA-8948216 Collagen chain trimeriz… 9.26e- 41  1.12e- 37      59.7         974. 6.37e5       3533.
#  7 R-HSA-913531  Interferon Signaling     3.37e- 37  4.08e- 34      99.9        3609. 6.37e5       3533.
#  8 R-HSA-5669034 TNFs bind their physiol… 1.02e- 28  1.24e- 25      34.5         407. 6.37e5       3533.
#  9 R-HSA-1169408 ISG15 antiviral mechani… 1.00e- 26  1.21e- 23      41           767. 6.37e5       3533.
# 10 R-HSA-877300  Interferon gamma signal… 6.47e- 26  7.82e- 23     114.         6460. 6.37e5       3533.
# # … with 457 more rows
```

### tr_get_files()
Create a named list of files, easily piped into `purrr::map(~read.csv(.))` to
generate a named list of data frames. Supports recursive searching, custom
string/pattern removal, and date removal (assuming standard format YYYYMMDD).
```r
> tr_get_files(
  folder       = "~/Downloads/new_data",
  pattern      = "de_genes", 
  recur        = FALSE, 
  date         = TRUE, 
  removeString = "de_genes"
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
tr_qc_plots(directory = "multiqc_data")
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
gage_gset <- gage::kegg.gsets(species = "pae")
gage_result <- gage::gage(input_genes, gsets = gage_gset)

tr_tidy_gage(gage_result)
# # A tibble: 7 × 1
#   spoT$Direction $Pathway                    $p.ge…¹ $stat…²  $p.val $q.val $set.…³   $exp1
#   <chr>          <chr>                         <dbl>   <dbl>   <dbl>  <dbl>   <dbl>   <dbl>
# 1 Up             pae00780 Biotin metabolism  0.00358    3.36 0.00358 0.0967      10 0.00358
# 2 Down           pae02020 Two-component sys… 0.00476   -2.64 0.00476 0.0664      53 0.00476
# 3 Down           pae00220 Arginine biosynth… 0.00560   -2.73 0.00560 0.0664      14 0.00560
# 4 Down           pae02040 Flagellar assembly 0.00927   -2.55 0.00927 0.0664      21 0.00927
# 5 Down           pae00860 Porphyrin and chl… 0.00983   -2.56 0.00983 0.0664      11 0.00983
# 6 Down           pae02024 Quorum sensing     0.0173    -2.21 0.0173  0.0933      21 0.0173 
# 7 Down           pae00190 Oxidative phospho… 0.0207    -2.21 0.0207  0.0933      10 0.0207 
# # … with abbreviated variable names ¹​$p.geomean, ²​$stat.mean, ³​$set.size
```

### tr_trunc_neatly()
Simple means of truncating long strings without breaking them in the middle of a 
word. Useful for example when trimming long Reactome pathway names in a plot.
```r
tr_trunc_neatly(x = "This is a long string that we want to break neatly.", l = 40)
# [1] "This is a long string that we want to..."
```

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
