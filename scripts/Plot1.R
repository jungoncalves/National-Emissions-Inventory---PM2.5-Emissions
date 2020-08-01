setwd("../National Emissions Inventory - PM2.5 Emissions/")
getwd()



#install.packages('ggplot2')

## Library 
library(dplyr)
#library(ggplot2)


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## See data 
head(NEI)
head(SCC)

# fips: A five-digit number (represented as a string) indicating the U.S. county
# SCC: The name of the source as indicated by a digit string (see source code classification table)
# Pollutant: A string indicating the pollutant
# Emissions: Amount of PM2.5 emitted, in tons
# type: The type of source (point, non-point, on-road, or non-road)
# year: The year of emissions recorded

########################### Question 1 ########################### 

#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from 
#all sources for each of the years 1999, 2002, 2005, and 2008.


df_NEI_sum <- aggregate(NEI["Emissions"], by=NEI["year"], sum)

head(df_NEI_sum)

png("Plot1.png", width=480, height=480)

plot(df_NEI_sum$year, df_NEI_sum$Emissions, type = 'l', xlab = 'Years', ylab = 'PM2.5  Emissions')
title('Total emissions from PM2.5 over the years')
dev.off()

#R: Yes the emissions have droped over the years 

