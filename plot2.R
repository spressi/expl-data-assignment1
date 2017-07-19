if(!require(dplyr)) install.packages("dplyr"); library(dplyr)

filename = "household_power_consumption.txt"
powerdata = read.table(filename, header=T, sep=";", dec=".", na.strings="?")
powerdata = powerdata %>% filter(Date=="1/2/2007" | Date=="2/2/2007")
powerdata$Date = powerdata$Date %>% as.Date(format="%d/%m/%Y")
powerdata$Time = powerdata$Time %>% strptime(format="%H:%M:%S")

axislab = "Global Active Power (kilowatts)"
length = powerdata$Global_active_power %>% length()

# this doesn't work since the locale on my machine is set to German :)
# weekdays = powerdata$Date %>% unique()
# weekdays = c(weekdays, max(weekdays)+1) %>% weekdays(abbreviate=TRUE)
weekdays = c("Thu", "Fri", "Sat") #so I hard-coded the xlab

png("plot2.png")
plot.ts(powerdata$Global_active_power, axes=FALSE, frame.plot=TRUE, xlab="", ylab=axislab)
axis(1, at=c(0, length/2, length), labels=weekdays); axis(2)
dev.off()
