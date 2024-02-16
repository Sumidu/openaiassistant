#' Create Assistant file from assistant object and file id
#' curl https://api.openai.com/v1/assistants/asst_abc123/files \
#' -H 'Authorization: Bearer $OPENAI_API_KEY"' \
#' -H 'Content-Type: application/json' \
#' -H 'OpenAI-Beta: assistants=v1' \
#' -d '{
#'       "file_id": "file-abc123"
#'     }'
#' @param assistant The assistant to associate the file with
#' @param file_id The file id to associate with the assistant
#' @returns A file object
#' @export
create_assistant_file <- function(assistant, file_id){
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
