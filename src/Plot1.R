# Install Package sqldf to facilitate In-Import Filtering 
# * Please ignore these lines if package is already installed in your environment
install.packages('sqldf')
update.packages(ask=FALSE)
remove(list=ls())

# Read data
library(sqldf)
hpc <- read.csv.sql('../data/household_power_consumption.txt', header = TRUE, sep = ';',
                    '
                    SELECT *
                    FROM file
                    WHERE Date in ("1/2/2007","2/2/2007")
                    ')
dim(hpc)
head(hpc)
sapply(hpc, class)
hpc$DateTime <- strptime(paste(hpc$Date, hpc$Time, sep = ' '), '%d/%m/%Y %H:%M:%S')
sapply(hpc, class)

# Plot
png('../figure/Plot1.png', width = 480, height = 480)
par(bg = NA)
hist(hpc$Global_active_power, 
     col = 'red',
     main = 'Global Active Power',
     xlab = 'Global Active Power (kilowatts)')

dev.off()
