# Load libraries
library(rgdal)
library(sf)
library(jsonlite)
library(cowplot)
library(ggsn)
library(ggspatial)
library(plotly)

# Source final_project.R
source("final_project.R")

# Source map_built_units.R
source("map_built_units.R")

# Create a choropleth map displaying the dominant income group for each block group
# in Chinatown and Wallingford for each year 

# Create a new data frame for each year with: GEOID, YEAR, NAME, and max_inc_grp
# (as an ordinal variable)

# Use income_year (ex. income_2013) data frame for this (make sure to create COPIES
# of the data frames)
# Create a new column: perc_max_inc_grp
# Then create new column: max_inc_grp 

# For 2013 ----

# Create copy of income_2013 
inc_2013 <- income_2013

# Percentage of individuals that belong to each income group
inc_2013$perc_10k_less <- inc_2013$less_than_10k / inc_2013$totalSurveyPop * 100
inc_2013$perc_10k_14.99k <- inc_2013$X10k_to_14.99k / inc_2013$totalSurveyPop * 100
inc_2013$perc_15k_19.99k <- inc_2013$X15k_to_19.99k / inc_2013$totalSurveyPop * 100
inc_2013$perc_20k_24.99k <- inc_2013$X20k_to_24.99k / inc_2013$totalSurveyPop * 100
inc_2013$perc_25k_29.99k <- inc_2013$X25k_to_29.99k / inc_2013$totalSurveyPop * 100
inc_2013$perc_30k_34.99k <- inc_2013$X30k_to_34.99k / inc_2013$totalSurveyPop * 100
inc_2013$perc_35k_39.99k <- inc_2013$X35k_to_39.99k / inc_2013$totalSurveyPop * 100
inc_2013$perc_40k_44.99k <- inc_2013$X40k_to_44.99k / inc_2013$totalSurveyPop * 100
inc_2013$perc_45k_49.99k <- inc_2013$X45k_to_49.99k / inc_2013$totalSurveyPop * 100
inc_2013$perc_50k_59.99k <- inc_2013$X50k_to_59.99k / inc_2013$totalSurveyPop * 100
inc_2013$perc_60k_74.99k <- inc_2013$X60k_to_74.99k / inc_2013$totalSurveyPop * 100
inc_2013$perc_75k_99.99k <- inc_2013$X75k_99.99k / inc_2013$totalSurveyPop * 100
inc_2013$perc_100k_124.99k <- inc_2013$X100k_to_124.99k / inc_2013$totalSurveyPop * 100
inc_2013$perc_125k_149.99k <- inc_2013$X125k_to_149.99k / inc_2013$totalSurveyPop * 100
inc_2013$perc_150k_199.99k <- inc_2013$X150k_to_199.99k / inc_2013$totalSurveyPop * 100
inc_2013$perc_200k_more <- inc_2013$X200k_or_more / inc_2013$totalSurveyPop * 100

# Percentage of dominant income group
max_inc <- apply(inc_2013[,4:19], 1, max)
perc_inc <- max_inc / inc_2013$totalSurveyPop * 100
inc_2013$max_inc_perc <- perc_inc

# Categorical variable (income)
# Match max percentage to one of the percentages
indices_10k <- which(inc_2013$max_inc_perc == inc_2013$perc_10k_less)
indices_10k_14.99k <- which(inc_2013$max_inc_perc == inc_2013$perc_10k_14.99k)
indices_15k_19.99k <- which(inc_2013$max_inc_perc == inc_2013$perc_15k_19.99k)
indices_20k_24.99k <- which(inc_2013$max_inc_perc == inc_2013$perc_20k_24.99k)
indices_25k_29.99k <- which(inc_2013$max_inc_perc == inc_2013$perc_25k_29.99k)
indices_30k_34.99k <- which(inc_2013$max_inc_perc == inc_2013$perc_30k_34.99k)
indices_35k_39.99k <- which(inc_2013$max_inc_perc == inc_2013$perc_35k_39.99k)
indices_40k_44.99k <- which(inc_2013$max_inc_perc == inc_2013$perc_40k_44.99k)
indices_45k_49.99k <- which(inc_2013$max_inc_perc == inc_2013$perc_45k_49.99k)
indices_50k_59.99k <- which(inc_2013$max_inc_perc == inc_2013$perc_50k_59.99k)
indices_60k_74.99k <- which(inc_2013$max_inc_perc == inc_2013$perc_60k_74.99k)
indices_75k_99.99k <- which(inc_2013$max_inc_perc == inc_2013$perc_75k_99.99k)
indices_100k_124.99k <- which(inc_2013$max_inc_perc == inc_2013$perc_100k_124.99k)
indices_125k_149.99k <- which(inc_2013$max_inc_perc == inc_2013$perc_125k_149.99k)
indices_150k_199.99k <- which(inc_2013$max_inc_perc == inc_2013$perc_150k_199.99k)
indices_200k <- which(inc_2013$max_inc_perc == inc_2013$perc_200k_more)

inc_2013$max_inc_grp[indices_10k] <- "10,000 or less" # or less
inc_2013$max_inc_grp[indices_10k_14.99k] <- "10,000-14,999"
inc_2013$max_inc_grp[indices_15k_19.99k] <- "15,000-19,999"
inc_2013$max_inc_grp[indices_20k_24.99k] <- "20,000-24,999"
inc_2013$max_inc_grp[indices_25k_29.99k] <- "25,000-29,999"
inc_2013$max_inc_grp[indices_30k_34.99k] <- "30,000-34,999"
inc_2013$max_inc_grp[indices_35k_39.99k] <- "35,000-39,999"
inc_2013$max_inc_grp[indices_40k_44.99k] <- "40,000-44,999"
inc_2013$max_inc_grp[indices_45k_49.99k] <- "45,000-49,999"
inc_2013$max_inc_grp[indices_50k_59.99k] <- "50,000-59,999"
inc_2013$max_inc_grp[indices_60k_74.99k] <- "60,000-74,999"
inc_2013$max_inc_grp[indices_75k_99.99k] <- "75,000-99,999"
inc_2013$max_inc_grp[indices_100k_124.99k] <- "100,000-124,999"
inc_2013$max_inc_grp[indices_125k_149.99k] <- "125,000-149,999"
inc_2013$max_inc_grp[indices_150k_199.99k] <- "150,000-199,999"
inc_2013$max_inc_grp[indices_200k] <- "200,000 or more"

