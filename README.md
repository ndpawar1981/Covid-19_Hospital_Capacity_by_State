# Covid-19_Hospital_Capacity_by_State 
>Data Provided By U.S. Department of Health & Human Services

## Executive Summary:
December 2019, people in Wuhan, China, began to show symptoms of a strange new
disease. It was the beginning of a novel, highly contagious infectious virus: severe acute
respiratory syndrome coronavirus 2. The entire world was then put through a vigorous
new era of confusion, doubt, and uncertainty. The public health sector was hit hard, and
hospitals around the world struggled to adapt to the changes brought about by the new
virus, leading to many hospitals having issues with their hospital capacities (e.g.,
shortage in hospital beds and staff such as physicians and nurses). Prior to the
coronavirus disease 2019 (COVID-19) pandemic, hospitals in the United States (US)
already had limited capacities due to the shortage of physicians and nurses nationwide.
Throughout the COVID-19 pandemic, hospital capacities in the United States have been
thin and seen constant hospitalization variations mostly associated with peaks of
infection from different COVID-19 variants.
The data came from the Department of Health and Human Services (HHS), which is
available [Here](https://healthdata.gov/Hospital/COVID-19-Reported-Patient-Impact-and-Hospital-Capa/g62h-syeh/about_data/). This dataset was made available for
public access for free from collaborative efforts of hospital, state, and federal personnel
in the US.
These data were derived from reports with facility-level granularity across three main
sources: (1) HHS TeleTracking, (2) reporting provided directly to HHS Protect by
state/territorial health departments on behalf of their healthcare facilities, and (3)
National Healthcare Safety Network (before 15 July 2020). The data were updated
regularly and provided the latest values reported by each facility within the last four
days at each update. This reporting method provides a comprehensive picture of
hospital utilization within a state in the US by ensuring all hospitals were represented,
even if they missed a single day of reporting.

## Motivation:
The topic itself is very sensitive as it is one in century pandemic outbreak for entire
world. Any data associated to this topic always raises questions or concerns and people
tend to deep dive more in that. The data used in the project is authentic as it is provided
by federal government agencies. Any conclusion or trend derived from this analysis can
be hold true. The dataset is rich ranging from year 2020 till 2024 with more than 100
different columns. It is time series data reported every day for given years. There is
sufficient volume of data to run analysis through it.

## Data Questions:
At high level, exploratory data analysis will be done. Few details outlined below.
- Number of inpatients with COVID -19
- Inpatient bed utilization
- ICU bed utilization
- ICU beds for COVID utilization
- Number of COVID deaths
- Identify which states had major strain during COVID-19?
- Identify any regional pattern for staffing shortages or bed utilization.
- Identify states having most pediatric ICU bed utilization.
- Identify/observe any shift in the data due to any government policy changes.
- Identify change in ICU bed utilization over given pandemic time at national level
as well as state level.
- Is there any correlation of critical staff shortage on number of COVID deaths in
given time? Identify Number of hospitals reporting critical staff shortages.
- Is there any correlation of onset COVID with number of ICU bed occupancy?

## Minimum Viable Product (MVP) :
Shiny app showcasing interesting findings about the data, with filtering based on the covid year, State and Adult/Child bed utlilization.

## Data Sources:
- Data is
available [Here](https://healthdata.gov/Hospital/COVID-19-Reported-Patient-Impact-and-Hospital-Capa/g62h-syeh/about_data/).
- Data Provided by U.S. Department of Health &amp; Human Services
- Data Last Updated on June 28, 2024 2:57 PM CDT
- Total records – 81.7K, Total Columns – 135
- Each Row represents Daily State Aggregated Report

## Known Issues and Challenges:
There are missing data (NA) in few columns. The average data that
represents NA per column is 8 to 10 %. Given the large dataset, it will be excluded from the
exploration.
