# Aileen Kuang, aileenk@uw.edu
# Victoria Zhuang, vzhuang@uw.edu 

# Load libraries ---------------------------------------------------------------
library(dplyr)
library(stringr)
library(ggplot2)
library(tidyr)


# Load data sets ---------------------------------------------------------------
df_1 <- read.csv("Built_Units_Since_2010_Edited.csv")
df_2 <- read.csv("2013_B02001.csv")
df_3 <- read.csv("2014_B02001.csv")
df_4 <- read.csv("2015_B02001.csv")
df_5 <- read.csv("2016_B02001.csv")
df_6 <- read.csv("2017_B02001.csv")
df_7 <- read.csv("2018_B02001.csv")
df_8 <- read.csv("2019_B02001.csv")

df_10 <- read.csv("2013_income.csv")
df_11 <- read.csv("2014_income.csv")
df_12 <- read.csv("2015_income.csv")
df_13 <- read.csv("2016_income.csv")
df_14 <- read.csv("2017_income.csv")
df_15 <- read.csv("2018_income.csv")
df_16 <- read.csv("2019_income.csv")



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

income_2013 <- df_10
income_2014 <- df_11
income_2015 <- df_12
income_2016 <- df_13
income_2017 <- df_14
income_2018 <- df_15
income_2019 <- df_16

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

# Clean income data 

# Add "Year" column to all income data sets 

income_2013$Year <- 2013
income_2014$Year <- 2014
income_2015$Year <- 2015
income_2016$Year <- 2016
income_2017$Year <- 2017
income_2018$Year <- 2018
income_2019$Year <- 2019

# Delete duplicate rows from all income data sets 

duplicates <- c(4, 5, 6, 10, 11, 12, 20, 21, 24, 25)

income_2013 <- income_2013[-duplicates,]
income_2014 <- income_2014[-duplicates,]
income_2015 <- income_2015[-duplicates,]
income_2016 <- income_2016[-duplicates,]
income_2017 <- income_2017[-duplicates,]
income_2018 <- income_2018[-duplicates,]
income_2019 <- income_2019[-duplicates,]

# Append all income data sets
income_df <- rbind(income_2013, income_2014, income_2015, income_2016, income_2017,
                   income_2018, income_2019)

# Move "Year" column in income_df up
income_df <- income_df %>% relocate(Year, .after = NAME)

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

# Remove observations after 2019 (ROWS)

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

# Join income_df to dem_df and built_units_df 
joined_df <- merge(x=joined_df, y=income_df, by.x = c("GEO_ID", "YEAR_FINAL"), by.y = c("GEO_ID", "Year"))

# Remove extra "NAME" column from joined_d 
joined_df <- joined_df[,-49]


# Data Cleaning ----------------------------------------------------------------
# Once you have created your joined dataset, you should then make sure your 
# dataset is clean and usable. i.e. make sure your columns properly formatted as
# a single CSV file that can be easily readable by R. Make sure your combined 
# dataset doesn't have more than roughly 25,000 rows -- if you have a larger 
# dataset than that I recommend you consider narrowing your dataset down in some 
# way either by filtering or through aggregation.  

# You will then also need to create additional columns in your data set:
# One new categorical variable
# One new continuous/numerical variable 

# Convert demographics columns to numeric type
joined_df$totalEstPop <- as.numeric(unlist(joined_df$totalEstPop))
joined_df$totalEstWhite <- as.numeric(unlist(joined_df$totalEstWhite))
joined_df$totalEstBlack <- as.numeric(unlist(joined_df$totalEstBlack))
joined_df$totalEstAIAN <- as.numeric(unlist(joined_df$totalEstAIAN))
joined_df$totalEstAsian <- as.numeric(unlist(joined_df$totalEstAsian))
joined_df$totalEstNHPI <- as.numeric(unlist(joined_df$totalEstNHPI))
joined_df$totalEstOther <- as.numeric(unlist(joined_df$totalEstOther))
joined_df$totalTwoRaces <- as.numeric(unlist(joined_df$totalTwoRaces))
joined_df$totalTwoRacesIncOther <- as.numeric(unlist(joined_df$totalTwoRacesIncOther))
joined_df$totalTwoRacesExcOther <- as.numeric(unlist(joined_df$totalTwoRacesExcOther))

# Continuous variable (race)

# Percentage of white people, percentage of non-white people, sum of non-white people
# Percent of the dominant group 

# Find the percentage of white people
joined_df$percWhite <- joined_df$totalEstWhite / joined_df$totalEstPop * 100

# Find the sum of non-white people
joined_df$totalEstNonWhite <- joined_df$totalEstBlack + joined_df$totalEstAIAN +
  joined_df$totalEstAsian + joined_df$totalEstNHPI

# Find the percentage of non-white people
joined_df$percNonWhite <- joined_df$totalEstNonWhite / joined_df$totalEstPop * 100

