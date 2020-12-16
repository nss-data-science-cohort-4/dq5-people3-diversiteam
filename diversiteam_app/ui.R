# Define UI for application that draws a histogram
shinyUI(dashboardPage(
    
    # Application title
    dashboardHeader(title = "Diversiteam App"),
    
    # Sidebar
    dashboardSidebar(
        # And a file input for the spreadsheet
        fileInput(
            'file',
            h4('Upload a CSV or XLSX spreadsheet'),
            accept = c(
                'text/csv',
                'text/comma-separated-values,text/plain',
                '.csv',
                '.xlsx'
                )
            ),
        
        # Add a selector for file type
        radioButtons(
            "fileType_Input",
            label = h4("Choose file type"),
            choices = list(".csv/txt" = 1, ".xlsx" = 2),
            selected = 1,
            inline = TRUE
        ),
        
        # Create a selector input for the statistic
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
