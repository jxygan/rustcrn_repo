#'Plot the interpolated data
#'
#'Using the interpolated data, produces a visual representation of predicted
#'results by plotting through image.plot
#'
#' @param value a vector of data corresponding to stations specified in \code{stations}
#' @param stations an optional numeric vector of station WBANNOs to use in interpolation
#' @param resolution numeric value for grid resolution
#'
#' @return \code{NULL}
#' @export
#'
#' @examples
#' # visualize predicted estimated trend of temperature of USA with
#' # resolution 100
#' tt_all <- temp_trend(rustcrn::stations$WBANNO)
#' value  <- tt_all[, 2]
#' plotting_interpolation( value )
#'
#' # visualize interpolation of every other station at a lower resolution
#' other <- rustcrn::stations$WBANNO[seq(2, nrow(rustcrn::stations), by = 2)]
#' value_other <- temp_trend(other)[,2]
#' plotting_interpolation( value_other, stations = other, resolution = 75 )
plotting_interpolation <- function(value, stations = NULL, resolution = 100) {
  #get interpolated data with
  data <- interpolation(value, stations, resolution)
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
