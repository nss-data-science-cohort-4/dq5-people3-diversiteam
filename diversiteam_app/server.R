# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    output$distPlot <- renderPlot({
    })

    observeEvent(input$file, {browser()})
    
})
