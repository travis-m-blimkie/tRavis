\name{tr_test_enrichment}

\alias{tr_test_enrichment}

\title{
  Test enrichment of custom gene set.
}

\description{
Function which perfroms Fisher's Exact test to determine enrichment of a set of genes of interest compared to some list of experimentally derived genes. Assumes \code{alternative = "greater"} in call to \code{fisher.test}(). Requires \code{tidyverse} installation.
}

\usage{
tr_test_enrichment(query_genes, enrichment_set, total_genes)
}

\arguments{
  \item{query_genes}{List of experimentally or otherwise derived genes, in which one wishes
  to test for enrichment.}

	\item{enrichment_set}{Set of genes of interest, such as virulence genes.}

	\item{total_genes}{Total number of genes for the organism/species.}
}

\value{
	\item{}{Produces the same output as if \code{fisher.test}() had been called.}
}

\references{
	None.
}

\seealso{
	\link{https://www.github.com/travis-m-blimkie/tRavis}
}

\examples{
tr_test_enrichment(experimental_genes, virulence_genes, total_genes = 5688)
}

\keyword{functions}
