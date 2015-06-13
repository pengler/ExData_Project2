require(plyr)
#require(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
coalSources<-SCC[grep ("^Fuel Comb.*Coal$",SCC$EI.Sector),]$SCC
NEI <- subset(NEI, SCC %in% coalSources)
totalEmissions <- aggregate (NEI$Emissions~NEI$year, FUN=sum)
plot (totalEmissions[,"NEI$year"],totalEmissions[,"NEI$Emissions"], type ="s",xlab="Year", ylab="PM2.5 Emissions (tons)", main="Total PM2.5 Coal Emissions by Year", lwd=2)

#emissionsByType<-ddply(NEI, c("year", "type"), function(x) colSums(x[c("Emissions")]))
