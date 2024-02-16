#' Retrieve messages from thread object
#' @param thread The thread object to retrieve the messages from
#' @returns A list of message objects
#' @export
#' @examples \dontrun{
#' thread <- create_thread()
#' messages <- thread_retrieve_messages(thread)
#' }
thread_retrieve_messages <- function(thread){
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
