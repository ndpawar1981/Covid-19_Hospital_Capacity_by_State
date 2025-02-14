library(shiny)
library(plotly)
library(tidyverse)
library(DT)
library(shinydashboard)
library(leaflet)
library(shinyWidgets)
library(scales) 
library(lubridate)
library(glue)

covid <- read.csv('./data/COVID.csv',check.names = FALSE)
covid_filtered <- covid |> 
  select(state,date,
         critical_staff_shortage = critical_staffing_shortage_today_yes,
         onset_covid = hospital_onset_covid,
         inpatient_beds,
         inpatient_beds_used,
         inpatient_beds_used_covid,
         adult_covid_admission_confirmed = previous_day_admission_adult_covid_confirmed,
         adult_covid_admission_suspected = previous_day_admission_adult_covid_suspected,
         pediatric_covid_admission_confirmed = previous_day_admission_pediatric_covid_confirmed,
         pediatric_covid_admission_suspected = previous_day_admission_pediatric_covid_suspected,
         total_adult_patients_hospitalized_confirmed_and_suspected_covid,
         total_adult_patients_hospitalized_confirmed_covid,
         total_pediatric_patients_hospitalized_confirmed_and_suspected_covid,
         total_pediatric_patients_hospitalized_confirmed_covid,
         total_staffed_adult_icu_beds,
         staffed_adult_icu_bed_occupancy,
         staffed_icu_adult_patients_confirmed_and_suspected_covid,
         staffed_icu_adult_patients_confirmed_covid,
         inpatient_beds_utilization,
         percent_of_inpatients_with_covid,
         inpatient_bed_covid_utilization,
         adult_icu_bed_covid_utilization,
         adult_icu_bed_utilization,
         adult_covid_admission_confirmed_18_19 = `previous_day_admission_adult_covid_confirmed_18-19`,
         adult_covid_admission_confirmed_20_29 = `previous_day_admission_adult_covid_confirmed_20-29`,
         adult_covid_admission_confirmed_30_39 = `previous_day_admission_adult_covid_confirmed_30-39`,
         adult_covid_admission_confirmed_40_49 = `previous_day_admission_adult_covid_confirmed_40-49`,
         adult_covid_admission_confirmed_50_59 = `previous_day_admission_adult_covid_confirmed_50-59`,
         adult_covid_admission_confirmed_60_69 = `previous_day_admission_adult_covid_confirmed_60-69`,
         adult_covid_admission_confirmed_70_79 = `previous_day_admission_adult_covid_confirmed_70-79`,
         adult_covid_admission_confirmed_80_plus  = `previous_day_admission_adult_covid_confirmed_80+`,
         adult_covid_admission_confirmed_unknown = `previous_day_admission_adult_covid_confirmed_unknown`,
         deaths_covid,
         pediatric_inpatient_bed_occupied = all_pediatric_inpatient_bed_occupied,
         pediatric_inpatient_beds = all_pediatric_inpatient_beds,
         admission_pediatric_covid_confirmed_0_4 = previous_day_admission_pediatric_covid_confirmed_0_4,
         admission_pediatric_covid_confirmed_5_11 = previous_day_admission_pediatric_covid_confirmed_5_11,
         admission_pediatric_covid_confirmed_12_17 = previous_day_admission_pediatric_covid_confirmed_12_17,
         admission_pediatric_covid_confirmed_unknown = previous_day_admission_pediatric_covid_confirmed_unknown,
         staffed_icu_pediatric_patients_confirmed_covid = staffed_icu_pediatric_patients_confirmed_covid,
         staffed_pediatric_icu_bed_occupancy,
         total_staffed_pediatric_icu_beds
         )

# ADD PERCENTAGE COLUMNS FOR PEDIATRIC WHICH WILL BE USED FOR PLOTS
covid_filtered <- covid_filtered |> 
  mutate(pediatric_icu_bed_covid_utilization = ifelse(is.na(total_staffed_pediatric_icu_beds) | is.na(staffed_icu_pediatric_patients_confirmed_covid) | total_staffed_pediatric_icu_beds == 0, 0, staffed_icu_pediatric_patients_confirmed_covid/total_staffed_pediatric_icu_beds),
         pediatric_icu_bed_utilization =  ifelse(is.na(total_staffed_pediatric_icu_beds) | is.na(staffed_pediatric_icu_bed_occupancy) | total_staffed_pediatric_icu_beds == 0, 0, staffed_pediatric_icu_bed_occupancy/total_staffed_pediatric_icu_beds)
  )
  
#convert the date column to DATE
covid_filtered$date <- as.Date(covid_filtered$date)

#Need to get state names.
statesList = read.csv('./data/data-map-state-abbreviations.csv')
covid_filtered <- left_join(covid_filtered, statesList, by = "state")

quarters_seq <- seq(as.Date("2020-01-01"), as.Date("2024-10-01"), by = "quarter")
quarter_labels <- paste0(year(quarters_seq), "-Q", quarter(quarters_seq))

statePop <- read.csv('./data/statePopulation.csv',check.names = FALSE)
statePop <- statePop |> 
  select(-demo) 


covid_filtered <- left_join(covid_filtered, statePop, by = "Name")