inc_2013$max_inc_grp_vec <- factor(inc_2013$max_inc_grp, ordered = TRUE,
                                   levels = c("10,000 or less", "20,000-24,999",
                                              "25,000-29,999","30,000-34,999", 
                                              "35,000-39,999", "40,000-44,999",
                                              "50,000-59,999", "60,000-74,999",
                                              "75,000-99,999", "100,000-124,999",
                                              "125,000-149,999", "150,000-199,999",
                                              "200,000 or more"))

# For 2014 ----
# Create copy of income_2014 
inc_2014 <- income_2014

# Percentage of individuals that belong to each income group
inc_2014$perc_10k_less <- inc_2014$less_than_10k / inc_2014$totalSurveyPop * 100
inc_2014$perc_10k_14.99k <- inc_2014$X10k_to_14.99k / inc_2014$totalSurveyPop * 100
inc_2014$perc_15k_19.99k <- inc_2014$X15k_to_19.99k / inc_2014$totalSurveyPop * 100
inc_2014$perc_20k_24.99k <- inc_2014$X20k_to_24.99k / inc_2014$totalSurveyPop * 100
inc_2014$perc_25k_29.99k <- inc_2014$X25k_to_29.99k / inc_2014$totalSurveyPop * 100
inc_2014$perc_30k_34.99k <- inc_2014$X30k_to_34.99k / inc_2014$totalSurveyPop * 100
inc_2014$perc_35k_39.99k <- inc_2014$X35k_to_39.99k / inc_2014$totalSurveyPop * 100
inc_2014$perc_40k_44.99k <- inc_2014$X40k_to_44.99k / inc_2014$totalSurveyPop * 100
inc_2014$perc_45k_49.99k <- inc_2014$X45k_to_49.99k / inc_2014$totalSurveyPop * 100
inc_2014$perc_50k_59.99k <- inc_2014$X50k_to_59.99k / inc_2014$totalSurveyPop * 100
inc_2014$perc_60k_74.99k <- inc_2014$X60k_to_74.99k / inc_2014$totalSurveyPop * 100
inc_2014$perc_75k_99.99k <- inc_2014$X75k_99.99k / inc_2014$totalSurveyPop * 100
inc_2014$perc_100k_124.99k <- inc_2014$X100k_to_124.99k / inc_2014$totalSurveyPop * 100
inc_2014$perc_125k_149.99k <- inc_2014$X125k_to_149.99k / inc_2014$totalSurveyPop * 100
inc_2014$perc_150k_199.99k <- inc_2014$X150k_to_199.99k / inc_2014$totalSurveyPop * 100
inc_2014$perc_200k_more <- inc_2014$X200k_or_more / inc_2014$totalSurveyPop * 100

# Percentage of dominant income group
max_inc <- apply(inc_2014[,4:19], 1, max)
perc_inc <- max_inc / inc_2014$totalSurveyPop * 100
inc_2014$max_inc_perc <- perc_inc

# Categorical variable (income)
# Match max percentage to one of the percentages
indices_10k <- which(inc_2014$max_inc_perc == inc_2014$perc_10k_less)
indices_10k_14.99k <- which(inc_2014$max_inc_perc == inc_2014$perc_10k_14.99k)
indices_15k_19.99k <- which(inc_2014$max_inc_perc == inc_2014$perc_15k_19.99k)
indices_20k_24.99k <- which(inc_2014$max_inc_perc == inc_2014$perc_20k_24.99k)
indices_25k_29.99k <- which(inc_2014$max_inc_perc == inc_2014$perc_25k_29.99k)
indices_30k_34.99k <- which(inc_2014$max_inc_perc == inc_2014$perc_30k_34.99k)
indices_35k_39.99k <- which(inc_2014$max_inc_perc == inc_2014$perc_35k_39.99k)
indices_40k_44.99k <- which(inc_2014$max_inc_perc == inc_2014$perc_40k_44.99k)
indices_45k_49.99k <- which(inc_2014$max_inc_perc == inc_2014$perc_45k_49.99k)
indices_50k_59.99k <- which(inc_2014$max_inc_perc == inc_2014$perc_50k_59.99k)
indices_60k_74.99k <- which(inc_2014$max_inc_perc == inc_2014$perc_60k_74.99k)
indices_75k_99.99k <- which(inc_2014$max_inc_perc == inc_2014$perc_75k_99.99k)
indices_100k_124.99k <- which(inc_2014$max_inc_perc == inc_2014$perc_100k_124.99k)
indices_125k_149.99k <- which(inc_2014$max_inc_perc == inc_2014$perc_125k_149.99k)
indices_150k_199.99k <- which(inc_2014$max_inc_perc == inc_2014$perc_150k_199.99k)
indices_200k <- which(inc_2014$max_inc_perc == inc_2014$perc_200k_more)

