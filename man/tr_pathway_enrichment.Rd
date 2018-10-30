\name{tr_pathway_enrichment}

\alias{tr_pathway_enrichment}

\title{
  Test for enriched pathways
}

\description{
  Performs Fisher's Exact Test for a list of genes of interest to determine enrichment of pathways. Supports three Pseudomonas strains: PA01, PA14, or LESB58. Allows filtering of pathways based on source (e.g. KEGG), as well as specification of desired p-value threshold. Requires \strong{\code{tidyverse}} installation.
}

\usage{
tr_pathway_enrichment(GOI, pval = 0.05, strain = "", db_source = "all")
}

\arguments{
  \item{GOI}{List of genes to be tested for enriched GO terms. Must be provided as a character vector.}

	\item{pval}{Desired significance threshold. Defaults to \code{0.05}}

	\item{strain}{Desired strain for analysis. Currently supports three: "PAO1", "PA14", or "LESB58".}

	\item{db_source}{Character or character vector of database source to be tested against. Defaults to "all". Can be any one or more of "KEGG", add more here.}
}

\value{
A data frame (tibble) of enriched pathways, along with additional information and associated p-value.
}

\references{
	None.
}

\seealso{
	\link{github.com/travis-m-blimkie/tRavis}
}

\examples{
tr_pathway_enrichment(GOI = genes, pval = 0.01, strain = "PAO1", db_source = "KEGG")
}

\keyword{functions}
