# Defines a function that performs GO term enrichment given an input list of genes
# p-value can be set as desired, with a default of 0.05

##TODO Add ability to filter enrichment background based on Namespace (e.g. only molecular process)

pao1_go_enrichment <- function(GOI, pval = 0.05) {

  require(tidyverse)
  

  # Check for correct input type --------------------------------------------

  if (is.character(GOI) == F) 
    stop("Please ensure GOI object is a character vector of locus tag IDs. If you gene names live as a column in a data frame, use dplyr::pull to extract the column as a character vector.")
  

  # Download and read in the GO terms, make as named list -------------------

  go_table <- read_tsv("https://raw.githubusercontent.com/travis-m-blimkie/tRavis/master/PAO1_gene_ontology_terms.txt")
  go_list <- split(x = go_table$Locus_Tag, f = go_table$GO_Term)
  
  
  # Numbers for matrix extraction -------------------------------------------

  overlap_list <- map(.x = go_list, function(x) 
    as.numeric(length(intersect(x, GOI)))
  )
  
  enrichment_lengths <- map(.x = go_list, function(x) length(x))                          
  
  query_length <- as.numeric(length(GOI))
  
  total_genes <- 5688
  
  
  # Construct matrices ------------------------------------------------------
  
  matrices <- map2(.x = overlap_list, .y = enrichment_lengths, function(x, y) 
    enrichment_matrix <- matrix(c(
      x, 
      as.numeric(y - x), 
      as.numeric(query_length - x), 
      as.numeric(total_genes - (y - x))
    ), nrow = 2, ncol = 2
    
    )
  )
  
  
  # Run Fishers test on each ------------------------------------------------
  
  fishers_result <- map(.x = matrices, function(x) 
    fisher.test(x, alternative = "greater")$p.value
  )
  
  
  # Create result table -----------------------------------------------------
  
  fishers_output <- tibble(GO_Term = names(fishers_result), 
                           pvalue = as.numeric(fishers_result[names(fishers_result)]))
  result_table <- left_join(fishers_output, distinct(go_table, GO_Term, .keep_all = T), by = "GO_Term") %>% 
    select(., GO_Term, Accession, Namespace, GO_Evidence_Code, PMID, pvalue)
  
  
  # Filter the result and return --------------------------------------------
  
  filtered_result <- result_table %>% 
    filter(pvalue <= pval) %>% 
    arrange(pvalue)
  
  return(filtered_result)
  
}
