
# This file contains a function for chart one.

library("dplyr")
library("tidyr")
library("ggplot2")
library("leaflet")
library("lintr")


# This function cleans up the raw data and returns a map.
map_gen <- function(pop_to_plot) {
  ca_sat19 <- read.csv("../data/ca-sat19.csv", stringsAsFactors = F)
  ca_income <- read.csv("../data/ca-county_income.csv", stringsAsFactors = F)
  ca_school <- read.csv("../data/ca-pubschls.csv", stringsAsFactors = F)
  
  ca_coord <- select(ca_school, Latitude, Longitude, County) %>%
    group_by(County) %>%
    summarise(
      lat = mean(as.numeric(Latitude), na.rm = T),
      lng = mean(as.numeric(Longitude), na.rm = T)
    )
  
  ca_income["NameClean"] <- gsub(" County, CA", "", ca_income$Name)
  ca_income["NameClean"] <- gsub(" County/city, CA", "", ca_income$NameClean)
  
  ca_sat19_county <- dplyr::group_by(ca_sat19, CName) %>%
    filter(RType == "C")
  ca_income_sat <- left_join(ca_income, ca_sat19_county,
                             by = c("NameClean" = "CName")
  ) %>%
    rename(vis_data = data_to_plot) %>%
    mutate(vis_data = as.numeric(vis_data)) %>%
    filter(!is.na(vis_data))
  ca_income_sat_loc <- left_join(
    ca_income_sat,
    ca_coord, c("NameClean" = "County")
  )
  pal <- colorNumeric(
    palette = c("white", "navy"),
    domain = ca_income_sat_loc$vis_data
  )
  map <- leaflet(ca_income_sat_loc) %>% addTiles()
  map %>%
    addCircleMarkers(
      lng = ~lng, lat = ~lat, color = ~ pal(vis_data),
      fillOpacity = 1,
      popup = ~ paste0(
        NameClean, " County", "<br>",
        vis_data,
        "% of 12th grade student passed benchmark."
      )
    ) %>%
    addLegend("topright", pal, values = ~ vis_data,
              title = "% Student Passed BM",
              labFormat = labelFormat(suffix = "%"), opacity = 1)
}
