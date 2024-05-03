#'Plot the interpolated data
#'
#'Using the intrapolated data, produces a visual representation of predicted
#'results by plotting through image.plot
#'
#' @param value a vector of data corresponding to 236 station locations
#' @param resolution numeric value for resolution of map
#'
#' @return Produce visual representation of spatial predictions
#' @export
#'
#' @example
#' plotting_interpolation(data)
#' 
plotting_interpolation <- function(value, resolution) {
  #get interpolated data with 
  data <- interpolation(value, resolution)
  
  #make a matrix of the data
  pred.matrix <- matrix(data[4], nrow = length(data$long), ncol = length(data$lat),
                        dimnames = list(long, lats))
  
  imgX <- list(x = lons, y= lats, z = pred.matrix)
  
  #plot the interpolation
  xline <- unique(data$long)
  yline <- unique(data$lat)
  
  for (i in 1:nrow(data)) {
    if (data$in_us[i] == 1) {  # Check if the point is in the US
      fields::image.plot(xline, yline, imgX$z,
                         xlab = "Longitude", ylab = "Latitude",
                         main = "Predicted Value by Location in US",
                         col = fields::tim.colors(256),
                         xaxt = "n", yaxt = "n",
                         xlim = range(xline), ylim = range(yline),
                         cex.main = 1.5,
                         cex.lab = 1.2,
                         cex.axis = 1.1,
                         key.title = "Predicted Value",
                         key.axes = axis(1, at = pretty(imgX$z), labels = format(pretty(imgX$z), nsmall = 2))  # Custom key axis
      )
      axis(1, at = pretty(xline), labels = format(pretty(xline), nsmall = 2))
      axis(2, at = pretty(yline), labels = format(pretty(yline), nsmall = 2))
      box()
      break
    }
  }
}


