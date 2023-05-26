source("map_built_units.R")

cent <- st_centroid(sf_2019, of_largest_polygon = TRUE)

# Create main map
main_map <- ggplot() + 
  geom_sf(data = seattle_sf, fill = "white") +
  geom_sf(data = rel_bg_sf, fill = "grey60") +
  geom_sf(data = cent, 
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
    title = "Net Units Demolished in Chinatown and Wallingford in 2019",
    size = "Units Demolished"
  ) + theme_void()

main_map_int <- ggplotly(main_map)

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
  blank()

# Create full map 
map <- ggdraw() +
  draw_plot(main_map_int) +
  draw_plot(inset_map, x = 0.6, y = 0.6, width = 0.3, height = 0.35)

# Plot map
plot(map)