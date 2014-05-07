# Set working directory to directory containing household_power_consumption.txt extracted from exdata-data-household_power_consumption.zip.
# URL: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
setwd("C:/Users/FCH808/Dropbox/~Coursera/DataScienceSpec/Exploratory-Data-Analysis/Week 1")
# Use fread in the data.table package to read the file as a data.frame/data.table quickly
library(data.table)
# Load the first column containing dates so find indices of the rows that contain the dates needed. Select statement is used to select the first column only.
findRows<-fread("household_power_consumption.txt", header = TRUE, select = 1)
# Save the indices to a file named all
all<-(which(findRows$Date %in% c("1/2/2007", "2/2/2007")) )
# Find where the first row starts that contains the dates wanted.
skipLines<- min(all)
# Find how many indices there are
keepRows<- length(all)
# Now reread the text file, getting the full rows. Skip the first files until the rows you want start. nrows is how many rows you want, here it is the length of your dates wanted. 
feb<- fread("household_power_consumption.txt", skip = skipLines , nrows = keepRows )
# Remove findRows data.table. No longer needed.
rm(findRows)
#Header = TRUE seemed to not grab the header names, but instead grabs the row previous to the ones wanted. So we'll just grab the names real quick with a fread on only the first row of the txt and saving those header names.
febNames<- names(fread("household_power_consumption.txt", nrow = 1))
#setnames sets the names vector onto our data set.
setnames(feb, febNames)
# Quick summary check of your dataset shows we have 2880 rows.
summary(feb)


# Note: The previous procedure was done to avoid reading in the entire dataset and simply subsetting the desired dates data. This is useful as the size of datasets extend beyond millions of rows and variables, as RAM requirements to house the entire dataset may make reading the entire dataset impracticable.


# Quickly save our default par() settings since we are changing them and will want to reset them after our custom plots.
opar <- par() 

#Plot 1

#Set custom settings for our plot. Move labels in closer with mpg. Make labels and axis text slightly smaller. Reduce margins slightly. 
par( mar = c(4,4,2,1), cex.lab = 0.8, cex.axis = 0.8, mgp = c(2.5, 1, 0) ) 

# Open png writer, set pixel dimensions needed. (defaults are 480x480 but they are explicitly entered for transparency.)
png(file = "plot1.png", width = 480, height = 480)

# Create plot
with(feb, hist(Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))

#shut off graphics device to write file to disk.
dev.off()

#Restore default settings.
par(opar)

# Manual restoration settings in case something happened during the save/restore process.
# par(mfrow = c(1,1), mar = c(5.1, 4.1, 4.1, 2.1), cex.lab = 1, cex.axis = 1, mgp = c(3, 1, 0) )