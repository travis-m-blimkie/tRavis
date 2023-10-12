test_that("we can list files properly", {

  retrieved_files <- tr_get_files(
    folder = test_path("fixtures"),
    pattern = "^test",
    remove_string = "test_",
    date = TRUE
  )

  expect_length(retrieved_files, 2)

  expect_named(retrieved_files, c("file1", "file2"))
})
