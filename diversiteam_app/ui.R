# Define UI for application that draws a histogram
shinyUI(dashboardPage(
    
    # Application title
    dashboardHeader(title = "Diversiteam"),
    
    # Sidebar with a slider input for number of bins
    
    dashboardSidebar(
        selectInput("stat",
                    "Choose your desired statistic:",
                    choices = stat_choices,
                    selected = stat_choices[1]
                    
        ),
    
        fileInput("file",
                  "Choose a file:")
    ),
    
    # Show a plot of the generated distribution
    dashboardBody(
        fluidRow(
            column(width = 8,
                   box(width = NULL,
                       plotOutput("base_bargraph")
                   )
            ),
            column(width = 4,
                   box(width = NULL,
                       plotOutput("barPlot")
                   )
            )
        )
    )
)
)
