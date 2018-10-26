#' Function to perform pathway enrichment for PAO1 based on annotations
#' downloaded from pseudomonas.com
#' Currently set up as a simple Fisher's Test of overlapping genes


pao1_pe <- function(GOI, pvalue = 0.05) {

  require(tidyverse)

  # Check if the input genes are in the correct format (character vector)
  if (is.character(GOI) != T) stop("Did you provide your genes as a character vector?")

  # Download the pathway annotations from my Github
  pao1_anno <- read_tsv(
    "https://raw.githubusercontent.com/travis-m-blimkie/misc_files/master/pao1_annotations_tidy.tsv"
    )

}


pao1_pe(GOI = test_genes)
