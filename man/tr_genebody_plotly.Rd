\name{tr_genebody_plotly}

\alias{tr_genebodyplotly}

\title{
Plot of gene body coverage
}

\description{
Using functions from the QoRTs package to read and plot gene body coverage data for the upper-middle quartile.
}

\usage{
tr_genebody_plotly(qorts_dir)
}

\arguments{
	\item{qorts_dir}{  Directory containing all the QoRTs results, with each sample having its own folder.}
}

\value{
	\item{tr_genebody_plotly}{  Returns a plotly object (html) of the results.}
}

\references{
	None.
}

\seealso{
	\link{https://www.github.com/travis-m-blimkie/tRavis}
}

\examples{
tr_genebody_coverage(qorts_dir = "~/my_data/qorts_results/")
}

\keyword{functions}
