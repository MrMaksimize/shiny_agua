source('./global.R')

library(shiny)

#bc is now available.

shinyServer(function(input, output) {


  output$waterUsage <- renderPlot({
    print("Running Cal")
    wu <- bc %>%
      filter(water_cons >= input$wc_range[1] & water_cons <= input$wc_range[2]) %>%
      filter(sewer_cons >= input$sc_range[1] & sewer_cons <= input$sc_range[2]) %>%
      group_by(cpcode, cpname) %>%
      summarise(water_cons = sum(water_cons))

    g <- ggplot(data = wu, aes(x = cpname, y = water_cons)) +
        geom_bar(stat = "identity") +
        coord_flip()
    g

  })

  output$wc_val <- renderPrint(input$wc_range)
  output$sc_val <- renderPrint(input$sc_range)

})
