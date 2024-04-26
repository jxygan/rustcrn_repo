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
  station_data <- full_daily_weather |> dplyr::filter(WBANNO == station_id)

  # Check and apply start date filter if provided
  if (!is.null(start_date)) {
    start_date <- as.Date(start_date)
    station_data <- station_data |> dplyr::filter(LST_DATE >= start_date)
  }

  # Check and apply end date filter if provided
  if (!is.null(end_date)) {
    end_date <- as.Date(end_date)
    station_data <- station_data |> dplyr::filter(LST_DATE <= end_date)
  }

  return(station_data)
}
