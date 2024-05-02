library(sp)
library(dplyr)
library(ggplot2)
#####################

grid_points_usa <- function(resolution){

  # Get map data for the USA
  usa_map <- ggplot2::map_data("usa")
  usa_map <- usa_map[usa_map$region == "main", ]

  #square matrix of min max coordinates
  lons <- seq(min(usa_map$long),max(usa_map$long), length.out = resolution)
  lats <- seq(min(usa_map$lat),max(usa_map$lat), length.out = resolution)
  grid_square <- expand.grid(lons, lats)

  #find intersection points
  intersection <- sp::point.in.polygon(grid_square$Var1,grid_square$Var2,
                                       usa_map$long, usa_map$lat )


  #Use intersection points to show if coordinates in USA location
  grid_square$in_us <- intersection
  names(grid_square)[1] <- "long"
  names(grid_square)[2] <- "lat"

  return(grid_square)
}

#returns a row of all grid points and if it is in USA

#test
result <- grid_points_usa(100)
result

