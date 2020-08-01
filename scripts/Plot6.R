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

########################### Question  6 ########################### 

#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, 
#California (fips == "06037"|}fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

#list values from motor vehicles
list_mv = levels(SCC$EI.Sector)[grep("vehicle",tolower(levels(SCC$EI.Sector)))]

#subset df from list filtered
df_mv <- subset(SCC, EI.Sector %in% list_mv)

#SCC to use in data NEI
list_ids_SCC_mv <- unique(df_mv$SCC)

#filtered id motor vehicles
df_filtered_mv <- subset(NEI, SCC %in% list_ids_SCC_mv)

#take only baltimore data
baltimore <- subset(df_filtered_mv, fips == "24510", select = c(Emissions, year))

#sum by years
baltimore_sum <- aggregate(baltimore["Emissions"], by=baltimore["year"], sum)

#take only los angeles data
losangeles <- subset(df_filtered_mv, fips == "06037", select = c(Emissions, year))

#sumerizing by years
losangeles_sum <- aggregate(losangeles["Emissions"], by=losangeles["year"], sum)

#plot

png("Plot6.png", width=480, height=480)

par(mfrow = c(1, 2))
plot(baltimore_sum$year, baltimore_sum$Emissions, type = 'l', xlab = 'Years', ylab = 'PM2.5  Emissions', main = 'Baltimore')
plot(losangeles_sum$year, losangeles_sum$Emissions, type = 'l', xlab = 'Years', ylab = 'PM2.5  Emissions', main = 'Los Angeles')

dev.off()
