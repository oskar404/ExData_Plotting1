# Exploratory Data Analysis Course Project 1
#
# Copyright (c) 2017 Oskar Lönnberg
#
# Creates histogram plot1.png "Global Active Power"

library(graphics)
library(grDevices)

# Download the data if it does not exist, unzip it and return the data filename.
#
download_data <- function() {
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    zip_file <- "household_power_consumption.zip"
    if (!file.exists(zip_file)) {
        download.file(url, zip_file)
        unzip(zip_file)
    }
    "household_power_consumption.txt"
}

# Read and subset of the data used for exploratory analysis
#
read_data <- function() {
    fn <- download_data()
    df <- read.table(fn, header = TRUE, sep=";")
    df <- df[grepl("^(1|2)/2/2007", df$Date),]
    df$Time <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")
    df$Date <- as.Date(df$Date, "%d/%m/%Y")
    df
}

# Create the historgram
print("Reading data ..")
df <- read_data()
print("Creating histogram ..")
active_power <- as.numeric(as.character(df$Global_active_power))
png(filename = "plot1.png", bg = "transparent", width = 480, height = 480)
hist(active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")
dev.off()