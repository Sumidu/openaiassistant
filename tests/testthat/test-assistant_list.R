testthat::test_that("List assistants retrieves objects", {

  fcal <- function(){
    assistant_list()
  }

  if(FALSE){
    # record API response after assistant create and use ID
    httptest2::capture_requests({
      resp <- fcal()

    })
  } else {
    httptest2::with_mock_api({
      resp <- fcal()
    })
  }


  lst <- resp

  testthat::expect_type(lst, "list")

})
