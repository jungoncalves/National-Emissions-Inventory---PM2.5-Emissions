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


########################### Question  4 ########################### 

#Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?


##list values from coal
list_coal <- grep("Coal", unique(SCC$SCC.Level.Four), perl=TRUE, value=TRUE)

#subset df from list filtered
df_SCC <- subset(SCC, SCC.Level.Four %in% list_coal)

#SCC to use in data NEI
list_ids_SCC <- unique(df_SCC$SCC)

#only id from coal 
df_filtered_coal <- subset(NEI, SCC %in% list_ids_SCC)

#sum by years
df_coal_sum <- aggregate(df_filtered_coal["Emissions"], by=df_filtered_coal["year"], sum)

#plot

png("Plot4.png", width=480, height=480)

plot(df_coal_sum$year, df_coal_sum$Emissions, type = 'l', xlab = 'Years', ylab = 'PM2.5  Emissions')
title('Total emissions from PM2.5 over the years from \ncoal combustion-related')

dev.off()
