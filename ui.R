source('./global.R')
library(shiny)

#bc is now available.

shinyUI(fluidPage(

  # Application title
  titlePanel("Water Consumption"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "cpcode",
                  selected = 15,
                  multiple = FALSE,
                  label = h3("Community Planning District"),
                  choices = getCPDList(TRUE)),
      textOutput("debug")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("waterUsage")
    )
  )
))
