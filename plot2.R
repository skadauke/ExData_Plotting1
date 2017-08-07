library(tidyverse)
library(lubridate)

# Load data and extract the subset covering 2007-02-01 to 2007-02-02
power <- read_delim("data/household_power_consumption.txt", delim=";", 
                    col_types = "ccddddddd") %>%
    mutate(Date = dmy(Date)) %>%
    mutate(Time = hms(Time)) %>%
    mutate(datetime = as.POSIXct(Date + Time)) %>%
    filter(Date %within% interval(ymd("2007-02-01"), ymd("2007-02-02")))

# Generate a plot of Global Active Power over time
with(power, {
    png("plot2.png", height = 480, width = 480)
    plot(datetime, Global_active_power, type="l",
         ylab="Global Active Power (kilowatts)",
         xlab="")
    dev.off()
})
