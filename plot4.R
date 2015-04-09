library(dplyr)
# Obtaining data
if (file.exists("household_power_consumption.txt") == FALSE) {
	download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "exdata_data_household_power_consumption.zip")
	unzip("exdata_data_household_power_consumption.zip")
}
chunk <- read.table("household_power_consumption.txt",sep = ";", header = TRUE, nrows = 5)
classes <- sapply(chunk, class)
data <- filter(read.table("household_power_consumption.txt",sep = ";", header = TRUE,  colClasses = classes, na.strings = "?"), Date == "1/2/2007" | Date == "2/2/2007")
data <- mutate(data, Date = paste(Date, Time))
data <- select(data, -Time)
data$Date <- strptime(data$Date, "%d/%m/%Y %H:%M:%S")

png(file = "plot4.png")
par(mfrow = c(2,2), mar = c(4,4,2,1))
with(data, {
	plot(Date, Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")
	plot(Date, Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
	{
	plot(Date, Sub_metering_1,xlab = "", ylab = "Energy sub metering", type = "l")
	points(Date, Sub_metering_2, type = "l", col = "red")
	points(Date, Sub_metering_3, type = "l", col = "blue")
	legend("topright",lty = 1, col = c("black", "red", "blue"),bty = "n", legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3" ))
	}
	plot(Date, Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")
})
dev.off()