#' function that runs an assistant with a thread
#' curl https://api.openai.com/v1/threads/thread_abc123/runs \
#' -H "Authorization: Bearer $OPENAI_API_KEY" \
#' -H "Content-Type: application/json" \
#' -H "OpenAI-Beta: assistants=v1" \
#' -d '{
#'    "assistant_id": "asst_abc123"
#'  }'
#' @param thread The thread to run the assistant with
#' @param assistant The assistant to run
#' @returns A run object
#' @export
#' @examples \dontrun{
#' thread <- create_thread()
#' assistant <- create_assistant()
#' run <- run_assistant(thread, assistant)
#' if(run$status != "completed"){
#'  print("The assistant is still running")
#' }
#' }
run_assistant <- function(thread, assistant){
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
