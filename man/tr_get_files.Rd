\name{tr_get_files}

\alias{tr_get_files}

\title{
  Create named list of files
}

\description{
  Function which creates a named list of files in a specified directory. Names are trimmed versions of file names, contents of the list are the file names themselves. Can be easily piped into \code{purrr::map(~read.csv(.))} to create named list of data frames.
}

\usage{
  tr_get_files(folder, pattern = "", date = FALSE)
}

\arguments{
  \item{folder}{Directory containing files of interest.}

  \item{pattern}{Optional pattern to use in file searching.}

  \item{date}{Do file names contain a date to be removed from names?}

}

\value{
  Named list of files to be read into R
}

\references{
  None.
}

\seealso{
  \url{https://www.github.com/travis-m-blimkie/tRavis}
}

\examples{
  myFiles <- tr_get_files(folder = "Results", pattern = "DE", date = TRUE)
}

\keyword{functions}
