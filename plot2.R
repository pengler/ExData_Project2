NEI <- readRDS("summarySCC_PM25.rds")

NEI <- NEI[NEI$fips=="24510",]
totalEmissions <- aggregate (NEI$Emissions~NEI$year, FUN=sum)
plot (totalEmissions[,"NEI$year"],
      totalEmissions[,"NEI$Emissions"], 
      type ="l",
      xlab="Year", 
      ylab="PM2.5 Emissions (tons)", 
      main="Total PM2.5 Emissions by Year in Baltimore City", 
      lwd=2 )

dev.copy(png,filename="plot2.png")
dev.off()
