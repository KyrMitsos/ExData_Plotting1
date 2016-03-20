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

# Plot histogram
hist(dt$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

# Output plot to file
dev.print(device=png,height=480,width=480,"plot1.png")