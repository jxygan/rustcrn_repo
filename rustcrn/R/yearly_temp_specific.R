#' Model the yearly temperature cycle of a specified USCRN weather station
#'
#' Get predicted values for each day of the year based on a sinusoidal model
#' fit on the USCRN average daily temperatures for a given research station.
#'
#' @param station_id The station ID (WBANNO number)
#'
#' @return A data frame containing two columns:
#' \itemize{
#' \item \code{doy} the day of year (1-365)
#' \item \code{t_daily_pred} predicted average temperatures for each day, in degrees Celsius
#' }
#'
#' @examples
#' ithaca <- 64758
#' ithaca_cycle <- yearly_cycle(ithaca)
#' plot(t_daily_pred ~ doy, data = ithaca_cycle, type = "l")
#' @export
yearly_cycle <- function(station_id) {
  # Extract necessary information by station ID
  ts <- time_series(station_id)[,c("LST_DATE", "T_DAILY_AVG")]
  ts$doy <- as.POSIXlt(ts$LST_DATE)$yday

  # Fit sinusoidal model to average temperature data, including the
  # second harmonic
  year.lm <- stats::lm(T_DAILY_AVG ~ cos(2*pi*doy/365.25) + sin(2*pi*doy/365.25) +
                  cos(4*pi*doy/365.25) + sin(4*pi*doy/365.25),
                data = ts)

  preds <- stats::predict(year.lm, newdata = list(doy = 1:365))

  # Return data frame with columns for DOY and predictions
  return(data.frame(doy = 1:365, t_daily_pred = preds))
}
