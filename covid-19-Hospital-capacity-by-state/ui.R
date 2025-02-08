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
                      choices = c("All", covid_filtered |> distinct(Name) |> pull(Name) |> sort())),
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
      fluidRow(
        column(4),  # Empty space on left
        column(4, 
               sliderInput("quarter_date", "Select Quarterly Date:",
                           min = quarters_seq[1], max = quarters_seq[length(quarters_seq)], value = quarters_seq[1], step = 20,
                           ticks = TRUE, animate = TRUE, width = "100%")
        ),
        column(4)
      ),
      fluidRow(
        column(6, plotlyOutput('mapplot')),
        column(6, plotlyOutput('covidplot'))
      ),
      fluidRow(
        column(6,DTOutput("top_Inpatient_states_table")),
        column(6,DTOutput("top_covid_Death_states_table"))
      )
      
    )
  ),
  tabPanel(
    title = "Model",
    icon = icon('calculator'),
    fluidPage(
      fluidRow(
        column(3),  # Empty space on left
        column(6, 
               h4("Relationship between Onset Covid-19 and Inpatient Covid beds utilization "),
               br(),
               verbatimTextOutput("correlation_value_onset")
        ),
        column(3)
      ),
      fluidRow(
        column(6,plotlyOutput("correlation_plot_onset")),
        column(6,verbatimTextOutput("model_output_onset")),
        br()
      ),
      
      tags$hr(style="border-top: 3px #2c3e50;"),
      
      fluidRow(
        column(3),  
        column(6, 
               h4("Relationship between Covid-19 and number of hospitals Critical Staff shortage "),
               br(),
               verbatimTextOutput("correlation_value_staff")
        ),
        column(3)
      ),
      fluidRow(
        column(6,plotlyOutput("correlation_plot_staff")),
        column(6,verbatimTextOutput("model_output_staff")),
        br()
      )
      
    )
  )
)
  