inc_2014$max_inc_grp[indices_10k] <- "10,000 or less" # or less
inc_2014$max_inc_grp[indices_10k_14.99k] <- "10,000-14,999"
inc_2014$max_inc_grp[indices_15k_19.99k] <- "15,000-19,999"
inc_2014$max_inc_grp[indices_20k_24.99k] <- "20,000-24,999"
inc_2014$max_inc_grp[indices_25k_29.99k] <- "25,000-29,999"
inc_2014$max_inc_grp[indices_30k_34.99k] <- "30,000-34,999"
inc_2014$max_inc_grp[indices_35k_39.99k] <- "35,000-39,999"
inc_2014$max_inc_grp[indices_40k_44.99k] <- "40,000-44,999"
inc_2014$max_inc_grp[indices_45k_49.99k] <- "45,000-49,999"
inc_2014$max_inc_grp[indices_50k_59.99k] <- "50,000-59,999"
inc_2014$max_inc_grp[indices_60k_74.99k] <- "60,000-74,999"
inc_2014$max_inc_grp[indices_75k_99.99k] <- "75,000-99,999"
inc_2014$max_inc_grp[indices_100k_124.99k] <- "100,000-124,999"
inc_2014$max_inc_grp[indices_125k_149.99k] <- "125,000-149,999"
inc_2014$max_inc_grp[indices_150k_199.99k] <- "150,000-199,999"
inc_2014$max_inc_grp[indices_200k] <- "200,000 or more"

inc_2014$max_inc_grp_vec <- factor(inc_2014$max_inc_grp, ordered = TRUE,
                                   levels = c("10,000 or less", "20,000-24,999",
                                              "25,000-29,999","30,000-34,999", 
                                              "35,000-39,999", "40,000-44,999",
                                              "50,000-59,999", "60,000-74,999",
                                              "75,000-99,999", "100,000-124,999",
                                              "125,000-149,999", "150,000-199,999",
                                              "200,000 or more"))

# For 2015 ----
# Create copy of income_2015 
inc_2015 <- income_2015

# Percentage of individuals that belong to each income group
inc_2015$perc_10k_less <- inc_2015$less_than_10k / inc_2015$totalSurveyPop * 100
inc_2015$perc_10k_14.99k <- inc_2015$X10k_to_14.99k / inc_2015$totalSurveyPop * 100
inc_2015$perc_15k_19.99k <- inc_2015$X15k_to_19.99k / inc_2015$totalSurveyPop * 100
inc_2015$perc_20k_24.99k <- inc_2015$X20k_to_24.99k / inc_2015$totalSurveyPop * 100
inc_2015$perc_25k_29.99k <- inc_2015$X25k_to_29.99k / inc_2015$totalSurveyPop * 100
inc_2015$perc_30k_34.99k <- inc_2015$X30k_to_34.99k / inc_2015$totalSurveyPop * 100
inc_2015$perc_35k_39.99k <- inc_2015$X35k_to_39.99k / inc_2015$totalSurveyPop * 100
inc_2015$perc_40k_44.99k <- inc_2015$X40k_to_44.99k / inc_2015$totalSurveyPop * 100
inc_2015$perc_45k_49.99k <- inc_2015$X45k_to_49.99k / inc_2015$totalSurveyPop * 100
inc_2015$perc_50k_59.99k <- inc_2015$X50k_to_59.99k / inc_2015$totalSurveyPop * 100
inc_2015$perc_60k_74.99k <- inc_2015$X60k_to_74.99k / inc_2015$totalSurveyPop * 100
inc_2015$perc_75k_99.99k <- inc_2015$X75k_99.99k / inc_2015$totalSurveyPop * 100
inc_2015$perc_100k_124.99k <- inc_2015$X100k_to_124.99k / inc_2015$totalSurveyPop * 100
inc_2015$perc_125k_149.99k <- inc_2015$X125k_to_149.99k / inc_2015$totalSurveyPop * 100
inc_2015$perc_150k_199.99k <- inc_2015$X150k_to_199.99k / inc_2015$totalSurveyPop * 100
inc_2015$perc_200k_more <- inc_2015$X200k_or_more / inc_2015$totalSurveyPop * 100

# Percentage of dominant income group
max_inc <- apply(inc_2015[,4:19], 1, max)
perc_inc <- max_inc / inc_2015$totalSurveyPop * 100
inc_2015$max_inc_perc <- perc_inc

# Categorical variable (income)
# Match max percentage to one of the percentages
indices_10k <- which(inc_2015$max_inc_perc == inc_2015$perc_10k_less)
indices_10k_14.99k <- which(inc_2015$max_inc_perc == inc_2015$perc_10k_14.99k)
indices_15k_19.99k <- which(inc_2015$max_inc_perc == inc_2015$perc_15k_19.99k)
indices_20k_24.99k <- which(inc_2015$max_inc_perc == inc_2015$perc_20k_24.99k)
indices_25k_29.99k <- which(inc_2015$max_inc_perc == inc_2015$perc_25k_29.99k)
indices_30k_34.99k <- which(inc_2015$max_inc_perc == inc_2015$perc_30k_34.99k)
indices_35k_39.99k <- which(inc_2015$max_inc_perc == inc_2015$perc_35k_39.99k)
indices_40k_44.99k <- which(inc_2015$max_inc_perc == inc_2015$perc_40k_44.99k)
indices_45k_49.99k <- which(inc_2015$max_inc_perc == inc_2015$perc_45k_49.99k)
indices_50k_59.99k <- which(inc_2015$max_inc_perc == inc_2015$perc_50k_59.99k)
indices_60k_74.99k <- which(inc_2015$max_inc_perc == inc_2015$perc_60k_74.99k)
indices_75k_99.99k <- which(inc_2015$max_inc_perc == inc_2015$perc_75k_99.99k)
indices_100k_124.99k <- which(inc_2015$max_inc_perc == inc_2015$perc_100k_124.99k)
indices_125k_149.99k <- which(inc_2015$max_inc_perc == inc_2015$perc_125k_149.99k)
indices_150k_199.99k <- which(inc_2015$max_inc_perc == inc_2015$perc_150k_199.99k)
indices_200k <- which(inc_2015$max_inc_perc == inc_2015$perc_200k_more)

