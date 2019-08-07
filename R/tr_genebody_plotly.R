
# Function to read in QoRTs results and make a combined plotly of gene body
# results for all samples


tr_genebody_plotly <- function(qorts_dir) {


  # Load libraries ----------------------------------------------------------

  library(QoRTs)
  library(dplyr)
  library(plotly)


  # Get sample names based on directory names -------------------------------

  sample_ids <- list.dirs(qorts_dir, full.names = F, recursive = F)



  # Read in all the results using QoRTs function ----------------------------

  qorts_results <- read.qc.results.data(infile.dir = qorts_dir, decoder = sample_ids)


  # Pull out the gene body coverage results ---------------------------------

  genebodies <- bind_rows(qorts_results@qc.data[["geneBodyCoverage.pct"]],
                          .id = "SampleName")


  # Plotly of gene body coverage for all samples ----------------------------

  plot_ly(
  	group_by(genebodies, SampleName),
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
