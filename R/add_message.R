#' Add a message to a thread
#' curl https://api.openai.com/v1/threads/thread_abc123/messages \
#' -H "Content-Type: application/json" \
#' -H "Authorization: Bearer $OPENAI_API_KEY" \
#' -H "OpenAI-Beta: assistants=v1" \
#' -d '{
#'      "role": "user",
#'     "content": "How does AI work? Explain it in simple terms."
#'    }'
#' @param thread A thread object
#' @param message The message to add
#' @returns A message object
#' @export
#' @examples \dontrun{
#' thread <- create_thread()
#' msg <- addMessage(thread, "How does AI work? Explain it in simple terms.")
#' }
addMessage <- function(thread, message){
  body <- list(role = "user", content = message)
  base_url <- "https://api.openai.com/"
  req <- httr2::request(base_url)
  resp <- req |>
    httr2::req_url_path_append("v1/threads") |>
    httr2::req_url_path_append(thread$id) |>
    httr2::req_url_path_append("messages") |>
    httr2::req_auth_bearer_token(token = Sys.getenv("OPENAI_API_KEY")) |>
    httr2::req_headers("Content-Type" = "application/json") |>
    httr2::req_headers("OpenAI-Beta" = "assistants=v1") |>
    httr2::req_body_json(body) |>
    httr2::req_throttle(rate = 15) |>
    httr2::req_perform()
  httr2::resp_body_json(resp, simplifyVector = TRUE)
}
