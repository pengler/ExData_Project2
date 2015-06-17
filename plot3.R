require(plyr)
require(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
NEI <- NEI[NEI$fips=="24510",]

emissionsByType<-ddply(NEI, c("year", "type"), function(x) colSums(x[c("Emissions")]))
p<-qplot(year, 
      Emissions, 
      data=emissionsByType, 
      facets = . ~ type , 
      geom=c("path","smooth"), 
      method="lm", 
      se=FALSE,
      ylab="Emissions (tons)",
      main="PM2.5 Emissions for Baltimore by Source Type")

print(p)
dev.copy(png,filename="plot3.png")
dev.off()