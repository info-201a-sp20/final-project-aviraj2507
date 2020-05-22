library(dplyr)
library(ggplot2)
library(plotly)

rm(list = ls())

cali_hs_sat_zip_df <- read.csv("../data/cali_hs_sat_zip.csv",
                               stringsAsFactors
                               = FALSE
)
cali_hs_sat_zip_df <- na.omit(cali_hs_sat_zip_df)

plot_ca <- ggplot(data = cali_hs_sat_zip_df) +
  geom_col(mapping = aes(x = TotalSatScore, y = MedianHouseholdIncome, 
                         fill = Zip),position = "dodge")  +
  ggtitle("SAT Score vs ZIP Code Income by HS") +
  xlab("HS Average SAT Score") +
  ylab("Zip Code Median Income")

ggplotly(plot_ca)

