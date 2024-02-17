#' Upload a file for assistant use
#' @param file_path The path to the file to upload
#' @returns A file object
#' @export
#' @examples \dontrun{
#' file_upload("path/to/file")
#' }
file_upload <- function(file_path){

  assertthat::assert_that(file.exists(file_path))

  check_token()

  base_url <- "https://api.openai.com/"
  req <- httr2::request(base_url)
  resp <- req |>
    httr2::req_url_path_append("v1/files") |>
    httr2::req_auth_bearer_token(token = Sys.getenv("OPENAI_API_KEY")) |>
    httr2::req_body_multipart(file = curl::form_file(file_path), purpose = "assistants") |>
    httr2::req_throttle(rate = 15) |>
    #httr2::req_dry_run()
    httr2::req_perform()

  httr2::resp_body_json(resp, simplifyVector = TRUE)
}
