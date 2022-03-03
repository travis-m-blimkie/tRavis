# Load packages
library(dplyr)
library(sigora)

data(idmap)


# Download all the Reactome data
reactome_data_all <- readr::read_tsv(
  "https://reactome.org/download/current/Ensembl2Reactome_All_Levels.txt",
  col_names = c("gene", "pathwayId", "url", "pathwayName", "evidence", "species")
)


# Filter for mouse-only entries, and select columns we need
reactome_data_mouse <- reactome_data_all %>%
  filter(species == "Mus musculus", stringr::str_detect(gene, "^ENSMUSG")) %>%
  select(pathwayId, pathwayName, gene) %>%
  as.data.frame()


# Construct the GPS object and save
gps_rea_mmu <- makeGPS(pathwayTable = reactome_data_mouse)

usethis::use_data(gps_rea_mmu, overwrite = TRUE, )
