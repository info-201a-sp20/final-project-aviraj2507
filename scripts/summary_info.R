library(dplyr)

rm(list = ls())

cali_hs_sat_zip_df <- read.csv("../data/cali_hs_sat_zip.csv",
  stringsAsFactors
  = FALSE
)
cali_hs_sat_zip_df <- na.omit(cali_hs_sat_zip_df)

options(scipen = 999)

summarise <- function(dataset) {
  output <- list()
  mean_income <- mean(dataset[[7]], na.rm = TRUE)
  median_income <- median(dataset[[7]], na.rm = TRUE)
  output$mean_household_income <- mean_income
  output$median_household_income <- median_income
  output$avg_score_below_mean_inc <- mean(dataset[dataset[[7]] <
    mean_income, 6],
  na.rm = TRUE
  )
  output$avg_score_above_mean_inc <- mean(dataset[dataset[[7]]
  >= mean_income, 6],
  na.rm = TRUE
  )
  output$zip_with_max_income <- dataset[dataset[[7]]
  == max(dataset[[7]]), 5]
  return(output)
}

summary_information <- summarise(cali_hs_sat_zip_df)
mean_household_income <- round(summary_information$mean_household_income,0)
avg_score_above_mean_inc <- round(summary_information$avg_score_above_mean_inc,
                                  1)
