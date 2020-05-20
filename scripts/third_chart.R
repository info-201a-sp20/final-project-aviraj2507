#third chart

# Below is a copy of the script and data from project.R

library("dplyr")
library("ggplot2")

#Getting the datasets
cali_sat <- read.csv("data/ca-sat15.csv", stringsAsFactors = FALSE)

cali_school_info <- read.csv("data/ca-pubschls.csv", stringsAsFactors = FALSE)

irs_tax_info <- read.csv("data/natl_2017_irs.csv", stringsAsFactors = FALSE)

cali_county_income <- read.csv("data/ca-county_income.csv", stringsAsFactors = FALSE)

cali_zip <- read.csv("data/ca-zip-mhi.csv", stringsAsFactors = FALSE)
# Source is http://www.usa.com/rank/california-state--median-household-income--zip-code-rank.htm
# Data aggregated from ACS 2010 - 2014 ACS Data

#Matching Zip Codes to School Name
cali_school_zip <- cali_school_info %>%
  select(School, Zip)

cali_sat_zip <- left_join(cali_sat,
                          cali_school_zip,
                          by = c("sname" = "School"))

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

cali_hs_satScores$Zip <- as.integer(cali_hs_satScores$Zip)

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

#Combining California and ZIP Code MHI
cali_hs_sat_zip <- cali_hs_satScores %>%
  left_join(cali_zip)

names(cali_hs_sat_zip)[7] <- "MedianHouseholdIncome"

######################

#Beginning Third Chart
scatter_sat_zip_HS<- ggplot(data = cali_hs_sat_zip,
                             aes(x = TotalSatScore, y = MedianHouseholdIncome)) +
  geom_point(size = 1, color = "darkblue") +
  geom_smooth(method=lm) +
  ggtitle("SAT Score vs ZIP Code Income by HS") +
  xlab("HS Average SAT Score") +
  ylab("Zip Code Median Income")

#Zip Code Only
zip_code_only_mhi <- cali_hs_sat_zip %>%
  group_by(Zip) %>%
  summarize(AvgSatScore = mean(TotalSatScore)) %>%
  left_join(cali_zip)

names(zip_code_only_mhi)[3] <- "MedianHouseholdIncome"

scatter_zip_only <- ggplot(data = zip_code_only_mhi,
       aes(x = AvgSatScore, y = MedianHouseholdIncome)) +
  geom_point(size = 1, color = "darkblue") +
  geom_smooth(method=lm) +
  ggtitle("SAT Score vs ZIP Code Income by Zip Code") +
  xlab("HS Average SAT Score") +
  ylab("Zip Code Median Income")

#Other Chart (By County)
scatter_sat_county <- ggplot(data = cali_county_sat_income,
       aes(x = TotalSatScore, y = MIH)) +
  geom_point(size = 2, color = "darkgreen") +
  geom_smooth(method=lm) +
  ggtitle("SAT Score vs Median Household Income, by County") +
  xlab("Average County SAT Score") +
  ylab("Median County Household Income")