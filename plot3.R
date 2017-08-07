library(tidyverse)
library(lubridate)

# Load data and extract the subset covering 2007-02-01 to 2007-02-02
power <- read_delim("data/household_power_consumption.txt", delim=";", 
                    col_types = "ccddddddd") %>%
    mutate(Date = dmy(Date)) %>%
    mutate(Time = hms(Time)) %>%
    mutate(datetime = as.POSIXct(Date + Time)) %>%
    filter(Date %within% interval(ymd("2007-02-01"), ymd("2007-02-02")))

# Generate a plot of Submetering over time
with(power, {
    png("plot3.png", height = 480, width = 480)
    plot(datetime, Sub_metering_1, type="l",
         ylab="Energy sub metering",
         xlab="")
    lines(datetime, Sub_metering_2, col="red")
    lines(datetime, Sub_metering_3, col="blue")
    legend("topright", col=c("black", "red", "blue"), lwd=1,
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    dev.off()
})
