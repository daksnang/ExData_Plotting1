################################################### 
# Exploratory data Analysis                       #
# Project 1 (file 4 of 4) - "plot4.R"             #
# Reproduce plot 4                                #
# Expected input: household_power_consumption.zip #
# Expected output: plot4.png                      #
#                                                 #
# Technical data:                                 #
# Ubuntu MATE 15.04 Vivid                         #
# x86_64-pc-linux-gnu (64-bit)                    #
# R 3.1.2 (2014-10-31) -- "Pumpkin Helmet"        #
#                                                 #
# Libraries used:                                 #
# sqldf (required)                                #
# pryr (optional)                                 #
###################################################

# For timing the process:
pmt <- proc.time()

## Set working directory:
setwd("~/Coursera/ExData_Plotting1")

## Download and unzip dataset. Used original dataset from UC Irvine Machine Learning Repository:
if(!file.exists("household_power_consumption.txt")){
  fileUrl <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
  download.file(fileUrl, "~/Coursera/ExData_Plotting1/dataset.zip", method="wget")
  unzip("dataset.zip")
}

## Read *only* data within specified timeframe:
library(sqldf)
data<- read.csv.sql("household_power_consumption.txt", 
                    sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", sep=";")
#closeAllConnections()
# See examples on p. 8 of http://cran.r-project.org/web/packages/sqldf/sqldf.pdf

## Check the size of the dataset:
library(pryr)
object_size(data) # 290 kB

## Transform date
dt <- paste(data$Date, data$Time)
dt <- as.POSIXct(dt, format="%d/%m/%Y %H:%M:%S")

## Create four plots
png(file="plot4.png", height=480, width=480)
par(mfrow = c(2, 2))
# sub-plot 1 ----------------------------------
plot(dt, data$Global_active_power, type="l", xlab="", ylab="Global Active Power")
# sub-plot 2 ----------------------------------
plot(dt, data$Voltage, type="l", xlab = "datetime", ylab = "Voltage")
# sub-plot 3 ---------------------------------
plot(dt, data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(dt, data$Sub_metering_2, col="red")
lines(dt, data$Sub_metering_3, col="blue")
legend("topright",  legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1),
       col=c("black", "red", "blue"), bty="n")
#Similarly, with less typing:
#legend("topright",  legend=colnames(data[, c(7, 8,9)]), lty=c(1,1,1),
#       col=c("black", "red", "blue"))
# sub-plot 4 --------------------------------
plot(dt, data$Global_reactive_power, type="l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()

# how much time elapsed
print(proc.time() - pmt)
