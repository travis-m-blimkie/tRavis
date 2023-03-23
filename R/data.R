#' Human ID mapping from biomaRt
#'
#' @format A tibble with 75123 rows and 4 columns:
#' \describe{
#'   \item{ensembl_gene_id}{Human Ensembl gene IDs}
#'   \item{hgnc_symbol}{Human gene symbols}
#'   \item{entrez_gene_id}{Human NCBI/Entrez gene IDs}
#'   \item{description}{Description of the gene}
#' }
"biomart_id_mapping_human"


#' Mouse ID mapping from biomaRt
#'
#' @format A tibble with 57298 rows and 4 columns:
#' \describe{
#'   \item{ensembl_gene_id}{Mouse Ensembl gene IDs}
#'   \item{mgi_symbol}{Mouse gene name/symbol}
#'   \item{entrez_gene_id}{Mouse NCBI/Entrez gene IDs}
#'   \item{description}{Description of the gene}
#' }
"biomart_id_mapping_mouse"


#' Gene Pair Signature (GPS) object for human Reactome data
#'
#' Reactome human pathway data, constructed by `sigora::makeGPS()` and suitable
#' for use in pathway enrichment.
#'
#' @details For more information see Sigora's documentation:
#'   <https://cran.r-project.org/package=sigora>
#'
#' @format A list with nine elements:
#' \describe{
#'   \item{origRepo}{A list cotaining the original data input to `makeGPS`}
#'   \item{L1}{Level 1 gene pair signatures}
#'   \item{L2}{Level 2 gene pair signatures}
#'   \item{L3}{Level 3 gene pair signatures}
#'   \item{L4}{Level 4 gene pair signatures}
#'   \item{L5}{Level 5 gene pair signatures}
#'   \item{repoName}{Name of the repository used to make the GPS object}
#'   \item{pathwaydescriptions}{A data frame of pathway names and IDs}
#'   \item{call}{The call to `makeGPS`}
#' }
"gps_rea_hsa"


#' Gene Pair Signature (GPS) object for mouse Reactome data
#'
#' Reactome mouse pathway data, constructed by `sigora::makeGPS()` and suitable
#' for use in pathway enrichment.
#'
#' @details For more information see Sigora's documentation:
#'   <https://cran.r-project.org/package=sigora>
#'
#' @format A list with nine elements:
#' \describe{
#'   \item{origRepo}{A list cotaining the original data input to `makeGPS`}
#'   \item{L1}{Level 1 gene pair signatures}
#'   \item{L2}{Level 2 gene pair signatures}
#'   \item{L3}{Level 3 gene pair signatures}
#'   \item{L4}{Level 4 gene pair signatures}
#'   \item{L5}{Level 5 gene pair signatures}
#'   \item{repoName}{Name of the repository used to make the GPS object}
#'   \item{pathwaydescriptions}{A data frame of pathway names and IDs}
#'   \item{call}{The call to `makeGPS`}
#' }
"gps_rea_mmu"


#' Human pathway hierarchy from Reactome
#'
#' Reactome pathway hierarchy data for humans
#'
#' @format A data frame (tibble) with 2610 rows and 4 columns
#' \describe{
#'   \item{id}{Pathway ID}
#'   \item{description}{Pathway name}
#'   \item{level_1}{Top-level parent term}
#'   \item{level_2}{Second-level hierarchy term}
#' }
"reactome_categories_human"


#' Mouse pathway hierarchy from Reactome
#'
#' Reactome pathway hierarchy data for mice
#'
#' @format A data frame (tibble) with 1717 rows and 4 columns
#' \describe{
#'   \item{id}{Pathway ID}
#'   \item{description}{Pathway name}
#'   \item{level_1}{Top-level parent term}
#'   \item{level_2}{Second-level hierarchy term}
#' }
"reactome_categories_mouse"


#' Sigora's database
#'
#' Table of Reactome pathways and their genes used by Sigora for enrichment
#'
#' @format A data frame (tibble) with 60775 rows and 4 columns
#' \describe{
#'   \item{pathway_id}{Pathway ID}
#'   \item{ensembl_gene_id}{Ensembl ID for constituent genes}
#'   \item{hgnc_symbol}{HGNC symbol for constituent genes}
#'   \item{description}{Pathway name}
#' }
"sigora_database"
