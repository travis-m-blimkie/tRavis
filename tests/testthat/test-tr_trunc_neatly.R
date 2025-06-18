test_that("string truncation works", {
  expect_equal(
    tr_trunc_neatly("This is a test string", l = 17),
    "This is a test..."
  )
})

test_that("we can handle factors", {
  expect_no_error(
    tr_trunc_neatly(as.factor("This is a test string"), l = 17)
  )
})
