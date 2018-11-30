
# tr_tidy_gage ------------------------------------------------------------

#' Takes a results object from Gage and munges it into a tidy data frame
#' Also filters based on q-value, with a default of 0.1 from the Gage
#' documentation.


tr_tidy_gage <- function(gage_result, qval = 0.1) {

  require(dplyr, tibble)

  bind_rows(
    list(
    Up = as.data.frame(gage_result[["greater"]]) %>% rownames_to_column(),
    Down = as.data.frame(gage_result[["less"]]) %>% rownames_to_column()
    ),
    .id = "Direction") %>% filter(., q.val < qval)

}

