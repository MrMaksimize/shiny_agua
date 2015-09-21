source('./global.R')

library(shiny)

#bc is now available.

shinyServer(function(input, output) {

  output$waterUsage <- renderPlot({

    plotData <- filter(bc, cpcode == input$cpcode)
    hist()


  })

  output$debug <- renderText(input$cpcode)

})
