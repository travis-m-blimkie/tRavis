\name{tr_de_results}

\alias{tr_de_results}

\title{
Runs \code{DESeq2::results()} with provided contrast
}

\description{
This function runs \code{DESeq2::results()} with the contrast as specified by the user. Adds columns, and filters the result based on user-provided cutoffs for adjusted p-value and fold change.
}

\usage{
tr_de_results(dds_obj, col_name, numerator, denominator, pAdj = 0.05, fc = 1.5)
}

\arguments{
	\item{dds_obj}{A DESEq2 dataset object as produced by running \code{DESeq2::DESeq().}}

	\item{col_name}{The name of the column/variable being analyzed, e.g. "Treatment" or "Genotype".}

	\item{numerator}{The first argument used as the experimental condition in the DE comparison, e.g. "Treated", or "Mutant".}

	\item{denominator}{The baseline or control condition used in the DE comparison, e.g. "Control" or "Untreated".}

	\item{pAdj}{Cutoff for adjusted p-value. Defaults to 0.05}

	\item{fc}{Cutoff for the fold change value. Defaults to 1.5}
}

\value{
A dataframe (tibble) of differentially expressed genes, filtered and without rownames (first column contains gene identifier).
}

\references{
None.
}

\seealso{
\url{https://www.github.com/travis-m-blimkie/tRavis}
}

\examples{

}

\keyword{functions}
