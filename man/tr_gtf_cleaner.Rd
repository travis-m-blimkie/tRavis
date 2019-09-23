\name{tr_gtf_cleaner}

\alias{tr_gtf_cleaner}

\title{
  Parse GTF Files
}

\description{
Given an input GTF file (bacterial), separates and cleans columns, returning a clean and tidy data frame. Only returns locus tag, gene name, description, start, end, and strand columns. Only supports PAO1, PA14, and LESB58. Uses a single regex to match and extract locus tag for all three strains.
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
