# Load libraries
library(jsonlite)
library(rgdal)
library(sf)

# Source final_project.R
source("final_project.R")

#Load in shape file as seattle_sf
seattle_sf <- read_sf("Census_Block_Groups_2010 (1)")
