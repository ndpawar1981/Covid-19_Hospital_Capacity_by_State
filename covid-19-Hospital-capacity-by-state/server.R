#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#


# Define server logic required to draw a histogram
function(input, output, session) {
  
  #Lets get data first..
  covid_data <- reactive({
    covid_data <- covid_filtered
    
    if (input$HospDataSelectState != "All"){
      covid_data <- covid_data |> 
        filter(state == input$HospDataSelectState &
                 date >= input$HospDataDateRange[1] & 
                 date <= input$HospDataDateRange[2])
    }
    return(covid_data)
  })
  
  ## Following code is related to the first Hospital Data page.
  
  total_avg_Inpatient_beds <- reactive({
    covid_data() |> 
      summarise(total_avg_Inpatient_beds = mean(inpatient_beds,na.rm = TRUE))
  })
  
  total_avg_Inpatient_beds_used <- reactive({
    covid_data() |> 
      summarise(total_avg_Inpatient_beds_used = mean(inpatient_beds_used,na.rm = TRUE))
  })
  
  total_avg_Inpatient_covid_beds <- reactive({
    covid_data() |> 
      summarise(total_avg_Inpatient_covid_beds = mean(inpatient_beds_used_covid,na.rm = TRUE))
  })
  
  Avg_staffed_adult_icu_beds <- reactive({
    covid_data() |> 
      summarise(Avg_staffed_adult_icu_beds = mean(total_staffed_adult_icu_beds,na.rm = TRUE))
  })
  
  Avg_staffed_adult_icu_beds_occupied <- reactive({
    covid_data() |> 
      summarise(Avg_staffed_adult_icu_beds_occupied = mean(staffed_adult_icu_bed_occupancy,na.rm = TRUE))
  })
  
  Avg_staffed_adult_icu_covid <- reactive({
    covid_data() |> 
      summarise(Avg_staffed_adult_icu_covid = mean(staffed_icu_adult_patients_confirmed_and_suspected_covid,na.rm = TRUE))
  })
  
  Avg_staffed_pediatric_icu_beds <- reactive({
    covid_data() |> 
      summarise(Avg_staffed_adult_icu_beds = mean(total_staffed_pediatric_icu_beds,na.rm = TRUE))
  })
  
  Avg_staffed_pediatric_icu_beds_used <- reactive({
    covid_data() |> 
      summarise(Avg_staffed_pediatric_icu_beds_used = mean(staffed_pediatric_icu_bed_occupancy,na.rm = TRUE))
  })
  
  Avg_staffed_pediatric_icu_covid <- reactive({
    covid_data() |> 
      summarise(Avg_staffed_pediatric_icu_covid = mean(staffed_icu_pediatric_patients_confirmed_covid,na.rm = TRUE))
  })
  
  Avg_Adults_Patients_Hospitalized_covid <- reactive({
    covid_data() |> 
      summarise(Avg_Adults_Patients_Hospitalized_covid = mean(total_adult_patients_hospitalized_confirmed_and_suspected_covid,na.rm = TRUE))
  })
  
  Avg_Pediatric_Patients_Hospitalized_covid <- reactive({
    covid_data() |> 
      summarise(Avg_Pediatric_Patients_Hospitalized_covid = mean(total_pediatric_patients_hospitalized_confirmed_and_suspected_covid,na.rm = TRUE))
  })
  
  Avg_Covid_deaths <- reactive({
    covid_data() |> 
      summarise(Avg_Covid_deaths = mean(deaths_covid,na.rm = TRUE))
  })
  
  # Output for value boxes
  output$avgInpatientsBeds <- renderValueBox({
    valueBox(
      value = format(total_avg_Inpatient_beds(), big.mark = ","),
      subtitle = "Avg Inpatient Beds",
      icon = icon("bed"),
      color = "blue"
    )
  })
  
  output$avgInpatientUsedBeds <- renderValueBox({
    valueBox(
      value = format(total_avg_Inpatient_beds_used(), big.mark = ","),
      subtitle = "Avg Inpatient Used Beds",
      icon = icon("bed")
    )
  })
  
  # Output for value boxes
  output$avgInpatientsCovidBeds <- renderValueBox({
    valueBox(
      value = format(total_avg_Inpatient_covid_beds(), big.mark = ","),
      subtitle = "Avg Inpatient Covid Beds",
      icon = icon("bed")
    )
  })
  
  output$avgStaffedAdultICUBeds <- renderValueBox({
    valueBox(
      value = format(Avg_staffed_adult_icu_beds(), big.mark = ","),
      subtitle = "Avg Adults ICU Beds",
      icon = icon("bed")
    )
  })
  
  output$avgStaffedAdultICUBedsOccupied <- renderValueBox({
    valueBox(
      value = format(Avg_staffed_adult_icu_beds_occupied(), big.mark = ","),
      subtitle = "Avg Adults ICU Beds Used",
      icon = icon("bed")
    )
  })
  
  output$AvgStaffedICUAdultsCovid <- renderValueBox({
    valueBox(
      value = format(Avg_staffed_adult_icu_covid(), big.mark = ","),
      subtitle = "Avg Adults ICU COVID patients",
      icon = icon("bed")
    )
  })
  
  output$AvgStaffedPiatricICUBeds <- renderValueBox({
    valueBox(
      value = format(Avg_staffed_pediatric_icu_beds(), big.mark = ","),
      subtitle = "Avg Pediatric ICU Beds",
      icon = icon("bed")
    )
  })
  
  output$AvgPiatricICUBedsUsed <- renderValueBox({
    valueBox(
      value = format(Avg_staffed_pediatric_icu_beds_used(), big.mark = ","),
      subtitle = "Avg Pediatric ICU Beds Used",
      icon = icon("bed")
    )
  })
  
  output$AvgICUPediatricCovid <- renderValueBox({
    valueBox(
      value = format(Avg_staffed_pediatric_icu_covid(), big.mark = ","),
      subtitle = "Avg Pediatric ICU COVID patients",
      icon = icon("bed")
    )
  })
  
  output$AvgAdultHospitalizedCovid <- renderValueBox({
    valueBox(
      value = format(Avg_Adults_Patients_Hospitalized_covid(), big.mark = ","),
      subtitle = "Avg Adult Hopsitlized COVID",
      icon = icon("person")
    )
  })
  
  output$AvgPediatricHospitalizedCovid <- renderValueBox({
    valueBox(
      value = format(Avg_Pediatric_Patients_Hospitalized_covid(), big.mark = ","),
      subtitle = "Avg Pediatric Hopsitlized COVID",
      icon = icon("person")
    )
  })
  
  output$AvgCovidDeaths <- renderValueBox({
    valueBox(
      value = format(Avg_Covid_deaths(), big.mark = ","),
      subtitle = "Avg COVID Deaths",
      icon = icon("person")
    )
  })
  
}
