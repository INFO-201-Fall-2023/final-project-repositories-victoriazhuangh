# Aileen Kuang
# Victoria Zhuang 

# Load libraries 
library(stringr)
library(dplyr)

built_units_df <- read.csv("Built_Units_Since_2010_Edited.csv")
dem_2013_df <- read.csv("2013_B02001.csv")
dem_2014_df <- read.csv("2014_B02001.csv")
dem_2015_df <- read.csv("2015_B02001.csv")
dem_2016_df <- read.csv("2016_B02001.csv")
dem_2017_df <- read.csv("2017_B02001.csv")
dem_2018_df <- read.csv("2018_B02001.csv")
dem_2019_df <- read.csv("2019_B02001.csv")
dem_2020_df <- read.csv("2020_B02001.csv")

# Data Joining -----------------------------------------------------------------
# You first need to to create a unified dataset (i.e. you need to join your 
# datasets together). This means that the records in your two datasets need to 
# be related some how, either by a shared key or a combination of fields.

# Convert GEOID10 and GEOID20 in built_units_df from scientific notation to actual
# numbers in Excel 

format(built_units_df$GEOID10, scientific = FALSE)

# First, aggregate dem_2020_df so that it can be joined

# Aggregate built_units so that it can be joined 

# Can join dem_2013_df to dem_2020_df by GEOID

# Join dem_2020_df to joined dem_20XX_df by GEOID

# Join dem_df to built_units by ??

# Data Cleaning ----------------------------------------------------------------
# Once you have created your joined dataset, you should then make sure your 
# dataset is clean and usable. i.e. make sure your columns properly formatted as
# a single CSV file that can be easily readable by R. Make sure your combined 
# dataset doesn't have more than roughly 25,000 rows -- if you have a larger 
# dataset than that I recommend you consider narrowing your dataset down in some 
# way either by filtering or through aggregation.  
# ------------------------------------------------------------------------------
# You will then also need to create additional columns in your datase:
# Must create at least one new categorical variable
# Must create at least one new continuous/numerical variable
# Must create at least one summarization data frame 
