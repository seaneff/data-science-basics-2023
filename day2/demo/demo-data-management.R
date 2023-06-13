#######################################################################
### Notes #############################################################
#######################################################################

## Assume working directory is set to source file location to 
## read in data

## in R studio, select "Session" -> "Set working directory" -> 
## "To source file location"

#######################################################################
### Load required libraries ###########################################
#######################################################################

## if you don't already have readxl downloaded, start by running:
## install.packages("readxl")
## install.packages("sqldf")
## install.packages("readr")

library(readxl)
library(sqldf)
library(readr)

#######################################################################
### Read in your raw dataset ##########################################
#######################################################################

goal_16 <- read_excel("Goal16.xlsx")
countries <- read.delim("input_data.tsv")

#######################################################################
### See datasets in R Studio Viewer ###################################
#######################################################################

View(goal_16)
View(countries)

#######################################################################
### Explore dataset generally #########################################
#######################################################################

## What are the columns/fields?
names(goal_16)

## What are the values for the Indicator columns?
table(goal_16$Indicator)

## What are the values for the SeriesDescription columns?
table(goal_16$SeriesDescription)

## Print out all the unique values for SeriesDescription
unique(goal_16$SeriesDescription)

## Print out all the unique GeoAreaNames
unique(goal_16$GeoAreaName)

########################################################################################################
### Look into specific types of data: ##################################################################
### Proportion of population that feel safe walking alone around the area they live after dark (%) #####
########################################################################################################

## create a dataset with just the value we are interested in
after_dark <- goal_16[which(goal_16$SeriesDescription == "Proportion of population that feel safe walking alone around the area they live after dark (%)"),]

## what GeoAreaNames have data for this?
table(after_dark$GeoAreaName)

## what years are the data from?
table(after_dark$Time_Detail)

########################################################################################################
### Look into specific types of data: ##################################################################
### Proportion of population subjected to robbery in the previous 12 months, by sex (%) ################
########################################################################################################

## create a dataset with just the value we are interested in
robbery <- goal_16[which(goal_16$SeriesDescription == "Proportion of population subjected to robbery in the previous 12 months, by sex (%)"),]

## what GeoAreaNames have data for this?
table(robbery$GeoAreaName)

## what years are the data from?
table(robbery$Time_Detail)

############################################################################################################################
### For each country, identify the most recent data ########################################################################
## for the observation Proportion of population that feel safe walking alone around the area they live after dark (%) #####
############################################################################################################################

## find the most recent year with data for each country
most_recent_years_per_country <- aggregate(after_dark$Time_Detail, by = list(after_dark$GeoAreaName), FUN = max)
most_recent_years_per_country
names(most_recent_years_per_country) <- c("GeoAreaName", "MostRecentYear")

## join/merge that dataset back with the original after_dark dataset
after_dark_with_year <- merge(after_dark, most_recent_years_per_country, by = "GeoAreaName")

## indicate if data are the most recent
after_dark_with_year$is_most_recent <-  after_dark_with_year$Time_Detail == after_dark_with_year$MostRecentYear
table(after_dark_with_year$is_most_recent)
most_recent_after_dark <- after_dark_with_year[which(after_dark_with_year$is_most_recent == TRUE),]
most_recent_after_dark$reference <- paste(most_recent_after_dark$Source, " (", most_recent_after_dark$Time_Detail, ")", sep = "")

############################################################################################################################
### For each country, identify the most recent data ########################################################################
## for the observation Proportion of population subjected to robbery in the previous 12 months, by sex (%) #################
############################################################################################################################

## find the most recent year with data for each country
most_recent_years_per_country_robbery <- aggregate(robbery$Time_Detail, by = list(robbery$GeoAreaName), FUN = max)
most_recent_years_per_country_robbery
names(most_recent_years_per_country_robbery) <- c("GeoAreaName", "MostRecentYear")

## join/merge that dataset back with the original after_dark dataset
robbery_with_year <- merge(robbery, most_recent_years_per_country_robbery, by = "GeoAreaName")

## indicate if data are the most recent
robbery_with_year$is_most_recent <-  robbery_with_year$Time_Detail == robbery_with_year$MostRecentYear
table(robbery_with_year$is_most_recent)
most_recent_robbery <- robbery_with_year[which(robbery_with_year$is_most_recent == TRUE),]
most_recent_robbery$reference <- paste(most_recent_robbery$Source, " (", most_recent_robbery$Time_Detail, ")", sep = "")

######################################################################################################
### reformat so we have just one row per country #####################################################
######################################################################################################

final_dataset <- sqldf(
  "select 
    c.name as country_name,
    c.iso_3166,
    c.who_member_state,
    c.who_region,
    max(case when d.Sex == 'BOTHSEX' then d.Value else null end) as safe_after_dark_overall,
    max(case when d.Sex == 'MALE' then d.Value else null end) as safe_after_dark_male,
    max(case when d.Sex == 'FEMALE' then d.Value else null end) as safe_after_dark_female,
    max(d.reference) as safe_after_dark_reference,
    max(case when r.Sex == 'BOTHSEX' then r.Value else null end) robbery_overall,
    max(case when r.Sex == 'MALE' then r.Value else null end) as robbery_male,
    max(case when r.Sex == 'FEMALE' then r.Value else null end) as robbery_female,
    max(r.reference) as robbery_reference,
    max(c.doctor_consultations_per_capita) as doctor_consultations_per_capita,
    max(c.doctors_consultation_reference) as doctors_consultation_reference,
    max(c.mds_per_10000capita) as mds_per_10000capita,
    max(c.mds_per_10000capita_reference) as mds_per_10000capita_reference,
    max(c.nurses_midwives_per_10000capita) as nurses_midwives_per_10000capita,
    max(c.nurses_midwives_per_10000capita_reference) as nurses_midwives_per_10000capita_reference
  from countries as c
  left join most_recent_after_dark as d
    on d.GeoAreaName = c.name
  left join most_recent_robbery as r
    on r.GeoAreaName = c.name
   group by d.Time_Detail,
    c.iso_3166,
    c.who_member_state,
    c.who_region")

######################################################################################################
### Export data ######################################################################################
######################################################################################################

write_delim(final_dataset,
             delim = "\t",
             file = "countries.tsv", 
             na = "NA")
