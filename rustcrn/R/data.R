
#'Information on USCRN weather stations
#'
#'A dataset containing information on each USCRN weather station, including
#'location (in longitude and latitude), state, and station name.
#'
#' @format a dataframe with 5 columns
#' \describe{
#' \item{WBANNO}{The station WBAN number (unique identifier)}
#' \item{state}{Two-letter abbreviation of the station's state or territory}
#' \item{station_name}{Station name}
#' \item{LONGITUDE}{Longitude of station in decimal degrees }
#' \item{LATITUDE}{Latitude of station in decimal degrees}
#' }
#'
"stations"


#'USCRN station daily weather data
#'
#'A dataset containing daily weather data from each USCRN weather station, from
#'2000-11-14 to 2024-04-07.
#'
#' @format a dataframe with 13 columns
#' \describe{
#' \item{WBANNO}{The station WBAN number}
#' \item{state}{The station's located state }
#' \item{station_name}{Station name}
#' \item{LST_DATE}{Date of weather recorded in YYYMMDD}
#' \item{CRX_VN}{The version number of the station datalogger program that was
#' in effect at the time of the observation}
#' \item{LONGITUDE}{Longitude of station in decimal degrees }
#' \item{LATITUDE}{Latitude of station in decimal degrees}
#' \item{T_DAILY_MAX}{Maximum air temperature, in degrees C}
#' \item{T_DAILY_MIN}{Minimum air temperature, in degrees C}
#' \item{T_DAILY_MEAN}{Mean air temperature, in degrees C, calculated using the
#'  typical historical approach: (T_DAILY_MAX + T_DAILY_MIN) / 2}
#' \item{T_DAILY_AVG}{Average air temperature, in degrees C}
#' \item{P_DAILY_CALC}{ Total amount of precipitation, in mm}
#' \item{SOLARAD_DAILY}{Total solar energy, in MJ/meter^2, calculated from the
#' hourly average global solar radiation rates and converted to energy by
#'  integrating over time.}
#' }
"full_daily_weather"
