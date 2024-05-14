#' Retrieve a run by thread and run object
#' @param run The run object to retrieve
#' @param thread The thread object to retrieve the run from
#' @returns The updated run object
#' @export
#' @examples \dontrun{
#' # more details here TBD
#' run_retrieve(run, thread)
#' }
run_retrieve <- function(run, thread){

  assertthat::assert_that(is_run(run))
  assertthat::assert_that(is_thread(thread))

  check_token()
  base_url <- "https://api.openai.com/"
  req <- httr2::request(base_url)
  resp <- req |>
    httr2::req_url_path_append("v2/threads") |>
    httr2::req_url_path_append(thread$id) |>
    httr2::req_url_path_append("runs") |>
    httr2::req_url_path_append(run$id) |>
    httr2::req_auth_bearer_token(token = Sys.getenv("OPENAI_API_KEY")) |>
    httr2::req_headers("OpenAI-Beta" = "assistants=v2") |>
    httr2::req_throttle(rate = 15) |>
    httr2::req_perform()
  httr2::resp_body_json(resp, simplifyVector = TRUE)
}
