#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#


# Define UI for application that draws a histogram


navbarPage(
  title = "COVID-19 Hospital Data",
  theme = shinythemes::shinytheme("flatly"), 
  tabPanel(
    title = "Overview",
    fluidPage(
      h4("Covid-19 Patients Impact and Hospital Capacity By State "),
      p("This dashboard provides insights into hospital capacities during COVID-19."),
      fluidRow(
        
      ),
      fluidRow(
        
      )
    )
  ),
  tabPanel(
    title = "Hospital Bed Utilization Trends",
    fluidPage(
      titlePanel("Hospital Data"),
      sidebarLayout(
        sidebarPanel(
          selectInput("HospDataSelectState", label = "Select State:",
                      choices = c("All", covid_filtered |> distinct(state) |> pull(state) |> sort())),
          #selectInput("HospDataType", label = "Select Hospital Bed:",
          #           choices = c("All", "Inpatient Bed", "Adult ICU Bed","Pediatric ICU Bed")),
          dateRangeInput(
            "HospDataDateRange",
            "Select Date Range:",
            start = min(covid_filtered$date),
            end = max(covid_filtered$date)
          ),
          width = 3
        ),
        mainPanel(
          valueBoxOutput("totalInpatientsBeds"),
          valueBoxOutput("totalInpatientsCovidBeds")
          #valueBoxOutput("totalICUBeds"),
          #valueBoxOutput("totalICUBeds"),
          #valueBoxOutput("totalICUBeds"),
          #valueBoxOutput("totalICUBeds")
        ) 
      )
    )
  ),
  tabPanel(
    title = "TBD",
    fluidPage(
      
    )
  )
)