inc_2015$max_inc_grp[indices_10k] <- "10,000 or less" # or less
inc_2015$max_inc_grp[indices_10k_14.99k] <- "10,000-14,999"
inc_2015$max_inc_grp[indices_15k_19.99k] <- "15,000-19,999"
inc_2015$max_inc_grp[indices_20k_24.99k] <- "20,000-24,999"
inc_2015$max_inc_grp[indices_25k_29.99k] <- "25,000-29,999"
inc_2015$max_inc_grp[indices_30k_34.99k] <- "30,000-34,999"
inc_2015$max_inc_grp[indices_35k_39.99k] <- "35,000-39,999"
inc_2015$max_inc_grp[indices_40k_44.99k] <- "40,000-44,999"
inc_2015$max_inc_grp[indices_45k_49.99k] <- "45,000-49,999"
inc_2015$max_inc_grp[indices_50k_59.99k] <- "50,000-59,999"
inc_2015$max_inc_grp[indices_60k_74.99k] <- "60,000-74,999"
inc_2015$max_inc_grp[indices_75k_99.99k] <- "75,000-99,999"
inc_2015$max_inc_grp[indices_100k_124.99k] <- "100,000-124,999"
inc_2015$max_inc_grp[indices_125k_149.99k] <- "125,000-149,999"
inc_2015$max_inc_grp[indices_150k_199.99k] <- "150,000-199,999"
inc_2015$max_inc_grp[indices_200k] <- "200,000 or more"

inc_2015$max_inc_grp_vec <- factor(inc_2015$max_inc_grp, ordered = TRUE,
                                   levels = c("10,000 or less", "20,000-24,999",
                                              "25,000-29,999","30,000-34,999", 
                                              "35,000-39,999", "40,000-44,999",
                                              "50,000-59,999", "60,000-74,999",
                                              "75,000-99,999", "100,000-124,999",
                                              "125,000-149,999", "150,000-199,999",
                                              "200,000 or more"))

# For 2016
# For 2016 ----
# Create copy of income_2016 
inc_2016 <- income_2016

# Percentage of individuals that belong to each income group
inc_2016$perc_10k_less <- inc_2016$less_than_10k / inc_2016$totalSurveyPop * 100
inc_2016$perc_10k_14.99k <- inc_2016$X10k_to_14.99k / inc_2016$totalSurveyPop * 100
inc_2016$perc_15k_19.99k <- inc_2016$X15k_to_19.99k / inc_2016$totalSurveyPop * 100
inc_2016$perc_20k_24.99k <- inc_2016$X20k_to_24.99k / inc_2016$totalSurveyPop * 100
inc_2016$perc_25k_29.99k <- inc_2016$X25k_to_29.99k / inc_2016$totalSurveyPop * 100
inc_2016$perc_30k_34.99k <- inc_2016$X30k_to_34.99k / inc_2016$totalSurveyPop * 100
inc_2016$perc_35k_39.99k <- inc_2016$X35k_to_39.99k / inc_2016$totalSurveyPop * 100
inc_2016$perc_40k_44.99k <- inc_2016$X40k_to_44.99k / inc_2016$totalSurveyPop * 100
inc_2016$perc_45k_49.99k <- inc_2016$X45k_to_49.99k / inc_2016$totalSurveyPop * 100
inc_2016$perc_50k_59.99k <- inc_2016$X50k_to_59.99k / inc_2016$totalSurveyPop * 100
inc_2016$perc_60k_74.99k <- inc_2016$X60k_to_74.99k / inc_2016$totalSurveyPop * 100
inc_2016$perc_75k_99.99k <- inc_2016$X75k_99.99k / inc_2016$totalSurveyPop * 100
inc_2016$perc_100k_124.99k <- inc_2016$X100k_to_124.99k / inc_2016$totalSurveyPop * 100
inc_2016$perc_125k_149.99k <- inc_2016$X125k_to_149.99k / inc_2016$totalSurveyPop * 100
inc_2016$perc_150k_199.99k <- inc_2016$X150k_to_199.99k / inc_2016$totalSurveyPop * 100
inc_2016$perc_200k_more <- inc_2016$X200k_or_more / inc_2016$totalSurveyPop * 100

# Percentage of dominant income group
max_inc <- apply(inc_2016[,4:19], 1, max)
perc_inc <- max_inc / inc_2016$totalSurveyPop * 100
inc_2016$max_inc_perc <- perc_inc

# Categorical variable (income)
# Match max percentage to one of the percentages
indices_10k <- which(inc_2016$max_inc_perc == inc_2016$perc_10k_less)
indices_10k_14.99k <- which(inc_2016$max_inc_perc == inc_2016$perc_10k_14.99k)
indices_15k_19.99k <- which(inc_2016$max_inc_perc == inc_2016$perc_15k_19.99k)
indices_20k_24.99k <- which(inc_2016$max_inc_perc == inc_2016$perc_20k_24.99k)
indices_25k_29.99k <- which(inc_2016$max_inc_perc == inc_2016$perc_25k_29.99k)
indices_30k_34.99k <- which(inc_2016$max_inc_perc == inc_2016$perc_30k_34.99k)
indices_35k_39.99k <- which(inc_2016$max_inc_perc == inc_2016$perc_35k_39.99k)
indices_40k_44.99k <- which(inc_2016$max_inc_perc == inc_2016$perc_40k_44.99k)
indices_45k_49.99k <- which(inc_2016$max_inc_perc == inc_2016$perc_45k_49.99k)
indices_50k_59.99k <- which(inc_2016$max_inc_perc == inc_2016$perc_50k_59.99k)
indices_60k_74.99k <- which(inc_2016$max_inc_perc == inc_2016$perc_60k_74.99k)
indices_75k_99.99k <- which(inc_2016$max_inc_perc == inc_2016$perc_75k_99.99k)
indices_100k_124.99k <- which(inc_2016$max_inc_perc == inc_2016$perc_100k_124.99k)
indices_125k_149.99k <- which(inc_2016$max_inc_perc == inc_2016$perc_125k_149.99k)
indices_150k_199.99k <- which(inc_2016$max_inc_perc == inc_2016$perc_150k_199.99k)
indices_200k <- which(inc_2016$max_inc_perc == inc_2016$perc_200k_more)

