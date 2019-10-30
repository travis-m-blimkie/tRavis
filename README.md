# tRavis

### Description
Github repository to hold my custom R package, containing a suite of useful
functions.

### Installation
The code below installs all dependencies and then tRavis itself.
```r
# tidyverse, devtools, and BiocManager
install.packages(c("tidyverse", "devtools", "BiocManager"))

# DESeq2 using BiocManager
BiocManager::install("DESeq2")

# QoRTs from Github
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
