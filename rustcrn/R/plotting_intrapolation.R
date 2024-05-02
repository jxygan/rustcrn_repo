
################################ 9

#the input is the interpolated data and grid points of all (including us and not)

plotting_interpolation <- function(data) {

  #make a matrix of the data
  pred.matrix <- matrix(data, nrow = length(data$long), ncol = length(data$lat),
                        dimnames = list(lons, lats))

  imgX <- list(x = lons, y = lats, z = pred.matrix)

  #plot the intrapolation
  xline <- unique(data$long)
  yline <- unique(data$lat)
  fields::image.plot( xline, yline , imgX, xlab = "Longitude" , ylab = "Latitude",
                      main = "Predicted vallue by location in US" )

}
