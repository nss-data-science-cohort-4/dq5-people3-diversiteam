library(shiny)
library(tidyverse)
library(shinydashboard)
library(readxl)
library(dplyr)
library(ggplot2)
library(plotly)

require(scales)

acs_data <- read_csv("../data/acs_data_converted.csv") %>% 
  drop_na(xValue) %>% 
  subset(xValue != "Bachelor's degree or higher" & xValue != "High school graduate or higher" & dropDownSub != "18 years and over" & dropDownSub != "65 years and over" | is.na(dropDownSub))


stat_choices <- unique(acs_data$dropDownMain)

