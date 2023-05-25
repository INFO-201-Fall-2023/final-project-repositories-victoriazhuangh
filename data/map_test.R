# Load libraries
library(jsonlite)
library(rgdal)
library(sf)

# Source final_project.R
source("final_project.R")

#Load in shape file as seattle_sf
seattle_sf <- read_sf("Census_Block_Groups_2010 (1)")

#Create copy of df_1 to join to seattle_sf

df_1_copy <- df_1

# Edit GEOID10 col in df_1_copy
df_1_copy$GEOID10 <- paste("1500000US", df_1_copy$GEOID10, sep = "")

# Filter down to relevant observations (year)

# Find indices of observations from 2020-2023
in_2020 <- which(df_1_copy$YEAR_FINAL == 2020)
in_2021 <- which(df_1_copy$YEAR_FINAL == 2021)
in_2022 <- which(df_1_copy$YEAR_FINAL == 2022)
in_2023 <- which(df_1_copy$YEAR_FINAL == 2023)

# Collect all observations into a vector
in_all <- c(in_2020, in_2021, in_2022, in_2023)

#Remove observations
df_1_copy <- df_1_copy[-in_all,]

# Filter down to relevant observations (block groups)

find_bg <- function(GEOID){
  mask <- str_detect(df_1_copy$GEOID10, GEOID)
  which(mask == TRUE)
}

# Find indices of relevant tracts using find_bg
obs_indices <- c(find_bg("1500000US530330050001"),
                 find_bg("1500000US530330050002"),
                 find_bg("1500000US530330050003"),
                 find_bg("1500000US530330051001"),
                 find_bg("1500000US530330051002"),
                 find_bg("1500000US530330051003"),
                 find_bg("1500000US530330052001"),
                 find_bg("1500000US530330052002"),
                 find_bg("1500000US530330052003"),
                 find_bg("1500000US530330052004"),
                 find_bg("1500000US530330052005"),
                 find_bg("1500000US530330090001"),
                 find_bg("1500000US530330090002"),
                 find_bg("1500000US530330091001"),
                 find_bg("1500000US530330091002")
)

#Filter by obs_indices
long_lat_col <- df_1_copy[obs_indices, c(34, 22, 42, 43)]

trim_geoid10 <- strtrim(long_lat_col$GEOID10, 21)
long_lat_col$GEOID10 <- trim_geoid10

#Join w/ dem_df
mapping_df <- merge(long_lat_col, dem_df, by.x=c("GEOID10", "YEAR_FINAL"), 
                    by.y=c("GEO_ID", "Year"))

#Join w/ income_df
mapping_df <- merge(mapping_df, income_df, by.x=c("GEOID10", "YEAR_FINAL"), 
                    by.y=c("GEO_ID", "Year"))

# Convert columns to numeric
mapping_df$totalEstPop <- as.numeric(unlist(mapping_df$totalEstPop))
mapping_df$totalEstWhite <- as.numeric(unlist(mapping_df$totalEstWhite))
mapping_df$totalEstBlack <- as.numeric(unlist(mapping_df$totalEstBlack))
mapping_df$totalEstAIAN <- as.numeric(unlist(mapping_df$totalEstAIAN))
mapping_df$totalEstAsian <- as.numeric(unlist(mapping_df$totalEstAsian))
mapping_df$totalEstNHPI <- as.numeric(unlist(mapping_df$totalEstNHPI))
mapping_df$totalEstOther <- as.numeric(unlist(mapping_df$totalEstOther))
mapping_df$totalTwoRaces <- as.numeric(unlist(mapping_df$totalTwoRaces))
mapping_df$totalTwoRacesIncOther <- as.numeric(unlist(mapping_df$totalTwoRacesIncOther))
mapping_df$totalTwoRacesExcOther <- as.numeric(unlist(mapping_df$totalTwoRacesExcOther))

#Edit GEOID10 column in seattle_sf
seattle_sf$GEOID10 <- paste("1500000US", seattle_sf$GEOID10, sep = "")

#Join seattle_sf to mapping_df 
new_sf <- merge(seattle_sf, mapping_df, by.x="GEOID10", by.y="GEOID10")

# Create 2013 df
sf_2013 <- new_sf[new_sf$YEAR_FINAL == 2014,]

sf_2013$percNonWhite <- ((sf_2013$totalEstPop - sf_2013$totalEstWhite) / sf_2013$totalEstPop) * 100

#Make map
main_map <- ggplot() + 
  geom_sf(data = seattle_sf) +
  geom_sf(aes(fill = percNonWhite), data = sf_2013) + 
  scale_fill_continuous(low = "#56B1F7", high = "#132B43") + 
  labs(
    fill = "Percentage of Non-White Individuals"
 ) 

plot(main_map)

