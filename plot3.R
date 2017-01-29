##############################
#Download and unzip the files#
##############################
if (!file.exists(".data")) {
     dir.create("data")
} # checks for a data directory, and creates one if it doesn't already exist
fileURL<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" #assigns a handle to the URL that points to the data
download.file(fileURL, destfile = "data.zip", method= "auto") # downloads the data folder
unzip(zipfile="data.zip", exdir ="data") #unzips the data folder and puts into a new folder, data

######################
#Read the Data into R#
######################
object.size("data/household_power_consumption.txt")
consumption<-read.csv2("data/household_power_consumption.txt", stringsAsFactors = FALSE, na.strings = "?")
consumption$Date<-as.Date(as.character(consumption$Date), format = "%d/%m/%Y")
dates<-c("2007-02-01", "2007-02-02")
febdata<-filter(consumption, Date == dates)
require(lubridate)
febdata<-mutate(febdata, Weekday=wday(febdata$Date, label =TRUE),datetime=ymd_hms(paste(Date,as.character(Time))))
finaldata<-na.omit(febdata)
with(finaldata, plot(datetime,Sub_metering_1,type = "l", col= "black",lwd=2,xlab="", ylab="Energy sub metering"))
with(finaldata,lines(datetime,Sub_metering_2, col ="red", lwd =2))
with(finaldata,lines(datetime,Sub_metering_3, col="blue", lwd=2))
legend("topright", lty = c(1,1,1), col=c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file ="plot3.png")
dev.off()