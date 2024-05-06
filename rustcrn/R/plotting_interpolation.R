#'Plot interpolated USCRN data on the US contiguous 48
#'
#'Using interpolated weather station data, draw a visual representation of the
#'predicted results in the form of a heat map-style plot of the US contiguous 48
#'states.
#'
#'See [fields::imagePlot], [grDevices::hcl.colors], [rustcrn::interpolation].
#'
#' @param value a vector of data corresponding to stations specified in \code{stations}
#' @param stations an optional numeric vector of station WBANNOs to use in interpolation
#' @param resolution numeric value for grid resolution
#' @param main plot title, default is "Predicted Value by Location in US"
#' @param palette a valid palette name to be passed to [grDevices::hcl.colors]
#' @param lines a logical indicating whether a map of the US should be drawn on top of the map
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
#' # change the plot title, palette, and remove state lines
#' plotting_interpolation( value, main = "Temperature trends",
#'                         palette = "Temps", lines = FALSE )
plotting_interpolation <- function(value, stations = NULL, resolution = 100,
                                   main = "Predicted Value by Location in US",
                                   palette = "Terrain",
                                   lines = TRUE, altitude = FALSE) {
  # get interpolated data
  data <- interpolation(value, stations, resolution)
  data$prediction <- ifelse(data$in_usa == 0, NA, data$prediction)
  data <- data[,-3]

  # make a matrix of the data
  pred.matrix <- matrix(data$prediction,
                        nrow = length(unique(data$long)),
                        ncol =length(unique(data$long)),
  )

  #plotting image
  plot <- fields::imagePlot(pred.matrix, axes = FALSE,
                            main = main,
                            col = grDevices::hcl.colors(64, palette = palette),
                            legend.width = 0.7, horizontal = FALSE,
                            asp = 0.5)

  if(lines) {
    usa <- ggplot2::map_data("state")
    usa$lons <- (usa[,1] - min(usa[,1]))/(max(usa[,1]) - min(usa[,1]))
    usa$lats <- (usa[,2] - min(usa[,2]))/(max(usa[,2]) - min(usa[,2]))
    invisible(tapply(usa, usa$group,
                     function(x) lines(x$lons, x$lats,
                                       lwd = 0.5, col = "grey30")))
  }
  # return(plot)
}
