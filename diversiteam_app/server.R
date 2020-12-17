# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    # Create a reactive element that munges the provided data
    company_data <- reactive({
        # Require an input so that it doesn't show an error
        req(input$file)
        # Read in each sheet as a dataframe
        for (i in 1:3){
            xl_data <- input$file$datapath
            
            sheetname <- (excel_sheets(path = xl_data)[i])
            
            assign(paste(sheetname), read_xlsx(xl_data, sheet = sheetname))
        }
        
        # Create the sex dataframe
        sex <- Age %>% 
            select(c('Sex', 'Total')) %>% 
            filter(Sex != 'Total') %>% 
            mutate(dropDownMain = 'Sex') %>% 
            rename(xValue = Sex, yValue = Total)
        
        # Create the age dataframe
        age_pivoted <-
            Age %>% 
            filter(Sex == 'Total') %>% 
            select(-c(Total, Sex)) %>%
            pivot_longer(
                cols = c('Under 20 years', '20 to 29 years', '30 to 39 years', '40 to 49 years', '50 to 59 years', '60 years and over'),
                names_to = "xValue",
                values_to = "yValue"
            ) %>% mutate(dropDownMain = 'Age')
        
        # Create the education dataframe
        education_pivoted <-
            Education %>% 
            filter(Sex == 'Total') %>% 
            select(-c(Sex, Total)) %>%
            pivot_longer(
                cols = c("No High School Diploma", "High school graduate (includes equivalency)", "Some college, no degree", "Associate's degree", "Bachelor's degree", "Master's degree", "Professional school degree", "Doctorate degree"),
                names_to = "xValue",
                values_to = "yValue"
            ) %>%
            mutate(dropDownMain = 'Education')
        
        # Create the race/ethnicity dataframe, part 1
        ethnicity <-
            Race %>% 
            select(c(Ethnicity, Total)) %>% 
            filter(Ethnicity == 'Hispanic or Latino') %>% 
            mutate(dropDownMain = 'Race and Ethnicity') %>% 
            rename(xValue = Ethnicity, yValue = Total)
        
        # Create the race/ethnicity dataframe, part 2
        race_pivoted <-
            Race %>% 
            filter(Ethnicity == 'Total') %>% 
            select(-c('Total', 'Ethnicity', 'Two races including Some other race', 'Two races excluding Some other race, and three or more races')) %>%
            pivot_longer(
                cols = c("White alone", "Black or African American", "American Indian and Alaska Native", "Asian", "Native Hawaiian and Other Pacific Islander", "Some other race", "Two or more races:"),
                names_to = "xValue",
                values_to = "yValue"
            ) %>% mutate(dropDownMain = 'Race and Ethnicity') %>% 
            mutate(xValue = sub("Two or more races:", "Two or more races", xValue))
        
        combined <-
            bind_rows(race_pivoted, ethnicity, education_pivoted, age_pivoted, sex) %>% 
            group_by(dropDownMain) %>% 
            mutate(Total = sum(yValue)) %>% 
            mutate(percentEst = yValue / Total * 100) %>% 
            select(-Total)
    })
    
    output$base_bargraph <- renderPlot({
        acs_data %>%
            filter(dropDownMain == input$stat) %>% 
            ggplot(aes(x = xValue, y = get(input$num_or_pct))) +
            geom_col() +
            ggtitle('Metro Nashville Demographics') +
            xlab('') +
            ylab(case_when(
                input$num_or_pct == 'yValue' ~ 'Count',
                input$num_or_pct == 'percentEst' ~ 'Percent')
                ) +
            scale_y_continuous(labels = comma) +
            theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1)) +
            theme(plot.title = element_text(hjust = 0.5))
    })
    
    output$company_bargraph <- renderPlot({
        company_data() %>%
            filter(dropDownMain == input$stat) %>% 
            ggplot(aes(x = xValue, y = get(input$num_or_pct))) +
            geom_col() +
            ggtitle('Company Demographics') +
            xlab('') +
            ylab(case_when(
                input$num_or_pct == 'yValue' ~ 'Count',
                input$num_or_pct == 'percentEst' ~ 'Percent')
            ) +
            scale_y_continuous(labels = comma) +
            theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1)) +
            theme(plot.title = element_text(hjust = 0.5))
    })
    
    output$base_treemap <- renderPlot({
        acs_data %>% 
            filter(dropDownMain == input$stat) %>% 
            ggplot(aes(area = get(input$num_or_pct), fill = percentEst, label = paste(xValue,paste((round(percentEst, 0)),"%",sep=""),sep="\n"))) +
            geom_treemap() +
            ggtitle('Metro Nashville Demographics') +
            geom_treemap_text(colour = "white", place = "topleft", reflow = T)
    })
    
    output$company_treemap <- renderPlot({
        company_data() %>%
            filter(dropDownMain == input$stat) %>% 
            ggplot(aes(area = get(input$num_or_pct), fill = percentEst, label = paste(xValue,paste((round(percentEst, 0)),"%",sep=""),sep="\n"))) +
            geom_treemap() +
            ggtitle('Company Demographics') +
            geom_treemap_text(colour = "white", place = "topleft", reflow = T)
    })
})
