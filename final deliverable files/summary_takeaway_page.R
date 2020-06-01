
takeaways <- list()

#use tags$p in ui file to write it in the form of a paragraph
takeaways$summary_table <- "From the table, we can clearly observe that zip codes in the beggining 
(low SAT scores)of the list are the areas with low average 
household income whereas zip codes towards the end of the list(high SAT  
scores) are the areas with high average household incomes and higher sat
scores."

#use tags$p in ui file to write it in the form of a paragraph
takeaways$first_visualisation <- "From the map visualization, we can see there seems to be a higher percentage
of students passing the performance benchmark near San Francisco and Sacramento
than other places. Students near Fresno seem to have significantly lower performance 
than others."

#use tags$p in ui file to write it in the form of a paragraph
takeaways$second_visualisation <- "From this scatterplot, we observe a linear relationship between SAT scores and income.
We can easily follow the trendline to see a trend up in SAT scores as median zip code income increases. The correlation 
between the two is `r corr_sat_income`. Based on the trendline, there seemed to be several high schools that outperformed
their expected SAT score based on their zip code median income, as well as some underperforming richer high schools. 
To the top right of the graph, schools that are well above the trendline shows the schools despite having access to more
resources, performed about as well with other schools with less resources."

#use tags$p in ui file to write it in the form of a paragraph
takeaways$third_visualisation <- "From the bar chart, we observe an upward trend as SAT score and median income 
increase. Towards the 1500 range in SAT score, not only do we see a concentration of data but the color key reflects
that many of the zip codes are 955xx which is Humboldt county. Towards the upper boundary of highest SAT scores
we see more 945xx zip codes which is Alameda county in the Bay area. This further confirms what we see from our
map visualization."

#use tags$p in ui file to write it in the form of a paragraph
takeaways$conclusion <- "Still to decide the conclusion"

