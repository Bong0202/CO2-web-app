library(ggrepel)

generate_pie_chart <- function(country_input) {
  df <- consumption %>%
    filter(country == country_input) %>%
    mutate(total_emission = sum(co2_emmission, na.rm = TRUE)) %>%
    mutate(percent_emission = (co2_emmission / total_emission) * 100) %>%
    select(food_category, percent_emission)

  df$percent_emission <- round(df$percent_emission)

  df2 <- df %>%
    mutate(
      csum = rev(cumsum(rev(percent_emission))),
      pos = percent_emission / 2 + lead(csum, 1),
      pos = if_else(is.na(pos), percent_emission / 2, pos)
    ) %>%
    filter(percent_emission > 1)

  pie_chart <- ggplot(df, aes(
    x = "", y = percent_emission,
    fill = fct_inorder(food_category)
  )) +
    geom_col(width = 1, color = "white") +
    coord_polar(theta = "y") +
    geom_label_repel(
      data = df2,
      aes(y = pos, label = paste0(percent_emission, "%")),
      size = 4, nudge_x = 1, show.legend = FALSE,
      segment.size = 0.25
    ) +
    guides(fill = guide_legend(title = "Food Category")) +
    labs(title = paste(
      "Breakdown of", country_input,
      "CO2 Emission by Food Category"
    )) +
    theme_void()

  return(pie_chart)
}
