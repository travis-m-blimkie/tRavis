
# tRavis::tr_heatmap() ----------------------------------------------------

tr_heatmap <- function(x) {

  require(tidyverse)
  require(pheatmap)
  require(RColorBrewer)


  heatmap_colour <- rev(colorRampPalette(brewer.pal(9, "Spectral"))(100))

  heatmap_matrix <- assay(x) %>%
    t() %>%
    dist() %>%
    as.matrix()

  rownames(heatmap_matrix) <- colnames(heatmap_matrix)


  pheatmap(heatmap_matrix,
           color = heatmap_colour,
           border_color = NA)

}
