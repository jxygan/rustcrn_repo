#' Interpolate data from the stations to a grid points within the contiguous USA
#'
#' @param value a vector of data corresponding to 236 station locations
#' @param resolution numeric value for resolution of map
#' 
#' @return A data frame of prediction with its corresponding longitude and latitude
#' @export
#'
#' @example
#' #To get data frame of predicted average year temperature of USA at each long, lat
#' x <- Average year temperature of each station
#' intrapolation(x)
#'
#' #To get data frame of predicted temperature in March 2024 of USA at each long, lat
#' z <- March 2024 average temperature of each station
#' intrapolation(z)


intrapolation <- function(value, resolution){
  #Fit a model using value provided and station location
  y <- value
  locs <- cbind(stations$LONGITUDE, stations$LATITUDE)
  fit <- GpGp::fit_model(y = y,
                         locs= locs,
                         covfun_name = "matern_sphere",
                         silent = TRUE)
  
  #Create grid with personalize resolution
  grid_square <- grid_points_usa(resolution)
  #Prepare all gradients
  locs_pred <- cbind(grid_square$long, grid_square$lat)
  
  #Create prediction
  prediction <- predictions(fit = fit,
                            locs_pred = locs_pred)
  
  #Make a data frame of prediction with its corresponding longitude and latitude
  result <- cbind(grid_square, prediction )
  
  return(result)
}
