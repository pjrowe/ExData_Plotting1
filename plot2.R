library(downloader)
library("dplyr")

pdata<-read.table("./household_power_consumption.txt",header = TRUE,sep=';')

# need to convert variables to numeric  i.e., and Date should be date and others should 
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

plot(xdata$Date,xdata$Global_active_power,type='n',xlab='',
     ylab='Global Active Power (kilowatts)')
lines(xdata$Date,xdata$Global_active_power,lty='solid',lwd=1)

dev.copy(png,file='plot2.png')
dev.off()

