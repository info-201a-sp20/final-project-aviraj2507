library(dplyr)
library(ggplot2)
library(plotly)
library(shiny)
library(DT)

rm(list = ls())

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

sum_tb <- DT::datatable(summary_table)
sum_tb

sum_table <- "descrition of the summary table"