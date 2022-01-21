consumption <- read.csv("data/food_consumption.csv")
source("Summary.R")

intro_page <- tabPanel(
  "Introduction",
  div(class = "intro",
      p("Welcome to a world of greenhouse gases, more specifically, Carbon
        Dioxide. Here you will be able to see how different countries around the
        world produce and consume foods which then leads to the carbon
        dioxide emissions released in each. Trying to answer the questions
        \"Which food product produces the highest carbon footprint?\", \"Which
        country has the highest CO2 emissions per person?\", and \"Which
        relevant fields (other than food), if included, contribute to the
        emissions?\", take a look into the different charts,
        graphs, and tables."),
      p("For our data, we've taken a look into three sources. From Nu3, the
        first data set we've decided to use is from the Food and Agriculture
        Organization of the UN (FAO). The data was collected to analyse and
        compare food consumption in 130 countries through 11 different food
        types in 2018. Nu3 is then able to calculate the amount of carbon
        dioxide emissions per person from these 130 countries, to figure out
        which diets are the most sustainable in certain countries."),
      p("In our second data set, we've used a 2018 study by J. Poore and T.
        Nemecek called Reducing food's environmental impacts through producers
        and consumers. In this data set, we are able to look at the carbon
        footprint of 43 different types of foods and the carbon emissions that
        come from producing these foods. This also gives a look into the
        environmental impacts that are a result of producing these various
        foods."),
      p("Our last data set is from the publication OurWorldinData, where they
        collected data from sources like the Global Carbon Atlas and Climate
        Watch, to show CO2 and greenhouse gas emissions of 207 countries and
        how other factors affect these emissions in each country."),
      p("Combining these three sources and their data, our goal is to identify
        which food product and country produces the most emissions to combat
        air pollution and possibly find more ways to live a sustainable
        lifestyle."),
      img(src = "https://www.cmu.edu/news/stories/archives/2020/april/images/greenhouse-gas-emissions-from-food-system900x600-min.jpg",
          style = "height: 300px")
  )
)

interactive_page_1 <- tabPanel(
  "Pie Chart",
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "country_input",
        label = "Country",
        choices = unique(consumption$country),
        selected = "USA"
      )
    ),

    mainPanel(
      plotOutput("pie_chart")
    )
  )

)

interactive_page_2 <- tabPanel(
  "Bar Chart",
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "product_type",
        label = "Total CO2 Emissions by Product",
        choices = unique(consumption$food_category),
        selected = "Beef"
      )
    ),

    mainPanel(
      plotlyOutput("bar_chart")
    )
  )

)

interactive_page_3 <- tabPanel(
  "Scatter Plot",
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "first_axis_input",
        label = "Select the first y-axis data(blue)",
        choices = c("Emission From All 11 Food Categories" =
                      "total_co2_emission_per_capita",
                    unique(consumption$food_category)),
        selected = "total_co2_emission_per_capita"
      ),

      selectInput(
        inputId = "second_axis_input",
        label = "Select the second y-axis data (brown)",
        choices = c(unique(consumption$food_category)),
        selected = "Beef"
      )
    ),

    mainPanel(
      plotlyOutput("scatterplot")
    )
  )
)

summary_page <- tabPanel(
  "Summary",
  div(class = "summary",
  p("Summary"),
  p("In summary, we've created a list called: summary_info,
    which includes 5 variables: _highest_co2_country, highest_food_consumed,
    mean_consumption, mean_co2_emmission, lowest_co2_emission_.
    The first variable: highest_co2_country, in which represents the country
    has the highest CO2 emissions per person is", strong(highest_co2_country),
    ". Next, the second variable: highest_food_consumed, represents the food
    category has highest consumption is", strong(highest_food_consumed),
    ". Following that, the third variable: mean_consumption, is the mean food
    consumption of", strong(round(mean_consumption, 2)),
    "; and fourth is mean co2 emmission (mean_co2_emmission):",
    strong(round(mean_co2_emmission, 2)), ". Last but not least, the lowest
    number of co2 emmission: lowest_co2_emission, is ",
    strong(lowest_co2_emission)),
  p("The table provides the total consumption and total CO2 emission
    (of all 130 countries combined) for each of the 11 food categories, which is
    then sorted by highest to lowest total CO2 emission. From the table, we can
    see that Beef is the food category that has the highest total CO2 emission
    by far, followed by Milk - inc. cheese. Comparing two meat products, poultry
    and beef, poultry has a much lower CO2 emission despite a higher total
    consumption. Meanwhile, the non-animal products (rice, soybeans, etc) rank
    much lower in total CO2 emission. This suggests that meat-heavy diets loaded
    with especially cow products (beef and dairy), will have a higher carbon
    footprint and thus contribute more to climate change."),
  h2("Summary Table"),
  div(class = "table",
      tableOutput("summary_table"),
      img(src = "https://cdn.vox-cdn.com/thumbor/cKg2JPJXDLHuw-uGvQquFJMoko8=/0x0:5151x2802/1820x1213/filters:focal(4119x208:4943x1032):format(webp)/cdn.vox-cdn.com/uploads/chorus_image/image/66342160/fresh_local_food_GettyImages_462800130.0.jpg",
          style = "height: 300px")
  )
)
)

ui <- fluidPage(
  includeCSS("www/style.css"),
  navbarPage(
    "Food Carbon Footprint",
    intro_page,
    interactive_page_1,
    interactive_page_2,
    interactive_page_3,
    summary_page
  ))
