data <- read.table('./exdata_data_household_power_consumption/household_power_consumption.txt', sep=';')
data[data=="?"] <- NA

colnames(data) <- data[1,]

data <- data[-1,]


df <- subset(data, Date == '1/2/2007')
df <- rbind(df,subset(data, Date == '2/2/2007'))

df$Date_time <- mapply(function(x, y) paste(x, y, sep=" "), df$Date, df$Time)
df$Date_time <- strptime(df$Date_time, "%d/%m/%Y %H:%M:%S")
df$Global_active_power <- as.numeric(df$Global_active_power)
df$Global_reactive_power <- as.numeric(df$Global_reactive_power)
df$Voltage <- as.numeric(df$Voltage)


plot(df$Date_time, df$Sub_metering_1, type='l', ylab='Energy sub metering', xlab='')
lines(df$Date_time, df$Sub_metering_2, type='l', col='red')
lines(df$Date_time, df$Sub_metering_3, type='l', col='blue')
legend('topright',legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col=c('black', 'red', 'blue'),lty=c(1,2,3), ncol=1)
