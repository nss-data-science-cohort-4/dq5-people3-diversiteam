library(shiny)
library(tidyverse)
library(shinydashboard)
library(readxl)

acs_data <- read_csv("../data/acs_data_converted.csv")

stat_choices <- unique(acs_data$dropDownMain)

