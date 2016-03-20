# Load data from disk
filename <- "household_power_consumption.txt"
titleline <- readLines(filename, n=1)
titleline<-strsplit(titleline,";")
all_data<-read.table(filename, header=TRUE, col.names = titleline[[1]], sep=";", na.strings = "?",
                     colClasses = c("character","character","numeric",
                                    "numeric","numeric","numeric",
                                    "numeric","numeric","numeric")
)

#Specialise selection on two dates
dt<-all_data[grep("^1/2/2007|^2/2/2007",all_data$Date),]

# Plot
xtime <- as.POSIXct(strptime(paste(dt$Date,dt$Time),"%d/%m/%Y %T"))# create x-axis datetime coords

plot(xtime, dt$Global_active_power,type = "l", ylab="Global Active Power (kilowatts)",xlab="")

# Output plot to file
dev.print(device=png,height=480,width=480,"plot2.png")