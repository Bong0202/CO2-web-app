library(tidyverse)
library(dplyr)


consumption <- read.csv("data/food_consumption.csv")
production <- read.csv("data/Food_Production.csv")
countries_emission <- read.csv("data/owid-co2-data.csv")

summary_info <- list()

# Which country has the highest CO2 emissions per person? highest_co2_country
highest_co2_country <- consumption %>%
  filter( co2_emmission == max(co2_emmission, na.rm = T)) %>% 
  pull(country)

# which food category has highest consumption? highest_food_consumed

highest_food_consumed <- consumption %>% 
  filter(consumption == max(consumption, na.rm = T)) %>% 
  pull(food_category)

# mean food consumption? mean_consumption

mean_consumption <- mean(consumption$consumption, na.rm = TRUE)

# mean co2 emmission? mean_co2_emmission

mean_co2_emmission <- mean(consumption$co2_emmission, na.rm = TRUE)

# lowest number of co2 emmission? lowest_co2_emission

lowest_co2_emission <- min(consumption$consumption, na.rm = TRUE)
  
# Summary_info list
summary_info$highest_co2_country <- highest_co2_country
summary_info$highest_food_consumed <- highest_food_consumed
summary_info$mean_consumption <- mean_consumption
summary_info$mean_co2_emmission <- mean_co2_emmission
summary_info$lowest_co2_emission <- lowest_co2_emission



 