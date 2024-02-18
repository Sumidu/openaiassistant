library(httptest2)
test_backup_token <- Sys.getenv("OPENAI_API_KEY")
Sys.setenv("OPENAI_API_KEY" = "test")


withr::defer(Sys.setenv("OPENAI_API_KEY" = test_backup_token), teardown_env())
