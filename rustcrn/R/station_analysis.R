#' Create a time series for a USCRN weather station
#'
#' Get every entry recorded by USCRN for a given weather station, between
#' given start and end dates (default: the entire time series) in a data frame.
#'
#' @param station_id The station ID (WBANNO number)
#' @param start_date Start of time series (format YYYY-mm-dd)
#' @param end_date End of time series (format YYYY-mm-dd)
#'
#' @return A data frame containing the full time series from the start of data collection to the most recent date, or between user-specified dates.
#' @export
#'
#' @examples
time_series <- function(station_id, start_date = NULL, end_date = NULL) {
  # Filter data by station ID first
  station_data <- full_daily_weather %>% dplyr::filter(WBANNO == station_id)

  # Check and apply start date filter if provided
  if (!is.null(start_date)) {
    start_date <- as.Date(start_date)
    station_data <- station_data %>% dplyr::filter(LST_DATE >= start_date)
  }

  # Check and apply end date filter if provided
  if (!is.null(end_date)) {
    end_date <- as.Date(end_date)
    station_data <- station_data %>% dplyr::filter(LST_DATE <= end_date)
  }

  return(station_data)
}

#' Model the yearly temperature cycle of a specified USCRN weather station
#'
#' Get predicted values for each day of the year based on a sinusoidal model
#' fit on the USCRN average daily temperatures for a given research station.
#'
#' @param station_id The station ID (WBANNO number)
#'
#' @return A data frame containing two columns for the day of year (0-365) and predicted average temperatures for each day, in degrees Celsius.
#' @export
#'
#' @examples
yearly_cycle <- function(station_id) {
  # Extract necessary information by station ID
  ts <- time_series(station_id)[,c("LST_DATE", "T_DAILY_AVG")]
  ts$doy <- as.POSIXlt(ts$LST_DATE)$yday

  # Fit sinusoidal model to average temperature data
  year.lm <- lm(T_DAILY_AVG ~ cos(2*pi*doy/365) + sin(2*pi*doy/365),
                data = ts)

  preds <- predict(year.lm, newdata = list(doy = 0:365))

  # Return data frame with columns for DOY and predictions
  return(data.frame(doy = 0:365, t_daily_pred = preds))
}
