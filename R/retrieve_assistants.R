#' Retrieve assistant using the API
#' GET
#' https://api.openai.com/v1/assistants/{assistant_id}
#' Retrieves an assistant.
#' Path parameters
#' assistant_id
#' string
#' Required
#' The ID of the assistant to retrieve.
#'
#' curl https://api.openai.com/v1/assistants/asst_abc123 \
#' -H "Content-Type: application/json" \
#' -H "Authorization: Bearer $OPENAI_API_KEY" \
#' -H "OpenAI-Beta: assistants=v1"
#' @param assistant_id The ID of the assistant to retrieve.
#' @returns An assistant object
#' @export
#' @examples \dontrun{
#' retrieveAssistant("asst_abc123")
#' }
retrieveAssistant <- function(assistant_id){
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
