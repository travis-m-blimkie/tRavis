\name{tr_heatmap}

\alias{tr_heatmap}

\title{
  Creates a heatmap of RNASeq data
}

\description{
  Wrapper function which simplifies creating a heatmap with RNASeq data. Takes
  as input a transformed DESeq dataset object resulting from a call to
  DESeq2::DESeq(). Required packages include: \code{pheatmap},
  \code{RColorBrewer}, and \code{tidyverse}.

}

\usage{
  tr_heatmap(x)
}

\arguments{
  \item{x}{A transformed DESeq2 dataset object; the output of a call to
  \code{DESeq2::DESeq()}. Transformation can be done with \code{rlog()} or
  \code{vst()}.}
}

\value{
  Outputs a heatmap created with the \code{pheatmap::pheatmap()} package/function.
}

\references{
  None.
}

\seealso{
  \url{https://www.github.com/travis-m-blimkie/tRavis}
}

\examples{
  tr_heatmap(vsd)
}

\keyword{functions}
