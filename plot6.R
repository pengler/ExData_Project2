require(plyr)
require(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Filter for motor vehicle emissions
motorVehicleSources<-SCC[grep ("^Mobile - On-Road",SCC$EI.Sector),]$SCC
NEI <- NEI[NEI$fips=="24510"|NEI$fips=="06037",]
NEI <- subset(NEI, SCC %in% motorVehicleSources)

totalEmissions <- aggregate (NEI$Emissions~NEI$year, FUN=sum)
emissionsByFips<-ddply(NEI, c("year", "fips"), 
                       function(x) colSums(x[c("Emissions")]))

# Get our min/max/deltas for the ribbons
baltimoreMin=min(emissionsByFips[emissionsByFips$fips=="24510",]$Emissions)
baltimoreMax=max(emissionsByFips[emissionsByFips$fips=="24510",]$Emissions)
baltimoreDelta = round(baltimoreMax-baltimoreMin,digits=2)
laMin=min(emissionsByFips[emissionsByFips$fips=="06037",]$Emissions)
laMax=max(emissionsByFips[emissionsByFips$fips=="06037",]$Emissions)
laDelta = round(laMax-laMin,digits=2)

# build the plot
p <- ggplot(data=emissionsByFips, aes(x=unique(emissionsByFips[,"year"]))) +
  geom_line(aes(y=emissionsByFips[emissionsByFips$fips=="24510",]$Emissions),
            color="Blue") +
  geom_line(aes(y=emissionsByFips[emissionsByFips$fips=="06037",]$Emissions),
            color="Red") +
  geom_ribbon(aes(x=unique(emissionsByFips[,"year"]),ymax=baltimoreMax,ymin=baltimoreMin),
              fill="Blue", 
              alpha=.1) +
  geom_ribbon(aes(x=unique(emissionsByFips[,"year"]),ymax=laMax,ymin=laMin),
              fill="Red", 
              alpha=.1) +
  annotate ("text",
            y=(laMax+laMin)/2-450,x=mean(emissionsByFips[,"year"]),
            label=paste("Delta in LA Emissions =", laDelta,"tons")) +
  annotate ("text",
            y=(baltimoreMax+baltimoreMin)/2+250,x=mean(emissionsByFips[,"year"]),
            label=paste("Delta in Baltimore Emissions =", baltimoreDelta,"tons")) +
  labs(title = "Baltimore vs LA Changes in Emissions")  +
  xlab("Year") +
  ylab("Emissions (tons)")

print(p)