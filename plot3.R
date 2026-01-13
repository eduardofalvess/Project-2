# plot3.R
# Emissions by source type in Baltimore City

library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")

baltimore <- subset(NEI, fips == "24510")

emissions_by_type <- aggregate(
  Emissions ~ year + type,
  baltimore,
  sum
)

png("plot3.png", width = 480, height = 480)

ggplot(emissions_by_type, aes(x = year, y = Emissions, color = type)) +
  geom_line() +
  geom_point() +
  labs(
    title = "PM2.5 Emissions by Source Type in Baltimore City",
    x = "Year",
    y = "Total Emissions (tons)"
  )

dev.off()
