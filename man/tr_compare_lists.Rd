\name{tr_compare_lists}

\alias{tr_compare_lists}

\title{
  Return Intersect and Unique Elements
}

\description{
  Performs \code{intersect(x, y)}, \code{setdiff(x, y)}, and \code{setdiff(y, x)}.
  Returns these elements in a named list, with names "common", "unique_x", and "unique_y".
}

\usage{
  tr_compare_lists(x, y)
}

\arguments{
  \item{x}{First vector to compare.}

  \item{y}{Second vector to compare.}

}

\value{
  A named list of the common and unique elements of \code{x} and \code{y}.
}

\references{
  None.
}

\seealso{
  \url{https://www.github.com/travis-m-blimkie/tRavis}
}

\examples{
  \code{comparison <- tr_compare_lists(x = c(1, 2, 3, 4, 5), y = c(4, 5, 6, 7, 8))}
}

\keyword{functions}
