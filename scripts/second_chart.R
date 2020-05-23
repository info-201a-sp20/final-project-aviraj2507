library(dplyr)
library(ggplot2)
library(plotly)

rm(list = ls())

cali_hs_sat_zip_df <- read.csv("../data/cali_hs_sat_zip.csv",
                               stringsAsFactors
                               = FALSE
)
data <- cali_hs_sat_zip_df <- na.omit(cali_hs_sat_zip_df)

chart_2 <- function(data){
  ca_vis <- cali_hs_sat_zip_df %>%               
  ggplot(data = ca_vis) +
  geom_col(mapping = aes(x = TotalSatScore, y = MedianHouseholdIncome, 
                         fill = Zip),position = "dodge")  +
  ggtitle("SAT Score vs ZIP Code Income by HS") +
  xlab("HS Average SAT Score") +
  ylab("Zip Code Median Income")
p <-ggplotly(plot_ca)
return(p)
}

chart_2(cali_hs_sat_zip_df)
