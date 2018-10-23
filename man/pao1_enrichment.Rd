\name{pao1_enrichment}

\alias{pao1_enrichment}

\title{
  Enrichment of custom gene set.
}

\description{
Function which perfroms Fisher's Exact test to determine enrichment of a set of genes of interest compared to some list of experimentally derived genes. Assumes \code{alternative = "greater"} in call to \code{fisher.test}(). Requires \code{tidyverse} installation.
}

\usage{
pao1_enrichment(query_genes, enrichment_set)
}

\arguments{
  \item{query_genes}{List of experimentally or otherwise derived genes, in which one wishes
  to test for enrichment.}
	
	\item{enrichment_set}{Set of genes of interest, such as virulence genes.}
}

\value{
	\item{}{Produces the output the same as if \code{fisher.test}() had been called.}
}

\references{
	None. 
}

\seealso{
	\link{github.com/travis-m-blimkie/tRavis}
}

\examples{
pao1_enrichment(experimental_genes, virulence_genes)
}

\keyword{functions}
