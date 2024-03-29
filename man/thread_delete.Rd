% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/thread_delete.R
\name{thread_delete}
\alias{thread_delete}
\title{Delete a thread by id}
\usage{
thread_delete(thread_id)
}
\arguments{
\item{thread_id}{The ID of the thread to delete}
}
\value{
a response object with deleted field set to true if successful
}
\description{
Delete a thread by id
}
\examples{
\dontrun{
thread_delete("thread_abc123")
}
}
