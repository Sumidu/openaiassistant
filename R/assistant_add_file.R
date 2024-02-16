#' Add file to assistant
#' This will only add the file if it not exists
#' @param assistant The assistant to add the file to
#' @param file_id The file id to add to the assistant
#' @returns The updated assistant object
#' @export
assistant_add_file <- function(assistant, file_id){

  check_token()
  if (file_id %in% assistant$file_ids){
    stop("File already added to assistant")
  }
  if(length(assistant$file_ids) == 0){
    body <- list(
      file_ids = list(file_id)
    )
  } else  {
    body <- list(
      file_ids = list(assistant$file_ids, file_id)
    )
  }

  base_url <- "https://api.openai.com/"
  req <- httr2::request(base_url)
  resp <- req |>
    httr2::req_url_path_append("v1/assistants") |>
    httr2::req_url_path_append(assistant$id) |>
    httr2::req_auth_bearer_token(token = Sys.getenv("OPENAI_API_KEY")) |>
    httr2::req_headers("Content-Type" = "application/json") |>
    httr2::req_headers("OpenAI-Beta" = "assistants=v1") |>
    httr2::req_body_json(body) |>
    httr2::req_throttle(rate = 15) |>
    httr2::req_perform()
  httr2::resp_body_json(resp, simplifyVector = TRUE)
}
