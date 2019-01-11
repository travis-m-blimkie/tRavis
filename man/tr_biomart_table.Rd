\name{tr_biomart_table}

\alias{tr_biomart_table}

\title{
Pulls ID conversions from BioMart
}

\description{
This function pulls human gene names from BioMart to facilitate conversion.
Currently includes Ensembl, Entrez, and HGNC.
}

\usage{
tr_biomart_table()
}

\arguments{
	\item{None}{  Currenly supports no direct arguments.}
}

\value{
	\item{tr_biomart_table}{   A dataframe listing different ID types for human genes.}
}

\references{
	None.
}

\seealso{
	\link{github.com/travis-m-blimkie/tRavis}
}

\examples{
conversion_table <- tr_biomart_table()
}

\keyword{functions}
