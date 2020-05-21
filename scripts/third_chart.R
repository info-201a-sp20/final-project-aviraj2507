library(dplyr)

library(ggplot2)

rm(list = ls())

cali_hs_sat_zip_df <- read.csv("../data/cali_hs_sat_zip.csv", stringsAsFactors = FALSE)
cali_hs_sat_zip_df <- na.omit(cali_hs_sat_zip_df)

scatter_sat_zip_HS<- ggplot(cali_hs_sat_zip_df,
                            aes(x = TotalSatScore, y = MedianHouseholdIncome)) +
  geom_point(size = 1, color = "darkblue") +
  geom_smooth(method=lm) +
  ggtitle("SAT Score vs ZIP Code Income by HS") +
  xlab("HS Average SAT Score") +
  ylab("Zip Code Median Income")

scatter_sat_zip_HS

