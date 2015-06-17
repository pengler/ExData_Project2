NEI <- readRDS("summarySCC_PM25.rds")

totalEmissions <- aggregate (NEI$Emissions~NEI$year, FUN=sum)

plot (totalEmissions[,"NEI$year"],
      totalEmissions[,"NEI$Emissions"], 
      type ="l",xlab="Year", 
      ylab="PM2.5 Emissions (tons)", 
      main="Total PM2.5 Emissions by Year", 
      lwd=2)
dev.copy(png,filename="plot1.png")
dev.off()