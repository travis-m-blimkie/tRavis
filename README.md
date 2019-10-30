# tRavis

### Description
Github repository to hold my custom R package, containing a suite of useful
functions.


#### Current functions include:
- **tr_compare_lists:** Returns common and unique elements for two vectors `x` and `y`.
- **tr_de_results:** Runs `DESeq2::results()` with provided contrasts, adds columns, and filters the result.
- **tr_deseq2_results:** Adds columns, and filters the result of `DESeq2::results()` call. Maintained for legacy support. 
- **tr_genebody_plotly:** Creates a plotly of gene body coverage, based on QoRTs program results.
- **tr_get_files:** Create a named list of files to be read in easily.
- **tr_gtf_cleaner:** Cleans and parses GTF files from *Pseudomonas aeruginosa*.
- **tr_test_enrichment:** Tests for enrichment of a specified set of genes in a list of genes of interest, using Fisher's Exact Test.
- **tr_tidy_gage:** Coverts output of Gage main function to a tidy dataframe, combining `greater` and `less`, while also filtering on q-value.

### Installation
The code below installs all dependencies and then tRavis itself.
```
# Tidyverse
install.packages("tidyverse")

# Devtools
install.packages("devtools")

# BiocManager
install.packages("BiocManager")

# DESeq2
BiocManager::install("DESeq2")

# QoRTs
install.packages("http://hartleys.github.io/QoRTs/QoRTs_STABLE.tar.gz",
                 repos = NULL, 
                 type = "source")

# Finally, you can install tRavis itself
devtools::install_github("travis-m-blimkie/tRavis")

# To update, use the following
devtools::update_packages("tRavis")
```

***

#### **Note**
At the current time, the function `tr_gtf_cleaner()` will not work properly with the latest version of GTF files from [PGDB](http://www.pseudomonas.com/), i.e. version 19.  
I am aware of this issue and will work on a fix as soon as I am able. 
