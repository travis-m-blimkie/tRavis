# Load the required packages
library(biomaRt)
library(tidyverse)

# Use `biomaRt::getBM()` to create the conversion table
biomart_id_mapping_mouse_1 <- getBM(
  attributes = c("ensembl_gene_id", "mgi_symbol", "entrezgene_id", "description"),
  mart = useMart("ensembl", dataset = "mmusculus_gene_ensembl")
)

# Replace empty values with NA
biomart_id_mapping_mouse_2 <- biomart_id_mapping_mouse_1 %>% replace(. == "", NA)

# Keep only one row for each Ensembl gene
biomart_id_mapping_mouse <- biomart_id_mapping_mouse_2 %>%
  rename("entrez_gene_id" = entrezgene_id) %>%
  mutate(across(everything(), as.character)) %>%
  arrange(ensembl_gene_id, mgi_symbol, entrez_gene_id) %>%
  distinct() %>%
  as_tibble()

# Save the data for use in the package
usethis::use_data(biomart_id_mapping_mouse, overwrite = TRUE)
