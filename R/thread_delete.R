#' Delete a thread by id
#' @param thread_id The ID of the thread to delete
#' @returns a response object with deleted field set to true if successful
#' @export
#' @examples \dontrun{
#' thread_delete("thread_abc123")
#' }
thread_delete <- function(thread_id){
  check_token()
  base_url <- "https://api.openai.com/"
  req <- httr2::request(base_url)
  resp <- req |>
    httr2::req_url_path_append("v1/threads") |>
    httr2::req_url_path_append(thread_id) |>
    httr2::req_auth_bearer_token(token = Sys.getenv("OPENAI_API_KEY")) |>
    httr2::req_headers("Content-Type" = "application/json") |>
    httr2::req_headers("OpenAI-Beta" = "assistants=v1") |>
    httr2::req_method("DELETE") |>
    httr2::req_throttle(rate = 15) |>
    httr2::req_perform()
  httr2::resp_body_json(resp, simplifyVector = TRUE)
}
