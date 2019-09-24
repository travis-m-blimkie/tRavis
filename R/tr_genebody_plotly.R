#' tr_genebody_plotly
#'
#' @param qorts_dir Directory containing all the QoRTs results, with each sample
#'   having its own folder. Directory name should include trailing "/".
#'
#' @return Returns a plotly object (html) of the results.
#'
#' @export
#'
#' @description Using functions from the \code{QoRTs} package to read and plot
#'   gene body coverage data for the upper-middle quartile.
#'
#' @references None.
#'
#' @seealso https://www.github.com/travis-m-blimkie/tRavis
#'
tr_genebody_plotly <- function(qorts_dir) {

  # Get list of samples based on directory names
  sample_ids <- list.dirs(qorts_dir, full.names = FALSE, recursive = FALSE)

  # Read in all the results using QoRTs function
  qorts_results <- QoRTs::read.qc.results.data(infile.dir = qorts_dir,
                                               decoder = sample_ids)


  # Pull out the gene body coverage results
  genebodies <- dplyr::bind_rows(qorts_results@qc.data[["geneBodyCoverage.pct"]],
                                 .id = "SampleName")


  # Plotly of gene body coverage for all samples
  plotly::plot_ly(
    dplyr::group_by(genebodies, SampleName),
    x = ~QUANTILE,
    y = ~X2.upperMidQuartile,
    name = "Upper_Mid_Quartile",
    type = "scatter",
    mode = "lines",
    text = ~SampleName,
    hoverinfo = "text",
    alpha = 0.3,
    line = list(shape = "spline")
  ) %>%
    plotly::layout(
      title = "Gene Body Coverage of the Upper-Middle Quartile",
      xaxis = list(title = "Percentile of Gene Body (5'->3')"),
      yaxis = list(title = "Proportion of Reads")
    )


}
