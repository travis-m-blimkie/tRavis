#' Clean annotations from pseudomonas.com
#'
#' @param input_file Path to the input TSV or CSV file.
#' @param extra_cols Logical to determine if start, end, and strand columns
#'   should be included. Defaults to `FALSE`.
#' @param fill_names Logical to determine if blank/NA genes names should be
#'   filled in with corresponding locus tag. Defaults to `FALSE`.
#'
#' @return A data frame (tibble) of the cleaned input file, containing the
#'   following columns: locus tag, gene name, description, start, end, and
#'   strand.
#'
#' @export
#'
#' @import dplyr
#' @import readr
#'
#' @description Given an input CSV or TSV annotation file (from *P.
#'   aeruginosa*), separates and cleans columns, returning a clean and tidy data
#'   frame. Only returns locus tag, gene name, description, start, end, and
#'   strand columns. Designed to work with files from
#'   [PGDB](pseudomonas.com), and only tested on the latest version (19).
#'
#' @references None.
#'
#' @seealso <https://www.github.com/travis-m-blimkie/tRavis>
#'
#' @examples
#' \dontrun{
#'   tr_anno_cleaner(
#'     "Downloads/Pseudomonas_aeruginosa_PAO1_107.tsv",
#'     extra_cols = FALSE,
#'     fill_names = FALSE
#'   )
#' }
#'
tr_anno_cleaner <- function(
    input_file,
    extra_cols = FALSE,
    fill_names = FALSE
) {

  file_type <- stringr::str_extract(input_file, pattern = "(c|t)sv$")

  if (is.na(file_type)) {
    stop("Input must be a tab- or comma-delimited file from pseudomonas.com")

  } else if (file_type == "csv") {
    step1 <- read_csv(input_file, col_types = cols()) %>% janitor::clean_names()

  } else if (file_type == "tsv") {
    step1 <- read_tsv(input_file, col_types = cols()) %>% janitor::clean_names()
  }

  # Use tidyverse functions to clean the input file
  step2 <- step1 %>%
    select(
      locus_tag,
      gene_name,
      "product_description" = product_name,
      start,
      end,
      strand
    ) %>%
    distinct(locus_tag, .keep_all = TRUE)

  # Conditionally choose columns based on user's choice
  if (extra_cols) {
    step3 <- step2
  } else {
    step3 <- step2 %>%
      select(locus_tag, gene_name, product_description)
  }


  # Conditionally fill blank gene names with corresponding locus tags
  if (fill_names) {
    step4 <- step3 %>%
      mutate(
        gene_name = case_when(is.na(gene_name) ~ locus_tag, TRUE ~ gene_name)
      )
  } else {
    step4 <- step3
  }

  return(step4)
}
