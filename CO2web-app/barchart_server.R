library(tidyverse)
library(ggplot2)


generate_barchart <- function(product_type) {
  animal_products <- c(
    "Pork", "Poultry", "Beef", "Lamb & Goat", "Fish",
    "Eggs", "Milk - inc. cheese"
  )
  non_animal_products <- c(
    "Wheat and Wheat Products", "Rice", "Soybeans",
    "Nuts inc. Peanut Butter"
  )

  category_data <- consumption %>%
    filter(food_category == product_type) %>%
    group_by(country) %>%
    summarize(co2_emission = co2_emmission) %>%
    arrange(desc(co2_emission)) %>%
    head(10)

  bar_chart <- ggplot(data = category_data, aes(
    x = reorder(country, co2_emission),
    y = co2_emission
  )) +
    geom_bar(stat = "identity", fill = "pink") +
    coord_flip() +
    labs(
      x = "Country", y = "Total Emission (kg CO2/person/year)",
      title =
        paste("Top 10 Total CO2 Emissions by Country from", product_type)
    )

  return(ggplotly(bar_chart, tooltip = c("y")))
}
