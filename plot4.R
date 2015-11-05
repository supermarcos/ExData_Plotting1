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

# preserve the existing locale
my_locale <- Sys.getlocale("LC_ALL")

# change locale to English (avoid to appear jue, vie, sab... as my local language and display thu, fri and sat)
Sys.setlocale("LC_ALL", "English")

# order the 4 plots as a 2x2 table:
par(mfrow = c(2, 2)) #, cex.lab=0.75, cex.axis=0.75, cex.sub=0.75) # 2 rows, 2 cols, cex sets a magnification factor... however, if I don't change the size of this result to something bigger either or it is impossible to read texts or it cuts off words

# this is the plot4, which is itself 4 plots all together in the same representation:

# plot 1: top left position
plot(data$DateTime, data$Global_active_power, xlab="", ylab="Global Active Power", type="l")

# plot 2: top right position
plot(data$DateTime, data$Voltage, xlab="datetime", ylab="Voltage", type="l")

# plot 3: bottom left position
plot(data$DateTime, data$Sub_metering_1, ylab = "Eergy sub metering", xlab = "", col = "black", type = 'l')
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend('topright', legend = c("Sub metering 1", "Sub metering 2", "Sub metering 3"), col = c("black", "red", "blue"), lty = "solid", bty = "n", cex=0.75) # theorically I should be able to use cex=0.75 or something to make the legend fit well, but for some reason on my computer doesn't behave as expected...

# plot 4: bottom right position
plot(data$DateTime, data$Global_reactive_power, xlab="datetime", ylab="Global reactive power", type="l")

# close png file...
dev.copy(device = png, file = "plot4.png", width = 600, height = 600, units = 'px')
dev.off()

# restore locale (this seems to be giving a warning on my computer...)
Sys.setlocale("LC_ALL", my_locale)
