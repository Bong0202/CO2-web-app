library(tidyverse)
library(ggplot2)

countries_emission <- read.csv("data/owid-co2-data.csv")

# scatterplot - time vs co2 emission of the U.S
us_data <- countries_emission %>%
  filter(iso_code == "USA") %>%
  select(year, co2)

scatter_plot <- ggplot(data = us_data) +
  geom_point(mapping = aes(x = year, y = co2), size = 1) +
  labs(x = "Year", y = "Tons of CO2 Emission (in millions)",
       title = "U.S. Annual CO2 Emissions") +
  scale_x_continuous(breaks = seq(1800, 2020, by = 20))