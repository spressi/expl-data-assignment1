if(!require(dplyr)) install.packages("dplyr"); library(dplyr)

filename = "household_power_consumption.txt"
powerdata = read.table(filename, header=T, sep=";", dec=".", na.strings="?")
powerdata = powerdata %>% filter(Date=="1/2/2007" | Date=="2/2/2007")
powerdata$Date = powerdata$Date %>% as.Date(format="%d/%m/%Y")
powerdata$Time = powerdata$Time %>% strptime(format="%H:%M:%S")

title = "Global Active Power"
axislab = "Global Active Power (kilowatts)"

png("plot1.png")
hist(powerdata$Global_active_power, col="red", main=title, xlab=axislab)
dev.off()
