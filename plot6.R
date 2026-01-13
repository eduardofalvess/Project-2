# plot6.R
# Motor vehicle emissions comparison: Baltimore vs Los Angeles

library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

vehicle_scc <- SCC[grep("vehicle", SCC$EI.Sector, ignore.case = TRUE), ]

vehicle_emissions <- merge(NEI, vehicle_scc, by = "SCC")

cities <- subset(
  vehicle_emissions,
  fips %in% c("24510", "06037")
)

cities$fips <- factor(
  cities$fips,
  levels = c("24510", "06037"),
  labels = c("Baltimore City", "Los Angeles County")
)

vehicle_by_city <- aggregate(
  Emissions ~ year + fips,
  cities,
  sum
)

png("plot6.png", width = 480, height = 480)

ggplot(vehicle_by_city, aes(x = year, y = Emissions, color = fips)) +
  geom_line() +
  geom_point() +
  labs(
    title = "Motor Vehicle PM2.5 Emissions",
    x = "Year",
    y = "Total Emissions (tons)",
    color = "City"
  )

dev.off()
