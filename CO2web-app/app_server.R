consumption <- read.csv("data/food_consumption.csv")
production <- read.csv("data/Food_Production.csv")
countries_emission <- read.csv("data/owid-co2-data.csv")

source("pie_chart_server.R")
source("scatterplot_server.R")
source("barchart_server.R")
source("table.R")

server <- function(input, output) {
  output$pie_chart <- renderPlot({
    generate_pie_chart(input$country_input)
  })

  output$scatterplot <- renderPlotly({
    generate_scatterplot(input$first_axis_input, input$second_axis_input)
  })

  output$bar_chart <- renderPlotly({
    generate_barchart(input$product_type)
  })
  output$summary_table <- renderTable(summary_table)
}
