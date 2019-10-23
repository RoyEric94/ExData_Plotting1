# Read file into Data frame
data <- read.csv("../household_power_consumption.txt",sep=";",colClasses = c("Global_active_power"="character"))

# Convert Date column as Date type
data$Date <- as.Date(as.character(data$Date), "%d/%m/%Y")

# Only use the two days worth of data
data <- subset(data, data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02"))

# Get DateTime Object from the Date and Time columns so that we can have a progressive line chart
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

# Replace all "?" in Global Active Power to be 0, then convert column to numeric
data$Global_active_power[data$Global_active_power == "?"] <- 0
data$Global_active_power <- as.numeric(data$Global_active_power)

# Generate and export the line chart according to the specifications
png(filename = "plot2.png", width = 480, height = 480)
plot(x=data$DateTime, y=data$Global_active_power,xlab="", ylab="Global Active Power (kilowatts)", pch=".")
lines(x=data$DateTime, y=data$Global_active_power)

# Close Graphics device
dev.off()