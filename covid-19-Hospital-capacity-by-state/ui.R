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
  tags$head(
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
          box(
            width=12,
            title='Trends Over Time',
            status='primary',
            p('Summary of Hospital Beds and Covid over time.'),
            tabsetPanel(
              tabPanel("Inpatient",
                       fluidPage(
                         fluidRow(
                           column(3,infoBoxOutput("avgInpatientsBeds")),
                           column(3,infoBoxOutput("avgInpatientUsedBeds")),
                           column(3,infoBoxOutput("avgInpatientsCovidBeds"))
                         )
                       )
              ),
              tabPanel("Staffed Adult ICU",
                       fluidPage(
                         fluidRow(
                           column(3,infoBoxOutput("avgStaffedAdultICUBeds")),
                           column(3,infoBoxOutput("avgStaffedAdultICUBedsOccupied")),
                           column(3,infoBoxOutput("AvgStaffedICUAdultsCovid"))
                         )
                       )
              ),
              tabPanel("Staffed Pediatric ICU",
                       fluidPage(
                         fluidRow(
                           column(3,infoBoxOutput("AvgStaffedPiatricICUBeds")),
                           column(3,infoBoxOutput("AvgPiatricICUBedsUsed")),
                           column(3,infoBoxOutput("AvgICUPediatricCovid"))
                         )
                       )
              ),
              tabPanel("Covid",
                       fluidPage(
                         fluidRow(
                           column(3,infoBoxOutput("AvgAdultHospitalizedCovid")),
                           column(3,infoBoxOutput("AvgPediatricHospitalizedCovid")),
                           column(3,infoBoxOutput("AvgCovidDeaths"))
                         )
                       )
              )
            )
          ),
          width=9
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

