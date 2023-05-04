# Aileen Kuang, aileenk@uw.edu
# Victoria Zhuang, vzhuang@uw.edu 

# Load libraries 
library(dplyr)
library(stringr)
library(ggplot2)
library(tidyr)

# Load data sets  
df_1 <- read.csv("Built_Units_Since_2010_Edited.csv")
df_2 <- read.csv("2013_B02001.csv")
df_3 <- read.csv("2014_B02001.csv")
df_4 <- read.csv("2015_B02001.csv")
df_5 <- read.csv("2016_B02001.csv")
df_6 <- read.csv("2017_B02001.csv")
df_7 <- read.csv("2018_B02001.csv")
df_8 <- read.csv("2019_B02001.csv")

# Data Joining -----------------------------------------------------------------

# You first need to to create a unified dataset (i.e. you need to join your 
# datasets together). This means that the records in your two data sets need to 
# be related some how, either by a shared key or a combination of fields.

# Create duplicates of data frames 
built_units_df <- df_1
dem_2013_df <- df_2
dem_2014_df <- df_3
dem_2015_df <- df_4
dem_2016_df <- df_5
dem_2017_df <- df_6
dem_2018_df <- df_7
dem_2019_df <- df_8

# Convert GEOID10 and GEOID20 in built_units_df from scientific notation to actual numbers 
built_units_df$built_units_geo10 <- paste("1500000US", built_units_df$GEOID10, sep = "")
built_units_df$built_units_geo20 <- paste("1500000US", built_units_df$GEOID20, sep = "")

# Edit column names and remove unnecessary columns for 2013-2019 data sets 

# For 2013:
dem_2013_df <- rename(dem_2013_df, totalEstPop = B02001_001E, 
                      totalEstWhite = B02001_002E,
                      totalEstBlack = B02001_003E,
                      totalEstAIAN = B02001_004E,
                      totalEstAsian = B02001_005E,
                      totalEstNHPI = B02001_006E,
                      totalEstOther = B02001_007E,
                      totalTwoRaces = B02001_008E,
                      totalTwoRacesIncOther = B02001_009E,
                      totalTwoRacesExcOther = B02001_010E)

dem_2013_df <- dem_2013_df[, -c(4, 5, 6, 8, 9, 10, 12, 13, 14, 16, 17, 18, 20, 21, 22, 24, 25, 26, 
                                28, 29, 30, 32, 33, 34, 36, 37, 38, 40, 41, 42, 43)]

# For 2014: 
dem_2014_df <- rename(dem_2014_df, totalEstPop = B02001_001E, 
                      totalEstWhite = B02001_002E,
                      totalEstBlack = B02001_003E,
                      totalEstAIAN = B02001_004E,
                      totalEstAsian = B02001_005E,
                      totalEstNHPI = B02001_006E,
                      totalEstOther = B02001_007E,
                      totalTwoRaces = B02001_008E,
                      totalTwoRacesIncOther = B02001_009E,
                      totalTwoRacesExcOther = B02001_010E)

dem_2014_df <- dem_2014_df[, -c(4, 5, 6, 8, 9, 10, 12, 13, 14, 16, 17, 18, 20, 21, 22, 24, 25, 26, 
                                28, 29, 30, 32, 33, 34, 36, 37, 38, 40, 41, 42, 43)]

# For 2015:
dem_2015_df <- rename(dem_2015_df, totalEstPop = B02001_001E, 
                      totalEstWhite = B02001_002E,
                      totalEstBlack = B02001_003E,
                      totalEstAIAN = B02001_004E,
                      totalEstAsian = B02001_005E,
                      totalEstNHPI = B02001_006E,
                      totalEstOther = B02001_007E,
                      totalTwoRaces = B02001_008E,
                      totalTwoRacesIncOther = B02001_009E,
                      totalTwoRacesExcOther = B02001_010E)

dem_2015_df <- dem_2015_df[, -c(4, 5, 6, 8, 9, 10, 12, 13, 14, 16, 17, 18, 20, 21, 22, 24, 25, 26, 
                                28, 29, 30, 32, 33, 34, 36, 37, 38, 40, 41, 42, 43)]

# For 2016:
dem_2016_df <- rename(dem_2016_df, totalEstPop = B02001_001E, 
                      totalEstWhite = B02001_002E,
                      totalEstBlack = B02001_003E,
                      totalEstAIAN = B02001_004E,
                      totalEstAsian = B02001_005E,
                      totalEstNHPI = B02001_006E,
                      totalEstOther = B02001_007E,
                      totalTwoRaces = B02001_008E,
                      totalTwoRacesIncOther = B02001_009E,
                      totalTwoRacesExcOther = B02001_010E)

