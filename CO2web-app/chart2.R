library(tidyverse)
library(ggplot2)

consumption <- read.csv("data/food_consumption.csv")

# bar chart - top 10 countries sorted by co2 emissions
products <- unique(consumption$food_category)
animal_products <- c("Pork", "Poultry", "Beef", "Lamb & Goat", "Fish",
                     "Eggs", "Milk - inc. cheese")
non_animal_products <- c("Wheat and Wheat Products", "Rice", "Soybeans",
                         "Nuts inc. Peanut Butter")


temp <- consumption %>%
  mutate(product_type = ifelse(is.element(food_category, animal_products), 
                               "animal", "non-animal"))

top_10 <- head(temp, 110) %>%
  group_by(country) %>%
  mutate(total_consumption = sum(consumption, na.rm = TRUE),
            total_emission = sum(co2_emmission, na.rm = TRUE)) %>%
  arrange(desc(total_emission))

bar_chart <- ggplot(top_10, aes(fill=product_type, y=co2_emmission, reorder(country, total_emission))) + 
  geom_bar(position="stack", stat="identity") +
  scale_y_continuous(breaks = seq(0, 3000, by = 200)) +
  labs(x = "Country", y = "Total Emission (kg CO2/person/year)",
       title = "Total CO2 Emissions by Country") +
  coord_flip() +
  guides(fill=guide_legend(title="Product Type"))

plot(bar_chart)
