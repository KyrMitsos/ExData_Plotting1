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

par(mfrow=c(2,2)) # Set up plot parameter for 2x2 frame

#Plot 1,1
plot(xtime,dt$Global_active_power,type = "l", ylab="Global Active Power",xlab="")
#Plot 1,2
plot(xtime,dt$Voltage,type = "l", ylab="Voltage",xlab="datetime")
#Plot 2,1
plot(xtime, dt$Sub_metering_1, type = "l", ylab="Energy sub metering", xlab="")
lines(xtime,dt$Sub_metering_2,col="red")
lines(xtime,dt$Sub_metering_3,col="blue")
legend("topright", lty=c(1,1,1), col=c("black", "red", "blue"), legend=names(dt)[7:9], text.width=62000, cex=.6, bty="n", y.intersp=.6, adj = c(0,0.2))
#Plot 2,2
plot(xtime,dt$Global_reactive_power,type = "l", ylab=names(dt)[4], xlab="datetime")

# Output plot to file
dev.print(device=png,height=480,width=480,"plot4.png")