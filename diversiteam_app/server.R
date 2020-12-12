# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    output$base_bargraph <- renderPlot({
        acs_data %>%
            ggplot(aes(x = label_03, y = value)) +
            geom_bar()
    })

    observeEvent(input$file, {browser()})
    
})
