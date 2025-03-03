% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{stations}
\alias{stations}
\title{Information on USCRN weather stations}
\format{
a dataframe with 5 columns
\describe{
\item{WBANNO}{The station WBAN number (unique identifier)}
\item{state}{Two-letter abbreviation of the station's state or territory}
\item{station_name}{Station name}
\item{LONGITUDE}{Longitude of station in decimal degrees }
\item{LATITUDE}{Latitude of station in decimal degrees}
}
}
\usage{
stations
}
\description{
A dataset containing information on each USCRN weather station, including
location (in longitude and latitude), state, and station name.
}
\keyword{datasets}
