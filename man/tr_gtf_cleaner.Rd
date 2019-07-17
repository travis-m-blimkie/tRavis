\name{tr_gtf_cleaner}

\alias{tr_gtf_cleaner}

\title{
  Parse GTF Files
}

\description{
Function which takes a raw GTF file as input, and returns a clean data frame containing locus tag, gene name, description, start, end, and strand. Currently supports only PAO1, PA14, and LESB58 strains of \emph{Pseudomonas aeruginosa}.
}

\usage{
tr_gtf_cleaner(gtf_file)
}

\arguments{
  \item{gtf_file}{Path to the input GTF file.}

    }

\value{
A dataframe (tibble) of the cleaned GTF file, containing the following columns: locus tag, gene name, description, start, end, and strand.
}

\references{
None.
}

\seealso{
\url{https://www.github.com/travis-m-blimkie/tRavis}
}

\examples{
tidy_gtf <- tr_gtf_cleaner("Pseudomonas_aeruginosa_PAO1_107.gtf")
}

\keyword{functions}