inc_2016$max_inc_grp[indices_10k] <- "10,000 or less" # or less
inc_2016$max_inc_grp[indices_10k_14.99k] <- "10,000-14,999"
inc_2016$max_inc_grp[indices_15k_19.99k] <- "15,000-19,999"
inc_2016$max_inc_grp[indices_20k_24.99k] <- "20,000-24,999"
inc_2016$max_inc_grp[indices_25k_29.99k] <- "25,000-29,999"
inc_2016$max_inc_grp[indices_30k_34.99k] <- "30,000-34,999"
inc_2016$max_inc_grp[indices_35k_39.99k] <- "35,000-39,999"
inc_2016$max_inc_grp[indices_40k_44.99k] <- "40,000-44,999"
inc_2016$max_inc_grp[indices_45k_49.99k] <- "45,000-49,999"
inc_2016$max_inc_grp[indices_50k_59.99k] <- "50,000-59,999"
inc_2016$max_inc_grp[indices_60k_74.99k] <- "60,000-74,999"
inc_2016$max_inc_grp[indices_75k_99.99k] <- "75,000-99,999"
inc_2016$max_inc_grp[indices_100k_124.99k] <- "100,000-124,999"
inc_2016$max_inc_grp[indices_125k_149.99k] <- "125,000-149,999"
inc_2016$max_inc_grp[indices_150k_199.99k] <- "150,000-199,999"
inc_2016$max_inc_grp[indices_200k] <- "200,000 or more"

inc_2016$max_inc_grp_vec <- factor(inc_2016$max_inc_grp, ordered = TRUE,
                                   levels = c("10,000 or less", "20,000-24,999",
                                              "25,000-29,999","30,000-34,999", 
                                              "35,000-39,999", "40,000-44,999",
                                              "50,000-59,999", "60,000-74,999",
                                              "75,000-99,999", "100,000-124,999",
                                              "125,000-149,999", "150,000-199,999",
                                              "200,000 or more"))

# For 2017 ----
# Create copy of income_2017 
inc_2017 <- income_2017

# Percentage of individuals that belong to each income group
inc_2017$perc_10k_less <- inc_2017$less_than_10k / inc_2017$totalSurveyPop * 100
inc_2017$perc_10k_14.99k <- inc_2017$X10k_to_14.99k / inc_2017$totalSurveyPop * 100
inc_2017$perc_15k_19.99k <- inc_2017$X15k_to_19.99k / inc_2017$totalSurveyPop * 100
inc_2017$perc_20k_24.99k <- inc_2017$X20k_to_24.99k / inc_2017$totalSurveyPop * 100
inc_2017$perc_25k_29.99k <- inc_2017$X25k_to_29.99k / inc_2017$totalSurveyPop * 100
inc_2017$perc_30k_34.99k <- inc_2017$X30k_to_34.99k / inc_2017$totalSurveyPop * 100
inc_2017$perc_35k_39.99k <- inc_2017$X35k_to_39.99k / inc_2017$totalSurveyPop * 100
inc_2017$perc_40k_44.99k <- inc_2017$X40k_to_44.99k / inc_2017$totalSurveyPop * 100
inc_2017$perc_45k_49.99k <- inc_2017$X45k_to_49.99k / inc_2017$totalSurveyPop * 100
inc_2017$perc_50k_59.99k <- inc_2017$X50k_to_59.99k / inc_2017$totalSurveyPop * 100
inc_2017$perc_60k_74.99k <- inc_2017$X60k_to_74.99k / inc_2017$totalSurveyPop * 100
inc_2017$perc_75k_99.99k <- inc_2017$X75k_99.99k / inc_2017$totalSurveyPop * 100
inc_2017$perc_100k_124.99k <- inc_2017$X100k_to_124.99k / inc_2017$totalSurveyPop * 100
inc_2017$perc_125k_149.99k <- inc_2017$X125k_to_149.99k / inc_2017$totalSurveyPop * 100
inc_2017$perc_150k_199.99k <- inc_2017$X150k_to_199.99k / inc_2017$totalSurveyPop * 100
inc_2017$perc_200k_more <- inc_2017$X200k_or_more / inc_2017$totalSurveyPop * 100

# Percentage of dominant income group
max_inc <- apply(inc_2017[,4:19], 1, max)
perc_inc <- max_inc / inc_2017$totalSurveyPop * 100
inc_2017$max_inc_perc <- perc_inc

# Categorical variable (income)
# Match max percentage to one of the percentages
indices_10k <- which(inc_2017$max_inc_perc == inc_2017$perc_10k_less)
indices_10k_14.99k <- which(inc_2017$max_inc_perc == inc_2017$perc_10k_14.99k)
indices_15k_19.99k <- which(inc_2017$max_inc_perc == inc_2017$perc_15k_19.99k)
indices_20k_24.99k <- which(inc_2017$max_inc_perc == inc_2017$perc_20k_24.99k)
indices_25k_29.99k <- which(inc_2017$max_inc_perc == inc_2017$perc_25k_29.99k)
indices_30k_34.99k <- which(inc_2017$max_inc_perc == inc_2017$perc_30k_34.99k)
indices_35k_39.99k <- which(inc_2017$max_inc_perc == inc_2017$perc_35k_39.99k)
indices_40k_44.99k <- which(inc_2017$max_inc_perc == inc_2017$perc_40k_44.99k)
indices_45k_49.99k <- which(inc_2017$max_inc_perc == inc_2017$perc_45k_49.99k)
indices_50k_59.99k <- which(inc_2017$max_inc_perc == inc_2017$perc_50k_59.99k)
indices_60k_74.99k <- which(inc_2017$max_inc_perc == inc_2017$perc_60k_74.99k)
indices_75k_99.99k <- which(inc_2017$max_inc_perc == inc_2017$perc_75k_99.99k)
indices_100k_124.99k <- which(inc_2017$max_inc_perc == inc_2017$perc_100k_124.99k)
indices_125k_149.99k <- which(inc_2017$max_inc_perc == inc_2017$perc_125k_149.99k)
indices_150k_199.99k <- which(inc_2017$max_inc_perc == inc_2017$perc_150k_199.99k)
indices_200k <- which(inc_2017$max_inc_perc == inc_2017$perc_200k_more)

