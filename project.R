#Project - Midpoint Deliverable, Data Exploration
library("dplyr")

#Getting the datasets
cali_sat <- read.csv("data/ca-sat15.csv")

cali_school_info <- read.csv("data/ca-pubschls.csv")

irs_tax_info <- read.csv("data/natl_2017_irs.csv")

#Matching Zip Codes to School Name
cali_school_zip <- cali_school_info %>%
  select(School, Zip)

cali_sat_zip <- left_join(cali_sat, cali_school_zip, by = c("sname" = "School"))

#Only California IRS Info
cali_tax_info <- irs_tax_info %>%
  filter(STATE == "CA")