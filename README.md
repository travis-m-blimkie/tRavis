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
data to use with Sigora. The input can be a vector of gene IDs (first example), 
or you can provide a data frame, indicating an ID column, while splitting those
genes into up or down using a second column (second example).
```r 
# For ReactomePA
> tr_enrichment_wrapper(
  input_genes = as.character(de_gene_table$entrez_gene_id),
  tool        = "ReactomePA",
  species     = "human",
  background  = gene_universe_entrez
)
# Testing 456 genes with ReactomePA...
# Done!
# 
# # A tibble: 835 × 8
#    pathway_id    description                            pvalue p_adjust gene_…¹ level_1 level_2 genes
#    <chr>         <chr>                                   <dbl>    <dbl> <chr>   <chr>   <chr>   <chr>
#  1 R-HSA-6798695 Neutrophil degranulation             5.47e-21 4.56e-18 57/306  Immune… Innate… 6438…
#  2 R-HSA-449147  Signaling by Interleukins            1.40e- 7 5.83e- 5 35/306  Immune… Cytoki… 9235…
#  3 R-HSA-6785807 Interleukin-4 and Interleukin-13 si… 9.81e- 6 2.73e- 3 13/306  Immune… Cytoki… 240/…
#  4 R-HSA-5602498 MyD88 deficiency (TLR2/4)            7.91e- 5 1.65e- 2 5/306   Disease Diseas… 7099…
#  5 R-HSA-5603041 IRAK4 deficiency (TLR2/4)            1.07e- 4 1.79e- 2 5/306   Disease Diseas… 7099…
#  6 R-HSA-5260271 Diseases of Immune System            1.90e- 4 2.26e- 2 6/306   Disease Diseas… 7099…
#  7 R-HSA-5602358 Diseases associated with the TLR si… 1.90e- 4 2.26e- 2 6/306   Disease Diseas… 7099…
#  8 R-HSA-5686938 Regulation of TLR by endogenous lig… 2.37e- 4 2.48e- 2 5/306   Immune… Innate… 7099…
#  9 R-HSA-166058  MyD88:MAL(TIRAP) cascade initiated … 3.25e- 4 2.71e- 2 11/306  Immune… Innate… 4205…
# 10 R-HSA-168188  Toll Like Receptor TLR6:TLR2 Cascade 3.25e- 4 2.71e- 2 11/306  Immune… Innate… 4205…
# # … with 825 more rows, and abbreviated variable name ¹gene_ratio
# # ℹ Use `print(n = ...)` to see more rows

# Or Sigora
> tr_enrichment_wrapper(
  input_genes = de_gene_table,
  directional = c("ensembl_gene_id", "log2FoldChange")
  tool        = "Sigora",
  gps_repo    = reaH,
  lvl         = 4
)
# Testing 515 total genes with Sigora:
# 	131 up-regulated genes...
# 	384 down-regulated genes...
# Done!
# 
# # A tibble: 195 × 7
#    pathway_id    description                                  pvalue bonfer…¹ direc…² level_1 level_2
#    <chr>         <chr>                                         <dbl>    <dbl> <chr>   <chr>   <chr>  
#  1 R-HSA-373076  Class A/1 (Rhodopsin-like receptors)       5.03e-13 5.04e-10 up      Signal… Signal…
#  2 R-HSA-77289   Mitochondrial Fatty Acid Beta-Oxidation    3.48e-10 3.48e- 7 up      Metabo… Metabo…
#  3 R-HSA-380108  Chemokine receptors bind chemokines        9.31e- 5 9.32e- 2 up      Signal… Signal…
#  4 R-HSA-198933  Immunoregulatory interactions between a L… 7.21e- 4 7.22e- 1 up      Immune… Adapti…
#  5 R-HSA-391903  Eicosanoid ligand-binding receptors        7.52e- 3 1   e+ 0 up      Signal… Signal…
#  6 R-HSA-71291   Metabolism of amino acids and derivatives  4.9 e- 2 1   e+ 0 up      Metabo… Metabo…
#  7 R-HSA-449836  Other interleukin signaling                9.89e- 2 1   e+ 0 up      Immune… Cytoki…
#  8 R-HSA-877300  Interferon gamma signaling                 1.33e- 1 1   e+ 0 up      Immune… Cytoki…
#  9 R-HSA-913531  Interferon Signaling                       1.45e- 1 1   e+ 0 up      Immune… Cytoki…
# 10 R-HSA-8978868 Fatty acid metabolism                      2.00e- 1 1   e+ 0 up      Metabo… Metabo…
# # … with 185 more rows, and abbreviated variable names ¹bonferroni, ²direction
# # ℹ Use `print(n = ...)` to see more rows
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
# # … with abbreviated variable names ¹$p.geomean, ²$stat.mean, ³$set.size
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
list of all contributors
[here](https://github.com/travis-m-blimkie/tRavis/graphs/contributors).

## License
This project is written under the MIT license, available
[here.](https://github.com/travis-m-blimkie/tRavis/blob/master/LICENSE)

## Acknowledgements
Thanks to everyone in the lab who has used these functions and provided
ideas/feedback!
