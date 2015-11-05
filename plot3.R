# load the data
# I will load it already filtered to avoid loading unnecessary data saving memory and time 
#   using sqldf command when loading the csv

library(sqldf)
library(lubridate)

# setwd("d:/Marcos/RProg/exploratory_data_analysis/projects/week1/ExData_Plotting1/")

# I am storing the file in the parent folder that contains the repository:
file <- "../household_power_consumption.txt"

# filter out just the ones from 2007-02-01 to 2007-02-02 which are the ones are going to be analysed
# unfortunately, dates are stored as d/m/yyyy and it is quite tricky get it right as a date using sql, using R it is much easier
data <- read.csv.sql(file, sql = "select * from file where Date=='1/2/2007' OR Date=='2/2/2007'", sep = ";")
# tidying up date and time, convert them to a real dateTime column adding an extra column called DateTime:
data$DateTime <- dmy(data$Date)+hms(data$Time)

## preserve the existing locale
my_locale <- Sys.getlocale("LC_ALL")

## change locale to English (avoid to appear jue, vie, sab... as my local language and display thu, fri and sat)
Sys.setlocale("LC_ALL", "English")

# this is the plot3, comparing metering 1, 2, and 3 data:
png("plot3.png", width=480, height=480, units='px')
plot(data$DateTime, data$Sub_metering_1, ylab = "Eergy sub metering", xlab = "", col = "black", type = 'l')
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")

legend('topright', legend = c("Sub metering 1", "Sub metering 2", "Sub metering 3"), col = c("black", "red", "blue"), lty = "solid")
dev.off()


## restore locale
Sys.setlocale("LC_ALL", my_locale)
