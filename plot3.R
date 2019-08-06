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
xdata$Sub_metering_1<-as.numeric(as.character(xdata$Sub_metering_1))
xdata$Sub_metering_2<-as.numeric(as.character(xdata$Sub_metering_2))
xdata$Sub_meteringc_3<-as.numeric(as.character(xdata$Sub_metering_3))

par(mfrow=c(1,1))

plot(xdata$Date,xdata$Sub_metering_1,type='n',xlab='',
     ylab='Energy sub metering')
lines(xdata$Date,xdata$Sub_metering_1,lty='solid',lwd=1,col='black')
lines(xdata$Date,xdata$Sub_metering_2,lty='solid',lwd=1,col='red')
lines(xdata$Date,xdata$Sub_metering_3,lty='solid',lwd=1,col='blue')
legend("topright",col=c('black','red','blue'),lty="solid",
       legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))

dev.copy(png,file='plot3.png')
dev.off()