inc_2017$max_inc_grp[indices_10k] <- "10,000 or less" # or less
inc_2017$max_inc_grp[indices_10k_14.99k] <- "10,000-14,999"
inc_2017$max_inc_grp[indices_15k_19.99k] <- "15,000-19,999"
inc_2017$max_inc_grp[indices_20k_24.99k] <- "20,000-24,999"
inc_2017$max_inc_grp[indices_25k_29.99k] <- "25,000-29,999"
inc_2017$max_inc_grp[indices_30k_34.99k] <- "30,000-34,999"
inc_2017$max_inc_grp[indices_35k_39.99k] <- "35,000-39,999"
inc_2017$max_inc_grp[indices_40k_44.99k] <- "40,000-44,999"
inc_2017$max_inc_grp[indices_45k_49.99k] <- "45,000-49,999"
inc_2017$max_inc_grp[indices_50k_59.99k] <- "50,000-59,999"
inc_2017$max_inc_grp[indices_60k_74.99k] <- "60,000-74,999"
inc_2017$max_inc_grp[indices_75k_99.99k] <- "75,000-99,999"
inc_2017$max_inc_grp[indices_100k_124.99k] <- "100,000-124,999"
inc_2017$max_inc_grp[indices_125k_149.99k] <- "125,000-149,999"
inc_2017$max_inc_grp[indices_150k_199.99k] <- "150,000-199,999"
inc_2017$max_inc_grp[indices_200k] <- "200,000 or more"

inc_2017$max_inc_grp_vec <- factor(inc_2017$max_inc_grp, ordered = TRUE,
                                   levels = c("10,000 or less", "20,000-24,999",
                                              "25,000-29,999","30,000-34,999", 
                                              "35,000-39,999", "40,000-44,999",
                                              "50,000-59,999", "60,000-74,999",
                                              "75,000-99,999", "100,000-124,999",
                                              "125,000-149,999", "150,000-199,999",
                                              "200,000 or more"))

# For 2018 ----
# Create copy of income_2018 
inc_2018 <- income_2018

# Percentage of individuals that belong to each income group
inc_2018$perc_10k_less <- inc_2018$less_than_10k / inc_2018$totalSurveyPop * 100
inc_2018$perc_10k_14.99k <- inc_2018$X10k_to_14.99k / inc_2018$totalSurveyPop * 100
inc_2018$perc_15k_19.99k <- inc_2018$X15k_to_19.99k / inc_2018$totalSurveyPop * 100
inc_2018$perc_20k_24.99k <- inc_2018$X20k_to_24.99k / inc_2018$totalSurveyPop * 100
inc_2018$perc_25k_29.99k <- inc_2018$X25k_to_29.99k / inc_2018$totalSurveyPop * 100
inc_2018$perc_30k_34.99k <- inc_2018$X30k_to_34.99k / inc_2018$totalSurveyPop * 100
inc_2018$perc_35k_39.99k <- inc_2018$X35k_to_39.99k / inc_2018$totalSurveyPop * 100
inc_2018$perc_40k_44.99k <- inc_2018$X40k_to_44.99k / inc_2018$totalSurveyPop * 100
inc_2018$perc_45k_49.99k <- inc_2018$X45k_to_49.99k / inc_2018$totalSurveyPop * 100
inc_2018$perc_50k_59.99k <- inc_2018$X50k_to_59.99k / inc_2018$totalSurveyPop * 100
inc_2018$perc_60k_74.99k <- inc_2018$X60k_to_74.99k / inc_2018$totalSurveyPop * 100
inc_2018$perc_75k_99.99k <- inc_2018$X75k_99.99k / inc_2018$totalSurveyPop * 100
inc_2018$perc_100k_124.99k <- inc_2018$X100k_to_124.99k / inc_2018$totalSurveyPop * 100
inc_2018$perc_125k_149.99k <- inc_2018$X125k_to_149.99k / inc_2018$totalSurveyPop * 100
inc_2018$perc_150k_199.99k <- inc_2018$X150k_to_199.99k / inc_2018$totalSurveyPop * 100
inc_2018$perc_200k_more <- inc_2018$X200k_or_more / inc_2018$totalSurveyPop * 100

# Percentage of dominant income group
max_inc <- apply(inc_2018[,4:19], 1, max)
perc_inc <- max_inc / inc_2018$totalSurveyPop * 100
inc_2018$max_inc_perc <- perc_inc

# Categorical variable (income)
# Match max percentage to one of the percentages
indices_10k <- which(inc_2018$max_inc_perc == inc_2018$perc_10k_less)
indices_10k_14.99k <- which(inc_2018$max_inc_perc == inc_2018$perc_10k_14.99k)
indices_15k_19.99k <- which(inc_2018$max_inc_perc == inc_2018$perc_15k_19.99k)
indices_20k_24.99k <- which(inc_2018$max_inc_perc == inc_2018$perc_20k_24.99k)
indices_25k_29.99k <- which(inc_2018$max_inc_perc == inc_2018$perc_25k_29.99k)
indices_30k_34.99k <- which(inc_2018$max_inc_perc == inc_2018$perc_30k_34.99k)
indices_35k_39.99k <- which(inc_2018$max_inc_perc == inc_2018$perc_35k_39.99k)
indices_40k_44.99k <- which(inc_2018$max_inc_perc == inc_2018$perc_40k_44.99k)
indices_45k_49.99k <- which(inc_2018$max_inc_perc == inc_2018$perc_45k_49.99k)
indices_50k_59.99k <- which(inc_2018$max_inc_perc == inc_2018$perc_50k_59.99k)
indices_60k_74.99k <- which(inc_2018$max_inc_perc == inc_2018$perc_60k_74.99k)
indices_75k_99.99k <- which(inc_2018$max_inc_perc == inc_2018$perc_75k_99.99k)
indices_100k_124.99k <- which(inc_2018$max_inc_perc == inc_2018$perc_100k_124.99k)
indices_125k_149.99k <- which(inc_2018$max_inc_perc == inc_2018$perc_125k_149.99k)
indices_150k_199.99k <- which(inc_2018$max_inc_perc == inc_2018$perc_150k_199.99k)
indices_200k <- which(inc_2018$max_inc_perc == inc_2018$perc_200k_more)

