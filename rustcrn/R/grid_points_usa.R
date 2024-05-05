#'Create a grid of points that fall within the contiguous USA
#'
#'Get a data frame of grid points. Each row corresponds to a specific grid point,
#'containing its longitude, latitude, and whether it's inside the contiguous
#'United States.
#'
#'The longitudes and latitudes correspond to an \eqn{n \times n} grid with
#'points spanning the contiguous USA, with \eqn{n =} \code{resolution}
#'
#'
#' @param resolution integer value specifying the number of grid divisions
#'
#' @return A dataframe of grid points with longitude, latitude, and whether the point is inside the USA
#' \itemize{
#' \item \code{long} longitude
#' \item \code{lat} latitude
#' \item \code{in_usa} 1 if the point is in the contiguous USA, 0 otherwise
#' }
#' @export
#'
#' @examples
#' #grid with resolution 30, 900 points in total
#' grid_points_usa(30)
#'
#' #grid with default resolution (100), 10,000 points in total
#' grid_points_usa()

grid_points_usa <- function(resolution = 100){

  # Check if resolution is a non-negative integer
  if (!is.numeric(resolution) || resolution != as.integer(resolution)
      || resolution <= 0) {
    stop("Error! Resolution not integer")
  }

  # Gets map data for the USA
  usa_map <- ggplot2::map_data("usa")
  usa_map <- usa_map[usa_map$region == "main", ]

  #Square matrix of min max coordinates and resolution
  lons <- seq(min(usa_map$long),max(usa_map$long), length.out = resolution)
  lats <- seq(min(usa_map$lat),max(usa_map$lat), length.out = resolution)
  grid_square <- expand.grid(lons, lats)

  #Find points that overlap
  intersection <- sp::point.in.polygon(grid_square$Var1,grid_square$Var2,
                                       usa_map$long, usa_map$lat )


  #Use intersection to show if coordinates in USA location by 1,0
  grid_square$in_usa <- intersection

  #Rename columns to fit longitude latitude.
  names(grid_square)[1] <- "long"
  names(grid_square)[2] <- "lat"

  return(grid_square)
}
