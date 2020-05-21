library(dplyr)

rm(list = ls())

cali_hs_sat_zip_df <- read.csv("../data/cali_hs_sat_zip.csv",
  stringsAsFactors
  = FALSE
)

cali_hs_sat_zip_df <- na.omit(cali_hs_sat_zip_df)

summary_table <- cali_hs_sat_zip_df %>%
  select(Zip, MedianHouseholdIncome, TotalSatScore) %>%
  group_by(Zip) %>%
  summarise(
    MedianHouseholdIncome = mean(MedianHouseholdIncome), TotalSatScore
    = mean(TotalSatScore)
  ) %>%
  arrange(Zip)

