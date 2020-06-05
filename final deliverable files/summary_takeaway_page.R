

takeaway_gen = function(content) {
  if (content == "summary_table"){
    return(
      div(
        h1("Takeaways from Summary Table:"),
        tags$ul(
          tags$li(
            p(
            "From the summary table, we can clearly observe that zip codes in the beggining 
            (low SAT scores)of the list are the areas with low average 
            household income."
            )
          ),
          tags$li(
            p(
            "The zip codes towards the end of the list(high SAT  
             scores) are the areas with high average household incomes and higher SAT
             scores."
            )
          )
        ),
        img(src = "https://vpandey26.files.wordpress.com/2019/03/n-college-acceptance-628x314.jpg?w=640")
      )
    )
  } else if (content == "first_visualisation") {
    return(
      div(
        h1("Takeaways from the Map:"),
        tags$ul(
          tags$li(
            p(
              "From the map visualization, we can see there seems to be a higher percentage
               of students passing the performance benchmark near San Francisco and Sacramento
               than other places."
            )
          ),
          tags$li(
            p(
              "Also, students near Fresno seem to have significantly lower performance 
               than others."
            )
          )
        )
      )
    )
  } else if (content == "second_visualisation") {
    return(
      div(
        h1("Takeaways from the Scatterplot"),
        tags$ul(
          tags$li(
            p(
              "From this scatterplot, we observe a positive linear relationship between SAT scores and 
              median income. Based on the trendline, there seemed to be several high schools that outperformed
              their expected SAT score based on their zip code median income, as well as some underperforming richer high schools."
            )
          ),
          tags$li(
            p(
              "For example in the Los Angelos area zip code (900) the school with the highest median income (86.573k) 
              only had a score 1221 while the school with the lowest (21.009k) had a score of 1129. Another interesting trend is 
              that some schools despite having the same median income had a wide range in SAT scores."
            )
          ),
          tags$li(
            p(
              "In the San Francisco area zip code (941) schools with a median income of around 121k had a range
              of scores 1725 to 1089."
            )
        ),
        img(src = "https://i.ibb.co/sg7pysb/collage.png")
        )
      )
    )
    
  } else if (content == "third_visualisation") {
    return(
      div(
        h1("Takeaways from the Bar Chart"),
        tags$ul(
          tags$li(
            p(
              "From the bar chart, we a see a linear trend between income bin and 
              Total SAT score that transcends all sections of the test."
            )
          ),
          tags$li(
            p(
              "While only a small difference, zip codes in lower income bins (ie of lower socio-economic status)
              tend to perform worse on math parts of the exam. As we change between the tests, the higher income
              bins stay relatively the same across all tests, but the lower bins perform worse on math."
            )
          )
        ),
          img(src = "https://i.ibb.co/sg7pysb/collage.png")
      )
    )
  }
}

