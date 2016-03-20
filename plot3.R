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
xtime <- as.POSIXct(strptime(paste(dt$Date,dt$Time),"%d/%m/%Y %T")) # create x-axis datetime coords

plot(xtime, dt$Sub_metering_1, type = "l", ylab="Energy sub metering", xlab="")
lines(xtime, dt$Sub_metering_2, col="red")
lines(xtime, dt$Sub_metering_3, col="blue")
legend("topright", lty=c(1,1,1), col=c("black", "red", "blue"), legend=names(dt)[7:9], text.width = 60000)

# Output plot to file
dev.print(device=png,height=480,width=480,"plot3.png")