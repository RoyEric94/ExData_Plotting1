# Read file into Data frame
data <- read.csv("../household_power_consumption.txt",sep=";",colClasses = c("Global_active_power"="character"))

# Convert Date column as Date type
data$Date <- as.Date(as.character(data$Date), "%d/%m/%Y")

# Replace all "?" in Global Active Power to be 0, then convert column to numeric
data$Global_active_power[data$Global_active_power == "?"] <- 0
data$Global_active_power <- as.numeric(data$Global_active_power)

# Only use the two days worth of data
data <- subset(data, data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02"))

# Generate and export the histogram according to the specifications
png(filename = "plot1.png", width = 480, height = 480)
hist(data$Global_active_power, col = "red",xlab="Global Active Power (kilowatts)",main = "Global Active Power")

# Close Graphics device
dev.off()