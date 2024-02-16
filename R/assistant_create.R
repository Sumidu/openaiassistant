#' Create an assistant
#' @param name The name of the assistant
#' @param instructions The instructions for the assistant
#' @param model The model to use for the assistant (default: "gpt-4-turbo-preview")
#' @param tool_retrieval Should the assistant have a retrieval tool? (default: FALSE)
#' @param tool_code_interpreter Should the assistant have a code interpreter tool? (default: FALSE)
#' @param file_ids A list of file IDs to add to the assistant (default: NULL)
#' @returns an assistant object
#' @export
assistant_create <- function(name, instructions, model = "gpt-4-turbo-preview", tool_retrieval = FALSE, tool_code_interpreter = FALSE, file_ids = NULL){
  check_token()

  # generate the body of the request
  body <- list(
    instructions = instructions,
    name = name,
    model = model
  )
  if(tool_retrieval){
    body$tools <- list(list(type = "retrieval"))
  }
  if(tool_code_interpreter){
    body$tools <- list(list(type = "code_interpreter"))
  }
  # function tool is not implemented yet

  # add files
  if(!is.null(file_ids)){
    body$file_ids <- file_ids
  }
  base_url <- "https://api.openai.com/"
  req <- httr2::request(base_url)
  resp <- req |>
    httr2::req_url_path_append("v1/assistants") |>
    httr2::req_auth_bearer_token(token = Sys.getenv("OPENAI_API_KEY")) |>
    httr2::req_headers("Content-Type" = "application/json") |>
    httr2::req_headers("OpenAI-Beta" = "assistants=v1") |>
    httr2::req_body_json(body) |>
    httr2::req_throttle(rate = 15) |>
    #httr2::req_dry_run()
    httr2::req_perform()

  httr2::resp_body_json(resp, simplifyVector = TRUE)
}
