require(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coalSources<-SCC[grep ("^Fuel Comb.*Coal$",SCC$EI.Sector),]$SCC
NEI <- subset(NEI, SCC %in% coalSources)
totalEmissions <- aggregate (NEI$Emissions~NEI$year, FUN=sum)

p <- ggplot(data=totalEmissions, 
            aes(x=totalEmissions[,"NEI$year"])) +
  geom_line(aes(y=totalEmissions[,"NEI$Emissions"])) +
  geom_smooth(aes(y=totalEmissions[,"NEI$Emissions"]),
              method="lm",
              se=FALSE, 
              lty=3,
              alpha=1/3) +
  labs(title = "Coal Combustion based PM2.5 Emissions")  +
  xlab("Year") +
  ylab("Emissions (tons)")

print(p)
dev.copy(png,filename="plot4.png")
dev.off()