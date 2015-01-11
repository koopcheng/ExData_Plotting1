# Author: Yung-Cheng Cheng
# E-mail: koopcheng@gmail.com
# Goal  : Project 1 of the Exploratory Data Analysis on Coursera. The goal is to examine how household energy usage varies over a 2-day period in February, 2007



# Load file:
# data format: Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
#		   16/12/2006;17:24:00;4.216;0.418;234.840;18.400;0.000;1.000;17.000
# All predefined types
# print(colClasses("-?cdfilnrzDP"))


setwd( "D:/GitHub/Coursera/ExploratoryDataAnalysis/ExData_Plotting1" );

#powerCsptLog <- read.table( "./data/household_power_consumption.txt", header=F, sep=";", skip = 10, nrows = 2 )
#options(error=recover)

#powerCsptLog <- read.csv( file = "./data/household_power_consumption.txt", head = TRUE, sep=";", colClasses = c( "character", "character", rep( "numeric", times=7 ) ) )
# powerCsptLog 
# powerCsptLog <- powerCsptLog[ powerCsptLog[,3:8]!= '?' ]
# powerCsptLog[apply(powerCsptLog, 1, function(x) {any(x == '?')}),]


powerCsptLog <- read.table( "./data/household_power_consumption.txt", header=F, sep=";", colClasses = c( rep( "character", times=9 )), skip = 1, nrows = -1 )
names(powerCsptLog) <- c( "Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3" )
#powerCsptLog
summary( powerCsptLog )
powerCsptLog<- powerCsptLog[!apply(powerCsptLog, 1, function(x) {any(x == '?')}),]
#powerCsptLog
summary( powerCsptLog )

powerCsptLog$Global_active_power<-as.numeric(powerCsptLog$Global_active_power) 

library( datasets )
#par(bg = "white")
#with( powerCsptLog, plot( Global_active_power ) ) ## Create plot on screen device
with( subset( powerCsptLog, Date == "1/2/2007" | Date == "2/2/2007" ), hist( Global_active_power, col = "red", breaks = 12, xlab="Global Active Power (kilowatts)", main = "Global Active Power" ) )
#title(main = "Global Active Power" ) ## Add a main title
dev.copy(png, file = "./figure/plot1.png", width=480, height=480) ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!