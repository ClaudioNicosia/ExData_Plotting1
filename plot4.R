
setwd("C:/Users/Linda/RWORK/Exploratory Analysis")


## Downloads the dataset from the URL into the directory created above.
url_fl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url_fl,destfile="household_power_consumption.zip")

## Unzip the file into the directory.
unzip(zipfile="household_power_consumption.zip")

fl_hse <- file("household_power_consumption.txt")

data <- read.table(text = grep("^[1,2]/2/2007", readLines(fl_hse), value = TRUE), 
                 col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                               "Voltage", "Global_intensity", "Sub_metering_1", 
                               "Sub_metering_2", "Sub_metering_3"), sep = ";" , na.strings="?", header = TRUE)

## Create formatted date 
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
dtime  <- paste(as.Date(data$Date), data$Time)
data$Dtime <- as.POSIXct(dtime)


# Set Parameters 
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))


## Generate Plot 4
#-------------------------#

with(data, {
  plot(Global_active_power ~ Dtime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  
  plot(Voltage~Dtime, type="l",  ylab="Voltage (volt)", xlab="")
  
  plot(Sub_metering_1 ~ Dtime, type="l",  
       ylab="Global Active Power (kilowatts)", xlab="")
  
  lines(Sub_metering_2 ~ Dtime,col="red")
  
  lines(Sub_metering_3 ~ Dtime,col="blue")
  
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(Global_reactive_power ~ Dtime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})


# Copy displayed plot to png file in working directory 
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off() ## Don't forget to close the PNG device!

