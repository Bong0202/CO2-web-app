consumption <- read.csv("data/food_consumption.csv")

library(tidyverse)

summary_table <- consumption %>%
  group_by(food_category) %>%
  summarise(total_consumption = sum(consumption, na.rm = TRUE),
            total_emission = sum(co2_emmission, na.rm = TRUE)) %>%
  arrange(desc(total_emission))

summary_table <- summary_table %>%
  rename("Food Category" = food_category,
         "Total Consumption (kg/person/year)" = total_consumption,
         "Total CO2 Emission (Kg CO2/person/year)" = total_emission)

# The table provides the total consumption and total CO2 emission
# (of all 130 countries combined) for each of the 11 food categories,
# which is then sorted by highest to lowest total CO2 emission. From the
# table, we can see that "Beef" is the food category that has the highest
# total CO2 emission by far, followed by "Milk - inc. cheese". Comparing
# two meat products, poultry and beef, poultry has a much lower CO2 emission
# despite a higher total consumption. Meanwhile, the non-animal
# products (rice, soybeans, etc) rank much lower in total CO2 emission.
# This suggests that meat-heavy diets loaded with especially cow products
# (beef and dairy), will have a higher carbon footprint and thus contribute
# more to climate change.
