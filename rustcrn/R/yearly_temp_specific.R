
#' Model the yearly temperature cycle of a specified USCRN weather station
#'
#' Get predicted values for each day of the year based on a sinusoidal model
#' fit on the USCRN average daily temperatures for a given research station.
#'
#' @param station_id The station ID (WBANNO number)
#'
#' @return A data frame containing two columns for the day of year (1-365) and predicted average temperatures for each day, in degrees Celsius.
#' @export
#'
#' @examples
yearly_cycle <- function(station_id) {
  # Extract necessary information by station ID
  ts <- time_series(station_id)[,c("LST_DATE", "T_DAILY_AVG")]
  ts$doy <- as.POSIXlt(ts$LST_DATE)$yday

  # Fit sinusoidal model to average temperature data
  # Fix with different wave function? some data not so smooth?
  year.lm <- lm(T_DAILY_AVG ~ cos(2*pi*doy/365) + sin(2*pi*doy/365),
                data = ts)

  preds <- predict(year.lm, newdata = list(doy = 1:365))

  # Return data frame with columns for DOY and predictions
  return(data.frame(doy = 1:365, t_daily_pred = preds))
}
