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
xdata$Global_reactive_power<-as.numeric(as.character(xdata$Global_reactive_power))
xdata$Voltage<-as.numeric(as.character(xdata$Voltage))
xdata$Sub_metering_1<-as.numeric(as.character(xdata$Sub_metering_1))
xdata$Sub_metering_2<-as.numeric(as.character(xdata$Sub_metering_2))
xdata$Sub_metering_3<-as.numeric(as.character(xdata$Sub_metering_3))

# set up 2 x 2 grid for plots 
par(mfrow=c(2,2))

# plot top left
plot(xdata$Date,xdata$Global_active_power,type='n',xlab='',
     ylab='Global Active Power (kilowatts)')
lines(xdata$Date,xdata$Global_active_power,lty='solid',lwd=1)

# plot top right

plot(xdata$Date,xdata$Voltage,type='n',xlab='datetime',
     ylab='Voltage')
lines(xdata$Date,xdata$Voltage,lty='solid',lwd=2,col='black')

# plot bottom left

plot(xdata$Date,xdata$Sub_metering_1,type='n',xlab='',
     ylab='Energy sub metering')
lines(xdata$Date,xdata$Sub_metering_1,lty='solid',lwd=1,col='black')
lines(xdata$Date,xdata$Sub_metering_2,lty='solid',lwd=1,col='red')
lines(xdata$Date,xdata$Sub_metering_3,lty='solid',lwd=1,col='blue')
legend('topright',inset=0.02,col=c('black','red','blue'),lty="solid",
       legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),box.lty=0)


# bottom right
plot(xdata$Date,xdata$Global_reactive_power,type='n',xlab='datetime',
     ylab='Global_reactive_power')
lines(xdata$Date,xdata$Global_reactive_power,lty='solid',lwd=2,col='black')

xdata$Global_active_power<-as.numeric(as.character(xdata$Global_active_power))

dev.copy(png,file='plot4.png')
dev.off()

