
# Load packages -----------------------------------------------------------

library(dplyr)


# Read in pathway hierarchy and pathway names -----------------------------

pathway_hierarchy <- readr::read_tsv(
  "https://reactome.org/download/current/ReactomePathwaysRelation.txt",
  col_names = c("higher", "pathway_id")
) %>%
  filter(stringr::str_detect(higher, "^R-HSA"))

all_pathways <- readr::read_tsv(
  "https://reactome.org/download/current/ReactomePathways.txt",
  col_names = c("pathway_id", "description", "organism")
) %>%
  filter(stringr::str_detect(pathway_id, "^R-HSA")) %>%
  select(-organism)


# Function to join and rename ---------------------------------------------

pathway_join <- function(input, name) {
  nam <- name
  p <- left_join(input, pathway_hierarchy, by = "pathway_id") %>%
    rename(!!name := "pathway_id", pathway_id = "higher")
  return(p)
}


# Initial join of all pathways to their parent ----------------------------

full_hierarchy <- all_pathways %>%
  select(pathway_id) %>%
  pathway_join(name = "enr_pathway")


# Run successive joins to fully expand the hierarchy ----------------------

for (i in 1:11) {
  names <- as.character(english::as.english(i))
  full_hierarchy <- full_hierarchy %>% pathway_join(name = names)
}

# All entries in "pathway_id" column are NA, so remove that column
length(na.omit(full_hierarchy$pathway_id))
full_hierarchy <- full_hierarchy %>% select(-pathway_id)


# Reduce hierarchy --------------------------------------------------------

# For each term, we want it's highest and second-highest level parent
enr_pathway_high_level <- data.frame()

for (row in 1:nrow(full_hierarchy)) {
  p <- na.omit(as.character(full_hierarchy[row, ]))

  how_deep <- length(p)

  if (how_deep >= 3) {
    p <- data.frame(
      pathway_id = p[1],
      level_2_id = p[length(p) - 1],
      level_1_id = p[length(p)]
    )
    enr_pathway_high_level <- bind_rows(enr_pathway_high_level, p)
  } else {
    p <- data.frame(
      pathway_id = p[1],
      level_2_id = p[1],
      level_1_id = p[length(p)]
    )
    enr_pathway_high_level <- bind_rows(enr_pathway_high_level, p)
  }
}


# Add descriptions --------------------------------------------------------

pathway_categories <-
  enr_pathway_high_level %>%
  left_join(., rename(all_pathways, "level_1" = description), by = c(level_1_id = "pathway_id")) %>%
  left_join(., all_pathways, by = "pathway_id") %>%
  select(pathway_id, "pathway_description" = description, level_1) %>%
  distinct(pathway_id, .keep_all = TRUE)

reactome_categories <- enr_pathway_high_level %>%
  left_join(., rename(all_pathways, "level_1" = description), by = c(level_1_id = "pathway_id")) %>%
  left_join(., rename(all_pathways, "level_2" = description), by = c(level_2_id = "pathway_id")) %>%
  left_join(., all_pathways, by = "pathway_id") %>%
  select("id" = pathway_id, description, level_1, level_2) %>%
  distinct(id, .keep_all = TRUE)

usethis::use_data(reactome_categories, overwrite = TRUE)
