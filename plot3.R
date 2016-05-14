# Author : Antonio Camacho
# Dataset : Electric power consumption
# File : https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip 
#
# We will only be using data from the dates 2007-02-01 and 2007-02-02.
# In order to get the line number for the fist row regarding 2007-02-01, the
# following bash command has been used:
# $ grep -n "^1/2/2007.*" household_power_consumption.txt | head -1
# 66638:1/2/2007;00:00:00;0.326;0.128;243.150;1.400;0.000;0.000;0.000
# Similarly, for the last line regarding 2007-02-02:
# grep -n "^2/2/2007.*" rdir/data/household_power_consumption.txt | tail -1
# 69517:2/2/2007;23:59:00;3.680;0.224;240.370;15.200;0.000;2.000;18.000
# Therefore, the number of rows is 69517 - 66638 + 1 = 2880 which is the number of
# minutes in two days (60*24*2)

# Read data
hpc <- read.table(
    "data/household_power_consumption.txt",
    sep=";",
    na.strings = "?",
    skip = 66637, # 66638 - 1 (starting row)
    nrows = 2880) # 60*24*2

# Set column names
names <- read.table(
    "data/household_power_consumption.txt",
    header = FALSE,
    sep=";",
    stringsAsFactors = FALSE,
    nrows = 1)
# Make names lowercase to easy typing
names(hpc) <- tolower(unlist(names))

# initialize graphic device
png(
    filename = "./plot3.png",
    width = 480,
    height = 480,
    units = "px")

# make the plot

with(
    hpc,
    plot(
        strptime(paste(date,time),"%d/%m/%Y %H:%M:%S"),
        sub_metering_1,
        ylab = "Energy sub metering",
        xlab = "",
        type ="l")
)

with(
    hpc,
    lines(
        strptime(paste(date,time),"%d/%m/%Y %H:%M:%S"),
        sub_metering_2,col="red")
    )

# add sub_metering_3
with(
    hpc,
    lines(
        strptime(paste(date,time),"%d/%m/%Y %H:%M:%S"),
        sub_metering_3,col="blue")
)

# anotate legend
legend("topright",
       lty = c(1,1,1),
       col = c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       )

# close graphic device
dev.off()
