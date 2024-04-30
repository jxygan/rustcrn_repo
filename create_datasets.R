# TODO: document datasets

# A dataset with one row for each station, providing information about the
# station identifier, station name, state, longitude, and latitude.

# The full daily dataset with the following columns:
#  • WBANNO, state, station name, LST_DATE, CRX_VN, LONGITUDE, LATITUDE,
#    T_DAILY_MAX, T_DAILY_MIN, T_DAILY_MEAN, T_DAILY_AVG, P_DAILY_CALC,
#    SOLARAD_DAILY
# Convert missing value codes into NAs. The date column should be in R’s date
# format. Be sure to document your dataset, explaining what each column means.

# Reads raw data, organized in folders by year
raw_names <- list.files(path = "raw_data",
                        recursive = TRUE,
                        full.names = TRUE)
# Reads header names
headers <- read.table("headers.txt")[29:56,]

# Read in raw data to a list of data frames
raw_data <- lapply( raw_names,
                    function(x) { read.table(x, col.names = headers) } )
# Name each list element with the file path
names(raw_data) <- raw_names

# Define names for full dataset
full_names <- c("WBANNO", "state", "station_name", "LST_DATE", "CRX_VN",
                "LONGITUDE", "LATITUDE",   "T_DAILY_MAX", "T_DAILY_MIN",
                "T_DAILY_MEAN", "T_DAILY_AVG", "P_DAILY_CALC", "SOLARAD_DAILY")

# Get how many rows are in each individual dataset + total rows
rows <- sapply(raw_data, function(x) {nrow(x)})
total_rows <- sum(rows)

# Create base data frame for full data set
full_data <- as.data.frame(matrix(NA, nrow = total_rows,
                                  ncol = length(full_names),
                                  dimnames = list(1:total_rows, full_names)))

# Loop through rows, adding data from each data frame into full data set
j <- 1
for(i in 1:total_rows) {
  raw <- raw_data[[i]]

  raw <- cbind(raw["WBANNO"],
               state = substring(raw_names[i], 29, 30),
               station_name =
                 substring(raw_names[i], 32, nchar(raw_names[i]) - 4),
               raw[,2:11])

  full_data[j:(j + rows[i] - 1),] <- raw
  j <- j + rows[i]
}

# Replace missing values with NA
full_data[full_data == -9999] <- NA

# Convert dates to Date objects
dates <- as.Date(as.character(full_data$LST_DATE), format = "%Y%m%d")
full_data$LST_DATE <- dates

# Write full dataset to file
saveRDS(full_data, file = "data/full_daily_weather.rds")
save(full_data, file = "data/full_daily_weather.RData")

# Collect individual station data by station identifier
station_data <- full_data[!duplicated(full_data["WBANNO"]),][,c("WBANNO",
                                                                "state",
                                                                "station_name",
                                                                "LONGITUDE",
                                                                "LATITUDE")]

# Write station data to file
saveRDS(station_data, file = "data/stations.rds")
save(station_data, file = "data/stations.RData")

# Read files into session
# full_daily_weather <- readRDS("data/full_daily_weather.rds")
# stations <- readRDS("data/stations.rds")
