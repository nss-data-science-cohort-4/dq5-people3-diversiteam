library(shiny)
library(tidyverse)
library(shinydashboard)

acs_data <- read_csv("../data/acs_5y_2018_data.csv")

stat_choices <- unique(acs_data$label_02)