dem_2016_df <- dem_2016_df[, -c(4, 5, 6, 8, 9, 10, 12, 13, 14, 16, 17, 18, 20, 21, 22, 24, 25, 26, 
                                28, 29, 30, 32, 33, 34, 36, 37, 38, 40, 41, 42, 43)]

# For 2017:
dem_2017_df <- rename(dem_2017_df, totalEstPop = B02001_001E, 
                      totalEstWhite = B02001_002E,
                      totalEstBlack = B02001_003E,
                      totalEstAIAN = B02001_004E,
                      totalEstAsian = B02001_005E,
                      totalEstNHPI = B02001_006E,
                      totalEstOther = B02001_007E,
                      totalTwoRaces = B02001_008E,
                      totalTwoRacesIncOther = B02001_009E,
                      totalTwoRacesExcOther = B02001_010E)

dem_2017_df <- dem_2017_df[, -c(4, 5, 6, 8, 9, 10, 12, 13, 14, 16, 17, 18, 20, 21, 22, 24, 25, 26, 
                                28, 29, 30, 32, 33, 34, 36, 37, 38, 40, 41, 42, 43)]

# For 2018:
dem_2018_df <- rename(dem_2018_df, totalEstPop = B02001_001E, 
                      totalEstWhite = B02001_002E,
                      totalEstBlack = B02001_003E,
                      totalEstAIAN = B02001_004E,
                      totalEstAsian = B02001_005E,
                      totalEstNHPI = B02001_006E,
                      totalEstOther = B02001_007E,
                      totalTwoRaces = B02001_008E,
                      totalTwoRacesIncOther = B02001_009E,
                      totalTwoRacesExcOther = B02001_010E)

dem_2018_df <- dem_2018_df[, -c(4, 5, 6, 8, 9, 10, 12, 13, 14, 16, 17, 18, 20, 21, 22, 24, 25, 26, 
                                28, 29, 30, 32, 33, 34, 36, 37, 38, 40, 41, 42, 43)]

# For 2019:
dem_2019_df <- rename(dem_2019_df, totalEstPop = B02001_001E, 
                      totalEstWhite = B02001_002E,
                      totalEstBlack = B02001_003E,
                      totalEstAIAN = B02001_004E,
                      totalEstAsian = B02001_005E,
                      totalEstNHPI = B02001_006E,
                      totalEstOther = B02001_007E,
                      totalTwoRaces = B02001_008E,
                      totalTwoRacesIncOther = B02001_009E,
                      totalTwoRacesExcOther = B02001_010E)

dem_2019_df <- dem_2019_df[, -c(4, 5, 6, 8, 9, 10, 12, 13, 14, 16, 17, 18, 20, 21, 22, 24, 25, 26, 
                                28, 29, 30, 32, 33, 34, 36, 37, 38, 40, 41, 42, 43)]

# Add "Year" column to all the individual demographic data sets 
dem_2013_df$Year <- 2013
dem_2014_df$Year <- 2014
dem_2015_df$Year <- 2015
dem_2016_df$Year <- 2016
dem_2017_df$Year <- 2017
dem_2018_df$Year <- 2018
dem_2019_df$Year <- 2019

# Remove first row from each data set
dem_2013_df <- dem_2013_df[-1,]
dem_2014_df <- dem_2014_df[-1,]
dem_2015_df <- dem_2015_df[-1,]
dem_2016_df <- dem_2016_df[-1,]
dem_2017_df <- dem_2017_df[-1,]
dem_2018_df <- dem_2018_df[-1,]
dem_2019_df <- dem_2019_df[-1,]

# Filter data sets for relevant census tracts: 
# Chinatown: 90 & 91
# Wallingford: 50, 51, 52 

# Find indices of relevant census tracts 
tract_90 <- which(str_detect(dem_2013_df$NAME, "Census Tract 90"))
tract_91 <- which(str_detect(dem_2013_df$NAME, "Census Tract 91"))
tract_50 <- which(str_detect(dem_2013_df$NAME, "Census Tract 50"))
tract_51 <- which(str_detect(dem_2013_df$NAME, "Census Tract 51"))
tract_52 <- which(str_detect(dem_2013_df$NAME, "Census Tract 52"))

# Combine indices into one vector: rel_tracts
rel_tracts <- c(tract_50, tract_51, tract_52, tract_90, tract_91)

# Use rel_tracts to filter down each data set 
dem_2013_df <- dem_2013_df[rel_tracts,]
dem_2014_df <- dem_2014_df[rel_tracts,]
dem_2015_df <- dem_2015_df[rel_tracts,]
dem_2016_df <- dem_2016_df[rel_tracts,]
dem_2017_df <- dem_2017_df[rel_tracts,]
dem_2018_df <- dem_2018_df[rel_tracts,]
dem_2019_df <- dem_2019_df[rel_tracts,]

