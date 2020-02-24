#' tr_anno_cleaner
#'
#' @param input_file Path to the input TSV file.
#'
#' @return A dataframe (tibble) of the cleaned TSV file, containing the
#'   following columns: locus tag, gene name, description, start, end, and
#'   strand.
#'
#' @export
#'
#' @import dplyr
#'
#' @description Given an input CSV/TSV annotation file (from \emph{P.
#'   aeruginosa}), separates and cleans columns, returning a clean and tidy data
#'   frame. Only returns locus tag, gene name, description, start, end, and
#'   strand columns. Designed to work with files from
#'   \href{pseudomonas.com}{PGDB}, and only tested on the latest version (19).
#'
#' @references None.
#'
#' @seealso \url{https://www.github.com/travis-m-blimkie/tRavis}
#'
tr_anno_cleaner <- function(input_file) {

  file_type <- stringr::str_extract(input_file, pattern = "(c|t)sv$")

  if (is.na(file_type)) {
    stop("Input must be tab- or comma-delimited file from pseudomonas.com")
  } else if (file_type == "csv") {
    step1 <- readr::read_csv(input_file) %>% janitor::clean_names()
  } else if ( file_type == "tsv") {
    step1 <- readr::read_tsv(input_file) %>% janitor::clean_names()
  }

  # Make extensive use of tidyverse functions to clean the CVS/TSV file
  step2 <- step1 %>%
    select(locus_tag, gene_name, product_name, start, end, strand) %>%
    distinct(locus_tag, .keep_all = TRUE) %>%
    mutate(gene_name = case_when(is.na(gene_name) ~ locus_tag, TRUE ~ gene_name))

  return(step2)
}
