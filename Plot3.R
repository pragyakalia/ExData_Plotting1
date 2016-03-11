# Load required libraries
library(dplyr)
library(data.table)

# Download & read the household power consumption data
setwd("~/Exploratory Data Analysis")
datafile <- fread("~/Exploratory Data Analysis/household_power_consumption.txt", na.strings = "?", stringsAsFactors = FALSE)

# Subset the data for relevant dates
pwrdata <- filter(datafile, grep("^[1,2]/2/2007", Date))

# Convert relevant columns to numeric
pwrdata$Sub_metering_1 <- as.numeric(as.character(pwrdata$Sub_metering_1))
pwrdata$Sub_metering_2 <- as.numeric(as.character(pwrdata$Sub_metering_2))
pwrdata$Sub_metering_3 <- as.numeric(as.character(pwrdata$Sub_metering_3))


# to combine date & time data in a new column 
pwrdata.time <- paste(pwrdata$Date, pwrdata$Time)

# Plot3.R Create graph, annotate & save as png
png("plot3.png", width=480, height=480)
## plots date/time Vs Sub metering 1 data and add annotation
plot(strptime(pwrdata.time, "%d/%m/%Y %H: %M: %S"), pwrdata$Sub_metering_1, type ="l", xlab = "", ylab = "Energy sub metering")
## add line graph for date/time vs Sub metering 2 data in red
lines(strptime(pwrdata.time, "%d/%m/%Y %H: %M: %S"), pwrdata$Sub_metering_2, type ="l", col = "red")
## add line graph for date/time vs Sub metering 3 data in blue
lines(strptime(pwrdata.time, "%d/%m/%Y %H: %M: %S"), pwrdata$Sub_metering_3, type ="l", col = "blue")
## add legend 
legend("topright", lty = 1, col = c("Black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
