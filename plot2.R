################################################### 
# Exploratory data Analysis                       #
# Project 1 (file 2 of 4) - "plot2.R"             #
# Reproduce plot 2                                #
# Expected input: household_power_consumption.zip #
# Expected output: plot2.png                      #
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

# For timing script execution:
pmt <- proc.time()

# Set working directory:
setwd("~/Coursera/ExData_Plotting1")

# Download and unzip dataset. Used original dataset from UC Irvine Machine Learning Repository:
if(!file.exists("household_power_consumption.txt")){
  fileUrl <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
  download.file(fileUrl, "~/Coursera/ExData_Plotting1/dataset.zip", method="wget")
  unzip("dataset.zip")
}

# Read *only* data within specified timeframe:
library(sqldf)
data<- read.csv.sql("household_power_consumption.txt", 
                    sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", sep=";")
closeAllConnections()
# See examples on p. 8 of http://cran.r-project.org/web/packages/sqldf/sqldf.pdf

# Check the size of the dataset:
library(pryr)
object_size(data) # 290 kB

# Transform date
dt <- paste(data$Date, data$Time)
dt <- as.POSIXct(dt, format="%d/%m/%Y %H:%M:%S")

# Plot the time series:
png(file="plot2.png", height=480, width=480)
plot(dt, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

# how much time elapsed
print(proc.time() - pmt)