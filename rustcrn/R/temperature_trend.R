#' Get the overall temperature trend in the US contiguous 48
#'
#' Get a model of temperature change over time in degrees Celsius per year
#' for the contiguous 48 states, based on USCRN data.
#'
#' @param station_id optional numeric WBANNO number for specified station
#'
#' @return a linear model of class merMod or lm
#' @export
#'
#' @examples
#' # all stations
#' tt_all <- temp_trend()
#' summary(tt_all)
#'
#' # for Ithaca
#' tt_ithaca <- temp_trend(64758)
#' summary(tt_ithaca)
temp_trend <- function(station_id = NULL) {
  # pull trend from one station
  if(!is.null(station_id)) {
    ts <- time_series(station_id)
    avg_temp <- ts$T_DAILY_AVG
    year <- as.numeric(ts$LST_DATE - as.Date("2000-01-01"))/365.25

    tt <- lm(avg_temp ~ year)
    return(tt)
  }

  # pull trend from all stations
  # get daily avg temps and express DOY as years since 2000
  avg_temp <- full_daily_weather$T_DAILY_AVG
  year <- as.numeric(full_daily_weather$LST_DATE - as.Date("2000-01-01"))/365.25

  # model with station IDs as random effects
  WBANNO <- full_daily_weather$WBANNO
  tt <- lme4::lmer(avg_temp ~ year + (1|WBANNO))

  return(tt)
}
