if(!require(dplyr)) install.packages("dplyr"); library(dplyr)
if(!require(gplots)) install.packages("gplots")

filename = "household_power_consumption.txt"
powerdata = read.table(filename, header=T, sep=";", dec=".", na.strings="?")
powerdata = powerdata %>% filter(Date=="1/2/2007" | Date=="2/2/2007")
powerdata$Date = powerdata$Date %>% as.Date(format="%d/%m/%Y")
powerdata$Time = powerdata$Time %>% strptime(format="%H:%M:%S")

color3 = "#4100FF" #color pipette of Sub_metering_3 's color
colors()[gplots::col2hex(colors())==color3] #check if color exists as color name? 
#No => use hex

png("plot3.png")
plot.ts(powerdata$Sub_metering_1, axes=FALSE, frame.plot=TRUE, xlab="", ylab="Energy sub metering")
axis(1, at=c(0, length/2, length), labels=weekdays); axis(2)
lines(powerdata$Sub_metering_2, col="red")
lines(powerdata$Sub_metering_3, col=color3)
legend("topright", lty=1, col=c("black", "red", color3), legend = paste0("Sub_metering_", 1:3))
dev.off()
