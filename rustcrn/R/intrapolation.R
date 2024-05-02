
# value is a vector of values against stations long, latitude

intrapolation <- function(value){
  y <- value
  locs <- cbind(rustcrn::stations$LONGITUDE, rustcrn::stations$LATITUDE)
  fit <- GpGp::fit_model(y = y,
                         locs= locs,
                         covfun_name = "matern_sphere",
                         silent = TRUE)

  locs_pred <- cbind(grid_square$long, grid_square$lat)

  prediction <- GpGp::predictions(fit = fit,
                            locs_pred = locs_pred)

  prediction <- cbind(grid_square, prediction )

  return(prediction)
}



#testing
# example
# intrapolation()
