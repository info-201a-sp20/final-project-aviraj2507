library(dplyr)
library(ggplot2)
library(plotly)
library(shiny)
library(DT)


cali_hs_sat_zip_df <- read.csv("../data/cali_hs_sat_zip.csv",
                               stringsAsFactors
                               = FALSE
)

# omits the NA values
cali_hs_sat_zip_df <- na.omit(cali_hs_sat_zip_df)

# the summary table
summary_table <- cali_hs_sat_zip_df %>%
  select(Zip, MedianHouseholdIncome, TotalSatScore) %>%
  group_by(Zip) %>%
  summarise(
    household_income = mean(MedianHouseholdIncome), overall_sat_score
    = mean(TotalSatScore)
  ) %>%
  arrange(overall_sat_score)

# how to make datatable in shiny
#output$foo <- DT::renderDataTable({ data })

sum_tb <- function(data) {
  return(datatable(summary_table))
}

summ_table <- list()
summ_table$sum_table <- "The summary table portrays how total SAT score and mean household income
are different for different areas(Zip code) in California."

