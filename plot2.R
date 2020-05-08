library(sqldf)
data <- data.table::fread("household_power_consumption.txt")
start <- as.Date("01/02/2007", "%d/%m/%Y")
end <- as.Date("02/02/2007", "%d/%m/%Y")
p <- sapply(as.Date(data$Date,  "%d/%m/%Y"), function(x) x >= start && x <= end)
actual_data <- data[p == TRUE, ]

combined <- paste(actual_data$Date, actual_data$Time, sep=" ")
datetime <- strptime(combined, "%d/%m/%Y %H:%M:%S")
globalActivePower <- as.numeric(actual_data$Global_active_power)
png("plot2.png", width=480, height=480)
plot(datetime, globalActivePower, type = "l", xlab = "", ylab="Global Active Power (kilowatts)")
dev.off()
