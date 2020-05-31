# server.R
library(dplyr)
source("interactive_page_3.R")
source("interactive_page_2.R")

cali_hs_sat_zip_df <- read.csv("../data/cali_hs_sat_zip.csv",
                               stringsAsFactors
                               = FALSE
)

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
}