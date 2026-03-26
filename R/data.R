#' Human gene ID mapping from biomaRt
#'
#' @return An object of class "tbl_df", "tbl", "data.frame"
#' @format A data frame (tibble) with 91703 rows and 3 columns:
#' \describe{
#'   \item{ensembl_gene_id}{Human Ensembl gene IDs}
#'   \item{hgnc_symbol}{Human gene symbols}
#'   \item{entrez_gene_id}{Human NCBI/Entrez gene IDs}
#' }
#' @source <https://bioconductor.org/packages/biomaRt/>
#'
"biomart_id_mapping_human"

#' Mouse gene ID mapping from biomaRt
#'
#' @return An object of class "tbl_df", "tbl", "data.frame"
#' @format A data frame (tibble) with 78873 rows and 3 columns:
#' \describe{
#'   \item{ensembl_gene_id}{Mouse Ensembl gene IDs}
#'   \item{mgi_symbol}{Mouse gene name/symbol}
#'   \item{entrez_gene_id}{Mouse NCBI/Entrez gene IDs}
#' }
#' @source <https://bioconductor.org/packages/biomaRt/>
#'
"biomart_id_mapping_mouse"

#' Human pathway hierarchy from Reactome
#'
#' @return An object of class "tbl_df", "tbl", "data.frame"
#' @format A data frame (tibble) with 2848 rows and 4 columns:
#' \describe{
#'   \item{id}{Pathway ID}
#'   \item{description}{Pathway name}
#'   \item{level_1}{Top-level parent term}
#'   \item{level_2}{Second-level hierarchy term}
#' }
#' @source <https://reactome.org/>
#'
"reactome_categories_human"

#' Mouse pathway hierarchy from Reactome
#'
#' @return An object of class "tbl_df", "tbl", "data.frame"
#' @format A data frame (tibble) with 1822 rows and 4 columns:
#' \describe{
#'   \item{id}{Pathway ID}
#'   \item{description}{Pathway name}
#'   \item{level_1}{Top-level parent term}
#'   \item{level_2}{Second-level hierarchy term}
#' }
#' @source <https://reactome.org/>
#'
"reactome_categories_mouse"
