#' Retrieves an assistant by id
#' @param assistant_id The ID of the assistant to retrieve.
#' @returns An assistant object
#' @export
#' @examples \dontrun{
#' retrieveAssistant("asst_abc123")
#' }
assistant_retrieve <- function(assistant_id){
  check_token()
  base_url <- "https://api.openai.com/"
  req <- httr2::request(base_url)
  resp <- req |>
    httr2::req_url_path_append("v1/assistants") |>
    httr2::req_url_path_append(assistant_id) |>
    httr2::req_auth_bearer_token(token = Sys.getenv("OPENAI_API_KEY")) |>
    httr2::req_headers("Content-Type" = "application/json") |>
    httr2::req_headers("OpenAI-Beta" = "assistants=v1") |>
    httr2::req_throttle(rate = 15) |>
    httr2::req_perform()


  httr2::resp_body_json(resp, simplifyVector = TRUE)
}
