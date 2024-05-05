#'Create a grid of points that fall within the contiguous USA
#'
#'Get a data frame of grid points. Each row corresponding to a specific grid point,
#'showing its longitude, latitude, and whether it's inside the USA by binary.
#'
#'
#' @param resolution numeric value for resolution of map
#'
#' @return A dataframe of grid points with longitude, latitude, and whether it's inside the USA
#' @export
#'
#' @examples 
#' #grid with resolution 30
#' grid_points_usa(30)
#'
#' #grid with resolution 100
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