test_that("correct station is pulled", {
  expect_equal(unique(time_series(64758)$station_name), "Ithaca_13_E")
})

test_that("start date is the same", {
  date <- "2020-01-01"
  expect_equal(min(time_series(64758, start_date = date)$LST_DATE), as.Date(date))
})

test_that("end date is the same", {
  date <- "2020-01-01"
  expect_equal(max(time_series(64758, end_date = date)$LST_DATE), as.Date(date))
})
