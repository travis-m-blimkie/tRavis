# Defines a function that performs GO term enrichment given an input list of genes
# p-value can be set as desired, with a default of 0.05

pao1_go_enrichment <- function(GOI, pval = 0.05) {

  require(tidyverse)
  
  
  # List of overlap size ----------------------------------------------------
  
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
  
  result_table <- tibble(
    term = names(fishers_result), 
    pvalue = as.numeric(fishers_result[names(fishers_result)])
  )
  
  
  # Filter the result -------------------------------------------------------
  
  filtered_result <- result_table %>% 
    filter(pvalue <= pval) %>% 
    arrange(pvalue)
  
  return(filtered_result)
  
}