inc_2018$max_inc_grp[indices_10k] <- "10,000 or less" # or less
inc_2018$max_inc_grp[indices_10k_14.99k] <- "10,000-14,999"
inc_2018$max_inc_grp[indices_15k_19.99k] <- "15,000-19,999"
inc_2018$max_inc_grp[indices_20k_24.99k] <- "20,000-24,999"
inc_2018$max_inc_grp[indices_25k_29.99k] <- "25,000-29,999"
inc_2018$max_inc_grp[indices_30k_34.99k] <- "30,000-34,999"
inc_2018$max_inc_grp[indices_35k_39.99k] <- "35,000-39,999"
inc_2018$max_inc_grp[indices_40k_44.99k] <- "40,000-44,999"
inc_2018$max_inc_grp[indices_45k_49.99k] <- "45,000-49,999"
inc_2018$max_inc_grp[indices_50k_59.99k] <- "50,000-59,999"
inc_2018$max_inc_grp[indices_60k_74.99k] <- "60,000-74,999"
inc_2018$max_inc_grp[indices_75k_99.99k] <- "75,000-99,999"
inc_2018$max_inc_grp[indices_100k_124.99k] <- "100,000-124,999"
inc_2018$max_inc_grp[indices_125k_149.99k] <- "125,000-149,999"
inc_2018$max_inc_grp[indices_150k_199.99k] <- "150,000-199,999"
inc_2018$max_inc_grp[indices_200k] <- "200,000 or more"

inc_2018$max_inc_grp_vec <- factor(inc_2018$max_inc_grp, ordered = TRUE,
                                   levels = c("10,000 or less", "20,000-24,999",
                                              "25,000-29,999","30,000-34,999", 
                                              "35,000-39,999", "40,000-44,999",
                                              "50,000-59,999", "60,000-74,999",
                                              "75,000-99,999", "100,000-124,999",
                                              "125,000-149,999", "150,000-199,999",
                                              "200,000 or more"))

# For 2019 ----
# Create copy of income_2019 
inc_2019 <- income_2019

# Percentage of individuals that belong to each income group
inc_2019$perc_10k_less <- inc_2019$less_than_10k / inc_2019$totalSurveyPop * 100
inc_2019$perc_10k_14.99k <- inc_2019$X10k_to_14.99k / inc_2019$totalSurveyPop * 100
inc_2019$perc_15k_19.99k <- inc_2019$X15k_to_19.99k / inc_2019$totalSurveyPop * 100
inc_2019$perc_20k_24.99k <- inc_2019$X20k_to_24.99k / inc_2019$totalSurveyPop * 100
inc_2019$perc_25k_29.99k <- inc_2019$X25k_to_29.99k / inc_2019$totalSurveyPop * 100
inc_2019$perc_30k_34.99k <- inc_2019$X30k_to_34.99k / inc_2019$totalSurveyPop * 100
inc_2019$perc_35k_39.99k <- inc_2019$X35k_to_39.99k / inc_2019$totalSurveyPop * 100
inc_2019$perc_40k_44.99k <- inc_2019$X40k_to_44.99k / inc_2019$totalSurveyPop * 100
inc_2019$perc_45k_49.99k <- inc_2019$X45k_to_49.99k / inc_2019$totalSurveyPop * 100
inc_2019$perc_50k_59.99k <- inc_2019$X50k_to_59.99k / inc_2019$totalSurveyPop * 100
inc_2019$perc_60k_74.99k <- inc_2019$X60k_to_74.99k / inc_2019$totalSurveyPop * 100
inc_2019$perc_75k_99.99k <- inc_2019$X75k_99.99k / inc_2019$totalSurveyPop * 100
inc_2019$perc_100k_124.99k <- inc_2019$X100k_to_124.99k / inc_2019$totalSurveyPop * 100
inc_2019$perc_125k_149.99k <- inc_2019$X125k_to_149.99k / inc_2019$totalSurveyPop * 100
inc_2019$perc_150k_199.99k <- inc_2019$X150k_to_199.99k / inc_2019$totalSurveyPop * 100
inc_2019$perc_200k_more <- inc_2019$X200k_or_more / inc_2019$totalSurveyPop * 100

# Percentage of dominant income group
max_inc <- apply(inc_2019[,4:19], 1, max)
perc_inc <- max_inc / inc_2019$totalSurveyPop * 100
inc_2019$max_inc_perc <- perc_inc

