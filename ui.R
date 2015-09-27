library(dplyr)
library(lubridate)
library(rgdal)
library(ggplot2)
library(shiny)

#bc is now available.

shinyUI(fluidPage(

  # Application title
  titlePanel("Water Consumption"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
        h4('Show Me Water Consumed'),
        sliderInput("water_top",
                    label = h4(textOutput("pctUsers")),
                    min = 0,
                    max = 100, value = 3),
        p("Please use the slider above to see which neighborhoods contain
          the top % of water users and how much water they used."),
        p("This is not real data - it's only a small sample.")
    ),
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("waterUsage")
    )
  )
))
