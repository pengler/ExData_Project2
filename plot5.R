#require(plyr)
require(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

motorVehicleSources<-SCC[grep ("^Mobile - On-Road",SCC$EI.Sector),]$SCC
NEI <- NEI[NEI$fips=="24510",]
NEI <- subset(NEI, SCC %in% motorVehicleSources)
totalEmissions <- aggregate (NEI$Emissions~NEI$year, FUN=sum)

p <- ggplot(data=totalEmissions, aes(x=totalEmissions[,"NEI$year"])) +
  geom_line(aes(y=totalEmissions[,"NEI$Emissions"],col="Emissons")) +
  geom_smooth(aes(y=totalEmissions[,"NEI$Emissions"], col="Trend"),method="lm",se=FALSE) +
  labs(title = "Motor Vehicle based PM2.5 Emissions in Balitmore")  +
  xlab("Year") +
  ylab("Emissions (tons)") + 
  theme (legend.title = element_blank())

print(p)