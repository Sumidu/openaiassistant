#' List all files
#' @returns A list of file objects
#' @export
files_list <- function(){

  check_token()

  base_url <- "https://api.openai.com/"
  req <- httr2::request(base_url)
  resp <- req |>
    httr2::req_url_path_append("v1/files") |>
    httr2::req_auth_bearer_token(token = Sys.getenv("OPENAI_API_KEY")) |>
    httr2::req_throttle(rate = 15) |>
    httr2::req_perform()
  httr2::resp_body_json(resp, simplifyVector = TRUE)
}
