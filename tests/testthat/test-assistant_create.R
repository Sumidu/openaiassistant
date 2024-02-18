test_that("Creating an assistant works (mock)", {

  fcal <- function(){
    assistant_create(name = "TEST", instructions = "Do nothing", model = "gpt-4-turbo-preview", tool_retrieval = FALSE, tool_code_interpreter = FALSE, file_ids = NULL)
  }

  if(FALSE){
    # record API response
    httptest2::capture_requests({
      assistant <- fcal()
    })
  } else {
    httptest2::with_mock_api({
      assistant <- fcal()
    })
  }


  expect_equal(assistant$name, "TEST")
  expect_equal(assistant$instructions, "Do nothing")
  expect_equal(assistant$model, "gpt-4-turbo-preview")
  expect_equal(assistant$tools, list())
  expect_equal(assistant$file_ids, list())

})
