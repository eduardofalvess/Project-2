# plot4.R
# Coal combustion-related emissions in the United States

library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coal_scc <- SCC[grep("coal", SCC$EI.Sector, ignore.case = TRUE), ]

coal_emissions <- merge(NEI, coal_scc, by = "SCC")

coal_by_year <- aggregate(Emissions ~ year, coal_emissions, sum)

png("plot4.png", width = 480, height = 480)

ggplot(coal_by_year, aes(x = year, y = Emissions)) +
  geom_line() +
  geom_point() +
  labs(
    title = "Coal Combustion PM2.5 Emissions in the United States",
    x = "Year",
    y = "Total Emissions (tons)"
  )

dev.off()
