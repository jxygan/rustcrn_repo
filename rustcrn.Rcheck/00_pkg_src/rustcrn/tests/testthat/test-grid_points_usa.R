#test grid_points_usa uses correct resolution

test_that("Resolution is correct by comparing number of rows",{
  expect_equal(dim(grid_points_usa(10))[1], 100)
  expect_equal(dim(grid_points_usa(50))[1], 2500)
  expect_equal(dim(grid_points_usa(5))[1], 25)
})


test_that("Column nmaes are long, lat, in_usa",{
  expect_equal(colnames(grid_points_usa(10)) , c("long", "lat", "in_usa"))
})


test_that("Resolution input needs to be integer or throws error", {
  # Expect an error when a non-integer string is passed
  expect_error(grid_points_usa("10"), "Error! Resolution not integer")
  expect_error(grid_points_usa("ten"), "Error! Resolution not integer")
})