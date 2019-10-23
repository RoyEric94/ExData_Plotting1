# Read file into Data frame
data <- read.csv("../household_power_consumption.txt",sep=";",colClasses = c("Sub_metering_1"="character","Sub_metering_2"="character","Sub_metering_3"="character"))

# Convert Date column as Date type
data$Date <- as.Date(as.character(data$Date), "%d/%m/%Y")

# Only use the two days worth of data
data <- subset(data, data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02"))

# Get DateTime Object from the Date and Time columns so that we can have progressive line charts
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

# Replace all "?" in Sub meterings to be 0, then convert columns to numeric
data$Sub_metering_1[data$Sub_metering_1 == "?"] <- 0
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2[data$Sub_metering_2 == "?"] <- 0
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3[data$Sub_metering_3 == "?"] <- 0
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)


# Generate and export the three line charts according to the specifications
png(filename = "plot3.png", width = 480, height = 480)
plot(x=data$DateTime, y=data$Sub_metering_1,xlab="", ylab="Energy sub metering", pch=".")
lines(x=data$DateTime, y=data$Sub_metering_1)
lines(x=data$DateTime, y=data$Sub_metering_2,col="red")
lines(x=data$DateTime, y=data$Sub_metering_3,col="blue")
# Add the legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty = 1,col = c("black","red","blue"))

# Close Graphics device
dev.off()