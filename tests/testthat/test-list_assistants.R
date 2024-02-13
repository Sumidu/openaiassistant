testthat::test_that("List assistants retrieves objects", {
  lst <- list_assistants()

  testthat::expect_type(lst, "list")

})
