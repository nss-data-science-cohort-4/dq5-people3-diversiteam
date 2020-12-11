# Define UI for application that draws a histogram
shinyUI(dashboardPage(
    
    # Application title
    dashboardHeader(title = "Diversiteam"),
    
    # Sidebar with a slider input for number of bins
    
    dashboardSidebar(
        sliderInput("bins",
                    "Number of bins:",
                    min = 1,
                    max = 50,
                    value = 30),
        selectInput("island",
                    "Choose an island:",
                    choices = xxx,
                    selected = xxx[1]
                    
        ),
        fileInput("file",
                  "Choose a file:")
    ),
    
    # Show a plot of the generated distribution
    dashboardBody(
        fluidRow(
            column(width = 8,
                   box(width = NULL,
                       plotOutput("distPlot")
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
