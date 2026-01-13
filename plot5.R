# plot5.R
# Motor vehicle emissions in Baltimore City

library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

vehicle_scc <- SCC[grep("vehicle", SCC$EI.Sector, ignore.case = TRUE), ]

vehicle_emissions <- merge(NEI, vehicle_scc, by = "SCC")

baltimore_vehicle <- subset(vehicle_emissions, fips == "24510")

vehicle_by_year <- aggregate(
  Emissions ~ year,
  baltimore_vehicle,
  sum
)

png("plot5.png", width = 480, height = 480)

ggplot(vehicle_by_year, aes(x = year, y = Emissions)) +
  geom_line() +
  geom_point() +
  labs(
    title = "Motor Vehicle PM2.5 Emissions in Baltimore City",
    x = "Year",
    y = "Total Emissions (tons)"
  )

dev.off()
