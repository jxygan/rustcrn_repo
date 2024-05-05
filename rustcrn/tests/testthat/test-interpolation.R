#test-interpolation

test_that("Resolution is correct by comparing number of rows",{
  x <- rep(c(1,2,3,4,5), length.out = nrow(stations))
  expect_equal(dim(interpolation( x, resolution = 10))[1], 100)

  y <- rep(c(1,3,4,4,8), length.out = nrow(stations))
  expect_equal(dim(interpolation( x, resolution = 5))[1], 25)

})


test_that("Column nmaes are long, lat, in_usa, prediction",{
  x <- rep(c(1,2,3,4,5), length.out = nrow(stations))
  expect_equal(colnames(interpolation( x, resolution = 10)), c("long", "lat",
                                                 "in_usa", "prediction"))
})


test_that("Different results for different input for value",{
  x <- rep(c(1,2,3,4,5), length.out = nrow(stations))
  y <- rep(c(1,3,4,4,8), length.out = nrow(stations))
  expect_failure(expect_equal(interpolation( x, resolution = 10),
                              interpolation( y, resolution = 10)))
})

test_that("Subsetting station data is functional", {
  wbanno <- rustcrn::stations$WBANNO[seq(1, nrow(rustcrn::stations), by = 4)]
  y <- rep(c(1,2,3,4,5), length.out = length(wbanno))
  expect_no_error(interpolation(y, stations = wbanno, resolution = 10))
})
