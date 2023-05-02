# Aileen Kuang
# Victoria Zhuang 

# Load libraries 
library(stringr)
library(dplyr)

df_1 <- read.csv("Built_Units_Since_2010_Edited.csv")
df_2 <- read.csv("2013_B02001.csv")
df_3 <- read.csv("2014_B02001.csv")
df_4 <- read.csv("2015_B02001.csv")
df_5 <- read.csv("2016_B02001.csv")
df_6 <- read.csv("2017_B02001.csv")
df_7 <- read.csv("2018_B02001.csv")
df_8 <- read.csv("2019_B02001.csv")
df_9 <- read.csv("2020_B02001.csv")

# Data Joining -----------------------------------------------------------------
# You first need to to create a unified dataset (i.e. you need to join your 
# datasets together). This means that the records in your two datasets need to 
# be related some how, either by a shared key or a combination of fields.

# Name data frames
built_units_df <- df_1
dem_2013_df <- df_2
dem_2014_df <- df_3
dem_2015_df <- df_4
dem_2016_df <- df_5
dem_2017_df <- df_6
dem_2018_df <- df_7
dem_2019_df <- df_8
dem_2020_df <- df_9

# Convert GEOID10 and GEOID20 in built_units_df from scientific notation to actual numbers 
built_units_df$built_units_geo10 <- paste("1500000US", built_units_df$GEOID10, sep = "")
built_units_df$built_units_geo20 <- paste("1500000US", built_units_df$GEOID20, sep = "")

# Aggregate dem_2020_df so that it can be joined

# Aggregate built_units so that it can be joined 

# Join all demographic data frames

# Join demographic data frame to built units data frame 

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
