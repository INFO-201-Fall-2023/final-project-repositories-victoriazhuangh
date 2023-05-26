units_2013_main <- ggplot() +
  geom_sf(data = seattle_sf) +
  geom_sf(data = rel_bg_sf, fill = "white") +
  geom_sf(data = sf_2013, aes(fill = bg_net_units)) +
  xlim(c(122.35, 122.30)) +
  ylim(c(47.58, 47.68)) +
  scale_fill_continuous(trans = "reverse") +
  labs(
    title = "Net Units Built in Chinatown and Wallingford in 2013",
    fill = "Number of Units",
  ) +
  coord_sf(crs = 4326) + 
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
  theme_bw()

units_2013_inset <- ggplot() + 
  geom_sf(data = seattle_sf) +
  geom_sf(data = rel_bg_sf, fill = "blue") +
  coord_sf(crs = 4326) + 
  annotation_scale(
    width_hint = 0.4,
    unit_category = "metric",
    style = "bar",
    location = "bl"
  ) +
  theme_bw()

units_2013_inset <- units_2013_inset + blank()

units_2013_map <- ggdraw() +
  draw_plot(units_2013_main) +
  draw_plot(units_2013_inset, x = 0.6, y = 0.6, width = 0.3, height = 0.35)

units_2013_map <- units_2013_map + north(sf_2013)

plot(units_2013_map)


# Trying proportional symbols map

# Create centroids
symbol_pos <- st_centroid(sf_2013, of_largest_polygon = TRUE)

help <- ggplot() + geom_sf(data = seattle_sf, fill = "white") +
  geom_sf(data = rel_bg_sf, fill = "grey60") +
  geom_sf(data = symbol_pos, 
          pch = 21,
          aes(size = bg_net_units),
          fill = alpha("red", 0.7),
          col = "grey20") +
  xlim(c(122.35, 122.30)) +
  ylim(c(47.58, 47.68))