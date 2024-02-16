#' Add a message to a thread
#'
#' @param thread A thread object
#' @param message The text of the message to add as a string
#' @returns A message object
#' @export
#' @examples \dontrun{
#' thread <- create_thread()
#' msg <- thread_add_message(thread, "How does AI work? Explain it in simple terms.")
#' }
thread_add_message <- function(thread, message){
  check_token()
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
