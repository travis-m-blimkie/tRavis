% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tr_anno_cleaner.R
\name{tr_anno_cleaner}
\alias{tr_anno_cleaner}
\title{tr_anno_cleaner}
\usage{
tr_anno_cleaner(input_file)
}
\arguments{
\item{input_file}{Path to the input TSV file.}
}
\value{
A dataframe (tibble) of the cleaned TSV file, containing the
  following columns: locus tag, gene name, description, start, end, and
  strand.
}
\description{
Given an input CSV/TSV annotation file (from \emph{P.
  aeruginosa}), separates and cleans columns, returning a clean and tidy data
  frame. Only returns locus tag, gene name, description, start, end, and
  strand columns. Designed to work with files from
  \href{pseudomonas.com}{PGDB}, and only tested on the latest version (19).
}
\references{
None.
}
\seealso{
\url{https://www.github.com/travis-m-blimkie/tRavis}
}