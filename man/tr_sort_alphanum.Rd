% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tr_sort_alphanum.R
\name{tr_sort_alphanum}
\alias{tr_sort_alphanum}
\title{Properly sort alphanumeric strings}
\usage{
tr_sort_alphanum(input_df, sort_col)
}
\arguments{
\item{input_df}{Input data frame or tibble to be sorted}

\item{sort_col}{Column to be used in sorting as an index or quoted name}
}
\value{
Sorted data frame
}
\description{
Function to sort a column of alphanumeric strings (e.g. c("a1",
"a11", "a2")) in numeric order (e.g. c("a1", "a2", "a11")). It works with
pipes, and you can provide column name or index as argument \code{sort_col}.
}
\examples{
tr_sort_alphanum(
  input_df = data.frame(
    colA = c("a11", "a1", "b1", "a2"),
    colB = c(3, 1, 4, 2)
  ),
  sort_col = "colA"
)

}
\references{
None.
}
\seealso{
\url{https://www.github.com/travis-m-blimkie/tRavis}
}
