
<!-- README.md is generated from README.Rmd. Please edit that file -->

# openaiassistant

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![pkgdown](https://github.com/Sumidu/openaiassistant/actions/workflows/pkgdown.yaml/badge.svg)](https://github.com/Sumidu/openaiassistant/actions/workflows/pkgdown.yaml)
<!-- badges: end -->

The goal of openaiassistant is to provide access to the assistants API
of OpenAI. The package is low effort and not yet fully tested.

## Installation

You can install the development version of openaiassistant like so:

``` r
remotes::install_github("sumidu/openaiassistant")
```

## Example Usage

This is a basic example which shows you how to use the assistants API.
It expects that you set the environment variable “OPENAI_API_KEY” to
your OpenAI API Key. This can be done by the following code in R:

``` r
Sys.setenv(OPENAI_API_KEY = "yourkeyhere")
```

This is the example.

``` r
library(openaiassistant)
## Check if API Key is set
check_token()

# Create a new assistant
assistant_name <- "Nordisch Jarvis"
instructions <- 
  paste("This is an assistant that answers as briefly as possible.",
    "Ideally one word only.")

assistant <-
  assistant_create(
    assistant_name,
    instructions,
    model = "gpt-4-turbo-preview"
  )

# create a new thread
thread <- thread_create()
message <-
  thread_add_message(thread, "What is the Queen of the Hanse?")

# create a run with this question
run <- assistant_run(assistant, thread)
# wait for completion
while (run$status %in% c("queued", "in_progress")) {
  run <- run_retrieve(run, thread)
  Sys.sleep(5)
}

# retrieve the messages
messages <- thread_retrieve_messages(thread)

# print the result
print(get_last_message(messages))

#> [1] Lübeck

# delete everything
res_thread <- thread_delete(thread$id)
res_assistant <- assistant_delete(assistant$id)
```
