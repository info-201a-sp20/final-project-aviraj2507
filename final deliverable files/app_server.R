# server.R
library(dplyr)
library(plotly)
library(leaflet)

source("Interactive_page_1.R")
source("interactive_page_3.R")
source("interactive_page_2.R")
source("summary_table_page.R")

cali_hs_sat_zip_df <- read.csv("../data/cali_hs_sat_zip.csv",
                               stringsAsFactors
                               = FALSE
)

cali_hs_sat_zip_df <- na.omit(cali_hs_sat_zip_df)
server <- function(input, output) {
  #Income Bar for Interactive Page 3 -- EJ
  output$income_bar <- renderPlotly(
    return(binned_income_interactive(cali_hs_sat_zip_df,
                                     input$income_bin_var,
                                     yvar = y_var_bar))
  )
  # SAT Score scatter for Interactive page 2 -- Brandon
  output$scatter <- renderPlotly({
    return(plot_scatter(cali_hs_sat_zip_df, input$search))
  })
  
  #Summary Table for summary_table page
  output$summary_table <- DT::renderDataTable({ 
    return(sum_tb(cali_hs_sat_zip_df))
  })
  
  output$map_vis <- renderLeaflet({
    return(map_gen(
      input$map_vis_type, input$map_vis_year
    ))
  })
}
