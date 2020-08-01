setwd("../National Emissions Inventory - PM2.5 Emissions/")
getwd()



## Library 
library(dplyr)
library(ggplot2)


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## See data 
head(NEI)
head(SCC)


########################### Question  3 ########################### 

#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
#variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
#Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

#uniques values in type
unique(NEI$type)

# Filtering and summarizing by type 
point <- subset(NEI, type == "POINT" & fips == "24510", select = c(Emissions, year))
point_sum <- aggregate(point["Emissions"], by=point["year"], sum)

onroad <- subset(NEI, type == "ON-ROAD" & fips == "24510", select = c(Emissions, year))
onroad_sum <- aggregate(onroad["Emissions"], by=onroad["year"], sum)

nonroad <- subset(NEI, type == "NON-ROAD" & fips == "24510", select = c(Emissions, year))
nonroad_sum <- aggregate(nonroad["Emissions"], by=nonroad["year"], sum)

nonpoint <- subset(NEI, type == "NONPOINT" & fips == "24510", select = c(Emissions, year))
nonpoint_sum <- aggregate(nonpoint["Emissions"], by=nonpoint["year"], sum)

#plot
png("Plot3.png", width=480, height=480)

p = ggplot() + 
  geom_line(data = point_sum, aes(x = year, y = Emissions ,  color = "POINT") ) +
  geom_line(data = nonpoint_sum, aes(x = year, y = Emissions, color = "NONPOINT" ) ) +
  geom_line(data = onroad_sum, aes(x = year, y = Emissions, color = "ON-ROAD")) +
  geom_line(data = nonroad_sum, aes(x = year, y = Emissions, color = "NON-ROAD")) +
  labs(x="Years", y="PM2.5  Emissions", color = 'Types') +
  ggtitle('Total emissions from PM2.5 over the years by Types')+
  scale_color_manual(values = c("POINT" = "blue", "NONPOINT" = "red",  "ON-ROAD" = "black", "NON-ROAD" = "green"))

print(p)

dev.off()
