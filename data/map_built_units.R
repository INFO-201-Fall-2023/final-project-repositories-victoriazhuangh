# Load necessary libraries ----
library(rgdal)
library(sf)
library(jsonlite)
library(cowplot)
library(ggsn)
library(ggspatial)
library(plotly)

# Source final_project.R file for data ----
source("final_project.R")

# Load and edit Seattle shape file ----
seattle_sf <- read_sf("Census_Block_Groups_2010 (1)")
seattle_sf$GEOID10 <- paste("1500000US", seattle_sf$GEOID10, sep = "")

# Create copy of joined_df ----
map_bu_df <- joined_df

# Extract necessary columns from map_bu_df ----
temp_map_df <- map_bu_df[, c(1, 2, 3, 4, 6:9, 13)]

# Join temp_map_df with seattle_sf ----
map_sf <- merge(seattle_sf, temp_map_df, by.x="GEOID10", by.y="GEO_ID")

# Create a shapefile with just block groups from Chinatown and Wallingford ----

#Make masks
bg_indices <- seattle_sf$GEOID10 == "1500000US530330090001" |
  seattle_sf$GEOID10  == "1500000US530330090002" |
  seattle_sf$GEOID10 == "1500000US530330091001" |
  seattle_sf$GEOID10 == "1500000US530330091002" | 
  seattle_sf$GEOID10 == "1500000US530330050001" |
  seattle_sf$GEOID10 == "1500000US530330050002" |
  seattle_sf$GEOID10 == "1500000US530330050003" |
  seattle_sf$GEOID10 == "1500000US530330051001" |
  seattle_sf$GEOID10 == "1500000US530330051002" |
  seattle_sf$GEOID10 == "1500000US530330051003" |
  seattle_sf$GEOID10 == "1500000US530330052001" |
  seattle_sf$GEOID10 == "1500000US530330052002" |
  seattle_sf$GEOID10 == "1500000US530330052003" |
  seattle_sf$GEOID10 == "1500000US530330052004" |
  seattle_sf$GEOID10 == "1500000US530330052005"

# Create data frame
rel_bg_sf <- seattle_sf[bg_indices,]

# Write a function to create a new data frame that has columns summarizing net 
# units, demo units, and new units
aggregate <- function(year){
  # Create a new data frame that only includes observations from that year
  year_sf <- map_sf[map_sf$YEAR_FINAL == year,]
  # Aggregate year_sf by block group
  grp_sf <- group_by(year_sf, GEOID10)
  net_sf <- summarize(grp_sf,
                      bg_net_units = sum(NET_UNITS),
                      bg_demo_units = sum(DEMO),
                      bg_new_units = sum(NEW))
  return(net_sf)
}

# MAKE MAPS ----

# Create a proportional symbol map w/ tooltips 
# Need to create a map for every year from 2013-2019 (2013, 2014, 2015, 2016, 
# 2017, 2018, 2019) displaying net units built (NET_UNITS) for each block group

# Create new theme 
theme_map <- function (base_size = 11, base_family = "") {
  theme_void() %+replace% 
    theme(
      plot.title = element_text(face = "bold", hjust = 0, margin=margin(5,0,5,0)),
      plot.caption = element_text(hjust = 0, margin=margin(5,0,5,0)),
      panel.border = element_rect(fill = NA, color = "black", linewidth = 0.5)
    )
}

# Write a function to create a proportional symbols map given the year and shapefile
make_map_new <- function(year, sf){
  
  # Create centroids 
  centroids <- st_centroid(sf, of_largest_polygon = TRUE)
  
  # Create main map
  main_map <- ggplot() + 
    geom_sf(data = seattle_sf, fill = "white") +
    geom_sf(data = rel_bg_sf, fill = "grey60") +
    geom_sf(data = centroids, 
            pch = 21,
            aes(size = bg_new_units),
            fill = alpha("red", 0.7),
            col = "grey20") +
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
      title = paste("Net Units Built in Chinatown and Wallingford in", year, sep = " "),
      caption = "The neighborhoods of Chinatown and Wallingford are highlighted in gray.
The northernmost highlighted neighborhood is Wallingford, and the southernmost
highlighted neighborhood is Chinatown.",
      size = "Units Built"
    ) + theme_map() +
    blank()
  
  # Create inset map 
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
    ) + theme_void() +
    labs(
      title = "Map of Seattle"
    ) + 
    theme(
      panel.border = element_rect(fill = NA, color = "black", linewidth = 0.5)
    ) +
    blank() 
  
  # Create full map 
  map <- ggdraw() +
    draw_plot(main_map) +
    draw_plot(inset_map, x = 0.5, y = 0.4, width = 0.3, height = 0.35)
  
  # Plot map
  plot(map)
}

make_map_dem <- function(year, sf){
  
  # Create centroids 
  centroids <- st_centroid(sf, of_largest_polygon = TRUE)
  
  # Create main map
  main_map <- ggplot() + 
    geom_sf(data = seattle_sf, fill = "white") +
    geom_sf(data = rel_bg_sf, fill = "grey60") +
    geom_sf(data = centroids, 
            pch = 21,
            aes(size = bg_demo_units),
            fill = alpha("red", 0.7),
            col = "grey20") +
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
      title = paste("Net Units Demolished in Chinatown and Wallingford in", year, sep = " "),
      caption = "The neighborhoods of Chinatown and Wallingford are highlighted in gray.
The northernmost highlighted neighborhood is Wallingford, and the southernmost
highlighted neighborhood is Chinatown.",
      size = "Units Demolished"
    ) + theme_map() +
    blank()

  # Create inset map 
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
    draw_plot(inset_map, x = 0.52, y = 0.4, width = 0.3, height = 0.35)
  
  # Plot map
  plot(map)
}