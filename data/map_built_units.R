# Source final_project.R file for data ----
source("final_project.R")

# Load necessary libraries ----
library(sf)
library(jsonlite)
library(rgdal)


# Load Seattle shape file ----
seattle_shp <- read_sf("Census_Block_Groups_2010 (1)")

# Create copy of joined_df ----
map_bu_df <- joined_df