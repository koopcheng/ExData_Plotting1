## Author: Yung-Cheng Cheng
## E-mail: koopcheng@gmail.com
## Goal  : Project 1 (figure 4) of the Exploratory Data Analysis on Coursera. The goal is to examine how household energy usage varies over a 2-day period in February, 2007
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
powerCsptLog$Sub_metering_1<-as.numeric(powerCsptLog$Sub_metering_1) 
powerCsptLog$Sub_metering_2<-as.numeric(powerCsptLog$Sub_metering_2) 
powerCsptLog$Sub_metering_3<-as.numeric(powerCsptLog$Sub_metering_3)  
powerCsptLog$Global_reactive_power<-as.numeric(powerCsptLog$Global_reactive_power) 
powerCsptLog$Voltage<-as.numeric(powerCsptLog$Voltage) 

## Make x tick label
powerCsptLog$Date	<- as.Date( powerCsptLog$Date, '%d/%m/%Y' )

## Make the figure.
library( datasets )
#par(bg = "white")
attach(mtcars)
par(mfrow=c(2,2))

## the top-left sub-figure
xticks <- weekdays( as.Date( subset( powerCsptLog$Date, powerCsptLog$Date == as.Date( "1/2/2007", '%d/%m/%Y' ) | powerCsptLog$Date == as.Date( "2/2/2007", '%d/%m/%Y' ) ), '%d/%m/%Y' ) )
with( subset( powerCsptLog, Date == as.Date( "1/2/2007", '%d/%m/%Y' ) | Date == as.Date( "2/2/2007", '%d/%m/%Y' ) ), plot( seq( from = 1, to = length( Global_active_power ) ), Global_active_power, type = "l", xaxt = "n", xlab = "", ylab = "Global Active Power", main = "" ) )
axis( side = 1, at = c( seq_along( xticks )[!duplicated( xticks  )], length( xticks ) + 1 ),
      labels = c( strtrim( xticks[!duplicated( xticks )], 3 ), "Sat" ) )

## the top-right sub-figure
with( subset( powerCsptLog, Date == as.Date( "1/2/2007", '%d/%m/%Y' ) | Date == as.Date( "2/2/2007", '%d/%m/%Y' ) ), plot( seq( from = 1, to = length( Voltage ) ), Voltage, type = "l", xaxt = "n", xlab = "datetime", ylab = "Voltage", main = "" ) )
axis( side = 1, at = c( seq_along( xticks )[!duplicated( xticks  )], length( xticks ) + 1 ),
      labels = c( strtrim( xticks[!duplicated( xticks )], 3 ), "Sat" ) )

## the bottom-left sub-figure
with( subset( powerCsptLog, Date == as.Date( "1/2/2007", '%d/%m/%Y' ) | Date == as.Date( "2/2/2007", '%d/%m/%Y' ) ),
	plot( seq( from = 1, to = length( Sub_metering_1 ) ), Sub_metering_1, type = "l", col="black", xaxt = "n", xlab = "", ylab = "Energy sub metering", main = "" ) )
with( subset( powerCsptLog, Date == as.Date( "1/2/2007", '%d/%m/%Y' ) | Date == as.Date( "2/2/2007", '%d/%m/%Y' ) ),
	lines( Sub_metering_2, type = "l", col = "red" ) )
with( subset( powerCsptLog, Date == as.Date( "1/2/2007", '%d/%m/%Y' ) | Date == as.Date( "2/2/2007", '%d/%m/%Y' ) ),
	lines( Sub_metering_3, type = "l", col = "blue" ) )

legend( "topright", legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ), col = c( "red", "black", "blue" ), lwd=1, bty = "n" )

axis( side = 1, at = c( seq_along( xticks )[!duplicated( xticks  )], length( xticks ) + 1 ),
      labels = c( strtrim( xticks[!duplicated( xticks )], 3 ), "Sat" ) )

## the bottom-right sub-figure
with( subset( powerCsptLog, Date == as.Date( "1/2/2007", '%d/%m/%Y' ) | Date == as.Date( "2/2/2007", '%d/%m/%Y' ) ), plot( seq( from = 1, to = length( Global_reactive_power ) ), Global_reactive_power, type = "l", xaxt = "n", xlab = "datetime", ylab = "Global reactive power", main = "" ) )
axis( side = 1, at = c( seq_along( xticks )[!duplicated( xticks  )], length( xticks ) + 1 ),
      labels = c( strtrim( xticks[!duplicated( xticks )], 3 ), "Sat" ) )

dev.copy(png, file = "./figure/plot4.png", width=480, height=480)
dev.off() 