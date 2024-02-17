test_that("is_run_id works", {
  tf <- is_run_id
  expect_false(tf(1))
  expect_false(tf("asst_"))
  expect_true(tf("run_"))
  expect_false(tf("thread_"))
  expect_false(tf("222_"))
  expect_false(tf("file_"))
})
