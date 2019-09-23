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
png("plot2.png", width=480, height=480)
with(df, 
     plot(x=1:2880, y=Global_active_power,
          main = "Global Active Power",
          xlab="",
          ylab="Global Active Power (Kilowatts)",
          xaxt ="n",
          col = 'black',
          lty=1,
          pch = "",
          
     )
)
lines(1:2880, df$Global_active_power, ylab="Global Active Power (Kilowatts)", xlab="")

axis(1, c(1,1440, 2880),c("Thu", "Fri", "Sun"))


dev.off()
#done
