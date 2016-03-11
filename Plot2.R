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

# to combine date & time data in a new column 
pwrdata.time <- paste(pwrdata$Date, pwrdata$Time)

# Plot2.R -> plots line graph of date/time and global active power data
png("plot2.png", width=480, height=480)
plot(strptime(pwrdata.time, "%d/%m/%Y %H: %M: %S"), pwrdata$Global_active_power, type ="l", xlab = "", ylab = "Global Active Power(Kilowatts")
dev.off()