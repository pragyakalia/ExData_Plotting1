# Load required libraries
library(dplyr)
library(data.table)

# Download & read the household power consumption data
setwd("~/Exploratory Data Analysis")
datafile <- fread("~/Exploratory Data Analysis/household_power_consumption.txt", na.strings = "?", stringsAsFactors = FALSE)

# Subset the data for relevant dates
pwrdata <- filter(datafile, grep("^[1,2]/2/2007", Date))

# Convert relevant columns to numeric
pwrdata$Global_active_power <- as.numeric(as.character(pwrdata$Global_active_power))
pwrdata$Global_reactive_power <- as.numeric(as.character(pwrdata$Global_reactive_power))
pwrdata$Sub_metering_1 <- as.numeric(as.character(pwrdata$Sub_metering_1))
pwrdata$Sub_metering_2 <- as.numeric(as.character(pwrdata$Sub_metering_2))
pwrdata$Sub_metering_3 <- as.numeric(as.character(pwrdata$Sub_metering_3))
pwrdata$Voltage <- as.numeric(as.character(pwrdata$Voltage))

# to combine date & time data in a new column 
pwrdata.time <- paste(pwrdata$Date, pwrdata$Time)

# Plot4.R Create 4 graphs & save as png
png("plot4.png", width=480, height=480)
## Set parameters for 4 graphs in 2*2 by column
par(mfcol = c(2,2))

## for Graph 1 in column 1
plot(strptime(pwrdata.time, "%d/%m/%Y %H: %M: %S"), pwrdata$Global_active_power, type ="l", xlab = "", ylab = "Global Active Power(Kilowatts")

## for Graph 2 in column 1
plot(strptime(pwrdata.time, "%d/%m/%Y %H: %M: %S"), pwrdata$Sub_metering_1, type ="l", xlab = "", ylab = "Energy sub metering")
lines(strptime(pwrdata.time, "%d/%m/%Y %H: %M: %S"), pwrdata$Sub_metering_2, type ="l", col = "red")
lines(strptime(pwrdata.time, "%d/%m/%Y %H: %M: %S"), pwrdata$Sub_metering_3, type ="l", col = "blue")
legend("topright", lty = 1, col = c("Black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## for Graph 3 in column 2
plot(strptime(pwrdata.time, "%d/%m/%Y %H: %M: %S"), pwrdata$Voltage, type ="l", xlab = "datetime", ylab = "Voltage")

## for Graph 4 in column 2
plot(strptime(pwrdata.time, "%d/%m/%Y %H: %M: %S"), pwrdata$Global_reactive_power, type ="l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()

