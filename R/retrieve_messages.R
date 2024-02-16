#' Retrieve messages from thread object
#' curl https://api.openai.com/v1/threads/thread_abc123/messages \
#' -H "Content-Type: application/json" \
#' -H "Authorization: Bearer $OPENAI_API_KEY" \
#' -H "OpenAI-Beta: assistants=v1"
#' @param thread The thread object to retrieve the messages from
#' @returns A list of message objects
#' @export
retrieve_messages <- function(thread){
  base_url <- "https://api.openai.com/"
  req <- httr2::request(base_url)
  resp <- req |>
    httr2::req_url_path_append("v1/threads") |>
    httr2::req_url_path_append(thread$id) |>
    httr2::req_url_path_append("messages") |>
    httr2::req_auth_bearer_token(token = Sys.getenv("OPENAI_API_KEY")) |>
    httr2::req_headers("Content-Type" = "application/json") |>
    httr2::req_headers("OpenAI-Beta" = "assistants=v1") |>
    httr2::req_throttle(rate = 15) |>
    httr2::req_perform()
  httr2::resp_body_json(resp, simplifyVector = TRUE)
}
