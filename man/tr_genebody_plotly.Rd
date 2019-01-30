\name{tr_genebody_plotly}

\alias{tr_genebodyplotly}

\title{
Create plotl of Gene Body Coverage
}

\description{
Using functions from the QoRTs package to read in gene body coverage data,
and plot upper-middle quartile gene body coverage.
}

\usage{
tr_genebody_plotly(qorts_dir)
}

\arguments{
	\item{qorts_dir}{  Directory containing all the QoRTs results, with each sample having its own folder.}
}

\value{
	\item{tr_genebody_plotly}{   Returns a plotly object (html) of the results.}
}

\references{
	None.
}

\seealso{
	\link{github.com/travis-m-blimkie/tRavis}
}

\examples{
tr_genebody_coverage(qorts_dir = "~/my_data/qorts_results")
}

\keyword{functions}
