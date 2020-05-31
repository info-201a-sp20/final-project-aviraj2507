# server.R
library(dplyr)
source("interactive_page_3.R")


server <- function(input, output) {
  #Income Bar for Interactive Page 3 -- EJ
  output$income_bar <- renderPlotly(
    return(binned_income_interactive(cali_hs_sat_zip_df,
                                     input$income_bin_var,
                                     yvar = y_var_bar))
  )
}