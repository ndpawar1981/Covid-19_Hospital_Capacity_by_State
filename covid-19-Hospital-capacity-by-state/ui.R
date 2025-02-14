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
    title = "Home",
    icon = icon('home'),
    fluidPage(
      h4("Covid-19 Patients Impact and Hospital Capacity By State "),
      span('A midcourse Data Science project by', strong('Nitin Pawar'), style='font-size:20px'),
      br(),
      fluidRow(
        column(12, 
               div(
                 style = "text-align: center; padding: 20px;",
                 h2("📊 Understanding the Impact of COVID-19 on Hospital Capacity"),
                 p("This dashboard provides insights into hospital capacity, ICU utilization, 
          and patient admissions across the United States. Explore trends, compare data, 
          and analyze key healthcare indicators in response to COVID-19."),
                 tags$hr(style="border-top: 3px solid #2c3e50;")
               )
        )
      ),
      fluidRow(
        column(4, wellPanel(
          h4("🏥 Hospital Bed Utilization"),
          p("Track inpatient and ICU bed occupancy trends over time.")
        )),
        column(4, wellPanel(
          h4("🌍 Geographic Insights"),
          p("Use interactive maps to visualize hospital capacity and covid-19 impact across the U.S.")
        )),
        column(4, wellPanel(
          h4("🔍 Statistical Insights"),
          p("Analyze correlations and trends affecting hospital capacity and staff by covid-19.")
        ))
      ),
      tags$hr(style="border-top: 3px solid #2c3e50;"),
      fluidRow(
        # column(12, 
        #        div(
        #          style = "text-align: left; padding: 15px; background-color: #F8F9FA; border-radius: 10px;",
        #          h3("📌 How to Use This Dashboard?"),
        #          tags$ul(
        #            tags$li("📍 Select a Date Range – Use the interactive slider to analyze different time periods."),
        #            tags$li("🌎 Explore Geographic Trends – View utilization rates across different states."),
        #            tags$li("📊 Compare Key Metrics – Utilize line charts and scatter plots."),
        #            tags$li("🔍 Filter & Customize Data – Drill down into specific hospital data.")
        #          )
        #        )
        # )
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
                         plotOutput("Pediatric_ICU_Bed_time_series_plot"),
                         br(),
                         h4("Pediatric Data Ananmoly"),
                         tags$ul(
                           tags$li("The Pediatric data is inconsistent hence spikes/gaps for certain date ranges.")
                         )
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
                           min = quarters_seq[1], max = quarters_seq[length(quarters_seq)], value = quarters_seq[1], step = 15,
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
