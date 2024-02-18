test_that("Deleting an assistant works (mock)", {

  fcal <- function(){
    assistant_id <- "asst_abc"
    assistant_delete(assistant_id)
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

  expect_equal(resp$object, "assistant.deleted")
  expect_true(resp$deleted)
})
