library(ggplot2)
library(ggrepel)
library(tidyverse)

consumption <- read.csv("data/food_consumption.csv")

# pie chart - u.s. by food category percentage of co2 emission

us <- consumption %>%
  filter(country == "USA") %>%
  mutate(total_emission = sum(co2_emmission, na.rm = TRUE)) %>%
  mutate(percent_emission = (co2_emmission / total_emission) * 100) %>%
  select(food_category, percent_emission)

us$percent_emission <- round(us$percent_emission)

us2 <- us %>% 
  mutate(csum = rev(cumsum(rev(percent_emission))), 
         pos = percent_emission/2 + lead(csum, 1),
         pos = if_else(is.na(pos), percent_emission/2, pos)) %>%
  filter(percent_emission > 1)

pie_chart <- ggplot(us, aes(x = "" , y = percent_emission, 
                            fill = fct_inorder(food_category))) +
  geom_col(width = 1, color = "white") +
  coord_polar(theta = "y") +
  geom_label_repel(data = us2,
                   aes(y = pos, label = paste0(percent_emission, "%")),
                   size = 4, nudge_x = 1, show.legend = FALSE, 
                   segment.size = 0.25) +
  guides(fill = guide_legend(title = "Food Category")) +
  labs(title = "Breakdown of U.S. CO2 Emission by Food Category") +
  theme_void()
