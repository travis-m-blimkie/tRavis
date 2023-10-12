#' Human gene ID mapping from biomaRt
#'
#' @return An object of class "tbl_df", "tbl", "data.frame"
#' @format A data frame (tibble) with 75739 rows and 4 columns:
#' \describe{
#'   \item{ensembl_gene_id}{Human Ensembl gene IDs}
#'   \item{hgnc_symbol}{Human gene symbols}
#'   \item{entrez_gene_id}{Human NCBI/Entrez gene IDs}
#'   \item{description}{Description of the gene}
#' }
"biomart_id_mapping_human"

#' Mouse gene ID mapping from biomaRt
#'
#' @return An object of class "tbl_df", "tbl", "data.frame"
#' @format A data frame (tibble) with 57286 rows and 4 columns:
#' \describe{
#'   \item{ensembl_gene_id}{Mouse Ensembl gene IDs}
#'   \item{mgi_symbol}{Mouse gene name/symbol}
#'   \item{entrez_gene_id}{Mouse NCBI/Entrez gene IDs}
#'   \item{description}{Description of the gene}
#' }
"biomart_id_mapping_mouse"

#' Human pathway hierarchy from Reactome
#'
#' @return An object of class "tbl_df", "tbl", "data.frame"
#' @format A data frame (tibble) with 2647 rows and 4 columns:
#' \describe{
#'   \item{id}{Pathway ID}
#'   \item{description}{Pathway name}
#'   \item{level_1}{Top-level parent term}
#'   \item{level_2}{Second-level hierarchy term}
#' }
"reactome_categories_human"

#' Mouse pathway hierarchy from Reactome
#'
#' @return An object of class "tbl_df", "tbl", "data.frame"
#' @format A data frame (tibble) with 1729 rows and 4 columns:
#' \describe{
#'   \item{id}{Pathway ID}
#'   \item{description}{Pathway name}
#'   \item{level_1}{Top-level parent term}
#'   \item{level_2}{Second-level hierarchy term}
#' }
"reactome_categories_mouse"
