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
  
  total_avg_Inpatient_beds <- reactive({
    covid_data() |> 
      summarise(total_avg_Inpatient_beds = mean(inpatient_beds,na.rm = TRUE))
      
  })
  
  total_avg_Inpatient_covid_beds <- reactive({
    covid_data() |> 
      summarise(total_avg_Inpatient_covid_beds = mean(inpatient_beds_used_covid,na.rm = TRUE))
    
  })
  
  # Output for value boxes
  output$totalInpatientsBeds <- renderValueBox({
    valueBox(
      value = format(total_avg_Inpatient_beds(), big.mark = ","),
      subtitle = "Avg Total Inpatients Beds",
      icon = icon("bed"),
      width = 3,
      color = 'blue'
    )
  })
  
  # Output for value boxes
  output$totalInpatientsCovidBeds <- renderValueBox({
    valueBox(
      value = format(total_avg_Inpatient_covid_beds(), big.mark = ","),
      subtitle = "Avg Total Inpatient Covid Beds",
      icon = icon("bed"),
      width = 3,
      color = 'red'
    )
  })
  
  
}
