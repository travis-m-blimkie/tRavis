#' tr_anno_cleaner
#'
#' @param tsv_file Path to the input TSV file.
#'
#' @return A dataframe (tibble) of the cleaned TSV file, containing the
#'   following columns: locus tag, gene name, description, start, end, and
#'   strand.
#'
#' @export
#'
#' @import dplyr
#' @import tidyr
#' @import stringr
#'
#' @description Given an input TSV file (\emph{P. aeruginosa}), separates and
#'   cleans columns, returning a clean and tidy data frame. Only returns locus
#'   tag, gene name, description, start, end, and strand columns. Only supports
#'   PAO1, PA14, and LESB58. Uses a single regex to match and extract locus tag
#'   for all three strains. Will work only with TSV files from
#'   \href{pseudomonas.com}{PGDB}, and only tested on the latest version (19).
#'
#' @references None.
#'
#' @seealso \url{https://www.github.com/travis-m-blimkie/tRavis}
#'
tr_anno_cleaner <- function(tsv_file) {
  step1 <- readr::read_tsv(tsv_file) %>%
    janitor::clean_names()

  # Make extensive use of tidyverse functions to clean the GTF file. Uses the
  # single regex to match IDs from all three strains in one go
  step2 <- step1 %>%
    select(locus_tag, gene_name, product_name, start, end, strand) %>%
    distinct(locus_tag, .keep_all = TRUE) %>%
    mutate(gene_name = case_when(is.na(gene_name) ~ locus_tag, TRUE ~ gene_name))

  return(step2)
}
