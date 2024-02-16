#' Gets the content of the last message from a list of messages
#' @param messages A list of message objects
#' @returns The content of the last message
#' @export
get_last_message <- function(messages){
  messages$data$content[[1]]$text$value
}