# Append all demographics data sets 
dem_df <- rbind(dem_2013_df, dem_2014_df, dem_2015_df, dem_2016_df, dem_2017_df,
                dem_2018_df, dem_2019_df)

# Move "Year" column in dem_df up
dem_df <- dem_df %>% relocate(Year, .after = NAME)

# Clean built_units_df 

# Move updated GEOID10 and GEOID20 to the beginning of the data set
built_units_df <- built_units_df %>% relocate(built_units_geo20)
built_units_df <- built_units_df %>% relocate(built_units_geo10)

# Remove unnecessary columns from built_units_df (X, Y)
unnecessary <- c(3, 4, 6, 7, 10, 17, 20, 21, 23, 34, 35, 36, 38, 39, 40, 41, 42, 
                 44, 45, 46, 53, 54, 55)

built_units_df <- built_units_df[, -unnecessary]

# Rename/shorten GEOID columns 
colnames(built_units_df)[1] = "GEO_ID"
colnames(built_units_df)[2] = "GEOID20"

# Remove unnecessary rows from built_units_df by filtering down to relevant 
# GEO IDs

# Write a function to find the index of the GEO ID in built_units_df 
find_geo_id <- function(GEOID){
  mask <- str_detect(built_units_df$GEO_ID, GEOID)
  which(mask == TRUE)
}

# Find indices of relevant tracts using find_geo_id 
rel_indices <- c(find_geo_id("1500000US530330050001"),
                 find_geo_id("1500000US530330050002"),
                 find_geo_id("1500000US530330050003"),
                 find_geo_id("1500000US530330051001"),
                 find_geo_id("1500000US530330051002"),
                 find_geo_id("1500000US530330051003"),
                 find_geo_id("1500000US530330052001"),
                 find_geo_id("1500000US530330052002"),
                 find_geo_id("1500000US530330052003"),
                 find_geo_id("1500000US530330052004"),
                 find_geo_id("1500000US530330052005"),
                 find_geo_id("1500000US530330090001"),
                 find_geo_id("1500000US530330090002"),
                 find_geo_id("1500000US530330091001"),
                 find_geo_id("1500000US530330091002")
)

# Filter built units by rel_indices
built_units_df <- built_units_df[rel_indices,]

# Remove GEOID20 and permit number
built_units_df <- built_units_df[, -c(2, 4)]

# Remove observations after 2019

# Find indices of observations from 2020-2023
obs_2020 <- which(built_units_df$YEAR_FINAL == 2020)
obs_2021 <- which(built_units_df$YEAR_FINAL == 2021)
obs_2022 <- which(built_units_df$YEAR_FINAL == 2022)
obs_2023 <- which(built_units_df$YEAR_FINAL == 2023)

# Collect all observations into a vector
obs_all <- c(obs_2020, obs_2021, obs_2022, obs_2023)

# Remove obs_all from built_units df
built_units_df <- built_units_df[-obs_all,]

# Edit GEO_ID column so that it shows only the first 21 characters 
# nchar(1500000US530330052002) = 21
trimmed_geo_id <- strtrim(built_units_df$GEO_ID, 21)
built_units_df$GEO_ID <- trimmed_geo_id

# Join dem_df to built_units_df
joined_df <- merge(x=built_units_df, y=dem_df, by.x=c("GEO_ID", "YEAR_FINAL"), by.y=c("GEO_ID", "Year"))

# Move "Year" column to the beginning of the joined df
joined_df <- joined_df %>% relocate(NAME.y, .after = GEO_ID)

# Data Cleaning ----------------------------------------------------------------
# Once you have created your joined dataset, you should then make sure your 
# dataset is clean and usable. i.e. make sure your columns properly formatted as
# a single CSV file that can be easily readable by R. Make sure your combined 
# dataset doesn't have more than roughly 25,000 rows -- if you have a larger 
# dataset than that I recommend you consider narrowing your dataset down in some 
# way either by filtering or through aggregation.  
# ------------------------------------------------------------------------------
# You will then also need to create additional columns in your data set:
# One new categorical variable
# One new continuous/numerical variable 

# Numerical variable: demographic percentages in each block group
maxrace <- pmax(joined_df$totalEstWhite, 
                joined_df$totalEstBlack,
                joined_df$totalEstAIAN,
                joined_df$totalEstAsian,
                joined_df$totalEstNHPI,
                joined_df$totalEstOther,
                joined_df$totalTwoRaces)

joined_df$Pre_race <- maxrace/c(select(joined_df, totalEstPop))

# Categorical variable: check which percentage is the highest and assign 
# that census tract "Predominantly..." (ex. "Predominantly Black")
# if (maxrace ==)

# Must create at least one summarization data frame 