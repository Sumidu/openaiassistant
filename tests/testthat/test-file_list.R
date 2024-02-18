test_that("file_list works (mocked)", {

  if(FALSE){
    # reset base paths etc.
    httptest2::capture_requests({
      lst <- file_list()
    })
  }
  httptest2::with_mock_api({
    lst <- file_list()
    expect_type(lst, "list")
  })
})
