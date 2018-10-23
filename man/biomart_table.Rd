\name{biomart_table}

\alias{biomart_table}

\title{
Pulls ID conversions from BioMart
}

\description{
This function pulls human gene names from BioMart to facilitate conversion. 
Currently includes Ensembl, Entrez, and HGNC. 
}

\usage{
biomart_table()
}

\arguments{
	\item{None}{  Currenly supports no direct arguments.}
}

\value{
	\item{biomart_table}{   A dataframe listing different ID types for human genes.}
}

\references{
	None. 
}

\seealso{
	\link{github.com/travis-m-blimkie/tRavis}
}

\examples{
conversion_table <- biomart_table()
}

\keyword{functions}
