data <- data.table::fread("household_power_consumption.txt")
start <- as.Date("01/02/2007", "%d/%m/%Y")
end <- as.Date("02/02/2007", "%d/%m/%Y")
p <- sapply(as.Date(data$Date,  "%d/%m/%Y"), function(x) x >= start && x <= end)
actual_data <- data[p == TRUE, ]

combined <- paste(actual_data$Date, actual_data$Time, sep=" ")
datetime <- strptime(combined, "%d/%m/%Y %H:%M:%S")
sub_meter_1 <- as.numeric(actual_data$Sub_metering_1)
sub_meter_2 <- as.numeric(actual_data$Sub_metering_2)
sub_meter_3 <- actual_data$Sub_metering_3
png("plot3.png", width=480, height=480)
plot(datetime, sub_meter_1, type= "l", xlab = "", ylab = "Energy Sub Metering")
points(datetime, sub_meter_2, type = "l", col = "red")
points(datetime, sub_meter_3, type = "l", col = "blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=c(2,2), col=c("black","blue","red"))
dev.off()
