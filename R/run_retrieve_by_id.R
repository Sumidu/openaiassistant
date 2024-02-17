#' Retrieve a run by thread and run object by ID
#' @param run_id The run id to retrieve
#' @param thread_id The thread id to retrieve the run from
#' @returns The updated run object
#' @export
#' @examples \dontrun{
#' run_retrieve_by_id("run_abc123", "thread_abc123")
#' }
run_retrieve_by_id <- function(run_id, thread_id){

  assertthat::assert_that(is.character(run_id))
  assertthat::assert_that(is_run_id(run_id))

  assertthat::assert_that(is.character(thread_id))
  assertthat::assert_that(is_thread_id(thread_id))

  check_token()

  base_url <- "https://api.openai.com/"
  req <- httr2::request(base_url)
  resp <- req |>
    httr2::req_url_path_append("v1/threads") |>
    httr2::req_url_path_append(thread_id) |>
    httr2::req_url_path_append("runs") |>
    httr2::req_url_path_append(run_id) |>
    httr2::req_auth_bearer_token(token = Sys.getenv("OPENAI_API_KEY")) |>
    httr2::req_headers("OpenAI-Beta" = "assistants=v1") |>
    httr2::req_throttle(rate = 15) |>
    httr2::req_perform()
  httr2::resp_body_json(resp, simplifyVector = TRUE)
}
