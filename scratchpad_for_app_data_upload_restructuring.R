library(readxl)
library(dplyr)
library(tidyverse)
xl_data <- "data/Example_Profile.xlsx"

# Read in each sheet as a dataframe
for (i in 1:3){
sheetname <- (excel_sheets(path = xl_data)[i])

assign(paste(sheetname), read_xlsx("data/Example_Profile.xlsx",sheet = sheetname))
}

# Create the sex dataframe
sex <- Age %>% 
  select(c('Sex', 'Total')) %>% 
  filter(Sex != 'Total') %>% 
  mutate(dropDownMain = 'Sex') %>% 
  rename(xValue = Sex, yValue = Total)

# Create the age dataframe
age_pivoted <-
  Age %>% 
  filter(Sex == 'Total') %>% 
  select(-c(Total, Sex)) %>%
  pivot_longer(
  cols = c('Under 20 years', '20 to 29 years', '30 to 39 years', '40 to 49 years', '50 to 59 years', '60 years and over'),
  names_to = "xValue",
  values_to = "yValue"
) %>% mutate(dropDownMain = 'Age')
  
# Create the education dataframe
education_pivoted <-
  Education %>% 
  filter(Sex == 'Total') %>% 
  select(-c(Sex, Total)) %>%
  pivot_longer(
    cols = c("No High School Diploma", "High school graduate (includes equivalency)", "Some college, no degree", "Associate's degree", "Bachelor's degree", "Master's degree", "Professional school degree", "Doctorate degree"),
    names_to = "xValue",
    values_to = "yValue"
  ) %>%
  mutate(dropDownMain = 'Education')

# Create the race/ethnicity dataframe, part 1
ethnicity <-
  Race %>% 
  select(c(Ethnicity, Total)) %>% 
  filter(Ethnicity == 'Hispanic or Latino') %>% 
  mutate(dropDownMain = 'Race') %>% 
  rename(xValue = Ethnicity, yValue = Total)
  
# Create the race/ethnicity dataframe, part 2
race_pivoted <-
  Race %>% 
  filter(Ethnicity == 'Total') %>% 
  select(-c('Total', 'Ethnicity', 'Two races including Some other race', 'Two races excluding Some other race, and three or more races')) %>%
  pivot_longer(
    cols = c("White alone", "Black or African American", "American Indian and Alaska Native", "Asian", "Native Hawaiian and Other Pacific Islander", "Some other race", "Two or more races:"),
    names_to = "xValue",
    values_to = "yValue"
  ) %>% mutate(dropDownMain = 'Race') %>% 
  mutate(xValue = sub("Two or more races:", "Two or more races", xValue))

combined <-
  bind_rows(race_pivoted, ethnicity, education_pivoted, age_pivoted, sex)
