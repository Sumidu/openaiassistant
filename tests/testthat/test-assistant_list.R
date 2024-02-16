testthat::test_that("List assistants retrieves objects", {
  lst <- assistant_list()

  testthat::expect_type(lst, "list")

})
