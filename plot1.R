library(downloader)
library("dplyr")

# download and unzip files and record date / time of download
url<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download(url,dest="household_power_consumption.zip",mode='wb')
unzip('household_power_consumption.zip')
date_downloaded<-Sys.time()

pdata<-read.table("./household_power_consumption.txt",header = TRUE,sep=';')

# need to convert variables to property type i.e., Date shoudl be date and others should 
# be integers

pdata$jDate<-strptime(pdata$Date,"%d/%m/%Y")
xdata<- subset(pdata, jDate=='2007-02-01'|jDate=='2007-02-02')
#select only certain dates
xdata$Date<-strptime(paste(xdata$Date,' ',xdata$Time),"%d/%m/%Y %H:%M:%S")
#remote extra columns
xdata<-select(xdata,c(-Time,-jDate))


# turn columns into numbers instead of factors
# not sure why doing a group of columns doesn't work - turns whole columns into NA
xdata$Global_active_power<-as.numeric(as.character(xdata$Global_active_power))

hist(xdata$Global_active_power,xlab='Global Active Power (kilowatts)', main="Global Active Power",col='red')

dev.copy(png,file='plot1.png')
dev.off()

# extra code 
#
#
#head(xdata)
#names(xdata)
#dim(xdata)
#object.size(xdata)
#str(xdata)
