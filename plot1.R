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
consumption<-read.csv2("data/household_power_consumption.txt", stringsAsFactors = FALSE, na.strings = "?")
consumption$Date<-as.Date(as.character(consumption$Date), format = "%d/%m/%Y")
dates<-c("2007-02-01", "2007-02-02")
febdata<-filter(consumption, Date == dates)
hist(na.omit(as.numeric(febdata$Global_active_power)), col="red", xaxp=c(0,6,3),xlab="Global Active Power (kilowatts)", main ="Global Active Power")
dev.copy(png, file ="plot1.png")
dev.off()
