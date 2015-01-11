## Author: Yung-Cheng Cheng
## E-mail: koopcheng@gmail.com
## Goal  : Project 1 (figure 2) of the Exploratory Data Analysis on Coursera. The goal is to examine how household energy usage varies over a 2-day period in February, 2007
## Format of the data file:
## 	     Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
## 	     16/12/2006;17:24:00;4.216;0.418;234.840;18.400;0.000;1.000;17.000
## Ref   :
## 	     1. to find all predefined types:
## 		  print(colClasses("-?cdfilnrzDP"))


## Set the working directory.
setwd( "D:/GitHub/Coursera/ExploratoryDataAnalysis/Project/ExData_Plotting1" );

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

## Make x tick label
powerCsptLog$Date	<- as.Date( powerCsptLog$Date, '%d/%m/%Y' )

## Make the figure.
library( datasets )
#par(bg = "white")
xticks <- weekdays( as.Date( subset( powerCsptLog$Date, powerCsptLog$Date == as.Date( "1/2/2007", '%d/%m/%Y' ) | powerCsptLog$Date == as.Date( "2/2/2007", '%d/%m/%Y' ) ), '%d/%m/%Y' ) )
with( subset( powerCsptLog, Date == as.Date( "1/2/2007", '%d/%m/%Y' ) | Date == as.Date( "2/2/2007", '%d/%m/%Y' ) ), plot( seq( from = 1, to = length( Global_active_power ) ), Global_active_power, type = "l", xaxt = "n", xlab = "", ylab = "Global Active Power (kilowatts)", main = "" ) )
axis( side = 1, at = c( seq( from = 1, to = length( xticks ), by=length( xticks )/2), length( xticks ) + 1 ),
      labels = c( strtrim( xticks[ seq( from = 1, to = length( xticks ), by=length( xticks )/2) ], 3 ), "Sat" ) )
dev.copy(png, file = "./figure/plot2.png", width=480, height=480) ## Copy my plot to a PNG file
dev.off() 