################################################### 
# Exploratory data Analysis                       #
# Project 1 (file 1 of 4) - "plot1.R"             #
# Reproduce plot 1                                #
# Expected input: household_power_consumption.zip #
# Expected output: plot1.png                      #
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
#closeAllConnections()
# See examples on p. 8 of http://cran.r-project.org/web/packages/sqldf/sqldf.pdf

# Check the size of the dataset:
library(pryr)
object_size(data) # 290 kB

# Plot histogram with specified parameters:
attach(data) # Allows to work access variables directly without data$... notation. (Use with caution)
png(file="plot1.png", height=480, width=480)
hist(Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()
# Just a sanity check for missing values '?'
which(Global_active_power=="?") # integer(0)
detach(data) # Detach database

# how much time elapsed
print(proc.time() - pmt)
