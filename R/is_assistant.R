#' determines if a object is an assistant
#' @param assistant The object to check
#' @returns TRUE when the object is an assistant, FALSE otherwise
#' @export
is_assistant <- function(assistant){
  if(typeof(assistant) != "list"){
    return(FALSE)
  }
  if(is.null(assistant)){
    return(FALSE)
  }
  if(is.null(assistant$object)){
    return(FALSE)
  }
  if(assistant$object != "assistant"){
    return(FALSE)
  }
  return(TRUE)
}


#' verifies an assistant id as a valid assistant id
#' @param assistant_id The assistant id to verify
#' @return TRUE if the assistant id is valid, FALSE otherwise
#' @export
is_assistant_id <- function(assistant_id){
  if(!is.character(assistant_id)){
    return(FALSE)
  }
  if(is.null(assistant_id)){
    return(FALSE)
  }
  if(substr(assistant_id, 1,5) != "asst_"){
    return(FALSE)
  }
  return(TRUE)
}
