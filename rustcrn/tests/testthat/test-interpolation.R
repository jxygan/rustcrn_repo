#test-interpolation

test_that("Resolution is correct by comparing number of rows",{
  x <- rep(c(1,2,3,4,5), length.out = nrow(stations))
  expect_equal(dim(interpolation( x ~ LONGITUDE + LATITUDE,
                                  data = stations,
                                  resolution = 10))[1], 100)

  y <- rep(c(1,3,4,4,8), length.out = nrow(stations))
  expect_equal(dim(interpolation( y ~ LONGITUDE + LATITUDE,
                                  data = stations,
                                  resolution = 5))[1], 25)

})


test_that("Column names are long, lat, in_usa, prediction",{
  x <- rep(c(1,2,3,4,5), length.out = nrow(stations))
  expect_equal(colnames(interpolation( x ~ LONGITUDE + LATITUDE,
                                       data = stations,
                                       resolution = 10)), c("long", "lat",
                                                 "in_usa", "prediction"))
})


test_that("Different results for different input for value",{
  x <- rep(c(1,2,3,4,5), length.out = nrow(stations))
  y <- rep(c(1,3,4,4,8), length.out = nrow(stations))
  expect_failure(expect_equal(interpolation( x ~ LONGITUDE + LATITUDE,
                                             data = stations,
                                             resolution = 10),
                              interpolation( y ~ LONGITUDE + LATITUDE,
                                             data = stations,
                                             resolution = 10)))
})

test_that("Adding two covariates is functional", {
  sub <- rustcrn::stations[seq(1, nrow(rustcrn::stations), by = 4), ]
  y <- rep(c(1,2,3,4,5), length.out = nrow(sub))
  sub$x1 <- rep(c(0,3,4,5,6,7), length.out = nrow(sub))
  sub$x2 <- rep(c(2,3,2,3,2), length.out = nrow(sub))

  xpred <- cbind(1, matrix(rep(1:9, length.out = 2 * 100), ncol = 2,
                           nrow = 100))

  expect_no_error(interpolation(y ~ LATITUDE + LONGITUDE + x1 + x2,
                data = sub, X_pred = xpred, resolution = 10))
})
