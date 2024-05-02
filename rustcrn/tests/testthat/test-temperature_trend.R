test_that("Output has correct dimensions", {
  trends <- temp_trend(rustcrn::stations[2:6,1])
  expect_equal(nrow(trends), 5)
  expect_equal(ncol(trends), 4)

  ithaca <- 64758
  trend_ithaca <- temp_trend(ithaca)
  expect_equal(nrow(trend_ithaca), 1)
  expect_equal(ncol(trend_ithaca), 4)

  asheville <- 53878
  trend_ashe <- temp_trend(asheville)
  expect_equal(nrow(trend_ashe), 1)
  expect_equal(ncol(trend_ashe), 4)
})

test_that("Output values are not missing", {
  ithaca <- 64758
  asheville <- 53878
  trend_ithaca <- temp_trend(ithaca)
  trend_ashe <- temp_trend(asheville)
  trends <- temp_trend(rustcrn::stations[2:6,1])

  expect_false(anyNA(trend_ithaca))
  expect_false(anyNA(trend_ashe))
  expect_false(anyNA(trends))
})
# come up with ideas for tests... how to test something like this? test
# for no errors?
