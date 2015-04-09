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

png(file = "plot2.png")
with(data, plot(Date, Global_active_power,xlab = "", ylab = "Global Active Power (kilowatts)", type = "l"))
dev.off()