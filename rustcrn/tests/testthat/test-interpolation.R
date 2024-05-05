#test-interpolation

test_that("Resolution is correct by comparing number of rows",{
  x <- rep(c(1,2,3,4,5), length.out = nrow(stations))
  expect_equal(dim(interpolation( x,10))[1], 100)
  
  y <- rep(c(1,3,4,4,8), length.out = nrow(stations))
  expect_equal(dim(interpolation( x,5))[1], 25)
  
})


test_that("Column nmaes are long, lat, in_usa, prediction",{
  x <- rep(c(1,2,3,4,5), length.out = nrow(stations))
  expect_equal(colnames(interpolation( x,10)), c("long", "lat", 
                                                 "in_usa", "prediction"))
})


test_that("Different results for different input for value",{
  x <- rep(c(1,2,3,4,5), length.out = nrow(stations))
  y <- rep(c(1,3,4,4,8), length.out = nrow(stations))
  expect_failure(expect_equal(interpolation( x,10), interpolation( y,10)))
})
