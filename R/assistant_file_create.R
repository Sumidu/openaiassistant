#' Create Assistant file from assistant object and file id
#' file must already exist
#' @param assistant The assistant to associate the file with
#' @param file_id The file id to associate with the assistant
#' @returns An assistant_file object
#' @export
assistant_file_create <- function(assistant, file_id){
  check_token()
  body <- list(file_id = file_id)
  base_url <- "https://api.openai.com/"
  req <- httr2::request(base_url)
  resp <- req |>
    httr2::req_url_path_append("v1/assistants") |>
    httr2::req_url_path_append(assistant$id) |>
    httr2::req_url_path_append("files") |>
    httr2::req_auth_bearer_token(token = Sys.getenv("OPENAI_API_KEY")) |>
    httr2::req_headers("Content-Type" = "application/json") |>
    httr2::req_headers("OpenAI-Beta" = "assistants=v1") |>
    httr2::req_body_json(body) |>
    httr2::req_throttle(rate = 15) |>
    httr2::req_perform()
  httr2::resp_body_json(resp, simplifyVector = TRUE)
}
