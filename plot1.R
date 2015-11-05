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

# this gets the global active power histogram:
# NOTE: apparently by default (at least on my computer) the files are 480x480, but it may be different somewhere else...
png("plot1.png", width=480, height=480, units='px')
hist(data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()

