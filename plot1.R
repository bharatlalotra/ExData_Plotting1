
# Code for plot1

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


# open device
png(filename='plot1.png',width=480,height=480,units='px')

# Plot histogram
hist(as.numeric(Relevant_Data$Global_active_power),col="red",xlab = "Global Active Power (kilowatts)", main="Global Active Power")

# close device
dev.off()

