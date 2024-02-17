#' Check if a run is a run
#' @param run The run object to check
#' @returns TRUE if the run is a run, FALSE otherwise
#' @export
is_run <- function(run){
  if(!is.list(run)){
    return(FALSE)
  }
  if(is.null(run$object)){
    return(FALSE)
  }
  if(run$object != "thread.run"){
    return(FALSE)
  }

  return(TRUE)
}


#' verifies a run id
#' @param run_id The run id to verify
#' @return TRUE if the run id is valid, FALSE otherwise
#' @export
is_run_id <- function(run_id){
  if(!is.character(run_id)){
    return(FALSE)
  }
  if(is.null(run_id)){
    return(FALSE)
  }
  if(substr(run_id, 1,4) != "run_"){
    return(FALSE)
  }
  return(TRUE)
}
