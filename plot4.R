# Read file into Data frame
data <- read.csv("../household_power_consumption.txt",sep=";",colClasses = c("Global_active_power"="character","Global_reactive_power"="character","Sub_metering_1"="character","Sub_metering_2"="character","Sub_metering_3"="character","Voltage"="character"))

# Convert Date column as Date type
data$Date <- as.Date(as.character(data$Date), "%d/%m/%Y")

# Only use the two days worth of data
data <- subset(data, data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02"))

# Get DateTime Object from the Date and Time columns so that we can have a progressive line chart
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

# Replace all "?" in Global Active Power to be 0, then convert column to numeric
data$Global_active_power[data$Global_active_power == "?"] <- 0
data$Global_active_power <- as.numeric(data$Global_active_power)

# Replace all "?" in Sub meterings to be 0, then convert columns to numeric
data$Sub_metering_1[data$Sub_metering_1 == "?"] <- 0
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2[data$Sub_metering_2 == "?"] <- 0
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3[data$Sub_metering_3 == "?"] <- 0
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

#Instanciate graphics device
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))

# FIRST PLOT (Essentially plot 2)
# Generate and export the line chart according to the specifications

plot(x=data$DateTime, y=data$Global_active_power,xlab="", ylab="Global Active Power (kilowatts)", type = "n")
lines(x=data$DateTime, y=data$Global_active_power)

# SECOND PLOT (Voltage X DateTime)
plot(x=data$DateTime, y=data$Voltage,xlab="datetime", ylab="Voltage", type = "n")
lines(x=data$DateTime, y=data$Voltage)

# THIRD PLOT (Essentially plot 3)
plot(x=data$DateTime, y=data$Sub_metering_1,xlab="", ylab="Energy sub metering", pch=".")
lines(x=data$DateTime, y=data$Sub_metering_1)
lines(x=data$DateTime, y=data$Sub_metering_2,col="red")
lines(x=data$DateTime, y=data$Sub_metering_3,col="blue")
# Add the legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty = 1,col = c("black","red","blue"))

# FOURTH PLOT (Global_Reactive_Power X DateTime)
plot(x=data$DateTime, y=data$Global_reactive_power,xlab="datetime", ylab="Global_reactive_power", type = "n")
lines(x=data$DateTime, y=data$Global_reactive_power)

# Close Graphics device
dev.off()