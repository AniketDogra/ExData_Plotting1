library(sqldf)
data <- data.table::fread("household_power_consumption.txt")
start <- as.Date("01/02/2007", "%d/%m/%Y")
end <- as.Date("02/02/2007", "%d/%m/%Y")
p <- sapply(as.Date(data$Date,  "%d/%m/%Y"), function(x) x >= start && x <= end)
actual_data <- data[p == TRUE, ]

globalActivePower <- as.numeric(actual_data$Global_active_power)
png("plot1.png", width=480, height=480)
hist(globalActivePower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