# Percentage of the dominant group 
max_race <- apply(joined_df[,40:48], 1, max)
perc_max_race <- max_race / joined_df$totalEstPop * 100
joined_df$percMaxRace <- perc_max_race

# Continuous variable (income)
# Percentage of individuals that belong to each income group

joined_df$perc_10k_less <- joined_df$less_than_10k / joined_df$totalSurveyPop * 100
joined_df$perc_10k_14.99k <- joined_df$X10k_to_14.99k / joined_df$totalSurveyPop * 100
joined_df$perc_15k_19.99k <- joined_df$X15k_to_19.99k / joined_df$totalSurveyPop * 100
joined_df$perc_20k_24.99k <- joined_df$X20k_to_24.99k / joined_df$totalSurveyPop * 100
joined_df$perc_25k_29.99k <- joined_df$X25k_to_29.99k / joined_df$totalSurveyPop * 100
joined_df$perc_30k_34.99k <- joined_df$X30k_to_34.99k / joined_df$totalSurveyPop * 100
joined_df$perc_35k_39.99k <- joined_df$X35k_to_39.99k / joined_df$totalSurveyPop * 100
joined_df$perc_40k_44.99k <- joined_df$X40k_to_44.99k / joined_df$totalSurveyPop * 100
joined_df$perc_45k_49.99k <- joined_df$X45k_to_49.99k / joined_df$totalSurveyPop * 100
joined_df$perc_50k_59.99k <- joined_df$X50k_to_59.99k / joined_df$totalSurveyPop * 100
joined_df$perc_60k_74.99k <- joined_df$X60k_to_74.99k / joined_df$totalSurveyPop * 100
joined_df$perc_75k_99.99k <- joined_df$X75k_99.99k / joined_df$totalSurveyPop * 100
joined_df$perc_100k_124.99k <- joined_df$X100k_to_124.99k / joined_df$totalSurveyPop * 100
joined_df$perc_125k_149.99k <- joined_df$X125k_to_149.99k / joined_df$totalSurveyPop * 100
joined_df$perc_150k_199.99k <- joined_df$X150k_to_199.99k / joined_df$totalSurveyPop * 100
joined_df$perc_200k_more <- joined_df$X200k_or_more / joined_df$totalSurveyPop * 100

# Percentage of dominant income group 
max_income_grp <- apply(joined_df[,50:65], 1, max)
perc_max_inc <- max_income_grp / joined_df$totalSurveyPop * 100
joined_df$max_inc_perc <- perc_max_inc

# Categorical variable (income)
# Match max percentage to one of the percentages 
# Assign column name to variable (which income group is dominant)

indices_10k <- which(joined_df$max_inc_perc == joined_df$perc_10k_less)
#indices_10k_14.99k <- which(joined_df$max_inc_perc == joined_df$perc_10k_14.99k)
#indices_15k_19.99k <- which(joined_df$max_inc_perc == joined_df$perc_15k_19.99k)
indices_20k_24.99k <- which(joined_df$max_inc_perc == joined_df$perc_20k_24.99k)
#indices_25k_29.99k <- which(joined_df$max_inc_perc == joined_df$perc_25k_29.99k)
#indices_30k_34.99k <- which(joined_df$max_inc_perc == joined_df$perc_30k_34.99k)
#indices_35k_39.99k <- which(joined_df$max_inc_perc == joined_df$perc_35k_39.99k)
#indices_40k_44.99k <- which(joined_df$max_inc_perc == joined_df$perc_40k_44.99k)
#indices_45k_49.99k <- which(joined_df$max_inc_perc == joined_df$perc_45k_49.99k)
indices_50k_59.99k <- which(joined_df$max_inc_perc == joined_df$perc_50k_59.99k)
indices_60k_74.99k <- which(joined_df$max_inc_perc == joined_df$perc_60k_74.99k)
indices_75k_99.99k <- which(joined_df$max_inc_perc == joined_df$perc_75k_99.99k)
indices_100k_124.99k <- which(joined_df$max_inc_perc == joined_df$perc_100k_124.99k)
indices_125k_149.99k <- which(joined_df$max_inc_perc == joined_df$perc_125k_149.99k)
indices_150k_199.99k <- which(joined_df$max_inc_perc == joined_df$perc_150k_199.99k)
indices_200k <- which(joined_df$max_inc_perc == joined_df$perc_200k_more)

# Categorical variable (race)
# Whether the census block group is white or non-white (T/F)

# If percWhite == preRacePercent, assign TRUE to isMaxWhite
joined_df$isMaxWhite <- ifelse(joined_df$percWhite > joined_df$percNonWhite, TRUE, FALSE)



# Create Plots -----------------------------------------------------------------

# Create change over time (built units) plot

# Filter data frame to census tracts in Chinatown (census tracts 90, 91)

# Create mask
chinatown_ct <- joined_df$GEO_ID == "1500000US530330090001" | 
  joined_df$GEO_ID == "1500000US530330090002" | 
  joined_df$GEO_ID == "1500000US530330091001" | 
  joined_df$GEO_ID == "1500000US530330091002"

