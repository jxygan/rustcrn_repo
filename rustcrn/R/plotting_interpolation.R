#'Plot the interpolated data
#'
#'Using the interpolated data, produces a visual representation of predicted
#'results by plotting through image.plot
#'
#' @param value a vector of data corresponding to 236 station locations
#' @param resolution numeric value for resolution of map
#'
#' @return Produce visual representation of spatial predictions
#' @export
#'
#' @examples
#' #To get image of predicted estimated trend of temperature of USA with resolution 100
#' tt_all <- temp_trend(rustcrn::stations$WBANNO)
#' value  <- tt_all[, 2]
#' plotting_interpolation( value, 100)

plotting_interpolation <- function(value, resolution) {
  #get interpolated data with
  data <- interpolation(value, resolution)
  data$prediction <- ifelse(data$in_usa == 0, NA, data$prediction)
  data <- data[,-3]
  
  #make a matrix of the data
  pred.matrix <- matrix(data$prediction,
                        nrow = length(unique(data$long)),
                        ncol =length(unique(data$long)),
  )
  
  
  #plotting image
  plot <- fields::image.plot(pred.matrix, axes = TRUE,
                             xlab = "Longitude", ylab = "Latitude",
                             main = "Predicted Value by Location in US",
                             col = terrain.colors(100),
                             key.title = "Predicted Value")
  
  
  
  return(plot)
}
