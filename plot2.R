NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")
NEI <- NEI[NEI$fips=="24510",]
totalEmissions <- aggregate (NEI$Emissions~NEI$year, FUN=sum)
plot (totalEmissions[,"NEI$year"],
      totalEmissions[,"NEI$Emissions"], 
      type ="s",
      xlab="Year", 
      ylab="PM2.5 Emissions (tons)", 
      main="Total PM2.5 Emissions by Year in Baltimore City", 
      lwd=2 )
