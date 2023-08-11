#' Wrapper for pathway enrichment with ReactomePA or sigora
#'
#' @param input_genes Character vector of input genes. For ReactomePA, these
#'   should be Entrez IDs; for Sigora, Ensembl IDs are recommended.
#'   Alternatively one can supply a data frame to use in conjunction with the
#'   `directional` argument.
#' @param directional If NULL (the default), `input_genes` is assumed to be a
#'   character vector of gene IDs to be tested as-is. Alternatively, one can
#'   supply a two item character vector of column names, where the first
#'   indicates the column containing gene IDs, and the second indicates a column
#'   containing values to be used to split the genes into up/down. In this case
#'   `input_genes` must be a data frame.
#' @param gene_ratio Logical. Should the output table contain information about
#'   candidate/background genes and gene ratio for each pathway?
#' @param tool Package to use for enrichment tests - either "Sigora" or
#'   "ReactomePA"
#' @param species Currently only supports human (default) or mouse. Needed by
#'   ReactomePA, and also used to add Reactome hierarchy information to the
#'   results (both Sigora and ReactomePA).
#' @param background Specified gene universe for ReactomePA; default is NULL, or
#'   can be a character vector of Entrez gene IDs. Does not apply to `tool =
#'   "sigora"`
#' @param gps_repo Gene pair signature object for Sigora to use, namely `reaH`
#'   or `reaM` from Sigora. See `?sigora::sigora` for details. Does not apply
#'   for `tool = "ReactomePA"`
#' @param lvl Level to use when running Sigora; recommend 4 for Reactome data,
#'   or 2 for KEGG data. Does not apply when `tool = "ReactomePA"`
#'
#' @return Data frame (tibble) of unfiltered results
#' @export
#'
#' @import dplyr
#' @import purrr
#' @import sigora
#' @import tibble
#' @import tidyr
#'
#' @references None.
#'
#' @seealso <https://www.github.com/travis-m-blimkie/tRavis>
#'
tr_enrichment_wrapper <- function(input_genes,
                                  directional = NULL,
                                  gene_ratio = FALSE,
                                  tool,
                                  species = "human",
                                  background = NULL,
                                  gps_repo = NULL,
                                  lvl = NULL) {

  # Basic input checks
  tool <- tolower(tool)
  stopifnot(tool %in% c("reactomepa", "sigora"))

  if (is.null(directional)) {
    stopifnot(is.character(input_genes))
    input_clean <- na.omit(unique(as.character(input_genes)))

  } else {
    stopifnot(is.data.frame(input_genes))

    input_clean <- list(
      "up"   = pull(
        filter(input_genes, .data[[directional[2]]] > 0),
        directional[1]
      ),
      "down" = pull(
        filter(input_genes, .data[[directional[2]]] < 0),
        directional[1]
      )
    ) %>%
      discard(~length(.x) == 0) %>%
      map(~na.omit(unique(as.character(.x))))
  }


  # ReactomePA
  if (tool == "reactomepa") {

    stopifnot(species %in% c("human", "mouse"))

    if (is.null(directional)) {

      stopifnot(!any(str_detect(input_clean, "[[:alpha:]]")))

      message(
        "Testing ", length(input_clean), " genes with ReactomePA..."
      )

      suppressPackageStartupMessages(
        rpa_part1 <- ReactomePA::enrichPathway(
          gene = input_clean,
          organism = species,
          universe = background
        ) %>%
          pluck("result")
      )

    } else {

      stopifnot(!any(str_detect(input_clean[1], "[[:alpha:]]")))
      stopifnot(!any(str_detect(input_clean[2], "[[:alpha:]]")))

      message(
        "Testing ", length(unlist(input_clean)), " total genes with ReactomePA:"
      )

      suppressPackageStartupMessages(
        rpa_part1 <- imap(
          input_clean,
          function(x, nm) {
            message("\t", length(x), " ", nm, "-regulated genes...")

            ReactomePA::enrichPathway(
              gene = x,
              organism = species,
              universe = background
            ) %>%
              pluck("result")
          }
        ) %>% bind_rows(.id = "direction")
      )
    }

    rpa_part2 <- rpa_part1 %>%
      remove_rownames() %>%
      as_tibble() %>%
      janitor::clean_names() %>%
      dplyr::rename("pathway_id" = id, "genes" = gene_id)

    # Optional gene ratio calculation (applies regardless of "directional")
    rpa_part3 <- if (gene_ratio) {
      rpa_part2 %>% mutate(
        n_cd_genes = count,
        n_bg_genes = as.numeric(str_extract(bg_ratio, "^[0-9]{1,4}")),
        gene_ratio = signif(n_cd_genes / n_bg_genes, digits = 2)
      )
    } else {
      rpa_part2
    }

    # Reorder columns (applies regardless of "directional" and "gene_ratio")
    output <- rpa_part3 %>% dplyr::select(
      all_of(c("pathway_id", "description", "pvalue", "p_adjust")),
      any_of(c("direction", "n_cd_genes", "n_bg_genes", "gene_ratio", "genes"))
    )


    # Sigora
  } else if (tool == "sigora") {


    # Check Sigora-specific inputs
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

    sigora_safe <- possibly(sigora, otherwise = NULL)


    if (is.null(directional)) {

      message(
        "Testing ", length(input_clean), " genes with Sigora..."
      )

      if (gene_ratio) { # Non-directional, "gene_ratio = TRUE"

        sigora_part1 <- quiet(sigora_safe(
          queryList = input_clean,
          GPSrepo   = gps_repo,
          level     = lvl
        ))

        sigora_part2 <- sigora_part1$summary_results %>%
          remove_rownames() %>%
          as_tibble() %>%
          janitor::clean_names()

        sigora_detailed_list <- sigora_part1$detailed_results %>%
          as_tibble() %>%
          dplyr::select(pathway, contains("gene")) %>%
          split(x = ., f = .$pathway)

        pathway_cd_data <- imap(sigora_detailed_list, function(x, nm)
          tibble(
            "pathwy_id" = nm,
            "entrez_gene_id" = unique(c(pull(x, gene1), pull(x, gene2)))
          )
        ) %>%
          bind_rows() %>%
          group_by(pathwy_id) %>%
          summarise(cd_genes = paste0(entrez_gene_id, collapse = ";")) %>%
          mutate(n_cd_genes = 1 + str_count(cd_genes, ";"), .after = 1) %>%
          ungroup()

        pathway_bg_data <- sigora_database %>%
          dplyr::select("pathwy_id" = pathway_id, entrez_gene_id) %>%
          filter(pathwy_id %in% pathway_cd_data$pathwy_id) %>%
          group_by(pathwy_id) %>%
          summarise(bg_genes = paste0(entrez_gene_id, collapse = ";")) %>%
          mutate(n_bg_genes = 1 + str_count(bg_genes, ";"), .after = 1) %>%
          ungroup()

        pathway_ratio_data <- left_join(
          pathway_cd_data,
          pathway_bg_data,
          by = "pathwy_id"
        ) %>%
          mutate(gene_ratio = signif(n_cd_genes / n_bg_genes, digits = 2))

        sigora_part3 <- left_join(
          x  = sigora_part2,
          y  = pathway_ratio_data,
          by = "pathwy_id"
        )

      } else if (!gene_ratio) { # Non-directional, "gene_ratio = FALSE"

        sigora_part1 <- quiet(sigora_safe(
          queryList = input_clean,
          GPSrepo   = gps_repo,
          level     = lvl
        ))
        sigora_part3 <- sigora_part1 %>%
          pluck("summary_results") %>%
          as_tibble() %>%
          janitor::clean_names()
      }


    } else { # Directional

      message(
        "Testing ", length(unlist(input_clean)), " total genes with Sigora:"
      )

      if (gene_ratio) { # Directional, "gene_ratio = TRUE"

        sigora_part3 <- imap(
          input_clean,
          function(x, nm) {
            message("\t", length(x), " ", nm, "-regulated genes...")

            sigora_part1 <- quiet(sigora_safe(
              queryList = x,
              GPSrepo   = gps_repo,
              level     = lvl
            ))

            sigora_part2 <- sigora_part1$summary_results %>%
              remove_rownames() %>%
              as_tibble() %>%
              janitor::clean_names()

            sigora_detailed_list <- sigora_part1$detailed_results %>%
              as_tibble() %>%
              dplyr::select(pathway, contains("gene")) %>%
              split(x = ., f = .$pathway)

            pathway_cd_data <- imap(sigora_detailed_list, function(x, nm)
              tibble(
                "pathwy_id" = nm,
                "entrez_gene_id" = unique(c(pull(x, gene1), pull(x, gene2)))
              )
            ) %>%
              bind_rows() %>%
              group_by(pathwy_id) %>%
              summarise(cd_genes = paste0(entrez_gene_id, collapse = ";")) %>%
              mutate(n_cd_genes = 1 + str_count(cd_genes, ";"), .after = 1) %>%
              ungroup()

            pathway_bg_data <- sigora_database %>%
              dplyr::select("pathwy_id" = pathway_id, entrez_gene_id) %>%
              filter(pathwy_id %in% pathway_cd_data$pathwy_id) %>%
              group_by(pathwy_id) %>%
              summarise(bg_genes = paste0(entrez_gene_id, collapse = ";")) %>%
              mutate(n_bg_genes = 1 + str_count(bg_genes, ";"), .after = 1) %>%
              ungroup()

            pathway_ratio_data <- left_join(
              pathway_cd_data,
              pathway_bg_data,
              by = "pathwy_id"
            ) %>%
              mutate(gene_ratio = signif(n_cd_genes / n_bg_genes, digits = 2))

            left_join(
              x  = sigora_part2,
              y  = pathway_ratio_data,
              by = "pathwy_id"
            )
          }
        ) %>% bind_rows(.id = "direction")


      } else if (!gene_ratio) { # Directional, "gene_ratio = FALSE"

        sigora_part3 <- imap(
          input_clean,
          function(x, nm) {

            message("\t", length(x), " ", nm, "-regulated genes...")

            sigora_part1 <- quiet(sigora_safe(
              queryList = x,
              GPSrepo   = gps_repo,
              level     = lvl
            ))

            sigora_part1 %>%
              pluck("summary_results") %>%
              as_tibble() %>%
              janitor::clean_names()
          }) %>% bind_rows(.id = "direction")
      }
    }

    # Tidy any type of Sigora output ("gene_ratio" TRUE or FALSE, directional
    # or not)
    sigora_part4 <- if (!nrow(sigora_part3) == 0) {
      sigora_part3
    } else {
      NULL
    }

    if (!is.null(sigora_part4)) {
      output <- sigora_part4 %>%
        dplyr::rename("pathway_id" = pathwy_id, "pvalue" = pvalues) %>%
        dplyr::select(
          all_of(c("pathway_id", "description", "pvalue", "bonferroni")),
          any_of(c("direction", "n_cd_genes", "n_bg_genes", "gene_ratio",
                   "cd_genes", "bg_genes"))
        )
    } else {
      message("No hits found by Sigora!\n")
      return(NULL)
    }
  }


  # Tool-agnostic: Add species-based Reactome hierarchy info, joining with a
  # lower case version of the "description" column to avoid matching issues
  if (species == "human") {
    output_final <- output %>%
      mutate(description = str_trim(description)) %>%
      left_join(
        x  = mutate(., key_col = tolower(description)),
        y  = mutate(reactome_categories_human,
                    key_col = tolower(description),
                    .keep = "unused"),
        by = c("pathway_id" = "id", "key_col")
      ) %>%
      dplyr::select(-key_col) %>%
      mutate(across(where(is.factor), as.character)) %>%
      relocate(any_of(c("genes", "cd_genes", "bg_genes")), .after = last_col())

  } else if (species == "mouse") {
    output_final <- output %>%
      left_join(
        x  = .,
        y  = reactome_categories_mouse, -description,
        by = c("pathway_id" = "id", "description")
      ) %>%
      mutate(across(where(is.factor), as.character)) %>%
      relocate(any_of(c("genes", "cd_genes", "bg_genes")), .after = last_col())
  }

  # Finished!
  message("Done!\n")
  return(output_final)
}
