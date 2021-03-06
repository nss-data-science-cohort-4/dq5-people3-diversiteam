# Define UI for application that draws a histogram
shinyUI(dashboardPage(
    skin = "yellow",
    
    # Application title
    dashboardHeader(title = "People 3"),
    
    # Sidebar
    dashboardSidebar(
        
        # Create a selector input for the statistic
        selectInput(
            "stat",
            h4("Choose your desired statistic:"),
            choices = stat_choices,
            selected = stat_choices[1]
        ),
        
        # Create a selector for raw #s or %s
        selectInput(
            'num_or_pct',
            h4('Compare by raw #s or %s:'),
            choices = c("Raw Numbers" = "yValue",
                        "Percent of Population" = "percentEst"),
            selected = "Raw Numbers"
        ),
        
        # And a file input for the spreadsheet
        fileInput(
            'file',
            h4('Upload your company demographics excel file:'),
            accept = '.xlsx'
        )
    ),
    
    # Body
    dashboardBody(
        tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
        ),
        tabsetPanel(
            tabPanel("Bar Graphs",
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
                               plotOutput("company_bargraph")
                           )
                    )
                )
            ),
            tabPanel("Treemaps",
                    # Create boxes to style each plot
                    fluidRow(
                        # Left plot with the bar graph for the base dataset
                        column(width = 6,
                               box(width = NULL,
                                   plotOutput("base_treemap")
                               )
                        ),
                        # Right plot with the bar graph for the company dataset
                        column(width = 6,
                               box(width = NULL,
                                   plotOutput("company_treemap")
                               )
                        )
                    )
            )
            )
    )
)
)
