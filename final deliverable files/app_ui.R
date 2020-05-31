library(dplyr)
library(ggplot2)
library(plotly)
library(shiny)
library(DT)


source("intro_page.R")
source("summary_takeaway_page.R")
source("interactive_page_3.R")
source("interactive_page_2.R")
source("summary_table_page.R")

page_one_sidepanel <- sidebarPanel(
  "Contents",
  selectInput(
    "Choose from the following options:",
    choices = list("Purpose of the project" = "purpose",
                   "About the project" = "about",
                   "Research" = "research")
  )
)
page_one_mainpanel <- mainPanel(
  "Overview of the Project",
  tags$p(textInput(
    inputId = "overview"
  )),
  tags$img(src = "https://www.fccnn.com/incoming/4676816-7wuexj-SAT/alternates/BASE_LANDSCAPE/SAT"),
  tags$img(src = "https://sierranewsonline.com/wp-content/uploads/2018/01/California-Department-of-Education-e1516666248141.png")
)

page_one <- tabPanel(
  h1("Project Overview"),
  page_one_sidepanel,
  page_one_mainpanel
)

page_two <- fluidPage(
  h1("Summary Table"),
  tags$p(textInput(
    inputId = "sum_table"
  )),
  tableOutput(
    outputId = "summary_table"
  )
)

page_three <- tabPanel(
  third_page_sidebar,
  third_page_main
)

page_six_sidepanel <- sidebarPanel(
  selectInput(
    h2("Contents:"),
    choices = list("Summary Table" = "summary_table",
                   "Map" = "first_visualisation",
                   "Column Chart" = "second_visualisation",
                   "Scatter Plot" = "third_visualisation",
                   "Conclusion" = "conclusion")
  )
)

page_six_mainpanel <- mainPanel(
  tags$p(textInput(
    inputId = "takeaway"
  ))
)

page_six <- tabPanel(
  h1("Project Takeaways"),
  page_five_sidepanel,
  page_five_mainpanel
)
ui <- navbarPage(
  "Standardised Testing and Median Household Income in California",
  page_one,
  page_two,
  page_three,
  page_four,
  page_five,
  page_six
)
