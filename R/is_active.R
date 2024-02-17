#' Checks whether a run is active
#' @param run The run object to check
#' @returns TRUE if the run is active, FALSE otherwise
#' @export
is_active <- function(run){

  assertthat::assert_that(is_run(run))

  if(run$status %in% c("queued", "in_progress")){
    return(TRUE)
  } else {
    return(FALSE)
  }
}
