overview_purpose = "These days, more universities decided to waive SAT
          requirements in their undergraduate admission process. As UW students, 
          most of us have experience taking the SAT or the ACT at some point in our
          lives, thus choosing this topic. It is interesting to see this transition 
          happening and it would be awesome if we can find a way to explain such transitions
          with data collected across different demographic/socioeconomic groups."
irs_url = "https://www.irs.gov/statistics/soi-tax-stats-i
ndividual-income-tax-statistics-2017-zip-code-data-soi"

r1_link = "https://www.racecounts.org/"
r2_link = "http://californiadatacollaborative.org/"
r3_link = "https://www.lacountyartsedcollective.org/models-reso
urces/resources/california-arts-education-data-project"
overview_gen = function(content) {
  if (content == "purpose"){
    return(
      div(
        h1("Purpose of our project"),
        p(overview_purpose)
        )
    )
  } else if (content == "data") {
    return(
      div(
        h1("Source of data"),
        p("The Data is from the ",
          a(
            "California Department of Education",
            href="https://www.cde.ca.gov/ds/sp/ai/"
            ),
          " as well as the ",
          a("IRS website",
            href=irs_url),".")
      )
    )
  } else if (content == "research") {
    return(
      div(
        h1("Other Relavent Research"),
        tags$ol(
          tags$li(
            p(a(
              "Race Counts",
              href=r1_link
            ),
            ": Race Counts measures the overall performance, amount of racial disparity,
            and impact by population size of counties and cities in California."
            )
          ),
          tags$li(
            p(a(
              "California Arts Education Data Project",
              href=r3_link
            ),
            ": The Data Project is designed to increase participation in arts education 
            across the state by analyzing and reporting school-level data on arts educa
            tion courses and grades 6 through 12 enrollment."
            )
          ),
          tags$li(
            p(a(
              "California Data Collaborative",
              href=r2_link
            ),
            ": Their analytics help water managers plan for and achieve their new water e
            fficiency goals. CaDC tools make use of agency and external data to assist sta
            ff with tasks like understanding water efficiency in their service area, analy
            zing the water savings of water efficiency rebates, and forecasting the impact
            of water rate changes."
            )
          )
        )
      )
    )
    
  }
}