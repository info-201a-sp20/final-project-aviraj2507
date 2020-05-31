#Creating third page for shiny app

library(dplyr)
library(ggplot2)
library(plotly)

cali_hs_sat_zip_df <- read.csv("../data/cali_hs_sat_zip.csv",
                               stringsAsFactors
                               = FALSE
)

#Making Scatter Plot
build_third_plot <- function(dataframe, input){
  chart <- ggplot(
    dataframe,
    aes(x = input, y = MedianHouseholdIncome)
  ) +
    geom_point(size = 1, color = "darkblue") +
    geom_smooth(method = lm) +
    ggtitle("SAT Score vs ZIP Code Income by HS") +
    xlab(input) +
    ylab("Zip Code Median Income")
  return(ggplotly(chart))
}

x_axis <- "AvgScrMath"

build_third_plot(cali_hs_sat_zip_df, x_axis)

#Making Binned Bar Graph

binned_income_interactive <- function(dataframe, bin, yvar = "AvgTotalSATScore") {
  df <- dataframe %>%
    filter(MedianHouseholdIncome != is.na(MedianHouseholdIncome)) %>%
    mutate(income_bin_primary =
             if(min(floor(MedianHouseholdIncome / bin)) == 0){
               (floor(MedianHouseholdIncome / bin) + 1)
             } else {
               (floor(MedianHouseholdIncome / bin))
             }) %>%
    mutate(income_bin =
             ifelse(income_bin_primary > 10,
                    10,
                    income_bin_primary)
    ) %>%
    group_by(income_bin) %>%
    summarize(AvgTotalSATScore = mean(TotalSatScore),
              AvgRead = mean(AvgScrRead),
              AvgMath = mean(AvgScrMath),
              AvgWrite = mean(AvgScrWrite))
  
  if(yvar == "AvgTotalSATScore"){
    y_lim <- 2400
    title <- "SAT Score: Total by Income Bin"
    y_title <- "Total SAT Score"
  } else {
    y_lim <- 800
    title <- paste("SAT Score:",
                   substr(yvar,4,nchar(yvar)),
                   "by Income Bin")
    y_title <- paste(substr(yvar,4,nchar(yvar)),
                     "SAT Score")
  }
  
  plot <- plot_ly(df,
    x = df$income_bin,
    y = df[[yvar]],
    type = "bar") %>% 
    layout(title = title,
           xaxis = list(title = "Income Bin",
                        zeroline = FALSE),
           yaxis = list(title = y_title,
                        zeroline = FALSE,
                        range = c(0, y_lim)))
  
  return(plot)
}

binned_income_interactive(cali_hs_sat_zip_df, 40000, yvar = "AvgMath")