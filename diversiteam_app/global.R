library(shiny)
library(tidyverse)
library(shinydashboard)
library(readxl)
library(dplyr)
library(ggplot2)
library(plotly)

require(scales)

acs_data <- read_csv("../data/acs_data_converted.csv") %>% 
  drop_na(xValue)

stat_choices <- unique(acs_data$dropDownMain)

