% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tr_tidy_gage.R
\name{tr_tidy_gage}
\alias{tr_tidy_gage}
\title{Coerce Gage output to a tidy data frame}
\usage{
tr_tidy_gage(gage_result, qval = 0.1)
}
\arguments{
\item{gage_result}{A list output from a call to \code{gage::gage}}

\item{qval}{Cutoff for q value, defaults to 0.1}
}
\value{
A data frame (tibble)
}
\description{
This function will simply convert the output from Gage
enrichment into an easier-to-use tibble format. At the same time it can
also filter the result based on q value, with a default of \code{0.1}.
}
\examples{
ex_gage_results <-
  readRDS(system.file("extdata", "ex_gage_results.rds", package = "tRavis"))

tr_tidy_gage(ex_gage_results, qval = 1)

}
\references{
None.
}
\seealso{
\url{https://www.github.com/travis-m-blimkie/tRavis}
}
