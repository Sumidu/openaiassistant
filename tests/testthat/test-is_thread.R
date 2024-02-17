test_that("is_thread_id works", {
  tf <- is_thread_id
  expect_false(tf(1))
  expect_false(tf("asst_"))
  expect_false(tf("run_"))
  expect_true(tf("thread_"))
  expect_false(tf("222_"))
  expect_false(tf("file_"))
})
