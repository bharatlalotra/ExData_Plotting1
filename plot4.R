
# Code for plot4

# Clear All Global Environiment Objects
rm(list = ls())


# Turn off warnings
options(warn=-1)

# Load Relevant Library(s)
library(dplyr)
library(rio)

# Read Names of .txt Files 
files=list.files(pattern = ".txt")

# Import .txt file content into a dataframe
Data=import(files)

# replace ? symbol with NA and remove rows with NA observations (optional step)
Data[ Data == "?" ] = NA
Data=Data[!is.na(Data$Global_active_power),]

# Extracing data between 2007-02-01 and 2007-02-02
DATE1 <- as.Date("2007-02-01")
DATE2 <- as.Date("2007-02-02")
Relevant_Data=filter(Data,as.Date(Data$Date, format='%d/%m/%Y')>=DATE1 & as.Date(Data$Date, format='%d/%m/%Y')<=DATE2)

# conversion from character to objects of classes "POSIXlt" and "POSIXct"
x = paste(Relevant_Data$Date, Relevant_Data$Time)
x=strptime(x, format="%d/%m/%Y  %H:%M:%S")


# open device
png(filename='plot4.png',width=480,height=480,units='px')


par(mfrow=c(2,2))

# Subplot 2,2,1 
plot(x,Relevant_Data$Global_active_power, type="l",ylab = "Global Active Power (kilowatts)",xlab ="" )


# subplot 2,2,2
plot(x,Relevant_Data$Voltage, type="l",ylab = "Voltage",xlab ="datetime" )


# subplot 2,2, 3
plot(x,Relevant_Data$Sub_metering_1, type="l",ylab = "Energy sub metering",xlab ="" ,col="black",ylim=c(0,38))
par(new=T)
plot(x,Relevant_Data$Sub_metering_2, type="l",ylab = "Energy sub metering",xlab ="" ,col="red",ylim=c(0,38))
par(new=T)
plot(x,Relevant_Data$Sub_metering_3, type="l",ylab = "Energy sub metering",xlab ="" ,col="blue",ylim=c(0,38))
legend("topright",  c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), # puts text in the legend 
       lty=c(1, 1,1),  # gives the legend appropriate symbols 
       col=c("black","red","blue")) # appropriate colors

# subplot 2,2,4
plot(x,Relevant_Data$Global_reactive_power, type="l",ylab = "Global_reactive_power",xlab ="datetime" )


# close device
dev.off()