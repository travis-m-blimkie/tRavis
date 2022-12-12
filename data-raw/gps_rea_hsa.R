# Load packages
library(dplyr)
library(sigora)

data(idmap)


# Download all the Reactome data
reactome_data_all <- readr::read_tsv(
  "https://reactome.org/download/current/Ensembl2Reactome_All_Levels.txt",
  col_names = c("gene", "pathwayId", "url", "pathwayName", "evidence", "species")
)


# Filter for human-only entries, and select columns we need
reactome_data_human <- reactome_data_all %>%
  filter(species == "Homo sapiens", stringr::str_detect(gene, "^ENSG")) %>%
  select(pathwayId, pathwayName, gene) %>%
  as.data.frame()


# Construct the GPS object and save
gps_rea_hsa <- makeGPS(pathwayTable = reactome_data_human)

usethis::use_data(gps_rea_hsa, overwrite = TRUE)
