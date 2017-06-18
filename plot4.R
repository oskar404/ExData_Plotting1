# Exploratory Data Analysis Course Project 1
#
# Copyright (c) 2017 Oskar Lönnberg
#
# Creates plot4.png showing multiple plots

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
print("Creating plot ..")

png(filename = "plot4.png", bg = "transparent", width = 480, height = 480)
par(mfcol = c(2,2))

# Create subplot 1
active_power <- as.numeric(as.character(df$Global_active_power))
plot(df$Time, active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)" )

# Create subplot 2
sub1 <- as.numeric(as.character(df$Sub_metering_1))
sub2 <- as.numeric(as.character(df$Sub_metering_2))
sub3 <- as.numeric(as.character(df$Sub_metering_3))
plot(df$Time, sub1, type = "n", xlab = "", ylab = "Energy sub metering" )
lines(df$Time, sub1, col = "black")
lines(df$Time, sub2, col = "red")
lines(df$Time, sub3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Create subplot 3
voltage <- as.numeric(as.character(df$Voltage))
plot(df$Time, voltage, type = "l", xlab = "datetime", ylab = "Voltage" )

# Create subplot 4
reactive_power <- as.numeric(as.character(df$Global_reactive_power))
plot(df$Time, reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power" )

dev.off()