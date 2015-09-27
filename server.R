source('./global.R')

library(shiny)

#bc is now available.

shinyServer(function(input, output) {
   output$waterUsage <- renderPlot({
       wu <- reactive({
           bc %>%
               select(everything()) %>%
               filter(
                   water_cons > quantile(
                       water_cons, 1 - (input$water_top / 100)
                   )
               )
       })
      g <- ggplot(data = wu(), aes(x = cpname, y = water_cons)) +
          geom_bar(stat="identity") +
          coord_flip() +
          xlab("Neighborhood") +
          ylab("Water Consumption")

      g

  })
})
