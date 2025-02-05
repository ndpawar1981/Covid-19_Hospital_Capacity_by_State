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
      summarise(total_avg_Inpatient_beds = round(mean(inpatient_beds,na.rm = TRUE),0))
  })
  
  total_avg_Inpatient_beds_used <- reactive({
    covid_data() |> 
      summarise(total_avg_Inpatient_beds_used = round(mean(inpatient_beds_used,na.rm = TRUE),0))
  })
  
  total_avg_Inpatient_covid_beds <- reactive({
    covid_data() |> 
      summarise(total_avg_Inpatient_covid_beds = round(mean(inpatient_beds_used_covid,na.rm = TRUE),0))
  })
  
  Avg_staffed_adult_icu_beds <- reactive({
    covid_data() |> 
      summarise(Avg_staffed_adult_icu_beds = round(mean(total_staffed_adult_icu_beds,na.rm = TRUE)))
  })
  
  Avg_staffed_adult_icu_beds_occupied <- reactive({
    covid_data() |> 
      summarise(Avg_staffed_adult_icu_beds_occupied = round(mean(staffed_adult_icu_bed_occupancy,na.rm = TRUE)))
  })
  
  Avg_staffed_adult_icu_covid <- reactive({
    covid_data() |> 
      summarise(Avg_staffed_adult_icu_covid = round(mean(staffed_icu_adult_patients_confirmed_and_suspected_covid,na.rm = TRUE)))
  })
  
  Avg_staffed_pediatric_icu_beds <- reactive({
    covid_data() |> 
      summarise(Avg_staffed_adult_icu_beds = round(mean(total_staffed_pediatric_icu_beds,na.rm = TRUE)))
  })
  
  Avg_staffed_pediatric_icu_beds_used <- reactive({
    covid_data() |> 
      summarise(Avg_staffed_pediatric_icu_beds_used = round(mean(staffed_pediatric_icu_bed_occupancy,na.rm = TRUE)))
  })
  
  Avg_staffed_pediatric_icu_covid <- reactive({
    covid_data() |> 
      summarise(Avg_staffed_pediatric_icu_covid = round(mean(staffed_icu_pediatric_patients_confirmed_covid,na.rm = TRUE)))
  })
  
  Avg_Adults_Patients_Hospitalized_covid <- reactive({
    covid_data() |> 
      summarise(Avg_Adults_Patients_Hospitalized_covid = round(mean(total_adult_patients_hospitalized_confirmed_and_suspected_covid,na.rm = TRUE)))
  })
  
  Avg_Pediatric_Patients_Hospitalized_covid <- reactive({
    covid_data() |> 
      summarise(Avg_Pediatric_Patients_Hospitalized_covid = round(mean(total_pediatric_patients_hospitalized_confirmed_and_suspected_covid,na.rm = TRUE)))
  })
  
  Avg_Covid_deaths <- reactive({
    covid_data() |> 
      summarise(Avg_Covid_deaths = mean(deaths_covid,na.rm = TRUE))
  })
  
  # Output for value boxes
  output$avgInpatientsBeds <- shinydashboard::renderValueBox({
    shinydashboard::valueBox(
      value = format(total_avg_Inpatient_beds(), big.mark = ","),
      subtitle = "Avg Inpatient Beds",
      icon = icon("bed"),
      color = #1b2838
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
  
  output$inpatient_time_series_plot <- renderPlot({
    
    title1 <- glue("Inpatient Hospital Utilization")
    if (input$HospDataSelectState != "All"){
      title1 <- paste0(title1, glue(" for {input$HospDataSelectState} State"))
    }
    
    df_filtered <- covid_data() %>%
      filter(date >= as.Date(input$HospDataDateRange[1]) & date <= as.Date(input$HospDataDateRange[2])) %>%
      arrange(date) |> 
      group_by(date) |> 
      summarise(inpatient_beds_utilization_avg = mean(inpatient_beds_utilization *100),
                inpatient_bed_covid_utilization_avg = mean(inpatient_bed_covid_utilization *100),
                percent_of_inpatients_with_covid_avg = mean(percent_of_inpatients_with_covid * 100)) 
    
    # Plot time series trends with labels
    ggplot(df_filtered, aes(x = date)) +
      geom_line(aes(y = inpatient_beds_utilization_avg, color = "Inpatient Beds Utilization"), size = 1) +
      geom_line(aes(y = inpatient_bed_covid_utilization_avg, color = "COVID Bed Utilization"), size = 1) +
      geom_line(aes(y = percent_of_inpatients_with_covid_avg, color = "Percent of Inpatients with COVID"), size = 1) +
      
      # # Add text labels every 30 days to reduce clutter
      geom_text(data = df_filtered %>% filter(day(date) %% 30 == 0),
                aes(y = inpatient_beds_utilization_avg, label = percent(inpatient_beds_utilization_avg / 100, accuracy = 0.1)),
                color = "black", vjust = -1, size = 3) +
      
      geom_text(data = df_filtered %>% filter(day(date) %% 30 == 0),
                aes(y = inpatient_bed_covid_utilization_avg, label = percent(inpatient_bed_covid_utilization_avg / 100, accuracy = 0.1)),
                color = "black", vjust = -1, size = 3) +
      
      geom_text(data = df_filtered %>% filter(day(date) %% 30 == 0),
                aes(y = percent_of_inpatients_with_covid_avg, label = percent(percent_of_inpatients_with_covid_avg / 100, accuracy = 0.1)),
                color = "black", vjust = -1, size = 3) +
      
      labs(
        title = title1,
        x = "Date",
        y = "Utilization Rate %",
        color = "Legend"
      ) +
      scale_color_manual(values = c("Inpatient Beds Utilization" = "blue", 
                                    "COVID Bed Utilization" = "red", 
                                    "Percent of Inpatients with COVID" = "orange"))
    
  })
  
  output$Adult_ICU_Bed_time_series_plot <- renderPlot({
    
    title2 <- glue("Adult ICU Bed Utilization")
    if (input$HospDataSelectState != "All"){
      title2 <- paste0(title2, glue(" for {input$HospDataSelectState} State"))
    }
    
    df_filtered2 <- covid_data() %>%
      filter(date >= as.Date(input$HospDataDateRange[1]) & date <= as.Date(input$HospDataDateRange[2])) %>%
      arrange(date) |> 
      group_by(date) |> 
      summarise(total_staffed_adult_icu_beds_avg = mean(total_staffed_adult_icu_beds),
                staffed_adult_icu_bed_occupancy_avg = mean(staffed_adult_icu_bed_occupancy),
                staffed_icu_adult_patients_confirmed_and_suspected_covid_avg = mean(staffed_icu_adult_patients_confirmed_and_suspected_covid )) 
    
    # Plot time series trends with labels
    ggplot(df_filtered2, aes(x = date)) +
      geom_line(aes(y = total_staffed_adult_icu_beds_avg, color = "Total ICU Beds"), size = 1) +
      geom_line(aes(y = staffed_adult_icu_bed_occupancy_avg, color = "ICU Beds Used"), size = 1) +
      geom_line(aes(y = staffed_icu_adult_patients_confirmed_and_suspected_covid_avg, color = "ICU Inpatients with COVID"), size = 1) +
      
      # # Add text labels every 30 days to reduce clutter
      geom_text(data = df_filtered2 %>% filter(day(date) %% 30 == 0),
                aes(y = total_staffed_adult_icu_beds_avg, label = round(total_staffed_adult_icu_beds_avg)),
                color = "black", vjust = -1, size = 3) +
      
      geom_text(data = df_filtered2 %>% filter(day(date) %% 30 == 0),
                aes(y = staffed_adult_icu_bed_occupancy_avg, label = round(staffed_adult_icu_bed_occupancy_avg)),
                color = "black", vjust = -1, size = 3) +
      
      geom_text(data = df_filtered2 %>% filter(day(date) %% 30 == 0),
                aes(y = staffed_icu_adult_patients_confirmed_and_suspected_covid_avg, label = round(staffed_icu_adult_patients_confirmed_and_suspected_covid_avg)),
                color = "black", vjust = -1, size = 3) +
      
      labs(
        title = title2,
        x = "Date",
        y = "Counts",
        color = "Legend"
      ) 
    
  })
  
  output$Pediatric_ICU_Bed_time_series_plot <- renderPlot({
    
    title3 <- glue("Pediatric ICU Bed Utilization")
    if (input$HospDataSelectState != "All"){
      title3 <- paste0(title3, glue(" for {input$HospDataSelectState} State"))
    }
    
    df_filtered3 <- covid_data() %>%
      filter(date >= as.Date(input$HospDataDateRange[1]) & date <= as.Date(input$HospDataDateRange[2])) %>%
      arrange(date) |> 
      group_by(date) |> 
      summarise(total_staffed_pediatric_icu_beds_avg = mean(total_staffed_pediatric_icu_beds),
                staffed_pediatric_icu_bed_occupancy_avg = mean(staffed_pediatric_icu_bed_occupancy),
                staffed_icu_pediatric_patients_confirmed_covid_avg = mean(staffed_icu_pediatric_patients_confirmed_covid )) 
    
    # Plot time series trends with labels
    ggplot(df_filtered3, aes(x = date)) +
      geom_line(aes(y = total_staffed_pediatric_icu_beds_avg, color = "Total ICU Beds"), size = 1) +
      geom_line(aes(y = staffed_pediatric_icu_bed_occupancy_avg, color = "ICU Beds Used"), size = 1) +
      geom_line(aes(y = staffed_icu_pediatric_patients_confirmed_covid_avg, color = "ICU Inpatients with COVID"), size = 1) +
      
      # # Add text labels every 30 days to reduce clutter
      geom_text(data = df_filtered3 %>% filter(day(date) %% 30 == 0),
                aes(y = total_staffed_pediatric_icu_beds_avg, label = round(total_staffed_pediatric_icu_beds_avg)),
                color = "black", vjust = -1, size = 3) +
      
      geom_text(data = df_filtered3 %>% filter(day(date) %% 30 == 0),
                aes(y = staffed_pediatric_icu_bed_occupancy_avg, label = round(staffed_pediatric_icu_bed_occupancy_avg)),
                color = "black", vjust = -1, size = 3) +
      
      geom_text(data = df_filtered3 %>% filter(day(date) %% 30 == 0),
                aes(y = staffed_icu_pediatric_patients_confirmed_covid_avg, label = round(staffed_icu_pediatric_patients_confirmed_covid_avg)),
                color = "black", vjust = -1, size = 3) +
      
      labs(
        title = title3,
        x = "Date",
        y = "Counts",
        color = "Legend"
      ) 
    
  })
  
  # Render DataTable
  output$covidTable <- renderDT({
    datatable(
      covid_data(),
      options = list(pageLength = 10),
      rownames = FALSE
    )
  })
  
}
