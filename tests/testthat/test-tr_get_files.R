context("Get files")
library(tRavis)

# Note that when running this these tests with "CTRL+SHIFT+T", the working
# directory is the directory in which the test files reside (tests/testthat).
# Hence we need to set the paths relative to that directory.

correct_list <- list(
  file1 = "../../data/testdata_getfiles/test_file1_20191231.csv",
  file2 = "../../data/testdata_getfiles/test_file2_20200101.csv"
)


test_that("Basic functionality", {
  expect_equal(
    correct_list,
    tr_get_files("../../data/testdata_getfiles", date = TRUE, removeString = "test_")
  )
})
