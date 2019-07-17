
# tr_gtf_cleaner -------------------------------------------------------------

# Given an input GTF file (bacterial), separates and cleans columns, returning a
# clean and tidy data frame. Only returns locus tag, gene name, description,
# start, end, and strand columns. Only supports PAO1, PA14, and LESB58. Uses
# a single regex to match and extract locus tag for all three strains.


tr_gtf_cleaner <- function(gtf_file) {

  require(tidyverse)

  gtf_cols = c("seqname", "source", "feature", "start", "end", "score", "strand", "frame", "attribute")
  gtf <- read_tsv(gtf_file, col_names = gtf_cols)


  clean_gtf <- gtf %>%
    filter(feature == "CDS") %>%
    separate(attribute, into = c("gene_id", "transcript_id", "locus_tag", "name", "ref"), sep = ";") %>%
    select(locus_tag, name, start, end, strand) %>%
    mutate(locus_tag = str_extract(locus_tag, pattern = "PA(14|LES)?_?[0-9]{4,5}"),
           name = str_replace(name, pattern = ' name "(.*)"', replacement = "\\1")) %>%
    separate(name, into = c("name", "description"), sep = " ,", fill = "left")


  return(clean_gtf)

}
