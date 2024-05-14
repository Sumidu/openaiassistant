#' Create a new thread
#' @returns A thread object
#' @export
#' @examples \dontrun{
#' thread <- thread_create()
#' }
thread_create <- function() {

  check_token()

  body <- ""
  base_url <- "https://api.openai.com/"
  req <- httr2::request(base_url)
  resp <- req |>
    httr2::req_url_path_append("v1/threads") |>
    httr2::req_auth_bearer_token(token = Sys.getenv("OPENAI_API_KEY")) |>
    httr2::req_headers("Content-Type" = "application/json") |>
    httr2::req_headers("OpenAI-Beta" = "assistants=v2") |>
    httr2::req_body_json(body) |>
    httr2::req_throttle(rate = 15) |>
    #httr2::req_dry_run()
    httr2::req_perform()

  httr2::resp_body_json(resp, simplifyVector = TRUE)
}
