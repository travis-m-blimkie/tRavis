#' Gene Pair Signature (GPS) object for human Reactome data
#'
#' Reactome human pathway data, constructed by `sigora::makeGPS()` and suitable
#' for use in pathway enrichment.
#'
#' @details For more information see sigora's documentation:
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
#' @details For more information see sigora's documentation:
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


#' Human ID mapping from biomaRt
#'
#' @format A tibble with 68005 rows and 3 columns:
#' \describe{
#'   \item{ensembl_gene_id}{Human Ensembl gene IDs}
#'   \item{hgnc_symbol}{Human gene symbols}
#'   \item{entrez_gene_id}{Human NCBI/Entrez gene IDs}
#' }
"biomart_id_mapping_human"


#' Mouse ID mapping from biomaRt
#'
#' @format A tibble with 55414 rows and 3 columns:
#' \describe{
#'   \item{ensembl_gene_id}{Mouse Ensembl gene IDs}
#'   \item{mgi_symbol}{Mouse gene name/symbol}
#'   \item{entrez_gene_id}{Mouse NCBI/Entrez gene IDs}
#' }
"biomart_id_mapping_mouse"
