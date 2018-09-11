# Updating Sigora's database used for enrichment --------------------------

library(sigora)
library(slam)
library(tidyverse)


# Constructing GPS for all levels -----------------------------------------
# Done using the Reactome Database, August 31st, 2018
reactome_ensembl_allLevels <- read.delim(
  "Ensembl2Reactome_All_Levels.txt",
  sep = "\t",
  col.names = c("gene", "pathwayID", "URL", "pathwayName", "Source", "Species")
) %>%
  filter(Species == "Homo sapiens") %>%
  select(pathwayID, pathwayName, gene)


reaH_allLevels <- makeGPS(
  pathwayTable = reactome_ensembl_allLevels,
  saveFile = "reaH_allLevels.rda",
  repoName = "reaH_allLevels"
)
