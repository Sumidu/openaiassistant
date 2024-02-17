test_that("is_assistant_id works", {
  tf <- is_assistant_id
  expect_false(tf(1))
  expect_true(tf("asst_"))
  expect_false(tf("run_"))
  expect_false(tf("thread_"))
  expect_false(tf("222_"))
  expect_false(tf("file_"))
})
