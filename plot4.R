# filename: plot4.R
# desc    : R script used to create plot4.png
# author  : Aditia Trihadian
# created : 2020-03-11

# Get the data
file_name <- "./exdata_data_household_power_consumption/household_power_consumption.txt"
df <- read.table(file_name, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

# Fix the column formats
df$Date <- as.Date(df$Date , format = "%d/%m/%Y")
df$Time <- format(df$Time, format="%H:%M:%S")

cols_numeric <- c("Global_active_power",
                  "Global_reactive_power",
                  "Voltage",
                  "Global_intensity",
                  "Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"
)

for(i in cols_numeric){
  df[[i]] <- as.numeric(df[[i]])
}

# Create a DateTime column
df$DateTime <- as.POSIXct(paste(df$Date, df$Time), 
                          format="%Y-%m-%d %H:%M:%S")

# Subset the date
df_subset <- subset(df, Date >= "2007-02-01" & Date <= "2007-02-02")

# Create PNG
png("plot4.png", width=480, height=480)

## Use 2x2 panels
par(mfrow=c(2,2))

## 1
plot(df_subset$DateTime, df_subset$Global_active_power, type="l", xlab="", ylab="Global Active Power")

## 2
plot(df_subset$DateTime, df_subset$Voltage, type = "l", xlab="datetime", ylab="Voltage")

## 3
plot(df_subset$DateTime, df_subset$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(df_subset$DateTime, df_subset$Sub_metering_2, type="l", col= "red")
lines(df_subset$DateTime, df_subset$Sub_metering_3, type="l", col= "blue")
legend(
  c("topright"), 
  c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
  lty= 1, 
  lwd=2, 
  col = c("black", "red", "blue")
)

## 4
plot(df_subset$DateTime, df_subset$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()