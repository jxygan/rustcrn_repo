pkgname <- "rustcrn"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
base::assign(".ExTimings", "rustcrn-Ex.timings", pos = 'CheckExEnv')
base::cat("name\tuser\tsystem\telapsed\n", file=base::get(".ExTimings", pos = 'CheckExEnv'))
base::assign(".format_ptime",
function(x) {
  if(!is.na(x[4L])) x[1L] <- x[1L] + x[4L]
  if(!is.na(x[5L])) x[2L] <- x[2L] + x[5L]
  options(OutDec = '.')
  format(x[1L:3L], digits = 7L)
},
pos = 'CheckExEnv')

### * </HEADER>
library('rustcrn')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("grid_points_usa")
### * grid_points_usa

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: grid_points_usa
### Title: Create a grid of points that fall within the contiguous USA
### Aliases: grid_points_usa

### ** Examples

#grid with resolution 30, 900 points in total
grid_points_usa(30)

#grid with default resolution (100), 10,000 points in total
grid_points_usa()



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("grid_points_usa", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("interpolation")
### * interpolation

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: interpolation
### Title: Interpolate USCRN station data to grid points within the
###   contiguous USA
### Aliases: interpolation

### ** Examples

# To get data frame of predicted estimated trend of temperature of USA with
# resolution 100
tt_all <- temp_trend(rustcrn::stations$WBANNO)
value  <- tt_all[, 2]
int_all <- interpolation( value )

# Interpolation of every other station at a lower resolution
other <- rustcrn::stations$WBANNO[seq(2, nrow(rustcrn::stations), by = 2)]
value_other <- temp_trend(other)[,2]
int_other <- interpolation( value_other, stations = other, resolution = 75 )



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("interpolation", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plotting_interpolation")
### * plotting_interpolation

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plotting_interpolation
### Title: Plot interpolated USCRN data on the US contiguous 48
### Aliases: plotting_interpolation

### ** Examples

# visualize predicted estimated trend of temperature of USA with
# resolution 100
tt_all <- temp_trend(rustcrn::stations$WBANNO)
value  <- tt_all[, 2]
plotting_interpolation( value )

# change the plot title, palette, and remove state lines
plotting_interpolation( value, main = "Temperature trends",
                        palette = "Temps", lines = FALSE )



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plotting_interpolation", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("temp_trend")
### * temp_trend

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: temp_trend
### Title: Get temperature trends for stations in the US contiguous 48
### Aliases: temp_trend

### ** Examples

# all stations
tt_all <- temp_trend(rustcrn::stations$WBANNO)

# for Ithaca
tt_ithaca <- temp_trend(64758)
tt_ithaca[["trend"]]



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("temp_trend", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("time_series")
### * time_series

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: time_series
### Title: Create a time series for a USCRN weather station
### Aliases: time_series

### ** Examples

ithaca <- 64758
ithaca_ts <- time_series(ithaca)
ithaca_2010s <- time_series(ithaca, start_date = "2010-01-01",
                            end_date = "2019-12-31")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("time_series", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("yearly_cycle")
### * yearly_cycle

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: yearly_cycle
### Title: Model the yearly temperature cycle of a specified USCRN weather
###   station
### Aliases: yearly_cycle

### ** Examples

ithaca <- 64758
ithaca_cycle <- yearly_cycle(ithaca)
plot(t_daily_pred ~ doy, data = ithaca_cycle, type = "l")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("yearly_cycle", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
