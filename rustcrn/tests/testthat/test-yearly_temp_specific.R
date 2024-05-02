test_that("Output has the correct dimensions", {
  ithaca <- 64758
  expect_equal(nrow(yearly_cycle(ithaca)), 365)
  expect_equal(ncol(yearly_cycle(ithaca)), 2)

  asheville <- 53878
  expect_equal(nrow(yearly_cycle(asheville)), 365)
  expect_equal(ncol(yearly_cycle(asheville)), 2)
})

test_that("Predictions fall in the correct range", {
  ithaca <- 64758
  ys <- yearly_cycle(ithaca)
  test_indices <- c(1, 61, 121, 181, 241, 301, 361)
  expected <- c(-3.7279105948, -2.0446014410, 10.2356313256,
                19.6428885644, 17.6875362312, 7.1445669006,
                -3.2147758732)

  expect_equal(ys[test_indices,2], expected)
})

# office hours
