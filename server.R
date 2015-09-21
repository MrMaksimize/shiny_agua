source('./global.R')

library(shiny)

#bc is now available.

shinyServer(function(input, output) {

  output$waterUsage <- renderPlot({
    inputCpcode = input$cpcode
    plotData <- bc
    if (inputCpcode != "")
      plotData <- filter(bc, cpcode == inputCpcode)
    g <- ggplot(data = plotData, aes(x = "")


  })

  output$debug <- renderText(input$cpcode)

})
