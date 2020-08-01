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


########################### Question  5 ########################### 

#How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

#list values from motor vehicles
list_mv = levels(SCC$EI.Sector)[grep("vehicle",tolower(levels(SCC$EI.Sector)))]

#subset df from list filtered
df_mv <- subset(SCC, EI.Sector %in% list_mv)

#SCC to use in data NEI
list_ids_SCC_mv <- unique(df_mv$SCC)

#filtered id motor vehicles
df_filtered_mv <- subset(NEI, SCC %in% list_ids_SCC_mv)

#take only baltimore data
mv <- subset(df_filtered_mv, fips == "24510", select = c(Emissions, year))

#sum data
df_mv_sum <- aggregate(mv["Emissions"], by=mv["year"], sum)

#plot
png("Plot5.png", width=480, height=480)

plot(df_mv_sum$year, df_mv_sum$Emissions, type = 'l', xlab = 'Years', ylab = 'PM2.5  Emissions')
title('Total emissions from PM2.5 over the years from \nmotor vehicle sources')

dev.off()
