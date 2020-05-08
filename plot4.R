data <- data.table::fread("household_power_consumption.txt")
start <- as.Date("01/02/2007", "%d/%m/%Y")
end <- as.Date("02/02/2007", "%d/%m/%Y")
p <- sapply(as.Date(data$Date,  "%d/%m/%Y"), function(x) x >= start && x <= end)
actual_data <- data[p == TRUE, ]

# creating variables
combined <- paste(actual_data$Date, actual_data$Time, sep=" ")
datetime <- strptime(combined, "%d/%m/%Y %H:%M:%S")
globalActivePower <- as.numeric(actual_data$Global_active_power)
Voltage <- as.numeric(actual_data$Voltage)
globalReactivePower <- as.numeric(actual_data$Global_reactive_power)
sub_meter_1 <- as.numeric(actual_data$Sub_metering_1)
sub_meter_2 <- as.numeric(actual_data$Sub_metering_2)
sub_meter_3 <- actual_data$Sub_metering_3


png("plot4.png", width=480, height=480)
par(mfrow = c(2,2))

# plot 1
plot(datetime, globalActivePower, type = "l", xlab = "", ylab="Global Active Power (kilowatts)")

# plot 2
plot(datetime, Voltage, type = "l", xlab = "datetime", ylab="Voltage")

# plot 3
plot(datetime, sub_meter_1, type= "l", xlab = "", ylab = "Energy Sub Metering")
points(datetime, sub_meter_2, type = "l", col = "red")
points(datetime, sub_meter_3, type = "l", col = "blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=c(2,2), col=c("black","blue","red"))


# plot 4
plot(datetime, globalReactivePower, type= "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()
