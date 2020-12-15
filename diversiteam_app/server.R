# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    output$base_bargraph <- renderPlot({
        acs_data %>%
            filter(dropDownMain == input$stat) %>% 
            ggplot(aes(x = xValue, y = yValue)) +
            geom_bar(stat = 'Identity')
    })
    
    output$company_data_table <- renderTable({
        
        # Outputs a table or header based on uploaded file
        
        req(input$file)
        
        company_data <- read.csv(input$file$datapath,
                                 header = input$header)
        
        if(input$disp == "head") {
            return(head(company_data))
        }
        else {
            return(company_data)
        }
        
    })

    #observeEvent(input$file, {browser()})
    
})
