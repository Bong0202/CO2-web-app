library(tidyverse)
library(ggplot2)
library(plotly)

# carbon footprint per capita from food consumption vs gdp per capita (2018)
generate_scatterplot <- function(first_axis_input, second_axis_input) {
  continents <- c(
    "World", "Europe", "North America", "Asia", "Africa", "South America",
    "Asia (excl. China & India)", "Europe (excl. EU-28)",
    "Europe (excl. EU-27)", "EU-28", "EU-27", "North America (excl. USA)",
    "International transport", "Antarctica", "Kuwaiti Oil Fires", "Oceania"
  )

  consumption$country[consumption$country == "USA"] <-
    "United States"

  consumption$country[consumption$country == "Hong Kong SAR. China"] <-
    "Hong Kong"

  # 2018 gdp per capita for each country
  gdp_per_capita <- countries_emission %>%
    filter(year == 2018) %>%
    filter(!is.element(country, continents)) %>%
    select(country, gdp, population) %>%
    mutate(gdp_per_capita = gdp / population)

  if (first_axis_input == "total_co2_emission_per_capita") {
    consumption_summary <- consumption %>%
      group_by(country) %>%
      summarise(co2_emmission = sum(co2_emmission))
  } else {
    consumption_summary <- consumption %>%
      filter(food_category == first_axis_input)
  }

  # full outer join on country
  joined_data <- merge(x = consumption_summary, y = gdp_per_capita,
                       by = "country", all = TRUE) %>%
    select(country, co2_emmission, gdp_per_capita) %>%
    na.omit()

  second_input_data <- consumption %>%
    filter(food_category == second_axis_input)

  second_input_data <- merge(x = second_input_data, y = gdp_per_capita,
                             by = "country", all = TRUE) %>%
    select(country, co2_emmission, gdp_per_capita) %>%
    na.omit()

  scatterplot <- ggplot(data = joined_data,
                        aes(x = gdp_per_capita, y = co2_emmission)) +
    geom_point(aes(text = paste("Country:", country)),
               alpha = 0.5, color = "blue") +
    geom_smooth(data = joined_data, method = "lm", se = FALSE, size = 0.5,
                alpha = 0.6, color = "blue") +
    geom_point(data = second_input_data,
               aes(text = paste("Country:", country),
                   x = gdp_per_capita, y = co2_emmission),
               alpha = 0.5, color = "brown") +
    geom_smooth(data = second_input_data, method = "lm", se = FALSE, size = 0.5,
                alpha = 0.6, color = "brown") +
    labs(
      title =
        "Relationship between GDP Per Capita and CO2 Emissions Per Capita",
      x = "GDP Per Capita (international dollars",
      y = "CO2 Emissions per Capita (kg CO2/year)"
    )

  scatterplotly <- ggplotly(scatterplot, tooltip = c("text", "x", "y"))

  return(scatterplotly)
}
