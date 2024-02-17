#' Check if a string is a file id
#' @param file_id The file id to check
#' @returns TRUE if the file id is a file id, FALSE otherwise
#' @export
is_file_id <- function(file_id){
  if(!is.character(file_id)){
    return(FALSE)
  }
  if(is.null(file_id)){
    return(FALSE)
  }
  if(substr(file_id, 1,5) != "file_"){
    return(FALSE)
  }
  return(TRUE)
}
