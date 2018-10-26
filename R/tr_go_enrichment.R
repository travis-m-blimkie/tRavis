# Defines a function that performs GO term enrichment given an input list of genes
# p-value can be set as desired, with a default of 0.05
# GO terms can also be filtered based on desired class


tr_go_enrichment <- function(GOI, pval = 0.05, strain = "", GO_class = "all") {

  require(tidyverse)


  # Check for correct input type --------------------------------------------

  if (is.character(GOI) == F)
    stop("Please ensure GOI object is a character vector of locus tag IDs.\n
         If you gene names live as a column in a data frame, use dplyr::pull\n
         to extract the column as a character vector.")


  # Selecting strain for use in enrichment ----------------------------------

  if (condition) {

  }f (strain == "PAO1") {
    go_table_all <- suppressMessages(read_tsv(
      "https://raw.githubusercontent.com/travis-m-blimkie/tRavis/master/gene_ontology_terms_PAO1.txt"
    ))
    total_genes <- 5701
  } else if (strain == "PA14") {
    go_table_all <- suppressMessages(read_tsv(
      "https://raw.githubusercontent.com/travis-m-blimkie/tRavis/master/gene_ontology_terms_PA14.txt"
    ))
    total_genes <- 5983
  } else if (strain == "LESB58") {
    go_table_all <- suppressMessages(read_tsv(
      "https://raw.githubusercontent.com/travis-m-blimkie/tRavis/master/gene_ontology_terms_LESB58.txt"
    ))
    total_genes <- 6028
  } else if (strain == "") {
    stop("Please select one of the following strains: PAO1, PA14, or LESB58")
  }


  # Filter based on desired class of GO terms -------------------------------

  go_table <- tibble()

  if ("all" %in% GO_class) {
    go_table <- go_table_all
  }
  if ("CC" %in% GO_class) {
    go_table <- bind_rows(go_table, filter(go_table_all, Namespace == "cellular_component"))
  }
  if ("BP" %in% GO_class) {
    go_table <- bind_rows(go_table, filter(go_table_all, Namespace == "biological_process"))
  }
  if ("MF" %in% GO_class) {
    go_table <- bind_rows(go_table, filter(go_table_all, Namespace == "molecular_function"))
  }

  # Convert the table to a named list for mapping
  go_list <- split(x = go_table$Locus_Tag, f = go_table$GO_Term)


  # Numbers for matrix construction -----------------------------------------

  overlap_list <- map(.x = go_list, function(x) as.numeric(length(intersect(x, GOI))))

  enrichment_lengths <- map(.x = go_list, function(x) length(x))

  query_length <- as.numeric(length(GOI))


  # Construct matrices ------------------------------------------------------

  matrices <- map2(.x = overlap_list, .y = enrichment_lengths, function(x, y)
    matrix(c(
      x,
      as.numeric(y - x),
      as.numeric(query_length - x),
      as.numeric(total_genes - (y - x))
    ), nrow = 2, ncol = 2))


  # Run Fishers test on each ------------------------------------------------

  fishers_result <- map(.x = matrices, function(x) fisher.test(x, alternative = "greater")$p.value)


  # Create result table -----------------------------------------------------

  fishers_output <- tibble(GO_Term = names(fishers_result),
                           pvalue = as.numeric(fishers_result[names(fishers_result)]))

  result_table <- left_join(fishers_output, distinct(go_table, GO_Term, .keep_all = T), by = "GO_Term") %>%
    select(., GO_Term, Accession, Namespace, GO_Evidence_Code, PMID, pvalue)


  # Filter the result on p-value --------------------------------------------

  filtered_result <- result_table %>%
    filter(pvalue <= pval) %>%
    arrange(pvalue)


  return(filtered_result)

}
