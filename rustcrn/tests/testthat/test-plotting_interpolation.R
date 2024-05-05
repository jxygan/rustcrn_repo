#test-plotting_interpolation
#need to make test
test_that("Drawing basic plot does not throw an error", {
  x <- rep(c(1,5,7,3,4,5,7), length.out = 236)

  expect_no_error(plotting_interpolation(x))
})

test_that("Adding a title does not throw an error", {
  x <- rep(c(1,5,7,3,4,5,7), length.out = 236)

  expect_no_error(plotting_interpolation(x, main = "test"))
})

test_that("Changing palette to a valid hcl palette does not throw an error", {
  x <- rep(c(1,5,7,3,4,5,7), length.out = 236)

  expect_no_error(plotting_interpolation(x, palette = "Spectral"))
})

test_that("Removing lines does not throw an error", {
  x <- rep(c(1,5,7,3,4,5,7), length.out = 236)

  expect_no_error(plotting_interpolation(x, lines = FALSE))
})
