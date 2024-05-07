#test-plotting_interpolation
#need to make test
test_that("Drawing basic plot does not throw an error", {
  sub <- rustcrn::stations[ seq(1, nrow(rustcrn::stations), by = 4), ]
  x <- rep(c(1,5,7,3,4,5,7), length.out = nrow(sub))
  interp <- interpolation( x ~ LONGITUDE + LATITUDE, data = sub,
                        resolution = 10 )

  expect_no_error(plotting_interpolation(interp))
})

test_that("Adding a title does not throw an error", {
  sub <- rustcrn::stations[ seq(1, nrow(rustcrn::stations), by = 4), ]
  x <- rep(c(1,5,7,3,4,5,7), length.out = nrow(sub))
  interp <- interpolation( x ~ LONGITUDE + LATITUDE, data = sub,
                           resolution = 10 )

  expect_no_error(plotting_interpolation(interp, main = "test"))
})

test_that("Changing palette to a valid hcl palette does not throw an error", {
  sub <- rustcrn::stations[ seq(1, nrow(rustcrn::stations), by = 4), ]
  x <- rep(c(1,5,7,3,4,5,7), length.out = nrow(sub))
  interp <- interpolation( x ~ LONGITUDE + LATITUDE, data = sub,
                           resolution = 10 )

  expect_no_error(plotting_interpolation(interp, palette = "Spectral"))
})

test_that("Removing lines does not throw an error", {
  sub <- rustcrn::stations[ seq(1, nrow(rustcrn::stations), by = 4), ]
  x <- rep(c(1,5,7,3,4,5,7), length.out = nrow(sub))
  interp <- interpolation( x ~ LONGITUDE + LATITUDE, data = sub,
                           resolution = 10 )

  expect_no_error(plotting_interpolation(interp, lines = FALSE))
})
