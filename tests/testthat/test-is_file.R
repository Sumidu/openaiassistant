test_that("is_file_id works", {
  tf <- is_file_id
  expect_false(tf(1))
  expect_false(tf("asst_"))
  expect_false(tf("run_"))
  expect_false(tf("thread_"))
  expect_false(tf("222_"))
  expect_true(tf("file_"))
})
