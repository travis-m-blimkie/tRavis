\name{pao1_go_enrichment}

\alias{pao1_go_enrichment}

\title{
  Test for enriched GO terms.
}

\description{
Performs Fisher's Exact Test for a list of genes of interest to determine enrichment of GO terms. 
Allows filtering of GO terms based on class (e.g. Biological Process), as well as specification of desired p-value threshold. Requires \strong{\code{tidyverse}} installation.
}

\usage{
pao1_go_enrichment(GOI, pval = 0.05, GO_class = "all")
}

\arguments{
  \item{GOI}{List of genes to be tested for enriched GO terms. Must be provided as a character vector.}
	
	\item{enrichment_set}{Desired significance threshold. Defaults to \code{0.05}}
	
	\item{GO_class}{Character or character vector of GO class to be tested against. Defaults to "all" for all classes. Can be any one or more of "CC" for Cellular Component, "BP" for Biological Process, or "MF" for Molecular Function.}
}

\value{
A data frame (tibble) of enriched GO terms, along with additional information and associated p-value.
}

\references{
	None. 
}

\seealso{
	\link{github.com/travis-m-blimkie/tRavis}
}

\examples{
pao1_go_enrichment(GOI = genes, pval = 0.01, GO_class = c("CC", "MF"))
}

\keyword{functions}
