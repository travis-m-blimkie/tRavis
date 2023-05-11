# Load packages and sigora data -------------------------------------------

library(dplyr)
data("reaH", "idmap", package = "sigora")


# Get pathway IDs and genes -----------------------------------------------

pathway_ids <- tibble("pathway_id" = reaH$origRepo[[1]]) %>%
  mutate(pwys = row_number(), .before = 1)

pathway_genes <- tibble("EntrezGene.ID" = reaH$origRepo[[2]]) %>%
  mutate(gns = row_number(), .before = 1)


# Map pathway IDs to their genes ------------------------------------------

mapped_data <- reaH$origRepo[[3]] %>%
  as_tibble() %>%
  left_join(pathway_ids) %>%
  left_join(pathway_genes)


# Add more ID info, filter for up to level 4 pathways ---------------------

sigora_database_L4 <- mapped_data %>%
  select(pathway_id, EntrezGene.ID) %>%
  filter(pathway_id %in% reaH$L1$ps[!reaH$L1$ps %in% reaH$L5$ps])


# Add pathway descriptions ------------------------------------------------

sigora_database_description <- reaH$pathwaydescriptions %>%
  as_tibble() %>%
  rename("pathway_id" = 1, "description" = 2) %>%
  left_join(sigora_database_L4, .)

sigora_database <- sigora_database_description %>%
  distinct() %>%
  janitor::clean_names()


# Save the object for the package -----------------------------------------

usethis::use_data(sigora_database, overwrite = TRUE, compress = "bzip2")
