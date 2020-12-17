library(shiny)
library(tidyverse)
library(shinydashboard)
library(readxl)
library(dplyr)
library(ggplot2)
library(plotly)
library(treemapify)
library(extrafont)
loadfonts(device="win")

require(scales)

acs_data <- read_csv("../data/acs_data_converted.csv") %>% 
  drop_na(xValue) %>% 
  subset(dropDownSub != "18 years and over" & dropDownSub != "65 years and over" | is.na(dropDownSub)) %>% 
  subset(xValue != "Bachelor's degree or higher" & xValue != "High school graduate or higher")


stat_choices <- unique(acs_data$dropDownMain)

bar_order_race = c('White', 'Black or African American','Hispanic or Latino','Asian','First Nation','Pacific Islander','Two or more races','Some other race')
bar_order_age = c('Under 18 years','18 to 24 years', '25 to 34 years', '35 to 44 years','45 to 54 years','55 to 64 years','65 to 74 years','75 to 84 years','85 years and over')
bar_order_sex = c('Female', 'Male')
bar_order_edu = c("Less than 9th grade", "No HS Diploma", "HS Graduate","Some college, no degree","Associate's degree","Bachelor's degree","Graduate or professional degree")

bar_order_race_c1 = c("White alone", "Black or African American", "American Indian and Alaska Native", "Asian", "Native Hawaiian and Other Pacific Islander", "Some other race", "Two or more races:")
bar_order_race_c2 ="Hispanic or Latino"
bar_order_age_c = c('Under 20 years','20 to 29 years', '30 to 39 years', '40 to 49 years','50 to 59 years','60 years and over')
bar_order_sex_c = c('Female', 'Male')
bar_order_edu_c = c("No High School Diploma", "High school graduate (includes equivalency)", "Some college, no degree", "Associate's degree", "Bachelor's degree", "Master's degree", "Professional school degree", "Doctorate degree")