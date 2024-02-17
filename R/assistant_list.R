#' Get list of all assistants
#' @param order The order to list the assistants in. Options are "asc" and "desc".
#' @param limit The maximum number of assistants to return.
#' @returns A list of assistant objects
#' @export
#' @examples \dontrun{
#' assistant_list()
#' }
assistant_list <- function(order = "desc", limit = 20) {

  assertthat::assert_that(order %in% c("asc", "desc"), msg = "order must bei either 'asc' or 'desc'.")

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
