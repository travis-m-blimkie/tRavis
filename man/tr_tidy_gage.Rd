\name{tr_tidy_gage}

\alias{tr_tidy_gage}

\title{
  Tidy Gage Output
}

\description{
This function will simply convert the output from Gage enrichment into a easier-to-use format, namely a data frame. At the same time it also filters the result based on q-value, with a default of \code{0.1}. Requires dplyr and tibble package installation.
}

\usage{
tr_tidy_gage(gage_result, qval = 0.1)
}

\arguments{
  \item{gage_result}{Output from call to \code{gage} function.}

    \item{qval}{Cutoff for q-value. Defaults to 0.1}

    }

\value{
A dataframe (tibble) of enriched KEGG pathways, filtered and without rownames (first column contains pathway name/identifier identifier).
}

\references{
None.
}

\seealso{
\link{https://www.github.com/travis-m-blimkie/tRavis}
}

\examples{
new_result <- tr_tidy_gage(gage_result, qval = 0.1)
}

\keyword{functions}
