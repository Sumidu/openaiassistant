#' Delete a file by id
#' curl https://api.openai.com/v1/files/file-abc123 \
#' -X DELETE \
#' -H "Authorization: Bearer $OPENAI_API_KEY"
#' @param file_id The file id to delete
#' @returns A list of file objects?
#' @export
deleteFile <- function(file_id){
  check_token()
  body <- list(file_id = file_id)
  base_url <- "https://api.openai.com/"
  req <- httr2::request(base_url)
  resp <- req |>
    httr2::req_url_path_append("v1/files") |>
    httr2::req_url_path_append(file_id) |>
    httr2::req_method("DELETE") |>
    httr2::req_auth_bearer_token(token = Sys.getenv("OPENAI_API_KEY")) |>
    httr2::req_throttle(rate = 15) |>
    #httr2::req_dry_run()
    httr2::req_perform()
  httr2::resp_body_json(resp, simplifyVector = TRUE)
}
