if(!require(dplyr)) install.packages("dplyr"); library(dplyr)

filename = "household_power_consumption.txt"
powerdata = read.table(filename, header=T, sep=";", dec=".", na.strings="?")
powerdata = powerdata %>% filter(Date=="1/2/2007" | Date=="2/2/2007")
powerdata$Date = powerdata$Date %>% as.Date(format="%d/%m/%Y")
powerdata$Time = powerdata$Time %>% strptime(format="%H:%M:%S")

title = "Global Active Power"
weekdays = c("Thu", "Fri", "Sat")
color3 = "#4100FF" #color pipette of Sub_metering_3 's color

png("plot4.png")
par(mfcol = c(2, 2), mar = c(4, 4, 2, 1))

#upper left == plot2 with changed ylab (getting rid of the "kilowatts")
plot.ts(powerdata$Global_active_power, axes=FALSE, frame.plot=TRUE, xlab="", ylab=title)
axis(1, at=c(0, length/2, length), labels=weekdays); axis(2)

#lower left == plot3
plot.ts(powerdata$Sub_metering_1, axes=FALSE, frame.plot=TRUE, xlab="", ylab="Energy sub metering")
axis(1, at=c(0, length/2, length), labels=weekdays); axis(2)
lines(powerdata$Sub_metering_2, col="red")
lines(powerdata$Sub_metering_3, col=color3)
legend("topright", lty=1, col=c("black", "red", color3), legend = paste0("Sub_metering_", 1:3))

#upper right
with(powerdata, plot.ts(Voltage, axes=FALSE, frame.plot=TRUE, xlab="datetime"))
axis(1, at=c(0, length/2, length), labels=weekdays)
axis(2, labels=FALSE) #just draw all ticks
axis(2, yaxp=c(234, 246, 3)) #draw fewer tick labels

#lower right
with(powerdata, plot.ts(Global_reactive_power, axes=FALSE, frame.plot=TRUE, xlab="datetime"))
axis(1, at=c(0, length/2, length), labels=weekdays); axis(2)

dev.off()
