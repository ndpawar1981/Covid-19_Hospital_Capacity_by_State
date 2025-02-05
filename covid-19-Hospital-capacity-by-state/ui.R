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
  # Include the custom CSS file
  header = tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
  ),
  
  title = "COVID-19 Hospital Data",
  theme = shinythemes::shinytheme("flatly"),
  tabPanel(
    title = "Overview",
    icon = icon('database'),
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
    title = "Bed Utilization Trends",
    icon = icon('hospital'),
    fluidPage(
      #useShinydashboard(),
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
          title="Trends Over Time",
          p('Summary of Hospital Beds and Covid over time.'),
          tabsetPanel(
            tabPanel("Inpatient",
                     fluidPage(
                       fluidRow(
                         column(4,valueBoxOutput("avgInpatientsBeds")),
                         column(4,valueBoxOutput("avgInpatientUsedBeds")),
                         column(4,valueBoxOutput("avgInpatientsCovidBeds"))
                       ),
                       br(),
                       fluidRow(
                         plotOutput("inpatient_time_series_plot")
                       )
                     )
            ),
            tabPanel("Staffed Adult ICU",
                     fluidPage(
                       fluidRow(
                         column(3,infoBoxOutput("avgStaffedAdultICUBeds")),
                         column(3,infoBoxOutput("avgStaffedAdultICUBedsOccupied")),
                         column(3,infoBoxOutput("AvgStaffedICUAdultsCovid"))
                       ),
                       br(),
                       fluidRow(
                         plotOutput("Adult_ICU_Bed_time_series_plot")
                       )
                     )
            ),
            tabPanel("Staffed Pediatric ICU",
                     fluidPage(
                       fluidRow(
                         column(3,infoBoxOutput("AvgStaffedPiatricICUBeds")),
                         column(3,infoBoxOutput("AvgPiatricICUBedsUsed")),
                         column(3,infoBoxOutput("AvgICUPediatricCovid"))
                       ),
                       br(),
                       fluidRow(
                         plotOutput("Pediatric_ICU_Bed_time_series_plot")
                       )
                     )
            ),
            tabPanel("Data",
                     fluidPage(
                       fluidRow(
                         DTOutput("covidTable") 
                       )
                    )
            )
          )
        )
      )
    )
  ),
  tabPanel(
    title = "Geo Visuals",
    icon = icon('map'),
    fluidPage(
      
    )
  )
)
