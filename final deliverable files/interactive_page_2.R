# Creating second page for shiny app

library(plotly)
library(stringr)

#Scatter Plot

plot_scatter <- function(data,  search = "", xvar = "TotalSatScore", yvar = "MedianHouseholdIncome") {
  xmax <- max(data[,xvar]) * 1.5
  ymax <- max(data[,yvar]) * 1.5
  
  data <- data %>% 
    filter(grepl(search, Zip))
  
  p <- plot_ly(x = data[, xvar],
               y = data[, yvar], 
               mode="markers", 
               marker = list(
                 opacity = .4, 
                 size = 10
               )) %>% 
    layout(xaxis = list(range = c(0, xmax), title = xvar), 
           yaxis = list(range = c(0, ymax), title = yvar)
    )
  return(p)
}

scatter_sidebar_content <- sidebarPanel(
  textInput("search", label = "Find a Zip code", value = "")
)


scatter_main_content <- mainPanel(
  plotlyOutput("scatter")
)

page_four <- tabPanel(
  "Scatter Plot",
  
  titlePanel("Total SAT Score v.s. Median Household Income"),
  
  sidebarLayout(
     scatter_sidebar_content,
    scatter_main_content
  )
)

    
  

