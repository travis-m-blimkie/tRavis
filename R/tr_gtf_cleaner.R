#' tr_gtf_cleaner
#'
#' @param gtf_file Path to the input GTF file
#'
#' @return A dataframe (tibble) of the cleaned GTF file, containing the
#'   following columns: locus tag, gene name, description, start, end, and
#'   strand.
#'
#' @export
#'
#' @description Given an input GTF file (bacterial), separates and cleans
#'   columns, returning a clean and tidy data frame. Only returns locus tag,
#'   gene name, description, start, end, and strand columns. Only supports PAO1,
#'   PA14, and LESB58. Uses a single regex to match and extract locus tag for
#'   all three strains.
#'
#' @references None.
#'
#' @seealso https://www.github.com/travis-m-blimkie/tRavis
#'
tr_gtf_cleaner <- function(gtf_file) {

  # Require the tidyverse
  requireNamespace(tidyverse)


  gtf_cols = c("seqname", "source", "feature", "start", "end",
               "score", "strand", "frame", "attribute")

  gtf <- read_tsv(gtf_file, col_names = gtf_cols)

  # Make extensive use of tidyverse functions to clean the GTF file. Uses the
  # single regex to match IDs from all three strains in one go
  clean_gtf <- gtf %>%
    filter(feature == "CDS") %>%
    separate(attribute, into = c("gene_id", "transcript_id", "locus_tag", "name", "ref"), sep = ";") %>%
    select(locus_tag, name, start, end, strand) %>%
    mutate(locus_tag = str_extract(locus_tag, pattern = "PA(14|LES)?_?[0-9]{4,5}"),
           name = str_replace(name, pattern = ' name "(.*)"', replacement = "\\1")) %>%
    separate(name, into = c("name", "description"), sep = " ,", fill = "left") %>%
    mutate(name = case_when(is.na(name) ~ locus_tag, TRUE ~ name))

  return(clean_gtf)
}
