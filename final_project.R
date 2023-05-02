# Aileen Kuang, aileenk@uw.edu
# Victoria Zhuang 

# Load libraries 
library(dplyr)
library(stringr)
library(ggplot2)

# Load data sets  
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
# datasets together). This means that the records in your two data sets need to 
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

# Edit column names and remove unnecessary columns for 2013-2020 data sets 
  
# For 2013:
dem_2013_df <- rename(dem_2013_df, totalEstPop2013 = B02001_001E, 
                      totalEstWhite2013 = B02001_002E,
                      totalEstBlack2013 = B02001_003E,
                      totalEstAIAN2013 = B02001_004E,
                      totalEstAsian2013 = B02001_005E,
                      totalEstNHPI2013 = B02001_006E,
                      totalEstOther2013 = B02001_007E,
                      totalTwoRaces2013 = B02001_008E,
                      totalTwoRacesIncOther2013 = B02001_009E,
                      totalTwoRacesExcOther2013 = B02001_010E)

col_2013_df <- data.frame(colnames(dem_2013_df))

col_mask <- col_2013_df == "totalEstPop2013" | col_2013_df == "totalEstWhite2013" | 
  col_2013_df == "totalEstBlack2013" | col_2013_df == "totalEstAIAN2013" |
  col_2013_df == "totalEstAsian2013" | col_2013_df == "totalEstNHPI2013" |
  col_2013_df == "totalEstOther2013" | col_2013_df == "totalTwoRaces2013" |
  col_2013_df == "totalTwoRacesIncOther2013" | col_2013_df == "totalTwoRacesExcOther2013"

col_filtered <- col_2013_df[col_mask == FALSE]

# For 2014: 
dem_2014_df <- rename(dem_2014_df, totalEstPop2014 = B02001_001E, 
                      totalEstWhite2014 = B02001_002E,
                      totalEstBlack2014 = B02001_003E,
                      totalEstAIAN2014 = B02001_004E,
                      totalEstAsian2014 = B02001_005E,
                      totalEstNHPI2014 = B02001_006E,
                      totalEstOther2014 = B02001_007E,
                      totalTwoRaces2014 = B02001_008E,
                      totalTwoRacesIncOther2014 = B02001_009E,
                      totalTwoRacesExcOther2014 = B02001_010E)

# For 2015:
dem_2015_df <- rename(dem_2015_df, totalEstPop2015 = B02001_001E, 
                      totalEstWhite2015 = B02001_002E,
                      totalEstBlack2015 = B02001_003E,
                      totalEstAIAN2015 = B02001_004E,
                      totalEstAsian2015 = B02001_005E,
                      totalEstNHPI2015 = B02001_006E,
                      totalEstOther2015 = B02001_007E,
                      totalTwoRaces2015 = B02001_008E,
                      totalTwoRacesIncOther2015 = B02001_009E,
                      totalTwoRacesExcOther2015 = B02001_010E)

# For 2016:
dem_2016_df <- rename(dem_2016_df, totalEstPop2016 = B02001_001E, 
                      totalEstWhite2016 = B02001_002E,
                      totalEstBlack2016 = B02001_003E,
                      totalEstAIAN2016 = B02001_004E,
                      totalEstAsian2016 = B02001_005E,
                      totalEstNHPI2016 = B02001_006E,
                      totalEstOther2016 = B02001_007E,
                      totalTwoRaces2016 = B02001_008E,
                      totalTwoRacesIncOther2016 = B02001_009E,
                      totalTwoRacesExcOther2016 = B02001_010E)

# For 2017:
dem_2017_df <- rename(dem_2017_df, totalEstPop2017 = B02001_001E, 
                      totalEstWhite2017 = B02001_002E,
                      totalEstBlack2017 = B02001_003E,
                      totalEstAIAN2017 = B02001_004E,
                      totalEstAsian2017 = B02001_005E,
                      totalEstNHPI2017 = B02001_006E,
                      totalEstOther2017 = B02001_007E,
                      totalTwoRaces2017 = B02001_008E,
                      totalTwoRacesIncOther2017 = B02001_009E,
                      totalTwoRacesExcOther2017 = B02001_010E)

# For 2018:
dem_2018_df <- rename(dem_2018_df, totalEstPop2018 = B02001_001E, 
                      totalEstWhite2018 = B02001_002E,
                      totalEstBlack2018 = B02001_003E,
                      totalEstAIAN2018 = B02001_004E,
                      totalEstAsian2018 = B02001_005E,
                      totalEstNHPI2018 = B02001_006E,
                      totalEstOther2018 = B02001_007E,
                      totalTwoRaces2018 = B02001_008E,
                      totalTwoRacesIncOther2018 = B02001_009E,
                      totalTwoRacesExcOther2018 = B02001_010E)

# For 2019:
dem_2019_df <- rename(dem_2019_df, totalEstPop2019 = B02001_001E, 
                      totalEstWhite2019 = B02001_002E,
                      totalEstBlack2019 = B02001_003E,
                      totalEstAIAN2019 = B02001_004E,
                      totalEstAsian2019 = B02001_005E,
                      totalEstNHPI2019 = B02001_006E,
                      totalEstOther2019 = B02001_007E,
                      totalTwoRaces2019 = B02001_008E,
                      totalTwoRacesIncOther2019 = B02001_009E,
                      totalTwoRacesExcOther2019 = B02001_010E)

# For 2020: 
dem_2020_df <- rename(dem_2020_df, totalEstPop2020 = B02001_001E, 
                      totalEstWhite2020 = B02001_002E,
                      totalEstBlack2020 = B02001_003E,
                      totalEstAIAN2020 = B02001_004E,
                      totalEstAsian2020 = B02001_005E,
                      totalEstNHPI2020 = B02001_006E,
                      totalEstOther2020 = B02001_007E,
                      totalTwoRaces2020 = B02001_008E,
                      totalTwoRacesIncOther2020 = B02001_009E,
                      totalTwoRacesExcOther2020 = B02001_010E)

# Join 2013-2019 data sets

#dem_list_df <- list(dem_2013_df, dem_2014_df, dem_2015_df, dem_2016_df, dem_2017_df, 
                    #dem_2018_df, dem_2019_df)

#Reduce(function(x, y) merge(x, y, all=FALSE), dem_list_df)

#dem_df <- dem_list_df %>% reduce(inner_join, by='GEO_ID')

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
