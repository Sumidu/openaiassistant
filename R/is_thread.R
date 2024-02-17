#' determines if object is a thread object
#' @param thread The object to check
#' @return TRUE if the object is a thread object, FALSE otherwise
#' @export
is_thread <- function(thread){
  if(!is.list(thread)){
    return(FALSE)
  }
  if(is.null(thread)){
    return(FALSE)
  }
  if(is.null(thread$object)){
    return(FALSE)
  }
  if(thread$object != "thread"){
    return(FALSE)
  }
  return(TRUE)
}

#' verifies a thread id as a valid thread id
#' @param thread_id The thread id to verify
#' @return TRUE if the thread id is valid, FALSE otherwise
#' @export
is_thread_id <- function(thread_id){
  if(!is.character(thread_id)){
    return(FALSE)
  }
  if(is.null(thread_id)){
    return(FALSE)
  }
  if(substr(thread_id, 1,7) != "thread_"){
    return(FALSE)
  }
  return(TRUE)
}
