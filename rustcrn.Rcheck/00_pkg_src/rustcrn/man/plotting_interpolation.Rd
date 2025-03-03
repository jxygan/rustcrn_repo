% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotting_interpolation.R
\name{plotting_interpolation}
\alias{plotting_interpolation}
\title{Plot interpolated USCRN data on the US contiguous 48}
\usage{
plotting_interpolation(
  value,
  stations = NULL,
  resolution = 100,
  main = "Predicted Value by Location in US",
  palette = "Terrain",
  lines = TRUE
)
}
\arguments{
\item{value}{a vector of data corresponding to stations specified in \code{stations}}

\item{stations}{an optional numeric vector of station WBANNOs to use in interpolation}

\item{resolution}{numeric value for grid resolution}

\item{main}{plot title, default is "Predicted Value by Location in US"}

\item{palette}{a valid palette name to be passed to [grDevices::hcl.colors]}

\item{lines}{a logical indicating whether a map of the US should be drawn on top of the map}
}
\value{
\code{NULL}
}
\description{
Using interpolated weather station data, draw a visual representation of the
predicted results in the form of a heat map-style plot of the US contiguous 48
states.
}
\details{
See [fields::imagePlot], [grDevices::hcl.colors], [rustcrn::interpolation].
}
\examples{
# visualize predicted estimated trend of temperature of USA with
# resolution 100
tt_all <- temp_trend(rustcrn::stations$WBANNO)
value  <- tt_all[, 2]
plotting_interpolation( value )

# change the plot title, palette, and remove state lines
plotting_interpolation( value, main = "Temperature trends",
                        palette = "Temps", lines = FALSE )
}
