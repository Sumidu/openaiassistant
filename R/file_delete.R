#' Delete a file by id
#' @param file_id The file id to delete
#' @returns A response object with a field deleted set to TRUE if the file was deleted
#' @export
#' @examples \dontrun{
#' file_delete("file_abc123")
#' }
file_delete <- function(file_id){

  assertthat::assert_that(is.character(file_id))
  assertthat::assert_that(is_file_id(file_id))

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
