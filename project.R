#Project - Midpoint Deliverable, Data Exploration
library("dplyr")

#Getting the datasets
cali_sat <- read.csv("data/ca-sat15.csv", stringsAsFactors = FALSE)

cali_school_info <- read.csv("data/ca-pubschls.csv", stringsAsFactors = FALSE)

irs_tax_info <- read.csv("data/natl_2017_irs.csv", stringsAsFactors = FALSE)

cali_county_income <- read.csv("data/ca-county_income.csv", stringsAsFactors = FALSE)

#Matching Zip Codes to School Name
cali_school_zip <- cali_school_info %>%
  select(School, Zip)

cali_sat_zip <- left_join(cali_sat, cali_school_zip, by = c("sname" = "School"))

#Only California IRS Info
cali_tax_info <- irs_tax_info %>%
  filter(STATE == "CA") %>%
  select(zipcode, agi_stub, N1, A00100)

cali_tax_info$A00100 <- as.numeric(cali_tax_info$A00100)

cali_tax_summary <- group_by(cali_tax_info, zipcode) %>%
  summarize(sum_of_agi = sum(A00100), sum_of_taxpayers = sum(N1),
            avg_tax_income = sum_of_agi / sum_of_taxpayers) %>%
  filter(avg_tax_income != is.na(avg_tax_income))

#Processing SAT Score File
cali_sat_zip$Zip <- substr(cali_sat_zip$Zip, 1, 5)

cali_hs_satScores <- cali_sat_zip %>%
  filter(rtype == "S") %>%
  select(sname, AvgScrRead, AvgScrMath, AvgScrWrite, Zip) %>%
  distinct(sname, .keep_all = TRUE) %>%
  group_by(sname) %>%
  mutate(TotalSatScore = sum(as.numeric(AvgScrRead), as.numeric(AvgScrWrite), as.numeric(AvgScrMath))) %>%
  filter(TotalSatScore != is.na(TotalSatScore))

#Combining Zip Code Income and SAT Scores
cali_hs_satScores$Zip <- as.integer(cali_hs_satScores$Zip)

cali_sat_income_by_zip <- left_join(cali_hs_satScores,
                                    cali_tax_summary,
                                    by = c("Zip" = "zipcode")) %>%
  select(sname, Zip, TotalSatScore, avg_tax_income) %>%
  filter(Zip != is.na(Zip), avg_tax_income != is.na(avg_tax_income))

zip_and_income <- cali_sat_income_by_zip %>%
  group_by(Zip) %>%
  summarize(AvgZipSat = mean(TotalSatScore)) %>%
  left_join(cali_tax_summary, by = c("Zip" = "zipcode")) %>%
  select(Zip, AvgZipSat, avg_tax_income)


#Combining County Income and SAT Scores
nchar(" County, CA")

cali_county_sat <- cali_sat_zip %>%
  filter(rtype == "C") %>%
  select(cname, AvgScrRead, AvgScrMath, AvgScrWrite) %>%
  mutate(TotalSatScore = as.numeric(AvgScrRead) +
           as.numeric(AvgScrWrite) +
           as.numeric(AvgScrMath)) %>%
  filter(TotalSatScore != is.na(TotalSatScore))

cali_county_income <- cali_county_income %>%
  mutate(cname = substr(Name, 1, nchar(Name) - nchar(" County, CA")))

cali_county_sat_income <- cali_county_sat %>%
  left_join(cali_county_income) %>%
  select(cname, AvgScrRead, AvgScrMath, AvgScrWrite, TotalSatScore, MIH)
