#' Function to perform pathway enrichment for PAO1 based on annotations
#' downloaded from pseudomonas.com
#' Currently set up as a simple Fisher's Test of overlapping genes


tr_pathway_enrichment <- function(GOI, strain = "", pvalue = 0.05) {

  require(tidyverse)

  # Check if the input genes are in the correct format (character vector)
  if (is.character(GOI) != T) stop("Did you provide your genes as a character vector?")

  # Download the pathway annotations from my Github
  if (strain == "PAO1" ) {
    annotations <- read_tsv(
      "https://raw.githubusercontent.com/travis-m-blimkie/misc_files/master/Pathway_Annotations/pathway_annotations_PAO1.tsv"
      )
    total_genes <- nrow(distinct(annotations, Locus_Tag)) %>% as.numeric()
  } else if (strain == "PA14") {
    annotations <- read_tsv(
      "https://raw.githubusercontent.com/travis-m-blimkie/misc_files/master/Pathway_Annotations/pathway_annotations_PA14.tsv"
    )
    total_genes <- nrow(distinct(annotations, Locus_Tag)) %>% as.numeric()
  } else if (strain == "LESB58") {
    annotations <- read_tsv(
      "https://raw.githubusercontent.com/travis-m-blimkie/misc_files/master/Pathway_Annotations/pathway_annotations_LESB58.tsv"
    )
    total_genes <- nrow(distinct(annotations, Locus_Tag)) %>% as.numeric()
  } else if (strain == "") {
    stop("Please select one of the following supported strains: 'PAO1', 'PA14', or 'LESB58'")
  }




}


