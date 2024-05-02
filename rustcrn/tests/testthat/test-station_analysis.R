test_that("correct station is pulled", {
  expect_equal(unique(time_series(64758)$station_name), "Ithaca_13_E")
  expect_equal(unique(time_series(53878)$station_name), "Asheville_13_S")
})

test_that("start date is the same", {
  date <- "2020-01-01"
  expect_equal(min(time_series(64758, start_date = date)$LST_DATE), as.Date(date))
  expect_equal(min(time_series(53878, start_date = date)$LST_DATE), as.Date(date))

  date <- "2021-12-31"
  expect_equal(min(time_series(64758, start_date = date)$LST_DATE), as.Date(date))
  expect_equal(min(time_series(53878, start_date = date)$LST_DATE), as.Date(date))
})

test_that("end date is the same", {
  date <- "2020-01-01"
  expect_equal(max(time_series(64758, end_date = date)$LST_DATE), as.Date(date))
  expect_equal(max(time_series(53878, end_date = date)$LST_DATE), as.Date(date))

  date <- "2021-12-31"
  expect_equal(max(time_series(64758, end_date = date)$LST_DATE), as.Date(date))
  expect_equal(max(time_series(53878, end_date = date)$LST_DATE), as.Date(date))
})
