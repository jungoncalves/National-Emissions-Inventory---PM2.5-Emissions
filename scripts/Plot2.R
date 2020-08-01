setwd("../National Emissions Inventory - PM2.5 Emissions/")
getwd()



## Library 
library(dplyr)
#library(ggplot2)


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## See data 
head(NEI)
head(SCC)

########################### Question  2 ########################### 

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
#from 1999 to 2008? Use the base plotting system to make a plot answering this question.

fips24510 <- subset(NEI, fips == "24510", select = c(Emissions, year))
fips24510_sum <- aggregate(fips24510["Emissions"], by=fips24510["year"], sum)

png("Plot2.png", width=480, height=480)
plot(fips24510_sum$year, fips24510_sum$Emissions, type = 'l', xlab = 'Years', ylab = 'PM2.5  Emissions')
title('Total emissions from PM2.5 over the years in Baltimore City')
dev.off()

#R: The emissions decrease from 1999 to 2002, then increase from 2002i intil 2005 them goes down 

