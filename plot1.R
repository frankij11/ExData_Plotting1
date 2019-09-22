library(lubridate)
library(dplyr)


#Download and subset data
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipName <- "data/data.zip"
dataFile <- "data/household_power_consumption.txt"
if(!file.exists("data")){dir.create("data/")}

if(!file.exists(dataFile)){
  download.file(fileURL, zipName )
  unzip(zipName, exdir = "data")
  file.remove(zipName)
  
}
df <- read.table(dataFile,
                 header = TRUE,
                 sep = ";",
                 na.strings = "?"
                 )
df$Date <- dmy(df$Date)
df$Time <- hms(df$Time)
# Read only dates 2007-02-01 and 2007-02-02
df <- filter(df, Date >= "2007-02-01", Date <= "2007-02-02" )
png("plot1.png", width=480, height=480)
with(df, 
     hist(Global_active_power,
          main = "Global Active Power",
          xlab="Global Active Power (Kilowatts)" ,
          col = 'red',
          freq=TRUE
          )
)
#          xlim = c(0,6)
axis(2, seq(0,1200,200))
axis(1, seq(0,6,1))


dev.off()
#done
