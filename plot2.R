# plot2.R
# PM2.5 emissions in Baltimore City

NEI <- readRDS("summarySCC_PM25.rds")

baltimore <- subset(NEI, fips == "24510")

total_baltimore <- aggregate(Emissions ~ year, baltimore, sum)

png("plot2.png", width = 480, height = 480)

plot(
  total_baltimore$year,
  total_baltimore$Emissions,
  type = "b",
  pch = 19,
  xlab = "Year",
  ylab = "Total PM2.5 Emissions (tons)",
  main = "PM2.5 Emissions in Baltimore City"
)

dev.off()
