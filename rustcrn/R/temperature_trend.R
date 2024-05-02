#' Get temperature trends for stations in the US contiguous 48
#'
#' Get a temperature change over time in degrees Celsius per year
#' for the contiguous 48 states, based on USCRN data.
#'
#' Temperature trends are modeled using a linear model with year and sinusoidal
#' components, to account for seasonality, and the function returns a small
#' summary of the model results including the coefficient for the year component
#' (the trend).
#'
#' @param station_ids vector of WBANNO numbers to get trends for specified stations.
#'
#' @return a data frame with four columns and n rows, where n is the number of stations in the input vector
#' \itemize{
#' \item \code{WBANNO} the station ID
#' \item \code{trend} trend of temperature change, in degrees Celsius per year
#' \item \code{p} the p-value of the year coefficient
#' \item \code{se} standard error of the model
#' }
#' @export
#'
#' @examples
#' # all stations
#' tt_all <- temp_trend(rustcrn::stations$WBANNO)
#'
#' # for Ithaca
#' tt_ithaca <- temp_trend(64758)
#' tt_ithaca[["trend"]]
temp_trend <- function(station_ids) {
  # create trend data frame
  trend <- as.data.frame(
    matrix(nrow = length(station_ids),
           ncol = 4,
           dimnames = list(NULL,
                           c("WBANNO", "trend", "p", "se"))))

  for(i in 1:length(station_ids)) {
    # fit model
    ts <- time_series(station_ids[i])
    doy <- as.POSIXlt(ts$LST_DATE)$yday

    avg_temp <- ts$T_DAILY_AVG
    year <- as.numeric(ts$LST_DATE - as.Date("2000-01-01"))/365.25

    tt <- stats::lm(avg_temp ~ year +
                      cos(2*pi*doy/365.25) +
                      sin(2*pi*doy/365.25) +
                      cos(4*pi*doy/365.25) +
                      sin(4*pi*doy/365.25))

    # add values to data frame
    trend[i, "WBANNO"] <- station_ids[i]
    trend[i, "trend"] <- tt$coefficients[2]
    trend[i, "p"] <- summary(tt)$coefficients[2,4]
    trend[i, "se"] <- stats::sigma(tt)
  }

  return(trend)
}
