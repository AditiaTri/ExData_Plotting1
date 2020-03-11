# filename: plot1.R
# desc    : R script used to create plot1.png
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

# Subset the date
df_subset <- subset(df, Date >= "2007-02-01" & Date <= "2007-02-02")

# Create PNG
png("plot1.png", width=480, height=480)
hist(df_subset$Global_active_power,
  col="red", 
  main="Global Active Power", 
  xlab="Global Active Power (kilowatts)",
  ylab="Frequency"
  )

dev.off()