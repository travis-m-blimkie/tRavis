#' Clean annotations from pseudomonas.com
#'
#' @param input_file Path to the input TSV or CSV file.
#' @param extra_cols Logical to determine if start, end, and strand columns
#'   should be included. Defaults to `FALSE`.
#' @param fill_names Logical to determine if blank/NA genes names should be
#'   filled in with corresponding locus tag. Defaults to `FALSE`.
#'
#' @return A data frame (tibble) of the cleaned input file
#' @export
#'
#' @import dplyr
#' @importFrom janitor clean_names
#'
#' @description Given an input CSV or TSV annotation file from
#'   <https://pseudomonas.com>, separates and cleans the data, returning a tidy
#'   tibble with the following columns: "locus_tag", "gene_name", and
#'   "product_name". Setting the `extra_cols` argument to `TRUE` will add the
#'   columns "start", "end", and "strand". Enabling `fill_names` will populate
#'   missing gene names with the corresponding locus tag.
#'
#' @references Download annotation files from <https://pseudomonas.com>
#' @seealso <https://www.github.com/travis-m-blimkie/tRavis>
#'
#' @examples
#' link <- system.file(
#'   "extdata/Pseudomonas_aeruginosa_PAO1_107.csv.gz",
#'   package = "tRavis"
#' )
#'
#' tr_anno_cleaner(input_file = link)
#'
tr_anno_cleaner <- function(
    input_file,
    extra_cols = FALSE,
    fill_names = FALSE
) {

  file_type <- gsub(
    pattern = ".*((c|t)sv).*",
    replacement = "\\1",
    x = tolower(input_file)
  )

  stopifnot("'input_file' must be a '.csv' or '.tsv' file" = !is.na(file_type))

  data_init <- read.delim(
    input_file,
    sep = switch(file_type, csv = ",", tsv = "\t")
  ) %>%
    clean_names() %>%
    as_tibble()

  final_cols <- c("locus_tag", "gene_name", "product_name")

  if (extra_cols) {
    final_cols <- append(final_cols, c("start", "end", "strand"))
  }

  data_final <- data_init %>%
    select(all_of(final_cols)) %>%
    distinct(locus_tag, .keep_all = TRUE)

  data_final[data_final == ""] <- NA

  # Conditionally fill blank gene names with corresponding locus tags
  if (fill_names) {
    data_final <- mutate(
      data_final,
      gene_name = if_else(is.na(gene_name), locus_tag, gene_name)
    )
  }

  return(data_final)
}
