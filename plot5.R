require(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Assume that the EI.Sector values that start with "Mobile" are considered motor vehichles
motorVehicleSources<-SCC[grep ("^Mobile -",SCC$EI.Sector),]$SCC
NEI <- NEI[NEI$fips=="24510",]
NEI <- subset(NEI, SCC %in% motorVehicleSources)
totalEmissions <- aggregate (NEI$Emissions~NEI$year, FUN=sum)

p <- ggplot(data=totalEmissions, 
            aes(x=totalEmissions[,"NEI$year"])) +
  geom_line(aes(y=totalEmissions[,"NEI$Emissions"])) +
  geom_smooth(aes(y=totalEmissions[,"NEI$Emissions"]),
              method="lm",
              se=FALSE, 
              lty=3,
              alpha=1/3) +
  labs(title = "Motor Vehicle based PM2.5 Emissions in Balitmore")  +
  xlab("Year") +
  ylab("Emissions (tons)")

print(p)
dev.copy(png,filename="plot5.png")
dev.off()