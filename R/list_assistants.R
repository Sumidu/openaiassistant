#' Get list of all assistants
#' curl "https://api.openai.com/v1/assistants?order=desc&limit=20" \
#' -H "Content-Type: application/json" \
#' -H "Authorization: Bearer $OPENAI_API_KEY" \
#' -H "OpenAI-Beta: assistants=v1"
#' @param order The order to list the assistants in. Options are "asc" and "desc".
#' @param limit The maximum number of assistants to return.
#' @export
#' @examples
#' list_assistants()
list_assistants <- function(order = "desc", limit = 20) {
  check_token()
  base_url <- "https://api.openai.com/"
  req <- httr2::request(base_url)
  resp <- req |>
    httr2::req_url_path_append("v1/assistants") |>
    httr2::req_auth_bearer_token(token = Sys.getenv("OPENAI_API_KEY")) |>
    httr2::req_headers("Content-Type" = "application/json") |>
    httr2::req_headers("OpenAI-Beta" = "assistants=v1") |>
    httr2::req_url_query("order" = order) |>
    httr2::req_url_query("limit" = limit) |>
    httr2::req_throttle(rate = 15) |>
    httr2::req_perform()

  httr2::resp_body_json(resp, simplifyVector = TRUE)
}
