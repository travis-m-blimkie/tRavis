#' Wrapper for pathway enrichment with ReactomePA or sigora
#'
#' @param tool Package to use for enrichment tests - either "ReactomePA" or
#'   "Sigora"
#' @param input_genes Character vector of input genes. For ReactomePA, these
#'   should be Entrez IDs; for Sigora, Ensembl IDs are recommended.
#' @param species Desired species for ReactomePA, either "human" (default) or
#'   "mouse". Does not apply to `tool = "sigora"`.
#' @param background Specified gene universe for ReactomePA; default is NULL, or
#'   can be a character vector of Entrez gene IDs. Does not apply to `tool =
#'   "sigora"`
#' @param gps_repo Gene pair signature object for Sigora to use. Can be one of
#'   the data objects shipped with this package (`gps_rea_hsa` or `gps_rea_mmu`
#'   for Reactome data for human and mouse, respectively), or one from Sigora
#'   itself - see `?sigora::sigora` for details. Does not apply for `tool =
#'   "ReactomePA"`
#' @param lvl Level to use when running Sigora; recommend 4 for Reactome data,
#'   or 2 for KEGG data. Does not apply for `tool = "ReactomePA"`
#' @param gene_ratio Logical. Should the output table contain information about
#'   candidate/background genes and gene ratio for each pathway? Note if using
#'   this option with Sigora, enrichment will take noticeably longer to run.
#'
#' @return Data frame (tibble) of results
#' @export
#'
#' @import ReactomePA
#' @import sigora
#' @import tibble
#' @import purrr
#' @import dplyr
#'
#' @references None.
#'
#' @seealso <https://www.github.com/travis-m-blimkie/tRavis>
#'
tr_enrichment_wrapper <- function(input_genes,
                                  tool,
                                  species = "human",
                                  background = NULL,
                                  gps_repo = NULL,
                                  lvl = NULL,
                                  gene_ratio = FALSE) {


  # Basic input checks
  stopifnot(is.character(input_genes))
  input_clean <- na.omit(unique(input_genes))
  tool <- tolower(tool)




  # ReactomePA
  if (tool == "reactomepa") {

    message(
      glue::glue("Testing {length(input_clean)} genes with ReactomePA..."),
      appendLF = FALSE
    )

    suppressPackageStartupMessages(
      rpa_part1 <- enrichPathway(
        gene = input_clean,
        organism = species,
        universe = background
      ) %>%
        pluck("result") %>%
        remove_rownames() %>%
        as_tibble() %>%
        janitor::clean_names() %>%
        dplyr::rename("pathway_id" = id, "genes" = gene_id)
    )


    ## Optional gene ratio calculation
    if (gene_ratio) {
      rpa_part1 <- rpa_part1 %>%
        mutate(
          n_cd_genes = count,
          n_bg_genes = as.numeric(str_extract(bg_ratio, "^[0-9]{1,4}")),
          gene_ratio = signif(n_cd_genes / n_bg_genes, digits = 2)
        )
    }


    ## Reorder columns
    output <- rpa_part1 %>%
      dplyr::select(
        all_of(c("pathway_id", "description", "pvalue", "p_adjust")),
        any_of(c("n_cd_genes", "n_bg_genes", "genes"))
      )



  # Sigora
  } else if (tool == "sigora") {


    ## Check Sigora-specific inputs
    if (is.null(gps_repo)) {
      stop(
        "When running Sigora, you must provide a GPS object. ",
        "See '?tr_enrichment_wrapper' for more information"
      )
    }

    if (is.null(lvl)) {
      stop(
        "When running Sigora, you must provide the 'lvl' argument. ",
        "See '?tr_enrichment_wrapper' for more information"
      )
    }

    quiet <- function(...) {
      sink(tempfile())
      on.exit(sink())
      eval(...)
    }

    message(
      glue::glue("Testing {length(input_clean)} genes with Sigora..."),
      appendLF = FALSE
    )


    ## Code for "gene_ratio = TRUE"
    if (gene_ratio) {

      sigora_temp_file <- tempfile(
        pattern = "sigora_temp_",
        tmpdir  = ".",
        fileext = ".tsv"
      )

      pathway_sizes <-
        gps_repo[str_subset(names(gps_repo), "^L[0-9]")] %>%
        map(~pluck(.x, "pwyszs") %>% enframe("pathwy_id", "n_bg_genes")) %>%
        bind_rows() %>%
        distinct() %>%
        mutate(n_bg_genes = as.numeric(n_bg_genes))

      sigora_part1 <- quiet(sigora(
        queryList = input_clean,
        GPSrepo   = gps_repo,
        level     = lvl,
        saveFile  = sigora_temp_file
      ))

      sigora_part2 <- read.delim(sigora_temp_file) %>%
        remove_rownames() %>%
        as_tibble() %>%
        janitor::clean_names()

      file.remove(sigora_temp_file)

      sigora_part3 <- left_join(
        x  = sigora_part2,
        y  = pathway_sizes,
        by = "pathwy_id"
      ) %>%
        mutate(
          n_cd_genes = str_count(genes, ";") + 1,
          gene_ratio = as.numeric(signif(n_cd_genes / n_bg_genes, digits = 2))
        )


    ## Code for "gene_ratio = FALSE"
    } else if (!gene_ratio) {

      sigora_part1 <- quiet(sigora(
        queryList = input_clean,
        GPSrepo   = gps_repo,
        level     = lvl
      ))

      sigora_part3 <- sigora_part1 %>%
        pluck("summary_results") %>%
        as_tibble() %>%
        janitor::clean_names()
    }


    ## Tidy both types of Sigora output
    output <- sigora_part3 %>%
      rename("pathway_id" = pathwy_id, "pvalue" = pvalues) %>%
      dplyr::select(
        all_of(c("pathway_id", "description", "pvalue", "bonferroni")),
        any_of(c("n_cd_genes", "n_bg_genes", "gene_ratio", "genes"))
      )


  } else {
    stop("Argument 'tool' must be one of 'ReactomePA' or 'Sigora'")
  }


  # Add hierarchy info
  if (species == "human") {
    output_final <- output %>%
      left_join(
        x  = .,
        y  = reactome_categories_human,
        by = c("pathway_id" = "id", "description")
      ) %>%
      mutate(across(where(is.factor), as.character)) %>%
      relocate(any_of("genes"), .after = last_col())

  } else if (species == "mouse") {
    output_final <- output %>%
      left_join(
        x  = .,
        y  = reactome_categories_mouse, -description,
        by = c("pathway_id" = "id", "description")
      ) %>%
      mutate(across(where(is.factor), as.character)) %>%
      relocate(any_of("genes"), .after = last_col())
  }


  # Finished!
  message("Done!")
  return(output_final)
}
