#'Plot interpolated USCRN data on the US contiguous 48
#'
#'Using interpolated weather station data, draw a visual representation of the
#'predicted results in the form of a heat map-style plot of the US contiguous 48
#'states.
#'
#'See [rustcrn::interpolation()], [fields::imagePlot()], [grDevices::hcl.colors()].
#'
#' @param interpolation the output of [rustcrn::interpolation()]; a data frame containing four columns \code{long, lat, in_usa, prediction}
#' @param main plot title, default is "Predicted Value by Location in US"
#' @param palette a valid palette name to be passed to [grDevices::hcl.colors()]
#' @param lines a logical indicating whether a map of the US should be drawn on top of the map
#'
#' @return \code{NULL}
#' @export
#'
#' @examples
#' # visualize a dummy dataset interpolated across the US
#' sub <- rustcrn::stations[ seq(1, nrow(rustcrn::stations), by = 4), ]
#' st <- as.numeric(as.factor(sub$state))
#' st_in <- interpolation(st ~ LONGITUDE + LATITUDE, data = sub,
#'                        resolution = 20)
#' plotting_interpolation( st_in, main = "Interpolation by state",
#'                         palette = "Spectral", lines = TRUE )
plotting_interpolation <- function(interpolation,
                                   main = "Predicted Value by Location in US",
                                   palette = "Terrain",
                                   lines = TRUE) {
  # get interpolated data
  data <- interpolation
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