# Filter data frame for Chinatown
chinatown_filt_df <- joined_df[chinatown_ct,]

# Filter data frame to census tracts in Wallingford (census tracts 50, 51, 52)

# Create mask 
wallingford_ct <- joined_df$GEO_ID == "1500000US530330050001" | 
  joined_df$GEO_ID == "1500000US530330050002" | 
  joined_df$GEO_ID == "1500000US530330050003" | 
  joined_df$GEO_ID == "1500000US530330051001" |
  joined_df$GEO_ID == "1500000US530330051002" |
  joined_df$GEO_ID == "1500000US530330051003" |
  joined_df$GEO_ID == "1500000US530330052001" |
  joined_df$GEO_ID == "1500000US530330052002" |
  joined_df$GEO_ID == "1500000US530330052003" |
  joined_df$GEO_ID == "1500000US530330052004" |
  joined_df$GEO_ID == "1500000US530330052005"

# Filter data frame for Wallingford
wallingford_filt_df <- joined_df[wallingford_ct,]

# Group and summarize data frames by year for Chinatown

chinatown_grp_df <- group_by(chinatown_filt_df, YEAR_FINAL)

bu_per_yr_chinatown <- summarize(chinatown_grp_df, 
                                 units_built = n_distinct(GEO_ID))

# Group and summarize data frames by year for Wallingford 

wallingford_grp_df <- group_by(wallingford_filt_df, YEAR_FINAL)

bu_per_yr_wallingford <- summarize(wallingford_grp_df, 
                                   units_built = n_distinct(GEO_ID))

# Create Chinatown bar graph
bar_bu_chinatown <- ggplot(data = bu_per_yr_chinatown, aes(x = YEAR_FINAL, y = units_built)) +
  geom_bar(stat = "identity") + 
  geom_smooth(method=lm, se=FALSE)

plot(bar_bu_chinatown)

# Create Wallingford bar graph
bar_bu_wallingford <- ggplot(data = bu_per_yr_wallingford, aes(x = YEAR_FINAL, y = units_built)) +
  geom_bar(stat = "identity") + 
  geom_smooth(method=lm, se=FALSE)

plot(bar_bu_wallingford)

# Create demographics plot 

# Group and summarize data frames by year 

chinatown_grp_df_2 <- group_by(chinatown_filt_df, YEAR_FINAL)

nonwhite_chinatown_df <- summarize(chinatown_grp_df_2,
                                   perc_nonwhite = mean(percNonWhite))

bar_nonwhite_chinatown <- ggplot(nonwhite_chinatown_df, aes(x = YEAR_FINAL, y = perc_nonwhite)) + 
  geom_bar(stat = "identity") + 
  coord_flip() + 
  labs(
    title = "Percentage of Non-White Residents in Chinatown (2013-2018)",
    x = "Year",
    y = "Percentage"
  )

plot(bar_nonwhite_chinatown)

wallingford_grp_df_2 <- group_by(wallingford_filt_df, YEAR_FINAL)

nonwhite_wallingford_df <- summarize(wallingford_grp_df_2,
                                     perc_nonwhite = mean(percNonWhite))

bar_nonwhite_wallingford <- ggplot(nonwhite_wallingford_df, aes(x = YEAR_FINAL, y = perc_nonwhite)) + 
  geom_bar(stat = "identity") + 
  geom_smooth(method=lm, se=FALSE)

plot(bar_nonwhite_wallingford)

#Find percentage of Black residents in all populations
joined_df$percBlack <- joined_df$totalEstBlack / joined_df$totalEstPop *100

#Find percentage of Asian residents in all populations 
joined_df$percAsian <- joined_df$totalEstAsian/ joined_df$totalEstPop * 100 

chinatown_filt_df$percAsian <- joined_df$percAsian[chinatown_ct]
#Find percentage of AIAN residents in all populations 
joined_df$percAIAN <- joined_df$totalEstAIAN/ joined_df$totalEstPop * 100 

#Find percentage of NHPI residents in all populations 
joined_df$percNHPI <- joined_df$totalEstNHPI/ joined_df$totalEstPop * 100

#Find percentage of other residents in all populations 
joined_df$percOther <- joined_df$totalEstOther / joined_df$totalEstPop * 100

#Bar plot for Asian demographic in Chinatown 

# Group by and summarize 
chinatown_asian_dem_df <- group_by(chinatown_filt_df, YEAR_FINAL) 

asian_chinatown_df <- summarize(chinatown_asian_dem_df, 
                                perc_asian = mean(percAsian))
bar_asian_chinatown <- ggplot(data = asian_chinatown_df, aes(x = YEAR_FINAL, y = perc_asian)) + 
  geom_bar(stat = "identity") + 
  geom_smooth(method=lm, se=FALSE)

plot(bar_asian_chinatown)
