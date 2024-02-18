#' Check whether the OpenAI Token is set
#' @returns NULL
#' @export
#' @returns TRUE is the token is set, errors otherwise
#' @examples \dontrun{
#' check_token()
#' }
check_token <- function() {
  if (is.null(Sys.getenv("OPENAI_API_KEY"))) {
    stop("OPENAI_API_KEY is not set. Please set it using Sys.setenv(OPENAI_API_KEY) or by adding it to your .Renviron file.")
  }
  if ((Sys.getenv("OPENAI_API_KEY")=="")) {
    stop("OPENAI_API_KEY is not set. Please set it using Sys.setenv(OPENAI_API_KEY) or by adding it to your .Renviron file.")
  }
  return(TRUE)
}
