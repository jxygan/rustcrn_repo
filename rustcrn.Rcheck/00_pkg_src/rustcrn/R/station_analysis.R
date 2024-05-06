#' Create a time series for a USCRN weather station
#'
#' Get every entry recorded by USCRN for a given weather station, between
#' given start and end dates (default: the entire time series) in a data frame.
#'
#' @param station_id numeric station ID (WBANNO number)
#' @param start_date character string with format YYYY-mm-dd for start of time series
#' @param end_date character string with format YYYY-mm-dd for end of time series
#'
#' @return A data frame containing the full time series from the start of data collection to the most recent date, or between user-specified dates.
#' @export
#'
#' @examples
#' ithaca <- 64758
#' ithaca_ts <- time_series(ithaca)
#' ithaca_2010s <- time_series(ithaca, start_date = "2010-01-01",
#'                             end_date = "2019-12-31")
#' @importFrom rlang .data
time_series <- function(station_id, start_date = NULL, end_date = NULL) {
  # Filter data by station ID first
  station_data <-  dplyr::filter(rustcrn::full_daily_weather, .data$WBANNO == station_id)

  # Check and apply start date filter if provided
  if (!is.null(start_date)) {
    start_date <- as.Date(start_date)
    station_data <- dplyr::filter(station_data, .data$LST_DATE >= start_date)
  }

  # Check and apply end date filter if provided
  if (!is.null(end_date)) {
    end_date <- as.Date(end_date)
    station_data <- dplyr::filter(station_data, .data$LST_DATE <= end_date)
  }

  return(station_data)
}
