# Define UI for application that draws a histogram
shinyUI(dashboardPage(
    
    # Application title
    dashboardHeader(title = "Diversiteam App"),
    
    # Sidebar
    dashboardSidebar(
        # And a file input for the spreadsheet
        fileInput("file",
                  "Choose a file:"
                  ),
        
        # Ask the user if the file they have uploaded has a header
        checkboxInput("header",
                      "Does the file contain a header?",
                      selected = TRUE
                      ),
        
        # Select whether to show
        radioButtons("disp", "Display",
                     choices = c(Head = "head",
                                 All = "all"),
                     selected = "head"
                     ),
        
        # With a selector input for the statistic
        selectInput("stat",
                    "Choose your desired statistic:",
                    choices = stat_choices,
                    selected = stat_choices[1]
        )
    ),
    
    # Body
    dashboardBody(
        # Create boxes to style each plot
        fluidRow(
            # Left plot with the bar graph for the base dataset
            column(width = 6,
                   box(width = NULL,
                       plotOutput("base_bargraph")
                   )
            ),
            # Right plot with the bar graph for the company dataset
            column(width = 6,
                   box(width = NULL,
                       tableOutput("company_data_table")
                   )
            )
        )
    )
)
)
