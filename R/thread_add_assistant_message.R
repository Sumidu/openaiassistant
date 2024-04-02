#' Add an assistant message to a thread
#'
#' @param thread A thread object
#' @param message The text of the message to add as a string
#' @returns A message object
#' @export
#' @examples \dontrun{
#' thread <- create_thread()
#' msg <- thread_add_message(thread, "This is a potential chatbot reply")
#' }

thread_add_assistant_message <- function (thread, message) 
{
  assertthat::assert_that(is_thread(thread))
  assertthat::assert_that(is.character(message))
  check_token()
  body <- list(role = "assistant", content = message)
  base_url <- "https://api.openai.com/"
  req <- httr2::request(base_url)
  resp <- httr2::req_perform(httr2::req_throttle(httr2::req_body_json(httr2::req_headers(httr2::req_headers(httr2::req_auth_bearer_token(httr2::req_url_path_append(httr2::req_url_path_append(httr2::req_url_path_append(req, 
                                                                                                                                                                                                                          "v1/threads"), thread$id), "messages"), token = Sys.getenv("OPENAI_API_KEY")), 
                                                                                                            `Content-Type` = "application/json"), `OpenAI-Beta` = "assistants=v1"), 
                                                                      body), rate = 15))
  httr2::resp_body_json(resp, simplifyVector = TRUE)
}