# Categorical variable (income)
# Match max percentage to one of the percentages
indices_10k <- which(inc_2019$max_inc_perc == inc_2019$perc_10k_less)
indices_10k_14.99k <- which(inc_2019$max_inc_perc == inc_2019$perc_10k_14.99k)
indices_15k_19.99k <- which(inc_2019$max_inc_perc == inc_2019$perc_15k_19.99k)
indices_20k_24.99k <- which(inc_2019$max_inc_perc == inc_2019$perc_20k_24.99k)
indices_25k_29.99k <- which(inc_2019$max_inc_perc == inc_2019$perc_25k_29.99k)
indices_30k_34.99k <- which(inc_2019$max_inc_perc == inc_2019$perc_30k_34.99k)
indices_35k_39.99k <- which(inc_2019$max_inc_perc == inc_2019$perc_35k_39.99k)
indices_40k_44.99k <- which(inc_2019$max_inc_perc == inc_2019$perc_40k_44.99k)
indices_45k_49.99k <- which(inc_2019$max_inc_perc == inc_2019$perc_45k_49.99k)
indices_50k_59.99k <- which(inc_2019$max_inc_perc == inc_2019$perc_50k_59.99k)
indices_60k_74.99k <- which(inc_2019$max_inc_perc == inc_2019$perc_60k_74.99k)
indices_75k_99.99k <- which(inc_2019$max_inc_perc == inc_2019$perc_75k_99.99k)
indices_100k_124.99k <- which(inc_2019$max_inc_perc == inc_2019$perc_100k_124.99k)
indices_125k_149.99k <- which(inc_2019$max_inc_perc == inc_2019$perc_125k_149.99k)
indices_150k_199.99k <- which(inc_2019$max_inc_perc == inc_2019$perc_150k_199.99k)
indices_200k <- which(inc_2019$max_inc_perc == inc_2019$perc_200k_more)

inc_2019$max_inc_grp[indices_10k] <- "10,000 or less" # or less
inc_2019$max_inc_grp[indices_10k_14.99k] <- "10,000-14,999"
inc_2019$max_inc_grp[indices_15k_19.99k] <- "15,000-19,999"
inc_2019$max_inc_grp[indices_20k_24.99k] <- "20,000-24,999"
inc_2019$max_inc_grp[indices_25k_29.99k] <- "25,000-29,999"
inc_2019$max_inc_grp[indices_30k_34.99k] <- "30,000-34,999"
inc_2019$max_inc_grp[indices_35k_39.99k] <- "35,000-39,999"
inc_2019$max_inc_grp[indices_40k_44.99k] <- "40,000-44,999"
inc_2019$max_inc_grp[indices_45k_49.99k] <- "45,000-49,999"
inc_2019$max_inc_grp[indices_50k_59.99k] <- "50,000-59,999"
inc_2019$max_inc_grp[indices_60k_74.99k] <- "60,000-74,999"
inc_2019$max_inc_grp[indices_75k_99.99k] <- "75,000-99,999"
inc_2019$max_inc_grp[indices_100k_124.99k] <- "100,000-124,999"
inc_2019$max_inc_grp[indices_125k_149.99k] <- "125,000-149,999"
inc_2019$max_inc_grp[indices_150k_199.99k] <- "150,000-199,999"
inc_2019$max_inc_grp[indices_200k] <- "200,000 or more"

inc_2019$max_inc_grp_vec <- factor(inc_2019$max_inc_grp, ordered = TRUE,
                                   levels = c("10,000 or less", "20,000-24,999",
                                              "25,000-29,999","30,000-34,999", 
                                              "35,000-39,999", "40,000-44,999",
                                              "50,000-59,999", "60,000-74,999",
                                              "75,000-99,999", "100,000-124,999",
                                              "125,000-149,999", "150,000-199,999",
                                              "200,000 or more"))


# Join each data set with the Seattle shapefile ----
sf_2013 <- merge(seattle_sf, inc_2013, by.x="GEOID10", by.y="GEO_ID")
sf_2014 <- merge(seattle_sf, inc_2014, by.x="GEOID10", by.y="GEO_ID")
sf_2015 <- merge(seattle_sf, inc_2013, by.x="GEOID10", by.y="GEO_ID")
sf_2016 <- merge(seattle_sf, inc_2016, by.x="GEOID10", by.y="GEO_ID")
sf_2017 <- merge(seattle_sf, inc_2017, by.x="GEOID10", by.y="GEO_ID")
sf_2018 <- merge(seattle_sf, inc_2018, by.x="GEOID10", by.y="GEO_ID")
sf_2019 <- merge(seattle_sf, inc_2019, by.x="GEOID10", by.y="GEO_ID")

# Create maps ----

# Write a function to create the map 

make_inc_map <- function(year, sf){
  
  main_map <- ggplot() +
    geom_sf(data = seattle_sf, fill = "white") +
    geom_sf(data = sf, aes(fill = max_inc_grp_vec)) +
    xlim(c(122.35, 122.30)) + 
    ylim(c(47.58, 47.68)) +
    annotation_scale(
      width_hint = 0.4,
      unit_category = "metric",
      style = "bar",
      location = "br"
    ) +
    annotation_north_arrow(
      location = "tl",
      style = north_arrow_fancy_orienteering
    ) + 
    labs(
      title = paste("Income Distribution of Chinatown and Wallingford in", year, sep = " "),
      caption = "The neighborhoods of Chinatown and Wallingford are highlighted in gray.
The northernmost highlighted neighborhood is Wallingford, and the southernmost
highlighted neighborhood is Chinatown.",
      fill = "Income Groups"
    ) + theme_map() +
    blank()
  
  inset_map <- ggplot() +
    geom_sf(data = seattle_sf, fill = "white") +
    geom_sf(data = rel_bg_sf, fill = "grey60") +
    coord_sf(crs = 4326) +
    annotation_scale(
      width_hint = 0.4,
      unit_category = "metric",
      style = "bar",
      location = "bl"
    ) +
    annotation_north_arrow(
      location = "tr",
      style = north_arrow_fancy_orienteering
    ) + labs(
      title = "Map of Seattle",
    ) + 
    theme_void() +
    theme(
      panel.border = element_rect(fill = NA, color = "black", linewidth = 0.5)
    ) +
    blank()
  
  # Create full map 
  map <- ggdraw() +
    draw_plot(main_map) +
    draw_plot(inset_map, x = 0.6, y = 0.4, width = 0.3, height = 0.35)
  
  # Plot map
  plot(map)
  
}