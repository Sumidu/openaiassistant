testthat::test_that("Token works", {
  env_name <- "OPENAI_API_KEY"

  backup_token <- Sys.getenv(env_name)

  # test error for missing token
  Sys.unsetenv(env_name)
  testthat::expect_error(check_token(), "OPENAI_API_KEY is not set")

  # restore
  Sys.setenv("OPENAI_API_KEY" = backup_token)
  testthat::expect_no_condition(check_token())

})
