## Author: Yung-Cheng Cheng
## E-mail: koopcheng@gmail.com
## Goal  : Project 1 of the Exploratory Data Analysis on Coursera. The goal is to examine how household energy usage varies over a 2-day period in February, 2007
## Format of the data file:
## 	     Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
## 	     16/12/2006;17:24:00;4.216;0.418;234.840;18.400;0.000;1.000;17.000
## Ref   :
## 	     1. to find all predefined types:
## 		  print(colClasses("-?cdfilnrzDP"))


## Set the working directory.
setwd( "D:/GitHub/Coursera/ExploratoryDataAnalysis/ExData_Plotting1" );

## Load the data
powerCsptLog <- read.table( "./data/household_power_consumption.txt", header=F, sep=";", colClasses = c( rep( "character", times=9 )), skip = 1, nrows = -1 )
names(powerCsptLog) <- c( "Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3" )

## Make summary and filter out the NA items
print( "== RAW data ======" );
summary( powerCsptLog )
# powerCsptLog 
powerCsptLog<- powerCsptLog[!apply(powerCsptLog, 1, function(x) {any(x == '?')}),]
print( "== Data after filtering ======" );
summary( powerCsptLog )
# powerCsptLog 

## Convert the column from 'character' to 'numeric' 
powerCsptLog$Global_active_power<-as.numeric(powerCsptLog$Global_active_power) 

## Make the figure.
library( datasets )
#par(bg = "white")
with( subset( powerCsptLog, Date == "1/2/2007" | Date == "2/2/2007" ), hist( Global_active_power, col = "red", breaks = 12, xlab="Global Active Power (kilowatts)", main = "Global Active Power" ) )
dev.copy(png, file = "./figure/plot1.png", width=480, height=480) ## Copy my plot to a PNG file
dev.off() 