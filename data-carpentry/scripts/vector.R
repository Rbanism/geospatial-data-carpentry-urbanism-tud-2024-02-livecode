library(tidyverse)
library(sf)

boundary_Delft <- st_read("data/delft-boundary.shp", quiet = TRUE)

st_geometry_type(boundary_Delft)
st_crs(boundary_Delft)
st_bbox(boundary_Delft)


boundary_Delft <- st_transform(boundary_Delft, 28992)

st_crs(boundary_Delft)
st_crs(boundary_Delft)$Name
st_crs(boundary_Delft)$epsg

st_bbox(boundary_Delft)

st_crs(boundary_Delft)$units_gdal

boundary_Delft


ggplot(data = boundary_Delft) +
  geom_sf(size = 3, color = "black", fill = "cyan1") +
  labs(title = "Delft Administrative Boundary") +
  coord_sf(datum = st_crs(28992))

ggplot(data = boundary_Delft) +
  geom_sf(line = 30, color = "black", fill = "cyan1") +
  labs(title = "Delft Administrative Boundary") +
  coord_sf(datum = st_crs(28992))

library(here)


lines_Delft <- st_read(here("data", "delft-streets.shp"))
point_Delft <- st_read(here("data", "delft-leisure.shp"))

st_geometry_type(lines_Delft)
st_geometry_type(point_Delft)

st_crs(lines_Delft)
st_crs(point_Delft)

st_bbox(lines_Delft)
st_bbox(point_Delft)

lines_Delft
point_Delft

# Examine attributes

lines_Delft

ncol(lines_Delft)

names(lines_Delft)

head(lines_Delft)

lines_Delft$highway

head(lines_Delft$highway, 10)

unique(lines_Delft$highway)

levels(factor(lines_Delft$highway))

## Challenge 2
ncol(point_Delft)
ncol(boundary_Delft)

head(point_Delft)
head(point_Delft, 10)

point_Delft

names(point_Delft)



# Subsetting features

cycleway_Delft <- lines_Delft %>%
  filter(highway == "cycleway")

nrow(lines_Delft)
nrow(cycleway_Delft)

cycleway_Delft <- cycleway_Delft %>%
  mutate(length = st_length(.))

cycleway_Delft %>%
  summarise(total_length = sum(length))

ggplot(data = cycleway_Delft) +
  geom_sf() +
  labs(title = "Slow mobility network in Delft",
       subtitle = "Cycleways") +
  coord_sf(datum = st_crs(28992))

# Customize plots

unique(lines_Delft$highway)

road_types <- c("motorway", "primary", "secondary", "cycleway")

lines_Delft_selection <- lines_Delft %>%
  filter(highway %in% road_types) %>%
  mutate(highway = factor(highway, levels = road_types))

road_colors <- c("blue", "green", "navy", "purple")

ggplot(data = lines_Delft_selection) +
  geom_sf(aes(color = highway)) +
  scale_color_manual(values = road_colors) +
  coord_sf(datum = st_crs(28992))

# Combine multiple layers

ggplot() +
  geom_sf(data = boundary_Delft,
          fill = "lightgrey",
          color = "lightgrey") +
  geom_sf(data = lines_Delft_selection,
          aes(color = highway)) +
  geom_sf(data = point_Delft,
          aes(fill = leisure)) +
  
  



