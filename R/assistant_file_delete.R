#' Delete an assistant file
#' @param assistant The assistant to delete the file from
#' @param file_id The file id to delete
#' @returns The assistant object
#' @export
#' @examples \dontrun{
#' assistant_file_delete(assistant, file_id)
#' }
assistant_file_delete <- function(assistant, file_id){
  base_url <- "https://api.openai.com/"
  req <- httr2::request(base_url)
  resp <- req |>
    httr2::req_url_path_append("v1/assistants") |>
    httr2::req_url_path_append(assistant$id) |>
    httr2::req_url_path_append("files") |>
    httr2::req_url_path_append(file_id) |>
    httr2::req_auth_bearer_token(token = Sys.getenv("OPENAI_API_KEY")) |>
    httr2::req_headers("Content-Type" = "application/json") |>
    httr2::req_headers("OpenAI-Beta" = "assistants=v1") |>
    httr2::req_method("DELETE") |>
    httr2::req_perform()
  httr2::resp_body_json(resp, simplifyVector = TRUE)
}
