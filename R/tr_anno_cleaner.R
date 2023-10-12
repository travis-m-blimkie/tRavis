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
#' tr_anno_cleaner(
#'   input_file = paste0(
#'   "https://pseudomonas.com/downloads/pseudomonas/pgd_r_22_1/",
#'   "Pseudomonas_aeruginosa_PAO1_107/Pseudomonas_aeruginosa_PAO1_107.csv.gz"
#'   )
#' )
#'
tr_anno_cleaner <- function(
    input_file,
    extra_cols = FALSE,
    fill_names = FALSE
) {

  file_type <- stringr::str_extract(input_file, pattern = "\\.(c|t)sv")

  stopifnot("'input_file' must be a '.csv' or '.tsv' file" = !is.na(file_type))

  step1 <- read_delim(
    input_file,
    delim = switch(file_type, csv = ",", tsv = "\t"),
    col_types = cols()
  ) %>%
    janitor::clean_names()

  if (!extra_cols) {
    final_cols <- c("locus_tag", "gene_name", "product_name")
  } else {
    final_cols <-
      c("locus_tag", "gene_name", "product_name", "start", "end", "strand")
  }

  step2 <- step1 %>%
    select(all_of(final_cols)) %>%
    distinct(locus_tag, .keep_all = TRUE)

  # Conditionally fill blank gene names with corresponding locus tags
  step3 <- step2

  if (fill_names) {
    step3 <- mutate(
      step3,
      gene_name = if_else(is.na(gene_name), locus_tag, gene_name)
    )
  }

  return(step3)
}
