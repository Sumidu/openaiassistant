#' Function that runs an assistant with a thread
#' @param assistant The assistant to run
#' @param thread The thread to run the assistant with
#' @returns A run object
#' @export
#' @examples \dontrun{
#' assistant <- create_assistant()
#' thread <- create_thread()
#' run <- run_assistant(assistant, thread)
#' if(run$status != "completed"){
#'  print("The assistant is still running")
#' }
#' }
assistant_run <- function(assistant, thread){

  assertthat::assert_that(is_assistant(assistant))
  assertthat::assert_that(is_thread(thread))

  check_token()
  body <- list(assistant_id = assistant$id)
  base_url <- "https://api.openai.com/"
  req <- httr2::request(base_url)
  resp <- req |>
    httr2::req_url_path_append("v1/threads") |>
    httr2::req_url_path_append(thread$id) |>
    httr2::req_url_path_append("runs") |>
    httr2::req_auth_bearer_token(token = Sys.getenv("OPENAI_API_KEY")) |>
    httr2::req_headers("Content-Type" = "application/json") |>
    httr2::req_headers("OpenAI-Beta" = "assistants=v1") |>
    httr2::req_body_json(body) |>
    httr2::req_throttle(rate = 15) |>
    httr2::req_perform()
  httr2::resp_body_json(resp, simplifyVector = TRUE)
}
