testthat::test_that("manual test", {

  library(openaiassistant)
  testthat::skip("This is a manual test")

  # generate a new assistant ----
  check_token()
  assistant_name <- "API Test Assistant"
  instructions <- "This is a test assistant for an API test. It should reply with very short answers."
  assistant <- assistant_create(assistant_name, instructions, model = "gpt-4-turbo-preview",
                                tool_retrieval = TRUE, tool_code_interpreter = FALSE)

  # find the assistant using list ----
  res <- assistant_list()
  # find the matching ID
  assistant_id <- res$data |>
    dplyr::select("id", "name") |>
    dplyr::filter(stringr::str_equal(name, assistant_name)) |>
    dplyr::pull(id)

  testthat::expect_equal(assistant$id, assistant_id)

  # reload the assistant using the ID ----
  load_assistant <- assistant_retrieve(assistant_id)
  testthat::expect_equal(assistant$id, load_assistant$id)

  # upload a file to the assistant ----
  file <- file_upload(here::here("tests", "testthat", "test_resources", "demofile.txt"))

  # add file to assistant
  assistant <- assistant_file_create(assistant, file$id)



  # new thread?
  thread <- thread_create()
  question <- "What is the name of the agent?"
  msg <- thread_add_message(thread, paste("Please answer only using the name:",question))


  run <- assistant_run(assistant, thread)
  {
    while(run$status != "completed"){
      run <- run_retrieve(run, thread)
      run$status
      Sys.sleep(5)
      cat("*")
    }
    beepr::beep(4)
  }
  # emergency retrieve
  # thread <- thread_retrieve("thread_9Sd4pM34p6a3YzwgPulfxe5t")
  msgs <- thread_retrieve_messages(thread)

  reply <- get_last_message(msgs)
  testthat::expect_equal(reply, "Tom Hilbindsly")

  # delete thread
  res <- thread_delete(thread$id)
  testthat::expect_equal(res$deleted, TRUE)

  testthat::expect_error(  thread_retrieve(thread$id) )


  files <- file_list()
  if(!file$id %in% files$data$id){
    # file exists
    testthat::fail("File was not listed")
  }

  # delete our file
  res <- file_delete(file$id)
  testthat::expect_equal(res$deleted, TRUE)

  files <- file_list()
  if(file$id %in% files$data$id){
    # file exists
    testthat::fail("File was not deleted")
  }


  # remove the test assistant
  res <- assistant_delete(assistant_id)
  testthat::expect_equal(res$deleted, TRUE)

})
