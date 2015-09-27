library(dplyr)
library(lubridate)
library(rgdal)
library(ggplot2)
library(shiny)


#Preprocess the data
wbill <- read.csv("./data/billing/bill_sample_complete.csv")
# Load SHP
com_plan <- readOGR(
    paste0("./data/shp/community_plan_sd"),
    layer = "community_plan_sd")

bc <- wbill %>%
    mutate(billing_frequency = toupper(billing_frequency),
           loc_in_city = toupper(loc_in_city)) %>%
    mutate(bill_post_date = mdy(bill_date_posting_date),
           meter_read_date = mdy(meter_read_date)) %>%
    # Remove rows that are not bi-monthly since that will skew the data:
    filter(billing_frequency == 'B') %>%
    # Remove rows that are not in a city
    filter(loc_in_city == 'IN') %>%
    select(
        id,
        cpcode,
        cpname,
        water_cons = water_consumption,
        sewer_cons = sewer_consumption
    )

# Shiny Server!
shinyServer(function(input, output) {
   output$pctUsers <- renderText({
       paste0(
           "By the Top ",
           input$water_top,
           "% of Water Users."
       )
   })
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
