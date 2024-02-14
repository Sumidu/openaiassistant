#' Create threadBeta
#' POST
#
#' https://api.openai.com/v1/threads
#
#' Create a thread.
#' curl https://api.openai.com/v1/threads \
#' -H "Content-Type: application/json" \
#' -H "Authorization: Bearer $OPENAI_API_KEY" \
#' -H "OpenAI-Beta: assistants=v1" \
#' -d ''
#' @returns A thread object
#' @export
#' @examples \dontrun{
#' thread <- create_thread()
#' }
create_thread <- function() {
  check_token()
  body <- ""
  base_url <- "https://api.openai.com/"
  req <- httr2::request(base_url)
  resp <- req |>
    httr2::req_url_path_append("v1/threads") |>
    httr2::req_auth_bearer_token(token = Sys.getenv("OPENAI_API_KEY")) |>
    httr2::req_headers("Content-Type" = "application/json") |>
    httr2::req_headers("OpenAI-Beta" = "assistants=v1") |>
    httr2::req_body_json(body) |>
    httr2::req_throttle(rate = 15) |>
    #httr2::req_dry_run()
    httr2::req_perform()


  httr2::resp_body_json(resp, simplifyVector = TRUE)
}
