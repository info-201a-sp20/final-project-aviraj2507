library(dplyr)

rm(list = ls())

cali_hs_sat_zip_df <- read.csv("../data/cali_hs_sat_zip.csv", stringsAsFactors = FALSE)

summarise <- function(dataset) {
  output <- list()
  mean_income <- mean(dataset[[7]], na.rm = TRUE)
  median_income <- median(dataset[[7]], na.rm = TRUE)
  output$mean_household_income <- mean_income
  output$median_household_income <- median_income
  output$avg_score_for_income_below_mean <- mean(dataset[dataset[[7]] < mean_income, 6], na.rm = TRUE)
  output$avg_score_for_income_atleast_mean <- mean(dataset[dataset[[7]] >= mean_income, 6], na.rm = TRUE)
  output$avg_score_for_income_below_median <- mean(dataset[dataset[[7]] < median_income, 6], na.rm = TRUE)
  output$avg_score_for_mincome_atleast_median <- mean(dataset[dataset[[7]] >= median_income, 6], na.rm = TRUE)
  
  return(output)
}

summary_info <- summarise(cali_hs_sat_zip_df)
