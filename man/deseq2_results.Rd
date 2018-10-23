\name{deseq2_results}

\alias{deseq2_results}

\title{
Adds columns and tidys a DESeq2 results object. 
}

\description{
This function adds two columns to the results object: \code{ABSLFC} is the absolute value of the log2FoldChange column. \code{FC} is the fold change, calculated from the log2FoldChange. It also filters the results based on absolute fold change and adjusted p-value.
}

\usage{
deseq2_results(result, pAdj = 0.05, fc = 1.5)
}

\arguments{
	\item{result}{Output from call to DESeq2's \code{results} function. Must have been run with the (\code{tidy = T} argument) option.}
	
	\item{pAdj}{Cutoff for adjusted p-value. Defaults to 0.05}
	
	\item{fc}{Cutoff for the fold change value. Defaults to 1.5}
}

\value{
A dataframe (tibble) of differentially expressed genes, filtered and without rownames.
}

\references{
None. 
}

\seealso{
\link{github.com/travis-m-blimkie/tRavis}
}

\examples{
initial_result <- results(dds, name = "treatment vs. control", tidy = T)

new_result <- deseq2_results(initial_result, pAdj = 0.05, fc = 1.5)
}

\keyword{functions}
