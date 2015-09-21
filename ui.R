source('./global.R')
library(shiny)

#bc is now available.

shinyUI(fluidPage(

  # Application title
  titlePanel("Water Consumption"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
#       selectInput(inputId = "cpcode",
#                   selected = 15,
#                   multiple = FALSE,
#                   label = h3("Community Planning District"),
#                   choices = getCPDList(TRUE)),
           sliderInput("wc_range",
                       label = h3("Water Consumption"),
                       min = 0,
                       max = 100,
                       value = c(0, 100)),

           sliderInput("sc_range",
                       label = h3("Sewer Consumption"),
                       min = 0,
                       max = 100,
                       value = c(0, 100)),
        fluidRow(
            column(4, verbatimTextOutput("wc_val")),
            column(4, verbatimTextOutput("sc_val"))
        )
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("waterUsage")
    )
  )
))
