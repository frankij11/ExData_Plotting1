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
png("plot3.png", width=480, height=480)
with(df, 
     plot(x=1:2880, y=Sub_metering_1,
          xlab="",
          ylab="Energy sub metering",
          xaxt ="n",
          col = 'black',
          lty=1,
          pch = "",
          
     )
)
lines(1:2880, df$Sub_metering_1, col ="black")
lines(1:2880, df$Sub_metering_2, col = "red")
lines(1:2880, df$Sub_metering_3, col = "blue")
#, legend("Sub_metering_1","Sub_metering_2", "Sub_metering_3" )
legend("topright", 
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3" ),
       col = c("black", "red", "blue"),
       lwd = 2
       )

axis(1, c(1,1440, 2880),c("Thu", "Fri", "Sun"))


dev.off()
#done
